// 週チャレンジシステム — Layer 1 のクライマックス
//
// 7日ごとに発生。その週の育成成果で S/A/B/C ランク判定。
// 学マスの中間/最終試験に対応。ストーリーとは独立して毎週遊べる。

/// 週番号を取得（1始まり）
pub fn get_week_number(day : Int) -> Int {
  (day - 1) / 7 + 1
}

/// その日が週末（7日目）かどうか
pub fn is_week_end(day : Int) -> Bool {
  day > 1 && (day - 1) % 7 == 6
}

/// 週チャレンジの判定
pub fn check_weekly_challenge(state : GameState) -> Unit {
  let day = state.day.get()
  if !is_week_end(day) {
    return
  }

  let week = get_week_number(day)
  let trust_gained = state.trust.get() - state.week_start_trust.get()
  let understanding_gained = state.understanding.get() - state.week_start_understanding.get()
  let empathy_gained = state.empathy.get() - state.week_start_empathy.get()

  let rank = evaluate_challenge_rank(trust_gained, understanding_gained, empathy_gained, week)
  let rank_str = challenge_rank_to_string(rank)

  // 灯ポイント報酬（ランクに応じて）
  let akari_reward = match rank {
    @data.ChallengeRank::S => 15
    @data.ChallengeRank::A => 10
    @data.ChallengeRank::B => 5
    @data.ChallengeRank::C => 2
  }

  state.akari_points.update(fn(p) { p + akari_reward })

  // コイン報酬
  let coin_reward = match rank {
    @data.ChallengeRank::S => 200
    @data.ChallengeRank::A => 100
    @data.ChallengeRank::B => 50
    @data.ChallengeRank::C => 20
  }
  state.coins.update(fn(c) { c + coin_reward })
  state.today_coins_earned.update(fn(c) { c + coin_reward })

  // 結果記録
  state.challenge_results.update(fn(results) {
    let new_results : Array[@data.ChallengeResult] = []
    for r in results {
      new_results.push(r)
    }
    new_results.push({
      week_number: week,
      rank,
      trust_gained,
      understanding_gained,
      empathy_gained,
      akari_points_earned: akari_reward,
    })
    new_results
  })

  // スタミナmod（学マスの試験合否に対応する緊張感）
  // Week 1-2 は免除（チュートリアル期間）
  if week >= 3 {
    let stamina_mod = match rank {
      @data.ChallengeRank::S => 1     // 翌週スタミナ+1: 好調ボーナス
      @data.ChallengeRank::A => 0
      @data.ChallengeRank::B => 0
      @data.ChallengeRank::C => -1    // 翌週スタミナ-1: 疲労ペナルティ
    }
    state.next_week_stamina_mod.set(stamina_mod)
  }

  let mut msg = "週末チャレンジ: " + rank_str + "ランク！ +" + akari_reward.to_string() + "灯P +" + coin_reward.to_string() + "コイン"
  if week >= 3 {
    match rank {
      @data.ChallengeRank::S =>
        msg = msg + " ★来週の余裕+1！"
      @data.ChallengeRank::C =>
        msg = msg + " …来週の余裕-1"
      _ => ()
    }
  }
  add_message(state, msg)
}

/// チャレンジランク判定
///
/// 週が進むにつれて要求値が上がる（成長を実感できる設計）。
fn evaluate_challenge_rank(
  trust : Int,
  understanding : Int,
  empathy : Int,
  week : Int
) -> @data.ChallengeRank {
  // 週に応じた基準値（序盤は緩め、後半はきつめ）
  let base = 10 + week * 3
  let total = trust + understanding + empathy

  // S: 3軸すべてバランスよく高い
  if trust >= base && understanding >= base && empathy >= base {
    @data.ChallengeRank::S
  } else if total >= base * 3 - 10 {
    @data.ChallengeRank::A
  } else if total >= base * 2 {
    @data.ChallengeRank::B
  } else {
    @data.ChallengeRank::C
  }
}

/// チャレンジランクの文字列表示
pub fn challenge_rank_to_string(rank : @data.ChallengeRank) -> String {
  match rank {
    S => "S"
    A => "A"
    B => "B"
    C => "C"
  }
}

/// 週の開始時パラメータを記録
pub fn snapshot_week_start(state : GameState) -> Unit {
  state.week_start_day.set(state.day.get())
  state.week_start_trust.set(state.trust.get())
  state.week_start_understanding.set(state.understanding.get())
  state.week_start_empathy.set(state.empathy.get())
}

/// 週チャレンジ目標のヘッダー行（「第1週 試験まで4日」）
pub fn get_exam_header(state : GameState) -> String {
  let day = state.day.get()
  let week = get_week_number(day)
  let days_in_week = (day - 1) % 7 + 1
  let days_left = 7 - days_in_week
  "第" + week.to_string() + "週 試験まで" + days_left.to_string() + "日"
}

/// Sランク目標値（その週の基準値）
pub fn get_exam_s_line(state : GameState) -> Int {
  let week = get_week_number(state.day.get())
  10 + week * 3
}

/// 今週の各軸獲得量を取得
pub fn get_weekly_gains(state : GameState) -> (Int, Int, Int) {
  let t = state.trust.get() - state.week_start_trust.get()
  let u = state.understanding.get() - state.week_start_understanding.get()
  let e = state.empathy.get() - state.week_start_empathy.get()
  (t, u, e)
}

/// 3軸ゲージ1行分を生成（DailyAction画面のSライン表示用）
///
/// 例: 「信頼  ████████░░░░░  12/13」
/// 目標達成時: 「信頼  █████████████  13/13 ▲」
pub fn build_axis_gauge(label : String, current : Int, target : Int) -> String {
  let width = 13
  let filled = if target > 0 {
    let f = current * width / target
    if f > width { width } else { f }
  } else {
    0
  }
  let mut bar = ""
  for i in 0..<width {
    if i < filled {
      bar = bar + "█"
    } else {
      bar = bar + "░"
    }
  }
  let status = if current >= target { " ▲" } else { "" }
  label + " " + bar + " " + current.to_string() + "/" + target.to_string() + status
}

/// Home画面用: 不足分表示テキスト（「信▲OK 理△-5 共△-6」）
pub fn get_exam_diff_display(state : GameState) -> String {
  let s_line = get_exam_s_line(state)
  let (t, u, e) = get_weekly_gains(state)
  fn diff_text(label : String, current : Int, target : Int) -> String {
    if current >= target {
      label + "▲OK"
    } else {
      label + "△-" + (target - current).to_string()
    }
  }
  diff_text("信", t, s_line) + " " + diff_text("理", u, s_line) + " " + diff_text("共", e, s_line)
}
