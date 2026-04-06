// ゲームシミュレーター — バランス調整・全体感確認ツール
//
// 実際のゲームロジック（game パッケージ）を使い、
// N日間の自動プレイを複数戦略で実行してレポートを出力する。
//
// 実行方法:
//   moon build --target js --release
//   node ./_build/js/release/build/sim/sim.js
//
// 出力内容:
//   - 戦略別の進行速度（各★ランク到達日数、章解放日数）
//   - 通貨蓄積カーブ（日別コイン・ジェム残高）
//   - ガチャ統計（N回引いた場合の獲得カード数・被り率・天井発動率）
//   - カード強化の実現性（MAXまでの所要日数/ガチャ回数）
//   - パラメータ成長曲線（信頼/理解/共感の日別推移）
//   - AP効率（1APあたりの平均パラメータ獲得量）

///|
extern "js" fn js_log(msg : String) -> Unit =
  #| (s) => console.log(s)

fn log(msg : String) -> Unit {
  js_log(msg)
}

fn log_divider() -> Unit {
  log("════════════════════════════════════════════════════════════════")
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

/// プレイ戦略 — AIがどのカードを優先的に選ぶか
enum Strategy {
  Balanced    // 3軸均等に育てる
  TrustFocus  // 信頼（Talk系）優先
  EmpathyFocus // 共感（Eat系）優先
  UnderstandingFocus // 理解（Observe系）優先
  RarePriority // レアカード優先（高効果を追う）
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
// シミュレーション実行
// =========================================================================

/// 戦略に基づいてカードを選ぶ
///
/// 手札の中から戦略に合ったカードを1枚選んで返す。
/// APが足りない場合は None。
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

/// ガチャ戦略: コインが一定額貯まったらガチャを引く
fn maybe_do_gacha(state : @game.GameState, gacha_threshold : Int) -> Unit {
  // 10連分貯まったら10連
  if state.coins.get() >= @game.gacha_multi_cost && state.coins.get() >= gacha_threshold {
    @game.gacha_multi(state)
  }
}

/// 強化戦略: シャードが貯まったら最もよく使うカードを強化
fn maybe_enhance(state : @game.GameState) -> Unit {
  let shards = state.enhancement_shards.get()
  if shards < 2 {
    return
  }

  // 所持カードの中でレベルが低いものを優先的に強化
  let owned = state.owned_cards.get()
  let mut target_id = ""
  let mut target_level = 99

  for oc in owned {
    if oc.level < target_level && oc.level < @game.max_card_level {
      let cost = @game.get_enhance_cost(oc.level)
      match cost {
        Some(c) => {
          if shards >= c.shards && state.coins.get() >= c.coins {
            target_level = oc.level
            target_id = oc.card_id
          }
        }
        None => ()
      }
    }
  }

  if target_id != "" {
    @game.enhance_card(state, target_id)
  }
}

/// スナップショット — 特定日のステータスを記録
struct DaySnapshot {
  day : Int
  trust : Int
  understanding : Int
  empathy : Int
  intimacy : Int
  stars : Int
  coins : Int
  gems : Int
  shards : Int
  owned_cards : Int
  player_level : Int
  chapter : Int
}

fn take_snapshot(state : @game.GameState) -> DaySnapshot {
  {
    day: state.day.get(),
    trust: state.trust.get(),
    understanding: state.understanding.get(),
    empathy: state.empathy.get(),
    intimacy: state.intimacy.get(),
    stars: @game.get_intimacy_stars(state.intimacy.get()),
    coins: state.coins.get(),
    gems: state.gems.get(),
    shards: state.enhancement_shards.get(),
    owned_cards: state.owned_cards.get().length(),
    player_level: state.player_level.get(),
    chapter: state.current_chapter.get(),
  }
}

/// 1日分のシミュレーション（ストーリー自動スキップ）
fn simulate_one_day(state : @game.GameState, strategy : Strategy) -> Unit {
  // ストーリーフェーズなら自動スキップ
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  // ログインボーナスフェーズならクレーム
  if state.phase.get() == @data.GamePhase::LoginBonus {
    @game.claim_login_bonus(state)
  }

  // Home フェーズ: 灯に行く
  if state.phase.get() == @data.GamePhase::Home {
    @game.go_to_akari(state)
  }

  // ActionSelect: 手札からカードを選んでプレイ
  let mut action_count = 0
  while state.phase.get() == @data.GamePhase::ActionSelect {
    let card = choose_card(state, strategy)
    match card {
      Some(c) => {
        @game.play_card(state, c.id)
        action_count = action_count + 1
        // Scene → ActionSelect に戻る
        if state.phase.get() == @data.GamePhase::Scene {
          @game.finish_scene(state)
        }
        // ストーリー解放されたら自動スキップ
        while state.phase.get() == @data.GamePhase::Story {
          @game.advance_story(state)
        }
      }
      None => {
        // AP不足 → 帰る
        @game.leave_akari(state)
      }
    }
    // 無限ループ防止
    if action_count > 10 {
      @game.leave_akari(state)
      break
    }
  }

  // ガチャ・強化の自動実行
  maybe_do_gacha(state, 2700)
  maybe_enhance(state)

  // 次の日へ（DayResult → 実際の日送り）
  if state.phase.get() == @data.GamePhase::Home {
    // next_day は DayResult フェーズへ遷移するだけなので、
    // advance_to_next_day を直接呼ぶ
    @game.next_day(state)
    // DayResult をスキップ
    if state.phase.get() == @data.GamePhase::DayResult {
      @game.advance_to_next_day(state)
    }
    // ログボをスキップ
    if state.phase.get() == @data.GamePhase::LoginBonus {
      @game.claim_login_bonus(state)
    }
  }
}

/// N日間シミュレーション実行
fn run_simulation(
  strategy : Strategy,
  days : Int,
  snapshot_interval : Int
) -> Array[DaySnapshot] {
  let state = @game.create_game_state()

  // ゲーム開始（Title → Story(ch0) → Home）
  @game.start_game(state)
  // ch0 ストーリーを自動スキップ
  while state.phase.get() == @data.GamePhase::Story {
    @game.advance_story(state)
  }

  let snapshots : Array[DaySnapshot] = []
  snapshots.push(take_snapshot(state))

  for d in 0..<days {
    simulate_one_day(state, strategy)

    // スナップショット取得
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
  shards_total : Int
  rare_count : Int
  uncommon_count : Int
  normal_count : Int
  pity_triggers : Int
  coins_spent : Int
}

fn simulate_gacha_only(num_pulls : Int) -> GachaStats {
  let state = @game.create_game_state()
  @game.register_initial_cards(state)
  // ガチャ用にコインを大量付与
  state.coins.set(num_pulls * @game.gacha_single_cost + 100_000)

  let mut new_count = 0
  let mut dup_count = 0
  let mut rare_count = 0
  let mut uncommon_count = 0
  let mut normal_count = 0
  let mut pity_triggers = 0

  for _ in 0..<num_pulls {
    let pity_before = state.gacha_pity.get()
    @game.gacha_single(state)
    let results = state.gacha_results.get()
    for r in results {
      if r.is_new {
        new_count = new_count + 1
      } else {
        dup_count = dup_count + 1
      }
      match r.card.rarity {
        Rare => rare_count = rare_count + 1
        Uncommon => uncommon_count = uncommon_count + 1
        Normal => normal_count = normal_count + 1
      }
    }
    if pity_before >= @game.gacha_pity_threshold - 1 && state.gacha_pity.get() == 0 {
      pity_triggers = pity_triggers + 1
    }
  }

  {
    total_pulls: num_pulls,
    new_cards: new_count,
    duplicate_cards: dup_count,
    shards_total: state.enhancement_shards.get(),
    rare_count,
    uncommon_count,
    normal_count,
    pity_triggers,
    coins_spent: num_pulls * @game.gacha_single_cost,
  }
}

// =========================================================================
// レポート出力
// =========================================================================

fn pad_right(s : String, width : Int) -> String {
  let mut result = s
  // 日本語文字は幅2としてカウント（簡易）
  let mut display_len = 0
  // 簡易: 文字列長をそのまま使う（ASCII前提のカラム幅）
  display_len = s.to_array().length()
  while display_len < width {
    result = result + " "
    display_len = display_len + 1
  }
  result
}

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
  strategy_name : String,
  snapshots : Array[DaySnapshot]
) -> Unit {
  log("")
  log("  ◆ 戦略: " + strategy_name)
  log("  ┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬───────┬──────┐")
  log("  │  日  │ 信頼 │ 理解 │ 共感 │親密度│  ★  │コイン│ ジェム│ カード│  章  │")
  log("  ├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼───────┼──────┤")

  for snap in snapshots {
    let line = "  │" +
      pad_left(snap.day.to_string(), 5) + " │" +
      pad_left(snap.trust.to_string(), 5) + " │" +
      pad_left(snap.understanding.to_string(), 5) + " │" +
      pad_left(snap.empathy.to_string(), 5) + " │" +
      pad_left(snap.intimacy.to_string(), 5) + " │" +
      pad_left(snap.stars.to_string(), 5) + " │" +
      pad_left(snap.coins.to_string(), 5) + " │" +
      pad_left(snap.gems.to_string(), 5) + " │" +
      pad_left(snap.owned_cards.to_string(), 6) + " │" +
      pad_left(snap.chapter.to_string(), 5) + " │"
    log(line)
  }

  log("  └──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴───────┴──────┘")
}

fn print_milestone_analysis(snapshots : Array[DaySnapshot]) -> Unit {
  log("")
  log("  到達日数:")

  // ★ランク到達日
  let star_targets = [1, 2, 3, 4, 5]
  for target in star_targets {
    let mut reached_day = -1
    for snap in snapshots {
      if snap.stars >= target && reached_day == -1 {
        reached_day = snap.day
      }
    }
    let day_str = if reached_day >= 0 { reached_day.to_string() + "日目" } else { "未到達" }
    log("    ★" + target.to_string() + " 到達: " + day_str)
  }

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
  log("  ◆ ガチャ統計 (" + stats.total_pulls.to_string() + "回)")
  log("    新規カード:     " + stats.new_cards.to_string() + " 枚")
  log("    被りカード:     " + stats.duplicate_cards.to_string() + " 枚")
  log("    獲得シャード:   " + stats.shards_total.to_string())
  log("    Rare排出:       " + stats.rare_count.to_string() + " 枚 (" +
    (stats.rare_count * 100 / stats.total_pulls).to_string() + "%)")
  log("    Uncommon排出:   " + stats.uncommon_count.to_string() + " 枚 (" +
    (stats.uncommon_count * 100 / stats.total_pulls).to_string() + "%)")
  log("    Normal排出:     " + stats.normal_count.to_string() + " 枚 (" +
    (stats.normal_count * 100 / stats.total_pulls).to_string() + "%)")
  log("    天井発動:       " + stats.pity_triggers.to_string() + " 回")
  log("    消費コイン:     " + stats.coins_spent.to_string())
}

fn print_economy_analysis(snapshots : Array[DaySnapshot]) -> Unit {
  log("")
  log("  ◆ 経済分析:")

  if snapshots.length() < 2 {
    return
  }

  // 1日あたりの平均コイン獲得量を推定
  // （最終コイン残高は支出後なので、実際の獲得量は推定）
  let last = snapshots[snapshots.length() - 1]
  let first = snapshots[0]
  let total_days = last.day - first.day
  if total_days <= 0 {
    return
  }

  log("    最終日コイン残高:  " + last.coins.to_string())
  log("    最終日ジェム残高:  " + last.gems.to_string())
  log("    最終日シャード:    " + last.shards.to_string())
  log("    最終日所持カード:  " + last.owned_cards.to_string() + " 枚")
  log("    最終日Pレベル:     " + last.player_level.to_string())

  // 全カード数
  let total_cards = @data.get_all_cards().length()
  log("    全カード数:        " + total_cards.to_string() + " 枚")
  log("    収集率:            " + (last.owned_cards * 100 / total_cards).to_string() + "%")

  // ガチャ10連に必要な日数 (2700コイン / 日あたり推定収入)
  // 1日あたりの推定コイン収入:
  //   行動5回 × 平均20コイン = 100
  //   ミッション3種 = 50+30+100 = 180
  //   合計 ≈ 280コイン/日
  let estimated_daily_coins = 280
  let days_for_multi = @game.gacha_multi_cost / estimated_daily_coins
  log("")
  log("    推定日収(コイン):  ~" + estimated_daily_coins.to_string())
  log("    10連ガチャ到達:    ~" + days_for_multi.to_string() + " 日")

  // カード強化分析
  log("")
  log("  ◆ 強化コスト表:")
  log("    Lv1→2: シャード2 + 100コイン (倍率 1.0x → 1.2x)")
  log("    Lv2→3: シャード4 + 200コイン (倍率 1.2x → 1.4x)")
  log("    Lv3→4: シャード6 + 400コイン (倍率 1.4x → 1.7x)")
  log("    Lv4→5: シャード10 + 800コイン (倍率 1.7x → 2.0x)")
  log("    全強化: シャード22 + 1500コイン (≈ ガチャ5連分)")
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

  // 進行速度の評価
  log("")
  log("  【進行速度】")

  // 理想: 30日で★3、60日で★4、120日で★5
  let mut star3_day = -1
  let mut star4_day = -1
  let mut star5_day = -1
  for snap in snapshots {
    if snap.stars >= 3 && star3_day == -1 { star3_day = snap.day }
    if snap.stars >= 4 && star4_day == -1 { star4_day = snap.day }
    if snap.stars >= 5 && star5_day == -1 { star5_day = snap.day }
  }

  fn eval_speed(actual : Int, target : Int) -> String {
    if actual < 0 {
      "未到達"
    } else if actual < target * 7 / 10 {
      "速すぎ(目標" + target.to_string() + "日, 実際" + actual.to_string() + "日)"
    } else if actual > target * 15 / 10 {
      "遅すぎ(目標" + target.to_string() + "日, 実際" + actual.to_string() + "日)"
    } else {
      "適正(目標" + target.to_string() + "日, 実際" + actual.to_string() + "日)"
    }
  }

  log("    ★3: " + eval_speed(star3_day, 30))
  log("    ★4: " + eval_speed(star4_day, 60))
  log("    ★5: " + eval_speed(star5_day, 120))

  // 経済バランスの評価
  log("")
  log("  【経済バランス】")

  // 30日後のコイン残高で判定
  let mut day30_coins = -1
  for snap in snapshots {
    if snap.day >= 30 && day30_coins == -1 {
      day30_coins = snap.coins
    }
  }
  if day30_coins >= 0 {
    if day30_coins > 10000 {
      log("    30日目コイン: " + day30_coins.to_string() + " → インフレ気味。ガチャコスト引上げ or 報酬減額を検討")
    } else if day30_coins < 1000 {
      log("    30日目コイン: " + day30_coins.to_string() + " → 枯渇気味。報酬増額 or ガチャコスト引下げを検討")
    } else {
      log("    30日目コイン: " + day30_coins.to_string() + " → 適正範囲")
    }
  }

  // パラメータバランス
  log("")
  log("  【パラメータバランス】")
  let t = last.trust
  let u = last.understanding
  let e = last.empathy
  let total = t + u + e
  if total > 0 {
    log("    信頼: " + (t * 100 / total).to_string() + "% (" + t.to_string() + ")")
    log("    理解: " + (u * 100 / total).to_string() + "% (" + u.to_string() + ")")
    log("    共感: " + (e * 100 / total).to_string() + "% (" + e.to_string() + ")")
    let max_param = if t > u { if t > e { t } else { e } } else { if u > e { u } else { e } }
    let min_param = if t < u { if t < e { t } else { e } } else { if u < e { u } else { e } }
    if max_param > min_param * 3 {
      log("    → 偏りが大きい。バランス型の報酬設計を見直すべき")
    } else if max_param < min_param * 15 / 10 {
      log("    → バランス良好")
    } else {
      log("    → やや偏りあり（許容範囲）")
    }
  }

  log("")
  log("  シミュレーション完了: " + total_days.to_string() + "日間")
}

// =========================================================================
// メインエントリ
// =========================================================================

fn main {
  log_section("灯 — ゲームバランスシミュレーター v1.0")
  log("")
  log("  実際のゲームロジック（game パッケージ）を使用")
  log("  全カード: " + @data.get_all_cards().length().to_string() + "枚")
  log("  全思い出: " + @data.get_all_memories().length().to_string() + "個")
  log("  全チャプター: " + @data.get_chapters().length().to_string() + "章")

  let sim_days = 120  // 4シーズン = 120日
  let snapshot_interval = 5  // 5日ごとにスナップショット

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

  let gacha_counts = [10, 50, 100, 200]
  for count in gacha_counts {
    let stats = simulate_gacha_only(count)
    print_gacha_report(stats)
  }

  // ====== 総合バランス評価 ======
  // バランス型で評価
  let balanced_snapshots = run_simulation(Balanced, sim_days, snapshot_interval)
  print_balance_assessment(balanced_snapshots)

  log("")
  log_divider()
  log("  シミュレーション完了。上記の数値をもとにバランス調整を行ってください。")
  log_divider()
}
