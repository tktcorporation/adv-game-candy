// 行動カードシステム — 学マスのスキルカードに対応
//
// 毎日の手札ドロー・デッキ構築・カードプレイのロジック。
// プレイヤーの進行状況に応じてデッキが拡張され、
// 天候・季節で手札の出現が変化する。
//
// 設計参照: docs/superpowers/specs/2026-04-06-social-game-system.md

/// 手札の最大枚数
pub let max_hand_size : Int = 4

/// カードの解放条件を満たしているかチェック
///
/// プレイヤーの現在の進行状況（ランク、クリア章、季節、天候、所持思い出）
/// と照合して、そのカードがデッキに含まれるかを判定する。
pub fn is_card_unlocked(
  card : @data.ActionCard,
  intimacy_stars : Int,
  cleared_chapter : Int,
  current_season : @data.Season,
  current_weather : @data.Weather,
  acquired_memory_ids : Array[String]
) -> Bool {
  match card.unlock_condition {
    Always => true
    IntimacyRankReached(rank) => intimacy_stars >= rank
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
    GachaOnly => false  // ガチャ専用カードは条件解放しない（ガチャで獲得）
  }
}

/// 現在の状況に応じた有効カードプールを構築
///
/// 全カードから解放条件を満たすものだけをフィルタリング。
/// これが毎日の手札ドロー元になる。
pub fn build_available_pool(
  intimacy_stars : Int,
  cleared_chapter : Int,
  current_season : @data.Season,
  current_weather : @data.Weather,
  acquired_memory_ids : Array[String]
) -> Array[@data.ActionCard] {
  let all_cards = @data.get_all_cards()
  let pool : Array[@data.ActionCard] = []
  for card in all_cards {
    if is_card_unlocked(
      card, intimacy_stars, cleared_chapter,
      current_season, current_weather, acquired_memory_ids,
    ) {
      pool.push(card)
    }
  }
  pool
}

/// 毎日の手札をドロー
///
/// 有効カードプールからランダムに max_hand_size 枚を選ぶ。
/// day ベースの決定的シャッフルにより、同じ日なら同じ手札が出る。
/// レアリティで重み付け: Normal=3, Uncommon=2, Rare=1。
///
/// 天候・季節限定カードは「必ず1枚手札に入る」保証を持つ。
/// これにより「雨の日だからあのカードが来る」という期待感を作る。
pub fn draw_hand(
  pool : Array[@data.ActionCard],
  day : Int
) -> Array[@data.ActionCard] {
  if pool.length() == 0 {
    return []
  }

  let hand : Array[@data.ActionCard] = []

  // 1. 天候/季節限定カードがあれば1枚確定で入れる
  let special_pool : Array[@data.ActionCard] = []
  let normal_pool : Array[@data.ActionCard] = []
  for card in pool {
    match card.category {
      Weather | Seasonal => special_pool.push(card)
      _ => normal_pool.push(card)
    }
  }

  if special_pool.length() > 0 {
    // 限定カードから1枚を日数ハッシュで選択
    let idx = ((day * 4957) % special_pool.length() + special_pool.length()) % special_pool.length()
    hand.push(special_pool[idx])
  }

  // 2. 残りのスロットを通常プールから埋める（重複なし）
  // 重み付きシャッフル: レアリティで出現率を調整
  let weighted : Array[(@data.ActionCard, Int)] = []
  for card in normal_pool {
    let weight = match card.rarity {
      Normal => 3
      Uncommon => 2
      Rare => 1
    }
    weighted.push((card, weight))
  }

  // 決定的擬似ランダムでシャッフル
  // day * 素数 をシードとして使用
  let mut seed = day * 6271
  let remaining = max_hand_size - hand.length()
  for _ in 0..<remaining {
    if weighted.length() == 0 {
      break
    }

    // 重みの合計
    let mut total_weight = 0
    for item in weighted {
      total_weight = total_weight + item.1
    }
    if total_weight == 0 {
      break
    }

    // 重み付き選択
    seed = (seed * 1103515245 + 12345) % 2_147_483_647
    let mut pick = (seed % total_weight + total_weight) % total_weight
    let mut chosen_idx = 0
    for i, item in weighted {
      pick = pick - item.1
      if pick < 0 {
        // pick が負になった = このカードが選ばれた
        chosen_idx = i
        break
      }
      // pick が 0 の場合もこのカードが選ばれる
      if pick == 0 && i == weighted.length() - 1 {
        chosen_idx = i
      }
    }

    // 手札に追加し、プールから除去（重複防止）
    let (card, _) = weighted[chosen_idx]

    // 既に手札にある同IDのカードはスキップ
    let mut already_in_hand = false
    for h in hand {
      if h.id == card.id {
        already_in_hand = true
        break
      }
    }

    // プールからは常に除去
    let new_weighted : Array[(@data.ActionCard, Int)] = []
    for i, item in weighted {
      if i != chosen_idx {
        new_weighted.push(item)
      }
    }

    if !already_in_hand {
      hand.push(card)
    }

    // weighted を更新（MoonBit では再代入できないので、次のイテレーションで
    // new_weighted を使う必要がある。ここでは break/continue パターンで対応）
    // → 実際には配列を直接操作する
    // weighted の中身を new_weighted に置き換える
    while weighted.length() > 0 {
      ignore(weighted.pop())
    }
    for item in new_weighted {
      weighted.push(item)
    }
  }

  hand
}

/// グローバルパラメータスケーリング係数（パーセント）
///
/// 全カードのパラメータ獲得値にこの係数を適用する。
/// 100 = 元の値、50 = 半分、33 = 1/3。
/// バランス調整はここで一括管理。
///
/// 設計根拠（シミュレーター検証済み）:
/// - 100% → ★5到達21日（速すぎ）
/// - 35% → ★5到達51日（やや速い）
/// - 15% → ★5到達約90日（適正レンジ）
/// ミッション報酬にも同じ係数が適用される
pub let param_scale_percent : Int = 15

/// カードをプレイした際の3軸パラメータ獲得値を計算
///
/// カード基本値 × グローバルスケール + 装備メモリーのパッシブボーナス。
/// スケール後の最低値は各軸1（ゼロ行動を防ぐ）。
pub fn calculate_card_gains(
  card : @data.ActionCard,
  memory_trust_bonus : Int,
  memory_understanding_bonus : Int,
  memory_empathy_bonus : Int
) -> (Int, Int, Int) {
  let trust = card.trust_gain * param_scale_percent / 100 + memory_trust_bonus
  let understanding = card.understanding_gain * param_scale_percent / 100 + memory_understanding_bonus
  let empathy = card.empathy_gain * param_scale_percent / 100 + memory_empathy_bonus
  // 最低1ポイント保証（元値が1以上なら）
  let t = if card.trust_gain > 0 && trust < 1 { 1 } else { trust }
  let u = if card.understanding_gain > 0 && understanding < 1 { 1 } else { understanding }
  let e = if card.empathy_gain > 0 && empathy < 1 { 1 } else { empathy }
  (t, u, e)
}
