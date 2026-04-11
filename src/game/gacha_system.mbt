// ガチャシステム — 食材キャラ排出版
//
// コインで食材キャラを入手。にゃんこ大戦争のガチャに対応。
// N(70%) / R(20%) / SR(8%) / SSR(2%) のレアリティ排出。
// 被りはレベルアップ（強化素材）。

/// ガチャ1回のコスト（コイン）
let gacha_cost : Int = 150

/// ガチャ1回実行 — 食材キャラ排出
pub fn gacha_single(state : GameState) -> Unit {
  let coins = state.coins.get()
  if coins < gacha_cost {
    add_message(
      state,
      "コインが足りません（" +
      coins.to_string() +
      "/" +
      gacha_cost.to_string() +
      "）",
    )
    return
  }

  state.coins.update(fn(c) { c - gacha_cost })
  state.gacha_pity.update(fn(p) { p + 1 })

  // レアリティ決定（決定的ハッシュ）
  let pity = state.gacha_pity.get()
  let rng = ((pity * 7919 + state.day.get() * 1013) % 100 + 100) % 100
  let target_rarity = if rng < 2 {
    @data.Rarity::SSR
  } else if rng < 10 {
    @data.Rarity::SR
  } else if rng < 30 {
    @data.Rarity::R
  } else {
    @data.Rarity::N
  }

  // 対象レアリティのキャラから選出
  let all_allies = @data.get_all_allies()
  let pool : Array[@data.AllyDef] = []
  for ally in all_allies {
    if ally.rarity == target_rarity {
      pool.push(ally)
    }
  }
  // プールが空なら全体から（フォールバック）
  if pool.length() == 0 {
    for ally in all_allies {
      pool.push(ally)
    }
  }

  let idx = ((pity * 3571 + state.day.get() * 7) % pool.length() + pool.length()) % pool.length()
  let ally = pool[idx]

  // 所持チェック
  let owned = state.owned_allies.get()
  let mut is_new = true
  for o in owned {
    if o.ally_id == ally.id {
      is_new = false
      break
    }
  }

  if is_new {
    // 新キャラ獲得
    state.owned_allies.update(fn(list) {
      let result : Array[@data.OwnedAlly] = []
      for o in list {
        result.push(o)
      }
      result.push({ ally_id: ally.id, level: 1 })
      result
    })
    let rarity_str = rarity_to_string(ally.rarity)
    add_message(
      state,
      "NEW! [" + rarity_str + "] " + ally.emoji + "「" + ally.name + "」を獲得！",
    )
  } else {
    // 被り → レベルアップ
    state.owned_allies.update(fn(list) {
      let result : Array[@data.OwnedAlly] = []
      for o in list {
        if o.ally_id == ally.id {
          result.push({ ..o, level: o.level + 1 })
        } else {
          result.push(o)
        }
      }
      result
    })
    add_message(
      state,
      ally.emoji +
      "「" +
      ally.name +
      "」レベルアップ！",
    )
  }
}

/// レアリティの表示文字列
fn rarity_to_string(r : @data.Rarity) -> String {
  match r {
    N => "N"
    R => "R"
    SR => "SR"
    SSR => "SSR"
  }
}

/// ガチャ画面を開く
pub fn open_gacha(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Gacha)
}

/// ガチャ画面を閉じる
pub fn close_gacha(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}
