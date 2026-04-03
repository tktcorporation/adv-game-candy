// Game data types for 廃墟カフェ復興記

/// Game phase enum
pub(all) enum GamePhase {
  Story
  Business
  DayResult
  Menu
  SpecialService
  CharacterEvent
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
pub(all) struct Chapter {
  id : Int
  title : String
  subtitle : String
  unlock_revenue : Int
  unlock_recipes : Int
  unlock_customers : Int
  unlock_intimacy : Int
  scenes : Array[Scene]
}

/// Menu item definition
pub(all) struct MenuItem {
  id : String
  name : String
  description : String
  cost : Int
  price : Int
  unlock_chapter : Int
}

/// Ingredient definition
pub(all) struct Ingredient {
  id : String
  name : String
  category : String
  unlock_chapter : Int
}

/// Recipe definition
pub(all) struct Recipe {
  id : String
  name : String
  base : String
  sub1 : String  // empty if none
  sub2 : String  // empty if none
  description : String
  cost : Int
  price : Int
  unlock_chapter : Int
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

/// Day result - a customer visit during business
pub(all) struct CustomerVisit {
  character_id : String
  menu_ordered : String
  revenue : Int
  intimacy_gained : Int
  dialogue : String
}

/// Daily mission definition
pub(all) struct DailyMission {
  id : String
  description : String
  reward : Int
  target : Int
  current : Int
  completed : Bool
}

/// Login bonus tier
pub(all) struct LoginBonusTier {
  day : Int
  reward : Int
}
