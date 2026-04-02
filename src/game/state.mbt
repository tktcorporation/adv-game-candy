// Game state management for 廃墟カフェ復興記

/// Main game state - held in signals for reactivity
pub(all) struct GameState {
  // Core state
  phase : @signals.Signal[@data.GamePhase]
  current_chapter : @signals.Signal[Int]
  scene_index : @signals.Signal[Int]
  line_index : @signals.Signal[Int]
  day : @signals.Signal[Int]
  money : @signals.Signal[Int]
  total_revenue : @signals.Signal[Int]
  total_customers : @signals.Signal[Int]

  // Stamina system
  stamina : @signals.Signal[Int]
  max_stamina : Int

  // Unlocked content
  unlocked_recipes : @signals.Signal[Array[String]]
  discovered_recipes : @signals.Signal[Array[String]]

  // Character intimacy: character_id -> points
  intimacy : @signals.Signal[Array[(String, Int)]]

  // Current day results
  day_visitors : @signals.Signal[Array[@data.CustomerVisit]]
  day_revenue : @signals.Signal[Int]
  day_cost : @signals.Signal[Int]

  // Menu selection for business phase
  selected_menu : @signals.Signal[Array[String]]

  // Daily missions
  business_count_today : @signals.Signal[Int]
  served_favorite_today : @signals.Signal[Bool]

  // Login bonus
  login_total_days : @signals.Signal[Int]
  login_claimed_today : @signals.Signal[Bool]

  // Story flags
  story_complete : @signals.Signal[Bool]
  found_recipe_notebook : @signals.Signal[Bool]

  // UI state
  show_menu_screen : @signals.Signal[Bool]
  show_recipe_book : @signals.Signal[Bool]
  message_log : @signals.Signal[Array[String]]
}

/// Create initial game state
pub fn create_game_state() -> GameState {
  let initial_recipes = ["r_blend", "r_latte", "r_houjicha"]
  let initial_intimacy : Array[(String, Int)] = [
    ("sakura", 0), ("amano", 0), ("kanzaki", 0), ("miyauchi", 0), ("kiritani", 0),
  ]
  {
    phase: @signals.signal(@data.GamePhase::Story),
    current_chapter: @signals.signal(0),
    scene_index: @signals.signal(0),
    line_index: @signals.signal(0),
    day: @signals.signal(1),
    money: @signals.signal(500),
    total_revenue: @signals.signal(0),
    total_customers: @signals.signal(0),
    stamina: @signals.signal(100),
    max_stamina: 100,
    unlocked_recipes: @signals.signal(initial_recipes),
    discovered_recipes: @signals.signal(initial_recipes),
    intimacy: @signals.signal(initial_intimacy),
    day_visitors: @signals.signal([]),
    day_revenue: @signals.signal(0),
    day_cost: @signals.signal(0),
    selected_menu: @signals.signal(initial_recipes),
    business_count_today: @signals.signal(0),
    served_favorite_today: @signals.signal(false),
    login_total_days: @signals.signal(1),
    login_claimed_today: @signals.signal(false),
    story_complete: @signals.signal(false),
    found_recipe_notebook: @signals.signal(false),
    show_menu_screen: @signals.signal(false),
    show_recipe_book: @signals.signal(false),
    message_log: @signals.signal([]),
  }
}
