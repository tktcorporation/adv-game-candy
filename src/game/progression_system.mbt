// 進行システム — 通貨獲得・ログボ・デイリザルト・プレイヤーレベル
//
// ソシャゲのリテンション・成長実感を支える基盤ロジック。

// =========================================================================
// 通貨獲得
// =========================================================================

/// カードプレイ時のコイン報酬
///
/// レアリティに応じてコインを獲得:
///   Normal: 15, Uncommon: 25, Rare: 40
pub fn get_card_coin_reward(rarity : @data.CardRarity) -> Int {
  match rarity {
    Normal => 15
    Uncommon => 25
    Rare => 40
  }
}

/// カードプレイ時のEXP報酬
pub fn get_card_exp_reward(rarity : @data.CardRarity) -> Int {
  match rarity {
    Normal => 10
    Uncommon => 15
    Rare => 25
  }
}

/// ストーリー章クリア時の報酬を付与
///
/// コイン + 星石（ジェム）を章の進行度に応じて付与。
pub fn grant_chapter_reward(state : GameState, chapter_id : Int) -> Unit {
  let coin_reward = 300 + chapter_id * 50  // ch0: 300, ch1: 350, ...
  let gem_reward = 30 + chapter_id * 10    // ch0: 30, ch1: 40, ...
  state.coins.update(fn(c) { c + coin_reward })
  state.gems.update(fn(g) { g + gem_reward })
  state.today_coins_earned.update(fn(c) { c + coin_reward })
  add_message(
    state,
    "章クリア報酬: " + coin_reward.to_string() + "コイン + " + gem_reward.to_string() + "星石",
  )
}

/// カードプレイ時のコイン・EXP付与
///
/// play_card から呼ばれる。
pub fn grant_action_rewards(state : GameState, card : @data.ActionCard) -> Unit {
  let coins = get_card_coin_reward(card.rarity)
  let exp = get_card_exp_reward(card.rarity)
  state.coins.update(fn(c) { c + coins })
  state.today_coins_earned.update(fn(c) { c + coins })
  state.player_exp.update(fn(e) { e + exp })

  // レベルアップチェック
  check_level_up(state)
}

// =========================================================================
// プレイヤーレベル
// =========================================================================

/// レベルアップに必要なEXP
///
/// Lv1→2: 50, Lv2→3: 100, ... 段階的に増加
pub fn exp_for_next_level(current_level : Int) -> Int {
  50 + (current_level - 1) * 50
}

/// レベルアップチェック
///
/// EXPが閾値を超えていたらレベルアップ。
/// 超過分のEXPは次レベルに持ち越し。
fn check_level_up(state : GameState) -> Unit {
  let exp = state.player_exp.get()
  let level = state.player_level.get()
  let needed = exp_for_next_level(level)
  if exp >= needed {
    state.player_exp.update(fn(e) { e - needed })
    state.player_level.update(fn(l) { l + 1 })
    let new_level = level + 1
    add_message(state, "プレイヤーレベル " + new_level.to_string() + " に上昇！")

    // レベルアップ報酬: 100コイン + 10星石
    state.coins.update(fn(c) { c + 100 })
    state.gems.update(fn(g) { g + 10 })
    state.today_coins_earned.update(fn(c) { c + 100 })

    // 連鎖レベルアップチェック
    check_level_up(state)
  }
}

/// 現在のAP上限（レベルに応じて増加）
///
/// 基本5 + レベル5ごとに+1（最大8）
pub fn get_max_ap(state : GameState) -> Int {
  let level = state.player_level.get()
  let bonus = level / 5
  let result = max_ap + bonus
  if result > 8 { 8 } else { result }
}

// =========================================================================
// ログインボーナス
// =========================================================================

/// ログインボーナスの報酬テーブル（7日サイクル）
pub fn get_login_bonus_rewards() -> Array[@data.LoginBonusReward] {
  [
    { day: 1, reward_type: "coin", reward_amount: 100, description: "100 コイン" },
    { day: 2, reward_type: "coin", reward_amount: 200, description: "200 コイン" },
    { day: 3, reward_type: "shard", reward_amount: 2, description: "シャード ×2" },
    { day: 4, reward_type: "coin", reward_amount: 300, description: "300 コイン" },
    { day: 5, reward_type: "shard", reward_amount: 3, description: "シャード ×3" },
    { day: 6, reward_type: "coin", reward_amount: 500, description: "500 コイン" },
    { day: 7, reward_type: "gem", reward_amount: 50, description: "50 星石" },
  ]
}

/// ログインボーナスをチェック・付与
///
/// 新しい日に初めてHomeに来たときに呼ばれる。
/// 未受取なら LoginBonus フェーズに遷移して報酬表示。
pub fn check_login_bonus(state : GameState) -> Bool {
  let current_day = state.day.get()
  let last_day = state.last_login_bonus_day.get()

  if current_day <= last_day {
    return false  // 今日は既に受取済み
  }

  // ストリーク更新
  if current_day == last_day + 1 {
    // 連続ログイン
    let new_streak = state.login_streak.get() % 7 + 1
    state.login_streak.set(new_streak)
  } else {
    // 途切れた（または初回）→ Day1 にリセット
    state.login_streak.set(1)
  }

  state.last_login_bonus_day.set(current_day)
  true  // ログボあり
}

/// ログインボーナスの報酬を実際に付与する
///
/// LoginBonus 画面で「受け取る」を押したとき呼ばれる。
pub fn claim_login_bonus(state : GameState) -> Unit {
  let streak = state.login_streak.get()
  let rewards = get_login_bonus_rewards()

  for reward in rewards {
    if reward.day == streak {
      match reward.reward_type {
        "coin" => state.coins.update(fn(c) { c + reward.reward_amount })
        "gem" => state.gems.update(fn(g) { g + reward.reward_amount })
        "shard" => state.enhancement_shards.update(fn(s) { s + reward.reward_amount })
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
///
/// 「次の日へ」の前に呼ばれ、今日の成果をまとめる。
pub fn build_day_result(state : GameState) -> @data.DayResultData {
  let trust_gained = state.trust.get() - state.day_start_trust.get()
  let understanding_gained = state.understanding.get() - state.day_start_understanding.get()
  let empathy_gained = state.empathy.get() - state.day_start_empathy.get()
  let coins_earned = state.today_coins_earned.get()
  let cards_played = state.today_actions.get().length()

  // 今日獲得した思い出（メッセージログから判定は複雑なので、空リストで）
  let memories : Array[String] = []

  // ランクアップ判定
  let current_stars = get_intimacy_stars(state.intimacy.get())
  let start_intimacy = state.day_start_trust.get() + state.day_start_understanding.get() + state.day_start_empathy.get()
  let start_stars = get_intimacy_stars(start_intimacy)
  let rank_up = current_stars > start_stars

  // 季節の節目判定
  let current_day = state.day.get()
  let is_milestone = @data.is_season_milestone(current_day)
  let milestone_rank = if is_milestone {
    let rank = @data.evaluate_milestone_rank(
      state.trust.get(), state.understanding.get(), state.empathy.get(),
    )
    @data.rank_to_string(rank)
  } else {
    ""
  }

  {
    trust_gained,
    understanding_gained,
    empathy_gained,
    coins_earned,
    cards_played,
    memories_acquired: memories,
    rank_up,
    new_star: current_stars,
    season_milestone: is_milestone,
    milestone_rank,
  }
}

/// 1日の開始時パラメータを記録
///
/// デイリザルトの差分計算のため、日の始めに現在値を保存���
pub fn snapshot_day_start(state : GameState) -> Unit {
  state.day_start_trust.set(state.trust.get())
  state.day_start_understanding.set(state.understanding.get())
  state.day_start_empathy.set(state.empathy.get())
  state.today_coins_earned.set(0)
}

/// デイリザルト画面を閉じて次の日へ進む（実際のday進行はここで行う）
pub fn close_day_result(state : GameState) -> Unit {
  // ログボチェック（新しい日）
  if check_login_bonus(state) {
    state.phase.set(@data.GamePhase::LoginBonus)
  } else {
    state.phase.set(@data.GamePhase::Home)
  }
}

// =========================================================================
// ミッション報酬（通貨版）
// =========================================================================

/// ミッション報酬にコインを含める
///
/// 従来の親密度報酬に加えて、コイン報酬も付与。
pub fn grant_mission_coin_reward(state : GameState, mission_id : String) -> Unit {
  let coins = match mission_id {
    "eat" => 50
    "talk" => 30
    "actions_3" => 100
    _ => 20
  }
  state.coins.update(fn(c) { c + coins })
  state.today_coins_earned.update(fn(c) { c + coins })
}
