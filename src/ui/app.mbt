// メインUI — 定食屋「灯」に通うADV
//
// カードシステムUI。手札から行動カードを選んでプレイする。
// Title → Story(ch0) → Home → ActionSelect(手札) → Scene → Home のサイクル。
// ヘッダーに3軸パラメータ・季節・天候を表示。

/// 季節に対応するCSSクラス名を返す
fn season_class(state : @game.GameState) -> String {
  let day = state.day.get()
  let season = @data.get_season(day)
  match season {
    Spring => "season-spring"
    Summer => "season-summer"
    Autumn => "season-autumn"
    Winter => "season-winter"
  }
}

/// 天候に対応するCSSクラス名を返す
fn weather_class(state : @game.GameState) -> String {
  let day = state.day.get()
  let weather = @data.get_weather(day)
  match weather {
    Rainy => "weather-rainy"
    Snowy => "weather-snowy"
    _ => ""
  }
}

/// メインアプリコンポーネント
pub fn app(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="app",
    [
      render_header(state),
      @dom.div(
        class="main-content",
        [
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Title },
            fn() { render_title_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Home },
            fn() { render_home_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::ActionSelect },
            fn() { render_action_select_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Scene },
            fn() { render_scene_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Story },
            fn() { render_story_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Album },
            fn() { render_album_view(state) },
          ),
        ],
      ),
      render_message_log(state),
    ],
  )
}

// =========================================================================
// ヘッダー
// =========================================================================

/// ヘッダー — ステータス表示
///
/// Title フェーズ以外で表示。3軸パラメータ・季節・天候・AP を常時表示。
fn render_header(state : @game.GameState) -> @dom.DomNode {
  @dom.header_(
    class="game-header",
    [
      @dom.div(
        class="header-title",
        [
          @dom.h1(class="title", [@dom.text("灯")]),
          // 季節・天候・日数
          @dom.span(
            class="subtitle",
            [@dom.text_dyn(fn() {
              let day = state.day.get()
              let season = @data.get_season(day)
              let weather = @data.get_weather(day)
              let day_in_season = @data.get_day_in_season(day)
              let s = @data.season_to_string(season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(weather)
              s
            })],
          ),
        ],
      ),
      // 3軸パラメータバー
      @dom.div(
        class="header-params",
        [
          @dom.span(
            class="param param-trust",
            [@dom.text_dyn(fn() { "信頼 " + state.trust.get().to_string() })],
          ),
          @dom.span(
            class="param param-understanding",
            [@dom.text_dyn(fn() { "理解 " + state.understanding.get().to_string() })],
          ),
          @dom.span(
            class="param param-empathy",
            [@dom.text_dyn(fn() { "共感 " + state.empathy.get().to_string() })],
          ),
        ],
      ),
      @dom.div(
        class="header-stats",
        [
          @dom.span(
            class="stat stat-stars",
            [@dom.text_dyn(fn() {
              @game.get_star_display(state.intimacy.get())
            })],
          ),
          @dom.span(
            class="stat stat-ap",
            [@dom.text_dyn(fn() {
              "AP " + state.ap.get().to_string() + "/" + @game.max_ap.to_string()
            })],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// Title ビュー
// =========================================================================

/// タイトル画面 — 初回起動時のみ表示
fn render_title_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="title-view",
    [
      @dom.div(
        class="title-logo",
        [@dom.text("灯")],
      ),
      @dom.div(
        class="title-tagline",
        [@dom.text("定食屋の片隅で、少しずつ近づく二人の物語")],
      ),
      @dom.button(
        class="btn btn-primary btn-large",
        on=@dom.events().click(fn(_e) { @game.start_game(state) }),
        [@dom.text("はじめる")],
      ),
    ],
  )
}

// =========================================================================
// Home ビュー
// =========================================================================

/// ホーム画面 — 日付・AP・今日の日替わり・ミッション・ボタン
fn render_home_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="home-view",
    [
      // 日付表示
      @dom.div(
        class="home-date",
        [@dom.text_dyn(fn() { state.day.get().to_string() + "日目" })],
      ),
      // 今日の日替わりカード
      @dom.div(
        class="daily-menu-card",
        [
          @dom.div(
            class="menu-label",
            [@dom.text("今日の日替わり")],
          ),
          @dom.div(
            class="menu-name",
            [@dom.text_dyn(fn() {
              let menu = @data.get_today_menu(state.day.get())
              menu.name
            })],
          ),
          @dom.div(
            class="menu-desc",
            [@dom.text_dyn(fn() {
              let menu = @data.get_today_menu(state.day.get())
              menu.description
            })],
          ),
        ],
      ),
      // 3軸パラメータ表示
      @dom.div(
        class="params-display",
        [
          @dom.div(
            class="star-display",
            [@dom.text_dyn(fn() {
              @game.get_star_display(state.intimacy.get())
            })],
          ),
          @dom.div(
            class="param-bars",
            [
              @dom.div(
                class="param-bar param-trust",
                [@dom.text_dyn(fn() { "信頼 " + state.trust.get().to_string() })],
              ),
              @dom.div(
                class="param-bar param-understanding",
                [@dom.text_dyn(fn() { "理解 " + state.understanding.get().to_string() })],
              ),
              @dom.div(
                class="param-bar param-empathy",
                [@dom.text_dyn(fn() { "共感 " + state.empathy.get().to_string() })],
              ),
            ],
          ),
          @dom.div(
            class="intimacy-bar",
            [@dom.text_dyn(fn() {
              let pts = state.intimacy.get()
              let current_ch = state.current_chapter.get()
              let chapters = @data.get_chapters()
              let next_threshold = if current_ch + 1 < chapters.length() {
                chapters[current_ch + 1].unlock_intimacy
              } else {
                1000
              }
              "次の章まで " + pts.to_string() + " / " + next_threshold.to_string()
            })],
          ),
        ],
      ),
      // AP ゲージ
      @dom.div(
        class="ap-gauge",
        [@dom.text_dyn(fn() {
          let ap = state.ap.get()
          let mut dots = ""
          for i in 0..<@game.max_ap {
            if i < ap {
              dots = dots + "●"
            } else {
              dots = dots + "○"
            }
          }
          "AP " + dots
        })],
      ),
      // メインアクションボタン
      @dom.div(
        class="home-actions",
        [
          @dom.show(
            fn() { state.ap.get() > 0 },
            fn() {
              @dom.button(
                class="btn btn-primary btn-large",
                on=@dom.events().click(fn(_e) { @game.go_to_akari(state) }),
                [@dom.text("灯に行く")],
              )
            },
          ),
          @dom.show(
            fn() { state.ap.get() == 0 },
            fn() {
              @dom.button(
                class="btn btn-primary btn-large",
                on=@dom.events().click(fn(_e) { @game.next_day(state) }),
                [@dom.text("次の日へ")],
              )
            },
          ),
        ],
      ),
      // AP が残っていても次の日へ行けるボタン
      @dom.show(
        fn() { state.ap.get() > 0 && state.ap.get() < @game.max_ap },
        fn() {
          @dom.div(
            class="home-secondary-actions",
            [
              @dom.button(
                class="btn btn-secondary btn-small",
                on=@dom.events().click(fn(_e) { @game.next_day(state) }),
                [@dom.text("次の日へ")],
              ),
            ],
          )
        },
      ),
      // デイリーミッション
      @dom.div(
        class="daily-missions",
        [
          @dom.div(
            class="missions-header",
            [@dom.text("デイリー")],
          ),
          @dom.for_each(
            fn() { state.daily_missions.get() },
            fn(mission, _i) {
              @dom.div(
                class="mission-item",
                [
                  @dom.div(
                    class="mission-status",
                    [@dom.text(if mission.completed { "✓" } else { "○" })],
                  ),
                  @dom.div(
                    class="mission-desc",
                    [@dom.text(mission.description)],
                  ),
                  @dom.div(
                    class="mission-reward",
                    [@dom.text("+" + mission.reward.to_string())],
                  ),
                ],
              )
            },
          ),
        ],
      ),
      // フッターボタン
      @dom.div(
        class="home-footer",
        [
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) { @game.open_album(state) }),
            [@dom.text("アルバム")],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// ActionSelect ビュー — 手札カードUI
// =========================================================================

/// 行動選択画面 — 手札からカードを選んでプレイ
fn render_action_select_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="action-select-view",
    [
      @dom.div(
        class="action-header",
        [@dom.text_dyn(fn() {
          let day = state.day.get()
          let weather = @data.get_weather(day)
          let weather_text = @data.weather_to_string(weather)
          "灯の中。" + weather_text + "の昼時。"
        })],
      ),
      // AP ゲージ
      @dom.div(
        class="ap-gauge",
        [@dom.text_dyn(fn() {
          let ap = state.ap.get()
          let mut dots = ""
          for i in 0..<@game.max_ap {
            if i < ap {
              dots = dots + "●"
            } else {
              dots = dots + "○"
            }
          }
          "AP " + dots
        })],
      ),
      // 手札カード一覧
      @dom.div(
        class="hand-cards",
        [
          @dom.for_each(
            fn() { state.hand.get() },
            fn(card, _i) { render_hand_card(state, card) },
          ),
          // 手札が空のとき
          @dom.show(
            fn() { state.hand.get().length() == 0 },
            fn() {
              @dom.div(
                class="hand-empty",
                [@dom.text("今日の手札はすべて使いました。")],
              )
            },
          ),
        ],
      ),
      // 帰るボタン
      @dom.div(
        class="action-footer",
        [
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) { @game.leave_akari(state) }),
            [@dom.text("帰る")],
          ),
        ],
      ),
    ],
  )
}

/// 手札カード — 1枚分のUI
///
/// カード名・説明・APコスト・3軸パラメータ予告を表示。
/// APが足りない場合はdisabled表示。レアリティでボーダー色を変える。
fn render_hand_card(
  state : @game.GameState,
  card : @data.ActionCard
) -> @dom.DomNode {
  let card_id = card.id
  let can_play = state.ap.get() >= card.ap_cost
  let rarity_class = match card.rarity {
    Normal => "rarity-normal"
    Uncommon => "rarity-uncommon"
    Rare => "rarity-rare"
  }
  let base_class = if can_play {
    "hand-card " + rarity_class
  } else {
    "hand-card disabled " + rarity_class
  }
  @dom.div(
    class="hand-card-wrapper",
    [
      if can_play {
        @dom.button(
          class=base_class,
          on=@dom.events().click(fn(_e) { @game.play_card(state, card_id) }),
          [
            // カードヘッダー: 名前 + APコスト
            @dom.div(
              class="card-header",
              [
                @dom.span(class="card-name", [@dom.text(card.name)]),
                @dom.span(
                  class="card-cost",
                  [@dom.text(card.ap_cost.to_string() + " AP")],
                ),
              ],
            ),
            // カード説明
            @dom.div(
              class="card-desc",
              [@dom.text(card.description)],
            ),
            // 3軸パラメータ予告
            @dom.div(
              class="card-params",
              [
                @dom.show(
                  fn() { card.trust_gain > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-trust",
                      [@dom.text("信+" + card.trust_gain.to_string())],
                    )
                  },
                ),
                @dom.show(
                  fn() { card.understanding_gain > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-understanding",
                      [@dom.text("理+" + card.understanding_gain.to_string())],
                    )
                  },
                ),
                @dom.show(
                  fn() { card.empathy_gain > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-empathy",
                      [@dom.text("共+" + card.empathy_gain.to_string())],
                    )
                  },
                ),
              ],
            ),
          ],
        )
      } else {
        @dom.div(
          class=base_class,
          [
            @dom.div(
              class="card-header",
              [
                @dom.span(class="card-name", [@dom.text(card.name)]),
                @dom.span(
                  class="card-cost",
                  [@dom.text(card.ap_cost.to_string() + " AP")],
                ),
              ],
            ),
            @dom.div(
              class="card-desc",
              [@dom.text(card.description)],
            ),
            @dom.div(
              class="card-params",
              [
                @dom.span(
                  class="card-param",
                  [@dom.text("AP不足")],
                ),
              ],
            ),
          ],
        )
      },
    ],
  )
}

// =========================================================================
// Scene ビュー
// =========================================================================

/// Scene ビュー — 行動結果のテキスト表示
fn render_scene_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="scene-view",
    [
      // メニュー名
      @dom.div(
        class="scene-menu",
        [@dom.text_dyn(fn() { state.today_menu.get() })],
      ),
      // シーンテキスト
      @dom.div(
        class="scene-text",
        [@dom.text_dyn(fn() { state.today_scene_text.get() })],
      ),
      // ボタン
      @dom.div(
        class="scene-actions",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) { @game.finish_scene(state) }),
            [@dom.text_dyn(fn() {
              // 次の章が解放可能かチェック
              let current = state.current_chapter.get()
              let chapters = @data.get_chapters()
              if current + 1 < chapters.length() {
                let next = chapters[current + 1]
                if state.intimacy.get() >= next.unlock_intimacy {
                  "ストーリーが解放されました"
                } else {
                  "ごちそうさまでした"
                }
              } else {
                "ごちそうさまでした"
              }
            })],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// Story ビュー
// =========================================================================

/// Story ビュー — ADV形式のテキスト表示
fn render_story_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="story-view",
    [
      // 章タイトル
      @dom.div(
        class="chapter-header",
        [@dom.text_dyn(fn() {
          match @game.get_current_chapter(state) {
            Some(ch) => ch.title + " 「" + ch.subtitle + "」"
            None => ""
          }
        })],
      ),
      // テキスト表示エリア
      @dom.div(
        class="story-text-area",
        [
          // 話者名
          @dom.div(
            class="speaker-name",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.speaker
                None => ""
              }
            })],
          ),
          // テキスト本文
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
      // 進行ボタン
      @dom.div(
        class="story-controls",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) { @game.advance_story(state) }),
            [@dom.text_dyn(fn() {
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

// =========================================================================
// Album ビュー
// =========================================================================

/// アルバム画面 — 味の記憶・発見ノート・会話メモ・ストーリー回想
fn render_album_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-view",
    [
      // ヘッダー
      @dom.div(
        class="album-header",
        [
          @dom.h2(class="section-title", [@dom.text("アルバム")]),
          @dom.button(
            class="btn btn-close",
            on=@dom.events().click(fn(_e) { @game.close_album(state) }),
            [@dom.text("×")],
          ),
        ],
      ),
      // タブ
      @dom.div(
        class="album-tabs",
        [
          render_album_tab(state, 0, "味の記憶"),
          render_album_tab(state, 1, "発見ノート"),
          render_album_tab(state, 2, "会話メモ"),
          render_album_tab(state, 3, "ストーリー"),
          render_album_tab(state, 4, "思い出"),
        ],
      ),
      // タブコンテンツ
      // Tab 0: 味の記憶
      @dom.show(
        fn() { state.album_tab.get() == 0 },
        fn() { render_album_visits(state) },
      ),
      // Tab 1: 発見ノート
      @dom.show(
        fn() { state.album_tab.get() == 1 },
        fn() { render_album_discoveries(state) },
      ),
      // Tab 2: 会話メモ
      @dom.show(
        fn() { state.album_tab.get() == 2 },
        fn() { render_album_talks(state) },
      ),
      // Tab 3: ストーリー回想
      @dom.show(
        fn() { state.album_tab.get() == 3 },
        fn() { render_album_stories(state) },
      ),
      // Tab 4: 思い出コレクション
      @dom.show(
        fn() { state.album_tab.get() == 4 },
        fn() { render_album_memories(state) },
      ),
    ],
  )
}

/// アルバムタブボタン
fn render_album_tab(
  state : @game.GameState,
  tab_index : Int,
  label : String
) -> @dom.DomNode {
  @dom.button(
    class="album-tab",
    on=@dom.events().click(fn(_e) { state.album_tab.set(tab_index) }),
    [@dom.text(label)],
  )
}

/// アルバム: 味の記憶（訪問記録）
fn render_album_visits(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      // メニュー制覇状況
      @dom.div(
        class="menu-collection",
        [@dom.text_dyn(fn() {
          let all_menus = @data.get_daily_menus()
          let log = state.visit_log.get()
          let mut unique_count = 0
          for menu in all_menus {
            let mut found = false
            for record in log {
              if record.menu_id == menu.id {
                found = true
                break
              }
            }
            if found {
              unique_count = unique_count + 1
            }
          }
          "制覇: " +
          unique_count.to_string() +
          " / " +
          all_menus.length().to_string() +
          " メニュー"
        })],
      ),
      // 訪問記録リスト
      @dom.div(
        class="visit-log",
        [
          @dom.for_each(
            fn() { state.visit_log.get() },
            fn(record, _i) {
              let menus = @data.get_daily_menus()
              let mut menu_name = record.menu_id
              for m in menus {
                if m.id == record.menu_id {
                  menu_name = m.name
                  break
                }
              }
              @dom.div(
                class="visit-entry",
                [
                  @dom.div(
                    class="visit-day",
                    [@dom.text(record.day.to_string() + "日目")],
                  ),
                  @dom.div(
                    class="visit-menu",
                    [@dom.text(menu_name)],
                  ),
                  @dom.div(
                    class="visit-scene",
                    [@dom.text(record.scene_text)],
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

/// アルバム: 発見ノート
fn render_album_discoveries(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      @dom.for_each(
        fn() { state.discoveries.get() },
        fn(discovery, _i) {
          @dom.div(
            class="album-entry",
            [@dom.text(discovery)],
          )
        },
      ),
      @dom.show(
        fn() { state.discoveries.get().length() == 0 },
        fn() {
          @dom.div(
            class="album-empty",
            [@dom.text("まだ何も発見していない。灯で観察してみよう。")],
          )
        },
      ),
    ],
  )
}

/// アルバム: 会話メモ
fn render_album_talks(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      @dom.for_each(
        fn() { state.talk_memos.get() },
        fn(memo, _i) {
          @dom.div(
            class="album-entry",
            [@dom.text(memo)],
          )
        },
      ),
      @dom.show(
        fn() { state.talk_memos.get().length() == 0 },
        fn() {
          @dom.div(
            class="album-empty",
            [@dom.text("まだ丸山と話していない。灯で話しかけてみよう。")],
          )
        },
      ),
    ],
  )
}

/// アルバム: ストーリー回想
fn render_album_stories(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      @dom.div(
        class="album-story-list",
        [@dom.text_dyn(fn() {
          let chapters = @data.get_chapters()
          let current = state.current_chapter.get()
          let mut result = ""
          for i, ch in chapters {
            if i <= current {
              result = result + "✓ " + ch.title + " 「" + ch.subtitle + "」\n"
            } else {
              result = result + "？ " + ch.title + "\n"
            }
          }
          result
        })],
      ),
    ],
  )
}

// =========================================================================
// アルバム: 思い出コレクション
// =========================================================================

/// アルバム: 思い出コレクション
///
/// 全思い出の一覧。獲得済みはタイトルと説明、未獲得はヒントを表示。
/// 装備状態も表示。
fn render_album_memories(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content album-memories",
    [
      // 獲得数
      @dom.div(
        class="memory-count",
        [@dom.text_dyn(fn() {
          let all = @data.get_all_memories()
          let acquired = state.acquired_memories.get()
          acquired.length().to_string() + " / " + all.length().to_string() + " 獲得"
        })],
      ),
      // 思い出一覧
      @dom.div(
        class="memory-list",
        [@dom.text_dyn(fn() {
          let all = @data.get_all_memories()
          let acquired = state.acquired_memories.get()
          let mut result = ""
          for memory in all {
            let mut is_acquired = false
            for record in acquired {
              if record.memory_id == memory.id {
                is_acquired = true
                break
              }
            }
            if is_acquired {
              result = result + "✦ " + memory.title + "\n"
              result = result + "  " + memory.description + "\n"
              let bonus_text = "  [+" + memory.trust_bonus.to_string() + "信 +" + memory.understanding_bonus.to_string() + "理 +" + memory.empathy_bonus.to_string() + "共]\n\n"
              result = result + bonus_text
            } else {
              result = result + "？ ???\n"
              result = result + "  ヒント: " + memory.hint + "\n\n"
            }
          }
          result
        })],
      ),
    ],
  )
}

// =========================================================================
// メッセージログ
// =========================================================================

/// メッセージログ
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
