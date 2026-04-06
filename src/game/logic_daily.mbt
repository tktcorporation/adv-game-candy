// デイリーサイクル — 次の日・パッシブ収入・ミッション・思い出装備
//
// 学マス参考リデザイン:
// - 毎朝ムード更新 + 最初のターン選択肢ドロー
// - 週末に週イベント判定
// - ターン数・コンボチェインのリセット
//
// next_day() → DayResult表示 → advance_to_next_day() で翌日へ。

/// 次の日へ進む（DayResult表示）
pub fn next_day(state : GameState) -> Unit {
  // 週イベント判定（DayResult前に行うことで結果をサマリーに含められる）
  check_weekly_event(state)

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
    add_message(
      state,
      season_name + "の節目 — " + rank_name + "ランク！",
    )

    check_and_acquire_memories(state, "", Some(rank))

    if rank == @data.MilestoneRank::S {
      state.gems.update(fn(g) { g + 100 })
      add_message(state, "Sランクボーナス: +100 星石")
    }
  }

  // 2. 翌日へ
  state.day.update(fn(d) { d + 1 })
  let current_max_ap = get_max_ap(state)
  state.ap.set(current_max_ap)
  state.today_actions.set([])
  state.daily_missions.set(create_daily_missions())

  // 3. パッシブ収入
  let passive_coins = grant_passive_income(state)
  if passive_coins > 0 {
    add_message(state, "定食屋パッシブ: +" + passive_coins.to_string() + "コイン")
  }

  // 4. ターン制リセット + ムード更新（学マス参考リデザイン）
  state.turn_number.set(0)
  state.combo_chain.set(0)
  state.last_card_category.set("")
  state.last_combo_bonus.set(
    { name: "", description: "", trust_bonus: 0, understanding_bonus: 0, empathy_bonus: 0 },
  )
  state.last_play_grade.set(@data.PlayGrade::Normal)
  update_daily_mood(state)

  // 5. 最初のターン選択肢をドロー（旧hand互換も維持）
  draw_turn_choices_for_state(state, 0)
  // 旧hand互換: 選択肢をhandにも入れる
  let initial_choices = state.turn_choices.get()
  state.hand.set(initial_choices.cards)

  // 6. デイスタートスナップショット
  snapshot_day_start(state)

  // 7. 週の開始ならスナップショット
  let new_day = state.day.get()
  if (new_day - 1) % 7 == 0 {
    snapshot_week_start(state)
  }

  // 季節・天候・ムード情報
  let new_season = @data.get_season(new_day)
  let new_weather = @data.get_weather(new_day)
  let day_in_season = @data.get_day_in_season(new_day)
  let mood = state.mood.get()
  let day_msg = @data.season_to_string(new_season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(new_weather) + @data.weather_to_string(new_weather) + " — " + mood_to_icon(mood) + mood_to_string(mood)
  add_message(state, day_msg)

  // 8. ログボ → Home
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

/// ミッション報酬を3軸に分配（スケーリング適用）
fn grant_mission_reward(state : GameState, mission_id : String, reward : Int) -> Unit {
  let scaled = reward * param_scale_percent / 100
  let effective = if scaled < 1 { 1 } else { scaled }
  match mission_id {
    "eat" => {
      state.empathy.update(fn(v) { v + effective * 6 / 10 })
      state.understanding.update(fn(v) { v + effective * 2 / 10 })
      state.trust.update(fn(v) { v + effective * 2 / 10 })
    }
    "talk" => {
      state.trust.update(fn(v) { v + effective * 6 / 10 })
      state.understanding.update(fn(v) { v + effective * 2 / 10 })
      state.empathy.update(fn(v) { v + effective * 2 / 10 })
    }
    _ => {
      state.trust.update(fn(v) { v + effective / 3 })
      state.understanding.update(fn(v) { v + effective / 3 })
      state.empathy.update(fn(v) { v + effective / 3 })
    }
  }
  sync_intimacy(state)
}

fn check_missions(state : GameState) -> Unit {
  let actions = state.today_actions.get()
  let mut had_eat = false
  let mut had_talk = false
  let action_count = actions.length()
  for a in actions {
    if a == "eat" {
      had_eat = true
    }
    if a == "talk" {
      had_talk = true
    }
  }

  state.daily_missions.update(fn(missions) {
    let result : Array[@data.DailyMission] = []
    for m in missions {
      if m.completed {
        result.push(m)
      } else if m.id == "eat" && had_eat {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
        grant_mission_coin_reward(state, m.id)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "talk" && had_talk {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
        grant_mission_coin_reward(state, m.id)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
      } else if m.id == "actions_3" && action_count >= 3 {
        result.push({ ..m, completed: true })
        grant_mission_reward(state, m.id, m.reward)
        grant_mission_coin_reward(state, m.id)
        add_message(state, "ミッション達成: " + m.description + " (+" + m.reward.to_string() + ")")
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
