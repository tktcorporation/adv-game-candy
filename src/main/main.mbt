// エントリーポイント — 定食屋「灯」ADV
//
// body に季節・天候のCSSクラスを動的に適用し、
// 背景の幾何学パターン色・天候エフェクトを切り替える。

fn main {
  let doc = @js_dom.document()
  match doc.getElementById("app") {
    Some(container) => {
      let state = @game.create_game_state()

      // body に季節・天候クラスを適用（day 変化で自動更新）
      let body = doc.body()
      let _dispose = @signals.effect(fn() {
        let day = state.day.get()
        let season = @data.get_season(day)
        let weather = @data.get_weather(day)
        let season_cls = match season {
          Spring => "season-spring"
          Summer => "season-summer"
          Autumn => "season-autumn"
          Winter => "season-winter"
        }
        let weather_cls = match weather {
          Rainy => "weather-rainy"
          Snowy => "weather-snowy"
          _ => ""
        }
        body.setClassName(season_cls + " " + weather_cls)
      })

      let app_node = @ui.app(state)
      @dom.render_to(container, app_node)
    }
    None => ()
  }
}
