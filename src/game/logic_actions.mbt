// 行動処理 — カードプレイ・思い出獲得チェック
//
// play_card() がメイン。★ランク+レベルの2軸でパラメータ計算し、
// 親密度マイルストーン・ミッション・思い出・手札更新まで一連で処理。

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
