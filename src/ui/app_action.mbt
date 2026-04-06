// ActionSelect ビュー — 手札カードUIと行動選択

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
          for i in 0..<@game.base_ap {
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
/// カード名・説明・APコスト・実効パラメータ値・♡合計を表示。
/// 実効値は preview_card_gains() で計算（★ランク・レベル・メモリーボーナス反映済み）。
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
  // 実効値を計算（base値ではなくスケーリング後の値）
  let (eff_t, eff_u, eff_e) = @game.preview_card_gains(state, card)
  let total_gain = eff_t + eff_u + eff_e
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
            // 3軸パラメータ（実効値）
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
            // ♡合計寄与（親密度にどれだけ進むか一目で分かる）
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
