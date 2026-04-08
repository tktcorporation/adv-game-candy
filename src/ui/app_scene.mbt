// Scene ビュー — DailyScene + VisitScene + Story
//
// DailyScene: 行動結果テキスト + バフ獲得/消費 + パラメータ変化
// VisitScene: 灯でのストーリーシーン（Layer 2）
// Story: メインストーリーADV

/// DailyScene ビュー — 行動結果表示（COMBO演出対応）
fn render_daily_scene_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="scene-view",
    [
      // COMBO演出（バフ消費時）— 学マスの「Perfect!」に対応
      @dom.show(
        fn() { state.last_card_result.get().buff_consumed },
        fn() {
          @dom.div(
            class="combo-display",
            [
              // バフ弾けた演出
              @dom.div(
                class="combo-burst",
                [@dom.text_dyn(fn() {
                  let r = state.last_card_result.get()
                  let buff_icon = if r.buff_gained != "" {
                    @game.buff_to_icon(r.buff_gained)
                  } else {
                    "✦"
                  }
                  buff_icon + " COMBO！"
                })],
              ),
              // 計算過程（8 → ×1.5 → 12！）
              @dom.div(
                class="combo-calc",
                [@dom.text_dyn(fn() { build_combo_text(state) })],
              ),
            ],
          )
        },
      ),
      // バフ獲得表示（バフ付与時）
      @dom.show(
        fn() {
          let r = state.last_card_result.get()
          r.buff_gained != "" && !r.buff_consumed
        },
        fn() {
          @dom.div(
            class="buff-gained-display",
            [@dom.text_dyn(fn() {
              let buff = state.last_card_result.get().buff_gained
              @game.buff_to_icon(buff) + " " + @game.buff_to_string(buff) + " を獲得！"
            })],
          )
        },
      ),
      // シーンテキスト
      @dom.div(
        class="scene-text",
        [@dom.text_dyn(fn() { state.today_scene_text.get() })],
      ),
      // 結果セクション
      @dom.div(
        class="scene-result",
        [
          @dom.div(
            class="scene-result-header",
            [@dom.text_dyn(fn() {
              if state.last_card_result.get().buff_consumed {
                "────── COMBO ──────"
              } else {
                "─── 結果 ───"
              }
            })],
          ),
          // パラメータ獲得値
          @dom.div(
            class="scene-gains",
            [@dom.text_dyn(fn() {
              let r = state.last_card_result.get()
              let mut s = ""
              if r.trust_gain > 0 {
                s = s + "信頼 +" + r.trust_gain.to_string() + "  "
              }
              if r.understanding_gain > 0 {
                s = s + "理解 +" + r.understanding_gain.to_string() + "  "
              }
              if r.empathy_gain > 0 {
                s = s + "共感 +" + r.empathy_gain.to_string() + "  "
              }
              let total = r.trust_gain + r.understanding_gain + r.empathy_gain
              s = s + "♡ +" + total.to_string()
              s
            })],
          ),
          // ひよりのリアクション
          @dom.show(
            fn() { state.last_card_result.get().reaction_text != "" },
            fn() {
              @dom.div(
                class="scene-reaction",
                [@dom.text_dyn(fn() {
                  "♪ " + state.last_card_result.get().reaction_text
                })],
              )
            },
          ),
        ],
      ),
      // ボタン
      @dom.div(
        class="scene-actions",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) { @game.finish_daily_scene(state) }),
            [@dom.text_dyn(fn() {
              if state.stamina.get() > 0 {
                "次の行動へ"
              } else {
                "今日はここまで"
              }
            })],
          ),
        ],
      ),
    ],
  )
}

/// COMBO演出テキスト生成（base → ×1.5 → 最終値！）
///
/// バフ消費時にカードの計算過程を可視化。
/// 学マスで「好調 → 集中 → Perfect! スコア×3」と見せるのと同じ設計。
fn build_combo_text(state : @game.GameState) -> String {
  let r = state.last_card_result.get()
  let mut lines = ""
  if r.base_trust > 0 {
    lines = lines + "信頼 " + r.base_trust.to_string() + " → ×1.5 → " + r.trust_gain.to_string() + "！\n"
  }
  if r.base_understanding > 0 {
    lines = lines + "理解 " + r.base_understanding.to_string() + " → ×1.5 → " + r.understanding_gain.to_string() + "！\n"
  }
  if r.base_empathy > 0 {
    lines = lines + "共感 " + r.base_empathy.to_string() + " → ×1.5 → " + r.empathy_gain.to_string() + "！"
  }
  lines
}

/// Visit ビュー — 灯でご飯（Layer 2）
///
/// 簡易実装: 灯に入ってメニューを見てストーリーシーン。
fn render_visit_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="visit-view",
    [
      @dom.div(
        class="visit-header",
        [@dom.text("── 定食屋「灯」 ──")],
      ),
      // 今日のメニュー
      @dom.div(
        class="visit-menu",
        [@dom.text_dyn(fn() {
          let menu = @data.get_today_menu(state.day.get())
          "今日の日替わり: " + menu.name
        })],
      ),
      @dom.div(
        class="visit-menu-desc",
        [@dom.text_dyn(fn() {
          let menu = @data.get_today_menu(state.day.get())
          menu.description
        })],
      ),
      // 席の位置
      @dom.div(
        class="visit-seat",
        [@dom.text_dyn(fn() {
          let seat = state.current_seat.get()
          match seat {
            FarTable => "いつものテーブル席に座る。"
            CounterEnd => "カウンターの端に座る。"
            CounterMiddle => "カウンターの真ん中に座る。"
            NextSeat => "ひよりの隣に座る。"
          }
        })],
      ),
      // ストーリーが解放されているか
      @dom.div(
        class="visit-story",
        [@dom.text_dyn(fn() {
          let current = state.current_chapter.get()
          let chapters = @data.get_chapters()
          let visits = state.total_visits.get()
          if current + 1 < chapters.length() {
            let next = chapters[current + 1]
            if visits >= next.unlock_visit_count {
              "新しい物語が読めそうだ。"
            } else {
              "いつもの灯の景色。"
            }
          } else {
            "ここは変わらない。それが嬉しい。"
          }
        })],
      ),
      // ボタン
      @dom.div(
        class="visit-actions",
        [
          // ストーリー解放されていれば読める
          @dom.show(
            fn() {
              let current = state.current_chapter.get()
              let chapters = @data.get_chapters()
              let visits = state.total_visits.get()
              if current + 1 < chapters.length() {
                visits >= chapters[current + 1].unlock_visit_count
              } else {
                false
              }
            },
            fn() {
              @dom.button(
                class="btn btn-primary",
                on=@dom.events().click(fn(_e) {
                  let current = state.current_chapter.get()
                  state.current_chapter.set(current + 1)
                  state.scene_index.set(0)
                  state.line_index.set(0)
                  state.phase.set(@data.GamePhase::Story)
                }),
                [@dom.text("ストーリーを読む")],
              )
            },
          ),
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) { @game.leave_visit(state) }),
            [@dom.text("ごちそうさまでした")],
          ),
        ],
      ),
    ],
  )
}

/// Story ビュー — ADV形式のテキスト表示
fn render_story_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="story-view",
    [
      @dom.div(
        class="chapter-header",
        [@dom.text_dyn(fn() {
          match @game.get_current_chapter(state) {
            Some(ch) => ch.title + " 「" + ch.subtitle + "」"
            None => ""
          }
        })],
      ),
      @dom.div(
        class="story-text-area",
        [
          @dom.div(
            class="speaker-name",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.speaker
                None => ""
              }
            })],
          ),
          @dom.div(
            class="story-text",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.text
                None => ""
              }
            })],
          ),
        ],
      ),
      @dom.div(
        class="story-controls",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) { @game.advance_story(state) }),
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(_) => "▼"
                None => "次へ"
              }
            })],
          ),
        ],
      ),
    ],
  )
}
