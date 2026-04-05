// ゲーム状態管理 — 定食屋「灯」に通うADV
//
// カフェ経営の複雑なフィールドを撤去し、
// 「日数・親密度・訪問記録」のシンプルな3本柱に簡素化。

/// メインのゲーム状態
///
/// Visit → Scene → (Story or 次の日) のサイクルで進行する。
/// 親密度が閾値に達するとストーリーが解放される。
pub(all) struct GameState {
  // フェーズ
  phase : @signals.Signal[@data.GamePhase]

  // ストーリー進行
  current_chapter : @signals.Signal[Int]
  scene_index : @signals.Signal[Int]
  line_index : @signals.Signal[Int]

  // 日数と親密度（コアシステム）
  day : @signals.Signal[Int]
  intimacy : @signals.Signal[Int]  // ひよりとの親密度（単一値）

  // 訪問記録（味の記憶）
  visit_log : @signals.Signal[Array[@data.VisitRecord]]
  visited_today : @signals.Signal[Bool]  // 今日訪問済みか

  // ひとくちシーンのテキスト（今日の分）
  today_scene_text : @signals.Signal[String]
  today_menu : @signals.Signal[String]  // 今日の日替わり名

  // UI状態
  show_calendar : @signals.Signal[Bool]
  message_log : @signals.Signal[Array[String]]

  // ストーリー完了
  story_complete : @signals.Signal[Bool]
}

/// 初期ゲーム状態を生成
///
/// day: 1, intimacy: 0, phase: Story（ch0から開始）
/// ch0/ch1 は unlock_intimacy: 0 なので最初にストーリーが流れる。
pub fn create_game_state() -> GameState {
  {
    phase: @signals.signal(@data.GamePhase::Story),
    current_chapter: @signals.signal(0),
    scene_index: @signals.signal(0),
    line_index: @signals.signal(0),
    day: @signals.signal(1),
    intimacy: @signals.signal(0),
    visit_log: @signals.signal([]),
    visited_today: @signals.signal(false),
    today_scene_text: @signals.signal(""),
    today_menu: @signals.signal(""),
    show_calendar: @signals.signal(false),
    message_log: @signals.signal([]),
    story_complete: @signals.signal(false),
  }
}
