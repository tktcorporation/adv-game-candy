// ディフェンスゲーム型定義 — にゃんこ大戦争式「食材ディフェンス」
//
// 定食屋「灯」の食材たちが空腹モンスターから店を守る1Dタワーディフェンス。
// フィールドは横1D（x座標のみ）。味方は右へ、敵は左へ自動で進む。

/// レアリティ — ガチャ排出率・キャラ性能のランク
pub(all) enum Rarity {
  N     // ノーマル（排出率70%）
  R     // レア（排出率20%）
  SR    // スーパーレア（排出率8%）
  SSR   // 超スーパーレア（排出率2%）
} derive(Eq)

/// 食材キャラ定義（プレイヤー側ユニットのマスターデータ）
///
/// ガチャで入手し、編成してバトルに出撃させる。
/// にゃんこ大戦争の「ネコ」に対応。
pub(all) struct AllyDef {
  id : String
  name : String
  emoji : String        // 絵文字表示（画像不要）
  rarity : Rarity
  deploy_cost : Int     // 出撃コスト（時間で溜まるリソース）
  cooldown : Int        // 再出撃までのクールダウン（tick数）
  hp : Int
  attack : Int
  speed : Int           // 移動速度（px/tick）
  attack_range : Int    // 攻撃射程（px）
  attack_interval : Int // 攻撃間隔（tick数）
  description : String  // フレーバーテキスト
}

/// 敵キャラ定義（空腹モンスターのマスターデータ）
pub(all) struct EnemyDef {
  id : String
  name : String
  emoji : String
  hp : Int
  attack : Int
  speed : Int
  attack_range : Int
  attack_interval : Int
}

/// 敵ウェーブ — 1つの敵出現パターン
///
/// delay tick後に、interval tick間隔で count体の敵を出現させる。
pub(all) struct EnemyWave {
  enemy_id : String
  count : Int
  interval : Int    // 出現間隔（tick数）
  delay : Int       // 開始までの遅延（tick数）
}

/// ステージ定義（バランス調整だけでレベル量産可能）
///
/// 敵のHP/攻撃/出現タイミングを変えるだけで難易度調整できる。
pub(all) struct StageDef {
  id : Int
  name : String
  description : String
  enemy_base_hp : Int       // 敵拠点のHP
  cost_speed : Int          // コスト回復速度（/tick、千分率: 100=0.1/tick）
  waves : Array[EnemyWave]
  reward_akari : Int        // クリア報酬（灯ポイント）
  reward_coins : Int
  /// 星評価の閾値（クリアtick数）: [3星, 2星, 1星]
  star_thresholds : Array[Int]
}

/// フィールド上のユニット（味方・敵共通のランタイム状態）
///
/// マスターデータ(AllyDef/EnemyDef)とは別に、戦闘中の個体状態を管理。
/// x座標が0（灯側）～field_width（敵側）で移動する。
pub(all) struct BattleUnit {
  uid : Int             // ユニーク識別子
  def_id : String       // マスターデータID
  is_ally : Bool        // true=味方, false=敵
  x : Int               // 現在のx座標（px）
  hp : Int              // 現在HP
  max_hp : Int
  attack : Int
  speed : Int
  attack_range : Int
  attack_interval : Int
  attack_timer : Int    // 次の攻撃までのカウントダウン
  emoji : String
  name : String
}

/// バトル結果
pub(all) enum BattleResult {
  InProgress
  Victory
  Defeat
} derive(Eq)

/// ステージクリア記録
pub(all) struct StageClearRecord {
  stage_id : Int
  stars : Int       // 1-3
  best_ticks : Int  // 最速クリアtick数
}

/// 所持キャラ記録（ガチャで入手）
pub(all) struct OwnedAlly {
  ally_id : String
  level : Int       // 強化レベル（被りで+1）
}

/// バトル編成（出撃デッキ）— 最大5体
pub(all) struct BattleFormation {
  ally_ids : Array[String]
}
