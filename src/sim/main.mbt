// ゲームシミュレーター v2.0 — ブルアカ参考リライト版
//
// 実際のゲームロジック（game パッケージ）を使い、
// N日間の自動プレイを複数戦略で実行してレポートを出力する。
//
// ファイル構成:
//   main.mbt   — シミュレーション本体・戦略・メインエントリ
//   report.mbt — レポート出力関数群
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
  UnderstandingFocus
  RarePriority
}

fn strategy_name(s : Strategy) -> String {
  match s {
    Balanced => "バランス型"
    TrustFocus => "信頼特化型"
    EmpathyFocus => "共感特化型"
    UnderstandingFocus => "理解特化型"
    RarePriority => "レア優先型"
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
  let ap = state.ap.get()

  let mut best : @data.ActionCard? = None
  let mut best_score = -1

  for card in hand {
    if ap < card.ap_cost {
      continue
    }

    let score = match strategy {
      Balanced => card.trust_gain + card.understanding_gain + card.empathy_gain
      TrustFocus => card.trust_gain * 3 + card.understanding_gain + card.empathy_gain
      EmpathyFocus => card.empathy_gain * 3 + card.trust_gain + card.understanding_gain
      UnderstandingFocus => card.understanding_gain * 3 + card.trust_gain + card.empathy_gain
      RarePriority => {
        let rarity_bonus = match card.rarity {
          Normal => 0
          Uncommon => 10
          Rare => 30
        }
        card.trust_gain + card.understanding_gain + card.empathy_gain + rarity_bonus
      }
    }

    if score > best_score {
      best_score = score
      best = Some(card)
    }
  }

  best
}

/// ガチャ戦略: ジェムが10連分貯まったらガチャ
fn maybe_do_gacha(state : @game.GameState) -> Unit {
  if state.gems.get() >= @game.gacha_multi_cost {
    @game.gacha_multi(state)
  }
}

/// 強化戦略: コインが余っていたらレベルアップ、シャードが貯まったら★アップ
fn maybe_enhance(state : @game.GameState) -> Unit {
  let owned = state.owned_cards.get()
  let coins = state.coins.get()

  // まず★ランクアップを試みる（コスパが高いため）
  for oc in owned {
    if oc.star_rank < @game.max_star_rank {
      let cost = @game.get_star_up_cost(oc.star_rank)
      match cost {
        Some(c) => {
          if oc.shards >= c.shards && coins >= c.coins {
            @game.star_up_card(state, oc.card_id)
            return
          }
        }
        None => ()
      }
    }
  }

  // 次にレベルアップ（コインに余裕がある場合のみ）
  if coins > 500 {
    for oc in owned {
      let max_lv = @game.get_card_max_level(oc.star_rank, state.player_level.get())
      if oc.level < max_lv {
        let cost = @game.get_level_up_cost(oc.level)
        if coins >= cost.coins + 300 {  // 300コイン余裕を持つ
          @game.level_up_card(state, oc.card_id)
          return
        }
      }
    }
  }
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
  player_level : Int
  coins : Int
  gems : Int
  eligma : Int
  owned_cards : Int
  chapter : Int
  total_star_ranks : Int
  total_card_levels : Int
}

fn take_snapshot(state : @game.GameState) -> DaySnapshot {
  let owned = state.owned_cards.get()
  let mut total_stars = 0
  let mut total_levels = 0
  for oc in owned {
    total_stars = total_stars + oc.star_rank
    total_levels = total_levels + oc.level
  }

  {
    day: state.day.get(),
    trust: state.trust.get(),
    understanding: state.understanding.get(),
    empathy: state.empathy.get(),
    intimacy: state.intimacy.get(),
    affection_level: @game.get_affection_level(state.intimacy.get()),
    player_level: state.player_level.get(),
    coins: state.coins.get(),
    gems: state.gems.get(),
    eligma: state.eligma.get(),
    owned_cards: owned.length(),
    chapter: state.current_chapter.get(),
    total_star_ranks: total_stars,
    total_card_levels: total_levels,
  }
}

// =========================================================================
// ガチャ統計
// =========================================================================

struct GachaStats {
  total_pulls : Int
  new_cards : Int
  duplicate_cards : Int
  eligma_total : Int
  star3_count : Int
  star2_count : Int
  star1_count : Int
  gems_spent : Int
  spark_available : Bool
}

fn simulate_gacha_only(num_pulls : Int) -> GachaStats {
  let state = @game.create_game_state()
  @game.register_initial_cards(state)
  state.gems.set(num_pulls * @game.gacha_single_cost + 100_000)

  let mut new_count = 0
  let mut dup_count = 0
  let mut star3_count = 0
  let mut star2_count = 0
  let mut star1_count = 0

  for _ in 0..<num_pulls {
    @game.gacha_single(state)
    let results = state.gacha_results.get()
    for r in results {
      if r.is_new {
        new_count = new_count + 1
      } else {
        dup_count = dup_count + 1
      }
      match r.card.rarity {
        Rare => star3_count = star3_count + 1
        Uncommon => star2_count = star2_count + 1
        Normal => star1_count = star1_count + 1
      }
    }
  }

  {
    total_pulls: num_pulls,
    new_cards: new_count,
    duplicate_cards: dup_count,
    eligma_total: state.eligma.get(),
    star3_count,
    star2_count,
    star1_count,
    gems_spent: num_pulls * @game.gacha_single_cost,
    spark_available: state.gacha_spark_available.get(),
  }
}

// =========================================================================
// 1日・N日シミュレーション
// =========================================================================

fn simulate_one_day(state : @game.GameState, strategy : Strategy) -> Unit {
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  if state.phase.get() == @data.GamePhase::LoginBonus {
    @game.claim_login_bonus(state)
  }

  if state.phase.get() == @data.GamePhase::Home {
    @game.go_to_akari(state)
  }

  let mut action_count = 0
  while state.phase.get() == @data.GamePhase::ActionSelect {
    let card = choose_card(state, strategy)
    match card {
      Some(c) => {
        @game.play_card(state, c.id)
        action_count = action_count + 1
        if state.phase.get() == @data.GamePhase::Scene {
          @game.finish_scene(state)
        }
        while state.phase.get() == @data.GamePhase::Story {
          @game.advance_story(state)
        }
      }
      None => {
        @game.leave_akari(state)
      }
    }
    if action_count > 10 {
      @game.leave_akari(state)
      break
    }
  }

  maybe_do_gacha(state)
  maybe_enhance(state)

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
  log_section("灯 — ゲームバランスシミュレーター v2.0 (ブルアカ参考リライト)")
  log("")
  log("  設計変更:")
  log("    - プレイヤーランクでメインストーリーをゲート（親密度ではない）")
  log("    - 親密度は上限なし（旧★1-5を廃止）")
  log("    - ガチャ通貨をジェムに変更（120/単発、1200/10連）")
  log("    - 200連スパーク（任意★3選択）")
  log("    - カード育成: ★ランク(1-5) + レベル(1-N)の2軸")
  log("    - 定食屋パッシブ収入（ブルアカのカフェ相当）")
  log("")
  log("  全カード: " + @data.get_all_cards().length().to_string() + "枚")
  log("  全思い出: " + @data.get_all_memories().length().to_string() + "個")
  log("  全チャプター: " + @data.get_chapters().length().to_string() + "章")

  let sim_days = 180
  let snapshot_interval = 10

  log_section("戦略別 " + sim_days.to_string() + "日間シミュレーション")

  let strategies : Array[Strategy] = [
    Balanced, TrustFocus, EmpathyFocus, UnderstandingFocus, RarePriority,
  ]

  for strategy in strategies {
    let name = strategy_name(strategy)
    let snapshots = run_simulation(strategy, sim_days, snapshot_interval)
    print_progression_report(name, snapshots)
    print_milestone_analysis(snapshots)
    print_economy_analysis(snapshots)
  }

  log_section("ガチャ統計シミュレーション")

  let gacha_counts = [10, 50, 100, 200, 500]
  for count in gacha_counts {
    let stats = simulate_gacha_only(count)
    print_gacha_report(stats)
  }

  let balanced_snapshots = run_simulation(Balanced, sim_days, snapshot_interval)
  print_balance_assessment(balanced_snapshots)

  log("")
  log_divider()
  log("  シミュレーション完了。")
  log("  プレイヤーランクと親密度が独立して進行することを確認してください。")
  log_divider()
}
