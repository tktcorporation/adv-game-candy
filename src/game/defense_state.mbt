// ディフェンスゲーム状態管理
//
// バトル中のランタイム状態。Signal で管理し、
// 毎tick更新 → luna.mbt の reactive DOM が自動反映。

/// フィールド幅（px）
pub let field_width : Int = 480

/// 灯（味方拠点）の初期HP
pub let base_hp : Int = 100

/// コスト上限
pub let max_cost : Int = 200

/// 出撃デッキの最大数
pub let max_formation : Int = 5

/// バトルランタイム状態（毎tick更新される）
///
/// Signal[BattleSnapshot] として GameState に格納。
/// イミュータブルなスナップショットを毎tick生成し set() する。
pub(all) struct BattleSnapshot {
  /// 現在のtick数
  tick : Int
  /// 味方ユニット一覧
  allies : Array[@data.BattleUnit]
  /// 敵ユニット一覧
  enemies : Array[@data.BattleUnit]
  /// 灯（味方拠点）の残りHP
  base_hp : Int
  /// 敵拠点の残りHP
  enemy_base_hp : Int
  /// 現在の出撃コスト（千分率: 1000 = コスト1.0）
  cost_milli : Int
  /// コスト回復速度（千分率/tick）
  cost_speed : Int
  /// バトル結果
  result : @data.BattleResult
  /// 次のユニークID（ユニット生成用カウンター）
  next_uid : Int
  /// 各味方キャラの再出撃クールダウン残り（ally_id → 残りtick）
  cooldowns : Array[(String, Int)]
  /// ウェーブ進行状態: (wave_index, spawned_count, next_spawn_tick)
  wave_states : Array[(Int, Int, Int)]
}

/// バトル開始時の初期スナップショット生成
pub fn create_battle_snapshot(stage : @data.StageDef) -> BattleSnapshot {
  let wave_states : Array[(Int, Int, Int)] = []
  for i = 0; i < stage.waves.length(); i = i + 1 {
    let wave = stage.waves[i]
    // (wave_index, spawned_count=0, next_spawn_tick=delay)
    wave_states.push((i, 0, wave.delay))
  }
  {
    tick: 0,
    allies: [],
    enemies: [],
    base_hp,
    enemy_base_hp: stage.enemy_base_hp,
    cost_milli: 0,
    cost_speed: stage.cost_speed,
    result: @data.BattleResult::InProgress,
    next_uid: 1,
    cooldowns: [],
    wave_states,
  }
}

/// クールダウンを取得
pub fn get_cooldown(snap : BattleSnapshot, ally_id : String) -> Int {
  for pair in snap.cooldowns {
    if pair.0 == ally_id {
      return pair.1
    }
  }
  0
}

/// 出撃可能かチェック
pub fn can_deploy(
  snap : BattleSnapshot,
  ally : @data.AllyDef
) -> Bool {
  if snap.result != @data.BattleResult::InProgress {
    return false
  }
  // コスト足りるか（千分率で比較）
  let cost_needed = ally.deploy_cost * 1000
  if snap.cost_milli < cost_needed {
    return false
  }
  // クールダウン中でないか
  if get_cooldown(snap, ally.id) > 0 {
    return false
  }
  true
}
