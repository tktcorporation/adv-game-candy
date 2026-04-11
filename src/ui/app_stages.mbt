// ステージ選択 + バトル結果 UI
//
// ステージ一覧: クリア済みは★表示、未クリアはロック表示。
// バトル結果: 勝利/敗北 + 星評価 + 報酬表示。

/// ステージ選択画面
fn render_stage_select_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="stage-select-view",
    [
      @dom.div(
        class="stage-header",
        [@dom.text("── ステージ選択 ──")],
      ),
      // 編成表示
      @dom.div(
        class="formation-display",
        [
          @dom.div(
            class="formation-label",
            [@dom.text("出撃編成:")],
          ),
          @dom.div(
            class="formation-icons",
            [@dom.text_dyn(fn() {
              let formation = state.formation.get()
              let mut s = ""
              for ally_id in formation.ally_ids {
                match @data.get_ally_by_id(ally_id) {
                  Some(a) => s = s + a.emoji + " "
                  None => ()
                }
              }
              s
            })],
          ),
        ],
      ),
      // ステージ一覧
      @dom.div(
        class="stage-list",
        [
          @dom.for_each(
            fn() { @data.get_all_stages() },
            fn(stage, _i) { render_stage_item(state, stage) },
          ),
        ],
      ),
      // 戻るボタン
      @dom.div(
        class="stage-footer",
        [
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) {
              state.phase.set(@data.GamePhase::Home)
            }),
            [@dom.text("ホームに戻る")],
          ),
        ],
      ),
    ],
  )
}

/// ステージ1つ分
fn render_stage_item(
  state : @game.GameState,
  stage : @data.StageDef
) -> @dom.DomNode {
  let stage_id = stage.id
  let unlocked_max = @game.get_unlocked_stage_max(state)
  let is_unlocked = stage_id <= unlocked_max
  let stars = @game.get_stage_stars(state, stage_id)
  let star_text = if stars >= 3 {
    "★★★"
  } else if stars >= 2 {
    "★★☆"
  } else if stars >= 1 {
    "★☆☆"
  } else {
    "☆☆☆"
  }

  if is_unlocked {
    @dom.button(
      class="stage-item unlocked",
      on=@dom.events().click(fn(_e) { start_battle(state, stage_id) }),
      [
        @dom.span(class="stage-id", [@dom.text(stage_id.to_string())]),
        @dom.span(class="stage-name", [@dom.text(stage.name)]),
        @dom.span(class="stage-stars", [@dom.text(star_text)]),
      ],
    )
  } else {
    @dom.div(
      class="stage-item locked",
      [
        @dom.span(class="stage-id", [@dom.text(stage_id.to_string())]),
        @dom.span(class="stage-name", [@dom.text("\u{1F512}")]),
        @dom.span(class="stage-stars", [@dom.text("☆☆☆")]),
      ],
    )
  }
}

/// バトル結果画面
fn render_battle_result_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="battle-result-view",
    [
      @dom.div(
        class="result-header",
        [@dom.text_dyn(fn() {
          let snap = state.battle.get()
          match snap.result {
            Victory => "勝利！"
            Defeat => "敗北…"
            InProgress => ""
          }
        })],
      ),
      // 星評価（勝利時のみ）
      @dom.show(
        fn() { state.battle.get().result == @data.BattleResult::Victory },
        fn() {
          @dom.div(
            class="result-stars",
            [@dom.text_dyn(fn() {
              let stage_id = state.current_stage_id.get()
              let stars = @game.get_stage_stars(state, stage_id)
              let mut s = ""
              for i = 0; i < 3; i = i + 1 {
                if i < stars { s = s + "★" } else { s = s + "☆" }
              }
              s
            })],
          )
        },
      ),
      // ステージ名
      @dom.div(
        class="result-stage-name",
        [@dom.text_dyn(fn() {
          let stage_id = state.current_stage_id.get()
          match @data.get_stage_by_id(stage_id) {
            Some(s) => s.name
            None => ""
          }
        })],
      ),
      // ボタン
      @dom.div(
        class="result-actions",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) {
              state.phase.set(@data.GamePhase::StageSelect)
            }),
            [@dom.text("ステージ選択へ")],
          ),
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) {
              state.phase.set(@data.GamePhase::Home)
            }),
            [@dom.text("ホームに戻る")],
          ),
        ],
      ),
    ],
  )
}
