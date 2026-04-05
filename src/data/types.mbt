// ゲームデータ型定義 — 定食屋「灯」に通うADV
//
// カフェ経営シミュレーションを撤去し、「定食屋に通う」ことをゲームループにした。
// 日替わりメニュー → ひとくちシーン → ストーリー解放 のサイクル。

/// ゲームフェーズ
///
/// Visit → Scene → (Story or 次の日) → Visit のサイクルで進行する。
/// Calendar は任意のタイミングで開ける閲覧画面。
pub(all) enum GamePhase {
  Visit     // 灯を訪問する画面（今日の日替わり表示）
  Scene     // ひとくちシーン（日替わりに紐づく短いテキスト）
  Story     // 本編ストーリー
  Calendar  // 味の記憶（カレンダー）閲覧
} derive(Eq)

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
/// カレンダー画面で一覧表示する。全メニュー制覇などコレクション要素。
pub(all) struct VisitRecord {
  day : Int
  menu_id : String
  scene_text : String
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
