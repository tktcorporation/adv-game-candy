// シミュレーションレポート出力 — 進行テーブル + バランス評価

fn pad_left(s : String, width : Int) -> String {
  let mut result = s
  let mut display_len = s.to_array().length()
  while display_len < width {
    result = " " + result
    display_len = display_len + 1
  }
  result
}

fn pad_right(s : String, width : Int) -> String {
  let mut result = s
  let mut display_len = s.to_array().length()
  while display_len < width {
    result = result + " "
    display_len = display_len + 1
  }
  result
}

/// 進行テーブル（週単位スナップショット）
fn print_progression_report(
  sname : String,
  snapshots : Array[DaySnapshot]
) -> Unit {
  log("")
  log("  ◆ 戦略: " + sname)
  log("  ┌──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┬──────┐")
  log("  │  日  │ 信頼 │ 理解 │ 共感 │親密Lv│ 灯P  │コイン│ 訪問 │  章  │")
  log("  ├──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┼──────┤")

  for snap in snapshots {
    let line = "  │" +
      pad_left(snap.day.to_string(), 5) + " │" +
      pad_left(snap.trust.to_string(), 5) + " │" +
      pad_left(snap.understanding.to_string(), 5) + " │" +
      pad_left(snap.empathy.to_string(), 5) + " │" +
      pad_left(snap.affection_level.to_string(), 5) + " │" +
      pad_left(snap.akari_points.to_string(), 5) + " │" +
      pad_left(snap.coins.to_string(), 5) + " │" +
      pad_left(snap.total_visits.to_string(), 5) + " │" +
      pad_left(snap.chapter.to_string(), 5) + " │"
    log(line)
  }

  log("  └──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┴──────┘")
}

/// バランス評価サマリー
fn print_detailed_analysis(result : SimResult) -> Unit {
  let snapshots = result.snapshots
  let stats = result.stats
  log("")
  log_section("バランス型 詳細分析")

  if snapshots.length() < 2 {
    log("  データ不足")
    return
  }

  let last = snapshots[snapshots.length() - 1]
  let total_days = last.day

  // --- 灯訪問頻度 ---
  log("")
  log("  【灯訪問頻度】")
  let visit_rate = if total_days > 0 { last.total_visits * 100 / total_days } else { 0 }
  log("    総訪問回数: " + last.total_visits.to_string() + "回 / " + total_days.to_string() + "日")
  log("    訪問率: " + visit_rate.to_string() + "%")
  log("    → 目標: 2-3日に1回来店 (33-50%)")

  // --- ストーリー進行 ---
  log("")
  log("  【ストーリー進行】(灯訪問回数でゲート)")
  let chapter_gates = [(1, "ch1"), (2, "ch2"), (3, "ch3"), (5, "ch4"), (6, "ch5"), (8, "ch6"), (10, "ch7"), (13, "ch8"), (16, "ch9")]
  for gate in chapter_gates {
    let (visits_needed, name) = gate
    let mut reached_day = -1
    for snap in snapshots {
      if snap.total_visits >= visits_needed && reached_day == -1 {
        reached_day = snap.day
      }
    }
    let status = if reached_day >= 0 {
      name + "(来店" + visits_needed.to_string() + "回): " + reached_day.to_string() + "日目"
    } else {
      name + "(来店" + visits_needed.to_string() + "回): 未到達"
    }
    log("    " + status)
  }

  // --- 親密度レベル進行 ---
  log("")
  log("  【親密度レベル進行】")
  let aff_goals = [(3, "顔見知り"), (5, "醤油差し距離"), (10, "名前を知る"), (15, "隣の席"), (20, "二人の場所")]
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

  // --- 3軸バランス ---
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

  // --- バフシステム効率 ---
  log("")
  log("  【バフシステム効率】")
  log("    バフ付与: " + stats.buff_grant_count.to_string() + "回")
  log("    バフ消費(成功): " + stats.buff_consume_count.to_string() + "回")
  log("    バフ消費(空振り): " + stats.buff_miss_count.to_string() + "回")
  let consume_rate = if stats.buff_grant_count > 0 {
    stats.buff_consume_count * 100 / stats.buff_grant_count
  } else { 0 }
  log("    消費/付与率: " + consume_rate.to_string() + "% → 目標: 60-80%")

  // --- ミッション達成率 ---
  log("")
  log("  【デイリーミッション】")
  let mission_rate = if stats.missions_total > 0 {
    stats.missions_completed * 100 / stats.missions_total
  } else { 0 }
  log("    達成: " + stats.missions_completed.to_string() + "/" + stats.missions_total.to_string() + " (" + mission_rate.to_string() + "%)")

  // --- 週チャレンジ結果 ---
  log("")
  log("  【週チャレンジ推移】")
  let total_challenges = stats.challenge_s_count + stats.challenge_a_count + stats.challenge_b_count + stats.challenge_c_count
  log("    S: " + stats.challenge_s_count.to_string() + "  A: " + stats.challenge_a_count.to_string() + "  B: " + stats.challenge_b_count.to_string() + "  C: " + stats.challenge_c_count.to_string() + "  (計" + total_challenges.to_string() + "週)")

  // --- カード使用頻度 ---
  log("")
  log("  【カード使用頻度 TOP5】")
  let top = if stats.card_play_counts.length() > 5 { 5 } else { stats.card_play_counts.length() }
  for i in 0..<top {
    let (card_id, count) = stats.card_play_counts[i]
    let name = match @data.get_card_by_id(card_id) {
      Some(c) => c.name
      None => card_id
    }
    let pct = if stats.total_card_plays > 0 { count * 100 / stats.total_card_plays } else { 0 }
    log("    " + (i + 1).to_string() + ". " + name + ": " + count.to_string() + "回 (" + pct.to_string() + "%)")
  }

  log("")
  log("  シミュレーション完了: " + total_days.to_string() + "日間")
}
