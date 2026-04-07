// シミュレーションレポート出力 — 2層アーキテクチャ版

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

fn print_balance_assessment(snapshots : Array[DaySnapshot]) -> Unit {
  log("")
  log_section("バランス評価サマリー")

  if snapshots.length() < 2 {
    log("  データ不足")
    return
  }

  let last = snapshots[snapshots.length() - 1]
  let total_days = last.day

  // 灯訪問頻度
  log("")
  log("  【灯訪問頻度】")
  let visit_rate = if total_days > 0 { last.total_visits * 100 / total_days } else { 0 }
  log("    総訪問回数: " + last.total_visits.to_string() + "回 / " + total_days.to_string() + "日")
  log("    訪問率: " + visit_rate.to_string() + "%")
  log("    → 目標: 2-3日に1回来店 (33-50%)")

  // チャプター進行
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

  // 親密度進行
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

  // 3軸バランス
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

  log("")
  log("  シミュレーション完了: " + total_days.to_string() + "日間")
}
