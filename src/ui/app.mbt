// メインUI — 定食屋「灯」に通うADV
//
// カードシステムUI。手札から行動カードを選んでプレイする。
// Title → Story(ch0) → Home → ActionSelect(手札) → Scene → Home のサイクル。
// ヘッダーに3軸パラメータ・季節・天候を表示。
//
// ファイル構成:
//   app.mbt          — エントリポイント + ヘッダー + タイトル
//   app_home.mbt     — Home ビュー
//   app_action.mbt   — ActionSelect + 手札カードUI
//   app_scene.mbt    — Scene + Story ビュー
//   app_album.mbt    — Album ビュー（全タブ）
//   app_day_result.mbt — DayResult + メッセージログ

/// 季節に対応するCSSクラス名を返す
fn season_class(state : @game.GameState) -> String {
  let day = state.day.get()
  let season = @data.get_season(day)
  match season {
    Spring => "season-spring"
    Summer => "season-summer"
    Autumn => "season-autumn"
    Winter => "season-winter"
  }
}

/// 天候に対応するCSSクラス名を返す
fn weather_class(state : @game.GameState) -> String {
  let day = state.day.get()
  let weather = @data.get_weather(day)
  match weather {
    Rainy => "weather-rainy"
    Snowy => "weather-snowy"
    _ => ""
  }
}

/// メインアプリコンポーネント
pub fn app(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="app",
    [
      render_header(state),
      @dom.div(
        class="main-content",
        [
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Title },
            fn() { render_title_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Home },
            fn() { render_home_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::ActionSelect },
            fn() { render_action_select_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Scene },
            fn() { render_scene_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Story },
            fn() { render_story_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Album },
            fn() { render_album_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::DayResult },
            fn() { render_day_result_view(state) },
          ),
        ],
      ),
      render_message_log(state),
    ],
  )
}

// =========================================================================
// ヘッダー
// =========================================================================

/// ヘッダー — ステータス表示
///
/// Title フェーズ以外で表示。3軸パラメータ・季節・天候・AP を常時表示。
fn render_header(state : @game.GameState) -> @dom.DomNode {
  @dom.header_(
    class="game-header",
    [
      @dom.div(
        class="header-title",
        [
          @dom.h1(class="title", [@dom.text("灯")]),
          // 季節・天候・日数
          @dom.span(
            class="subtitle",
            [@dom.text_dyn(fn() {
              let day = state.day.get()
              let season = @data.get_season(day)
              let weather = @data.get_weather(day)
              let day_in_season = @data.get_day_in_season(day)
              let s = @data.season_to_string(season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(weather)
              s
            })],
          ),
        ],
      ),
      // ♡親密度Lv + AP（簡素化: 3軸数値はHome画面に移動）
      @dom.div(
        class="header-stats",
        [
          @dom.span(
            class="stat stat-affection",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              "♡Lv" + level.to_string()
            })],
          ),
          @dom.span(
            class="stat stat-ap",
            [@dom.text_dyn(fn() {
              "AP " + state.ap.get().to_string() + "/" + @game.get_max_ap(state).to_string()
            })],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// Title ビュー
// =========================================================================

/// タイトル画面 — 初回起動時のみ表示
fn render_title_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="title-view",
    [
      @dom.div(
        class="title-logo",
        [@dom.text("灯")],
      ),
      @dom.div(
        class="title-tagline",
        [@dom.text("定食屋の片隅で、少しずつ近づく二人の物語")],
      ),
      @dom.button(
        class="btn btn-primary btn-large",
        on=@dom.events().click(fn(_e) { @game.start_game(state) }),
        [@dom.text("はじめる")],
      ),
    ],
  )
}
