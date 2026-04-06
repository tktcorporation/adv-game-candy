// ゲームシミュレーター v2.0 — ブルアカ参考リライト版
//
// 実際のゲームロジック（game パッケージ）を使い、
// N日間の自動プレイを複数戦略で実行してレポートを出力する。
//
// 検証項目:
// - プレイヤーレベル進行速度（メインストーリーのゲート）
// - 親密度レベル進行速度（上限なし、ボンドストーリーのゲート）
// - ジェム経済（ガチャ通貨として十分か）
// - コイン経済（カード強化に足りるか）
// - ガチャ統計（★3排出率、ソフト天井、スパーク到達）
// - カード育成（★ランクアップ/レベルアップの実現性）
// - パッシブ収入（定食屋カフェ効果）
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
  total_star_ranks : Int  // 全カードの★ランク合計
  total_card_levels : Int // 全カードのレベル合計
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
// 1日シミュレーション
// =========================================================================

fn simulate_one_day(state : @game.GameState, strategy : Strategy) -> Unit {
  // ストーリー自動スキップ
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  // ログボ
  if state.phase.get() == @data.GamePhase::LoginBonus {
    @game.claim_login_bonus(state)
  }

  // Home → 灯へ
  if state.phase.get() == @data.GamePhase::Home {
    @game.go_to_akari(state)
  }

  // カードプレイ
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

  // ガチャ・強化
  maybe_do_gacha(state)
  maybe_enhance(state)

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

/// N日間シミュレーション
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
// ガチャ統計シミュレーション
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
// レポート出力
// =========================================================================

fn pad_left(s : String, width : Int) -> String {
  let mut result = s
  let mut display_len = s.to_array().length()
  while display_len < width {
    result = " " + result
    display_len = display_len + 1
  }
  result
}

fn print_progression_report(
  sname : String,
  snapshots : Array[DaySnapshot]
) -> Unit {
  log("")
  log("  ◆ 戦略: " + sname)
  log("  ┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐")
  log("  │  日  │ 信頼 │ 理解 │ 共感 │親密Lv│ PLv  │コイン│ ジェム│ ｴﾘｸﾞﾏ│ カード│  章  │")
  log("  ├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤")

  for snap in snapshots {
    let line = "  │" +
      pad_left(snap.day.to_string(), 5) + " │" +
      pad_left(snap.trust.to_string(), 5) + " │" +
      pad_left(snap.understanding.to_string(), 5) + " │" +
      pad_left(snap.empathy.to_string(), 5) + " │" +
      pad_left(snap.affection_level.to_string(), 5) + " │" +
      pad_left(snap.player_level.to_string(), 5) + " │" +
      pad_left(snap.coins.to_string(), 5) + " │" +
      pad_left(snap.gems.to_string(), 5) + " │" +
      pad_left(snap.eligma.to_string(), 5) + " │" +
      pad_left(snap.owned_cards.to_string(), 5) + " │" +
      pad_left(snap.chapter.to_string(), 5) + " │"
    log(line)
  }

  log("  └──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘")
}

fn print_milestone_analysis(snapshots : Array[DaySnapshot]) -> Unit {
  log("")
  log("  到達日数:")

  // 親密度レベル到達日
  let aff_targets = [3, 5, 10, 15, 20, 30, 50]
  for target in aff_targets {
    let mut reached_day = -1
    for snap in snapshots {
      if snap.affection_level >= target && reached_day == -1 {
        reached_day = snap.day
      }
    }
    let day_str = if reached_day >= 0 { reached_day.to_string() + "日目" } else { "未到達" }
    log("    親密度Lv" + target.to_string() + " 到達: " + day_str)
  }

  log("")

  // プレイヤーレベル到達日
  let plv_targets = [5, 10, 15, 20, 25, 30, 35]
  for target in plv_targets {
    let mut reached_day = -1
    for snap in snapshots {
      if snap.player_level >= target && reached_day == -1 {
        reached_day = snap.day
      }
    }
    let day_str = if reached_day >= 0 { reached_day.to_string() + "日目" } else { "未到達" }
    log("    PLv" + target.to_string() + " 到達: " + day_str)
  }

  log("")

  // 章解放日
  for ch in [1, 2, 3, 4, 5, 6, 7, 8, 9] {
    let mut reached_day = -1
    for snap in snapshots {
      if snap.chapter >= ch && reached_day == -1 {
        reached_day = snap.day
      }
    }
    if reached_day >= 0 {
      log("    第" + ch.to_string() + "章 解放: " + reached_day.to_string() + "日目")
    }
  }
}

fn print_gacha_report(stats : GachaStats) -> Unit {
  log("")
  log("  ◆ ガチャ統計 (" + stats.total_pulls.to_string() + "連)")
  log("    新規カード:     " + stats.new_cards.to_string() + " 枚")
  log("    被りカード:     " + stats.duplicate_cards.to_string() + " 枚")
  log("    獲得エリグマ:   " + stats.eligma_total.to_string())
  log("    ★3排出:         " + stats.star3_count.to_string() + " 枚 (" +
    (stats.star3_count * 100 / stats.total_pulls).to_string() + "%)")
  log("    ★2排出:         " + stats.star2_count.to_string() + " 枚 (" +
    (stats.star2_count * 100 / stats.total_pulls).to_string() + "%)")
  log("    ★1排出:         " + stats.star1_count.to_string() + " 枚 (" +
    (stats.star1_count * 100 / stats.total_pulls).to_string() + "%)")
  log("    消費ジェム:     " + stats.gems_spent.to_string())
  let spark_str = if stats.spark_available { "到達" } else { "未到達" }
  log("    スパーク:       " + spark_str)
}

fn print_economy_analysis(snapshots : Array[DaySnapshot]) -> Unit {
  log("")
  log("  ◆ 経済分析:")

  if snapshots.length() < 2 {
    return
  }

  let last = snapshots[snapshots.length() - 1]

  log("    最終日コイン残高:    " + last.coins.to_string())
  log("    最終日ジェム残高:    " + last.gems.to_string())
  log("    最終日エリグマ:      " + last.eligma.to_string())
  log("    最終日所持カード:    " + last.owned_cards.to_string() + " 枚")
  log("    最終日PLv:           " + last.player_level.to_string())
  log("    最終日親密度Lv:      " + last.affection_level.to_string())
  log("    カード★合計:         " + last.total_star_ranks.to_string())
  log("    カードLv合計:        " + last.total_card_levels.to_string())

  let total_cards = @data.get_all_cards().length()
  log("    全カード数:          " + total_cards.to_string() + " 枚")
  log("    収集率:              " + (last.owned_cards * 100 / total_cards).to_string() + "%")

  // ジェム収入分析
  log("")
  log("  ◆ ジェム収入源（推定日収）:")
  log("    ログボ平均:     ~" + ((20 + 30 + 40 + 80) / 7).to_string() + " ジェム/日")
  log("    デイリーミッション: ~18 ジェム/日 (5+3+10)")
  log("    カードプレイ:   ~3 ジェム/日 (Rare/Uncommon時)")
  log("    合計推定:       ~45 ジェム/日")
  log("    10連到達:       ~" + (@game.gacha_multi_cost / 45).to_string() + " 日")
  log("    スパーク到達:   ~" + (@game.gacha_spark_threshold * @game.gacha_single_cost / 45).to_string() + " 日")

  // カード強化分析
  log("")
  log("  ◆ ★ランクアップコスト:")
  log("    ★1→★2: 10シャード + 1,000コイン")
  log("    ★2→★3: 30シャード + 3,000コイン")
  log("    ★3→★4: 100シャード + 10,000コイン")
  log("    ★4→★5: 300シャード + 30,000コイン")
  log("    合計: 440シャード + 44,000コイン")

  log("")
  log("  ◆ パッシブ収入（定食屋カフェ）:")
  log("    親密度Lv1:  15コイン/日")
  log("    親密度Lv10: 60コイン/日 + 1ジェム/日")
  log("    親密度Lv20: 110コイン/日 + 2ジェム/日")
  log("    親密度Lv50: 260コイン/日 + 5ジェム/日")
}

fn print_balance_assessment(snapshots : Array[DaySnapshot]) -> Unit {
  log("")
  log_section("バランス評価サマリー")

  if snapshots.length() < 2 {
    log("  データ不足")
    return
  }

  let last = snapshots[snapshots.length() - 1]
  let total_days = last.day

  // プレイヤーレベル進行速度
  log("")
  log("  【プレイヤーレベル進行】(メインストーリーのゲート)")

  let chapter_gates = [(2, "ch1"), (5, "ch2"), (8, "ch3"), (12, "ch4"), (16, "ch5"), (20, "ch6"), (25, "ch7"), (30, "ch8"), (35, "ch9")]
  for gate in chapter_gates {
    let (level, name) = gate
    let mut reached_day = -1
    for snap in snapshots {
      if snap.player_level >= level && reached_day == -1 {
        reached_day = snap.day
      }
    }
    let status = if reached_day >= 0 {
      name + "(PLv" + level.to_string() + "): " + reached_day.to_string() + "日目"
    } else {
      name + "(PLv" + level.to_string() + "): 未到達"
    }
    log("    " + status)
  }

  // 親密度進行速度
  log("")
  log("  【親密度レベル進行】(ボンドストーリー・カード解放)")
  let aff_goals = [(5, "カード解放1"), (10, "カード解放2"), (15, "カード解放3"), (20, "思い出★5相当"), (30, "長期目標")]
  for goal in aff_goals {
    let (level, desc) = goal
    let mut reached_day = -1
    for snap in snapshots {
      if snap.affection_level >= level && reached_day == -1 {
        reached_day = snap.day
      }
    }
    let day_str = if reached_day >= 0 { reached_day.to_string() + "日目" } else { "未到達" }
    log("    Lv" + level.to_string() + " (" + desc + "): " + day_str)
  }

  // 経済バランス
  log("")
  log("  【経済バランス】")

  let mut day30_coins = -1
  let mut day30_gems = -1
  for snap in snapshots {
    if snap.day >= 30 && day30_coins == -1 {
      day30_coins = snap.coins
      day30_gems = snap.gems
    }
  }
  if day30_coins >= 0 {
    log("    30日目コイン: " + day30_coins.to_string())
    log("    30日目ジェム: " + day30_gems.to_string())
    if day30_gems >= @game.gacha_multi_cost * 2 {
      log("    → ジェム余り過ぎ。ガチャコスト引上げ or 報酬減額を検討")
    } else if day30_gems < @game.gacha_single_cost {
      log("    → ジェム枯渇。報酬増額を検討")
    } else {
      log("    → ジェム適正範囲")
    }
  }

  // パラメータバランス
  log("")
  log("  【3軸バランス】")
  let t = last.trust
  let u = last.understanding
  let e = last.empathy
  let total = t + u + e
  if total > 0 {
    log("    信頼: " + (t * 100 / total).to_string() + "% (" + t.to_string() + ")")
    log("    理解: " + (u * 100 / total).to_string() + "% (" + u.to_string() + ")")
    log("    共感: " + (e * 100 / total).to_string() + "% (" + e.to_string() + ")")
  }

  // 分離の検証
  log("")
  log("  【設計検証: ユーザーランク/親密度分離】")
  log("    プレイヤーレベル（メインゲート）: " + last.player_level.to_string())
  log("    親密度レベル（サブシステム）:     " + last.affection_level.to_string())
  log("    → プレイヤーレベルは行動量に比例（詰まらない設計）")
  log("    → 親密度は3軸の質に依存（戦略性あり）")

  log("")
  log("  シミュレーション完了: " + total_days.to_string() + "日間")
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

  let sim_days = 180  // 6シーズン = 180日（長期検証）
  let snapshot_interval = 10  // 10日ごとにスナップショット

  // ====== 各戦略のシミュレーション ======
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

  // ====== ガチャ統計 ======
  log_section("ガチャ統計シミュレーション")

  let gacha_counts = [10, 50, 100, 200, 500]
  for count in gacha_counts {
    let stats = simulate_gacha_only(count)
    print_gacha_report(stats)
  }

  // ====== 総合バランス評価 ======
  let balanced_snapshots = run_simulation(Balanced, sim_days, snapshot_interval)
  print_balance_assessment(balanced_snapshots)

  log("")
  log_divider()
  log("  シミュレーション完了。")
  log("  プレイヤーランクと親密度が独立して進行することを確認してください。")
  log_divider()
}
