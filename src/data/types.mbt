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
