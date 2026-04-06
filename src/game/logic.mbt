// ゲームロジック — 定食屋「灯」に通うADV
//
// ブルアカ参考リライト:
// - メインストーリーはプレイヤーレベルでゲート（親密度ではない）
// - 親密度は上限なし、ボンドストーリー・カード解放用
// - カード育成は★ランク+レベルの2軸
// - パッシブ収入で通い続けることが報われる

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
// 行動処理（カードシステム）
// =========================================================================

fn card_category_to_action_string(category : @data.CardCategory) -> String {
  match category {
    Eat => "eat"
    Observe => "observe"
    Talk => "talk"
    Special | Weather | Seasonal => "special"
  }
}

pub fn can_play_card(state : GameState, card : @data.ActionCard) -> Bool {
  state.ap.get() >= card.ap_cost
}

/// 行動カードをプレイする
///
/// ★ランク + レベルの2軸でパラメータ計算。
/// 親密度マイルストーンチェックを追加（上限なし対応）。
pub fn play_card(state : GameState, card_id : String) -> Unit {
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
    None => return
  }

  if !can_play_card(state, card) {
    return
  }

  let day = state.day.get()
  let action_str = card_category_to_action_string(card.category)

  // 1. AP消費
  state.ap.update(fn(ap) { ap - card.ap_cost })

  // 2. メモリーボーナス
  let memory_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    memory_ids.push(record.memory_id)
  }
  let (mem_trust, mem_understanding, mem_empathy) = calculate_memory_bonus(
    state.memory_slots.get(), memory_ids,
  )

  // 3. ★ランク + レベル による3軸パラメータ計算
  let card_star = get_card_star_rank(state, card.id)
  let card_level = get_card_level(state, card.id)
  let effective_star = if card_star > 0 { card_star } else { 1 }
  let effective_level = if card_level > 0 { card_level } else { 1 }

  let (trust_gain, understanding_gain, empathy_gain) = calculate_card_gains(
    card, effective_star, effective_level,
    mem_trust, mem_understanding, mem_empathy,
  )
  state.trust.update(fn(v) { v + trust_gain })
  state.understanding.update(fn(v) { v + understanding_gain })
  state.empathy.update(fn(v) { v + empathy_gain })

  // 親密度（合計値）を同期
  sync_intimacy(state)

  // 4. 親密度マイルストーンチェック（上限なし対応）
  check_affection_milestones(state)

  // 5. テキスト生成 → Scene へ
  let scene_text = @data.get_action_text(action_str, state.intimacy.get(), day)
  state.today_scene_text.set(scene_text)

  let menu = @data.get_today_menu(day)
  state.today_menu.set(menu.name)

  // 6. 行動履歴
  state.today_actions.update(fn(actions) {
    let result : Array[String] = []
    for a in actions {
      result.push(a)
    }
    result.push(action_str)
    result
  })

  // 訪問記録
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

  // コレクション
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

  // 7. 行動カウンタ更新
  match card.category {
    Eat => state.total_eat_count.update(fn(n) { n + 1 })
    Observe => state.total_observe_count.update(fn(n) { n + 1 })
    Talk => state.total_talk_count.update(fn(n) { n + 1 })
    _ => ()
  }

  // 8. ミッション判定
  check_missions(state)

  // 9. 思い出獲得チェック
  check_and_acquire_memories(state, card.id, None)

  // 10. 手札からカード除去
  state.hand.update(fn(h) {
    let result : Array[@data.ActionCard] = []
    for c in h {
      if c.id != card_id {
        result.push(c)
      }
    }
    result
  })

  // 11. 通貨・EXP報酬
  grant_action_rewards(state, card)

  // 12. 条件解放カードチェック
  check_condition_unlocks(state)

  // 13. カード結果をScene表示用に保存
  let coin_reward = get_card_coin_reward(card.rarity)
  let exp_reward = get_card_exp_reward(card.rarity)
  let gem_reward = get_card_gem_reward(card.rarity)
  let affection_level = get_affection_level(state.intimacy.get())
  let reaction = @data.get_reaction_text(action_str, affection_level)
  state.last_card_result.set({
    trust_gain, understanding_gain, empathy_gain,
    coin_reward, exp_reward, gem_reward,
    reaction_text: reaction,
  })

  // メッセージ
  let msg = card.name + " — 信頼+" + trust_gain.to_string() + " 理解+" + understanding_gain.to_string() + " 共感+" + empathy_gain.to_string() + " +" + coin_reward.to_string() + "コイン"
  add_message(state, msg)

  state.phase.set(@data.GamePhase::Scene)
}

/// 思い出獲得チェック（親密度レベル使用、上限なし）
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

  let aff_level = get_affection_level(state.intimacy.get())
  let newly = check_memory_conditions(
    state.total_eat_count.get(),
    state.total_talk_count.get(),
    state.total_observe_count.get(),
    aff_level,
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
// シーン終了 → ストーリー解放チェック（プレイヤーレベルでゲート）
// =========================================================================

/// ひとくちシーン終了
pub fn finish_scene(state : GameState) -> Unit {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()

  if current + 1 >= chapters.length() {
    state.phase.set(@data.GamePhase::ActionSelect)
    return
  }

  let next = chapters[current + 1]
  let player_level = state.player_level.get()

  if player_level >= next.unlock_player_level {
    state.current_chapter.set(current + 1)
    state.scene_index.set(0)
    state.line_index.set(0)
    state.phase.set(@data.GamePhase::Story)
    add_message(
      state,
      next.title + " 「" + next.subtitle + "」が解放されました！",
    )
  } else {
    state.phase.set(@data.GamePhase::ActionSelect)
  }
}

// =========================================================================
// 次の日 — デイリーリセット + パッシブ収入
// =========================================================================

/// 次の日へ進む（DayResult表示）
pub fn next_day(state : GameState) -> Unit {
  let result = build_day_result(state)
  state.day_result.set(result)
  state.phase.set(@data.GamePhase::DayResult)
}

/// DayResult画面から実際に翌日へ進む
///
/// 追加: パッシブ収入付与（ブルアカのカフェ相当）
pub fn advance_to_next_day(state : GameState) -> Unit {
  let current_day = state.day.get()

  // 1. 季節の節目チェック
  if @data.is_season_milestone(current_day) {
    let season = @data.get_season(current_day)
    let year = @data.get_year(current_day)
    let trust = state.trust.get()
    let understanding = state.understanding.get()
    let empathy = state.empathy.get()
    let rank = @data.evaluate_milestone_rank(trust, understanding, empathy)

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

    let milestone_text = @data.get_milestone_text(season, rank)
    state.today_scene_text.set(milestone_text)

    let season_name = @data.season_to_string(season)
    let rank_name = @data.rank_to_string(rank)
    add_message(
      state,
      season_name + "の節目 — " + rank_name + "ランク！",
    )

    check_and_acquire_memories(state, "", Some(rank))

    if rank == @data.MilestoneRank::S {
      state.gems.update(fn(g) { g + 100 })
      add_message(state, "Sランクボーナス: +100 星石")
    }
  }

  // 2. 翌日へ
  state.day.update(fn(d) { d + 1 })
  let current_max_ap = get_max_ap(state)
  state.ap.set(current_max_ap)
  state.today_actions.set([])
  state.daily_missions.set(create_daily_missions())

  // 3. パッシブ収入（ブルアカのカフェ相当）
  let passive_coins = grant_passive_income(state)
  if passive_coins > 0 {
    add_message(state, "定食屋パッシブ: +" + passive_coins.to_string() + "コイン")
  }

  // 4. 新しい手札をドロー
  draw_daily_hand(state)

  // 5. デイスタートスナップショット
  snapshot_day_start(state)

  // 季節・天候情報
  let new_day = state.day.get()
  let new_season = @data.get_season(new_day)
  let new_weather = @data.get_weather(new_day)
  let day_in_season = @data.get_day_in_season(new_day)
  let day_msg = @data.season_to_string(new_season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(new_weather) + @data.weather_to_string(new_weather)
  add_message(state, day_msg)

  // 6. ログボ → Home
  if check_login_bonus(state) {
    state.phase.set(@data.GamePhase::LoginBonus)
  } else {
    state.phase.set(@data.GamePhase::Home)
  }
}

// =========================================================================
// 思い出装備
// =========================================================================

pub fn equip_memory(state : GameState, slot : Int, memory_id : String) -> Unit {
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
// デイリーミッション
// =========================================================================

/// ミッション報酬を3軸に分配（スケーリング適用）
fn grant_mission_reward(state : GameState, mission_id : String, reward : Int) -> Unit {
  let scaled = reward * param_scale_percent / 100
  let effective = if scaled < 1 { 1 } else { scaled }
  match mission_id {
    "eat" => {
      state.empathy.update(fn(v) { v + effective * 6 / 10 })
      state.understanding.update(fn(v) { v + effective * 2 / 10 })
      state.trust.update(fn(v) { v + effective * 2 / 10 })
    }
    "talk" => {
      state.trust.update(fn(v) { v + effective * 6 / 10 })
      state.understanding.update(fn(v) { v + effective * 2 / 10 })
      state.empathy.update(fn(v) { v + effective * 2 / 10 })
    }
    _ => {
      state.trust.update(fn(v) { v + effective / 3 })
      state.understanding.update(fn(v) { v + effective / 3 })
      state.empathy.update(fn(v) { v + effective / 3 })
    }
  }
  sync_intimacy(state)
}

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
        grant_mission_coin_reward(state, m.id)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "talk" && had_talk {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
        grant_mission_coin_reward(state, m.id)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "actions_3" && action_count >= 3 {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
        grant_mission_coin_reward(state, m.id)
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

pub fn open_album(state : GameState) -> Unit {
  state.album_tab.set(0)
  state.phase.set(@data.GamePhase::Album)
}

pub fn close_album(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
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
