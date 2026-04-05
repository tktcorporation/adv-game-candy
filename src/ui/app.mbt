// メインUI — 定食屋「灯」に通うADV
//
// AP行動選択制のUI。
// Title → Story(ch0) → Home → ActionSelect → Scene → Home のサイクル。

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

/// ヘッダー — タイトルと基本ステータス
///
/// Title フェーズ以外で表示。AP と ★ を常時表示。
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
            [@dom.text_dyn(fn() { state.day.get().to_string() + "日目" })],
          ),
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
      // 親密度と★
      @dom.div(
        class="intimacy-display",
        [
          @dom.div(
            class="star-display",
            [@dom.text_dyn(fn() {
              @game.get_star_display(state.intimacy.get())
            })],
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
              pts.to_string() + " / " + next_threshold.to_string()
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
// ActionSelect ビュー
// =========================================================================

/// 行動選択画面 — 灯の中で何をするか選ぶ
fn render_action_select_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="action-select-view",
    [
      @dom.div(
        class="action-header",
        [@dom.text("灯の中。昼時。")],
      ),
      // AP表示
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
      // 行動カード: 食べる
      render_action_card(
        state,
        @data.ActionType::Eat,
        "食べる",
        "日替わりを食べる。ひよりも来るかも。",
      ),
      // 行動カード: 観察する
      render_action_card(
        state,
        @data.ActionType::Observe,
        "観察する",
        "店内を見回す。小さな発見があるかも。",
      ),
      // 行動カード: 丸山と話す
      render_action_card(
        state,
        @data.ActionType::Talk,
        "丸山と話す",
        "店主と世間話。ひよりの話が聞けるかも。",
      ),
      // 行動カード: 特別行動（★3以降）
      @dom.show(
        fn() { @game.get_intimacy_stars(state.intimacy.get()) >= 3 },
        fn() {
          render_action_card(
            state,
            @data.ActionType::Special,
            "特別行動",
            "もう少し踏み込んだことをしてみる。",
          )
        },
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

/// 行動カード — 各行動のUI
fn render_action_card(
  state : @game.GameState,
  action : @data.ActionType,
  name : String,
  description : String
) -> @dom.DomNode {
  let cost = @game.get_action_cost(action)
  @dom.div(
    class="action-card-wrapper",
    [
      @dom.show(
        fn() { @game.can_perform_action(state, action) },
        fn() {
          @dom.button(
            class="action-card",
            on=@dom.events().click(fn(_e) { @game.perform_action(state, action) }),
            [
              @dom.div(
                class="action-card-header",
                [
                  @dom.span(class="action-name", [@dom.text(name)]),
                  @dom.span(
                    class="action-cost",
                    [@dom.text(cost.to_string() + " AP")],
                  ),
                ],
              ),
              @dom.div(
                class="action-desc",
                [@dom.text(description)],
              ),
            ],
          )
        },
      ),
      @dom.show(
        fn() { !@game.can_perform_action(state, action) },
        fn() {
          @dom.div(
            class="action-card disabled",
            [
              @dom.div(
                class="action-card-header",
                [
                  @dom.span(class="action-name", [@dom.text(name)]),
                  @dom.span(
                    class="action-cost",
                    [@dom.text(cost.to_string() + " AP")],
                  ),
                ],
              ),
              @dom.div(
                class="action-desc",
                [@dom.text(description)],
              ),
            ],
          )
        },
      ),
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
