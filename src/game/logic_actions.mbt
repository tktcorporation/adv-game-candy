// 行動処理 — カードプレイ・思い出獲得チェック
//
// 学マス参考リデザイン:
// - 毎ターン3枚から1枚選択（レッスン選択方式）
// - ムードボーナス（コンディション方式）
// - コンボチェイン（スキルカード連携方式）
// - PERFECT/GOOD/NORMAL判定（パーフェクトレッスン方式）

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

/// 行動カードをプレイする（学マス参考リデザイン版）
///
/// 新しいフロー:
/// 1. AP消費
/// 2. ムードボーナス計算（ひよりの気分 × カードカテゴリ）
/// 3. コンボ判定（前のカードとの連携）
/// 4. PERFECT/GOOD/NORMAL グレード判定
/// 5. 最終パラメータ = base × ★倍率 × Lv倍率 × ムード倍率 × グレード倍率 + メモリー + コンボ
/// 6. テキスト生成 → Scene
/// 7. 次ターンの選択肢をドロー
pub fn play_card(state : GameState, card_id : String) -> Unit {
  // ターン選択肢から対象カードを探す
  let choices = state.turn_choices.get()
  let mut target_card : @data.ActionCard? = None
  for c in choices.cards {
    if c.id == card_id {
      target_card = Some(c)
      break
    }
  }

  // 選択肢にない場合、旧hand互換でも探す
  if target_card == None {
    let hand = state.hand.get()
    for c in hand {
      if c.id == card_id {
        target_card = Some(c)
        break
      }
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
  let turn = state.turn_number.get()
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

  // 3. ★ランク + レベル によるベースパラメータ
  let card_star = get_card_star_rank(state, card.id)
  let card_level = get_card_level(state, card.id)
  let effective_star = if card_star > 0 { card_star } else { 1 }
  let effective_level = if card_level > 0 { card_level } else { 1 }

  let (base_trust, base_understanding, base_empathy) = calculate_card_gains(
    card, effective_star, effective_level,
    mem_trust, mem_understanding, mem_empathy,
  )

  // 4. ムードボーナス（ひよりの気分）
  let mood = state.mood.get()
  let mood_mult = get_mood_multiplier(mood, card.category)

  // 5. コンボ判定
  let (combo_t, combo_u, combo_e) = process_combo(state, card.category)
  let chain = state.combo_chain.get()
  let chain_mult = get_chain_multiplier(chain)

  // 6. PERFECT/GOOD/NORMAL 判定
  let grade = determine_play_grade(day, turn, mood, card.category, chain)
  let grade_mult = grade_multiplier(grade)
  state.last_play_grade.set(grade)

  // 7. 最終パラメータ計算
  //    = base × mood_mult/100 × grade_mult/100 × chain_mult/100 + combo_bonus
  let trust_gain = base_trust * mood_mult * grade_mult * chain_mult / 1_000_000 + combo_t
  let understanding_gain = base_understanding * mood_mult * grade_mult * chain_mult / 1_000_000 + combo_u
  let empathy_gain = base_empathy * mood_mult * grade_mult * chain_mult / 1_000_000 + combo_e

  // 最低1ポイント保証
  let final_trust = if card.trust_gain > 0 && trust_gain < 1 { 1 } else { trust_gain }
  let final_understanding = if card.understanding_gain > 0 && understanding_gain < 1 { 1 } else { understanding_gain }
  let final_empathy = if card.empathy_gain > 0 && empathy_gain < 1 { 1 } else { empathy_gain }

  state.trust.update(fn(v) { v + final_trust })
  state.understanding.update(fn(v) { v + final_understanding })
  state.empathy.update(fn(v) { v + final_empathy })

  // 親密度（合計値）を同期
  sync_intimacy(state)

  // 8. 親密度マイルストーンチェック
  check_affection_milestones(state)

  // 9. テキスト生成 → Scene へ
  let scene_text = @data.get_action_text(action_str, state.intimacy.get(), day)
  state.today_scene_text.set(scene_text)

  let menu = @data.get_today_menu(day)
  state.today_menu.set(menu.name)

  // 10. 行動履歴
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

  // 11. 行動カウンタ更新
  match card.category {
    Eat => state.total_eat_count.update(fn(n) { n + 1 })
    Observe => state.total_observe_count.update(fn(n) { n + 1 })
    Talk => state.total_talk_count.update(fn(n) { n + 1 })
    _ => ()
  }

  // 12. ミッション判定
  check_missions(state)

  // 13. 思い出獲得チェック
  check_and_acquire_memories(state, card.id, None)

  // 14. 手札からカード除去（旧互換）
  state.hand.update(fn(h) {
    let result : Array[@data.ActionCard] = []
    for c in h {
      if c.id != card_id {
        result.push(c)
      }
    }
    result
  })

  // 15. 通貨・EXP報酬
  grant_action_rewards(state, card)

  // 16. 条件解放カードチェック
  check_condition_unlocks(state)

  // 17. カード結果をScene表示用に保存
  let coin_reward = get_card_coin_reward(card.rarity)
  let exp_reward = get_card_exp_reward(card.rarity)
  let gem_reward = get_card_gem_reward(card.rarity)
  let affection_level = get_affection_level(state.intimacy.get())
  let reaction = @data.get_reaction_text(action_str, affection_level)
  state.last_card_result.set({
    trust_gain: final_trust, understanding_gain: final_understanding,
    empathy_gain: final_empathy,
    coin_reward, exp_reward, gem_reward,
    reaction_text: reaction,
  })

  // 18. メッセージ（グレード表示付き）
  let grade_str = grade_to_string(grade)
  let grade_prefix = if grade_str != "" { grade_str + " " } else { "" }
  let msg = grade_prefix + card.name + " — 信頼+" + final_trust.to_string() + " 理解+" + final_understanding.to_string() + " 共感+" + final_empathy.to_string() + " +" + coin_reward.to_string() + "コイン"
  add_message(state, msg)

  // 19. ターン数を進めて次の選択肢をドロー
  state.turn_number.update(fn(t) { t + 1 })
  let next_turn = state.turn_number.get()

  // APが残っていれば次ターンの選択肢をドロー
  if state.ap.get() > 0 {
    draw_turn_choices_for_state(state, next_turn)
  } else {
    // AP切れ: 選択肢をクリア
    state.turn_choices.set({ cards: [], turn_number: next_turn })
  }

  state.phase.set(@data.GamePhase::Scene)
}

/// ターン選択肢をステートにドロー
///
/// カードプールを構築し、draw_turn_choices で3枚ドローして
/// turn_choices に設定する。
pub fn draw_turn_choices_for_state(state : GameState, turn : Int) -> Unit {
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

  let choices = draw_turn_choices(pool, day, turn)
  state.turn_choices.set({ cards: choices, turn_number: turn })
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
