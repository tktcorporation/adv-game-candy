// エントリーポイント — 定食屋「灯」ADV

fn main {
  let doc = @js_dom.document()
  match doc.getElementById("app") {
    Some(container) => {
      let state = @game.create_game_state()
      let app_node = @ui.app(state)
      @dom.render_to(container, app_node)
    }
    None => ()
  }
}
