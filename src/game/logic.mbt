// Game logic for 廃墟カフェ復興記

/// Advance story by one line
pub fn advance_story(state : GameState) -> Unit {
  let chapter = @data.get_chapters()[state.current_chapter.get()]
  let scene = chapter.scenes[state.scene_index.get()]
  let next_line = state.line_index.get() + 1
  if next_line < scene.lines.length() {
    state.line_index.set(next_line)
  } else {
    // Scene complete - move to next scene or end chapter
    let next_scene_id = scene.next_scene
    if next_scene_id == "" {
      // Chapter story complete - go to business phase
      state.phase.set(@data.GamePhase::Business)
      state.line_index.set(0)
      state.scene_index.set(0)
    } else {
      // Find next scene index
      let mut found = -1
      for i, s in chapter.scenes {
        if s.id == next_scene_id {
          found = i
          break
        }
      }
      if found >= 0 {
        state.scene_index.set(found)
        state.line_index.set(0)
      } else {
        state.phase.set(@data.GamePhase::Business)
        state.line_index.set(0)
      }
    }
  }
}

/// Get current story line
pub fn get_current_line(state : GameState) -> @data.StoryLine? {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return None
  }
  let chapter = chapters[ch_idx]
  let sc_idx = state.scene_index.get()
  if sc_idx >= chapter.scenes.length() {
    return None
  }
  let scene = chapter.scenes[sc_idx]
  let ln_idx = state.line_index.get()
  if ln_idx >= scene.lines.length() {
    return None
  }
  Some(scene.lines[ln_idx])
}

/// Get current chapter info
pub fn get_current_chapter(state : GameState) -> @data.Chapter? {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return None
  }
  Some(chapters[ch_idx])
}

/// Start business day - consume stamina and generate customers
pub fn start_business(state : GameState) -> Unit {
  let stamina = state.stamina.get()
  if stamina < 20 {
    add_message(state, "スタミナが足りません！ 回復を待ちましょう。")
    return
  }
  state.stamina.set(stamina - 20)
  state.day_visitors.set([])
  state.day_revenue.set(0)
  state.day_cost.set(0)

  // Generate customer visits based on current chapter and available characters
  let visits = generate_visits(state)
  let mut total_rev = 0
  let mut total_cost = 0
  for v in visits {
    total_rev = total_rev + v.revenue
    // Find the recipe cost
    let recipes = @data.get_all_recipes()
    for r in recipes {
      if r.id == v.menu_ordered {
        total_cost = total_cost + r.cost
        break
      }
    }
    // Update intimacy
    update_intimacy(state, v.character_id, v.intimacy_gained)
  }

  state.day_visitors.set(visits)
  state.day_revenue.set(total_rev)
  state.day_cost.set(total_cost)
  state.money.update(fn(m) { m + total_rev - total_cost })
  state.total_revenue.update(fn(r) { r + total_rev })
  state.total_customers.update(fn(c) { c + visits.length() })

  // Update daily mission tracking
  state.business_count_today.update(fn(c) { c + 1 })

  state.phase.set(@data.GamePhase::DayResult)
}

/// Generate customer visits for a business day
fn generate_visits(state : GameState) -> Array[@data.CustomerVisit] {
  let visits : Array[@data.CustomerVisit] = []
  let chapter = state.current_chapter.get()
  let characters = @data.get_characters()
  let selected = state.selected_menu.get()
  let recipes = @data.get_all_recipes()

  for c in characters {
    if c.intro_chapter > chapter {
      continue
    }
    // Simple visit probability based on day/chapter
    // Each character has ~60% chance to visit
    let day_hash = state.day.get() * 31 + c.id.length()
    if day_hash % 10 < 4 {
      continue
    }

    // Pick a menu item they'd order
    let mut ordered_id = ""
    let mut ordered_name = ""
    let mut price = 300

    // Check if their favorite is available
    let mut has_favorite = false
    for s in selected {
      if s == c.favorite_menu {
        has_favorite = true
        break
      }
    }

    if has_favorite {
      ordered_id = c.favorite_menu
      for r in recipes {
        if r.id == ordered_id {
          ordered_name = r.name
          price = r.price
          break
        }
      }
      // Check if we served favorite
      state.served_favorite_today.set(true)
    } else {
      // Order from available menu
      if selected.length() > 0 {
        let idx = day_hash % selected.length()
        ordered_id = selected[idx]
        for r in recipes {
          if r.id == ordered_id {
            ordered_name = r.name
            price = r.price
            break
          }
        }
      }
    }

    let intimacy_gain = if has_favorite { 15 } else { 8 }
    let dialogue = get_visit_dialogue(c, has_favorite, ordered_name)

    visits.push({
      character_id: c.id,
      menu_ordered: ordered_id,
      revenue: price,
      intimacy_gained: intimacy_gain,
      dialogue: dialogue,
    })
  }

  // Add some generic customers too
  if selected.length() > 0 {
    let generic_count = 1 + (state.day.get() % 3)
    for i in 0..<generic_count {
      let idx = (state.day.get() + i) % selected.length()
      let recipe_id = selected[idx]
      let mut recipe_name = ""
      let mut recipe_price = 300
      for r in recipes {
        if r.id == recipe_id {
          recipe_name = r.name
          recipe_price = r.price
          break
        }
      }
      visits.push({
        character_id: "",
        menu_ordered: recipe_id,
        revenue: recipe_price,
        intimacy_gained: 0,
        dialogue: "「" + recipe_name + "、美味しかったです」",
      })
    }
  }
  visits
}

/// Get dialogue for a character visit
fn get_visit_dialogue(c : @data.Character, got_favorite : Bool, menu_name : String) -> String {
  match c.id {
    "sakura" =>
      if got_favorite {
        "「……悪くないです」"
      } else {
        "「" + menu_name + "ね。ありがとう」"
      }
    "amano" =>
      if got_favorite {
        "「ココアおかわりいいすか！」"
      } else {
        "「" + menu_name + "っすね、ありがとうございます！」"
      }
    "kanzaki" =>
      if got_favorite {
        "「今日のおすすめ？ ……ふーん、いいセンスね」"
      } else {
        "「" + menu_name + "にしようかな」"
      }
    "miyauchi" =>
      if got_favorite {
        "「いい香りだ」"
      } else {
        "「" + menu_name + "をもらおうか」"
      }
    "kiritani" =>
      if got_favorite {
        "「データで見ると御社の強みは……冗談よ。美味しい」"
      } else {
        "「" + menu_name + "、いただきます」"
      }
    _ => "「ごちそうさまでした」"
  }
}

/// Update intimacy for a character
pub fn update_intimacy(state : GameState, character_id : String, amount : Int) -> Unit {
  if character_id == "" {
    return
  }
  state.intimacy.update(fn(pairs) {
    let result : Array[(String, Int)] = []
    for pair in pairs {
      if pair.0 == character_id {
        result.push((pair.0, pair.1 + amount))
      } else {
        result.push(pair)
      }
    }
    result
  })
}

/// Get intimacy for a character
pub fn get_intimacy(state : GameState, character_id : String) -> Int {
  let pairs = state.intimacy.get()
  for pair in pairs {
    if pair.0 == character_id {
      return pair.1
    }
  }
  0
}

/// Get intimacy star rating
pub fn get_intimacy_stars(points : Int) -> Int {
  let ranks = @data.get_intimacy_ranks()
  let mut stars = 1
  for rank in ranks {
    if points >= rank.min_points {
      stars = rank.stars
    }
  }
  stars
}

/// End current day and advance
pub fn end_day(state : GameState) -> Unit {
  state.day.update(fn(d) { d + 1 })
  state.day_visitors.set([])
  state.day_revenue.set(0)
  state.day_cost.set(0)

  // Recover some stamina
  let new_stamina = state.stamina.get() + 10
  if new_stamina > state.max_stamina {
    state.stamina.set(state.max_stamina)
  } else {
    state.stamina.set(new_stamina)
  }

  // Check for chapter unlock
  check_chapter_unlock(state)

  // Reset daily mission counters
  state.business_count_today.set(0)
  state.served_favorite_today.set(false)

  // Go back to business (or story if new chapter unlocked)
  let phase = state.phase.get()
  ignore(phase)
}

/// Check if a new chapter should be unlocked
pub fn check_chapter_unlock(state : GameState) -> Unit {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()
  if current + 1 >= chapters.length() {
    return
  }
  let next = chapters[current + 1]
  let revenue = state.total_revenue.get()
  let recipes = state.discovered_recipes.get().length()
  let customers = count_met_characters(state)

  // Check max intimacy across all characters
  let max_int = get_max_intimacy(state)

  if revenue >= next.unlock_revenue && recipes >= next.unlock_recipes && customers >= next.unlock_customers && max_int >= next.unlock_intimacy {
    state.current_chapter.set(current + 1)
    state.scene_index.set(0)
    state.line_index.set(0)
    state.phase.set(@data.GamePhase::Story)
    add_message(state, next.title + " 「" + next.subtitle + "」が解放されました！")

    // Unlock new recipes for this chapter
    unlock_chapter_recipes(state, current + 1)
  } else {
    state.phase.set(@data.GamePhase::Business)
  }
}

/// Count characters the player has met
fn count_met_characters(state : GameState) -> Int {
  let chapter = state.current_chapter.get()
  let characters = @data.get_characters()
  let mut count = 0
  for c in characters {
    if c.intro_chapter <= chapter {
      count = count + 1
    }
  }
  count
}

/// Get max intimacy across all characters
fn get_max_intimacy(state : GameState) -> Int {
  let pairs = state.intimacy.get()
  let mut max_val = 0
  for pair in pairs {
    if pair.1 > max_val {
      max_val = pair.1
    }
  }
  max_val
}

/// Unlock recipes for a chapter
fn unlock_chapter_recipes(state : GameState, chapter : Int) -> Unit {
  let all_recipes = @data.get_all_recipes()
  state.unlocked_recipes.update(fn(current) {
    let result : Array[String] = []
    for r in current {
      result.push(r)
    }
    for recipe in all_recipes {
      if recipe.unlock_chapter == chapter {
        let mut already = false
        for r in result {
          if r == recipe.id {
            already = true
            break
          }
        }
        if !already {
          result.push(recipe.id)
        }
      }
    }
    result
  })
  // Also add to discovered
  state.discovered_recipes.update(fn(current) {
    let result : Array[String] = []
    for r in current {
      result.push(r)
    }
    let unlocked = state.unlocked_recipes.get()
    for u in unlocked {
      let mut already = false
      for r in result {
        if r == u {
          already = true
          break
        }
      }
      if !already {
        result.push(u)
      }
    }
    result
  })
}

/// Toggle a recipe in selected menu
pub fn toggle_menu_item(state : GameState, recipe_id : String) -> Unit {
  state.selected_menu.update(fn(current) {
    let mut found = false
    for r in current {
      if r == recipe_id {
        found = true
        break
      }
    }
    if found {
      let result : Array[String] = []
      for r in current {
        if r != recipe_id {
          result.push(r)
        }
      }
      result
    } else {
      let result : Array[String] = []
      for r in current {
        result.push(r)
      }
      result.push(recipe_id)
      result
    }
  })
}

/// Add a message to the log
pub fn add_message(state : GameState, msg : String) -> Unit {
  state.message_log.update(fn(log) {
    let result : Array[String] = []
    for m in log {
      result.push(m)
    }
    result.push(msg)
    // Keep last 20 messages
    if result.length() > 20 {
      let trimmed : Array[String] = []
      for i in (result.length() - 20)..<result.length() {
        trimmed.push(result[i])
      }
      trimmed
    } else {
      result
    }
  })
}

/// Get daily mission status
pub fn get_daily_missions(state : GameState) -> Array[@data.DailyMission] {
  let biz_count = state.business_count_today.get()
  let served_fav = state.served_favorite_today.get()
  [
    {
      id: "m1",
      description: "営業を1回行う",
      reward: 100,
      target: 1,
      current: biz_count,
      completed: biz_count >= 1,
    },
    {
      id: "m2",
      description: "営業を3回行う",
      reward: 300,
      target: 3,
      current: biz_count,
      completed: biz_count >= 3,
    },
    {
      id: "m3",
      description: "常連客にお気に入りを出す",
      reward: 200,
      target: 1,
      current: if served_fav { 1 } else { 0 },
      completed: served_fav,
    },
  ]
}

/// Claim daily mission reward
pub fn claim_mission_reward(state : GameState, mission_id : String) -> Unit {
  let missions = get_daily_missions(state)
  for m in missions {
    if m.id == mission_id && m.completed {
      state.money.update(fn(money) { money + m.reward })
      add_message(state, "ミッション達成！ ¥" + m.reward.to_string() + " を獲得！")
      break
    }
  }
}

/// Claim login bonus
pub fn claim_login_bonus(state : GameState) -> Unit {
  if state.login_claimed_today.get() {
    return
  }
  let total_days = state.login_total_days.get()
  let tiers = @data.get_login_bonus_tiers()
  let mut reward = 100 // default
  for tier in tiers {
    if total_days >= tier.day {
      reward = tier.reward
    }
  }
  state.money.update(fn(m) { m + reward })
  state.login_claimed_today.set(true)
  add_message(state, "ログインボーナス！ ¥" + reward.to_string() + " を獲得！（" + total_days.to_string() + "日目）")
}

/// Get character name by id
pub fn get_character_name(character_id : String) -> String {
  let characters = @data.get_characters()
  for c in characters {
    if c.id == character_id {
      return c.name
    }
  }
  "お客さん"
}

/// Get recipe name by id
pub fn get_recipe_name(recipe_id : String) -> String {
  let recipes = @data.get_all_recipes()
  for r in recipes {
    if r.id == recipe_id {
      return r.name
    }
  }
  "不明"
}
