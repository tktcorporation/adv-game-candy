// Entry point for 廃墟カフェ復興記

fn main {
  let doc = @js_dom.document()
  match doc.getElementById("app") {
    Some(container) => {
      let state = @game.create_game_state()

      // Claim login bonus on start
      @game.claim_login_bonus(state)

      // Render the app
      let app_node = @ui.app(state)
      @dom.render_to(container, app_node)
    }
    None => ()
  }
}
