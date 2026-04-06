// ゲームロジック — 定食屋「灯」に通うADV
//
// ブルアカ参考リライト:
// - メインストーリーはプレイヤーレベルでゲート（親密度ではない）
// - 親密度は上限なし、ボンドストーリー・カード解放用
// - カード育成は★ランク+レベルの2軸
// - パッシブ収入で通い続けることが報われる
//
// ファイル構成:
//   logic.mbt         — ストーリー進行・ゲーム開始・ヘルパー
//   logic_actions.mbt  — カードプレイ・思い出獲得
//   logic_daily.mbt    — デイリーサイクル・ミッション・アルバム

// =========================================================================
// ストーリー進行（プレイヤーレベルでゲート）
// =========================================================================

/// ストーリーを1行進める
pub fn advance_story(state : GameState) -> Unit {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return
  }
  let chapter = chapters[ch_idx]
  let scene = chapter.scenes[state.scene_index.get()]
  let next_line = state.line_index.get() + 1
  if next_line < scene.lines.length() {
    state.line_index.set(next_line)
  } else {
    let next_scene_id = scene.next_scene
    if next_scene_id == "" {
      finish_chapter(state)
    } else {
      let mut found = -1
      for i, s in chapter.scenes {
        if s.id == next_scene_id {
          found = i
          break
        }
      }
      if found >= 0 {
        state.scene_index.set(found)
        state.line_index.set(0)
      } else {
        finish_chapter(state)
      }
    }
  }
}

/// 章のストーリー終了時の処理
///
/// 設計変更: 次章の解放条件を intimacy → player_level に変更。
/// プレイヤーレベルは行動すれば必ず上がるため、ストーリー進行が保証される。
fn finish_chapter(state : GameState) -> Unit {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()

  if current + 1 >= chapters.length() {
    state.story_complete.set(true)
    state.phase.set(@data.GamePhase::Home)
    add_message(state, "物語が完結しました。灯にはこれからも通えます。")
    return
  }

  // 章クリア報酬
  grant_chapter_reward(state, current)

  // 次の章がプレイヤーレベルで即座に解放可能かチェック
  let next = chapters[current + 1]
  let player_level = state.player_level.get()
  if player_level >= next.unlock_player_level {
    state.current_chapter.set(current + 1)
    state.scene_index.set(0)
    state.line_index.set(0)
    add_message(
      state,
      next.title + " 「" + next.subtitle + "」が解放されました！",
    )
  } else {
    state.phase.set(@data.GamePhase::Home)
    state.line_index.set(0)
    state.scene_index.set(0)
  }
}

/// 現在のストーリー行を取得
pub fn get_current_line(state : GameState) -> @data.StoryLine? {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return None
  }
  let chapter = chapters[ch_idx]
  let sc_idx = state.scene_index.get()
  if sc_idx >= chapter.scenes.length() {
    return None
  }
  let scene = chapter.scenes[sc_idx]
  let ln_idx = state.line_index.get()
  if ln_idx >= scene.lines.length() {
    return None
  }
  Some(scene.lines[ln_idx])
}

/// 現在の章情報を取得
pub fn get_current_chapter(state : GameState) -> @data.Chapter? {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return None
  }
  Some(chapters[ch_idx])
}

// =========================================================================
// タイトル・ゲーム開始
// =========================================================================

/// タイトル画面から「はじめる」
pub fn start_game(state : GameState) -> Unit {
  state.current_chapter.set(0)
  state.scene_index.set(0)
  state.line_index.set(0)
  register_initial_cards(state)
  draw_daily_hand(state)
  snapshot_day_start(state)
  state.phase.set(@data.GamePhase::Story)
}

/// 今日の手札をドロー（毎朝呼ばれる）
///
/// 所持カード + 季節/天候条件 を満たすカードからドロー。
fn draw_daily_hand(state : GameState) -> Unit {
  let day = state.day.get()
  let season = @data.get_season(day)
  let weather = @data.get_weather(day)
  let owned = state.owned_cards.get()
  let all_cards = @data.get_all_cards()

  let owned_ids : Array[String] = []
  for oc in owned {
    owned_ids.push(oc.card_id)
  }

  let pool : Array[@data.ActionCard] = []
  for card in all_cards {
    let mut is_owned = false
    for oid in owned_ids {
      if oid == card.id {
        is_owned = true
        break
      }
    }

    match card.unlock_condition {
      SeasonOnly(s) => {
        if is_owned && s == season {
          pool.push(card)
        }
        continue
      }
      WeatherOnly(w) => {
        if is_owned && w == weather {
          pool.push(card)
        }
        continue
      }
      _ => ()
    }

    if is_owned {
      pool.push(card)
    }
  }

  let hand = draw_hand(pool, day)
  state.hand.set(hand)
}

// =========================================================================
// Home → ActionSelect → Scene → ActionSelect → Home
// =========================================================================

pub fn go_to_akari(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::ActionSelect)
}

pub fn leave_akari(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}

// =========================================================================
// ヘルパー
// =========================================================================

pub fn get_current_season(state : GameState) -> @data.Season {
  @data.get_season(state.day.get())
}

pub fn get_current_weather(state : GameState) -> @data.Weather {
  @data.get_weather(state.day.get())
}

pub fn get_param_display(state : GameState) -> String {
  let trust = state.trust.get()
  let understanding = state.understanding.get()
  let empathy = state.empathy.get()
  "信頼:" + trust.to_string() + " 理解:" + understanding.to_string() + " 共感:" + empathy.to_string()
}

/// 3軸の合計値を intimacy に同期する
pub fn sync_intimacy(state : GameState) -> Unit {
  let total = state.trust.get() + state.understanding.get() + state.empathy.get()
  state.intimacy.set(total)
}

/// 親密度レベル表示（上限なし）
///
/// 旧★表示を廃止し、レベル数値表示に変更。
pub fn get_affection_display(state : GameState) -> String {
  let level = get_affection_level(state.intimacy.get())
  let next_points = affection_points_for_level(level + 1)
  let current = state.intimacy.get()
  "親密度Lv" + level.to_string() + " (" + current.to_string() + "/" + next_points.to_string() + ")"
}

// =========================================================================
// ユーティリティ
// =========================================================================

pub fn add_message(state : GameState, msg : String) -> Unit {
  state.message_log.update(fn(log) {
    let result : Array[String] = []
    for m in log {
      result.push(m)
    }
    result.push(msg)
    if result.length() > 20 {
      let trimmed : Array[String] = []
      for i in (result.length() - 20)..<result.length() {
        trimmed.push(result[i])
      }
      trimmed
    } else {
      result
    }
  })
}
