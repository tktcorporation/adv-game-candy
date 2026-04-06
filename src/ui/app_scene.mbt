// Scene ビュー — 行動結果のテキスト + 獲得値 + リアクション表示
//
// 学マス参考: カード使用後に「何が得られたか」を明示。
// シーンテキスト → 結果（パラメータ・通貨） → リアクション → ボタン の順。

/// Scene ビュー — 行動結果のテキスト + 獲得値 + リアクション表示
fn render_scene_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="scene-view",
    [
      // メニュー名
      @dom.div(
        class="scene-menu",
        [@dom.text_dyn(fn() { state.today_menu.get() })],
      ),
      // シーンテキスト
      @dom.div(
        class="scene-text",
        [@dom.text_dyn(fn() { state.today_scene_text.get() })],
      ),
      // 結果セクション（獲得値・報酬・リアクション）
      @dom.div(
        class="scene-result",
        [
          @dom.div(
            class="scene-result-header",
            [@dom.text("─── 結果 ───")],
          ),
          // パラメータ獲得値 + ♡合計
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
          // 通貨・EXP報酬
          @dom.div(
            class="scene-rewards",
            [@dom.text_dyn(fn() {
              let r = state.last_card_result.get()
              let mut s = "+" + r.coin_reward.to_string() + " コイン  +" + r.exp_reward.to_string() + " EXP"
              if r.gem_reward > 0 {
                s = s + "  +" + r.gem_reward.to_string() + " 星石"
              }
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
            on=@dom.events().click(fn(_e) { @game.finish_scene(state) }),
            [@dom.text_dyn(fn() {
              // 次の章が解放可能かチェック
              let current = state.current_chapter.get()
              let chapters = @data.get_chapters()
              if current + 1 < chapters.length() {
                let next = chapters[current + 1]
                if state.player_level.get() >= next.unlock_player_level {
                  "ストーリーが解放されました"
                } else {
                  "ごちそうさまでした"
                }
              } else {
                "ごちそうさまでした"
              }
            })],
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
      // 章タイトル
      @dom.div(
        class="chapter-header",
        [@dom.text_dyn(fn() {
          match @game.get_current_chapter(state) {
            Some(ch) => ch.title + " 「" + ch.subtitle + "」"
            None => ""
          }
        })],
      ),
      // テキスト表示エリア
      @dom.div(
        class="story-text-area",
        [
          // 話者名
          @dom.div(
            class="speaker-name",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.speaker
                None => ""
              }
            })],
          ),
          // テキスト本文
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
      // 進行ボタン
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
