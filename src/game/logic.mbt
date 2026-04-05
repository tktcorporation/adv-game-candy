// ゲームロジック — 定食屋「灯」に通うADV
//
// ゲームループ: Visit → Scene → (Story解放 or 次の日) → Visit
// 親密度が閾値に達するとストーリー章が解放される。

/// ストーリーを1行進める
pub fn advance_story(state : GameState) -> Unit {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return
  }
  let chapter = chapters[ch_idx]
  let scene = chapter.scenes[state.scene_index.get()]
  let next_line = state.line_index.get() + 1
  if next_line < scene.lines.length() {
    state.line_index.set(next_line)
  } else {
    // シーン完了 — 次のシーンへ or 章終了
    let next_scene_id = scene.next_scene
    if next_scene_id == "" {
      // 章のストーリー完了 — Visit フェーズへ
      finish_chapter(state)
    } else {
      // 次のシーンを探す
      let mut found = -1
      for i, s in chapter.scenes {
        if s.id == next_scene_id {
          found = i
          break
        }
      }
      if found >= 0 {
        state.scene_index.set(found)
        state.line_index.set(0)
      } else {
        finish_chapter(state)
      }
    }
  }
}

/// 章のストーリー終了時の処理
///
/// 次の章がすぐ解放可能なら連続でストーリーに入る（ch0→ch1）。
/// そうでなければ Visit フェーズへ。
fn finish_chapter(state : GameState) -> Unit {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()

  // 最終章なら完了
  if current + 1 >= chapters.length() {
    state.story_complete.set(true)
    state.phase.set(@data.GamePhase::Visit)
    add_message(state, "物語が完結しました。灯にはこれからも通えます。")
    return
  }

  // 次の章が即座に解放可能かチェック
  let next = chapters[current + 1]
  let intimacy = state.intimacy.get()
  if intimacy >= next.unlock_intimacy {
    // 連続ストーリー解放（ch0→ch1 など）
    state.current_chapter.set(current + 1)
    state.scene_index.set(0)
    state.line_index.set(0)
    add_message(
      state,
      next.title + " 「" + next.subtitle + "」が解放されました！",
    )
    // phase は Story のまま
  } else {
    // Visit フェーズへ
    state.phase.set(@data.GamePhase::Visit)
    state.line_index.set(0)
    state.scene_index.set(0)
  }
}

/// 現在のストーリー行を取得
pub fn get_current_line(state : GameState) -> @data.StoryLine? {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return None
  }
  let chapter = chapters[ch_idx]
  let sc_idx = state.scene_index.get()
  if sc_idx >= chapter.scenes.length() {
    return None
  }
  let scene = chapter.scenes[sc_idx]
  let ln_idx = state.line_index.get()
  if ln_idx >= scene.lines.length() {
    return None
  }
  Some(scene.lines[ln_idx])
}

/// 現在の章情報を取得
pub fn get_current_chapter(state : GameState) -> @data.Chapter? {
  let chapters = @data.get_chapters()
  let ch_idx = state.current_chapter.get()
  if ch_idx >= chapters.length() {
    return None
  }
  Some(chapters[ch_idx])
}

// =========================================================================
// 灯を訪問する（メインのゲームループ）
// =========================================================================

/// 灯に入る — 日替わりを食べてひとくちシーンを見る
///
/// 1. 今日の日替わりメニューを取得
/// 2. 親密度を加算
/// 3. ひとくちシーンテキストを生成
/// 4. visit_log に記録
/// 5. phase を Scene に遷移
pub fn visit_akari(state : GameState) -> Unit {
  let day = state.day.get()
  let menu = @data.get_today_menu(day)

  // 親密度を加算
  state.intimacy.update(fn(i) { i + menu.intimacy_bonus })

  // ひとくちシーンを生成
  let scene_text = generate_scene_text(state.intimacy.get(), day, menu.name)

  // 今日の情報をセット
  state.today_scene_text.set(scene_text)
  state.today_menu.set(menu.name)

  // 訪問記録を追加
  state.visit_log.update(fn(log) {
    let result : Array[@data.VisitRecord] = []
    for r in log {
      result.push(r)
    }
    result.push({ day, menu_id: menu.id, scene_text })
    result
  })

  // 訪問済みフラグ
  state.visited_today.set(true)

  // Scene フェーズへ
  state.phase.set(@data.GamePhase::Scene)
}

/// ひとくちシーン終了 — ストーリー解放チェック
///
/// 親密度が次章の閾値に達していればストーリーへ、そうでなければ「また明日」。
pub fn finish_scene(state : GameState) -> Unit {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()

  // 最終章クリア済み
  if current + 1 >= chapters.length() {
    add_message(state, "また明日も灯に来よう。")
    // Visit のまま次の日へボタンを待つ
    state.phase.set(@data.GamePhase::Visit)
    return
  }

  let next = chapters[current + 1]
  let intimacy = state.intimacy.get()

  if intimacy >= next.unlock_intimacy {
    // ストーリー解放
    state.current_chapter.set(current + 1)
    state.scene_index.set(0)
    state.line_index.set(0)
    state.phase.set(@data.GamePhase::Story)
    add_message(
      state,
      next.title + " 「" + next.subtitle + "」が解放されました！",
    )
  } else {
    // まだ足りない
    let remaining = next.unlock_intimacy - intimacy
    add_message(
      state,
      "また明日も灯に来よう。（次の章まであと " +
      remaining.to_string() +
      "）",
    )
    state.phase.set(@data.GamePhase::Visit)
  }
}

/// 次の日へ進む
///
/// day をインクリメントし、Visit フェーズに戻す。
pub fn next_day(state : GameState) -> Unit {
  state.day.update(fn(d) { d + 1 })
  state.visited_today.set(false)
  state.phase.set(@data.GamePhase::Visit)
}

// =========================================================================
// ひとくちシーン生成
// =========================================================================

/// 親密度の段階に応じたひとくちシーンテキストを返す
///
/// day のハッシュでバリエーションを選択する。
/// 同じ日なら同じテキスト（決定的）。
fn generate_scene_text(intimacy : Int, day : Int, menu_name : String) -> String {
  let texts : Array[String] = if intimacy < 100 {
    [
      "カウンターの反対側で、彼女も同じものを食べている。",
      "今日は" + menu_name + "か。向こう側でも、箸が動いている。",
      "同じ店、同じ時間。それだけの関係。",
      "いつもの席。いつもの定食。向こう側に、いつもの人。",
    ]
  } else if intimacy < 300 {
    [
      "二つ向こうの席から、小さな「いただきます」が聞こえた。",
      "今日の" + menu_name + "、美味しいな。……あの人も食べてるだろうか。",
      "ちらっと視線が合った気がした。気のせいかもしれない。",
      "隣の席との間に、醤油差しが一つ。距離はまだ遠い。",
    ]
  } else if intimacy < 600 {
    [
      "「今日の、美味しいですね」。一つ空けた席から、小さな声。",
      "隣から味噌汁の匂い。同じものを食べている安心感。",
      menu_name + "を食べながら、ふと隣を見る。同じタイミングで箸が止まった。",
      "「……おかわり、しますか？」。お茶のやかんを差し出された。",
    ]
  } else {
    [
      "「今日は何だろう」。隣に座ったひよりが、少し楽しそうに言った。",
      "二人分の「いただきます」が重なった。丸山がニヤニヤしている。",
      "「" + menu_name + "、好きなんですか？」「うん、ここのは全部好き」",
      "隣の席が、いつの間にか「いつもの席」になっていた。",
    ]
  }
  texts[day % texts.length()]
}

// =========================================================================
// ユーティリティ
// =========================================================================

/// メッセージログに追加（最大20件を保持）
pub fn add_message(state : GameState, msg : String) -> Unit {
  state.message_log.update(fn(log) {
    let result : Array[String] = []
    for m in log {
      result.push(m)
    }
    result.push(msg)
    if result.length() > 20 {
      let trimmed : Array[String] = []
      for i in (result.length() - 20)..<result.length() {
        trimmed.push(result[i])
      }
      trimmed
    } else {
      result
    }
  })
}

/// 親密度のスターランクを取得
pub fn get_intimacy_stars(points : Int) -> Int {
  let ranks = @data.get_intimacy_ranks()
  let mut stars = 1
  for rank in ranks {
    if points >= rank.min_points {
      stars = rank.stars
    }
  }
  stars
}
