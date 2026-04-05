// ゲームロジック — 定食屋「灯」に通うADV
//
// AP行動選択制:
//   Title → Story(ch0) → Home → ActionSelect → Scene → ActionSelect → Home
// 毎日5APの中で「食べる/観察する/話す」を選び、親密度を貯めてストーリーを解放する。

// =========================================================================
// ストーリー進行（既存ロジックを維持）
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
    // シーン完了 — 次のシーンへ or 章終了
    let next_scene_id = scene.next_scene
    if next_scene_id == "" {
      // 章のストーリー完了 — Home フェーズへ
      finish_chapter(state)
    } else {
      // 次のシーンを探す
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
/// 次の章がすぐ解放可能なら連続でストーリーに入る（ch0→ch1 など）。
/// そうでなければ Home フェーズへ。
fn finish_chapter(state : GameState) -> Unit {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()

  // 最終章なら完了
  if current + 1 >= chapters.length() {
    state.story_complete.set(true)
    state.phase.set(@data.GamePhase::Home)
    add_message(state, "物語が完結しました。灯にはこれからも通えます。")
    return
  }

  // 次の章が即座に解放可能かチェック
  let next = chapters[current + 1]
  let intimacy = state.intimacy.get()
  if intimacy >= next.unlock_intimacy {
    // 連続ストーリー解放（ch0→ch1 など）
    state.current_chapter.set(current + 1)
    state.scene_index.set(0)
    state.line_index.set(0)
    add_message(
      state,
      next.title + " 「" + next.subtitle + "」が解放されました！",
    )
    // phase は Story のまま
  } else {
    // Home フェーズへ
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

/// タイトル画面から「はじめる」— ch0 ストーリーへ遷移
///
/// ch0 は unlock_intimacy: 0 なので即座に再生可能。
pub fn start_game(state : GameState) -> Unit {
  state.current_chapter.set(0)
  state.scene_index.set(0)
  state.line_index.set(0)
  state.phase.set(@data.GamePhase::Story)
}

// =========================================================================
// Home → ActionSelect → Scene → ActionSelect → Home
// =========================================================================

/// Home から灯に行く — ActionSelect フェーズへ遷移
pub fn go_to_akari(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::ActionSelect)
}

/// ActionSelect から帰る — Home フェーズへ遷移
pub fn leave_akari(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}

// =========================================================================
// 行動処理（ゲームのコア）
// =========================================================================

/// 行動の AP コストを返す
pub fn get_action_cost(action : @data.ActionType) -> Int {
  match action {
    Eat => 2
    Observe => 1
    Talk => 1
    Special => 2
  }
}

/// 行動の親密度ボーナスを計算（日数ハッシュで変動あり）
fn get_action_intimacy(action : @data.ActionType, day : Int) -> Int {
  match action {
    Eat => 10 + (day % 6)       // 10-15
    Observe => 3 + (day % 3)    // 3-5
    Talk => 5 + (day % 4)       // 5-8
    Special => 15 + (day % 11)  // 15-25
  }
}

/// 行動タイプを文字列に変換（VisitRecord 保存用）
fn action_type_to_string(action : @data.ActionType) -> String {
  match action {
    Eat => "eat"
    Observe => "observe"
    Talk => "talk"
    Special => "special"
  }
}

/// その行動を実行可能か判定
///
/// AP が足りるか、Special の場合は ★3（親密度300）以上かをチェック。
pub fn can_perform_action(state : GameState, action : @data.ActionType) -> Bool {
  let cost = get_action_cost(action)
  if state.ap.get() < cost {
    return false
  }
  match action {
    Special => get_intimacy_stars(state.intimacy.get()) >= 3
    _ => true
  }
}

/// 行動を実行する
///
/// 1. AP消費
/// 2. 親密度加算
/// 3. 行動テキスト設定 → Scene フェーズへ
/// 4. 訪問記録・コレクションに追加
/// 5. ミッション判定
pub fn perform_action(state : GameState, action : @data.ActionType) -> Unit {
  if !can_perform_action(state, action) {
    return
  }

  let day = state.day.get()
  let cost = get_action_cost(action)
  let intimacy_gain = get_action_intimacy(action, day)
  let action_str = action_type_to_string(action)

  // 1. AP消費
  state.ap.update(fn(ap) { ap - cost })

  // 2. 親密度加算
  state.intimacy.update(fn(i) { i + intimacy_gain })

  // 3. 行動テキスト生成 → Scene へ
  let scene_text = @data.get_action_text(action_str, state.intimacy.get(), day)
  state.today_scene_text.set(scene_text)

  let menu = @data.get_today_menu(day)
  state.today_menu.set(menu.name)

  // 4. 行動履歴に追加
  state.today_actions.update(fn(actions) {
    let result : Array[String] = []
    for a in actions {
      result.push(a)
    }
    result.push(action_str)
    result
  })

  // 訪問記録に追加（Eat の場合のみ味の記憶に記録）
  if action == @data.ActionType::Eat {
    state.visit_log.update(fn(log) {
      let result : Array[@data.VisitRecord] = []
      for r in log {
        result.push(r)
      }
      result.push({ day, menu_id: menu.id, scene_text, action_type: action_str })
      result
    })
  }

  // コレクション追加（Observe → 発見ノート、Talk → 会話メモ）
  if action == @data.ActionType::Observe {
    let discovery = @data.get_discovery_text(state.intimacy.get(), day)
    state.discoveries.update(fn(arr) {
      // 重複チェック
      for d in arr {
        if d == discovery {
          return arr
        }
      }
      let result : Array[String] = []
      for d in arr {
        result.push(d)
      }
      result.push(discovery)
      result
    })
  }
  if action == @data.ActionType::Talk {
    let memo = @data.get_talk_text(state.intimacy.get(), day)
    state.talk_memos.update(fn(arr) {
      // 重複チェック
      for m in arr {
        if m == memo {
          return arr
        }
      }
      let result : Array[String] = []
      for m in arr {
        result.push(m)
      }
      result.push(memo)
      result
    })
  }

  // 5. ミッション判定
  check_missions(state)

  // Scene フェーズへ
  state.phase.set(@data.GamePhase::Scene)
}

// =========================================================================
// シーン終了 → ActionSelect に戻る or ストーリー解放
// =========================================================================

/// ひとくちシーン終了 — ストーリー解放チェック
///
/// 親密度が次章の閾値に達していればストーリーへ、
/// そうでなければ ActionSelect に戻る（APが残っていれば追加行動可能）。
pub fn finish_scene(state : GameState) -> Unit {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()

  // 最終章クリア済み
  if current + 1 >= chapters.length() {
    // ActionSelect に戻る（APがあればまだ行動できる）
    state.phase.set(@data.GamePhase::ActionSelect)
    return
  }

  let next = chapters[current + 1]
  let intimacy = state.intimacy.get()

  if intimacy >= next.unlock_intimacy {
    // ストーリー解放
    state.current_chapter.set(current + 1)
    state.scene_index.set(0)
    state.line_index.set(0)
    state.phase.set(@data.GamePhase::Story)
    add_message(
      state,
      next.title + " 「" + next.subtitle + "」が解放されました！",
    )
  } else {
    // ActionSelect に戻る
    state.phase.set(@data.GamePhase::ActionSelect)
  }
}

// =========================================================================
// 次の日 — デイリーリセット
// =========================================================================

/// 次の日へ進む
///
/// day をインクリメントし、AP回復、行動履歴クリア、ミッションリセット。
pub fn next_day(state : GameState) -> Unit {
  state.day.update(fn(d) { d + 1 })
  state.ap.set(max_ap)
  state.today_actions.set([])
  state.daily_missions.set(create_daily_missions())
  state.phase.set(@data.GamePhase::Home)
}

// =========================================================================
// デイリーミッション
// =========================================================================

/// 行動後にミッション達成をチェックし、未達成→達成のものに報酬を付与
fn check_missions(state : GameState) -> Unit {
  let actions = state.today_actions.get()
  let mut had_eat = false
  let mut had_talk = false
  let action_count = actions.length()
  for a in actions {
    if a == "eat" {
      had_eat = true
    }
    if a == "talk" {
      had_talk = true
    }
  }
  // 今回の行動も含めるため action_count は既に今回分を含む

  state.daily_missions.update(fn(missions) {
    let result : Array[@data.DailyMission] = []
    for m in missions {
      if m.completed {
        result.push(m)
      } else if m.id == "eat" && had_eat {
        result.push({ ..m, completed: true })
        // 報酬付与
        state.intimacy.update(fn(i) { i + m.reward })
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "talk" && had_talk {
        result.push({ ..m, completed: true })
        state.intimacy.update(fn(i) { i + m.reward })
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "actions_3" && action_count >= 3 {
        result.push({ ..m, completed: true })
        state.intimacy.update(fn(i) { i + m.reward })
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else {
        result.push(m)
      }
    }
    result
  })
}

// =========================================================================
// アルバム
// =========================================================================

/// アルバムを開く
pub fn open_album(state : GameState) -> Unit {
  state.album_tab.set(0)
  state.phase.set(@data.GamePhase::Album)
}

/// アルバムを閉じる（Home に戻る）
pub fn close_album(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}

// =========================================================================
// ユーティリティ
// =========================================================================

/// メッセージログに追加（最大20件を保持）
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

/// 親密度のスターランクを取得
pub fn get_intimacy_stars(points : Int) -> Int {
  let ranks = @data.get_intimacy_ranks()
  let mut stars = 1
  for rank in ranks {
    if points >= rank.min_points {
      stars = rank.stars
    }
  }
  stars
}

/// ★表示用の文字列を生成（例: "★★☆☆☆"）
pub fn get_star_display(points : Int) -> String {
  let stars = get_intimacy_stars(points)
  let mut result = ""
  for i in 0..<5 {
    if i < stars {
      result = result + "★"
    } else {
      result = result + "☆"
    }
  }
  result
}
