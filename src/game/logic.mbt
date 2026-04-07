// ゲームロジック — 2層アーキテクチャ
//
// ストーリー進行 / ゲーム開始 / ヘルパー関数。
// Layer 1 の行動処理は logic_actions.mbt、
// デイリーサイクルは logic_daily.mbt に分離。

// =========================================================================
// ストーリー進行（灯訪問回数でゲート）
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

  // 次の章が即座に解放可能かチェック（灯訪問回数条件）
  let next = chapters[current + 1]
  let visits = state.total_visits.get()
  if visits >= next.unlock_visit_count {
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
  // 初期デッキ登録
  register_initial_deck(state)
  // 手札ドロー
  draw_daily_hand(state)
  snapshot_day_start(state)
  snapshot_week_start(state)
  state.phase.set(@data.GamePhase::Story)
}

/// 初期デッキを登録（初期カード8枚）
fn register_initial_deck(state : GameState) -> Unit {
  let initial = @data.get_initial_cards()
  let ids : Array[String] = []
  for card in initial {
    ids.push(card.id)
  }
  state.deck.set({ card_ids: ids, max_size: 15 })
}

// =========================================================================
// Home → Layer1 / Layer2 遷移
// =========================================================================

/// 日常行動パートへ（Layer 1）
pub fn go_to_daily_action(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::DailyAction)
}

/// 灯に行く（Layer 2 — 灯ポイント消費）
pub fn go_to_visit(state : GameState) -> Unit {
  let points = state.akari_points.get()
  if points < visit_cost {
    add_message(state, "灯ポイントが足りません（" + points.to_string() + "/" + visit_cost.to_string() + "）")
    return
  }
  state.akari_points.update(fn(p) { p - visit_cost })
  state.total_visits.update(fn(v) { v + 1 })
  state.visit_phase.set(@data.VisitPhase::Entering)
  state.phase.set(@data.GamePhase::Visit)

  // 訪問回数でカード解放チェック
  check_card_unlocks(state)
  // チャプター解放チェック
  check_chapter_unlocks(state)

  add_message(state, "灯に来た。（来店" + state.total_visits.get().to_string() + "回目）")
}

/// 訪問回数でのカード解放チェック
fn check_card_unlocks(state : GameState) -> Unit {
  let visits = state.total_visits.get()
  let deck = state.deck.get()
  let unlockable = @data.get_unlockable_cards()

  for card in unlockable {
    let needed = @data.get_card_unlock_visits(card.id)
    if visits >= needed {
      let mut already = false
      for id in deck.card_ids {
        if id == card.id {
          already = true
          break
        }
      }
      if !already {
        state.deck.update(fn(d) {
          let new_ids : Array[String] = []
          for id in d.card_ids {
            new_ids.push(id)
          }
          new_ids.push(card.id)
          { ..d, card_ids: new_ids }
        })
        add_message(state, "新しい行動カード「" + card.name + "」を獲得！")
      }
    }
  }
}

/// チャプター解放チェック
fn check_chapter_unlocks(state : GameState) -> Unit {
  let visits = state.total_visits.get()
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()
  if current + 1 < chapters.length() {
    let next = chapters[current + 1]
    if visits >= next.unlock_visit_count {
      add_message(state, next.title + "が解放されました！")
    }
  }
}

/// 灯から帰る
pub fn leave_visit(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}

/// 日常行動画面からホームに戻る
pub fn leave_daily_action(state : GameState) -> Unit {
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

/// 親密度レベル算出（上限なし、累進的）
///
/// Lv1: 0-29, Lv2: 30-69, Lv3: 70-119, ...
/// 各レベルの必要量 = 30 + (level-1) * 10
pub fn get_affection_level(points : Int) -> Int {
  let mut level = 1
  let mut accumulated = 0
  for i = 0; i < 100; i = i + 1 {
    let needed = 30 + level * 10
    if accumulated + needed > points {
      break
    }
    accumulated = accumulated + needed
    level = level + 1
  }
  level
}

/// 特定レベル到達に必要な累計ポイント
pub fn affection_points_for_level(level : Int) -> Int {
  let mut total = 0
  for l = 1; l < level; l = l + 1 {
    total = total + 30 + l * 10
  }
  total
}

/// 親密度レベル表示
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
