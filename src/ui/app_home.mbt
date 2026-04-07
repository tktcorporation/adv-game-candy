// Home ビュー — 2層アーキテクチャのハブ画面
//
// Layer 1（日常行動）とLayer 2（灯訪問）の入口。
// バフ状態・週チャレンジ目標・灯ポイントを常時表示。

/// ホーム画面
fn render_home_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="home-view",
    [
      // ♡ 親密度 + 関係性テキスト
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
      // ── 今週の目標（週チャレンジ） ──
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
      // ── バフ状態 ──
      @dom.div(
        class="buff-display",
        [@dom.text_dyn(fn() {
          let comfort = state.buff_comfort.get()
          let curiosity = state.buff_curiosity.get()
          let courage = state.buff_courage.get()
          let mut s = ""
          if comfort > 0 {
            s = s + "♨安心×" + comfort.to_string() + " "
          }
          if curiosity > 0 {
            s = s + "✧好奇心×" + curiosity.to_string() + " "
          }
          if courage > 0 {
            s = s + "⚡勇気×" + courage.to_string() + " "
          }
          if s == "" {
            "バフなし"
          } else {
            s
          }
        })],
      ),
      // ── 心の余裕ゲージ ──
      @dom.div(
        class="stamina-gauge",
        [@dom.text_dyn(fn() {
          let stamina = state.stamina.get()
          let max = @game.base_stamina
          let mut dots = ""
          for i in 0..<max {
            if i < stamina {
              dots = dots + "●"
            } else {
              dots = dots + "○"
            }
          }
          "心の余裕 " + dots + " (" + stamina.to_string() + "/" + max.to_string() + ")"
        })],
      ),
      // メインアクションボタン群
      @dom.div(
        class="home-actions",
        [
          // Layer 1: 日常行動
          @dom.show(
            fn() { state.stamina.get() > 0 },
            fn() {
              @dom.button(
                class="btn btn-primary btn-large",
                on=@dom.events().click(fn(_e) { @game.go_to_daily_action(state) }),
                [@dom.text("今日の行動")],
              )
            },
          ),
          // Layer 2: 灯に行く（新章解放時に ✦ マーク）
          @dom.button(
            class="btn btn-secondary btn-large",
            on=@dom.events().click(fn(_e) { @game.go_to_visit(state) }),
            [@dom.text_dyn(fn() {
              let has_new_story = has_unlocked_story(state)
              let points = state.akari_points.get()
              let cost = @game.visit_cost
              if has_new_story && points >= cost {
                "✦ 灯に行く（" + points.to_string() + "/" + cost.to_string() + "灯P）"
              } else {
                "灯に行く（" + points.to_string() + "/" + cost.to_string() + "灯P）"
              }
            })],
          ),
          // 灯Pゲージ（ボタン直下にインライン表示）
          @dom.div(
            class="akari-gauge-inline",
            [@dom.text_dyn(fn() { build_akari_gauge(state) })],
          ),
          // 次の日へ
          @dom.show(
            fn() { state.stamina.get() == 0 },
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
      // 余裕残りがあっても次の日へ行けるボタン
      @dom.show(
        fn() { state.stamina.get() > 0 && state.today_actions.get().length() > 0 },
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
                    [@dom.text("+" + mission.reward.to_string() + "灯P")],
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
              "  灯P " + state.akari_points.get().to_string() +
              "  来店 " + state.total_visits.get().to_string() + "回"
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
            [@dom.text_dyn(fn() {
              if has_unlocked_story(state) {
                "アルバム ●"
              } else {
                "アルバム"
              }
            })],
          ),
        ],
      ),
    ],
  )
}

/// 未読のストーリーが解放されているか判定（ブルアカ風NEWバッジ用）
///
/// 次章の unlock_visit_count を満たしているが、まだ読んでいない状態。
/// Home画面の灯ボタン ✦ マークとアルバムボタン ● マークに使用。
fn has_unlocked_story(state : @game.GameState) -> Bool {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()
  let visits = state.total_visits.get()
  if current + 1 < chapters.length() {
    visits >= chapters[current + 1].unlock_visit_count
  } else {
    false
  }
}

/// 灯Pゲージ — ▓▓▓░░░░░░░ 形式のインラインゲージ
///
/// 「灯に行く」ボタン直下に配置。
/// 満タン時は ★ マークで「行ける！」を視覚的に伝える。
fn build_akari_gauge(state : @game.GameState) -> String {
  let points = state.akari_points.get()
  let cost = @game.visit_cost
  let width = 10
  if points >= cost {
    let mut bar = ""
    for _i in 0..<width {
      bar = bar + "▓"
    }
    bar + " ★"
  } else {
    let filled = points * width / cost
    let mut bar = ""
    for i in 0..<width {
      if i < filled {
        bar = bar + "▓"
      } else {
        bar = bar + "░"
      }
    }
    bar
  }
}
