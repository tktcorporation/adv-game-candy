// ゲーム状態管理 — 定食屋「灯」に通うADV
//
// AP行動選択制: 毎日5APの中で灯での過ごし方を選ぶ。
// 「日数・3軸パラメータ・AP・手札・行動履歴・ミッション・思い出」で状態を管理。
//
// 学マス参考のソーシャルゲームシステム:
// - 3軸パラメータ（信頼/理解/共感）で戦略的行動選択
// - 行動カードの手札ドロー
// - 季節・天候によるカード出現変化
// - 思い出（メモリー）の収集・装備

/// AP の上限値
///
/// 毎日リセットされ、この値に戻る。行動ごとに 1-3 AP 消費する。
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
  /// 親密度（後方互換）= trust + understanding + empathy の合計値
  intimacy : @signals.Signal[Int]

  // --- 関係性3軸（学マスの Vo/Da/Vi に対応）---
  /// 信頼 — 丸山との会話、日々の積み重ねで育つ
  trust : @signals.Signal[Int]
  /// 理解 — 観察、ひよりの仕草や好みを知ることで育つ
  understanding : @signals.Signal[Int]
  /// 共感 — 食事を共有し、同じ体験をすることで育つ
  empathy : @signals.Signal[Int]

  // AP（行動ポイント）— ゲームのコアリソース
  ap : @signals.Signal[Int]

  // --- 行動カードシステム（学マスのスキルカードに対応）---
  /// 今日の手札（毎朝ドロー、max_hand_size枚）
  hand : @signals.Signal[Array[@data.ActionCard]]

  // 今日の行動履歴（ミッション判定・アルバム用）
  today_actions : @signals.Signal[Array[String]]

  // --- 行動カウンタ（思い出獲得条件の判定用）---
  /// 累計食事回数
  total_eat_count : @signals.Signal[Int]
  /// 累計会話回数
  total_talk_count : @signals.Signal[Int]
  /// 累計観察回数
  total_observe_count : @signals.Signal[Int]

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

  // --- 思い出システム（学マスのメモリーに対応）---
  /// 獲得済みの思い出記録
  acquired_memories : @signals.Signal[Array[@data.MemoryRecord]]
  /// 装備中の思い出スロット（3枠: 信頼/理解/共感）
  memory_slots : @signals.Signal[@data.MemorySlots]

  // --- 季節の節目イベント結果 ---
  /// 過去の季節イベント結果（S/A/B/C ランク）
  season_results : @signals.Signal[Array[@data.SeasonResult]]

  // UI状態
  message_log : @signals.Signal[Array[String]]
  /// アルバム内のタブ切替用
  /// 0: 味の記憶, 1: 発見ノート, 2: 会話メモ, 3: ストーリー回想, 4: 思い出
  album_tab : @signals.Signal[Int]

  // ストーリー完了
  story_complete : @signals.Signal[Bool]

  // --- 通貨システム ---
  /// 灯コイン — 行動・ミッション・ストーリーで獲得。ガチャ・強化に使う
  coins : @signals.Signal[Int]
  /// 星石 — プレミアム通貨。ストーリー・実績・ログボで獲得
  gems : @signals.Signal[Int]
  /// 強化シャード — ガチャ被り or ミッション報酬で獲得。カード強化に使う
  enhancement_shards : @signals.Signal[Int]

  // --- カードコレクション ---
  /// 獲得済みカード一覧（レベル管理）。IDが含まれていればそのカードを所持
  owned_cards : @signals.Signal[Array[@data.OwnedCard]]

  // --- ガチャ ---
  /// 天井カウンタ — Rare未獲得の連続回数。pity_threshold に達したら確定
  gacha_pity : @signals.Signal[Int]
  /// 累計ガチャ回数
  gacha_total_pulls : @signals.Signal[Int]
  /// 直近のガチャ結果（演出画面で表示）
  gacha_results : @signals.Signal[Array[@data.GachaResult]]

  // --- ログインボーナス ---
  /// 連続ログイン日数（1-7サイクル）
  login_streak : @signals.Signal[Int]
  /// 最後にログボを受け取ったゲーム内日数
  last_login_bonus_day : @signals.Signal[Int]

  // --- デイリザルト ---
  /// 今日のリザルトデータ（「次の日へ」時に生成）
  day_result : @signals.Signal[@data.DayResultData]
  /// 今日獲得したコイン数（リザルト表示用にトラッキング）
  today_coins_earned : @signals.Signal[Int]
  /// 今日の開始時の3軸値（差分計算用）
  day_start_trust : @signals.Signal[Int]
  day_start_understanding : @signals.Signal[Int]
  day_start_empathy : @signals.Signal[Int]

  // --- プレイヤーレベル ---
  /// プレイヤー経験値 — 行動するたびに蓄積
  player_exp : @signals.Signal[Int]
  /// プレイヤーレベル（レベルアップでAP上限増加などの恩恵）
  player_level : @signals.Signal[Int]

  // --- 強化画面用 ---
  /// 現在選択中のカードID（強化画面）
  enhance_target_card : @signals.Signal[String]
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
/// 3軸パラメータはすべて0から開始。
/// ch0 は unlock_intimacy: 0 なので、タイトル→ストーリーですぐ再生される。
pub fn create_game_state() -> GameState {
  {
    phase: @signals.signal(@data.GamePhase::Title),
    current_chapter: @signals.signal(0),
    scene_index: @signals.signal(0),
    line_index: @signals.signal(0),
    day: @signals.signal(1),
    intimacy: @signals.signal(0),
    // 3軸パラメータ
    trust: @signals.signal(0),
    understanding: @signals.signal(0),
    empathy: @signals.signal(0),
    ap: @signals.signal(max_ap),
    // 行動カード（初日の手札は start_game 時にドロー）
    hand: @signals.signal([]),
    today_actions: @signals.signal([]),
    // 行動カウンタ
    total_eat_count: @signals.signal(0),
    total_talk_count: @signals.signal(0),
    total_observe_count: @signals.signal(0),
    visit_log: @signals.signal([]),
    today_scene_text: @signals.signal(""),
    today_menu: @signals.signal(""),
    daily_missions: @signals.signal(create_daily_missions()),
    discoveries: @signals.signal([]),
    talk_memos: @signals.signal([]),
    // 思い出
    acquired_memories: @signals.signal([]),
    memory_slots: @signals.signal(
      { trust_slot: "", understanding_slot: "", empathy_slot: "" },
    ),
    // 季節イベント結果
    season_results: @signals.signal([]),
    message_log: @signals.signal([]),
    album_tab: @signals.signal(0),
    story_complete: @signals.signal(false),
    // --- 通貨 ---
    coins: @signals.signal(500),        // 初期500コインでチュートリアルガチャ可能
    gems: @signals.signal(0),
    enhancement_shards: @signals.signal(0),
    // --- カードコレクション（初期カードは start_game で自動登録）---
    owned_cards: @signals.signal([]),
    // --- ガチャ ---
    gacha_pity: @signals.signal(0),
    gacha_total_pulls: @signals.signal(0),
    gacha_results: @signals.signal([]),
    // --- ログインボーナス ---
    login_streak: @signals.signal(0),
    last_login_bonus_day: @signals.signal(0),
    // --- デイリザルト ---
    day_result: @signals.signal({
      trust_gained: 0, understanding_gained: 0, empathy_gained: 0,
      coins_earned: 0, cards_played: 0, memories_acquired: [],
      rank_up: false, new_star: 1,
      season_milestone: false, milestone_rank: "",
    }),
    today_coins_earned: @signals.signal(0),
    day_start_trust: @signals.signal(0),
    day_start_understanding: @signals.signal(0),
    day_start_empathy: @signals.signal(0),
    // --- プレイヤーレベル ---
    player_exp: @signals.signal(0),
    player_level: @signals.signal(1),
    // --- 強化画面用 ---
    enhance_target_card: @signals.signal(""),
  }
}
