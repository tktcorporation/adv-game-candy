// 週イベントシステム — 学マスのオーディションに対応
//
// 7日ごとに発生するチェックポイント。その週の獲得パラメータが
// 目標値を達成していれば成功。短期目標として機能する。
//
// 設計根拠:
// 学マスではプロデュース中にオーディションという明確なゴールがあり、
// 「あのオーディションに間に合わせるためにどのレッスンを受けるか」
// という逆算思考がゲームの面白さになる。
// 同様に、「今週の目標まであと信頼15…」という緊張感を作る。

/// 週番号を取得（day 1-7 = week 1, 8-14 = week 2, ...）
pub fn get_week_number(day : Int) -> Int {
  (day - 1) / 7 + 1
}

/// 今日が週の最終日（7日目）かどうか
pub fn is_week_end(day : Int) -> Bool {
  day % 7 == 0 && day > 0
}

/// 週番号に応じた週イベントを生成
///
/// 週が進むほど要求値が上がるが、カード育成やコンボで
/// 獲得量も増えるのでバランスが取れる。
/// 4週サイクルで信頼→理解→共感→バランスのローテーション。
pub fn get_weekly_event(week : Int) -> @data.WeeklyEvent {
  // 難易度スケーリング: 週が進むほど要求値が上がる
  let base = 5 + week * 2
  let cycle = week % 4

  match cycle {
    0 => {
      // 信頼重視の週
      {
        id: "week_" + week.to_string(),
        name: "信頼の週",
        description: "丸山との会話を深めよう。ひよりも聞いている。",
        required_trust: base + 5,
        required_understanding: base / 2,
        required_empathy: base / 2,
        reward_coins: 200 + week * 30,
        reward_gems: 20 + week * 5,
        success_text: "丸山が嬉しそうに笑った。「最近、よく来てくれるね」",
        fail_text: "今週は少し忙しかった。でも、灯はいつでも待っている。",
      }
    }
    1 => {
      // 理解重視の週
      {
        id: "week_" + week.to_string(),
        name: "理解の週",
        description: "ひよりのことをもっと知ろう。小さな変化に目を向けて。",
        required_trust: base / 2,
        required_understanding: base + 5,
        required_empathy: base / 2,
        reward_coins: 200 + week * 30,
        reward_gems: 20 + week * 5,
        success_text: "ひよりが読んでいた本のジャンルが変わった。何かあったのかもしれない。",
        fail_text: "今週は気づけなかったことがある。来週はもう少し注意深く。",
      }
    }
    2 => {
      // 共感重視の週
      {
        id: "week_" + week.to_string(),
        name: "共感の週",
        description: "同じものを食べ、同じ空気を吸う。それが共感の始まり。",
        required_trust: base / 2,
        required_understanding: base / 2,
        required_empathy: base + 5,
        reward_coins: 200 + week * 30,
        reward_gems: 20 + week * 5,
        success_text: "今日、初めてひよりと同じメニューを頼んだ。丸山がにやりと笑った。",
        fail_text: "今週はすれ違いが多かった。でも、食事の味は覚えている。",
      }
    }
    _ => {
      // バランス週（全軸均等）
      {
        id: "week_" + week.to_string(),
        name: "調和の週",
        description: "信頼も理解も共感も。バランスよく関係を育てよう。",
        required_trust: base,
        required_understanding: base,
        required_empathy: base,
        reward_coins: 300 + week * 40,
        reward_gems: 30 + week * 8,
        success_text: "灯に来ると落ち着く。ここが、自分の居場所になりつつある。",
        fail_text: "まだまだ道半ば。でも、少しずつ進んでいるのは確かだ。",
      }
    }
  }
}

/// 週イベントのチェック・判定（週末日に呼ばれる）
///
/// その週の獲得パラメータ（week_start_*との差分）で判定する。
pub fn check_weekly_event(state : GameState) -> Unit {
  let day = state.day.get()
  if !is_week_end(day) {
    return
  }

  let week = get_week_number(day)
  let event = get_weekly_event(week)

  // その週の獲得量を計算
  let trust_gained = state.trust.get() - state.week_start_trust.get()
  let understanding_gained = state.understanding.get() - state.week_start_understanding.get()
  let empathy_gained = state.empathy.get() - state.week_start_empathy.get()

  let passed = trust_gained >= event.required_trust &&
    understanding_gained >= event.required_understanding &&
    empathy_gained >= event.required_empathy

  // 結果を記録
  state.weekly_event_results.update(fn(results) {
    let new_results : Array[@data.WeeklyEventResult] = []
    for r in results {
      new_results.push(r)
    }
    new_results.push({
      event_id: event.id,
      week_number: week,
      passed,
      trust_achieved: trust_gained,
      understanding_achieved: understanding_gained,
      empathy_achieved: empathy_gained,
    })
    new_results
  })

  if passed {
    // 成功: 報酬付与
    state.coins.update(fn(c) { c + event.reward_coins })
    state.gems.update(fn(g) { g + event.reward_gems })
    state.today_coins_earned.update(fn(c) { c + event.reward_coins })
    state.today_gems_earned.update(fn(g) { g + event.reward_gems })
    state.today_scene_text.set(event.success_text)
    add_message(state, "週イベント「" + event.name + "」達成！ +" + event.reward_coins.to_string() + "コイン +" + event.reward_gems.to_string() + "星石")
  } else {
    // 失敗: 慰めテキストのみ
    state.today_scene_text.set(event.fail_text)
    add_message(state, "週イベント「" + event.name + "」未達成。来週また頑張ろう。")
  }
}

/// 週の開始パラメータをスナップショット
pub fn snapshot_week_start(state : GameState) -> Unit {
  state.week_start_trust.set(state.trust.get())
  state.week_start_understanding.set(state.understanding.get())
  state.week_start_empathy.set(state.empathy.get())
}

/// 今週の目標表示テキスト（ホーム画面用）
pub fn get_weekly_goal_display(state : GameState) -> String {
  let day = state.day.get()
  let week = get_week_number(day)
  let event = get_weekly_event(week)
  let days_left = 7 - ((day - 1) % 7)

  // 現在の週獲得量
  let trust_gained = state.trust.get() - state.week_start_trust.get()
  let understanding_gained = state.understanding.get() - state.week_start_understanding.get()
  let empathy_gained = state.empathy.get() - state.week_start_empathy.get()

  let trust_ok = if trust_gained >= event.required_trust { "✓" } else { "…" }
  let understanding_ok = if understanding_gained >= event.required_understanding { "✓" } else { "…" }
  let empathy_ok = if empathy_gained >= event.required_empathy { "✓" } else { "…" }

  event.name + " (あと" + days_left.to_string() + "日) " +
    trust_ok + "信" + trust_gained.to_string() + "/" + event.required_trust.to_string() + " " +
    understanding_ok + "理" + understanding_gained.to_string() + "/" + event.required_understanding.to_string() + " " +
    empathy_ok + "共" + empathy_gained.to_string() + "/" + event.required_empathy.to_string()
}
