// メインUI — 2層アーキテクチャ版
//
// Layer 1（ひよりの日常）: Home → DailyAction → DailyScene → Home
// Layer 2（灯でご飯）: Home → Visit → VisitScene → Home
//
// ファイル構成:
//   app.mbt          — エントリポイント + ヘッダー + タイトル
//   app_home.mbt     — Home ビュー（日常 / 灯に行く / デッキ）
//   app_action.mbt   — DailyAction + 手札カードUI（バフ表示付き）
//   app_scene.mbt    — DailyScene + VisitScene + Story ビュー
//   app_album.mbt    — Album ビュー
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
            fn() { state.phase.get() == @data.GamePhase::DailyAction },
            fn() { render_daily_action_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::DailyScene },
            fn() { render_daily_scene_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Visit },
            fn() { render_visit_view(state) },
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
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::LoginBonus },
            fn() { render_login_bonus_view(state) },
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
fn render_header(state : @game.GameState) -> @dom.DomNode {
  @dom.header_(
    class="game-header",
    [
      @dom.div(
        class="header-title",
        [
          @dom.h1(class="title", [@dom.text("灯")]),
          @dom.span(
            class="subtitle",
            [@dom.text_dyn(fn() {
              let day = state.day.get()
              let season = @data.get_season(day)
              let weather = @data.get_weather(day)
              let day_in_season = @data.get_day_in_season(day)
              @data.season_to_string(season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(weather)
            })],
          ),
        ],
      ),
      @dom.div(
        class="header-stats",
        [
          // 灯ポイント
          @dom.span(
            class="stat stat-akari",
            [@dom.text_dyn(fn() {
              "灯P " + state.akari_points.get().to_string()
            })],
          ),
          // 心の余裕
          @dom.span(
            class="stat stat-stamina",
            [@dom.text_dyn(fn() {
              "余裕 " + state.stamina.get().to_string() + "/" + @game.base_stamina.to_string()
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
        [@dom.text("ひよりの日常と、定食屋の片隅の物語")],
      ),
      @dom.button(
        class="btn btn-primary btn-large",
        on=@dom.events().click(fn(_e) { @game.start_game(state) }),
        [@dom.text("はじめる")],
      ),
    ],
  )
}
