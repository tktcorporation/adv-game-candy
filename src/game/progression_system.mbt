// 進行システム — 2層アーキテクチャ版
//
// 旧システムからの変更:
// - プレイヤーレベル/EXP削除 → 灯訪問回数がストーリーゲート
// - ジェム通貨削除 → 灯ポイント（ゲーム内で完結）
// - パッシブ収入削除 → デイリーミッションが灯ポイント源

// =========================================================================
// 章クリア報酬
// =========================================================================

/// ストーリー章クリア時の報酬
pub fn grant_chapter_reward(state : GameState, chapter_id : Int) -> Unit {
  let coin_reward = 200 + chapter_id * 50
  let akari_reward = 5 + chapter_id * 2
  state.coins.update(fn(c) { c + coin_reward })
  state.akari_points.update(fn(p) { p + akari_reward })
  state.today_coins_earned.update(fn(c) { c + coin_reward })
  add_message(
    state,
    "章クリア報酬: " + coin_reward.to_string() + "コイン + " + akari_reward.to_string() + "灯P",
  )
}

// =========================================================================
// ログインボーナス
// =========================================================================

/// ログインボーナスの報酬テーブル（7日サイクル）
pub fn get_login_bonus_rewards() -> Array[@data.LoginBonusReward] {
  [
    { day: 1, reward_type: "coin", reward_amount: 100, description: "100 コイン" },
    { day: 2, reward_type: "akari_point", reward_amount: 3, description: "3 灯ポイント" },
    { day: 3, reward_type: "coin", reward_amount: 200, description: "200 コイン" },
    { day: 4, reward_type: "akari_point", reward_amount: 5, description: "5 灯ポイント" },
    { day: 5, reward_type: "coin", reward_amount: 300, description: "300 コイン" },
    { day: 6, reward_type: "akari_point", reward_amount: 5, description: "5 灯ポイント" },
    { day: 7, reward_type: "akari_point", reward_amount: 10, description: "10 灯ポイント" },
  ]
}

/// ログインボーナスチェック
pub fn check_login_bonus(state : GameState) -> Bool {
  let current_day = state.day.get()
  let last_day = state.last_login_bonus_day.get()

  if current_day <= last_day {
    return false
  }

  if current_day == last_day + 1 {
    let new_streak = state.login_streak.get() % 7 + 1
    state.login_streak.set(new_streak)
  } else {
    state.login_streak.set(1)
  }

  state.last_login_bonus_day.set(current_day)
  true
}

/// ログインボーナス報酬を付与
pub fn claim_login_bonus(state : GameState) -> Unit {
  let streak = state.login_streak.get()
  let rewards = get_login_bonus_rewards()

  for reward in rewards {
    if reward.day == streak {
      match reward.reward_type {
        "coin" => {
          state.coins.update(fn(c) { c + reward.reward_amount })
          state.today_coins_earned.update(fn(c) { c + reward.reward_amount })
        }
        "akari_point" => {
          state.akari_points.update(fn(p) { p + reward.reward_amount })
        }
        _ => ()
      }
      add_message(state, "ログインボーナス: " + reward.description)
      break
    }
  }

  state.phase.set(@data.GamePhase::Home)
}

// =========================================================================
// デイリザルト
// =========================================================================

/// デイリザルトデータを生成
pub fn build_day_result(state : GameState) -> @data.DayResultData {
  let trust_gained = state.trust.get() - state.day_start_trust.get()
  let understanding_gained = state.understanding.get() - state.day_start_understanding.get()
  let empathy_gained = state.empathy.get() - state.day_start_empathy.get()
  let coins_earned = state.today_coins_earned.get()
  let actions_taken = state.today_actions.get().length()

  let memories : Array[String] = []

  // 週チャレンジ判定
  let day = state.day.get()
  let challenge_result = if is_week_end(day) {
    let week = get_week_number(day)
    let t = state.trust.get() - state.week_start_trust.get()
    let u = state.understanding.get() - state.week_start_understanding.get()
    let e = state.empathy.get() - state.week_start_empathy.get()
    let rank = evaluate_challenge_rank(t, u, e, week)
    challenge_rank_to_string(rank)
  } else {
    ""
  }

  // 灯ポイント集計（ミッション + チャレンジ + 行動 で今日獲得した分は近似）
  let akari_earned = state.akari_points.get()  // 近似表示

  {
    trust_gained,
    understanding_gained,
    empathy_gained,
    akari_points_earned: akari_earned,
    coins_earned,
    actions_taken,
    memories_acquired: memories,
    challenge_result,
    stamina_remaining: state.stamina.get(),
  }
}

/// 1日の開始時パラメータを記録
pub fn snapshot_day_start(state : GameState) -> Unit {
  state.day_start_trust.set(state.trust.get())
  state.day_start_understanding.set(state.understanding.get())
  state.day_start_empathy.set(state.empathy.get())
  state.today_coins_earned.set(0)
}

/// デイリザルト画面を閉じる
pub fn close_day_result(state : GameState) -> Unit {
  if check_login_bonus(state) {
    state.phase.set(@data.GamePhase::LoginBonus)
  } else {
    state.phase.set(@data.GamePhase::Home)
  }
}
