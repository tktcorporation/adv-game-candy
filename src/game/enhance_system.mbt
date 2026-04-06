// カード強化システム
//
// 所持カードのレベルを上げてパラメータ獲得量を増加させる。
// シャード（ガチャ被り or ミッション報酬）+ コインで強化。
// レベル1→5で最大2倍の効果。
//
// レベル毎の効果倍率:
//   Lv1: 1.0x（基本値）
//   Lv2: 1.2x
//   Lv3: 1.4x
//   Lv4: 1.7x
//   Lv5: 2.0x（MAX）

/// カードレベルの上限
pub let max_card_level : Int = 5

/// レベルごとのパラメータ倍率（10倍して整数管理、実適用時に /10 する）
///
/// Lv1=10, Lv2=12, Lv3=14, Lv4=17, Lv5=20
/// 適用: base_gain * multiplier / 10
pub fn get_level_multiplier(level : Int) -> Int {
  match level {
    1 => 10
    2 => 12
    3 => 14
    4 => 17
    5 => 20
    _ => 10
  }
}

/// レベルアップに必要なコスト
///
/// 現在レベル → 次レベルへのコスト。
/// MAXの場合は None。
pub fn get_enhance_cost(current_level : Int) -> @data.EnhanceCost? {
  match current_level {
    1 => Some({ shards: 2, coins: 100 })
    2 => Some({ shards: 4, coins: 200 })
    3 => Some({ shards: 6, coins: 400 })
    4 => Some({ shards: 10, coins: 800 })
    _ => None  // Lv5 = MAX
  }
}

/// カードの強化済みパラメータ値を計算
///
/// base_gain にレベル倍率を適用して返す。
/// 端数切り上げ（最低でも base_gain は保証）。
pub fn apply_level_bonus(base_gain : Int, level : Int) -> Int {
  let mult = get_level_multiplier(level)
  let result = base_gain * mult / 10
  // 基本値より下がらないよう保証
  if result < base_gain { base_gain } else { result }
}

/// カード強化を実行
///
/// 条件: 所持済み、MAX未満、シャード/コイン足りる。
/// 成功でレベルアップ、コスト消費、メッセージ表示。
pub fn enhance_card(state : GameState, card_id : String) -> Unit {
  // 所持チェック
  let owned = state.owned_cards.get()
  let mut current_level = 0
  let mut found = false
  for oc in owned {
    if oc.card_id == card_id {
      current_level = oc.level
      found = true
      break
    }
  }
  if !found {
    add_message(state, "カードを所持していません")
    return
  }

  // コストチェック
  let cost = match get_enhance_cost(current_level) {
    Some(c) => c
    None => {
      add_message(state, "最大レベルに達しています")
      return
    }
  }

  if state.enhancement_shards.get() < cost.shards {
    add_message(state, "シャードが足りません")
    return
  }
  if state.coins.get() < cost.coins {
    add_message(state, "コインが足りません")
    return
  }

  // コスト消費
  state.enhancement_shards.update(fn(s) { s - cost.shards })
  state.coins.update(fn(c) { c - cost.coins })

  // レベルアップ
  state.owned_cards.update(fn(arr) {
    let result : Array[@data.OwnedCard] = []
    for oc in arr {
      if oc.card_id == card_id {
        result.push({ card_id: oc.card_id, level: oc.level + 1 })
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

  let new_level = current_level + 1
  add_message(
    state,
    "「" + card_name + "」をLv" + new_level.to_string() + "に強化！",
  )
}

/// 強化画面を開く
pub fn open_enhance(state : GameState) -> Unit {
  state.enhance_target_card.set("")
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
