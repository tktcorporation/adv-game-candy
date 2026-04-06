// ガチャシステム — ブルアカの募集システムに対応
//
// ジェム通貨でカードを引く。被りはカード固有シャード+エリグマに変換。
// 200連スパークで任意★3カードを選択可能。
// ソフト天井70連以降、★3確率が毎回+2%上昇。
//
// 設計思想（ブルアカ参考）:
// - 搾取的にしない。ジェムは日常プレイで十分稼げる
// - スパーク200で確定。長期プレイヤーを裏切らない
// - 被りにも価値がある（固有シャード→★ランクアップ）
// - 初回1200ジェム配布で即10連可能

/// ガチャコスト（ジェム）
pub let gacha_single_cost : Int = 120

pub let gacha_multi_cost : Int = 1200

/// スパーク閾値（200連で任意★3選択）
pub let gacha_spark_threshold : Int = 200

/// ソフト天井開始（70連以降、★3確率が+2%/回で上昇）
pub let gacha_soft_pity_start : Int = 70

/// 基本排出レート（千分率）
/// ★3: 2.5%, ★2: 18.5%, ★1: 79%
pub let rate_star3 : Int = 25    // /1000
pub let rate_star2 : Int = 185   // /1000
// ★1は残り: 790/1000

/// カードが所持済みかチェック
pub fn is_card_owned(state : GameState, card_id : String) -> Bool {
  let owned = state.owned_cards.get()
  for oc in owned {
    if oc.card_id == card_id {
      return true
    }
  }
  false
}

/// 所持カードの★ランクを取得（未所持なら0）
pub fn get_card_star_rank(state : GameState, card_id : String) -> Int {
  let owned = state.owned_cards.get()
  for oc in owned {
    if oc.card_id == card_id {
      return oc.star_rank
    }
  }
  0
}

/// 所持カードのレベルを取得（未所持なら0）
pub fn get_card_level(state : GameState, card_id : String) -> Int {
  let owned = state.owned_cards.get()
  for oc in owned {
    if oc.card_id == card_id {
      return oc.level
    }
  }
  0
}

/// 初期カード（Always）を全て所持済みに登録
///
/// ゲーム開始時に呼ばれる。★1 Lv1 で登録。
pub fn register_initial_cards(state : GameState) -> Unit {
  let all = @data.get_all_cards()
  for card in all {
    if card.unlock_condition == @data.UnlockCondition::Always {
      if !is_card_owned(state, card.id) {
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            result.push(oc)
          }
          result.push({ card_id: card.id, star_rank: 1, level: 1, shards: 0 })
          result
        })
      }
    }
  }
}

/// 条件解放カードのオートアンロック
///
/// 毎行動後チェック。条件を満たした非GachaOnlyカードを★1 Lv1で自動登録。
pub fn check_condition_unlocks(state : GameState) -> Unit {
  let all = @data.get_all_cards()
  let aff_level = get_affection_level(state.intimacy.get())
  let chapter = state.current_chapter.get()
  let day = state.day.get()
  let season = @data.get_season(day)
  let weather = @data.get_weather(day)
  let memory_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    memory_ids.push(record.memory_id)
  }

  for card in all {
    match card.unlock_condition {
      Always | GachaOnly => continue
      SeasonOnly(_) | WeatherOnly(_) => continue
      _ => ()
    }
    if !is_card_owned(state, card.id) {
      if is_card_unlocked(card, aff_level, chapter, season, weather, memory_ids) {
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            result.push(oc)
          }
          result.push({ card_id: card.id, star_rank: 1, level: 1, shards: 0 })
          result
        })
        add_message(state, "新カード獲得: 「" + card.name + "」")
      }
    }
  }
}

/// ガチャ対象カードプールを取得
///
/// GachaOnly + 条件解放カード（Season/Weather含む）。
/// Always（初期カード）はガチャ対象外。
fn get_gacha_pool(_state : GameState) -> Array[@data.ActionCard] {
  let all = @data.get_all_cards()
  let pool : Array[@data.ActionCard] = []
  for card in all {
    if card.unlock_condition == @data.UnlockCondition::Always {
      continue
    }
    pool.push(card)
  }
  pool
}

/// ソフト天井を考慮した★3排出率を計算（千分率）
///
/// 70連未満: 25/1000 (2.5%)
/// 70連以降: 25 + (pity - 70) * 20 /1000 (毎回+2%)
/// 最大: 1000/1000 (100%)
fn get_effective_star3_rate(pity : Int) -> Int {
  if pity < gacha_soft_pity_start {
    rate_star3
  } else {
    let bonus = (pity - gacha_soft_pity_start) * 20
    let rate = rate_star3 + bonus
    if rate > 1000 { 1000 } else { rate }
  }
}

/// ガチャ1回分を実行（内部ロジック）
fn execute_single_pull(
  state : GameState,
  seed : Int
) -> @data.GachaResult {
  let pool = get_gacha_pool(state)
  let since_star3 = state.gacha_since_star3.get()

  // 1. レアリティ抽選（ソフト天井は★3未排出連続回数で判定）
  let effective_star3 = get_effective_star3_rate(since_star3)
  let raw = seed * 1103515245 + 12345
  let positive = if raw < 0 { -raw } else { raw }
  let roll = positive % 1000

  let rarity : @data.CardRarity = if roll < effective_star3 {
    @data.CardRarity::Rare
  } else if roll < effective_star3 + rate_star2 {
    @data.CardRarity::Uncommon
  } else {
    @data.CardRarity::Normal
  }

  // 排出時の★ランク
  let pull_star = match rarity {
    Normal => 1
    Uncommon => 2
    Rare => 3
  }

  // 2. レアリティでフィルタ
  let filtered : Array[@data.ActionCard] = []
  for card in pool {
    if card.rarity == rarity {
      filtered.push(card)
    }
  }
  let target_pool = if filtered.length() > 0 { filtered } else { pool }

  if target_pool.length() == 0 {
    let dummy_card : @data.ActionCard = {
      id: "c_eat_daily", name: "日替わりを食べる",
      description: "", category: @data.CardCategory::Eat,
      rarity: @data.CardRarity::Normal, ap_cost: 2,
      trust_gain: 2, understanding_gain: 3, empathy_gain: 10,
      unlock_condition: @data.UnlockCondition::Always, scene_key: "eat",
    }
    return { card: dummy_card, is_new: false, star_rank: 1, shards_gained: 1, eligma_gained: 1 }
  }

  // 3. プールからカード選択
  let seed2 = (seed * 48271 + 12345) % 2_147_483_647
  let idx = ((seed2 % target_pool.length()) + target_pool.length()) % target_pool.length()
  let card = target_pool[idx]

  // 4. 新規 or 被り判定
  let is_new = !is_card_owned(state, card.id)
  let (card_shards, eligma) = if is_new {
    (0, 0)
  } else {
    // 被り時のシャード数（ブルアカ参考: ★ランクに応じて固有シャード + エリグマ）
    match rarity {
      Normal => (1, 1)      // ★1被り: 1固有 + 1エリグマ
      Uncommon => (10, 2)   // ★2被り: 10固有 + 2エリグマ
      Rare => (50, 5)       // ★3被り: 50固有 + 5エリグマ
    }
  }

  // 5. カウンタ更新
  // スパークカウンタ（★3でリセットしない、200で到達）
  state.gacha_pity.update(fn(p) { p + 1 })
  // ソフト天井カウンタ（★3でリセット）
  if rarity == @data.CardRarity::Rare {
    state.gacha_since_star3.set(0)
  } else {
    state.gacha_since_star3.update(fn(p) { p + 1 })
  }

  // スパークチェック
  if state.gacha_pity.get() >= gacha_spark_threshold {
    state.gacha_spark_available.set(true)
  }

  // 6. カード登録 or シャード付与
  if is_new {
    state.owned_cards.update(fn(arr) {
      let result : Array[@data.OwnedCard] = []
      for oc in arr {
        result.push(oc)
      }
      result.push({ card_id: card.id, star_rank: pull_star, level: 1, shards: 0 })
      result
    })
  } else {
    // 被り: カード固有シャードを加算
    state.owned_cards.update(fn(arr) {
      let result : Array[@data.OwnedCard] = []
      for oc in arr {
        if oc.card_id == card.id {
          result.push({ ..oc, shards: oc.shards + card_shards })
        } else {
          result.push(oc)
        }
      }
      result
    })
    // エリグマ加算
    state.eligma.update(fn(e) { e + eligma })
  }

  state.gacha_total_pulls.update(fn(n) { n + 1 })

  { card, is_new, star_rank: pull_star, shards_gained: card_shards, eligma_gained: eligma }
}

/// ガチャ単発 — 120ジェム消費
pub fn gacha_single(state : GameState) -> Unit {
  if state.gems.get() < gacha_single_cost {
    add_message(state, "星石が足りません")
    return
  }
  state.gems.update(fn(g) { g - gacha_single_cost })

  let seed = state.day.get() * 7919 + state.gacha_total_pulls.get() * 104729
  let result = execute_single_pull(state, seed)

  state.gacha_results.set([result])

  if result.is_new {
    add_message(state, "NEW! ★" + result.star_rank.to_string() + "「" + result.card.name + "」を獲得！")
  } else {
    add_message(
      state,
      "「" + result.card.name + "」（被り）→ シャード×" + result.shards_gained.to_string() + " エリグマ×" + result.eligma_gained.to_string(),
    )
  }
}

/// ガチャ10連 — 1200ジェム消費
///
/// ★2以上が1枚も出なければ最後の1枚を★2確定にする。
pub fn gacha_multi(state : GameState) -> Unit {
  if state.gems.get() < gacha_multi_cost {
    add_message(state, "星石が足りません")
    return
  }
  state.gems.update(fn(g) { g - gacha_multi_cost })

  let results : Array[@data.GachaResult] = []
  let mut has_star2_plus = false
  let base_seed = state.day.get() * 7919 + state.gacha_total_pulls.get() * 104729

  for i in 0..<10 {
    let seed = base_seed + i * 31337
    let result = execute_single_pull(state, seed)
    if result.card.rarity != @data.CardRarity::Normal {
      has_star2_plus = true
    }
    results.push(result)
  }

  // 10連保証: ★2以上が0枚なら最後の1枚を★2に差し替え
  if !has_star2_plus && results.length() > 0 {
    let pool = get_gacha_pool(state)
    let uncommon_pool : Array[@data.ActionCard] = []
    for card in pool {
      if card.rarity == @data.CardRarity::Uncommon {
        uncommon_pool.push(card)
      }
    }
    if uncommon_pool.length() > 0 {
      let idx = (base_seed % uncommon_pool.length() + uncommon_pool.length()) % uncommon_pool.length()
      let card = uncommon_pool[idx]
      let is_new = !is_card_owned(state, card.id)
      let (card_shards, eligma) = if is_new { (0, 0) } else { (10, 2) }
      if is_new {
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            result.push(oc)
          }
          result.push({ card_id: card.id, star_rank: 2, level: 1, shards: 0 })
          result
        })
      } else {
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            if oc.card_id == card.id {
              result.push({ ..oc, shards: oc.shards + card_shards })
            } else {
              result.push(oc)
            }
          }
          result
        })
        state.eligma.update(fn(e) { e + eligma })
      }
      let last_idx = results.length() - 1
      results[last_idx] = { card, is_new, star_rank: 2, shards_gained: card_shards, eligma_gained: eligma }
    }
  }

  state.gacha_results.set(results)

  let mut new_count = 0
  let mut shard_total = 0
  let mut eligma_total = 0
  for r in results {
    if r.is_new {
      new_count = new_count + 1
    }
    shard_total = shard_total + r.shards_gained
    eligma_total = eligma_total + r.eligma_gained
  }
  let msg = "10連結果: NEW " + new_count.to_string() + "枚, シャード+" + shard_total.to_string() + " エリグマ+" + eligma_total.to_string()
  add_message(state, msg)
}

/// スパーク実行 — 任意の★3カードを選択して獲得
///
/// 200連到達時に利用可能。スパーク後カウンタリセット。
pub fn execute_spark(state : GameState, card_id : String) -> Unit {
  if !state.gacha_spark_available.get() {
    add_message(state, "スパークが利用できません（200連未達）")
    return
  }

  // ★3カードから選択
  let pool = get_gacha_pool(state)
  let mut target : @data.ActionCard? = None
  for card in pool {
    if card.id == card_id && card.rarity == @data.CardRarity::Rare {
      target = Some(card)
      break
    }
  }

  match target {
    Some(card) => {
      let is_new = !is_card_owned(state, card.id)
      if is_new {
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            result.push(oc)
          }
          result.push({ card_id: card.id, star_rank: 3, level: 1, shards: 0 })
          result
        })
        add_message(state, "スパーク! ★3「" + card.name + "」を獲得！")
      } else {
        // 既所持なら大量シャード
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            if oc.card_id == card.id {
              result.push({ ..oc, shards: oc.shards + 50 })
            } else {
              result.push(oc)
            }
          }
          result
        })
        add_message(state, "スパーク! 「" + card.name + "」のシャード×50を獲得")
      }

      // スパークカウンタリセット
      state.gacha_pity.set(0)
      state.gacha_spark_available.set(false)
    }
    None => {
      add_message(state, "対象カードが見つかりません")
    }
  }
}

/// ガチャ画面を開く
pub fn open_gacha(state : GameState) -> Unit {
  state.gacha_results.set([])
  state.phase.set(@data.GamePhase::Gacha)
}

/// ガチャ画面を閉じてHomeへ
pub fn close_gacha(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}
