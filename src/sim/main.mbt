// ゲームシミュレーター — 2層アーキテクチャ版 v2
//
// N日間の自動プレイを複数戦略で実行し、詳細レポートを出力する。
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
// シミュレーション戦略（6種）
// =========================================================================

enum Strategy {
  Balanced       // バランス型: 3軸を均等に
  TrustFocus     // 信頼特化: 信頼系カードを優先
  EmpathyFocus   // 共感特化: 共感系カードを優先
  BuffOptimal    // バフ最適: バフ積み→消費の掛け算を最大化
  StoryRush      // ストーリー急行: 灯ポイント獲得を最優先
  WeeklySRank    // S狙い: 週チャレンジS判定に向けて3軸バランス
}

fn strategy_name(s : Strategy) -> String {
  match s {
    Balanced => "バランス型"
    TrustFocus => "信頼特化型"
    EmpathyFocus => "共感特化型"
    BuffOptimal => "バフ最適型"
    StoryRush => "ストーリー急行型"
    WeeklySRank => "週S狙い型"
  }
}

// =========================================================================
// カード選択AI（戦略に応じたスコアリング）
// =========================================================================

/// カード選択AI
///
/// 旧版: 単純なスコア線形比較のみ。
/// v2: バフスタック数、スタミナ残量、週の進行状況を考慮。
/// バフ消費カードはバフがある時のみ高スコア、
/// スタミナが残り少ない時は低コストカードを優先。
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

    let score = score_card(state, card, strategy, stamina)

    if score > best_score {
      best_score = score
      best = Some(card)
    }
  }

  best
}

/// カードスコア計算（戦略ごとの重み付け）
///
/// スコア設計の根拠:
/// - base_score: カードの素の強さ（3軸合計）
/// - バフ消費可能な場合: 1.5倍分の追加得点 + 灯ポイントボーナス
/// - バフ付与カード: 将来の掛け算のため少し加点
/// - スタミナ効率: 残り少ない時は低コストを優先
fn score_card(
  state : @game.GameState,
  card : @data.ActionCard,
  strategy : Strategy,
  stamina : Int
) -> Int {
  let base = card.trust_gain + card.understanding_gain + card.empathy_gain

  // バフ消費可能チェック
  let has_buff = if card.consumes_buff != "" {
    @game.get_buff_count(state, card.consumes_buff) > 0
  } else {
    false
  }

  // スタミナ効率ボーナス（残り少ない時に低コスト優先）
  let stamina_bonus = if stamina <= 2 && card.stamina_cost == 1 { 3 } else { 0 }

  match strategy {
    Balanced => {
      let buff_score = if has_buff { base / 2 } else if card.grants_buff != "" { 3 } else { 0 }
      base + buff_score + stamina_bonus
    }
    TrustFocus => {
      let axis_score = card.trust_gain * 3 + card.understanding_gain + card.empathy_gain
      let buff_score = if has_buff && card.consumes_buff == "courage" { axis_score / 2 } else if card.grants_buff == "courage" { 5 } else { 0 }
      axis_score + buff_score + stamina_bonus
    }
    EmpathyFocus => {
      let axis_score = card.empathy_gain * 3 + card.trust_gain + card.understanding_gain
      let buff_score = if has_buff && card.consumes_buff == "comfort" { axis_score / 2 } else if card.grants_buff == "comfort" { 5 } else { 0 }
      axis_score + buff_score + stamina_bonus
    }
    BuffOptimal => {
      // バフ消費で倍率が乗る時は最優先
      if has_buff {
        base * 3 + 10
      } else if card.grants_buff != "" {
        // バフを積む（バフがまだ無い or スタック数少ない時は高評価）
        let current = @game.get_buff_count(state, card.grants_buff)
        base + (3 - current) * 4 + stamina_bonus
      } else {
        base + stamina_bonus
      }
    }
    StoryRush => {
      // 灯ポイント獲得効率を最大化
      // バフ消費時 +3灯P、通常 +1灯P。バフ消費優先。
      if has_buff {
        30 + base  // 3灯Pのため最優先
      } else if card.grants_buff != "" {
        15 + base  // 将来のバフ消費のため
      } else {
        base + stamina_bonus
      }
    }
    WeeklySRank => {
      // 3軸のうち最も低い軸を優先的に上げる
      let t = state.trust.get() - state.week_start_trust.get()
      let u = state.understanding.get() - state.week_start_understanding.get()
      let e = state.empathy.get() - state.week_start_empathy.get()
      let min_axis = if t <= u && t <= e { "trust" } else if u <= e { "understanding" } else { "empathy" }

      let axis_bonus = match min_axis {
        "trust" => card.trust_gain * 3
        "understanding" => card.understanding_gain * 3
        _ => card.empathy_gain * 3
      }
      let buff_score = if has_buff { base / 2 + 5 } else if card.grants_buff != "" { 3 } else { 0 }
      axis_bonus + base + buff_score + stamina_bonus
    }
  }
}

// =========================================================================
// メインエントリ
// =========================================================================

fn main {
  log_section("灯 — ゲームバランスシミュレーター v4.0 (2層アーキテクチャ)")
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
  let snapshot_interval = 7  // 週単位でスナップショット

  let strategies : Array[Strategy] = [
    Balanced, TrustFocus, EmpathyFocus, BuffOptimal, StoryRush, WeeklySRank,
  ]

  // --- 全戦略シミュレーション実行 ---
  let all_results : Array[(String, SimResult)] = []
  for strategy in strategies {
    let name = strategy_name(strategy)
    let result = run_simulation(strategy, sim_days, snapshot_interval)
    all_results.push((name, result))
  }

  // --- レポート出力 ---
  log_section("戦略別 " + sim_days.to_string() + "日間シミュレーション")

  for entry in all_results {
    let (name, result) = entry
    print_progression_report(name, result.snapshots)
  }

  // 全戦略比較サマリー
  print_strategy_comparison(all_results)

  // バランス型の詳細分析
  for entry in all_results {
    let (name, result) = entry
    if name == "バランス型" {
      print_detailed_analysis(result)
      break
    }
  }

  // 全戦略の灯ポイント経済分析
  print_economy_analysis(all_results)

  log("")
  log_divider()
  log("  シミュレーション完了。")
  log("  Layer1(日常)とLayer2(灯訪問)の分離を確認してください。")
  log_divider()
}
