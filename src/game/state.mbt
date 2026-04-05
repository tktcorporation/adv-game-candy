// ゲーム状態管理 — 定食屋「灯」に通うADV
//
// AP行動選択制: 毎日5APの中で灯での過ごし方を選ぶ。
// 「日数・親密度・AP・行動履歴・ミッション」で状態を管理。

/// AP の上限値
///
/// 毎日リセットされ、この値に戻る。行動ごとに 1-2 AP 消費する。
/// 1日に最大3-5回の行動が可能（行動コストの組み合わせ次第）。
pub let max_ap : Int = 5

/// メインのゲーム状態
///
/// Title → Story(ch0) → Home → ActionSelect → Scene → Home のサイクルで進行する。
/// AP を使い切るか「帰る」を選ぶまで ActionSelect に留まれる。
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

  // AP（行動ポイント）— ゲームのコアリソース
  ap : @signals.Signal[Int]

  // 今日の行動履歴（ミッション判定・アルバム用）
  today_actions : @signals.Signal[Array[String]]

  // 訪問記録（味の記憶）
  visit_log : @signals.Signal[Array[@data.VisitRecord]]

  // ひとくちシーンのテキスト（今日の分）
  today_scene_text : @signals.Signal[String]
  today_menu : @signals.Signal[String]  // 今日の日替わり名

  // デイリーミッション
  daily_missions : @signals.Signal[Array[@data.DailyMission]]

  // コレクション（アルバム用）
  /// 観察で得た発見テキスト。重複なしで蓄積される。
  discoveries : @signals.Signal[Array[String]]
  /// 丸山と話して得た情報テキスト。重複なしで蓄積される。
  talk_memos : @signals.Signal[Array[String]]

  // UI状態
  message_log : @signals.Signal[Array[String]]
  /// アルバム内のタブ切替用（0: 味の記憶, 1: 発見ノート, 2: 会話メモ, 3: ストーリー回想）
  album_tab : @signals.Signal[Int]

  // ストーリー完了
  story_complete : @signals.Signal[Bool]
}

/// デイリーミッションの初期値を生成
///
/// 毎日リセット時にもこの関数で新しいミッションを作る。
/// ID はミッション達成判定で使う識別子。
fn create_daily_missions() -> Array[@data.DailyMission] {
  [
    { id: "eat", description: "灯で食事をする", completed: false, reward: 10 },
    { id: "talk", description: "丸山と話す", completed: false, reward: 5 },
    { id: "actions_3", description: "3つの行動をする", completed: false, reward: 20 },
  ]
}

/// 初期ゲーム状態を生成
///
/// phase: Title（初回はタイトル画面から開始）
/// AP: 5（上限値）
/// ch0 は unlock_intimacy: 0 なので、タイトル→ストーリーですぐ再生される。
pub fn create_game_state() -> GameState {
  {
    phase: @signals.signal(@data.GamePhase::Title),
    current_chapter: @signals.signal(0),
    scene_index: @signals.signal(0),
    line_index: @signals.signal(0),
    day: @signals.signal(1),
    intimacy: @signals.signal(0),
    ap: @signals.signal(max_ap),
    today_actions: @signals.signal([]),
    visit_log: @signals.signal([]),
    today_scene_text: @signals.signal(""),
    today_menu: @signals.signal(""),
    daily_missions: @signals.signal(create_daily_missions()),
    discoveries: @signals.signal([]),
    talk_memos: @signals.signal([]),
    message_log: @signals.signal([]),
    album_tab: @signals.signal(0),
    story_complete: @signals.signal(false),
  }
}
