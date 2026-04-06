// 思い出（メモリー）システム — 学マスのメモリーに対応
//
// 特定条件を達成すると獲得する収集要素。
// 装備スロット（3枠）にセットするとパッシブ効果が毎日の行動に加算される。
//
// 設計参照: docs/superpowers/specs/2026-04-06-social-game-system.md

/// 思い出の獲得条件をチェックし、新たに獲得した思い出IDのリストを返す
///
/// 毎行動後に呼び出され、条件を満たした未獲得の思い出を検出する。
/// 戻り値: 今回新たに獲得した思い出のIDリスト。
pub fn check_memory_conditions(
  // プレイヤーの状態
  eat_count : Int,
  talk_count : Int,
  observe_count : Int,
  intimacy_stars : Int,
  discovery_count : Int,
  visited_menu_ids : Array[String],
  current_weather : @data.Weather,
  // 既獲得の思い出ID
  acquired_ids : Array[String],
  // 今回プレイしたカードID（特別行動系の判定用）
  played_card_id : String,
  // 季節の節目ランク（節目イベント後に呼ばれる場合）
  season_rank : @data.MilestoneRank?,
  current_season : @data.Season
) -> Array[String] {
  let newly_acquired : Array[String] = []

  // ヘルパー: 既に獲得済みか
  fn is_acquired(id : String) -> Bool {
    for aid in acquired_ids {
      if aid == id {
        return true
      }
    }
    // 今回獲得済みリストもチェック
    for nid in newly_acquired {
      if nid == id {
        return true
      }
    }
    false
  }

  // --- 行動回数系 ---
  if eat_count >= 1 && !is_acquired("m_first_meal") {
    newly_acquired.push("m_first_meal")
  }
  if eat_count >= 5 && !is_acquired("m_five_meals") {
    newly_acquired.push("m_five_meals")
  }
  if talk_count >= 5 && !is_acquired("m_maruyama_laugh") {
    newly_acquired.push("m_maruyama_laugh")
  }
  if observe_count >= 3 && intimacy_stars >= 2 && !is_acquired("m_page_finger") {
    newly_acquired.push("m_page_finger")
  }

  // --- 親密度ランク系 ---
  if intimacy_stars >= 2 && !is_acquired("m_rank2") {
    newly_acquired.push("m_rank2")
  }
  if intimacy_stars >= 3 && !is_acquired("m_rank3") {
    newly_acquired.push("m_rank3")
  }
  if intimacy_stars >= 4 && !is_acquired("m_rank4") {
    newly_acquired.push("m_rank4")
  }
  if intimacy_stars >= 5 && !is_acquired("m_rank5") {
    newly_acquired.push("m_rank5")
  }

  // --- 天候系 ---
  if current_weather == @data.Weather::Rainy && !is_acquired("m_rainy_day") {
    newly_acquired.push("m_rainy_day")
  }
  if current_weather == @data.Weather::Snowy && !is_acquired("m_snowy_day") {
    newly_acquired.push("m_snowy_day")
  }

  // --- 特別行動系 ---
  if played_card_id == "c_sp_recommend" && !is_acquired("m_recommend_food") {
    newly_acquired.push("m_recommend_food")
  }
  if played_card_id == "c_sp_book_talk" && !is_acquired("m_book_conversation") {
    newly_acquired.push("m_book_conversation")
  }

  // --- コレクション系 ---
  // 全12メニュー制覇
  let total_menus = @data.get_daily_menus().length()
  if visited_menu_ids.length() >= total_menus && !is_acquired("m_all_menus") {
    newly_acquired.push("m_all_menus")
  }
  // 発見ノート10個
  if discovery_count >= 10 && !is_acquired("m_ten_discoveries") {
    newly_acquired.push("m_ten_discoveries")
  }

  // --- 季節の節目系 ---
  match season_rank {
    Some(rank) => {
      if rank == @data.MilestoneRank::S {
        let memory_id = match current_season {
          Spring => "m_spring_s"
          Summer => "m_summer_s"
          Autumn => "m_autumn_s"
          Winter => "m_winter_s"
        }
        if !is_acquired(memory_id) {
          newly_acquired.push(memory_id)
        }
      }
    }
    None => ()
  }

  newly_acquired
}

/// 装備中の思い出スロットから合計パッシブボーナスを計算
///
/// 3つのスロットにセットされた思い出のボーナスを合算して返す。
/// 戻り値: (trust_bonus, understanding_bonus, empathy_bonus)
pub fn calculate_memory_bonus(
  slots : @data.MemorySlots,
  acquired_ids : Array[String]
) -> (Int, Int, Int) {
  let all_memories = @data.get_all_memories()
  let mut trust = 0
  let mut understanding = 0
  let mut empathy = 0

  let slot_ids = [slots.trust_slot, slots.understanding_slot, slots.empathy_slot]

  for slot_id in slot_ids {
    if slot_id == "" {
      continue
    }
    // 獲得済みか確認（不正防止）
    let mut is_owned = false
    for aid in acquired_ids {
      if aid == slot_id {
        is_owned = true
        break
      }
    }
    if !is_owned {
      continue
    }
    // 思い出のボーナスを加算
    for memory in all_memories {
      if memory.id == slot_id {
        trust = trust + memory.trust_bonus
        understanding = understanding + memory.understanding_bonus
        empathy = empathy + memory.empathy_bonus
        break
      }
    }
  }

  (trust, understanding, empathy)
}

/// 思い出IDから思い出データを取得
pub fn get_memory_by_id(id : String) -> @data.Memory? {
  let all = @data.get_all_memories()
  for m in all {
    if m.id == id {
      return Some(m)
    }
  }
  None
}
