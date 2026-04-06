// 進行システム — ブルアカ参考リライト
//
// プレイヤーランク（指揮官レベル相当）: メインストーリーのゲート。行動すれば必ず上がる。
// 親密度レベル（絆レベル相当）: キャラ別、上限なし。ボンドストーリー・カード解放。
//
// 設計根拠:
// ユーザーランクと親密度を分離することで、キャラが少なくてもストーリーが詰まらない。
// プレイヤーレベルは行動の「量」で上がり、親密度は行動の「質」で上がる。

// =========================================================================
// 通貨獲得
// =========================================================================

/// カードプレイ時のコイン報酬
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

/// カードプレイ時のジェム報酬（Rare以上で少量）
pub fn get_card_gem_reward(rarity : @data.CardRarity) -> Int {
  match rarity {
    Normal => 0
    Uncommon => 1
    Rare => 3
  }
}

/// ストーリー章クリア時の報酬
///
/// コイン + ジェム を章の進行度に応じて付与。
pub fn grant_chapter_reward(state : GameState, chapter_id : Int) -> Unit {
  let coin_reward = 300 + chapter_id * 50
  let gem_reward = 50 + chapter_id * 20   // ジェム増量（ガチャ通貨なので）
  state.coins.update(fn(c) { c + coin_reward })
  state.gems.update(fn(g) { g + gem_reward })
  state.today_coins_earned.update(fn(c) { c + coin_reward })
  state.today_gems_earned.update(fn(g) { g + gem_reward })
  add_message(
    state,
    "章クリア報酬: " + coin_reward.to_string() + "コイン + " + gem_reward.to_string() + "星石",
  )
}

/// カードプレイ時のコイン・ジェム・EXP付与
pub fn grant_action_rewards(state : GameState, card : @data.ActionCard) -> Unit {
  let coins = get_card_coin_reward(card.rarity)
  let gems = get_card_gem_reward(card.rarity)
  let exp = get_card_exp_reward(card.rarity)
  state.coins.update(fn(c) { c + coins })
  state.today_coins_earned.update(fn(c) { c + coins })
  if gems > 0 {
    state.gems.update(fn(g) { g + gems })
    state.today_gems_earned.update(fn(g) { g + gems })
  }
  state.player_exp.update(fn(e) { e + exp })

  check_level_up(state)
}

// =========================================================================
// プレイヤーレベル（ブルアカの指揮官レベルに対応）
// =========================================================================

/// レベルアップに必要なEXP
///
/// Lv1→2: 50, Lv2→3: 70, Lv3→4: 90, ...
/// 緩やかな線形増加で、常に進行可能。
pub fn exp_for_next_level(current_level : Int) -> Int {
  30 + current_level * 20
}

/// レベルアップチェック（連鎖対応）
fn check_level_up(state : GameState) -> Unit {
  let exp = state.player_exp.get()
  let level = state.player_level.get()
  let needed = exp_for_next_level(level)
  if exp >= needed {
    state.player_exp.update(fn(e) { e - needed })
    state.player_level.update(fn(l) { l + 1 })
    let new_level = level + 1
    add_message(state, "プレイヤーLv" + new_level.to_string() + " に上昇！")

    // レベルアップ報酬（ブルアカ参考: ジェムを多めに）
    state.coins.update(fn(c) { c + 100 })
    state.gems.update(fn(g) { g + 20 })
    state.today_coins_earned.update(fn(c) { c + 100 })
    state.today_gems_earned.update(fn(g) { g + 20 })

    // 連鎖レベルアップチェック
    check_level_up(state)
  }
}

/// 現在のAP上限（プレイヤーレベルに応じて増加）
///
/// 基本5 + レベル5ごとに+1（上限10）
pub fn get_max_ap(state : GameState) -> Int {
  let level = state.player_level.get()
  let bonus = level / 5
  let result = base_ap + bonus
  if result > 10 { 10 } else { result }
}

// =========================================================================
// 親密度マイルストーン（ブルアカの絆レベル報酬に対応）
// =========================================================================

/// 親密度マイルストーン報酬のチェック・付与
///
/// 親密度レベルが上がった際に、未受取のマイルストーン報酬を付与する。
pub fn check_affection_milestones(state : GameState) -> Unit {
  let current_level = get_affection_level(state.intimacy.get())
  let claimed = state.claimed_affection_milestone.get()

  if current_level <= claimed {
    return
  }

  let milestones = @data.get_affection_milestones()
  for m in milestones {
    if m.level > claimed && m.level <= current_level {
      match m.reward_type {
        "gem" => {
          state.gems.update(fn(g) { g + m.reward_amount })
          state.today_gems_earned.update(fn(g) { g + m.reward_amount })
        }
        "coin" => {
          state.coins.update(fn(c) { c + m.reward_amount })
          state.today_coins_earned.update(fn(c) { c + m.reward_amount })
        }
        _ => ()
      }
      add_message(state, "親密度Lv" + m.level.to_string() + "到達! " + m.description)
    }
  }

  state.claimed_affection_milestone.set(current_level)
}

// =========================================================================
// ログインボーナス
// =========================================================================

/// ログインボーナスの報酬テーブル（7日サイクル）
///
/// ジェム報酬を増やしてガチャへの導線を作る。
pub fn get_login_bonus_rewards() -> Array[@data.LoginBonusReward] {
  [
    { day: 1, reward_type: "coin", reward_amount: 100, description: "100 コイン" },
    { day: 2, reward_type: "gem", reward_amount: 20, description: "20 星石" },
    { day: 3, reward_type: "coin", reward_amount: 200, description: "200 コイン" },
    { day: 4, reward_type: "gem", reward_amount: 30, description: "30 星石" },
    { day: 5, reward_type: "coin", reward_amount: 300, description: "300 コイン" },
    { day: 6, reward_type: "gem", reward_amount: 40, description: "40 星石" },
    { day: 7, reward_type: "gem", reward_amount: 80, description: "80 星石" },
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
        "gem" => {
          state.gems.update(fn(g) { g + reward.reward_amount })
          state.today_gems_earned.update(fn(g) { g + reward.reward_amount })
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
// パッシブ収入（ブルアカのカフェに対応）
// =========================================================================

/// パッシブ収入を付与（日送り時に呼ばれる）
pub fn grant_passive_income(state : GameState) -> Int {
  let aff_level = get_affection_level(state.intimacy.get())
  let passive = calculate_passive_income(aff_level)

  state.coins.update(fn(c) { c + passive.daily_coins })
  state.today_coins_earned.update(fn(c) { c + passive.daily_coins })

  if passive.daily_gems > 0 {
    state.gems.update(fn(g) { g + passive.daily_gems })
    state.today_gems_earned.update(fn(g) { g + passive.daily_gems })
  }

  passive.daily_coins
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
  let gems_earned = state.today_gems_earned.get()
  let cards_played = state.today_actions.get().length()

  let memories : Array[String] = []

  // プレイヤーレベルアップ判定
  let current_player_level = state.player_level.get()
  // レベルアップはリアルタイムで行われるため、day_startとの比較は不要
  // ここではday_resultは表示用なのでcurrent値を使う

  // 親密度レベルアップ判定
  let current_aff_level = get_affection_level(state.intimacy.get())
  let start_aff_level = state.day_start_affection_level.get()
  let aff_level_up = current_aff_level > start_aff_level

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

  // パッシブ収入
  let passive = calculate_passive_income(current_aff_level)

  {
    trust_gained,
    understanding_gained,
    empathy_gained,
    coins_earned,
    gems_earned,
    cards_played,
    memories_acquired: memories,
    player_level_up: false,  // 表示用（実際のレベルアップはリアルタイム）
    new_player_level: current_player_level,
    affection_level_up: aff_level_up,
    new_affection_level: current_aff_level,
    season_milestone: is_milestone,
    milestone_rank,
    passive_coins: passive.daily_coins,
  }
}

/// 1日の開始時パラメータを記録
pub fn snapshot_day_start(state : GameState) -> Unit {
  state.day_start_trust.set(state.trust.get())
  state.day_start_understanding.set(state.understanding.get())
  state.day_start_empathy.set(state.empathy.get())
  state.day_start_affection_level.set(get_affection_level(state.intimacy.get()))
  state.today_coins_earned.set(0)
  state.today_gems_earned.set(0)
}

/// デイリザルト画面を閉じる
pub fn close_day_result(state : GameState) -> Unit {
  if check_login_bonus(state) {
    state.phase.set(@data.GamePhase::LoginBonus)
  } else {
    state.phase.set(@data.GamePhase::Home)
  }
}

// =========================================================================
// ミッション報酬（通貨版）
// =========================================================================

/// ミッション報酬にコイン・ジェムを付与
pub fn grant_mission_coin_reward(state : GameState, mission_id : String) -> Unit {
  let (coins, gems) = match mission_id {
    "eat" => (50, 5)
    "talk" => (30, 3)
    "actions_3" => (100, 10)
    _ => (20, 2)
  }
  state.coins.update(fn(c) { c + coins })
  state.today_coins_earned.update(fn(c) { c + coins })
  state.gems.update(fn(g) { g + gems })
  state.today_gems_earned.update(fn(g) { g + gems })
}
