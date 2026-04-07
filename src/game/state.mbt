// ゲーム状態管理 — 2層アーキテクチャ
//
// Layer 1（ひよりの日常）: デッキ構築 + バフ積み + 心の余裕管理
// Layer 2（灯でご飯）: 灯ポイント消費 → ストーリー報酬
//
// 設計根拠: ゲームループとストーリーを分離。
// ストーリー完結後もLayer 1は永久に遊べる。
// 週末チャレンジがLayer 1側のクライマックスを提供。

/// 心の余裕の基本上限値（学マスの体力に対応）
///
/// 行動するたびに消費。高コスト行動（外出）は多く消費。
/// 0になると「引きこもりデー」（回復のみ）。
pub let base_stamina : Int = 8

/// 灯訪問に必要な灯ポイント
pub let visit_cost : Int = 10

/// メインのゲーム状態
pub(all) struct GameState {
  // フェーズ
  phase : @signals.Signal[@data.GamePhase]

  // ストーリー進行
  current_chapter : @signals.Signal[Int]
  scene_index : @signals.Signal[Int]
  line_index : @signals.Signal[Int]

  // 日数
  day : @signals.Signal[Int]

  // --- 関係性3軸 ---
  trust : @signals.Signal[Int]
  understanding : @signals.Signal[Int]
  empathy : @signals.Signal[Int]
  /// 親密度（後方互換）= trust + understanding + empathy
  intimacy : @signals.Signal[Int]

  // =========================================================================
  // Layer 1: ひよりの日常
  // =========================================================================

  /// 心の余裕（学マスの体力に対応）
  /// 行動するたびに消費。攻め(新体験) vs 守り(回復) のジレンマ。
  stamina : @signals.Signal[Int]

  /// デッキ（所持カードID一覧 + 上限）
  deck : @signals.Signal[@data.DeckInfo]
  /// 今日の手札（デッキからドローされた4枚）
  hand : @signals.Signal[Array[@data.ActionCard]]
  /// 今日プレイした行動のログ
  today_actions : @signals.Signal[Array[String]]

  // --- バフスタック（学マスの好調/集中/やる気に対応）---
  /// 安心スタック — 共感系 ×1.5
  buff_comfort : @signals.Signal[Int]
  /// 好奇心スタック — 理解系 ×1.5
  buff_curiosity : @signals.Signal[Int]
  /// 勇気スタック — 信頼系 ×1.5
  buff_courage : @signals.Signal[Int]

  // --- 行動カウンタ ---
  total_actions : @signals.Signal[Int]

  // =========================================================================
  // Layer 2: 灯でご飯
  // =========================================================================

  /// 灯ポイント（Layer 1 → Layer 2 のブリッジ通貨）
  /// デイリーミッション・バフプレイ・チャレンジで獲得。10で1回来店。
  akari_points : @signals.Signal[Int]

  /// 累計灯訪問回数（チャプター解放条件）
  total_visits : @signals.Signal[Int]

  /// 現在の席位置
  current_seat : @signals.Signal[@data.SeatPosition]

  /// 灯訪問の進行状態
  visit_phase : @signals.Signal[@data.VisitPhase]

  // 訪問記録
  visit_log : @signals.Signal[Array[@data.VisitRecord]]
  today_scene_text : @signals.Signal[String]
  today_menu : @signals.Signal[String]

  // =========================================================================
  // 週チャレンジ（Layer 1 のクライマックス）
  // =========================================================================

  /// 週の開始日（7日ごとにリセット）
  week_start_day : @signals.Signal[Int]
  /// 週の開始時パラメータ（週内の獲得量計算用）
  week_start_trust : @signals.Signal[Int]
  week_start_understanding : @signals.Signal[Int]
  week_start_empathy : @signals.Signal[Int]
  /// 週チャレンジ結果の履歴
  challenge_results : @signals.Signal[Array[@data.ChallengeResult]]

  // =========================================================================
  // 共通システム
  // =========================================================================

  // デイリーミッション
  daily_missions : @signals.Signal[Array[@data.DailyMission]]

  // コレクション
  discoveries : @signals.Signal[Array[String]]
  talk_memos : @signals.Signal[Array[String]]

  // 思い出システム
  acquired_memories : @signals.Signal[Array[@data.MemoryRecord]]
  memory_slots : @signals.Signal[@data.MemorySlots]

  // 季節の節目
  season_results : @signals.Signal[Array[@data.SeasonResult]]

  // 通貨
  coins : @signals.Signal[Int]

  // ガチャ（簡素化: 行動カード獲得のみ）
  gacha_pity : @signals.Signal[Int]
  gacha_results : @signals.Signal[Array[@data.GachaResult]]

  // ログインボーナス
  login_streak : @signals.Signal[Int]
  last_login_bonus_day : @signals.Signal[Int]

  // デイリザルト
  day_result : @signals.Signal[@data.DayResultData]
  last_card_result : @signals.Signal[@data.CardResult]
  today_coins_earned : @signals.Signal[Int]
  day_start_trust : @signals.Signal[Int]
  day_start_understanding : @signals.Signal[Int]
  day_start_empathy : @signals.Signal[Int]

  // UI状態
  message_log : @signals.Signal[Array[String]]
  album_tab : @signals.Signal[Int]
  story_complete : @signals.Signal[Bool]
}

/// デイリーミッションの初期値を生成
///
/// 報酬は灯ポイント（旧: 親密度ボーナス）。
/// 3つ全達成で +3 + +2 + +5 = 10灯ポイント = 1回来店分。
fn create_daily_missions() -> Array[@data.DailyMission] {
  [
    { id: "action_1", description: "行動を1つする", completed: false, reward: 3 },
    { id: "action_3", description: "3つの行動をする", completed: false, reward: 5 },
    { id: "use_buff", description: "バフを使って行動する", completed: false, reward: 2 },
  ]
}

/// 初期ゲーム状態を生成
pub fn create_game_state() -> GameState {
  {
    phase: @signals.signal(@data.GamePhase::Title),
    current_chapter: @signals.signal(0),
    scene_index: @signals.signal(0),
    line_index: @signals.signal(0),
    day: @signals.signal(1),
    // 関係性3軸
    trust: @signals.signal(0),
    understanding: @signals.signal(0),
    empathy: @signals.signal(0),
    intimacy: @signals.signal(0),
    // Layer 1: ひよりの日常
    stamina: @signals.signal(base_stamina),
    deck: @signals.signal(
      ({ card_ids: [], max_size: 15 } : @data.DeckInfo),
    ),
    hand: @signals.signal([]),
    today_actions: @signals.signal([]),
    buff_comfort: @signals.signal(0),
    buff_curiosity: @signals.signal(0),
    buff_courage: @signals.signal(0),
    total_actions: @signals.signal(0),
    // Layer 2: 灯でご飯
    akari_points: @signals.signal(10),  // 初回来店分を付与
    total_visits: @signals.signal(0),
    current_seat: @signals.signal(@data.SeatPosition::FarTable),
    visit_phase: @signals.signal(@data.VisitPhase::Entering),
    visit_log: @signals.signal([]),
    today_scene_text: @signals.signal(""),
    today_menu: @signals.signal(""),
    // 週チャレンジ
    week_start_day: @signals.signal(1),
    week_start_trust: @signals.signal(0),
    week_start_understanding: @signals.signal(0),
    week_start_empathy: @signals.signal(0),
    challenge_results: @signals.signal([]),
    // 共通
    daily_missions: @signals.signal(create_daily_missions()),
    discoveries: @signals.signal([]),
    talk_memos: @signals.signal([]),
    acquired_memories: @signals.signal([]),
    memory_slots: @signals.signal(
      { trust_slot: "", understanding_slot: "", empathy_slot: "" },
    ),
    season_results: @signals.signal([]),
    coins: @signals.signal(500),
    gacha_pity: @signals.signal(0),
    gacha_results: @signals.signal([]),
    login_streak: @signals.signal(0),
    last_login_bonus_day: @signals.signal(0),
    day_result: @signals.signal({
      trust_gained: 0, understanding_gained: 0, empathy_gained: 0,
      akari_points_earned: 0, coins_earned: 0, actions_taken: 0,
      memories_acquired: [], challenge_result: "", stamina_remaining: 0,
    }),
    last_card_result: @signals.signal({
      trust_gain: 0, understanding_gain: 0, empathy_gain: 0,
      buff_gained: "", buff_consumed: false, multiplier_applied: false,
      reaction_text: "",
    }),
    today_coins_earned: @signals.signal(0),
    day_start_trust: @signals.signal(0),
    day_start_understanding: @signals.signal(0),
    day_start_empathy: @signals.signal(0),
    message_log: @signals.signal([]),
    album_tab: @signals.signal(0),
    story_complete: @signals.signal(false),
  }
}
