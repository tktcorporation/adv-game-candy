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

  add_message(state, "週末チャレンジ: " + rank_str + "ランク！ +" + akari_reward.to_string() + "灯P +" + coin_reward.to_string() + "コイン")
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

/// 週チャレンジ目標の表示テキスト
pub fn get_weekly_goal_display(state : GameState) -> String {
  let day = state.day.get()
  let week = get_week_number(day)
  let days_in_week = (day - 1) % 7 + 1
  let days_left = 7 - days_in_week

  let trust_gained = state.trust.get() - state.week_start_trust.get()
  let understanding_gained = state.understanding.get() - state.week_start_understanding.get()
  let empathy_gained = state.empathy.get() - state.week_start_empathy.get()

  let base = 10 + week * 3
  "第" + week.to_string() + "週（残り" + days_left.to_string() + "日）S目標: 各" + base.to_string() + " / 現在 信" + trust_gained.to_string() + " 理" + understanding_gained.to_string() + " 共" + empathy_gained.to_string()
}
