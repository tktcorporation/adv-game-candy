// ディフェンスゲーム コアロジック — tick処理
//
// 毎tick（1/60秒）で呼ばれ、全ユニットの移動・攻撃・ウェーブ出現を処理。
// イミュータブル: 旧スナップショットから新スナップショットを生成して返す。

/// 1tick分のゲーム更新（メインループ）
///
/// 処理順序:
/// 1. コスト回復
/// 2. 敵ウェーブ出現
/// 3. ユニット移動
/// 4. 攻撃判定
/// 5. 死亡除去
/// 6. 拠点攻撃判定
/// 7. 勝敗判定
/// 8. クールダウン減少
pub fn tick_battle(
  snap : BattleSnapshot,
  stage : @data.StageDef
) -> BattleSnapshot {
  if snap.result != @data.BattleResult::InProgress {
    return snap
  }
  let new_tick = snap.tick + 1

  // 1. コスト回復
  let new_cost = if snap.cost_milli + snap.cost_speed > max_cost * 1000 {
    max_cost * 1000
  } else {
    snap.cost_milli + snap.cost_speed
  }

  // 2. 敵ウェーブ出現
  let mut uid_counter = snap.next_uid
  let new_enemies : Array[@data.BattleUnit] = []
  for e in snap.enemies {
    new_enemies.push(e)
  }
  let new_wave_states : Array[(Int, Int, Int)] = []
  for ws in snap.wave_states {
    let (wi, spawned, next_tick) = ws
    let wave = stage.waves[wi]
    if spawned < wave.count && new_tick >= next_tick {
      // 敵を1体出現
      match @data.get_enemy_by_id(wave.enemy_id) {
        Some(edef) => {
          new_enemies.push({
            uid: uid_counter,
            def_id: edef.id,
            is_ally: false,
            x: field_width,
            hp: edef.hp,
            max_hp: edef.hp,
            attack: edef.attack,
            speed: edef.speed,
            attack_range: edef.attack_range,
            attack_interval: edef.attack_interval,
            attack_timer: edef.attack_interval,
            emoji: edef.emoji,
            name: edef.name,
          })
          uid_counter = uid_counter + 1
        }
        None => ()
      }
      new_wave_states.push((wi, spawned + 1, next_tick + wave.interval))
    } else {
      new_wave_states.push(ws)
    }
  }

  // 3. ユニット移動（攻撃対象がいないときだけ移動）
  let moved_allies = move_units(snap.allies, new_enemies, true)
  let moved_enemies = move_units(new_enemies, moved_allies, false)

  // 4. 攻撃判定
  let (atk_allies, damaged_enemies) = process_attacks(
    moved_allies, moved_enemies, true,
  )
  let (atk_enemies, damaged_allies) = process_attacks(
    moved_enemies, atk_allies, false,
  )

  // 5. 死亡除去
  let alive_allies = filter_alive(damaged_allies)
  let alive_enemies = filter_alive(damaged_enemies)

  // 6. 拠点攻撃判定
  let mut new_base_hp = snap.base_hp
  let mut new_enemy_base_hp = snap.enemy_base_hp
  for e in alive_enemies {
    if e.x <= 0 {
      new_base_hp = new_base_hp - e.attack
    }
  }
  for a in alive_allies {
    if a.x >= field_width {
      new_enemy_base_hp = new_enemy_base_hp - a.attack
    }
  }
  if new_base_hp < 0 {
    new_base_hp = 0
  }
  if new_enemy_base_hp < 0 {
    new_enemy_base_hp = 0
  }

  // 7. 勝敗判定
  let result = if new_enemy_base_hp <= 0 {
    @data.BattleResult::Victory
  } else if new_base_hp <= 0 {
    @data.BattleResult::Defeat
  } else {
    @data.BattleResult::InProgress
  }

  // 8. クールダウン減少
  let new_cooldowns : Array[(String, Int)] = []
  for pair in snap.cooldowns {
    let (id, cd) = pair
    if cd > 1 {
      new_cooldowns.push((id, cd - 1))
    }
    // cd <= 1 なら除去（クールダウン完了）
  }

  {
    tick: new_tick,
    allies: alive_allies,
    enemies: alive_enemies,
    base_hp: new_base_hp,
    enemy_base_hp: new_enemy_base_hp,
    cost_milli: new_cost,
    cost_speed: snap.cost_speed,
    result,
    next_uid: uid_counter,
    cooldowns: new_cooldowns,
    wave_states: new_wave_states,
  }
}

/// ユニットを移動（攻撃対象が射程内にいなければ前進）
fn move_units(
  units : Array[@data.BattleUnit],
  targets : Array[@data.BattleUnit],
  is_ally : Bool
) -> Array[@data.BattleUnit] {
  let result : Array[@data.BattleUnit] = []
  for u in units {
    let has_target = has_target_in_range(u, targets)
    if has_target {
      result.push(u)
    } else {
      let new_x = if is_ally { u.x + u.speed } else { u.x - u.speed }
      // フィールド範囲内にクランプ
      let clamped = if new_x < 0 { 0 } else if new_x > field_width {
        field_width
      } else {
        new_x
      }
      result.push({ ..u, x: clamped })
    }
  }
  result
}

/// 射程内にターゲットがいるか
fn has_target_in_range(
  unit : @data.BattleUnit,
  targets : Array[@data.BattleUnit]
) -> Bool {
  for t in targets {
    let dist = if unit.x > t.x { unit.x - t.x } else { t.x - unit.x }
    if dist <= unit.attack_range {
      return true
    }
  }
  false
}

/// 攻撃処理: 射程内の最前列ターゲットにダメージ
fn process_attacks(
  attackers : Array[@data.BattleUnit],
  defenders : Array[@data.BattleUnit],
  attacker_is_ally : Bool
) -> (Array[@data.BattleUnit], Array[@data.BattleUnit]) {
  // defenders を mutable コピー
  let def_hp : Array[Int] = []
  for d in defenders {
    def_hp.push(d.hp)
  }

  let new_attackers : Array[@data.BattleUnit] = []
  for a in attackers {
    if a.attack_timer <= 1 {
      // 攻撃実行: 射程内の最前列ターゲットを探す
      let target_idx = find_closest_target(a, defenders, attacker_is_ally)
      match target_idx {
        Some(idx) => {
          def_hp[idx] = def_hp[idx] - a.attack
          new_attackers.push({ ..a, attack_timer: a.attack_interval })
        }
        None => new_attackers.push({ ..a, attack_timer: a.attack_timer - 1 })
      }
    } else {
      new_attackers.push({ ..a, attack_timer: a.attack_timer - 1 })
    }
  }

  let new_defenders : Array[@data.BattleUnit] = []
  for i, d in defenders {
    new_defenders.push({ ..d, hp: def_hp[i] })
  }

  (new_attackers, new_defenders)
}

/// 射程内の最前列ターゲットのインデックスを返す
fn find_closest_target(
  attacker : @data.BattleUnit,
  targets : Array[@data.BattleUnit],
  attacker_is_ally : Bool
) -> Int? {
  let mut best_idx : Int? = None
  let mut best_dist = field_width + 1
  for i, t in targets {
    let dist = if attacker.x > t.x {
      attacker.x - t.x
    } else {
      t.x - attacker.x
    }
    if dist <= attacker.attack_range && dist < best_dist {
      // 味方は最も左（前方）の敵を、敵は最も右（前方）の味方を狙う
      let is_better = if attacker_is_ally {
        match best_idx {
          Some(bi) => t.x > targets[bi].x
          None => true
        }
      } else {
        match best_idx {
          Some(bi) => t.x < targets[bi].x
          None => true
        }
      }
      if is_better {
        best_idx = Some(i)
        best_dist = dist
      }
    }
  }
  best_idx
}

/// HP > 0 のユニットだけ残す
fn filter_alive(units : Array[@data.BattleUnit]) -> Array[@data.BattleUnit] {
  let result : Array[@data.BattleUnit] = []
  for u in units {
    if u.hp > 0 {
      result.push(u)
    }
  }
  result
}
