// ロードマップUI — ストーリー進捗の可視化
//
// Home画面に表示する「路線図」スタイルの進捗表示。
// 各章を駅ノードとして横並びに描画し、
// クリア済み・現在地・未解放を視覚的に区別する。
//
// 構成:
//   1. 章トラック — ●━●━◎━○━○ の路線図
//   2. 灯P進捗バー — 次の灯訪問までの充填ゲージ
//   3. 次章情報 — 次に読める章のタイトルと必要来店数

/// ロードマップ — ストーリー進捗と次の目標をビジュアルで表示
///
/// Home画面の親密度表示の直下に配置。
/// 「ゲーム全体のどこにいるか」「次に何をすべきか」を
/// テキストではなくビジュアルで伝える。
fn render_roadmap(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="roadmap",
    [
      // ── ストーリー路線図 ──
      @dom.div(
        class="roadmap-header",
        [@dom.text("物語の道のり")],
      ),
      // 章トラック（路線図）
      @dom.div(
        class="roadmap-track",
        [@dom.text_dyn(fn() { build_chapter_track(state) })],
      ),
      // 章ラベル（起承転結）
      @dom.div(
        class="roadmap-arc-labels",
        [@dom.text_dyn(fn() { build_arc_labels(state) })],
      ),
      // ── 灯ポイント進捗ゲージ ──
      @dom.div(
        class="roadmap-gauge",
        [
          @dom.div(
            class="roadmap-gauge-label",
            [@dom.text("灯ポイント")],
          ),
          @dom.div(
            class="roadmap-gauge-bar",
            [@dom.text_dyn(fn() { build_akari_gauge(state) })],
          ),
        ],
      ),
      // ── 次章情報 ──
      @dom.div(
        class="roadmap-next",
        [@dom.text_dyn(fn() { build_next_chapter_info(state) })],
      ),
    ],
  )
}

/// 章トラック生成 — ●━●━◎━○━○ 形式の路線図
///
/// ● = クリア済み、◉ = 現在地（次に読む章）、○ = 未解放
/// 章間は ━ で接続。
/// 起(0-1) 承(2-7) 転(8) 結(9) の構造を反映。
fn build_chapter_track(state : @game.GameState) -> String {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()
  let visits = state.total_visits.get()
  let story_done = state.story_complete.get()
  let total = chapters.length()

  let mut track = ""
  for i in 0..<total {
    // 章間の接続線（最初の章以外）
    if i > 0 {
      if i <= current {
        track = track + "━"
      } else {
        track = track + "─"
      }
    }

    // 章ノードの状態判定
    if story_done {
      // 全章クリア → すべて ●
      track = track + "●"
    } else if i < current {
      // クリア済み
      track = track + "●"
    } else if i == current {
      // 現在の章（chapter 0 はプロローグなので特殊）
      // current_chapter はクリア済みの最新章を指す場合がある
      // → 次に読むべき章が current+1
      track = track + "●"
    } else if i == current + 1 {
      // 次の章 = 現在地
      if visits >= chapters[i].unlock_visit_count {
        // 解放済み → 読める！
        track = track + "◉"
      } else {
        // 未解放 → ロック中
        track = track + "◎"
      }
    } else {
      // まだ先の章
      track = track + "○"
    }
  }
  track
}

/// 起承転結ラベル — 路線図の下に表示する構成表示
fn build_arc_labels(_state : @game.GameState) -> String {
  // 起(ch0-1)  承(ch2-7)  転(ch8)  結(ch9)
  // スペーシングは路線図の幅に合わせて調整
  "起    承        転 結"
}

/// 灯ポイント進捗ゲージ — ▓▓▓░░░░░░░ 形式
///
/// 灯訪問コスト（10灯P）に対する現在の灯P充填率を可視化。
/// 満タン時は視覚的にハイライト（★マーク）。
fn build_akari_gauge(state : @game.GameState) -> String {
  let points = state.akari_points.get()
  let cost = @game.visit_cost
  let gauge_width = 10

  if points >= cost {
    // 満タン → 灯に行ける！
    let mut bar = ""
    for _i in 0..<gauge_width {
      bar = bar + "▓"
    }
    bar + " ★ " + points.to_string() + "/" + cost.to_string()
  } else {
    let filled = points * gauge_width / cost
    let mut bar = ""
    for i in 0..<gauge_width {
      if i < filled {
        bar = bar + "▓"
      } else {
        bar = bar + "░"
      }
    }
    bar + " " + points.to_string() + "/" + cost.to_string()
  }
}

/// 次章情報 — 次に読める章のタイトルと解放条件
fn build_next_chapter_info(state : @game.GameState) -> String {
  let current = state.current_chapter.get()
  let chapters = @data.get_chapters()
  let visits = state.total_visits.get()
  let story_done = state.story_complete.get()

  if story_done {
    return "全ての物語を読み終えた。灯にはいつでも通える。"
  }

  if current + 1 >= chapters.length() {
    return "最終章が待っている。"
  }

  let next = chapters[current + 1]
  if visits >= next.unlock_visit_count {
    "▶ " + next.title + " — 灯で読める"
  } else {
    let remaining = next.unlock_visit_count - visits
    "▷ " + next.title + " — あと" + remaining.to_string() + "回来店"
  }
}
