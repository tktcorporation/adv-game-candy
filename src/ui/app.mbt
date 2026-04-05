// Main app UI for 灯（ADVゲーム）

/// Main app component
pub fn app(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="app",
    [
      // Header
      render_header(state),
      // Main content area - switches based on game phase
      @dom.div(
        class="main-content",
        [
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Story },
            fn() { render_story_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Business },
            fn() { render_business_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::DayResult },
            fn() { render_day_result_view(state) },
          ),
        ],
      ),
      // Message log
      render_message_log(state),
    ],
  )
}

/// Header with game status
fn render_header(state : @game.GameState) -> @dom.DomNode {
  @dom.header_(
    class="game-header",
    [
      @dom.div(
        class="header-title",
        [
          @dom.h1(class="title", [@dom.text("灯")]),
          @dom.span(
            class="subtitle",
            [@dom.text_dyn(fn() {
              let ch = state.current_chapter.get()
              let chapters = @data.get_chapters()
              if ch < chapters.length() {
                chapters[ch].title + " " + chapters[ch].subtitle
              } else {
                "Complete"
              }
            })],
          ),
        ],
      ),
      @dom.div(
        class="header-stats",
        [
          @dom.span(
            class="stat",
            [@dom.text_dyn(fn() { "Day " + state.day.get().to_string() })],
          ),
          @dom.span(
            class="stat money",
            [@dom.text_dyn(fn() { "¥" + state.money.get().to_string() })],
          ),
          @dom.span(
            class="stat stamina",
            [@dom.text_dyn(fn() {
              "SP " + state.stamina.get().to_string() + "/" + state.max_stamina.to_string()
            })],
          ),
        ],
      ),
    ],
  )
}

/// Story view - ADV-style text display
fn render_story_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="story-view",
    [
      // Chapter title
      @dom.div(
        class="chapter-header",
        [@dom.text_dyn(fn() {
          match @game.get_current_chapter(state) {
            Some(ch) => ch.title + " 「" + ch.subtitle + "」"
            None => ""
          }
        })],
      ),
      // Text display area
      @dom.div(
        class="story-text-area",
        [
          // Speaker name
          @dom.div(
            class="speaker-name",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.speaker
                None => ""
              }
            })],
          ),
          // Story text
          @dom.div(
            class="story-text",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.text
                None => ""
              }
            })],
          ),
        ],
      ),
      // Advance button
      @dom.div(
        class="story-controls",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) { @game.advance_story(state) }),
            [@dom.text_dyn(fn() {
              // Check if this is the last line
              match @game.get_current_line(state) {
                Some(_) => "▼"
                None => "次へ"
              }
            })],
          ),
        ],
      ),
    ],
  )
}

/// Business view - menu selection and operation
fn render_business_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="business-view",
    [
      @dom.h2(class="section-title", [@dom.text("営業準備")]),
      // Stamina display
      @dom.div(
        class="stamina-bar",
        [
          @dom.text_dyn(fn() {
            "仕入れ予算 (SP): " + state.stamina.get().to_string() + " / " + state.max_stamina.to_string() + "  (営業コスト: 20)"
          }),
        ],
      ),
      // Menu selection
      @dom.h3(class="subsection-title", [@dom.text("提供メニュー")]),
      @dom.div(
        class="menu-grid",
        [
          @dom.for_each(
            fn() { state.unlocked_recipes.get() },
            fn(recipe_id, _i) {
              let recipes = @data.get_all_recipes()
              let mut name = ""
              let mut price = 0
              let mut desc = ""
              for r in recipes {
                if r.id == recipe_id {
                  name = r.name
                  price = r.price
                  desc = r.description
                  break
                }
              }
              let rid = recipe_id
              @dom.div(
                class="menu-item",
                on=@dom.events().click(fn(_e) { @game.toggle_menu_item(state, rid) }),
                [
                  @dom.div(
                    class="menu-item-header",
                    [
                      @dom.span(
                        class="menu-check",
                        [@dom.text_dyn(fn() {
                          let selected = state.selected_menu.get()
                          let mut found = false
                          for s in selected {
                            if s == rid {
                              found = true
                              break
                            }
                          }
                          if found { "[x]" } else { "[ ]" }
                        })],
                      ),
                      @dom.span(class="menu-name", [@dom.text(name)]),
                      @dom.span(class="menu-price", [@dom.text("¥" + price.to_string())]),
                    ],
                  ),
                  @dom.div(class="menu-desc", [@dom.text(desc)]),
                ],
              )
            },
          ),
        ],
      ),
      // Action buttons
      @dom.div(
        class="business-actions",
        [
          @dom.button(
            class="btn btn-primary btn-large",
            on=@dom.events().click(fn(_e) { @game.start_business(state) }),
            [@dom.text("営業開始")],
          ),
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) { state.show_recipe_book.set(true) }),
            [@dom.text("レシピ帳")],
          ),
        ],
      ),
      // Daily missions
      render_daily_missions(state),
      // Recipe book overlay
      @dom.show(
        fn() { state.show_recipe_book.get() },
        fn() { render_recipe_book(state) },
      ),
    ],
  )
}

/// Day result view
fn render_day_result_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="day-result-view",
    [
      @dom.h2(class="section-title", [@dom.text_dyn(fn() { "Day " + state.day.get().to_string() + " 営業結果" })]),
      // Customer visit log
      @dom.div(
        class="visit-log",
        [
          @dom.for_each(
            fn() { state.day_visitors.get() },
            fn(visit, _i) {
              let char_name = if visit.character_id != "" {
                @game.get_character_name(visit.character_id)
              } else {
                "一般のお客さん"
              }
              let menu_name = @game.get_recipe_name(visit.menu_ordered)
              @dom.div(
                class="visit-entry",
                [
                  @dom.div(
                    class="visit-info",
                    [
                      @dom.span(class="visitor-name", [@dom.text(char_name)]),
                      @dom.span(class="visitor-order", [@dom.text(" → " + menu_name)]),
                      @dom.span(class="visitor-revenue", [@dom.text(" ¥" + visit.revenue.to_string())]),
                    ],
                  ),
                  @dom.div(class="visit-dialogue", [@dom.text(visit.dialogue)]),
                ],
              )
            },
          ),
        ],
      ),
      // Summary
      @dom.div(
        class="day-summary",
        [
          @dom.div(
            class="summary-row",
            [
              @dom.text_dyn(fn() { "売上: ¥" + state.day_revenue.get().to_string() }),
            ],
          ),
          @dom.div(
            class="summary-row",
            [
              @dom.text_dyn(fn() { "仕入れ: ¥" + state.day_cost.get().to_string() }),
            ],
          ),
          @dom.div(
            class="summary-row profit",
            [
              @dom.text_dyn(fn() {
                let profit = state.day_revenue.get() - state.day_cost.get()
                "利益: ¥" + profit.to_string()
              }),
            ],
          ),
        ],
      ),
      // Next day button
      @dom.div(
        class="day-result-actions",
        [
          @dom.button(
            class="btn btn-primary btn-large",
            on=@dom.events().click(fn(_e) { @game.end_day(state) }),
            [@dom.text("次の日へ")],
          ),
        ],
      ),
    ],
  )
}

/// Daily missions panel
fn render_daily_missions(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="missions-panel",
    [
      @dom.h3(class="subsection-title", [@dom.text("デイリーミッション")]),
      @dom.div(
        class="missions-list",
        [
          @dom.for_each(
            fn() { @game.get_daily_missions(state) },
            fn(mission, _i) {
              let mid = mission.id
              @dom.div(
                class="mission-item",
                [
                  @dom.span(
                    class="mission-status",
                    [@dom.text(if mission.completed { "✓" } else { "○" })],
                  ),
                  @dom.span(class="mission-desc", [@dom.text(mission.description)]),
                  @dom.span(class="mission-progress", [@dom.text(
                    mission.current.to_string() + "/" + mission.target.to_string(),
                  )]),
                  @dom.span(class="mission-reward", [@dom.text("¥" + mission.reward.to_string())]),
                  @dom.show(
                    fn() {
                      let missions = @game.get_daily_missions(state)
                      for m in missions {
                        if m.id == mid {
                          return m.completed
                        }
                      }
                      false
                    },
                    fn() {
                      @dom.button(
                        class="btn btn-small",
                        on=@dom.events().click(fn(_e) { @game.claim_mission_reward(state, mid) }),
                        [@dom.text("受取")],
                      )
                    },
                  ),
                ],
              )
            },
          ),
        ],
      ),
    ],
  )
}

/// Recipe book overlay
fn render_recipe_book(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="overlay",
    [
      @dom.div(
        class="recipe-book",
        [
          @dom.div(
            class="recipe-book-header",
            [
              @dom.h2(class="section-title", [@dom.text("レシピ帳")]),
              @dom.button(
                class="btn btn-close",
                on=@dom.events().click(fn(_e) { state.show_recipe_book.set(false) }),
                [@dom.text("×")],
              ),
            ],
          ),
          @dom.div(
            class="recipe-list",
            [
              @dom.for_each(
                fn() { state.discovered_recipes.get() },
                fn(recipe_id, _i) {
                  let recipes = @data.get_all_recipes()
                  let mut name = "???"
                  let mut desc = ""
                  let mut cost = 0
                  let mut price = 0
                  for r in recipes {
                    if r.id == recipe_id {
                      name = r.name
                      desc = r.description
                      cost = r.cost
                      price = r.price
                      break
                    }
                  }
                  @dom.div(
                    class="recipe-entry",
                    [
                      @dom.div(class="recipe-name", [@dom.text(name)]),
                      @dom.div(class="recipe-desc", [@dom.text(desc)]),
                      @dom.div(
                        class="recipe-costs",
                        [@dom.text("原価 ¥" + cost.to_string() + " → 売値 ¥" + price.to_string())],
                      ),
                    ],
                  )
                },
              ),
            ],
          ),
        ],
      ),
    ],
  )
}

/// Message log at the bottom
fn render_message_log(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="message-log",
    [
      @dom.for_each(
        fn() { state.message_log.get() },
        fn(msg, _i) {
          @dom.div(class="message-entry", [@dom.text(msg)])
        },
      ),
    ],
  )
}
