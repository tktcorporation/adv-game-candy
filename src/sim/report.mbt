// シミュレーションレポート出力
//
// テーブル形式の進行レポート、マイルストーン到達分析、
// ガチャ統計、経済分析、バランス評価サマリーを出力する。

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
