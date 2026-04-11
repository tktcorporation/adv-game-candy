// ゲームデータ型定義 — 定食屋「灯」ADV
//
// 2層アーキテクチャ:
//   Layer 1 — ひよりの日常（毎日プレイするゲームループ）
//   Layer 2 — 灯でご飯（灯ポイント消費で解放するストーリー報酬）
//
// 設計根拠: ゲームループとストーリーを分離することで、
// ストーリー完結後もゲームが続く（ライブサービス運営が可能）。
// 「日常を頑張った報酬として灯に行ける」= 灯の特別感が増す。

/// ゲームフェーズ — 2層構造を反映
///
/// Layer 1: Home → DailyAction → DailyScene → Home のサイクル
/// Layer 2: Home → Visit → VisitScene → Home のサイクル（灯ポイント消費）
/// Bridge:  WeeklyChallenge は Layer 1 のクライマックス（7日ごと）
pub(all) enum GamePhase {
  Title
  Home            // ハブ画面（日常行動 / 灯に行く / デッキ編集 等）
  // --- Layer 1: ひよりの日常 ---
  DailyAction     // 手札からカード選択（図書館/買い物/自炊/読書/散歩）
  DailyScene      // 行動結果テキスト + パラメータ変化
  // --- Layer 2: 灯でご飯 ---
  Visit           // 灯に入る（席選び → 注文 → ストーリー）
  VisitScene      // 灯でのストーリーシーン
  // --- 共通 ---
  Story           // メインストーリーADV
  WeeklyChallenge // 週末チャレンジ（Layer 1 のクライマックス）
  DayResult       // 1日の成果サマリー
  Album           // コレクション閲覧
  DeckEdit        // デッキ管理画面
  Gacha           // ガチャ（行動カード獲得）
  LoginBonus      // ログインボーナス
  // --- ディフェンスゲーム（Layer 1 の新メイン） ---
  StageSelect     // ステージ選択画面
  Battle          // バトル中
  BattleResult    // バトル結果画面
} derive(Eq)

// =========================================================================
// Layer 1: ひよりの日常（ゲームループ）
// =========================================================================

/// 日常行動カードのカテゴリ
///
/// ひよりが1日にできる行動の種類。学マスのレッスン種別に対応。
/// 各カテゴリは主に1つの軸を伸ばし、対応するバフとの相性がある。
pub(all) enum ActionCategory {
  Study     // 図書館・勉強 → 理解メイン
  Cook      // 自炊・料理 → 共感メイン
  Explore   // 散歩・外出 → 信頼メイン
  Read      // 読書 → 理解メイン（低コスト）
  Shop      // 買い物 → 共感サブ
  Social    // 友人と会う → 信頼メイン
} derive(Eq)

/// 日常行動カード（学マスのスキルカードに対応）
///
/// ひよりの日常生活を表すカード。デッキに入れて毎日ドローする。
/// Layer 1 のコアメカニクス。
pub(all) struct ActionCard {
  id : String
  name : String
  description : String           // ひよりの心の声（フレーバーテキスト）
  category : ActionCategory
  stamina_cost : Int             // 心の余裕コスト（1-3）
  trust_gain : Int
  understanding_gain : Int
  empathy_gain : Int
  /// バフ付与効果（プレイ時に獲得するバフ）
  grants_buff : String           // "" = なし, "comfort"/"curiosity"/"courage"
  /// バフ消費効果（対応バフがあれば効果UP + バフ消費）
  consumes_buff : String         // "" = なし
  buff_bonus_multiplier : Int    // バフ消費時の倍率（千分率: 1500 = 1.5倍）
  scene_key : String             // 行動結果テキストのキー
}

/// バフ — 学マスの好調/集中/やる気に対応
///
/// 「掛け算」を生むコア要素。バフを積んでから大技で消費 = 爆発感。
/// 安心: 共感系を強化（温かい食事、成功体験で獲得）
/// 好奇心: 理解系を強化（新しい発見、読書で獲得）
/// 勇気: 信頼系を強化（外出、新しい場所で獲得）
pub(all) enum Buff {
  Comfort    // 安心 — 共感系 ×1.5
  Curiosity  // 好奇心 — 理解系 ×1.5
  Courage    // 勇気 — 信頼系 ×1.5
} derive(Eq)

/// バフスタック（何段積まれているか）
pub(all) struct BuffStack {
  buff : Buff
  count : Int    // スタック数（最大3）
}

/// デッキ情報
///
/// 学マスの Slay the Spire 式デッキ構築。
/// カードの追加/削除で「ひよりの生活の幅」を表現。
pub(all) struct DeckInfo {
  /// デッキに入っているカードID一覧
  card_ids : Array[String]
  /// デッキの最大枚数
  max_size : Int
}

// =========================================================================
// Layer 2: 灯でご飯（ストーリー報酬）
// =========================================================================

/// 席の位置（関係性の進行を空間で表現）
///
/// 設計根拠: CLAUDE.md の「席の距離が関係性を語る」に対応。
/// 灯に通い続けることで座れる位置が近づく。
pub(all) enum SeatPosition {
  FarTable      // 遠いテーブル席（初期）
  CounterEnd    // カウンターの端（信頼20+）
  CounterMiddle // カウンターの真ん中（信頼40+）
  NextSeat      // ひよりの隣（信頼60+）
} derive(Eq)

/// 灯訪問の状態（Layer 2 の進行管理用）
pub(all) enum VisitPhase {
  Entering      // 灯に入る
  Seating       // 席を選ぶ
  Ordering      // 注文する
  Eating        // 食事シーン + ストーリー
  Leaving       // 「ごちそうさま」
} derive(Eq)

// =========================================================================
// 週チャレンジ（Layer 1 のクライマックス）
// =========================================================================

/// 週末チャレンジ — 学マスの中間/最終試験に対応
///
/// 7日ごとに発生するゲーム側クライマックス。
/// その週の育成成果を試す5ターンの特別パート。
/// ストーリーとは独立 → ストーリー完結後も毎週遊べる。
pub(all) struct WeeklyChallenge {
  id : String
  name : String
  description : String
  /// ランク判定の閾値（その週の獲得量）
  s_threshold : Int     // 3軸すべてこの値以上 → Sランク
  a_threshold : Int     // 合計この値以上 → Aランク
  b_threshold : Int     // 合計この値以上 → Bランク
  /// 報酬
  reward_akari_points : Int   // 灯ポイント報酬
  reward_coins : Int
}

/// チャレンジ結果ランク
pub(all) enum ChallengeRank {
  S   // 3軸バランスよく高い
  A   // 合計が高い
  B   // そこそこ
  C   // 最低保証
} derive(Eq)

/// 週チャレンジ結果記録
pub(all) struct ChallengeResult {
  week_number : Int
  rank : ChallengeRank
  trust_gained : Int
  understanding_gained : Int
  empathy_gained : Int
  akari_points_earned : Int
}

// =========================================================================
// 共通型（両レイヤーで使用）
// =========================================================================

/// 関係性3軸（学マスの Vo/Da/Vi に対応）
pub(all) enum RelationAxis {
  Trust         // 信頼
  Understanding // 理解
  Empathy       // 共感
} derive(Eq)

/// 季節
pub(all) enum Season {
  Spring
  Summer
  Autumn
  Winter
} derive(Eq)

/// 天候
pub(all) enum Weather {
  Sunny
  Cloudy
  Rainy
  Snowy
} derive(Eq)

/// デイリーミッション
pub(all) struct DailyMission {
  id : String
  description : String
  completed : Bool
  reward : Int            // 灯ポイント報酬
}

/// 思い出（メモリー） — 収集要素 + パッシブ効果
pub(all) struct Memory {
  id : String
  title : String
  description : String
  hint : String
  trust_bonus : Int
  understanding_bonus : Int
  empathy_bonus : Int
}

/// 思い出の獲得記録
pub(all) struct MemoryRecord {
  memory_id : String
  acquired_day : Int
  acquired_season : Season
}

/// 装備中の思い出スロット（3枠）
pub(all) struct MemorySlots {
  trust_slot : String
  understanding_slot : String
  empathy_slot : String
}

/// 季節の節目ランク
pub(all) enum MilestoneRank {
  S
  A
  B
  C
} derive(Eq)

/// 季節の節目結果
pub(all) struct SeasonResult {
  season : Season
  year : Int
  rank : MilestoneRank
  trust_at_eval : Int
  understanding_at_eval : Int
  empathy_at_eval : Int
}

// =========================================================================
// ストーリー型（変更なし）
// =========================================================================

/// ストーリー1行
pub(all) struct StoryLine {
  speaker : String
  text : String
  is_choice : Bool
  choices : Array[Choice]
}

/// 選択肢
pub(all) struct Choice {
  text : String
  next_scene : String
  intimacy_target : String
  intimacy_change : Int
}

/// シーン
pub(all) struct Scene {
  id : String
  lines : Array[StoryLine]
  next_scene : String
}

/// チャプター
///
/// メインストーリーは灯ポイント消費（Layer 2 訪問回数）で解放。
pub(all) struct Chapter {
  id : Int
  title : String
  subtitle : String
  /// 解放に必要な累計灯訪問回数
  unlock_visit_count : Int
  scenes : Array[Scene]
}

/// 日替わりメニュー
pub(all) struct DailyMenu {
  id : String
  name : String
  description : String
  intimacy_bonus : Int
}

/// 訪問記録
pub(all) struct VisitRecord {
  day : Int
  menu_id : String
  scene_text : String
  action_type : String
}

/// キャラクター定義
pub(all) struct Character {
  id : String
  name : String
  age : Int
  background : String
  appearance : String
  mannerisms : String
  expression : String
  voice : String
  pattern : String
  favorite_menu : String
  challenge_menu : String
  intro_chapter : Int
}

// =========================================================================
// デイリザルト・通貨・ガチャ（簡素化）
// =========================================================================

/// デイリザルト
pub(all) struct DayResultData {
  trust_gained : Int
  understanding_gained : Int
  empathy_gained : Int
  akari_points_earned : Int   // 灯ポイント
  coins_earned : Int
  actions_taken : Int
  memories_acquired : Array[String]
  challenge_result : String   // "" = チャレンジなし, "S"/"A"/"B"/"C"
  stamina_remaining : Int
}

/// カードプレイ結果（DailyScene 表示用）
///
/// COMBO演出のために、バフ倍率適用前の「base値」も保持する。
/// 表示例: 「信頼 8 → ×1.5 → 12！」
pub(all) struct CardResult {
  trust_gain : Int
  understanding_gain : Int
  empathy_gain : Int
  /// バフ倍率適用前の基礎値（COMBO演出で計算過程を表示するため）
  base_trust : Int
  base_understanding : Int
  base_empathy : Int
  buff_gained : String        // 獲得バフ名（"" = なし）
  buff_consumed : Bool        // バフ消費したか
  multiplier_applied : Bool   // 倍率が適用されたか
  reaction_text : String      // ひよりの心の声
}

/// ガチャ結果（行動カード獲得）
pub(all) struct GachaResult {
  card : ActionCard
  is_new : Bool
}

/// ログインボーナス報酬
pub(all) struct LoginBonusReward {
  day : Int
  reward_type : String    // "coin" / "akari_point" / "card"
  reward_amount : Int
  description : String
}
