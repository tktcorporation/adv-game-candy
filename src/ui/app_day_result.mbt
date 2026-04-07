// DayResult ビュー — 1日の成果まとめ
//
// 灯ポイント獲得量・バフ使用・週チャレンジ結果を表示。

/// DayResult画面
fn render_day_result_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="day-result-view",
    [
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
          "今日の行動: " + state.day_result.get().actions_taken.to_string() + "回"
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
      // 灯ポイント・コイン
      @dom.div(
        class="day-result-currency",
        [@dom.text_dyn(fn() {
          let r = state.day_result.get()
          "灯P " + state.akari_points.get().to_string() + "  コイン +" + r.coins_earned.to_string()
        })],
      ),
      // 週チャレンジ結果
      @dom.show(
        fn() { state.day_result.get().challenge_result != "" },
        fn() {
          @dom.div(
            class="day-result-challenge",
            [@dom.text_dyn(fn() {
              "週末チャレンジ: " + state.day_result.get().challenge_result + "ランク！"
            })],
          )
        },
      ),
      // 次の目標
      @dom.div(
        class="day-result-next",
        [
          @dom.div(
            class="day-result-next-header",
            [@dom.text("── 明日 ──")],
          ),
          @dom.div(
            class="day-result-next-story",
            [@dom.text_dyn(fn() {
              let current_ch = state.current_chapter.get()
              let chapters = @data.get_chapters()
              let visits = state.total_visits.get()
              if current_ch + 1 < chapters.length() {
                let next = chapters[current_ch + 1]
                if visits >= next.unlock_visit_count {
                  "灯で新しい物語が読めます！"
                } else {
                  next.title + "まで: あと" + (next.unlock_visit_count - visits).to_string() + "回来店"
                }
              } else {
                "全章クリア済み"
              }
            })],
          ),
          // 灯訪問の目安
          @dom.div(
            class="day-result-next-visit",
            [@dom.text_dyn(fn() {
              let points = state.akari_points.get()
              if points >= @game.visit_cost {
                "灯ポイント十分！灯に行けます"
              } else {
                "灯まであと " + (@game.visit_cost - points).to_string() + " 灯P"
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
