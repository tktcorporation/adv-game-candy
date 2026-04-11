// ディフェンスゲーム バトル操作 — 出撃・報酬・編成
//
// プレイヤーの操作（出撃）と、バトル結果の報酬処理。

/// 食材キャラを出撃させる
///
/// コスト消費 → ユニット生成 → クールダウン開始。
/// 味方ユニットはx=0（灯の城の前）から出現し右へ進む。
pub fn deploy_ally(
  snap : BattleSnapshot,
  ally : @data.AllyDef
) -> BattleSnapshot {
  if !can_deploy(snap, ally) {
    return snap
  }

  let cost_needed = ally.deploy_cost * 1000
  let new_cost = snap.cost_milli - cost_needed

  // ユニット生成
  let new_unit : @data.BattleUnit = {
    uid: snap.next_uid,
    def_id: ally.id,
    is_ally: true,
    x: 20, // 灯の城の少し前から出現
    hp: ally.hp,
    max_hp: ally.hp,
    attack: ally.attack,
    speed: ally.speed,
    attack_range: ally.attack_range,
    attack_interval: ally.attack_interval,
    attack_timer: ally.attack_interval,
    emoji: ally.emoji,
    name: ally.name,
  }

  let new_allies : Array[@data.BattleUnit] = []
  for a in snap.allies {
    new_allies.push(a)
  }
  new_allies.push(new_unit)

  // クールダウン設定
  let new_cooldowns : Array[(String, Int)] = []
  let mut found = false
  for pair in snap.cooldowns {
    let (id, cd) = pair
    if id == ally.id {
      new_cooldowns.push((id, ally.cooldown))
      found = true
    } else {
      new_cooldowns.push((id, cd))
    }
  }
  if !found {
    new_cooldowns.push((ally.id, ally.cooldown))
  }

  {
    ..snap,
    allies: new_allies,
    cost_milli: new_cost,
    next_uid: snap.next_uid + 1,
    cooldowns: new_cooldowns,
  }
}

/// バトル勝利時の報酬を付与
pub fn grant_battle_reward(
  state : GameState,
  stage : @data.StageDef,
  clear_ticks : Int
) -> Unit {
  // 星評価
  let stars = evaluate_stars(stage, clear_ticks)

  // 灯ポイント報酬（星数でボーナス）
  let akari_reward = stage.reward_akari + (stars - 1) * 3
  state.akari_points.update(fn(p) { p + akari_reward })

  // コイン報酬
  let coin_reward = stage.reward_coins + (stars - 1) * 50
  state.coins.update(fn(c) { c + coin_reward })

  // クリア記録更新
  update_stage_record(state, stage.id, stars, clear_ticks)

  add_message(
    state,
    "ステージクリア！ ★" +
    stars.to_string() +
    " +" +
    akari_reward.to_string() +
    "灯P +" +
    coin_reward.to_string() +
    "コイン",
  )
}

/// 星評価（クリアtick数 vs 閾値）
///
/// star_thresholds: [3星の上限tick, 2星の上限tick, 1星の上限tick]
/// tick数が少ないほど高評価。
pub fn evaluate_stars(stage : @data.StageDef, ticks : Int) -> Int {
  let thresholds = stage.star_thresholds
  if thresholds.length() >= 3 {
    if ticks <= thresholds[2] {
      3
    } else if ticks <= thresholds[1] {
      2
    } else {
      1
    }
  } else {
    1
  }
}

/// ステージクリア記録を更新（ベスト更新時のみ）
fn update_stage_record(
  state : GameState,
  stage_id : Int,
  stars : Int,
  ticks : Int
) -> Unit {
  state.stage_records.update(fn(records) {
    let new_records : Array[@data.StageClearRecord] = []
    let mut found = false
    for r in records {
      if r.stage_id == stage_id {
        found = true
        // ベスト更新
        let best_stars = if stars > r.stars { stars } else { r.stars }
        let best_ticks = if ticks < r.best_ticks { ticks } else { r.best_ticks }
        new_records.push({ stage_id, stars: best_stars, best_ticks })
      } else {
        new_records.push(r)
      }
    }
    if !found {
      new_records.push({ stage_id, stars, best_ticks: ticks })
    }
    new_records
  })
}

/// ステージクリア済みか
pub fn is_stage_cleared(state : GameState, stage_id : Int) -> Bool {
  let records = state.stage_records.get()
  for r in records {
    if r.stage_id == stage_id {
      return true
    }
  }
  false
}

/// ステージの星数を取得（未クリアは0）
pub fn get_stage_stars(state : GameState, stage_id : Int) -> Int {
  let records = state.stage_records.get()
  for r in records {
    if r.stage_id == stage_id {
      return r.stars
    }
  }
  0
}

/// 解放済みステージの最大ID（クリア済み+1 まで解放）
pub fn get_unlocked_stage_max(state : GameState) -> Int {
  let records = state.stage_records.get()
  let mut max_cleared = 0
  for r in records {
    if r.stage_id > max_cleared {
      max_cleared = r.stage_id
    }
  }
  // 最初のステージは常に解放、クリア済み+1まで解放
  if max_cleared == 0 { 1 } else { max_cleared + 1 }
}
