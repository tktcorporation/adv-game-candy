// ActionSelect ビュー — 学マス参考リデザイン版
//
// 旧: 手札4枚を並べて自由選択
// 新: 毎ターン3枚提示→1枚選択（学マスのレッスン選択方式）
//     + ひよりの気分表示（ムード一致でボーナス）
//     + コンボチェイン表示
//     + 週イベント目標の進捗バー

/// 行動選択画面（学マス参考リデザイン版）
fn render_action_select_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="action-select-view",
    [
      // ヘッダー: 天候 + ターン数
      @dom.div(
        class="action-header",
        [@dom.text_dyn(fn() {
          let day = state.day.get()
          let weather = @data.get_weather(day)
          let weather_text = @data.weather_to_string(weather)
          let turn = state.turn_number.get() + 1
          "灯の中。" + weather_text + "の昼時。（ターン" + turn.to_string() + "）"
        })],
      ),
      // ムード表示（ひよりの気分）— 最重要情報
      @dom.div(
        class="mood-display",
        [
          @dom.div(
            class="mood-icon",
            [@dom.text_dyn(fn() { @game.mood_to_icon(state.mood.get()) })],
          ),
          @dom.div(
            class="mood-text",
            [@dom.text_dyn(fn() { @game.mood_to_description(state.mood.get()) })],
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
      // コンボチェイン表示
      @dom.show(
        fn() { state.combo_chain.get() > 0 },
        fn() {
          @dom.div(
            class="combo-display",
            [@dom.text_dyn(fn() {
              let chain = state.combo_chain.get()
              let bonus = state.last_combo_bonus.get()
              let chain_mult = @game.get_chain_multiplier(chain)
              let mult_pct = chain_mult - 100
              "CHAIN x" + chain.to_string() + " (+" + mult_pct.to_string() + "%) — " + bonus.name
            })],
          )
        },
      ),
      // 週イベント目標（ミニ進捗バー）
      @dom.div(
        class="weekly-goal-mini",
        [@dom.text_dyn(fn() { @game.get_weekly_goal_display(state) })],
      ),
      // ── ターン選択肢: 3枚から1枚選ぶ ──
      @dom.div(
        class="turn-choices",
        [
          @dom.div(
            class="choices-label",
            [@dom.text("── 3枚から1枚を選べ ──")],
          ),
          @dom.for_each(
            fn() { state.turn_choices.get().cards },
            fn(card, _i) { render_choice_card(state, card) },
          ),
          // 選択肢が空のとき
          @dom.show(
            fn() { state.turn_choices.get().cards.length() == 0 },
            fn() {
              @dom.div(
                class="hand-empty",
                [@dom.text("APが尽きた。今日はここまで。")],
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

/// 選択肢カード — 1枚分のUI（ムード一致ハイライト付き）
///
/// ムード一致カードにはハイライトを付けて「今これを選ぶべき」感を出す。
/// 実効値のプレビューにムードボーナスも反映する。
fn render_choice_card(
  state : @game.GameState,
  card : @data.ActionCard
) -> @dom.DomNode {
  let card_id = card.id
  let can_play = state.ap.get() >= card.ap_cost
  let mood = state.mood.get()
  let mood_match = @game.is_mood_match(mood, card.category)

  let rarity_class = match card.rarity {
    Normal => "rarity-normal"
    Uncommon => "rarity-uncommon"
    Rare => "rarity-rare"
  }
  let mood_class = if mood_match { " mood-match" } else { "" }
  let base_class = if can_play {
    "hand-card " + rarity_class + mood_class
  } else {
    "hand-card disabled " + rarity_class
  }

  // 実効値を計算（ムードボーナス込み）
  let (base_t, base_u, base_e) = @game.preview_card_gains(state, card)
  let mood_mult = @game.get_mood_multiplier(mood, card.category)
  let eff_t = base_t * mood_mult / 100
  let eff_u = base_u * mood_mult / 100
  let eff_e = base_e * mood_mult / 100
  let total_gain = eff_t + eff_u + eff_e

  @dom.div(
    class="hand-card-wrapper",
    [
      if can_play {
        @dom.button(
          class=base_class,
          on=@dom.events().click(fn(_e) { @game.play_card(state, card_id) }),
          [
            // ムード一致バッジ
            if mood_match {
              @dom.div(
                class="mood-badge",
                [@dom.text(@game.mood_to_icon(mood) + " 効果UP!")],
              )
            } else {
              @dom.text("")
            },
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
            // 3軸パラメータ（ムードボーナス反映済み実効値）
            @dom.div(
              class="card-params",
              [
                @dom.show(
                  fn() { eff_t > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-trust",
                      [@dom.text("信+" + eff_t.to_string())],
                    )
                  },
                ),
                @dom.show(
                  fn() { eff_u > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-understanding",
                      [@dom.text("理+" + eff_u.to_string())],
                    )
                  },
                ),
                @dom.show(
                  fn() { eff_e > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-empathy",
                      [@dom.text("共+" + eff_e.to_string())],
                    )
                  },
                ),
              ],
            ),
            // ♡合計
            @dom.div(
              class="card-affection-total",
              [@dom.text("♡+" + total_gain.to_string())],
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
