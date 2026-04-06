// ゲームデータ型定義 — 定食屋「灯」に通うADV
//
// AP行動選択制: Title → Story(ch0) → Home → ActionSelect → Scene → Home のサイクル。
// 毎日5APの中で「食べる/観察する/話す」を選び、親密度を貯めてストーリーを解放する。

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
} derive(Eq)

/// 行動タイプ — 灯の中で何をするか
///
/// 各行動にはAPコストと親密度効果がある。
/// Special は ★3（親密度300）到達で解放される上位行動。
pub(all) enum ActionType {
  Eat       // 食べる (2 AP, +10-15 親密度)
  Observe   // 観察する (1 AP, +3-5 親密度)
  Talk      // 丸山と話す (1 AP, +5-8 親密度)
  Special   // 特別行動 (2 AP, +15-25 親密度, ★3で解放)
} derive(Eq)

/// デイリーミッション
///
/// 毎日リセット。達成でボーナス親密度を獲得。
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
/// unlock_intimacy で解放条件を管理する。
/// 旧システムの unlock_revenue / unlock_recipes / unlock_customers は撤去済み。
pub(all) struct Chapter {
  id : Int
  title : String
  subtitle : String
  unlock_intimacy : Int
  scenes : Array[Scene]
}

/// 日替わりメニュー
///
/// 定食屋「灯」の日替わり定食。日数のハッシュで決定的に選ばれる。
/// intimacy_bonus: その日に訪問したとき加算される親密度ポイント（8-15）。
pub(all) struct DailyMenu {
  id : String
  name : String
  description : String
  intimacy_bonus : Int
}

/// 訪問記録（味の記憶）
///
/// アルバム画面で一覧表示する。全メニュー制覇などコレクション要素。
/// action_type: どの行動で記録されたか（"eat"/"observe"/"talk"/"special"）
pub(all) struct VisitRecord {
  day : Int
  menu_id : String
  scene_text : String
  action_type : String
}

/// Customer character definition
///
/// 各キャラクターの設定資料。外見・仕草・表情のフィールドは
/// シナリオ執筆時の描写一貫性と、将来の立ち絵・キャラ図鑑UIに使用。
pub(all) struct Character {
  id : String
  name : String
  age : Int
  background : String
  /// 外見: 髪型、服装、体格、印象的な身体的特徴
  appearance : String
  /// 仕草・癖: その人特有の動作パターン（緊張時、リラックス時など）
  mannerisms : String
  /// 表情の特徴: デフォルト表情、笑い方、怒り方など
  expression : String
  /// 声・話し方の特徴: 口調、テンポ、声質のイメージ
  voice : String
  pattern : String
  favorite_menu : String
  challenge_menu : String
  intro_chapter : Int
}

/// Intimacy rank thresholds
pub(all) struct IntimacyRank {
  stars : Int
  min_points : Int
  description : String
}

// =========================================================================
// ソーシャルゲームシステム拡張 — 学マス参考設計
// =========================================================================

/// 関係性3軸（学マスの Vo/Da/Vi に対応）
///
/// 単一の親密度を3つの軸に分解し、行動選択に戦略性を持たせる。
/// 合計値 = 従来の intimacy（後方互換）。
pub(all) enum RelationAxis {
  Trust        // 信頼 — 丸山との会話、日々の積み重ねで育つ
  Understanding // 理解 — 観察、ひよりの仕草や好みを知ることで育つ
  Empathy      // 共感 — 食事を共有し、同じ体験をすることで育つ
} derive(Eq)

/// 季節（学マスのプロデュース期間に対応）
///
/// 30日で1季節。季節ごとにメニュー・カード・イベントが変化し、
/// 季節末に節目イベント（学マスの中間/最終試験）が発生する。
pub(all) enum Season {
  Spring  // 春 — 新しい出会い、桜メニュー
  Summer  // 夏 — 冷やし系メニュー、夏祭りの話題
  Autumn  // 秋 — 秋刀魚、読書の秋でひよりとの距離が縮まる
  Winter  // 冬 — 温かい料理、年末年始の特別感
} derive(Eq)

/// 天候（日替わりで変動し、カード出現率やテキストに影響）
///
/// 天候は day のハッシュで決定的に決まる（セーブ/ロード互換）。
/// 雨の日に限定カードが出る、冬のみ雪が降るなど戦略の幅を広げる。
pub(all) enum Weather {
  Sunny   // 晴れ (50%) — 標準。客足が多い日
  Cloudy  // 曇り (25%) — やや静か。観察が捗る
  Rainy   // 雨 (20%) — 灯の雰囲気が変わる。限定カード出現
  Snowy   // 雪 (冬のみ 5%) — 特別な雰囲気。温かい料理ボーナス
} derive(Eq)

/// 行動カードのカテゴリ（既存 ActionType を包含）
///
/// 既存の Eat/Observe/Talk/Special を拡張し、
/// 天候限定・季節限定カードを追加する基盤。
pub(all) enum CardCategory {
  Eat       // 食事系（共感メイン）
  Observe   // 観察系（理解メイン）
  Talk      // 会話系（信頼メイン）
  Special   // 特別行動（複合、条件解放）
  Weather   // 天候限定（その日の天候でのみ出現）
  Seasonal  // 季節限定（その季節でのみ出現）
} derive(Eq)

/// 行動カードのレアリティ（手札ドロー時の出現率に影響）
pub(all) enum CardRarity {
  Normal    // 通常 — 高確率で手札に入る
  Uncommon  // 上質 — やや低確率だが効果が高い
  Rare      // 特別 — 低確率、条件付き。大きな効果
} derive(Eq)

/// 行動カードの解放条件
///
/// カードがプレイヤーのデッキに追加される条件。
/// Always は初期デッキ。それ以外は進行度に応じて解放。
pub(all) enum UnlockCondition {
  Always                // 初期カード
  IntimacyRankReached(Int)  // ★N以上で解放
  ChapterCleared(Int)   // 第N章クリアで解放
  SeasonOnly(Season)    // 特定季節のみ出現
  WeatherOnly(Weather)  // 特定天候のみ出現
  MemoryAcquired(String) // 特定の思い出を獲得済み
} derive(Eq)

/// 行動カード（学マスのスキルカードに対応）
///
/// 毎日の手札にドローされ、APを消費してプレイする。
/// 3軸パラメータへの影響が異なり、どのカードを使うかが戦略。
/// scene_key: 行動時に表示されるテキストの参照キー。
pub(all) struct ActionCard {
  id : String
  name : String
  description : String
  category : CardCategory
  rarity : CardRarity
  ap_cost : Int
  // 3軸への影響値
  trust_gain : Int
  understanding_gain : Int
  empathy_gain : Int
  // 解放条件
  unlock_condition : UnlockCondition
  // 行動テキスト参照キー（既存の get_action_text に渡す）
  scene_key : String
}

/// プレイヤーの手札（毎日リセット）
///
/// 毎朝、解放済みカードプールから max_hand_size 枚をドロー。
/// 天候・季節で特定カードの出現率が上がる。
pub(all) struct Hand {
  cards : Array[ActionCard]
  max_hand_size : Int  // 通常4枚
}

/// 思い出（学マスのメモリーに対応）
///
/// 特定条件を達成すると獲得する収集要素。
/// 装備スロットにセットするとパッシブ効果が毎日の行動に加算される。
/// acquired_day: 獲得した日（0 = 未獲得）。
pub(all) struct Memory {
  id : String
  title : String
  description : String
  // 獲得条件のヒントテキスト（図鑑で「？？？」の代わりに表示）
  hint : String
  // パッシブ効果（装備時、毎日の行動に加算）
  trust_bonus : Int
  understanding_bonus : Int
  empathy_bonus : Int
}

/// 思い出の獲得記録
///
/// Memory の id と獲得日を紐づける。アルバム表示用。
pub(all) struct MemoryRecord {
  memory_id : String
  acquired_day : Int
  acquired_season : Season
}

/// 装備中の思い出スロット（3枠: 信頼/理解/共感）
///
/// 各スロットに1つずつ思い出をセットできる。
/// 空文字列 = 未装備。
pub(all) struct MemorySlots {
  trust_slot : String       // 信頼スロットにセットした思い出ID
  understanding_slot : String // 理解スロットにセットした思い出ID
  empathy_slot : String     // 共感スロットにセットした思い出ID
}

/// 季節の節目イベント結果（学マスの中間/最終試験に対応）
///
/// 各季節末に3軸パラメータを評価し、S/A/B/Cランクを付与。
/// ランクに応じて異なるご褒美シーンが再生される。
pub(all) enum MilestoneRank {
  S  // 3軸すべて高い（バランス型）
  A  // 合計が高い
  B  // そこそこ
  C  // 最低保証（必ず何かは見られる）
} derive(Eq)

/// 季節の節目イベント結果記録
pub(all) struct SeasonResult {
  season : Season
  year : Int          // 何年目か（1始まり）
  rank : MilestoneRank
  trust_at_eval : Int
  understanding_at_eval : Int
  empathy_at_eval : Int
}

/// 週替わりミッション（デイリーの上位）
///
/// 1週間（7日）で達成する中期目標。報酬は限定カードや思い出のかけら。
pub(all) struct WeeklyMission {
  id : String
  description : String
  target_value : Int    // 目標値
  current_value : Int   // 現在の進捗
  completed : Bool
  reward_type : String  // "card" / "memory" / "text"
  reward_id : String    // 報酬の参照ID
}
