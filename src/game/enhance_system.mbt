// カード強化システム — ブルアカの生徒育成に対応
//
// ★ランクアップ: カード固有シャード + コインで★1→★5
// レベルアップ: コインのみでLv1→max（上限=★ランク×10、プレイヤーレベルで制約）
//
// ★ランクアップコスト:
//   ★1→★2: 10シャード + 1000コイン
//   ★2→★3: 30シャード + 3000コイン
//   ★3→★4: 100シャード + 10000コイン
//   ★4→★5: 300シャード + 30000コイン
//
// レベルアップコスト:
//   1レベルにつき (current_level * 10 + 50) コイン

/// ★ランクの上限
pub let max_star_rank : Int = 5

/// ★ランクアップに必要なコスト
pub fn get_star_up_cost(current_star : Int) -> @data.StarUpCost? {
  match current_star {
    1 => Some({ shards: 10, coins: 1000 })
    2 => Some({ shards: 30, coins: 3000 })
    3 => Some({ shards: 100, coins: 10000 })
    4 => Some({ shards: 300, coins: 30000 })
    _ => None  // ★5 = MAX
  }
}

/// レベルアップに必要なコスト（1レベル分）
pub fn get_level_up_cost(current_level : Int) -> @data.LevelUpCost {
  { coins: current_level * 10 + 50 }
}

/// ★ランクアップを実行
///
/// 条件: 所持済み、★MAX未満、固有シャード/コイン足りる。
pub fn star_up_card(state : GameState, card_id : String) -> Unit {
  let owned = state.owned_cards.get()
  let mut current_star = 0
  let mut current_shards = 0
  let mut found = false
  for oc in owned {
    if oc.card_id == card_id {
      current_star = oc.star_rank
      current_shards = oc.shards
      found = true
      break
    }
  }
  if !found {
    add_message(state, "カードを所持していません")
    return
  }

  let cost = match get_star_up_cost(current_star) {
    Some(c) => c
    None => {
      add_message(state, "★MAXに達しています")
      return
    }
  }

  if current_shards < cost.shards {
    add_message(state, "シャードが足りません（必要: " + cost.shards.to_string() + "）")
    return
  }
  if state.coins.get() < cost.coins {
    add_message(state, "コインが足りません（必要: " + cost.coins.to_string() + "）")
    return
  }

  // コスト消費
  state.coins.update(fn(c) { c - cost.coins })

  // ★ランクアップ + シャード消費
  state.owned_cards.update(fn(arr) {
    let result : Array[@data.OwnedCard] = []
    for oc in arr {
      if oc.card_id == card_id {
        result.push({ ..oc, star_rank: oc.star_rank + 1, shards: oc.shards - cost.shards })
      } else {
        result.push(oc)
      }
    }
    result
  })

  // カード名取得
  let all = @data.get_all_cards()
  let mut card_name = card_id
  for c in all {
    if c.id == card_id {
      card_name = c.name
      break
    }
  }

  let new_star = current_star + 1
  add_message(
    state,
    "「" + card_name + "」を★" + new_star.to_string() + "にランクアップ！",
  )
}

/// レベルアップを実行
///
/// 条件: 所持済み、レベル上限未満（★ランク×10 or プレイヤーレベル）、コイン足りる。
pub fn level_up_card(state : GameState, card_id : String) -> Unit {
  let owned = state.owned_cards.get()
  let mut current_level = 0
  let mut current_star = 0
  let mut found = false
  for oc in owned {
    if oc.card_id == card_id {
      current_level = oc.level
      current_star = oc.star_rank
      found = true
      break
    }
  }
  if !found {
    add_message(state, "カードを所持していません")
    return
  }

  let max_level = get_card_max_level(current_star, state.player_level.get())
  if current_level >= max_level {
    if current_level >= current_star * 10 {
      add_message(state, "レベル上限です（★ランクを上げてください）")
    } else {
      add_message(state, "レベル上限です（プレイヤーレベルを上げてください）")
    }
    return
  }

  let cost = get_level_up_cost(current_level)
  if state.coins.get() < cost.coins {
    add_message(state, "コインが足りません（必要: " + cost.coins.to_string() + "）")
    return
  }

  // コスト消費
  state.coins.update(fn(c) { c - cost.coins })

  // レベルアップ
  state.owned_cards.update(fn(arr) {
    let result : Array[@data.OwnedCard] = []
    for oc in arr {
      if oc.card_id == card_id {
        result.push({ ..oc, level: oc.level + 1 })
      } else {
        result.push(oc)
      }
    }
    result
  })

  let all = @data.get_all_cards()
  let mut card_name = card_id
  for c in all {
    if c.id == card_id {
      card_name = c.name
      break
    }
  }

  let new_level = current_level + 1
  add_message(
    state,
    "「" + card_name + "」をLv" + new_level.to_string() + "に強化！",
  )
}

/// エリグマをカード固有シャードに変換
///
/// ブルアカのエリグマ→神名文字変換に対応。
/// 1エリグマ = 1カード固有シャード。
pub fn convert_eligma(state : GameState, card_id : String, amount : Int) -> Unit {
  if state.eligma.get() < amount {
    add_message(state, "エリグマが足りません")
    return
  }

  let mut found = false
  for oc in state.owned_cards.get() {
    if oc.card_id == card_id {
      found = true
      break
    }
  }
  if !found {
    add_message(state, "カードを所持していません")
    return
  }

  state.eligma.update(fn(e) { e - amount })
  state.owned_cards.update(fn(arr) {
    let result : Array[@data.OwnedCard] = []
    for oc in arr {
      if oc.card_id == card_id {
        result.push({ ..oc, shards: oc.shards + amount })
      } else {
        result.push(oc)
      }
    }
    result
  })

  add_message(state, "エリグマ×" + amount.to_string() + "をシャードに変換")
}

/// 強化画面を開く
pub fn open_enhance(state : GameState) -> Unit {
  state.enhance_target_card.set("")
  state.enhance_mode.set("star")
  state.phase.set(@data.GamePhase::CardEnhance)
}

/// 強化画面を閉じてHomeへ
pub fn close_enhance(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}

/// 強化対象カードを選択
pub fn select_enhance_target(state : GameState, card_id : String) -> Unit {
  state.enhance_target_card.set(card_id)
}
