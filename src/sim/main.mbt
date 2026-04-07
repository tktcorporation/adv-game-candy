// ゲームシミュレーター — 2層アーキテクチャ版
//
// N日間の自動プレイを複数戦略で実行してレポートを出力する。
//
// 実行方法:
//   moon build --target js --release
//   node ./_build/js/release/build/sim/sim.js

///|
extern "js" fn js_log(msg : String) -> Unit =
  #| (s) => console.log(s)

fn log(msg : String) -> Unit {
  js_log(msg)
}

fn log_divider() -> Unit {
  log("════════════════════════════════════════════════════════════════════════")
}

fn log_section(title : String) -> Unit {
  log("")
  log_divider()
  log("  " + title)
  log_divider()
}

// =========================================================================
// シミュレーション戦略
// =========================================================================

enum Strategy {
  Balanced
  TrustFocus
  EmpathyFocus
  BuffOptimal
}

fn strategy_name(s : Strategy) -> String {
  match s {
    Balanced => "バランス型"
    TrustFocus => "信頼特化型"
    EmpathyFocus => "共感特化型"
    BuffOptimal => "バフ最適型"
  }
}

// =========================================================================
// カード選択AI
// =========================================================================

fn choose_card(
  state : @game.GameState,
  strategy : Strategy
) -> @data.ActionCard? {
  let hand = state.hand.get()
  let stamina = state.stamina.get()

  let mut best : @data.ActionCard? = None
  let mut best_score = -1

  for card in hand {
    if stamina < card.stamina_cost {
      continue
    }

    let base_score = card.trust_gain + card.understanding_gain + card.empathy_gain

    let score = match strategy {
      Balanced => base_score
      TrustFocus => card.trust_gain * 3 + card.understanding_gain + card.empathy_gain
      EmpathyFocus => card.empathy_gain * 3 + card.trust_gain + card.understanding_gain
      BuffOptimal => {
        // バフ消費カードでバフがあれば高スコア
        let has_buff = if card.consumes_buff != "" {
          @game.get_buff_count(state, card.consumes_buff) > 0
        } else {
          false
        }
        if has_buff {
          base_score * 2  // バフ消費で倍率が乗るので優先
        } else if card.grants_buff != "" {
          base_score + 5  // バフ付与も少し優先
        } else {
          base_score
        }
      }
    }

    if score > best_score {
      best_score = score
      best = Some(card)
    }
  }

  best
}

// =========================================================================
// スナップショット
// =========================================================================

struct DaySnapshot {
  day : Int
  trust : Int
  understanding : Int
  empathy : Int
  intimacy : Int
  affection_level : Int
  akari_points : Int
  coins : Int
  total_visits : Int
  deck_size : Int
  chapter : Int
  stamina : Int
}

fn take_snapshot(state : @game.GameState) -> DaySnapshot {
  {
    day: state.day.get(),
    trust: state.trust.get(),
    understanding: state.understanding.get(),
    empathy: state.empathy.get(),
    intimacy: state.intimacy.get(),
    affection_level: @game.get_affection_level(state.intimacy.get()),
    akari_points: state.akari_points.get(),
    coins: state.coins.get(),
    total_visits: state.total_visits.get(),
    deck_size: state.deck.get().card_ids.length(),
    chapter: state.current_chapter.get(),
    stamina: state.stamina.get(),
  }
}

// =========================================================================
// 1日・N日シミュレーション
// =========================================================================

fn simulate_one_day(state : @game.GameState, strategy : Strategy) -> Unit {
  // ストーリー自動送り
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  // ログインボーナス
  if state.phase.get() == @data.GamePhase::LoginBonus {
    @game.claim_login_bonus(state)
  }

  // 日常行動（Layer 1）
  if state.phase.get() == @data.GamePhase::Home {
    @game.go_to_daily_action(state)
  }

  let mut action_count = 0
  while state.phase.get() == @data.GamePhase::DailyAction {
    let card = choose_card(state, strategy)
    match card {
      Some(c) => {
        @game.play_daily_action(state, c.id)
        action_count = action_count + 1
        if state.phase.get() == @data.GamePhase::DailyScene {
          @game.finish_daily_scene(state)
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

  // 灯訪問（Layer 2 — ポイント足りたら）
  if state.phase.get() == @data.GamePhase::Home && state.akari_points.get() >= @game.visit_cost {
    @game.go_to_visit(state)
    // 訪問後にストーリーが解放されてたら読む
    if state.phase.get() == @data.GamePhase::Visit {
      @game.leave_visit(state)
    }
    while state.phase.get() == @data.GamePhase::Story {
      @game.advance_story(state)
    }
  }

  // 次の日
  if state.phase.get() == @data.GamePhase::Home {
    @game.next_day(state)
    if state.phase.get() == @data.GamePhase::DayResult {
      @game.advance_to_next_day(state)
    }
    if state.phase.get() == @data.GamePhase::LoginBonus {
      @game.claim_login_bonus(state)
    }
  }
}

fn run_simulation(
  strategy : Strategy,
  days : Int,
  snapshot_interval : Int
) -> Array[DaySnapshot] {
  let state = @game.create_game_state()

  @game.start_game(state)
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  let snapshots : Array[DaySnapshot] = []
  snapshots.push(take_snapshot(state))

  for d in 0..<days {
    simulate_one_day(state, strategy)
    if (d + 1) % snapshot_interval == 0 || d == days - 1 {
      snapshots.push(take_snapshot(state))
    }
    ignore(d)
  }

  snapshots
}

// =========================================================================
// メインエントリ
// =========================================================================

fn main {
  log_section("灯 — ゲームバランスシミュレーター v3.0 (2層アーキテクチャ)")
  log("")
  log("  設計:")
  log("    - Layer 1: ひよりの日常（バフ積み→消費の掛け算）")
  log("    - Layer 2: 灯でご飯（灯ポイント消費でストーリー報酬）")
  log("    - 週チャレンジ: 7日ごとのクライマックス")
  log("")
  log("  全カード: " + @data.get_all_cards().length().to_string() + "枚")
  log("  全思い出: " + @data.get_all_memories().length().to_string() + "個")
  log("  全チャプター: " + @data.get_chapters().length().to_string() + "章")

  let sim_days = 120
  let snapshot_interval = 10

  log_section("戦略別 " + sim_days.to_string() + "日間シミュレーション")

  let strategies : Array[Strategy] = [
    Balanced, TrustFocus, EmpathyFocus, BuffOptimal,
  ]

  for strategy in strategies {
    let name = strategy_name(strategy)
    let snapshots = run_simulation(strategy, sim_days, snapshot_interval)
    print_progression_report(name, snapshots)
  }

  let balanced_snapshots = run_simulation(Balanced, sim_days, snapshot_interval)
  print_balance_assessment(balanced_snapshots)

  log("")
  log_divider()
  log("  シミュレーション完了。")
  log("  Layer1(日常)とLayer2(灯訪問)の分離を確認してください。")
  log_divider()
}
