// バトル画面UI — Pixi.js v8 レンダラー連携版
//
// 戦場フィールドはPixi.js (WebGL) で描画。
// HUD（拠点HP、コスト）と出撃パネルはDOM (luna.mbt)。
// 毎tickでMoonBitのゲームロジック→FFI→Pixi.js描画を同期。

/// ゲームループのタイマーID（停止用）
let game_timer_id : Ref[Int] = { val: 0 }

/// バトル画面全体
fn render_battle_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="battle-view",
    [
      render_battle_hud(state),
      // Pixi.jsのCanvas配置用コンテナ
      @dom.div(class="battlefield", id="pixi-battlefield", []),
      render_deploy_panel(state),
    ],
  )
}

/// HUD — 拠点HP + コスト（テキストゲージ表示）
fn render_battle_hud(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="battle-hud",
    [
      // 灯HP
      @dom.div(
        class="hud-hp-section",
        [
          @dom.span(class="hp-icon", [@dom.text("\u{1F3E0}")]),
          @dom.span(
            class="hp-bar-text",
            [@dom.text_dyn(fn() {
              let snap = state.battle.get()
              build_bar(snap.base_hp, @game.base_hp, 15, true)
            })],
          ),
        ],
      ),
      // 敵拠点HP
      @dom.div(
        class="hud-hp-section",
        [
          @dom.span(class="hp-icon", [@dom.text("\u{1F47E}")]),
          @dom.span(
            class="hp-bar-text",
            [@dom.text_dyn(fn() {
              let snap = state.battle.get()
              let stage_id = state.current_stage_id.get()
              let max_hp = match @data.get_stage_by_id(stage_id) {
                Some(s) => s.enemy_base_hp
                None => 1
              }
              build_bar(snap.enemy_base_hp, max_hp, 15, false)
            })],
          ),
        ],
      ),
      // コストゲージ
      @dom.div(
        class="hud-cost-section",
        [@dom.text_dyn(fn() {
          let snap = state.battle.get()
          let cost = snap.cost_milli / 1000
          let pct = cost * 10 / @game.max_cost
          let mut bar = "COST "
          for i in 0..<10 {
            if i < pct { bar = bar + "\u{2593}" } else { bar = bar + "\u{2591}" }
          }
          bar + " " + cost.to_string()
        })],
      ),
    ],
  )
}

/// HPバーをテキストで描画（▓▓▓░░░ 形式）
fn build_bar(
  current : Int,
  max : Int,
  width : Int,
  is_ally : Bool
) -> String {
  let filled = if max > 0 {
    let f = current * width / max
    if f > width { width } else if f < 0 { 0 } else { f }
  } else {
    0
  }
  let mut bar = ""
  for i in 0..<width {
    if i < filled {
      bar = bar + "\u{2593}"
    } else {
      bar = bar + "\u{2591}"
    }
  }
  let label = if is_ally { "" } else { "" }
  label + bar + " " + current.to_string() + "/" + max.to_string()
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

/// バトル開始 — Pixi.jsレンダラー初期化 + ゲームループ開始
pub fn start_battle(state : @game.GameState, stage_id : Int) -> Unit {
  match @data.get_stage_by_id(stage_id) {
    Some(stage) => {
      state.current_stage_id.set(stage_id)
      state.battle.set(@game.create_battle_snapshot(stage))
      state.phase.set(@data.GamePhase::Battle)
      // Pixi.jsレンダラー初期化
      init_renderer_ffi("pixi-battlefield")
      // ゲームループ開始
      let timer = set_interval_ffi(fn() { tick_game_loop(state) }, 16)
      game_timer_id.val = timer
    }
    None => ()
  }
}

/// ゲームループ1tick — ロジック更新 + Pixi.js描画同期
fn tick_game_loop(state : @game.GameState) -> Unit {
  let stage_id = state.current_stage_id.get()
  match @data.get_stage_by_id(stage_id) {
    Some(stage) => {
      let old_snap = state.battle.get()
      let new_snap = @game.tick_battle(old_snap, stage)
      state.battle.set(new_snap)
      sync_renderer(old_snap, new_snap)
      if new_snap.result != @data.BattleResult::InProgress {
        clear_interval_ffi(game_timer_id.val)
        handle_battle_end(state, stage, new_snap)
      }
    }
    None => ()
  }
}

/// Pixi.jsとの描画同期（差分検出で生成/更新/削除）
fn sync_renderer(
  old_snap : @game.BattleSnapshot,
  new_snap : @game.BattleSnapshot
) -> Unit {
  sync_units(old_snap.allies, new_snap.allies, true)
  sync_units(old_snap.enemies, new_snap.enemies, false)
}

/// ユニット配列の差分同期
fn sync_units(
  old_units : Array[@data.BattleUnit],
  new_units : Array[@data.BattleUnit],
  is_ally : Bool
) -> Unit {
  // 新規: newにいてoldにいない → spawn
  for nu in new_units {
    let mut found = false
    for ou in old_units {
      if ou.uid == nu.uid { found = true; break }
    }
    if !found {
      spawn_unit_ffi(nu.uid, nu.emoji, nu.x, is_ally)
    }
  }
  // 更新: newにいる全ユニット → update
  for nu in new_units {
    let hp_ratio = nu.hp.to_double() / nu.max_hp.to_double()
    update_unit_ffi(nu.uid, nu.x, hp_ratio)
  }
  // 削除: oldにいてnewにいない → remove
  for ou in old_units {
    let mut found = false
    for nu in new_units {
      if nu.uid == ou.uid { found = true; break }
    }
    if !found { remove_unit_ffi(ou.uid) }
  }
}

fn handle_battle_end(
  state : @game.GameState,
  stage : @data.StageDef,
  snap : @game.BattleSnapshot
) -> Unit {
  destroy_renderer_ffi()
  match snap.result {
    Victory => @game.grant_battle_reward(state, stage, snap.tick)
    Defeat => @game.add_message(state, "敗北…編成を見直そう。")
    InProgress => ()
  }
  state.phase.set(@data.GamePhase::BattleResult)
}

fn stop_battle(state : @game.GameState) -> Unit {
  clear_interval_ffi(game_timer_id.val)
  destroy_renderer_ffi()
  @game.add_message(state, "撤退した。")
  state.phase.set(@data.GamePhase::Home)
}
