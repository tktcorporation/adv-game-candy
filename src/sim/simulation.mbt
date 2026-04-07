// シミュレーション実行 — 1日サイクル + N日ループ

// =========================================================================
// 1日シミュレーション
// =========================================================================

/// 1日を完全シミュレーション（統計も収集）
///
/// フロー: Story自動送り → ログインボーナス → 日常行動(Layer1) →
///         灯訪問(Layer2) → 日送り(DayResult → advance_to_next_day)
fn simulate_one_day(
  state : @game.GameState,
  strategy : Strategy,
  stats : MutStats
) -> Unit {
  // ストーリー自動送り
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  // ログインボーナス
  if state.phase.get() == @data.GamePhase::LoginBonus {
    let akari_before = state.akari_points.get()
    @game.claim_login_bonus(state)
    let akari_after = state.akari_points.get()
    stats.akari_from_login = stats.akari_from_login + (akari_after - akari_before)
  }

  // 日常行動（Layer 1）
  if state.phase.get() == @data.GamePhase::Home {
    @game.go_to_daily_action(state)
  }

  stats.missions_total = stats.missions_total + 3  // 1日3ミッション

  let mut action_count = 0
  while state.phase.get() == @data.GamePhase::DailyAction {
    let card = choose_card(state, strategy)
    match card {
      Some(c) => {
        let has_buff = if c.consumes_buff != "" {
          @game.get_buff_count(state, c.consumes_buff) > 0
        } else {
          false
        }

        let akari_before = state.akari_points.get()
        let missions_before = count_completed_missions(state)

        @game.play_daily_action(state, c.id)
        stats.total_card_plays = stats.total_card_plays + 1
        record_card_play(stats, c.id)
        action_count = action_count + 1

        // バフ付与/消費の追跡
        if c.grants_buff != "" {
          stats.buff_grant_count = stats.buff_grant_count + 1
        }
        if c.consumes_buff != "" {
          if has_buff {
            stats.buff_consume_count = stats.buff_consume_count + 1
          } else {
            stats.buff_miss_count = stats.buff_miss_count + 1
          }
        }

        // 灯ポイント（行動由来 vs ミッション由来）
        let akari_after = state.akari_points.get()
        let missions_after = count_completed_missions(state)
        let akari_diff = akari_after - akari_before
        let new_missions = missions_after - missions_before

        if new_missions > 0 {
          stats.missions_completed = stats.missions_completed + new_missions
          let mission_akari = estimate_mission_akari(
            new_missions, action_count, has_buff,
          )
          stats.akari_from_missions = stats.akari_from_missions + mission_akari
          stats.akari_from_actions = stats.akari_from_actions + (akari_diff - mission_akari)
        } else {
          stats.akari_from_actions = stats.akari_from_actions + akari_diff
        }

        if state.phase.get() == @data.GamePhase::DailyScene {
          // finish_daily_scene はスタミナ0で next_day を呼んでしまうので、
          // シミュレーターでは手動で Home に戻す。
          // 日送りは灯訪問の後にシミュレーター側で行う。
          if state.stamina.get() <= 0 {
            state.phase.set(@data.GamePhase::Home)
            break
          } else {
            @game.finish_daily_scene(state)
          }
        }
      }
      None => {
        @game.leave_daily_action(state)
      }
    }
    if action_count > 10 {
      @game.leave_daily_action(state)
      break
    }
  }

  // 灯訪問（Layer 2 — 戦略に応じた判断）
  let should_visit = should_visit_akari(state, strategy)
  if state.phase.get() == @data.GamePhase::Home && should_visit {
    let chapter_before = state.current_chapter.get()
    stats.akari_spent_on_visits = stats.akari_spent_on_visits + @game.visit_cost
    @game.go_to_visit(state)
    if state.phase.get() == @data.GamePhase::Visit {
      // ストーリー解放チェック（UIでは「ストーリーを読む」ボタンに対応）
      let current = state.current_chapter.get()
      let chapters = @data.get_chapters()
      let visits = state.total_visits.get()
      if current + 1 < chapters.length() {
        let next = chapters[current + 1]
        if visits >= next.unlock_visit_count {
          state.current_chapter.set(current + 1)
          state.scene_index.set(0)
          state.line_index.set(0)
          state.phase.set(@data.GamePhase::Story)
        }
      }
      while state.phase.get() == @data.GamePhase::Story {
        @game.advance_story(state)
      }
      if state.phase.get() == @data.GamePhase::Visit {
        @game.leave_visit(state)
      }
    }
    let chapter_after = state.current_chapter.get()
    if chapter_after > chapter_before {
      let akari_reward = 5 + chapter_before * 2
      stats.akari_from_chapters = stats.akari_from_chapters + akari_reward
    }
  }

  // 次の日
  if state.phase.get() == @data.GamePhase::Home {
    let akari_before = state.akari_points.get()
    @game.next_day(state)

    if state.phase.get() == @data.GamePhase::DayResult {
      let result = state.day_result.get()
      match result.challenge_result {
        "S" => stats.challenge_s_count = stats.challenge_s_count + 1
        "A" => stats.challenge_a_count = stats.challenge_a_count + 1
        "B" => stats.challenge_b_count = stats.challenge_b_count + 1
        "C" => stats.challenge_c_count = stats.challenge_c_count + 1
        _ => ()
      }
      let akari_after = state.akari_points.get()
      let challenge_akari = akari_after - akari_before
      if challenge_akari > 0 {
        stats.akari_from_challenges = stats.akari_from_challenges + challenge_akari
      }

      @game.advance_to_next_day(state)
    }
    if state.phase.get() == @data.GamePhase::LoginBonus {
      let akari_b = state.akari_points.get()
      @game.claim_login_bonus(state)
      let akari_a = state.akari_points.get()
      stats.akari_from_login = stats.akari_from_login + (akari_a - akari_b)
    }
  }
}

// =========================================================================
// 訪問判断ロジック（戦略依存）
// =========================================================================

/// 灯に行くかどうかの判断（戦略に応じて変わる）
///
/// StoryRush: 灯ポイントが貯まったら即座に行く。
/// WeeklySRank: 週の前半は行かず、後半に余裕があれば行く。
/// 他: 灯ポイントが十分なら行く。
fn should_visit_akari(state : @game.GameState, strategy : Strategy) -> Bool {
  let points = state.akari_points.get()
  if points < @game.visit_cost {
    return false
  }
  match strategy {
    StoryRush => true
    WeeklySRank => {
      let day_in_week = (state.day.get() - 1) % 7
      day_in_week >= 4 || points >= @game.visit_cost * 2
    }
    _ => true
  }
}

// =========================================================================
// N日シミュレーション
// =========================================================================

fn run_simulation(
  strategy : Strategy,
  days : Int,
  snapshot_interval : Int
) -> SimResult {
  let state = @game.create_game_state()
  let stats = new_mut_stats()

  @game.start_game(state)
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  let snapshots : Array[DaySnapshot] = []
  snapshots.push(take_snapshot(state))

  for d in 0..<days {
    simulate_one_day(state, strategy, stats)
    if (d + 1) % snapshot_interval == 0 || d == days - 1 {
      snapshots.push(take_snapshot(state))
    }
    ignore(d)
  }

  { snapshots, stats: freeze_stats(stats) }
}
