// ゲームロジック — 定食屋「灯」に通うADV
//
// AP行動選択制:
//   Title → Story(ch0) → Home → ActionSelect → Scene → ActionSelect → Home
// 毎日の手札からカードを選び、3軸パラメータを育ててストーリーを解放する。
//
// 学マス参考のソーシャルゲームシステム:
// - 行動カードの手札ドローとプレイ
// - 3軸パラメータ（信頼/理解/共感）の成長
// - 季節の節目イベント（S/A/B/C ランク判定）
// - 思い出の自動獲得チェック

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
/// 初日の手札もここでドローする。
pub fn start_game(state : GameState) -> Unit {
  state.current_chapter.set(0)
  state.scene_index.set(0)
  state.line_index.set(0)
  // 初日の手札をドロー
  draw_daily_hand(state)
  state.phase.set(@data.GamePhase::Story)
}

/// 今日の手札をドロー（毎朝呼ばれる）
///
/// 現在の進行状況・季節・天候に応じて有効カードプールを構築し、
/// そこから hand_size 枚をドローする。
fn draw_daily_hand(state : GameState) -> Unit {
  let day = state.day.get()
  let stars = get_intimacy_stars(state.intimacy.get())
  let chapter = state.current_chapter.get()
  let season = @data.get_season(day)
  let weather = @data.get_weather(day)

  // 獲得済み思い出IDリスト
  let memory_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    memory_ids.push(record.memory_id)
  }

  let pool = build_available_pool(
    stars, chapter, season, weather, memory_ids,
  )
  let hand = draw_hand(pool, day)
  state.hand.set(hand)
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
// 行動処理（ゲームのコア — カードシステム一本）
// =========================================================================

/// カードカテゴリを行動文字列に変換（VisitRecord/ミッション判定用）
fn card_category_to_action_string(category : @data.CardCategory) -> String {
  match category {
    Eat => "eat"
    Observe => "observe"
    Talk => "talk"
    Special | Weather | Seasonal => "special"
  }
}

/// 手札のカードをプレイできるか判定
pub fn can_play_card(state : GameState, card : @data.ActionCard) -> Bool {
  state.ap.get() >= card.ap_cost
}

/// 行動カードをプレイする（新システムのメイン行動処理）
///
/// 1. AP消費
/// 2. 3軸パラメータ加算（カード値 + 装備メモリーボーナス）
/// 3. 親密度（合計値）更新
/// 4. 行動テキスト設定 → Scene フェーズへ
/// 5. 訪問記録・コレクションに追加
/// 6. 行動カウンタ更新
/// 7. ミッション判定
/// 8. 思い出獲得チェック
/// 9. 手札からカードを除去
pub fn play_card(state : GameState, card_id : String) -> Unit {
  // 手札からカードを探す
  let hand = state.hand.get()
  let mut target_card : @data.ActionCard? = None
  for c in hand {
    if c.id == card_id {
      target_card = Some(c)
      break
    }
  }

  let card = match target_card {
    Some(c) => c
    None => return  // 手札にないカードは無視
  }

  if !can_play_card(state, card) {
    return
  }

  let day = state.day.get()
  let action_str = card_category_to_action_string(card.category)

  // 1. AP消費
  state.ap.update(fn(ap) { ap - card.ap_cost })

  // 2. 装備メモリーのパッシブボーナスを取得
  let memory_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    memory_ids.push(record.memory_id)
  }
  let (mem_trust, mem_understanding, mem_empathy) = calculate_memory_bonus(
    state.memory_slots.get(), memory_ids,
  )

  // 3. 3軸パラメータ加算
  let (trust_gain, understanding_gain, empathy_gain) = calculate_card_gains(
    card, mem_trust, mem_understanding, mem_empathy,
  )
  state.trust.update(fn(v) { v + trust_gain })
  state.understanding.update(fn(v) { v + understanding_gain })
  state.empathy.update(fn(v) { v + empathy_gain })

  // 親密度（合計値）を同期
  sync_intimacy(state)

  // 4. 行動テキスト生成 → Scene へ
  let scene_text = @data.get_action_text(action_str, state.intimacy.get(), day)
  state.today_scene_text.set(scene_text)

  let menu = @data.get_today_menu(day)
  state.today_menu.set(menu.name)

  // 5. 行動履歴に追加
  state.today_actions.update(fn(actions) {
    let result : Array[String] = []
    for a in actions {
      result.push(a)
    }
    result.push(action_str)
    result
  })

  // 訪問記録に追加（Eat系の場合のみ味の記憶に記録）
  if card.category == @data.CardCategory::Eat {
    state.visit_log.update(fn(log) {
      let result : Array[@data.VisitRecord] = []
      for r in log {
        result.push(r)
      }
      result.push({ day, menu_id: menu.id, scene_text, action_type: action_str })
      result
    })
  }

  // コレクション追加（Observe系 → 発見ノート、Talk系 → 会話メモ）
  if card.category == @data.CardCategory::Observe {
    let discovery = @data.get_discovery_text(state.intimacy.get(), day)
    state.discoveries.update(fn(arr) {
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
  if card.category == @data.CardCategory::Talk {
    let memo = @data.get_talk_text(state.intimacy.get(), day)
    state.talk_memos.update(fn(arr) {
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

  // 6. 行動カウンタ更新
  match card.category {
    Eat => state.total_eat_count.update(fn(n) { n + 1 })
    Observe => state.total_observe_count.update(fn(n) { n + 1 })
    Talk => state.total_talk_count.update(fn(n) { n + 1 })
    _ => ()  // Special/Weather/Seasonal はカテゴリ別カウンタなし
  }

  // 7. ミッション判定
  check_missions(state)

  // 8. 思い出獲得チェック
  check_and_acquire_memories(state, card.id, None)

  // 9. 手札からカードを除去
  state.hand.update(fn(h) {
    let result : Array[@data.ActionCard] = []
    for c in h {
      if c.id != card_id {
        result.push(c)
      }
    }
    result
  })

  // パラメータ上昇メッセージ
  let msg = card.name + " — 信頼+" + trust_gain.to_string() + " 理解+" + understanding_gain.to_string() + " 共感+" + empathy_gain.to_string()
  add_message(state, msg)

  // Scene フェーズへ
  state.phase.set(@data.GamePhase::Scene)
}

/// 思い出獲得チェックを実行し、新規獲得をメッセージに表示
fn check_and_acquire_memories(
  state : GameState,
  played_card_id : String,
  season_rank : @data.MilestoneRank?
) -> Unit {
  let day = state.day.get()
  let acquired_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    acquired_ids.push(record.memory_id)
  }

  // 訪問済みメニューIDリスト
  let visited_menu_ids : Array[String] = []
  for record in state.visit_log.get() {
    let mut already = false
    for id in visited_menu_ids {
      if id == record.menu_id {
        already = true
        break
      }
    }
    if !already {
      visited_menu_ids.push(record.menu_id)
    }
  }

  let newly = check_memory_conditions(
    state.total_eat_count.get(),
    state.total_talk_count.get(),
    state.total_observe_count.get(),
    get_intimacy_stars(state.intimacy.get()),
    state.discoveries.get().length(),
    visited_menu_ids,
    @data.get_weather(day),
    acquired_ids,
    played_card_id,
    season_rank,
    @data.get_season(day),
  )

  if newly.length() > 0 {
    let season = @data.get_season(day)
    state.acquired_memories.update(fn(records) {
      let result : Array[@data.MemoryRecord] = []
      for r in records {
        result.push(r)
      }
      for id in newly {
        result.push({ memory_id: id, acquired_day: day, acquired_season: season })
      }
      result
    })

    // 獲得メッセージ
    for id in newly {
      match get_memory_by_id(id) {
        Some(memory) =>
          add_message(state, "思い出を獲得: 「" + memory.title + "」")
        None => ()
      }
    }
  }
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
/// 1. 季節の節目チェック（昨日が節目日なら結果を記録）
/// 2. day をインクリメント
/// 3. AP回復、行動履歴クリア、ミッションリセット
/// 4. 新しい手札をドロー
pub fn next_day(state : GameState) -> Unit {
  let current_day = state.day.get()

  // 1. 季節の節目チェック（今日=節目日なら、結果を記録してから翌日へ）
  if @data.is_season_milestone(current_day) {
    let season = @data.get_season(current_day)
    let year = @data.get_year(current_day)
    let trust = state.trust.get()
    let understanding = state.understanding.get()
    let empathy = state.empathy.get()
    let rank = @data.evaluate_milestone_rank(trust, understanding, empathy)

    // 節目結果を記録
    state.season_results.update(fn(results) {
      let new_results : Array[@data.SeasonResult] = []
      for r in results {
        new_results.push(r)
      }
      new_results.push({
        season, year, rank,
        trust_at_eval: trust,
        understanding_at_eval: understanding,
        empathy_at_eval: empathy,
      })
      new_results
    })

    // 節目テキストを表示
    let milestone_text = @data.get_milestone_text(season, rank)
    state.today_scene_text.set(milestone_text)

    let season_name = @data.season_to_string(season)
    let rank_name = @data.rank_to_string(rank)
    add_message(
      state,
      season_name + "の節目 — " + rank_name + "ランク！",
    )

    // 節目で思い出獲得チェック
    check_and_acquire_memories(state, "", Some(rank))
  }

  // 2. 翌日へ
  state.day.update(fn(d) { d + 1 })
  state.ap.set(max_ap)
  state.today_actions.set([])
  state.daily_missions.set(create_daily_missions())

  // 3. 新しい手札をドロー
  draw_daily_hand(state)

  // 季節・天候情報をメッセージに
  let new_day = state.day.get()
  let new_season = @data.get_season(new_day)
  let new_weather = @data.get_weather(new_day)
  let day_in_season = @data.get_day_in_season(new_day)
  let day_msg = @data.season_to_string(new_season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(new_weather) + @data.weather_to_string(new_weather)
  add_message(state, day_msg)

  state.phase.set(@data.GamePhase::Home)
}

// =========================================================================
// 思い出装備
// =========================================================================

/// 思い出をスロットに装備する
///
/// slot: 0=信頼, 1=理解, 2=共感
pub fn equip_memory(state : GameState, slot : Int, memory_id : String) -> Unit {
  // 獲得済みか確認
  let acquired = state.acquired_memories.get()
  let mut is_owned = false
  for record in acquired {
    if record.memory_id == memory_id {
      is_owned = true
      break
    }
  }
  if !is_owned && memory_id != "" {
    return
  }

  state.memory_slots.update(fn(slots) {
    match slot {
      0 => { ..slots, trust_slot: memory_id }
      1 => { ..slots, understanding_slot: memory_id }
      _ => { ..slots, empathy_slot: memory_id }
    }
  })

  if memory_id != "" {
    match get_memory_by_id(memory_id) {
      Some(memory) =>
        add_message(state, "思い出「" + memory.title + "」を装備しました")
      None => ()
    }
  }
}

// =========================================================================
// 季節・天候ヘルパー（UI用）
// =========================================================================

/// 現在の季節を取得
pub fn get_current_season(state : GameState) -> @data.Season {
  @data.get_season(state.day.get())
}

/// 現在の天候を取得
pub fn get_current_weather(state : GameState) -> @data.Weather {
  @data.get_weather(state.day.get())
}

/// 3軸パラメータの表示用テキストを生成
pub fn get_param_display(state : GameState) -> String {
  let trust = state.trust.get()
  let understanding = state.understanding.get()
  let empathy = state.empathy.get()
  "信頼:" + trust.to_string() + " 理解:" + understanding.to_string() + " 共感:" + empathy.to_string()
}

// =========================================================================
// デイリーミッション
// =========================================================================

/// ミッション報酬を3軸に分配して付与
///
/// ミッションの行動カテゴリに応じて主軸を決定:
/// eat → 共感メイン、talk → 信頼メイン、actions_3 → 均等分配
fn grant_mission_reward(state : GameState, mission_id : String, reward : Int) -> Unit {
  match mission_id {
    "eat" => {
      // 食事ミッション → 共感メイン (6:2:2)
      state.empathy.update(fn(v) { v + reward * 6 / 10 })
      state.understanding.update(fn(v) { v + reward * 2 / 10 })
      state.trust.update(fn(v) { v + reward * 2 / 10 })
    }
    "talk" => {
      // 会話ミッション → 信頼メイン (6:2:2)
      state.trust.update(fn(v) { v + reward * 6 / 10 })
      state.understanding.update(fn(v) { v + reward * 2 / 10 })
      state.empathy.update(fn(v) { v + reward * 2 / 10 })
    }
    _ => {
      // 汎用ミッション → 均等分配
      state.trust.update(fn(v) { v + reward / 3 })
      state.understanding.update(fn(v) { v + reward / 3 })
      state.empathy.update(fn(v) { v + reward / 3 })
    }
  }
  // intimacy を同期
  sync_intimacy(state)
}

/// 3軸の合計値を intimacy に同期する
///
/// trust + understanding + empathy = intimacy
/// 3軸を変更した後は必ずこれを呼ぶ。
pub fn sync_intimacy(state : GameState) -> Unit {
  let total = state.trust.get() + state.understanding.get() + state.empathy.get()
  state.intimacy.set(total)
}

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

  state.daily_missions.update(fn(missions) {
    let result : Array[@data.DailyMission] = []
    for m in missions {
      if m.completed {
        result.push(m)
      } else if m.id == "eat" && had_eat {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "talk" && had_talk {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "actions_3" && action_count >= 3 {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
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
