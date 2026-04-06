// エントリーポイント — 定食屋「灯」ADV
//
// body に季節・天候のCSSクラスを動的に適用し、
// 背景の幾何学パターン色・天候エフェクトを切り替える。

///|
/// 季節文字列を取得するヘルパー（季節装飾の FFI 呼び出し用）
extern "js" fn add_seasonal_decoration_js(season : String) -> Unit =
  #| (s) => { if(globalThis.addSeasonalDecoration) globalThis.addSeasonalDecoration(s) }

fn main {
  let doc = @js_dom.document()
  match doc.getElementById("app") {
    Some(container) => {
      let state = @game.create_game_state()

      // body に季節・天候クラスを適用 + 季節装飾パーティクルを追加
      // day が変化するたびに自動更新される
      match doc.body() {
        Some(body) => {
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

            // 季節の浮遊パーティクル（桜の花びら・紅葉・雪の結晶）
            let season_str = match season {
              Spring => "spring"
              Summer => "summer"
              Autumn => "autumn"
              Winter => "winter"
            }
            add_seasonal_decoration_js(season_str)
          })
        }
        None => ()
      }

      let app_node = @ui.app(state)
      @dom.render_to(container, app_node)
    }
    None => ()
  }
}
