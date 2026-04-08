// 行動処理 — Layer 1 カードプレイ + バフシステム
//
// 学マスの掛け算を再現: バフ付与カード（低コスト）→ バフ消費カード（高コスト、倍率）
// 心の余裕（stamina）を消費。0になると引きこもりデー。

/// カードをプレイできるか判定
pub fn can_play_card(state : GameState, card : @data.ActionCard) -> Bool {
  state.stamina.get() >= card.stamina_cost
}

/// 日常行動カードをプレイ（Layer 1 のコア処理）
///
/// 1. スタミナ消費
/// 2. バフ消費チェック → 倍率適用
/// 3. パラメータ加算
/// 4. バフ付与
/// 5. ミッション・思い出チェック
/// 6. 灯ポイント付与
pub fn play_daily_action(state : GameState, card_id : String) -> Unit {
  // カード検索
  let card = match @data.get_card_by_id(card_id) {
    Some(c) => c
    None => return
  }

  // スタミナチェック
  if !can_play_card(state, card) {
    add_message(state, "心の余裕が足りない…")
    return
  }

  // 1. スタミナ消費
  state.stamina.update(fn(s) { s - card.stamina_cost })

  // 2. バフ消費 → 倍率計算
  let mut multiplier = 1000  // 千分率: 1000 = 1.0x
  let mut buff_consumed = false
  if card.consumes_buff != "" {
    let has_buff = get_buff_count(state, card.consumes_buff) > 0
    if has_buff {
      multiplier = card.buff_bonus_multiplier
      consume_buff(state, card.consumes_buff)
      buff_consumed = true
    }
  }

  // 3. パラメータ加算（倍率適用）
  let trust_gain = card.trust_gain * multiplier / 1000
  let understanding_gain = card.understanding_gain * multiplier / 1000
  let empathy_gain = card.empathy_gain * multiplier / 1000

  // 思い出パッシブボーナス加算
  let (mem_t, mem_u, mem_e) = calculate_memory_bonus(
    state.memory_slots.get(),
    get_acquired_ids(state),
  )
  let final_trust = trust_gain + mem_t
  let final_understanding = understanding_gain + mem_u
  let final_empathy = empathy_gain + mem_e

  state.trust.update(fn(v) { v + final_trust })
  state.understanding.update(fn(v) { v + final_understanding })
  state.empathy.update(fn(v) { v + final_empathy })
  sync_intimacy(state)

  // 4. バフ付与
  let mut buff_gained = ""
  if card.grants_buff != "" {
    grant_buff(state, card.grants_buff)
    buff_gained = card.grants_buff
  }

  // 5. コイン報酬
  let coin_reward = if buff_consumed { 20 } else { 10 }
  state.coins.update(fn(c) { c + coin_reward })
  state.today_coins_earned.update(fn(c) { c + coin_reward })

  // 6. 灯ポイント（バフ消費時ボーナス）
  let akari_earned = if buff_consumed { 3 } else { 1 }
  state.akari_points.update(fn(p) { p + akari_earned })

  // 7. 行動記録
  state.today_actions.update(fn(a) {
    let result : Array[String] = []
    for act in a {
      result.push(act)
    }
    result.push(card_id)
    result
  })
  state.total_actions.update(fn(n) { n + 1 })

  // 8. シーンテキスト + 結果記録
  let reaction = get_action_reaction(card, buff_consumed)
  state.today_scene_text.set(card.description)
  state.last_card_result.set({
    trust_gain: final_trust,
    understanding_gain: final_understanding,
    empathy_gain: final_empathy,
    base_trust: card.trust_gain,
    base_understanding: card.understanding_gain,
    base_empathy: card.empathy_gain,
    buff_gained,
    buff_consumed,
    multiplier_applied: buff_consumed,
    reaction_text: reaction,
  })

  // 9. ミッション・思い出チェック
  check_missions(state)
  check_and_acquire_memories(state, card_id, None)

  // DailyScene へ遷移
  state.phase.set(@data.GamePhase::DailyScene)
}

/// DailyScene から戻る
pub fn finish_daily_scene(state : GameState) -> Unit {
  // スタミナが0なら自動で日送り
  if state.stamina.get() <= 0 {
    add_message(state, "心の余裕がなくなった。今日はゆっくり休もう。")
    next_day(state)
  } else {
    state.phase.set(@data.GamePhase::DailyAction)
  }
}

// =========================================================================
// バフ操作
// =========================================================================

/// バフのスタック数を取得
pub fn get_buff_count(state : GameState, buff_name : String) -> Int {
  match buff_name {
    "comfort" => state.buff_comfort.get()
    "curiosity" => state.buff_curiosity.get()
    "courage" => state.buff_courage.get()
    _ => 0
  }
}

/// バフを1スタック付与（上限3）
fn grant_buff(state : GameState, buff_name : String) -> Unit {
  let max_stacks = 3
  match buff_name {
    "comfort" =>
      state.buff_comfort.update(fn(c) { if c < max_stacks { c + 1 } else { c } })
    "curiosity" =>
      state.buff_curiosity.update(fn(c) { if c < max_stacks { c + 1 } else { c } })
    "courage" =>
      state.buff_courage.update(fn(c) { if c < max_stacks { c + 1 } else { c } })
    _ => ()
  }
}

/// バフを1スタック消費
fn consume_buff(state : GameState, buff_name : String) -> Unit {
  match buff_name {
    "comfort" =>
      state.buff_comfort.update(fn(c) { if c > 0 { c - 1 } else { 0 } })
    "curiosity" =>
      state.buff_curiosity.update(fn(c) { if c > 0 { c - 1 } else { 0 } })
    "courage" =>
      state.buff_courage.update(fn(c) { if c > 0 { c - 1 } else { 0 } })
    _ => ()
  }
}

/// バフ名の日本語表示
pub fn buff_to_string(name : String) -> String {
  match name {
    "comfort" => "安心"
    "curiosity" => "好奇心"
    "courage" => "勇気"
    _ => ""
  }
}

/// バフ名のアイコン
pub fn buff_to_icon(name : String) -> String {
  match name {
    "comfort" => "♨"
    "curiosity" => "✧"
    "courage" => "⚡"
    _ => ""
  }
}

// =========================================================================
// 手札ドロー
// =========================================================================

/// 今日の手札をドロー（デッキ + 天候/季節条件フィルタ）
pub fn draw_daily_hand(state : GameState) -> Unit {
  let day = state.day.get()
  let season = @data.get_season(day)
  let weather = @data.get_weather(day)
  let deck = state.deck.get()

  let pool : Array[@data.ActionCard] = []

  // デッキ内カード
  let all_cards = @data.get_all_cards()
  for card in all_cards {
    let mut in_deck = false
    for id in deck.card_ids {
      if id == card.id {
        in_deck = true
        break
      }
    }
    if !in_deck {
      continue
    }
    pool.push(card)
  }

  // 天候限定カード（条件一致時のみ追加）
  for card in @data.get_weather_cards() {
    if card.id == "c_w_rain_indoor" && weather == @data.Weather::Rainy {
      pool.push(card)
    } else if card.id == "c_w_sunny_park" && weather == @data.Weather::Sunny {
      pool.push(card)
    }
  }

  // 季節限定カード（条件一致時のみ追加）
  for card in @data.get_seasonal_cards() {
    let season_match = match card.id {
      "c_s_spring_hanami" => season == @data.Season::Spring
      "c_s_summer_ice" => season == @data.Season::Summer
      "c_s_autumn_book" => season == @data.Season::Autumn
      "c_s_winter_stew" => season == @data.Season::Winter
      _ => false
    }
    if season_match {
      pool.push(card)
    }
  }

  // シンプルなシャッフル + 4枚ドロー
  let hand = draw_from_pool(pool, day, 4)
  state.hand.set(hand)
}

/// プールから指定枚数をドロー（決定的ランダム）
fn draw_from_pool(
  pool : Array[@data.ActionCard],
  seed : Int,
  count : Int
) -> Array[@data.ActionCard] {
  if pool.length() == 0 {
    return []
  }
  let result : Array[@data.ActionCard] = []
  let used : Array[Int] = []
  let n = if count > pool.length() { pool.length() } else { count }
  for i = 0; i < n; i = i + 1 {
    let hash = ((seed * 7919 + i * 1013) % pool.length() + pool.length()) % pool.length()
    let mut idx = hash
    // 重複回避
    let mut attempts = 0
    while is_used(used, idx) && attempts < pool.length() {
      idx = (idx + 1) % pool.length()
      attempts = attempts + 1
    }
    if !is_used(used, idx) {
      used.push(idx)
      result.push(pool[idx])
    }
  }
  result
}

fn is_used(used : Array[Int], idx : Int) -> Bool {
  for u in used {
    if u == idx {
      return true
    }
  }
  false
}

// =========================================================================
// リアクションテキスト
// =========================================================================

/// 行動結果のテキスト（バフ消費で特別テキスト）
fn get_action_reaction(card : @data.ActionCard, buff_consumed : Bool) -> String {
  if buff_consumed {
    match card.consumes_buff {
      "comfort" => "安心感が力になった。いつもより手応えがある。"
      "curiosity" => "好奇心が弾けた。新しい発見がたくさん。"
      "courage" => "勇気を振り絞った。一歩踏み出せた気がする。"
      _ => ""
    }
  } else if card.grants_buff != "" {
    match card.grants_buff {
      "comfort" => "ほっとする。安心が少し溜まった。"
      "curiosity" => "面白い。もっと知りたくなった。"
      "courage" => "やればできる。少し勇気が出た。"
      _ => ""
    }
  } else {
    "静かな時間が流れた。"
  }
}

// =========================================================================
// 思い出獲得チェック（memory_system.mbt から呼び出し）
// =========================================================================

/// 獲得済み思い出IDリストを取得
fn get_acquired_ids(state : GameState) -> Array[String] {
  let records = state.acquired_memories.get()
  let ids : Array[String] = []
  for r in records {
    ids.push(r.memory_id)
  }
  ids
}

/// 思い出獲得チェック＆記録
pub fn check_and_acquire_memories(
  state : GameState,
  played_card_id : String,
  season_rank : @data.MilestoneRank?
) -> Unit {
  let acquired_ids = get_acquired_ids(state)
  let aff_level = get_affection_level(state.intimacy.get())
  let day = state.day.get()
  let weather = @data.get_weather(day)
  let season = @data.get_season(day)
  let eat_count = state.total_actions.get()  // 簡易: 全行動数
  let talk_count = 0
  let observe_count = 0
  let disc_count = state.discoveries.get().length()
  let visit_menus : Array[String] = []
  for r in state.visit_log.get() {
    visit_menus.push(r.menu_id)
  }

  let new_ids = check_memory_conditions(
    eat_count, talk_count, observe_count,
    aff_level, disc_count, visit_menus,
    weather, acquired_ids, played_card_id,
    season_rank, season,
  )

  for id in new_ids {
    state.acquired_memories.update(fn(records) {
      let result : Array[@data.MemoryRecord] = []
      for r in records {
        result.push(r)
      }
      result.push({ memory_id: id, acquired_day: day, acquired_season: season })
      result
    })
    match get_memory_by_id(id) {
      Some(memory) =>
        add_message(state, "思い出「" + memory.title + "」を獲得！")
      None => ()
    }
  }
}
