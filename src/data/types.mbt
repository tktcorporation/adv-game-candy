// ゲームデータ型定義 — 定食屋「灯」に通うADV
//
// ブルアカ参考設計:
// - プレイヤーランク（ユーザーランク）: メインコンテンツのゲート。AP上限・カードLv上限を決定
// - 親密度レベル: キャラ別、上限なし。ボンドストーリー・特別対話を解放
// - カード★ランク + レベル: カードの強さを2軸で管理
// - ジェム通貨ガチャ + 200天井スパーク
//
// 設計根拠:
// ユーザーランクと親密度を分離することで、キャラが少なくても詰まらない。
// メインストーリーはプレイヤーランクで解放され、親密度はオプショナルな深化要素。

/// ゲームフェーズ
///
/// Title → Story(ch0) → Home → ActionSelect → Scene → Home のサイクル。
/// 行動選択で何をするかがゲームのコア。
pub(all) enum GamePhase {
  Title         // 初回起動時のタイトル画面
  Home          // ホーム画面（日付・AP・ミッション・「灯に行く」）
  ActionSelect  // 灯の中。食べる/観察する/話す を選ぶ
  Scene         // 行動結果のテキスト表示
  Story         // 本編ADVストーリー
  Album         // アルバム（味の記憶・発見ノート・会話メモ・ストーリー回想）
  Gacha         // ガチャ（カード獲得）画面
  CardEnhance   // カード強化画面（★ランクアップ + レベルアップ）
  DayResult     // デイリザルト（1日の成果サマリー）画面
  LoginBonus    // ログインボーナス画面
} derive(Eq)

/// 行動タイプ — 灯の中で何をするか
///
/// 各行動にはAPコストと親密度効果がある。
/// Special は 親密度Lv10 到達で解放される上位行動。
pub(all) enum ActionType {
  Eat       // 食べる (2 AP, +10-15 親密度)
  Observe   // 観察する (1 AP, +3-5 親密度)
  Talk      // 丸山と話す (1 AP, +5-8 親密度)
  Special   // 特別行動 (2 AP, +15-25 親密度, 親密度Lv10で解放)
} derive(Eq)

/// デイリーミッション
///
/// 毎日リセット。達成でボーナス親密度・コインを獲得。
/// 「灯で食事をする」「丸山と話す」「3つ行動する」の3種。
pub(all) struct DailyMission {
  id : String
  description : String
  completed : Bool
  reward : Int
}

/// A single line of story dialogue
pub(all) struct StoryLine {
  speaker : String  // empty string for narration
  text : String
  is_choice : Bool
  choices : Array[Choice]
}

/// A choice in story
pub(all) struct Choice {
  text : String
  next_scene : String
  intimacy_target : String  // character id, empty if none
  intimacy_change : Int
}

/// A story scene
pub(all) struct Scene {
  id : String
  lines : Array[StoryLine]
  next_scene : String  // empty if branching via choices
}

/// Chapter definition
///
/// ブルアカ参考: メインストーリーはプレイヤーレベルで解放。
/// 親密度ではなくプレイヤーランクでゲートすることで、
/// キャラが少なくてもストーリーが詰まらない設計。
pub(all) struct Chapter {
  id : Int
  title : String
  subtitle : String
  /// プレイヤーレベルN以上で解放（旧: unlock_intimacy）
  ///
  /// 設計根拠: ユーザーランクと親密度を分離。
  /// プレイヤーレベルは行動するだけで上がるため、
  /// 特定キャラとの関係に依存せず進行できる。
  unlock_player_level : Int
  scenes : Array[Scene]
}

/// 日替わりメニュー
pub(all) struct DailyMenu {
  id : String
  name : String
  description : String
  intimacy_bonus : Int
}

/// 訪問記録（味の記憶）
pub(all) struct VisitRecord {
  day : Int
  menu_id : String
  scene_text : String
  action_type : String
}

/// Customer character definition
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
// ブルアカ参考ソーシャルゲームシステム
// =========================================================================

/// 関係性3軸（学マスの Vo/Da/Vi に対応）
///
/// 3軸の合計値が「親密度ポイント」となり、親密度レベルを決定する。
/// 親密度レベルは上限なし（ブルアカの絆レベル相当）。
pub(all) enum RelationAxis {
  Trust        // 信頼 — 丸山との会話、日々の積み重ねで育つ
  Understanding // 理解 — 観察、ひよりの仕草や好みを知ることで育つ
  Empathy      // 共感 — 食事を共有し、同じ体験をすることで育つ
} derive(Eq)

/// 季節（30日で1季節、季節ごとにメニュー・カード・イベントが変化）
pub(all) enum Season {
  Spring  // 春 — 新しい出会い、桜メニュー
  Summer  // 夏 — 冷やし系メニュー、夏祭りの話題
  Autumn  // 秋 — 秋刀魚、読書の秋でひよりとの距離が縮まる
  Winter  // 冬 — 温かい料理、年末年始の特別感
} derive(Eq)

/// 天候（日替わりで変動し、カード出現率やテキストに影響）
pub(all) enum Weather {
  Sunny   // 晴れ (50%)
  Cloudy  // 曇り (25%)
  Rainy   // 雨 (20%)
  Snowy   // 雪 (冬のみ 5%)
} derive(Eq)

/// 行動カードのカテゴリ
pub(all) enum CardCategory {
  Eat       // 食事系（共感メイン）
  Observe   // 観察系（理解メイン）
  Talk      // 会話系（信頼メイン）
  Special   // 特別行動（複合、条件解放）
  Weather   // 天候限定
  Seasonal  // 季節限定
} derive(Eq)

/// 行動カードのレアリティ
///
/// ガチャ排出時の★ランクにも対応:
///   Normal = ★1排出、Uncommon = ★2排出、Rare = ★3排出
pub(all) enum CardRarity {
  Normal    // ★1 — 高確率排出
  Uncommon  // ★2 — 中確率排出
  Rare      // ★3 — 低確率排出（2.5%）
} derive(Eq)

/// 行動カードの解放条件
///
/// カードがプレイヤーのデッキに追加される条件。
/// Always は初期デッキ。それ以外は進行度に応じて解放。
///
/// 設計変更: IntimacyRankReached → AffectionLevel（上限なし）
/// AffectionLevel(N) は親密度レベルN以上で解放。
pub(all) enum UnlockCondition {
  Always                    // 初期カード
  AffectionLevel(Int)       // 親密度レベルN以上で解放（旧: IntimacyRankReached）
  ChapterCleared(Int)       // 第N章クリアで解放
  SeasonOnly(Season)        // 特定季節のみ出現
  WeatherOnly(Weather)      // 特定天候のみ出現
  MemoryAcquired(String)    // 特定の思い出を獲得済み
  GachaOnly                 // ガチャでのみ入手可能
} derive(Eq)

/// 行動カード（学マスのスキルカードに対応）
///
/// 毎日の手札にドローされ、APを消費してプレイする。
/// 3軸パラメータへの影響が異なり、どのカードを使うかが戦略。
pub(all) struct ActionCard {
  id : String
  name : String
  description : String
  category : CardCategory
  rarity : CardRarity
  ap_cost : Int
  trust_gain : Int
  understanding_gain : Int
  empathy_gain : Int
  unlock_condition : UnlockCondition
  scene_key : String
}

/// プレイヤーの手札（毎日リセット）
pub(all) struct Hand {
  cards : Array[ActionCard]
  max_hand_size : Int
}

/// 思い出（学マスのメモリーに対応）
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

/// 装備中の思い出スロット（3枠: 信頼/理解/共感）
pub(all) struct MemorySlots {
  trust_slot : String
  understanding_slot : String
  empathy_slot : String
}

/// 季節の節目イベント結果ランク
pub(all) enum MilestoneRank {
  S  // 3軸すべて高い
  A  // 合計が高い
  B  // そこそこ
  C  // 最低保証
} derive(Eq)

/// 季節の節目イベント結果記録
pub(all) struct SeasonResult {
  season : Season
  year : Int
  rank : MilestoneRank
  trust_at_eval : Int
  understanding_at_eval : Int
  empathy_at_eval : Int
}

/// 週替わりミッション
pub(all) struct WeeklyMission {
  id : String
  description : String
  target_value : Int
  current_value : Int
  completed : Bool
  reward_type : String
  reward_id : String
}

// =========================================================================
// カード育成システム（ブルアカの生徒育成に対応）
// =========================================================================

/// 所持カード情報（ブルアカの生徒育成に対応）
///
/// ★ランク（1-5）とレベル（1-N）の2軸で育成。
/// ★ランクはカード固有シャードで上げる（ブルアカの神名文字/エリグマ相当）。
/// レベルはコインで上げる（上限 = プレイヤーレベル）。
///
/// ★ランク効果: ★1=1.0x, ★2=1.2x, ★3=1.4x, ★4=1.7x, ★5=2.0x
/// レベル効果: Lv毎に+2%（Lv1=+0%, Lv10=+18%, Lv50=+98%）
pub(all) struct OwnedCard {
  card_id : String
  star_rank : Int   // ★1-5（ガチャ排出 ★1/★2/★3、シャードでアップグレード）
  level : Int       // 1 ~ (star_rank * 10)、プレイヤーレベルで上限
  shards : Int      // カード固有シャード（被りで獲得、★ランクアップに使用）
}

/// ガチャ1回分の結果表示データ
pub(all) struct GachaResult {
  card : ActionCard
  is_new : Bool
  star_rank : Int       // 排出時の★ランク
  shards_gained : Int   // 被り時に獲得するカード固有シャード
  eligma_gained : Int   // 被り時に獲得する汎用シャード（エリグマ相当）
}

/// ログインボーナス1日分の報酬定義
pub(all) struct LoginBonusReward {
  day : Int
  reward_type : String  // "coin" / "gem" / "shard" / "ticket"
  reward_amount : Int
  description : String
}

/// デイリザルト（1日の成果サマリー）
///
/// ブルアカ参考: プレイヤーランクと親密度を分離して表示。
/// 「今日の行動で何が進んだか」を一覧する。
pub(all) struct DayResultData {
  trust_gained : Int
  understanding_gained : Int
  empathy_gained : Int
  coins_earned : Int
  gems_earned : Int
  cards_played : Int
  memories_acquired : Array[String]
  // プレイヤーレベル関連
  player_level_up : Bool
  new_player_level : Int
  // 親密度関連（上限なし）
  affection_level_up : Bool
  new_affection_level : Int
  // 季節の節目
  season_milestone : Bool
  milestone_rank : String
  // パッシブ収入
  passive_coins : Int
}

/// カードプレイ結果（Scene画面表示用）
///
/// play_card() で生成し、Scene画面で獲得値・報酬・リアクションを表示する。
/// base値ではなくスケーリング後の実効値を保持。
pub(all) struct CardResult {
  trust_gain : Int
  understanding_gain : Int
  empathy_gain : Int
  coin_reward : Int
  exp_reward : Int
  gem_reward : Int
  reaction_text : String
}

/// ★ランクアップに必要なコスト
///
/// カード固有シャード + コインで★ランクを上げる。
/// ブルアカの神名文字→★アップに対応。
pub(all) struct StarUpCost {
  shards : Int  // カード固有シャード
  coins : Int   // コイン
}

/// カードレベルアップに必要なコスト
pub(all) struct LevelUpCost {
  coins : Int
}

/// ガチャバナー情報（ブルアカの募集に対応）
///
/// ジェム通貨でガチャ。200連でスパーク（任意★3カード選択）。
/// ソフト天井70連以降★3確率が上昇。
pub(all) struct GachaBanner {
  id : String
  name : String
  description : String
  // 排出レート: ★1 79%, ★2 18.5%, ★3 2.5%
  rate_star1 : Int    // ★1排出率 (千分率: 790 = 79.0%)
  rate_star2 : Int    // ★2排出率 (千分率: 185 = 18.5%)
  rate_star3 : Int    // ★3排出率 (千分率: 25 = 2.5%)
  // スパーク（天井）: この回数引くと任意★3カードを選択可能
  spark_threshold : Int   // 200
  // ソフト天井: この回数以降、★3確率が毎回+2%上昇
  soft_pity_start : Int   // 70
  // コスト（ジェム）
  single_cost : Int       // 120ジェム
  multi_cost : Int        // 1200ジェム（10連）
}

/// 親密度マイルストーン報酬
///
/// 特定の親密度レベル到達時にもらえる報酬。
/// 上限なしのため、高レベルでも報酬が存在する。
pub(all) struct AffectionMilestone {
  level : Int           // 親密度レベル
  reward_type : String  // "gem" / "coin" / "bond_story" / "card" / "title"
  reward_amount : Int
  description : String
}

/// 定食屋パッシブ収入（ブルアカのカフェに対応）
///
/// 親密度レベルに応じて毎日自動でコイン・ジェムを獲得。
/// 「灯に通い続けること自体が報われる」設計。
pub(all) struct RestaurantPassive {
  daily_coins : Int     // 日あたりパッシブコイン
  daily_gems : Int      // 日あたりパッシブジェム（高親密度で発生）
}
