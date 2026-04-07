// DailyAction ビュー — Layer 1 の行動選択UI
//
// 手札4枚から選択。バフ状態とバフ消費/付与を明示表示。
// 「バフを積んでから大技」の戦略を視覚的にガイド。

/// 日常行動選択画面
fn render_daily_action_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="action-select-view",
    [
      // ヘッダー: ひよりの1日
      @dom.div(
        class="action-header",
        [@dom.text_dyn(fn() {
          let day = state.day.get()
          let weather = @data.get_weather(day)
          let weather_text = @data.weather_to_string(weather)
          "ひよりの1日。" + weather_text + "。"
        })],
      ),
      // バフ状態（最重要情報）
      @dom.div(
        class="buff-status",
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
          if s == "" { "バフなし — まず低コストカードでバフを積もう" } else { s }
        })],
      ),
      // 心の余裕ゲージ
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
      // 週チャレンジ目標（ミニ）
      @dom.div(
        class="weekly-goal-mini",
        [@dom.text_dyn(fn() { @game.get_weekly_goal_display(state) })],
      ),
      // ── 手札カード ──
      @dom.div(
        class="turn-choices",
        [
          @dom.div(
            class="choices-label",
            [@dom.text("── 今日の手札 ──")],
          ),
          @dom.for_each(
            fn() { state.hand.get() },
            fn(card, _i) { render_action_card(state, card) },
          ),
          @dom.show(
            fn() { state.hand.get().length() == 0 },
            fn() {
              @dom.div(
                class="hand-empty",
                [@dom.text("手札がない。")],
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
            on=@dom.events().click(fn(_e) { @game.leave_daily_action(state) }),
            [@dom.text("ホームに戻る")],
          ),
        ],
      ),
    ],
  )
}

/// 行動カード1枚分のUI（バフ付与/消費を明示）
fn render_action_card(
  state : @game.GameState,
  card : @data.ActionCard
) -> @dom.DomNode {
  let card_id = card.id
  let can_play = state.stamina.get() >= card.stamina_cost
  let has_buff = if card.consumes_buff != "" {
    @game.get_buff_count(state, card.consumes_buff) > 0
  } else {
    false
  }
  let buff_class = if has_buff { " buff-ready" } else { "" }
  let base_class = if can_play {
    "hand-card" + buff_class
  } else {
    "hand-card disabled"
  }

  @dom.div(
    class="hand-card-wrapper",
    [
      if can_play {
        @dom.button(
          class=base_class,
          on=@dom.events().click(fn(_e) { @game.play_daily_action(state, card_id) }),
          [
            // バフ消費可能バッジ
            if has_buff {
              @dom.div(
                class="buff-badge",
                [@dom.text(@game.buff_to_icon(card.consumes_buff) + " 効果UP!")],
              )
            } else {
              @dom.text("")
            },
            // カードヘッダー
            @dom.div(
              class="card-header",
              [
                @dom.span(class="card-name", [@dom.text(card.name)]),
                @dom.span(
                  class="card-cost",
                  [@dom.text(card.stamina_cost.to_string() + " 余裕")],
                ),
              ],
            ),
            // 説明
            @dom.div(
              class="card-desc",
              [@dom.text(card.description)],
            ),
            // 3軸パラメータ
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
            // バフ情報
            @dom.div(
              class="card-buff-info",
              [@dom.text(
                if card.grants_buff != "" {
                  "付与: " + @game.buff_to_icon(card.grants_buff) + @game.buff_to_string(card.grants_buff)
                } else if card.consumes_buff != "" {
                  "消費: " + @game.buff_to_icon(card.consumes_buff) + @game.buff_to_string(card.consumes_buff) + " → ×1.5"
                } else {
                  ""
                },
              )],
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
                  [@dom.text(card.stamina_cost.to_string() + " 余裕")],
                ),
              ],
            ),
            @dom.div(
              class="card-desc",
              [@dom.text("余裕不足")],
            ),
          ],
        )
      },
    ],
  )
}
