// デイリーサイクル — 次の日・ミッション・アルバム
//
// next_day() → DayResult表示 → advance_to_next_day() で翌日へ。
// 週末（7日ごと）にチャレンジ判定。

/// 次の日へ進む（DayResult表示）
pub fn next_day(state : GameState) -> Unit {
  // 週チャレンジ判定（DayResult前に）
  check_weekly_challenge(state)

  let result = build_day_result(state)
  state.day_result.set(result)
  state.phase.set(@data.GamePhase::DayResult)
}

/// DayResult画面から実際に翌日へ進む
pub fn advance_to_next_day(state : GameState) -> Unit {
  let current_day = state.day.get()

  // 1. 季節の節目チェック
  if @data.is_season_milestone(current_day) {
    let season = @data.get_season(current_day)
    let year = @data.get_year(current_day)
    let trust = state.trust.get()
    let understanding = state.understanding.get()
    let empathy = state.empathy.get()
    let rank = @data.evaluate_milestone_rank(trust, understanding, empathy)

    state.season_results.update(fn(results) {
      let new_results : Array[@data.SeasonResult] = []
      for r in results {
        new_results.push(r)
      }
      new_results.push({
        season, year, rank,
        trust_at_eval: trust,
        understanding_at_eval: understanding,
        empathy_at_eval: empathy,
      })
      new_results
    })

    let milestone_text = @data.get_milestone_text(season, rank)
    state.today_scene_text.set(milestone_text)

    let season_name = @data.season_to_string(season)
    let rank_name = @data.rank_to_string(rank)
    add_message(state, season_name + "の節目 — " + rank_name + "ランク！")

    check_and_acquire_memories(state, "", Some(rank))

    // Sランクボーナス: 灯ポイント
    if rank == @data.MilestoneRank::S {
      state.akari_points.update(fn(p) { p + 10 })
      add_message(state, "Sランクボーナス: +10 灯ポイント")
    }
  }

  // 2. 翌日へ（スタミナmodを適用して回復）
  state.day.update(fn(d) { d + 1 })
  let stamina_mod = state.next_week_stamina_mod.get()
  let effective_stamina = base_stamina + stamina_mod
  state.stamina.set(effective_stamina)
  state.today_actions.set([])
  state.daily_missions.set(create_daily_missions())

  // 3. バフリセット（翌日に持ち越さない）
  state.buff_comfort.set(0)
  state.buff_curiosity.set(0)
  state.buff_courage.set(0)

  // 4. 手札ドロー
  draw_daily_hand(state)

  // 5. デイスタートスナップショット
  snapshot_day_start(state)

  // 6. 週の開始ならスナップショット
  let new_day = state.day.get()
  if (new_day - 1) % 7 == 0 {
    snapshot_week_start(state)
    // 週が切り替わったのでスタミナmodをリセット
    state.next_week_stamina_mod.set(0)
  }

  // 季節・天候情報
  let new_season = @data.get_season(new_day)
  let new_weather = @data.get_weather(new_day)
  let day_in_season = @data.get_day_in_season(new_day)
  let day_msg = @data.season_to_string(new_season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(new_weather) + @data.weather_to_string(new_weather)
  add_message(state, day_msg)

  // 7. ログボ → Home
  if check_login_bonus(state) {
    state.phase.set(@data.GamePhase::LoginBonus)
  } else {
    state.phase.set(@data.GamePhase::Home)
  }
}

// =========================================================================
// 思い出装備
// =========================================================================

pub fn equip_memory(state : GameState, slot : Int, memory_id : String) -> Unit {
  let acquired = state.acquired_memories.get()
  let mut is_owned = false
  for record in acquired {
    if record.memory_id == memory_id {
      is_owned = true
      break
    }
  }
  if !is_owned && memory_id != "" {
    return
  }

  state.memory_slots.update(fn(slots) {
    match slot {
      0 => { ..slots, trust_slot: memory_id }
      1 => { ..slots, understanding_slot: memory_id }
      _ => { ..slots, empathy_slot: memory_id }
    }
  })

  if memory_id != "" {
    match get_memory_by_id(memory_id) {
      Some(memory) =>
        add_message(state, "思い出「" + memory.title + "」を装備しました")
      None => ()
    }
  }
}

// =========================================================================
// デイリーミッション
// =========================================================================

/// ミッション報酬を灯ポイントで付与
fn grant_mission_reward(state : GameState, reward : Int) -> Unit {
  state.akari_points.update(fn(p) { p + reward })
}

fn check_missions(state : GameState) -> Unit {
  let actions = state.today_actions.get()
  let action_count = actions.length()
  let mut has_buff_play = false
  // バフ消費プレイがあったかチェック
  if state.last_card_result.get().buff_consumed {
    has_buff_play = true
  }

  state.daily_missions.update(fn(missions) {
    let result : Array[@data.DailyMission] = []
    for m in missions {
      if m.completed {
        result.push(m)
      } else if m.id == "action_1" && action_count >= 1 {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.reward)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + " 灯P)")
      } else if m.id == "action_3" && action_count >= 3 {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.reward)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + " 灯P)")
      } else if m.id == "use_buff" && has_buff_play {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.reward)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + " 灯P)")
      } else {
        result.push(m)
      }
    }
    result
  })
}

// =========================================================================
// アルバム
// =========================================================================

pub fn open_album(state : GameState) -> Unit {
  state.album_tab.set(0)
  state.phase.set(@data.GamePhase::Album)
}

pub fn close_album(state : GameState) -> Unit {
  state.phase.set(@data.GamePhase::Home)
}
