// 行動カードシステム — ブルアカ参考リライト
//
// 毎日の手札ドロー・デッキ構築・カードプレイのロジック。
// ★ランク(1-5) + レベル(1-N) の2軸でカードを育成する。
//
// 設計変更:
// - 旧 IntimacyRankReached → AffectionLevel（上限なし）
// - 旧 カードLv1-5 → ★ランク(1-5)でベース倍率 + レベルで追加スケーリング
// - param_scale_percent でグローバルバランス調整

/// 手札の最大枚数
pub let max_hand_size : Int = 4

/// グローバルパラメータスケーリング係数（パーセント）
///
/// 全カードのパラメータ獲得値にこの係数を適用。
/// 100 = 元の値、15 = 15%（大幅スケールダウン）。
///
/// 設計根拠（シミュレーター検証済み）:
/// - 100% → 親密度レベル上昇が速すぎる
/// - 15% → 適正レンジ（親密度Lv10到達 ~30日、Lv20到達 ~75日）
pub let param_scale_percent : Int = 15

// =========================================================================
// 親密度レベル計算（上限なし）
// =========================================================================

/// 親密度ポイントから親密度レベルを算出
///
/// 上限なし。レベルN到達に必要な累計ポイント = N * N * 5。
/// Lv1: 5, Lv5: 125, Lv10: 500, Lv15: 1125, Lv20: 2000, Lv50: 12500
///
/// 設計根拠: 二次関数的増加で序盤は速く、後半はゆっくり。
/// ★5ハードキャップを廃止し、常に成長余地がある。
pub fn get_affection_level(points : Int) -> Int {
  if points <= 0 {
    return 1
  }
  // N * N * 5 <= points を満たす最大のN
  let mut level = 1
  while (level + 1) * (level + 1) * 5 <= points {
    level = level + 1
  }
  level
}

/// 次の親密度レベルに必要な累計ポイント
pub fn affection_points_for_level(level : Int) -> Int {
  level * level * 5
}

// =========================================================================
// カードの解放条件チェック
// =========================================================================

/// カードの解放条件を満たしているかチェック
///
/// AffectionLevel(N): 親密度レベルN以上で解放（旧 IntimacyRankReached）
pub fn is_card_unlocked(
  card : @data.ActionCard,
  affection_level : Int,
  cleared_chapter : Int,
  current_season : @data.Season,
  current_weather : @data.Weather,
  acquired_memory_ids : Array[String]
) -> Bool {
  match card.unlock_condition {
    Always => true
    AffectionLevel(level) => affection_level >= level
    ChapterCleared(ch) => cleared_chapter >= ch
    SeasonOnly(season) => season == current_season
    WeatherOnly(weather) => weather == current_weather
    MemoryAcquired(memory_id) => {
      let mut found = false
      for id in acquired_memory_ids {
        if id == memory_id {
          found = true
          break
        }
      }
      found
    }
    GachaOnly => false  // ガチャ専用カードは条件解放しない
  }
}

/// 現在の状況に応じた有効カードプールを構築
pub fn build_available_pool(
  affection_level : Int,
  cleared_chapter : Int,
  current_season : @data.Season,
  current_weather : @data.Weather,
  acquired_memory_ids : Array[String]
) -> Array[@data.ActionCard] {
  let all_cards = @data.get_all_cards()
  let pool : Array[@data.ActionCard] = []
  for card in all_cards {
    if is_card_unlocked(
      card, affection_level, cleared_chapter,
      current_season, current_weather, acquired_memory_ids,
    ) {
      pool.push(card)
    }
  }
  pool
}

/// 毎ターンの選択肢をドロー（学マスのレッスン選択に対応）
///
/// 有効カードプールからランダムに3枚を選ぶ。
/// プレイヤーは3枚から1枚を選び、残りは捨てる。
/// 「どれを取るか」の悩みがゲームの面白さの核心。
///
/// day + turn でシードを作るため、同じ日の同じターンなら同じ結果。
/// レアリティ重み: Normal=3, Uncommon=2, Rare=1。
/// 天候/季節限定カードは出現時に1枚保証スロット。
pub fn draw_turn_choices(
  pool : Array[@data.ActionCard],
  day : Int,
  turn : Int
) -> Array[@data.ActionCard] {
  let choices_size = 3 // 毎ターン3枚提示

  if pool.length() == 0 {
    return []
  }

  let choices : Array[@data.ActionCard] = []

  // 1. 天候/季節限定カードがあれば1枚確定（最初のターンのみ）
  let special_pool : Array[@data.ActionCard] = []
  let normal_pool : Array[@data.ActionCard] = []
  for card in pool {
    match card.category {
      Weather | Seasonal => special_pool.push(card)
      _ => normal_pool.push(card)
    }
  }

  if special_pool.length() > 0 && turn == 0 {
    let idx = ((day * 4957) % special_pool.length() + special_pool.length()) % special_pool.length()
    choices.push(special_pool[idx])
  }

  // 2. 残りスロットを通常プールから重み付き選択
  let weighted : Array[(@data.ActionCard, Int)] = []
  for card in normal_pool {
    let weight = match card.rarity {
      Normal => 3
      Uncommon => 2
      Rare => 1
    }
    weighted.push((card, weight))
  }

  // day + turn でシードを変える（同じ日でもターンごとに異なる選択肢）
  let mut seed = day * 6271 + turn * 9377
  let remaining = choices_size - choices.length()
  for _ in 0..<remaining {
    if weighted.length() == 0 {
      break
    }

    let mut total_weight = 0
    for item in weighted {
      total_weight = total_weight + item.1
    }
    if total_weight == 0 {
      break
    }

    seed = (seed * 1103515245 + 12345) % 2_147_483_647
    let mut pick = (seed % total_weight + total_weight) % total_weight
    let mut chosen_idx = 0
    for i, item in weighted {
      pick = pick - item.1
      if pick < 0 {
        chosen_idx = i
        break
      }
      if pick == 0 && i == weighted.length() - 1 {
        chosen_idx = i
      }
    }

    let (card, _) = weighted[chosen_idx]

    let mut already_chosen = false
    for c in choices {
      if c.id == card.id {
        already_chosen = true
        break
      }
    }

    let new_weighted : Array[(@data.ActionCard, Int)] = []
    for i, item in weighted {
      if i != chosen_idx {
        new_weighted.push(item)
      }
    }

    if !already_chosen {
      choices.push(card)
    }

    while weighted.length() > 0 {
      ignore(weighted.pop())
    }
    for item in new_weighted {
      weighted.push(item)
    }
  }

  choices
}

/// 旧互換: draw_hand は draw_turn_choices のラッパー
///
/// 初回ターンの選択肢を返す。既存コードとの互換性のため残す。
pub fn draw_hand(
  pool : Array[@data.ActionCard],
  day : Int
) -> Array[@data.ActionCard] {
  draw_turn_choices(pool, day, 0)
}

// =========================================================================
// カード強化パラメータ計算（★ランク + レベル 2軸）
// =========================================================================

/// ★ランクの基本倍率（10倍して整数管理）
///
/// ★1=10(1.0x), ★2=12(1.2x), ★3=14(1.4x), ★4=17(1.7x), ★5=20(2.0x)
pub fn get_star_multiplier(star_rank : Int) -> Int {
  match star_rank {
    1 => 10
    2 => 12
    3 => 14
    4 => 17
    5 => 20
    _ => 10
  }
}

/// カードレベルのボーナス倍率（100倍して整数管理）
///
/// Lv毎に+2%: Lv1=100, Lv10=118, Lv20=138, Lv50=198
pub fn get_level_bonus(level : Int) -> Int {
  100 + (level - 1) * 2
}

/// カードの最大レベル
///
/// ★ランク × 10 と プレイヤーレベル の小さい方。
/// ★1: max Lv10, ★2: max Lv20, ★3: max Lv30, ★4: max Lv40, ★5: max Lv50
pub fn get_card_max_level(star_rank : Int, player_level : Int) -> Int {
  let star_cap = star_rank * 10
  if player_level < star_cap { player_level } else { star_cap }
}

/// カードプレイ時の3軸パラメータ獲得値を計算
///
/// 計算式: base × param_scale% × ★倍率 × Lv倍率 + メモリーボーナス
/// 最低1ポイント保証（元値が1以上なら）。
pub fn calculate_card_gains(
  card : @data.ActionCard,
  star_rank : Int,
  card_level : Int,
  memory_trust_bonus : Int,
  memory_understanding_bonus : Int,
  memory_empathy_bonus : Int
) -> (Int, Int, Int) {
  let star_mult = get_star_multiplier(star_rank)
  let level_mult = get_level_bonus(card_level)

  // base × scale% × ★mult/10 × level_mult/100
  let trust = card.trust_gain * param_scale_percent * star_mult * level_mult / 100_000 + memory_trust_bonus
  let understanding = card.understanding_gain * param_scale_percent * star_mult * level_mult / 100_000 + memory_understanding_bonus
  let empathy = card.empathy_gain * param_scale_percent * star_mult * level_mult / 100_000 + memory_empathy_bonus

  // 最低1ポイント保証
  let t = if card.trust_gain > 0 && trust < 1 { 1 } else { trust }
  let u = if card.understanding_gain > 0 && understanding < 1 { 1 } else { understanding }
  let e = if card.empathy_gain > 0 && empathy < 1 { 1 } else { empathy }
  (t, u, e)
}

/// カードプレイ前の獲得値プレビュー（UI表示用）
///
/// play_card() と同じ計算ロジック（★ランク・レベル・メモリーボーナス反映）で
/// 実効値を返す。app.mbt のカード表示で、base値ではなく実効値を表示するために使用。
///
/// 背景: カードに「共+10」と表示されるが、param_scale_percent=15 適用後は「共+1」。
/// この関数で正しい値を表示することで、プレイヤーの期待と実際の乖離をなくす。
pub fn preview_card_gains(
  state : GameState,
  card : @data.ActionCard
) -> (Int, Int, Int) {
  let card_star = get_card_star_rank(state, card.id)
  let card_level = get_card_level(state, card.id)
  let effective_star = if card_star > 0 { card_star } else { 1 }
  let effective_level = if card_level > 0 { card_level } else { 1 }
  let memory_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    memory_ids.push(record.memory_id)
  }
  let (m_t, m_u, m_e) = calculate_memory_bonus(
    state.memory_slots.get(), memory_ids,
  )
  calculate_card_gains(card, effective_star, effective_level, m_t, m_u, m_e)
}

// =========================================================================
// 定食屋パッシブ収入（ブルアカのカフェに対応）
// =========================================================================

/// 定食屋パッシブ収入を計算
///
/// 親密度レベルに応じて毎日自動でコイン・ジェムを獲得。
/// 「灯に通い続けること自体が報われる」設計。
///
/// コイン: 10 + affection_level * 5 (Lv10 → 60コイン/日)
/// ジェム: affection_level / 10 (Lv10 → 1ジェム/日, Lv20 → 2)
pub fn calculate_passive_income(affection_level : Int) -> @data.RestaurantPassive {
  {
    daily_coins: 10 + affection_level * 5,
    daily_gems: affection_level / 10,
  }
}
