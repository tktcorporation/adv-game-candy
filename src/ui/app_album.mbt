// Album ビュー — 味の記憶・発見ノート・会話メモ・ストーリー回想・思い出コレクション

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
