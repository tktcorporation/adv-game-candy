// バトル画面UI — ディフェンスゲームのメイン画面
//
// 上部: 拠点HPバー
// 中央: フィールド（味方・敵ユニットが移動）
// 下部: コストゲージ + 出撃ボタン

/// ゲームループのタイマーID（停止用）
let game_timer_id : Ref[Int] = { val: 0 }

/// バトル画面全体
fn render_battle_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="battle-view",
    [
      render_battle_hud(state),
      render_battlefield(state),
      render_deploy_panel(state),
    ],
  )
}

/// HUD — 拠点HP + コスト + タイマー
fn render_battle_hud(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="battle-hud",
    [
      // 灯HP
      @dom.div(
        class="base-hp-bar",
        [
          @dom.span(class="hp-label", [@dom.text("灯 ")]),
          @dom.span(
            class="hp-value",
            [@dom.text_dyn(fn() {
              let snap = state.battle.get()
              snap.base_hp.to_string() + "/" + @game.base_hp.to_string()
            })],
          ),
        ],
      ),
      // 敵拠点HP
      @dom.div(
        class="enemy-hp-bar",
        [
          @dom.span(class="hp-label", [@dom.text("敵 ")]),
          @dom.span(
            class="hp-value",
            [@dom.text_dyn(fn() {
              let snap = state.battle.get()
              snap.enemy_base_hp.to_string()
            })],
          ),
        ],
      ),
      // コストゲージ
      @dom.div(
        class="cost-gauge",
        [@dom.text_dyn(fn() {
          let snap = state.battle.get()
          let cost = snap.cost_milli / 1000
          "コスト: " + cost.to_string() + "/" + @game.max_cost.to_string()
        })],
      ),
    ],
  )
}

/// 戦場フィールド — ユニット描画
fn render_battlefield(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="battlefield",
    [
      // 灯の城
      @dom.div(class="base-icon base-ally", [@dom.text("\u{1F3E0}")]),
      // 敵の城
      @dom.div(class="base-icon base-enemy", [@dom.text("\u{1F47E}")]),
      // 味方ユニット
      @dom.for_each(
        fn() { state.battle.get().allies },
        fn(unit, _i) { render_battle_unit(unit, true) },
      ),
      // 敵ユニット
      @dom.for_each(
        fn() { state.battle.get().enemies },
        fn(unit, _i) { render_battle_unit(unit, false) },
      ),
    ],
  )
}

/// 個別ユニット描画
fn render_battle_unit(unit : @data.BattleUnit, is_ally : Bool) -> @dom.DomNode {
  let cls = if is_ally { "battle-unit ally-unit" } else { "battle-unit enemy-unit" }
  // x座標をパーセンテージに変換（0-480px → 0-100%）
  let pct = unit.x * 100 / @game.field_width
  let style = "left:" + pct.to_string() + "%"
  @dom.div(
    class=cls,
    style~,
    [
      @dom.span(class="unit-emoji", [@dom.text(unit.emoji)]),
      // HPバー（簡易表示）
      @dom.div(
        class="unit-hp-bar",
        [
          @dom.div(
            class="unit-hp-fill",
            style="width:" + (unit.hp * 100 / unit.max_hp).to_string() + "%",
            [],
          ),
        ],
      ),
    ],
  )
}

/// 出撃パネル — 編成キャラのボタン
fn render_deploy_panel(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="deploy-panel",
    [
      @dom.div(
        class="deploy-buttons",
        [
          @dom.for_each(
            fn() {
              let formation = state.formation.get()
              let result : Array[@data.AllyDef] = []
              for ally_id in formation.ally_ids {
                match @data.get_ally_by_id(ally_id) {
                  Some(a) => result.push(a)
                  None => ()
                }
              }
              result
            },
            fn(ally, _i) { render_deploy_button(state, ally) },
          ),
        ],
      ),
      // 撤退ボタン
      @dom.div(
        class="battle-controls",
        [
          @dom.button(
            class="btn btn-secondary btn-small",
            on=@dom.events().click(fn(_e) { stop_battle(state) }),
            [@dom.text("撤退")],
          ),
        ],
      ),
    ],
  )
}

/// 出撃ボタン1つ分
fn render_deploy_button(
  state : @game.GameState,
  ally : @data.AllyDef
) -> @dom.DomNode {
  let ally_id = ally.id
  let cost = ally.deploy_cost
  @dom.button(
    class="deploy-btn",
    on=@dom.events().click(fn(_e) {
      let snap = state.battle.get()
      match @data.get_ally_by_id(ally_id) {
        Some(a) => {
          if @game.can_deploy(snap, a) {
            let new_snap = @game.deploy_ally(snap, a)
            state.battle.set(new_snap)
          }
        }
        None => ()
      }
    }),
    [
      @dom.span(class="deploy-emoji", [@dom.text(ally.emoji)]),
      @dom.span(class="deploy-name", [@dom.text(ally.name)]),
      @dom.span(
        class="deploy-cost",
        [@dom.text_dyn(fn() {
          let snap = state.battle.get()
          let cd = @game.get_cooldown(snap, ally_id)
          if cd > 0 {
            "CD:" + (cd / 60 + 1).to_string() + "s"
          } else {
            cost.to_string()
          }
        })],
      ),
    ],
  )
}

/// バトル開始
pub fn start_battle(state : @game.GameState, stage_id : Int) -> Unit {
  match @data.get_stage_by_id(stage_id) {
    Some(stage) => {
      state.current_stage_id.set(stage_id)
      state.battle.set(@game.create_battle_snapshot(stage))
      state.phase.set(@data.GamePhase::Battle)
      // ゲームループ開始（約60FPS: 16ms間隔）
      let timer = set_interval_ffi(
        fn() { tick_game_loop(state) },
        16,
      )
      game_timer_id.val = timer
    }
    None => ()
  }
}

/// ゲームループ1tick（setIntervalから呼ばれる）
fn tick_game_loop(state : @game.GameState) -> Unit {
  let stage_id = state.current_stage_id.get()
  match @data.get_stage_by_id(stage_id) {
    Some(stage) => {
      let snap = state.battle.get()
      let new_snap = @game.tick_battle(snap, stage)
      state.battle.set(new_snap)
      // 勝敗判定
      if new_snap.result != @data.BattleResult::InProgress {
        clear_interval_ffi(game_timer_id.val)
        handle_battle_end(state, stage, new_snap)
      }
    }
    None => ()
  }
}

/// バトル終了処理
fn handle_battle_end(
  state : @game.GameState,
  stage : @data.StageDef,
  snap : @game.BattleSnapshot
) -> Unit {
  match snap.result {
    Victory => @game.grant_battle_reward(state, stage, snap.tick)
    Defeat => @game.add_message(state, "敗北…編成を見直そう。")
    InProgress => ()
  }
  state.phase.set(@data.GamePhase::BattleResult)
}

/// 撤退（バトル中断）
fn stop_battle(state : @game.GameState) -> Unit {
  clear_interval_ffi(game_timer_id.val)
  @game.add_message(state, "撤退した。")
  state.phase.set(@data.GamePhase::Home)
}
