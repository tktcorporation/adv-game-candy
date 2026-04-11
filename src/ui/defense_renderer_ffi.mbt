// Pixi.js 戦場レンダラー FFI — battle_renderer.js へのブリッジ
//
// MoonBit のゲームループ（tick処理）から呼び出し、
// JS側のPixi.jsレンダラーにユニットの生成・移動・消滅を指示する。
//
// 責務分離: MoonBit=ロジック、JS=描画。
// MoonBitは「uidのユニットをx座標に動かせ」と命令するだけ。

///|
/// 戦場のPixi.jsレンダラーを初期化（canvas要素を生成）
extern "js" fn init_renderer_ffi(container_id : String) -> Unit =
  #| (id) => { if(globalThis.initBattleRenderer) globalThis.initBattleRenderer(id) }

///|
/// ユニットをフィールドに出現させる
extern "js" fn spawn_unit_ffi(
  uid : Int,
  emoji : String,
  x : Int,
  is_ally : Bool
) -> Unit =
  #| (uid, emoji, x, isAlly) => { if(globalThis.spawnBattleUnit) globalThis.spawnBattleUnit(uid, emoji, x, isAlly) }

///|
/// ユニットの位置とHPを更新
extern "js" fn update_unit_ffi(uid : Int, x : Int, hp_ratio : Double) -> Unit =
  #| (uid, x, hpRatio) => { if(globalThis.updateBattleUnit) globalThis.updateBattleUnit(uid, x, hpRatio) }

///|
/// ユニットを撃破（消滅エフェクト付き）
extern "js" fn remove_unit_ffi(uid : Int) -> Unit =
  #| (uid) => { if(globalThis.removeBattleUnit) globalThis.removeBattleUnit(uid) }

///|
/// 攻撃エフェクト（バウンス + ヒットスパーク）
extern "js" fn attack_effect_ffi(uid : Int, target_uid : Int) -> Unit =
  #| (uid, tid) => { if(globalThis.battleAttackEffect) globalThis.battleAttackEffect(uid, tid) }

///|
/// ダメージ数値ポップアップ
extern "js" fn damage_number_ffi(x : Int, y : Int, damage : Int) -> Unit =
  #| (x, y, d) => { if(globalThis.battleDamageNumber) globalThis.battleDamageNumber(x, y, d) }

///|
/// レンダラー破棄
extern "js" fn destroy_renderer_ffi() -> Unit =
  #| () => { if(globalThis.destroyBattleRenderer) globalThis.destroyBattleRenderer() }
