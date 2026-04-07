// ガチャシステム — 簡素化版
//
// 行動カードを獲得するガチャ。コインで引く。
// 旧システムの★ランク/シャード/エリグマ/スパークを削除し、
// シンプルに「新しい行動カードが手に入る」だけに。

/// ガチャ1回のコスト（コイン）
let gacha_cost : Int = 100

/// ガチャ1回実行
pub fn gacha_single(state : GameState) -> Unit {
  let coins = state.coins.get()
  if coins < gacha_cost {
    add_message(state, "コインが足りません（" + coins.to_string() + "/" + gacha_cost.to_string() + "）")
    return
  }

  state.coins.update(fn(c) { c - gacha_cost })
  state.gacha_pity.update(fn(p) { p + 1 })

  // 排出カード決定
  let all_cards = @data.get_all_cards()
  let pity = state.gacha_pity.get()
  let hash = ((pity * 7919 + state.day.get() * 1013) % all_cards.length() + all_cards.length()) % all_cards.length()
  let card = all_cards[hash]

  // デッキに追加
  let deck = state.deck.get()
  let mut is_new = true
  for id in deck.card_ids {
    if id == card.id {
      is_new = false
      break
    }
  }

  if is_new {
    state.deck.update(fn(d) {
      let new_ids : Array[String] = []
      for id in d.card_ids {
        new_ids.push(id)
      }
      new_ids.push(card.id)
      { ..d, card_ids: new_ids }
    })
    add_message(state, "NEW! 「" + card.name + "」を獲得！")
  } else {
    // 被り → コイン還元
    state.coins.update(fn(c) { c + 30 })
    add_message(state, "「" + card.name + "」（被り → +30コイン）")
  }

  state.gacha_results.set([{ card, is_new }])
}

/// ガチャ画面を開く
pub fn open_gacha(state : GameState) -> Unit {
  state.gacha_results.set([])
  state.phase.set(@data.GamePhase::Gacha)
}

/// ガチャ画面を閉じる
pub fn close_gacha(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}
