// ガチャシステム — ソーシャルゲームの核心
//
// カードを引いてデッキに追加する。被りカードはシャードに変換。
// 天井（pity）システムで一定回数引けばRare確定。
// 学マスのサポートカードガチャに対応。
//
// 設計思想:
// - 搾取的にしない。天井50、コインは行動で十分稼げる
// - 被りにも価値がある（シャード→強化）
// - 初期カード（Always）は最初から所持。ガチャ対象外

/// ガチャバナー定数
///
/// 単発300コイン、10連2700コイン（10%引き）。
/// 天井50回でRare確定。確率: Normal 70%, Uncommon 25%, Rare 5%。
pub let gacha_single_cost : Int = 300

pub let gacha_multi_cost : Int = 2700

pub let gacha_pity_threshold : Int = 50

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
/// ゲーム開始時に呼ばれる。既に登録済みのカードはスキップ。
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
          result.push({ card_id: card.id, level: 1 })
          result
        })
      }
    }
  }
}

/// 条件解放カードのオートアンロック
///
/// 毎行動後・毎日チェック。条件を満たした非GachaOnlyカードを自動登録。
pub fn check_condition_unlocks(state : GameState) -> Unit {
  let all = @data.get_all_cards()
  let stars = get_intimacy_stars(state.intimacy.get())
  let chapter = state.current_chapter.get()
  let day = state.day.get()
  let season = @data.get_season(day)
  let weather = @data.get_weather(day)
  let memory_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    memory_ids.push(record.memory_id)
  }

  for card in all {
    // GachaOnlyはスキップ、Alwaysは既に登録済み
    match card.unlock_condition {
      Always | GachaOnly => continue
      _ => ()
    }
    // 天候/季節限定は「出現条件」であって「所持条件」ではない
    // → 一度手に入れたら永続所持（天候/季節カードもガチャ or 条件で獲得可能に）
    match card.unlock_condition {
      SeasonOnly(_) | WeatherOnly(_) => continue
      _ => ()
    }
    if !is_card_owned(state, card.id) {
      if is_card_unlocked(card, stars, chapter, season, weather, memory_ids) {
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            result.push(oc)
          }
          result.push({ card_id: card.id, level: 1 })
          result
        })
        add_message(state, "新カード獲得: 「" + card.name + "」")
      }
    }
  }
}

/// ガチャ対象カードプールを取得
///
/// GachaOnly + 条件解放カード（Season/Weather限定含む）のうち、
/// まだ最大レベルに達していないもの。
fn get_gacha_pool(state : GameState) -> Array[@data.ActionCard] {
  let all = @data.get_all_cards()
  let pool : Array[@data.ActionCard] = []
  for card in all {
    // 初期カードはガチャ対象外
    if card.unlock_condition == @data.UnlockCondition::Always {
      continue
    }
    // 最大レベル(5)のカードはプールから除外
    let level = get_card_level(state, card.id)
    if level >= 5 {
      continue
    }
    pool.push(card)
  }
  pool
}

/// ガチャ1回分を実行（内部ロジック）
///
/// 1. レアリティ抽選（天井考慮）
/// 2. そのレアリティのカードプールから1枚選択
/// 3. 新規 or 被り判定
/// 4. 被りならシャード変換
fn execute_single_pull(
  state : GameState,
  seed : Int
) -> @data.GachaResult {
  let pool = get_gacha_pool(state)
  let pity = state.gacha_pity.get()

  // 1. レアリティ抽選
  let rarity : @data.CardRarity = if pity >= gacha_pity_threshold - 1 {
    // 天井: Rare確定
    @data.CardRarity::Rare
  } else {
    // 符号安全な擬似乱数: seed を正の範囲に正規化してから % 100
    let raw = seed * 1103515245 + 12345
    let positive = if raw < 0 { -raw } else { raw }
    let percent = positive % 100
    if percent < 5 {
      @data.CardRarity::Rare
    } else if percent < 30 {
      @data.CardRarity::Uncommon
    } else {
      @data.CardRarity::Normal
    }
  }

  // 2. レアリティでフィルタ
  let filtered : Array[@data.ActionCard] = []
  for card in pool {
    if card.rarity == rarity {
      filtered.push(card)
    }
  }

  // フィルタ結果が空なら全プールから選ぶ（フォールバック）
  let target_pool = if filtered.length() > 0 { filtered } else { pool }

  if target_pool.length() == 0 {
    // プールが完全に空の場合（全カードMAX）、ダミー結果を返す
    let dummy_card : @data.ActionCard = {
      id: "c_eat_daily", name: "日替わりを食べる",
      description: "", category: @data.CardCategory::Eat,
      rarity: @data.CardRarity::Normal, ap_cost: 2,
      trust_gain: 2, understanding_gain: 3, empathy_gain: 10,
      unlock_condition: @data.UnlockCondition::Always, scene_key: "eat",
    }
    return { card: dummy_card, is_new: false, shards_gained: 5 }
  }

  // 3. プールからカード選択
  let seed2 = (seed * 48271 + 12345) % 2_147_483_647
  let idx = ((seed2 % target_pool.length()) + target_pool.length()) % target_pool.length()
  let card = target_pool[idx]

  // 4. 新規 or 被り判定
  let is_new = !is_card_owned(state, card.id)
  let shards = if is_new {
    0
  } else {
    // 被り時のシャード数: レアリティに応じて
    match card.rarity {
      Normal => 1
      Uncommon => 3
      Rare => 10
    }
  }

  // 5. 天井カウンタ更新
  if rarity == @data.CardRarity::Rare {
    state.gacha_pity.set(0)
  } else {
    state.gacha_pity.update(fn(p) { p + 1 })
  }

  // 6. カード登録 or シャード付与
  if is_new {
    state.owned_cards.update(fn(arr) {
      let result : Array[@data.OwnedCard] = []
      for oc in arr {
        result.push(oc)
      }
      result.push({ card_id: card.id, level: 1 })
      result
    })
  } else {
    state.enhancement_shards.update(fn(s) { s + shards })
  }

  state.gacha_total_pulls.update(fn(n) { n + 1 })

  { card, is_new, shards_gained: shards }
}

/// ガチャ単発 — 300コイン消費
///
/// コイン不足の場合は何もしない。
/// 結果を gacha_results に設定し、Gacha フェーズのまま演出表示。
pub fn gacha_single(state : GameState) -> Unit {
  if state.coins.get() < gacha_single_cost {
    add_message(state, "コインが足りません")
    return
  }
  state.coins.update(fn(c) { c - gacha_single_cost })

  let seed = state.day.get() * 7919 + state.gacha_total_pulls.get() * 104729
  let result = execute_single_pull(state, seed)

  state.gacha_results.set([result])

  if result.is_new {
    add_message(state, "NEW! 「" + result.card.name + "」を獲得！")
  } else {
    add_message(
      state,
      "「" + result.card.name + "」（被り）→ シャード×" + result.shards_gained.to_string(),
    )
  }
}

/// ガチャ10連 — 2700コイン消費
///
/// 10回引いて、Uncommon以上が1枚も出なければ最後の1枚をUncommon確定にする。
pub fn gacha_multi(state : GameState) -> Unit {
  if state.coins.get() < gacha_multi_cost {
    add_message(state, "コインが足りません")
    return
  }
  state.coins.update(fn(c) { c - gacha_multi_cost })

  let results : Array[@data.GachaResult] = []
  let mut has_uncommon_plus = false
  let base_seed = state.day.get() * 7919 + state.gacha_total_pulls.get() * 104729

  for i in 0..<10 {
    let seed = base_seed + i * 31337
    let result = execute_single_pull(state, seed)
    if result.card.rarity != @data.CardRarity::Normal {
      has_uncommon_plus = true
    }
    results.push(result)
  }

  // 10連保証: Uncommon以上が0枚なら最後の1枚をUncommonに差し替え
  if !has_uncommon_plus && results.length() > 0 {
    // 最後のカードをUncommon候補に差し替え
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
      let shards = if is_new { 0 } else { 3 }
      if is_new {
        state.owned_cards.update(fn(arr) {
          let result : Array[@data.OwnedCard] = []
          for oc in arr {
            result.push(oc)
          }
          result.push({ card_id: card.id, level: 1 })
          result
        })
      } else {
        state.enhancement_shards.update(fn(s) { s + shards })
      }
      // 最後の結果を差し替え
      let last_idx = results.length() - 1
      results[last_idx] = { card, is_new, shards_gained: shards }
    }
  }

  state.gacha_results.set(results)

  // サマリーメッセージ
  let mut new_count = 0
  let mut shard_total = 0
  for r in results {
    if r.is_new {
      new_count = new_count + 1
    }
    shard_total = shard_total + r.shards_gained
  }
  let msg = "10連結果: NEW " + new_count.to_string() + "枚, シャード+" + shard_total.to_string()
  add_message(state, msg)
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
