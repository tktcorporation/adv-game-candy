// 思い出（メモリー）システム — 学マスのメモリーに対応
//
// 特定条件を達成すると獲得する収集要素。
// 装備スロット（3枠）にセットするとパッシブ効果が毎日の行動に加算される。
//
// 設計変更: intimacy_stars → affection_level（上限なし）
// 旧★2→Lv5, ★3→Lv10, ★4→Lv15, ★5→Lv20 にマッピング。

/// 思い出の獲得条件をチェックし、新たに獲得した思い出IDのリストを返す
///
/// 毎行動後に呼び出され、条件を満たした未獲得の思い出を検出する。
pub fn check_memory_conditions(
  eat_count : Int,
  talk_count : Int,
  observe_count : Int,
  affection_level : Int,
  discovery_count : Int,
  visited_menu_ids : Array[String],
  current_weather : @data.Weather,
  acquired_ids : Array[String],
  played_card_id : String,
  season_rank : @data.MilestoneRank?,
  current_season : @data.Season
) -> Array[String] {
  let newly_acquired : Array[String] = []

  fn is_acquired(id : String) -> Bool {
    for aid in acquired_ids {
      if aid == id {
        return true
      }
    }
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
  if observe_count >= 3 && affection_level >= 5 && !is_acquired("m_page_finger") {
    newly_acquired.push("m_page_finger")
  }

  // --- 親密度レベル系（旧★ランク → 親密度レベル） ---
  // 旧★2=Lv5, ★3=Lv10, ★4=Lv15, ★5=Lv20
  if affection_level >= 5 && !is_acquired("m_rank2") {
    newly_acquired.push("m_rank2")
  }
  if affection_level >= 10 && !is_acquired("m_rank3") {
    newly_acquired.push("m_rank3")
  }
  if affection_level >= 15 && !is_acquired("m_rank4") {
    newly_acquired.push("m_rank4")
  }
  if affection_level >= 20 && !is_acquired("m_rank5") {
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
  let total_menus = @data.get_daily_menus().length()
  if visited_menu_ids.length() >= total_menus && !is_acquired("m_all_menus") {
    newly_acquired.push("m_all_menus")
  }
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
