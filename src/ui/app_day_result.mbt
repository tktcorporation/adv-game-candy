// DayResult ビュー — 1日の成果まとめ
//
// 設計意図: ブルアカのステージクリア画面を参考に、
// プレイヤーが「今日何をして何を得たか」を振り返れるようにする。

/// DayResult画面 — 1日の記録と明日の目標を表示
///
/// build_day_result() が生成した DayResultData を表示する。
/// 「次の日へ」ボタンで advance_to_next_day() を呼び、翌日へ遷移する。
fn render_day_result_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="day-result-view",
    [
      // タイトル
      @dom.div(
        class="day-result-title",
        [@dom.text_dyn(fn() {
          "── " + state.day.get().to_string() + "日目の記録 ──"
        })],
      ),
      // 行動回数
      @dom.div(
        class="day-result-actions",
        [@dom.text_dyn(fn() {
          "今日の行動: " + state.day_result.get().cards_played.to_string() + "回"
        })],
      ),
      // パラメータ変化
      @dom.div(
        class="day-result-gains",
        [@dom.text_dyn(fn() {
          let r = state.day_result.get()
          let mut s = ""
          if r.trust_gained > 0 {
            s = s + "信頼 +" + r.trust_gained.to_string() + "  "
          }
          if r.understanding_gained > 0 {
            s = s + "理解 +" + r.understanding_gained.to_string() + "  "
          }
          if r.empathy_gained > 0 {
            s = s + "共感 +" + r.empathy_gained.to_string() + "  "
          }
          let total = r.trust_gained + r.understanding_gained + r.empathy_gained
          if total > 0 {
            s = s + "♡ +" + total.to_string()
          }
          s
        })],
      ),
      // 親密度レベルアップ
      @dom.show(
        fn() { state.day_result.get().affection_level_up },
        fn() {
          @dom.div(
            class="day-result-levelup",
            [@dom.text_dyn(fn() {
              let r = state.day_result.get()
              "♡ 親密度 → Lv" + r.new_affection_level.to_string() + " UP!"
            })],
          )
        },
      ),
      // プレイヤーレベルアップ
      @dom.show(
        fn() {
          // PLv変化があった場合（day_start_affection_levelの類似パターンで検出）
          state.day_result.get().new_player_level > 1
        },
        fn() {
          @dom.div(
            class="day-result-plv",
            [@dom.text_dyn(fn() {
              "PLv " + state.day_result.get().new_player_level.to_string()
            })],
          )
        },
      ),
      // 通貨獲得
      @dom.div(
        class="day-result-currency",
        [@dom.text_dyn(fn() {
          let r = state.day_result.get()
          let mut s = "コイン +" + r.coins_earned.to_string()
          if r.gems_earned > 0 {
            s = s + "  星石 +" + r.gems_earned.to_string()
          }
          if r.passive_coins > 0 {
            s = s + "  (パッシブ +" + r.passive_coins.to_string() + ")"
          }
          s
        })],
      ),
      // 明日の目標
      @dom.div(
        class="day-result-next",
        [
          @dom.div(
            class="day-result-next-header",
            [@dom.text("── 明日の目標 ──")],
          ),
          @dom.div(
            class="day-result-next-story",
            [@dom.text_dyn(fn() {
              let current_ch = state.current_chapter.get()
              let chapters = @data.get_chapters()
              let player_lv = state.player_level.get()
              let exp = state.player_exp.get()
              if current_ch + 1 < chapters.length() {
                let next = chapters[current_ch + 1]
                let needed_lv = next.unlock_player_level
                if player_lv >= needed_lv {
                  "📖 次の章が読めます！"
                } else {
                  let exp_to_next = @game.exp_for_next_level(player_lv) - exp
                  "📖 " + next.title + "まで: PLv" + needed_lv.to_string() + " (EXP あと" + exp_to_next.to_string() + ")"
                }
              } else {
                "📖 全章クリア済み"
              }
            })],
          ),
          @dom.div(
            class="day-result-next-affection",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              let milestones = @data.get_affection_milestones()
              let mut next_milestone = 0
              for m in milestones {
                if m.level > level {
                  next_milestone = m.level
                  break
                }
              }
              if next_milestone > 0 {
                "♡ 次のマイルストーン: Lv" + next_milestone.to_string()
              } else {
                ""
              }
            })],
          ),
        ],
      ),
      // ボタン
      @dom.div(
        class="day-result-btn",
        [
          @dom.button(
            class="btn btn-primary btn-large",
            on=@dom.events().click(fn(_e) { @game.advance_to_next_day(state) }),
            [@dom.text("次の日へ")],
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
