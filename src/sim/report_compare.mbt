// シミュレーションレポート — 戦略比較 + 灯ポイント経済分析

/// 全戦略の最終結果比較テーブル
fn print_strategy_comparison(all_results : Array[(String, SimResult)]) -> Unit {
  log("")
  log_section("戦略比較サマリー")
  log("")

  // ヘッダー
  log("  ┌──────────────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐")
  log("  │    戦略      │ 信頼 │ 理解 │ 共感 │ 合計 │親密Lv│ 訪問 │  章  │ S率  │ バフ率│")
  log("  ├──────────────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤")

  for entry in all_results {
    let (name, result) = entry
    let snaps = result.snapshots
    let stats = result.stats
    if snaps.length() == 0 { continue }
    let last = snaps[snaps.length() - 1]
    let total = last.trust + last.understanding + last.empathy
    let total_challenges = stats.challenge_s_count + stats.challenge_a_count + stats.challenge_b_count + stats.challenge_c_count
    let s_rate = if total_challenges > 0 { stats.challenge_s_count * 100 / total_challenges } else { 0 }
    let buff_rate = if stats.buff_grant_count > 0 { stats.buff_consume_count * 100 / stats.buff_grant_count } else { 0 }

    // 名前を8文字に調整（日本語は幅2として計算）
    let padded_name = pad_right(name, 12)
    let line = "  │" + padded_name + "  │" +
      pad_left(last.trust.to_string(), 5) + " │" +
      pad_left(last.understanding.to_string(), 5) + " │" +
      pad_left(last.empathy.to_string(), 5) + " │" +
      pad_left(total.to_string(), 5) + " │" +
      pad_left(last.affection_level.to_string(), 5) + " │" +
      pad_left(last.total_visits.to_string(), 5) + " │" +
      pad_left(last.chapter.to_string(), 5) + " │" +
      pad_left(s_rate.to_string() + "%", 5) + " │" +
      pad_left(buff_rate.to_string() + "%", 5) + " │"
    log(line)
  }

  log("  └──────────────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘")

  // 分析コメント
  log("")
  log("  【分析】")

  // 最高パラメータ戦略を見つける
  let mut best_total = 0
  let mut best_total_name = ""
  let mut best_visits = 0
  let mut best_visits_name = ""
  let mut best_s_rate = 0
  let mut best_s_name = ""

  for entry in all_results {
    let (name, result) = entry
    let snaps = result.snapshots
    let stats = result.stats
    if snaps.length() == 0 { continue }
    let last = snaps[snaps.length() - 1]
    let total = last.trust + last.understanding + last.empathy
    if total > best_total { best_total = total; best_total_name = name }
    if last.total_visits > best_visits { best_visits = last.total_visits; best_visits_name = name }
    let total_c = stats.challenge_s_count + stats.challenge_a_count + stats.challenge_b_count + stats.challenge_c_count
    let sr = if total_c > 0 { stats.challenge_s_count * 100 / total_c } else { 0 }
    if sr > best_s_rate { best_s_rate = sr; best_s_name = name }
  }

  log("    パラメータ最高: " + best_total_name + " (" + best_total.to_string() + ")")
  log("    訪問回数最多: " + best_visits_name + " (" + best_visits.to_string() + "回)")
  log("    S率最高: " + best_s_name + " (" + best_s_rate.to_string() + "%)")
}

/// 灯ポイント経済分析（全戦略）
fn print_economy_analysis(all_results : Array[(String, SimResult)]) -> Unit {
  log("")
  log_section("灯ポイント経済分析")
  log("")
  log("  灯P収入源の内訳（120日間）:")
  log("")

  // ヘッダー
  log("  ┌──────────────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐")
  log("  │    戦略      │ 行動 │ ﾐｯｼｮﾝ│ 週ﾁｬﾚ│ ﾛｸﾞﾎﾞ│ 章ｸﾘｱ│ 総収入│ 訪問消費│")
  log("  ├──────────────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤")

  for entry in all_results {
    let (name, result) = entry
    let s = result.stats
    let total_income = s.akari_from_actions + s.akari_from_missions + s.akari_from_challenges + s.akari_from_login + s.akari_from_chapters

    let padded_name = pad_right(name, 12)
    let line = "  │" + padded_name + "  │" +
      pad_left(s.akari_from_actions.to_string(), 5) + " │" +
      pad_left(s.akari_from_missions.to_string(), 5) + " │" +
      pad_left(s.akari_from_challenges.to_string(), 5) + " │" +
      pad_left(s.akari_from_login.to_string(), 5) + " │" +
      pad_left(s.akari_from_chapters.to_string(), 5) + " │" +
      pad_left(total_income.to_string(), 5) + " │" +
      pad_left(s.akari_spent_on_visits.to_string(), 5) + "  │"
    log(line)
  }

  log("  └──────────────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘")

  // 経済バランス分析
  log("")
  log("  【経済バランス判定】")

  for entry in all_results {
    let (name, result) = entry
    let s = result.stats
    let total_income = s.akari_from_actions + s.akari_from_missions + s.akari_from_challenges + s.akari_from_login + s.akari_from_chapters
    let surplus = total_income - s.akari_spent_on_visits
    let daily_income = if total_income > 0 { total_income * 10 / 120 } else { 0 }
    let visit_interval = if s.akari_spent_on_visits > 0 {
      let visits = s.akari_spent_on_visits / @game.visit_cost
      if visits > 0 { 120 / visits } else { 999 }
    } else { 999 }

    let balance_str = if surplus > 50 { "余剰(灯P溜まりすぎ)" } else if surplus > 0 { "適正" } else { "不足(訪問できない)" }
    log("    " + name + ": 日平均" + daily_income.to_string() + ".x灯P/日, " + visit_interval.to_string() + "日に1回来店, " + balance_str)
  }

  log("")
  log("  → 目標: 2-3日に1回来店 = 日平均3.3-5.0灯P/日")
}
