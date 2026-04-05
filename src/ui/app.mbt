// メインUI — 定食屋「灯」に通うADV

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
            fn() { state.phase.get() == @data.GamePhase::Visit },
            fn() { render_visit_view(state) },
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
            fn() { state.phase.get() == @data.GamePhase::Calendar },
            fn() { render_calendar_view(state) },
          ),
        ],
      ),
      render_message_log(state),
    ],
  )
}

/// ヘッダー — タイトルと基本ステータス
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
            class="stat",
            [@dom.text_dyn(fn() {
              let pts = state.intimacy.get()
              let stars = @game.get_intimacy_stars(pts)
              "親密度 " + pts.to_string() + " (★" + stars.to_string() + ")"
            })],
          ),
        ],
      ),
    ],
  )
}

/// Visit ビュー — 灯を訪問する画面
///
/// 今日の日替わりメニューを表示し、「灯に入る」ボタンで訪問する。
/// 訪問済みなら「次の日へ」ボタンを表示。
fn render_visit_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="visit-view",
    [
      @dom.h2(class="section-title", [@dom.text("灯")]),
      // 今日の日替わり表示
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
      // アクションボタン
      @dom.div(
        class="visit-actions",
        [
          // 未訪問なら「灯に入る」
          @dom.show(
            fn() { !state.visited_today.get() },
            fn() {
              @dom.button(
                class="btn btn-primary btn-large",
                on=@dom.events().click(fn(_e) { @game.visit_akari(state) }),
                [@dom.text("灯に入る")],
              )
            },
          ),
          // 訪問済みなら「次の日へ」
          @dom.show(
            fn() { state.visited_today.get() },
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
      // 親密度バー
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
          "親密度 " + pts.to_string() + " / " + next_threshold.to_string()
        })],
      ),
      // 味の記憶ボタン
      @dom.div(
        class="calendar-link",
        [
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) {
              state.phase.set(@data.GamePhase::Calendar)
            }),
            [@dom.text("味の記憶")],
          ),
        ],
      ),
    ],
  )
}

/// Scene ビュー — ひとくちシーン表示
///
/// 短いテキスト（1-3行）を表示し、ストーリー解放 or 次の日へ。
fn render_scene_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="scene-view",
    [
      // メニュー名
      @dom.div(
        class="scene-menu",
        [@dom.text_dyn(fn() { state.today_menu.get() })],
      ),
      // ひとくちシーンテキスト
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

/// Calendar ビュー — 味の記憶（訪問記録の一覧）
///
/// コレクション要素。訪問した日のメニューとひとくちシーンを振り返る。
fn render_calendar_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="calendar-view",
    [
      @dom.div(
        class="calendar-header",
        [
          @dom.h2(class="section-title", [@dom.text("味の記憶")]),
          @dom.button(
            class="btn btn-close",
            on=@dom.events().click(fn(_e) {
              state.phase.set(@data.GamePhase::Visit)
            }),
            [@dom.text("×")],
          ),
        ],
      ),
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
              // menu_id から名前を引く
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
