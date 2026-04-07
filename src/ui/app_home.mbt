// Home ビュー — 学マス参考リデザイン版
//
// 情報階層:
// ♡親密度+関係性テキスト → 今週の目標（週イベント） → ひよりの気分 → 日替わり → アクション → ミッション → ステータス
//
// 学マス参考: 目標の常時表示 + コンディション表示
// ブルアカ参考: ♡+数字のシンプルさ

/// ホーム画面（学マス参考リデザイン版）
fn render_home_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="home-view",
    [
      // ♡ 親密度 + 関係性テキスト（画面上部に大きく）
      @dom.div(
        class="affection-display",
        [
          @dom.div(
            class="affection-level",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              let next_pts = @game.affection_points_for_level(level + 1)
              let current_pts = state.intimacy.get()
              "♡ 親密度 Lv" + level.to_string() + " (" + current_pts.to_string() + "/" + next_pts.to_string() + ")"
            })],
          ),
          @dom.div(
            class="affection-desc",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              @data.get_affection_description(level)
            })],
          ),
        ],
      ),
      // ── 今週の目標（週イベント） ──
      @dom.div(
        class="weekly-event-goal",
        [
          @dom.div(
            class="weekly-goal-header",
            [@dom.text("── 今週の目標 ──")],
          ),
          @dom.div(
            class="weekly-goal-content",
            [@dom.text_dyn(fn() { @game.get_weekly_goal_display(state) })],
          ),
        ],
      ),
      // ── ひよりの気分 ──
      @dom.div(
        class="mood-preview",
        [
          @dom.div(
            class="mood-preview-icon",
            [@dom.text_dyn(fn() {
              let mood = state.mood.get()
              @game.mood_to_icon(mood) + " " + @game.mood_to_string(mood)
            })],
          ),
          @dom.div(
            class="mood-preview-desc",
            [@dom.text_dyn(fn() { @game.mood_to_description(state.mood.get()) })],
          ),
        ],
      ),
      // 次の目標セクション（ストーリー進行）
      @dom.div(
        class="next-goal",
        [
          @dom.div(
            class="next-goal-header",
            [@dom.text("── ストーリー ──")],
          ),
          @dom.div(
            class="next-goal-content",
            [@dom.text_dyn(fn() {
              let current_ch = state.current_chapter.get()
              let chapters = @data.get_chapters()
              let player_lv = state.player_level.get()
              let exp = state.player_exp.get()
              if current_ch + 1 < chapters.length() {
                let next = chapters[current_ch + 1]
                let needed_lv = next.unlock_player_level
                let chapter_label = next.title + " 「" + next.subtitle + "」"
                if player_lv >= needed_lv {
                  chapter_label + " — 読めます！"
                } else {
                  let exp_to_next = @game.exp_for_next_level(player_lv) - exp
                  chapter_label + " — PLv" + needed_lv.to_string() + " (EXP あと" + exp_to_next.to_string() + ")"
                }
              } else {
                "全章クリア済み"
              }
            })],
          ),
          // PLv進捗バー
          @dom.div(
            class="plv-progress",
            [@dom.text_dyn(fn() {
              let player_lv = state.player_level.get()
              let exp = state.player_exp.get()
              let needed = @game.exp_for_next_level(player_lv)
              let filled = if needed > 0 { exp * 10 / needed } else { 10 }
              let mut bar = "PLv" + player_lv.to_string() + " "
              for i in 0..<10 {
                if i < filled {
                  bar = bar + "█"
                } else {
                  bar = bar + "░"
                }
              }
              bar = bar + " " + exp.to_string() + "/" + needed.to_string()
              bar
            })],
          ),
        ],
      ),
      // 今日の日替わり
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
      // AP ゲージ
      @dom.div(
        class="ap-gauge",
        [@dom.text_dyn(fn() {
          let ap = state.ap.get()
          let max_ap = @game.get_max_ap(state)
          let mut dots = ""
          for i in 0..<max_ap {
            if i < ap {
              dots = dots + "●"
            } else {
              dots = dots + "○"
            }
          }
          "AP " + dots + " (" + ap.to_string() + "/" + max_ap.to_string() + ")"
        })],
      ),
      // AP が残っていても次の日へ行けるボタン
      @dom.show(
        fn() { state.ap.get() > 0 && state.ap.get() < @game.get_max_ap(state) },
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
      // ステータス（3軸 + 通貨）
      @dom.div(
        class="home-status",
        [
          @dom.div(
            class="param-summary",
            [@dom.text_dyn(fn() {
              "信頼 " + state.trust.get().to_string() +
              " ▸ 理解 " + state.understanding.get().to_string() +
              " ▸ 共感 " + state.empathy.get().to_string()
            })],
          ),
          @dom.div(
            class="currency-display",
            [@dom.text_dyn(fn() {
              "コイン " + state.coins.get().to_string() +
              "  星石 " + state.gems.get().to_string()
            })],
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
