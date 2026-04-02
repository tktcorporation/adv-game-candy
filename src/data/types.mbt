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
pub(all) struct Character {
  id : String
  name : String
  age : Int
  background : String
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
