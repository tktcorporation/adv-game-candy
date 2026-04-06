// ゲーム状態管理 — 定食屋「灯」に通うADV
//
// ブルアカ参考設計:
// - プレイヤーランク: メインコンテンツのゲート。行動で常に上がる
// - 親密度レベル: キャラ別、上限なし。3軸パラメータの合計から算出
// - カード育成: ★ランク(1-5) + レベル(1-N)の2軸
// - ジェム通貨ガチャ + 200天井スパーク
// - 定食屋パッシブ収入（ブルアカのカフェ相当）

/// AP の基本上限値
///
/// プレイヤーレベルに応じて増加する（get_max_ap参照）。
pub let base_ap : Int = 5

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

  // 日数
  day : @signals.Signal[Int]

  // --- 親密度（3軸合計、上限なし） ---
  /// 親密度ポイント（後方互換）= trust + understanding + empathy
  /// 親密度レベルは get_affection_level(intimacy) で動的算出
  intimacy : @signals.Signal[Int]

  // --- 関係性3軸 ---
  trust : @signals.Signal[Int]
  understanding : @signals.Signal[Int]
  empathy : @signals.Signal[Int]

  // AP
  ap : @signals.Signal[Int]

  // --- 行動カードシステム ---
  hand : @signals.Signal[Array[@data.ActionCard]]
  today_actions : @signals.Signal[Array[String]]

  // --- 行動カウンタ ---
  total_eat_count : @signals.Signal[Int]
  total_talk_count : @signals.Signal[Int]
  total_observe_count : @signals.Signal[Int]

  // 訪問記録
  visit_log : @signals.Signal[Array[@data.VisitRecord]]
  today_scene_text : @signals.Signal[String]
  today_menu : @signals.Signal[String]

  // デイリーミッション
  daily_missions : @signals.Signal[Array[@data.DailyMission]]

  // コレクション
  discoveries : @signals.Signal[Array[String]]
  talk_memos : @signals.Signal[Array[String]]

  // --- 思い出システム ---
  acquired_memories : @signals.Signal[Array[@data.MemoryRecord]]
  memory_slots : @signals.Signal[@data.MemorySlots]

  // --- 季節の節目 ---
  season_results : @signals.Signal[Array[@data.SeasonResult]]

  // UI状態
  message_log : @signals.Signal[Array[String]]
  album_tab : @signals.Signal[Int]
  story_complete : @signals.Signal[Bool]

  // =========================================================================
  // 通貨システム（ブルアカ参考）
  // =========================================================================

  /// コイン — 行動・ミッション・パッシブで獲得。カード強化に使う
  coins : @signals.Signal[Int]
  /// 星石（ジェム） — ガチャ通貨。ストーリー・実績・ログボ・パッシブで獲得
  gems : @signals.Signal[Int]
  /// 汎用シャード（エリグマ相当） — ガチャ被りで獲得。任意カードのシャードに変換可能
  eligma : @signals.Signal[Int]

  // =========================================================================
  // カードコレクション（★ランク + レベル制）
  // =========================================================================

  /// 獲得済みカード一覧（★ランク・レベル・固有シャード管理）
  owned_cards : @signals.Signal[Array[@data.OwnedCard]]

  // =========================================================================
  // ガチャ（ブルアカの募集に対応）
  // =========================================================================

  /// 現在のバナーでの累計ガチャ回数（スパーク用、★3で非リセット）
  gacha_pity : @signals.Signal[Int]
  /// ★3未排出の連続回数（ソフト天井用、★3でリセット）
  gacha_since_star3 : @signals.Signal[Int]
  /// 全期間の累計ガチャ回数
  gacha_total_pulls : @signals.Signal[Int]
  /// 直近のガチャ結果（演出画面で表示）
  gacha_results : @signals.Signal[Array[@data.GachaResult]]
  /// スパーク可能フラグ（200連到達時にtrue）
  gacha_spark_available : @signals.Signal[Bool]

  // =========================================================================
  // ログインボーナス
  // =========================================================================

  login_streak : @signals.Signal[Int]
  last_login_bonus_day : @signals.Signal[Int]

  // =========================================================================
  // デイリザルト
  // =========================================================================

  day_result : @signals.Signal[@data.DayResultData]
  /// 直前のカードプレイ結果（Scene画面で獲得値・報酬・リアクションを表示するため）
  last_card_result : @signals.Signal[@data.CardResult]
  today_coins_earned : @signals.Signal[Int]
  today_gems_earned : @signals.Signal[Int]
  day_start_trust : @signals.Signal[Int]
  day_start_understanding : @signals.Signal[Int]
  day_start_empathy : @signals.Signal[Int]
  /// 今日の開始時の親密度レベル（レベルアップ検知用）
  day_start_affection_level : @signals.Signal[Int]

  // =========================================================================
  // プレイヤーランク（ブルアカの指揮官レベルに対応）
  // =========================================================================

  /// プレイヤー経験値 — 行動・ミッション・ストーリーで蓄積
  player_exp : @signals.Signal[Int]
  /// プレイヤーレベル — メインストーリーのゲート、AP上限、カードLv上限を決定
  ///
  /// 設計根拠: 親密度と分離することで、キャラが少なくてもストーリーが詰まらない。
  /// プレイヤーレベルは行動すれば必ず上がるため、進行が保証される。
  player_level : @signals.Signal[Int]

  // =========================================================================
  // 強化画面用
  // =========================================================================

  enhance_target_card : @signals.Signal[String]
  /// 強化モード: "star" = ★ランクアップ, "level" = レベルアップ
  enhance_mode : @signals.Signal[String]

  // =========================================================================
  // 親密度マイルストーン（受取済みレベル追跡）
  // =========================================================================

  /// 親密度マイルストーン報酬を受け取った最大レベル
  claimed_affection_milestone : @signals.Signal[Int]

  // =========================================================================
  // 学マス参考リデザイン: ムード・コンボ・週イベント・ターン制
  // =========================================================================

  /// ひよりの今日の気分（学マスのコンディション相当）
  /// 毎日変化し、特定軸のカード効果を強化する
  mood : @signals.Signal[@data.Mood]

  /// 今ターンの選択肢（3枚提示→1枚選択）
  /// 学マスのレッスン選択に対応
  turn_choices : @signals.Signal[@data.TurnChoices]

  /// 今日のターン数（何ターン目か）
  turn_number : @signals.Signal[Int]

  /// 直前のカードプレイのグレード（PERFECT/GOOD/NORMAL）
  last_play_grade : @signals.Signal[@data.PlayGrade]

  /// コンボチェイン数（連続で同系統 or 相性良いカードを出した回数）
  combo_chain : @signals.Signal[Int]
  /// 直前にプレイしたカードのカテゴリ（コンボ判定用）
  last_card_category : @signals.Signal[String]
  /// 直前のコンボボーナス（UI表示用）
  last_combo_bonus : @signals.Signal[@data.ComboBonus]

  /// 週イベント結果の履歴
  weekly_event_results : @signals.Signal[Array[@data.WeeklyEventResult]]
  /// 週の開始時パラメータ（週イベントで「その週の獲得量」を判定するため）
  week_start_trust : @signals.Signal[Int]
  week_start_understanding : @signals.Signal[Int]
  week_start_empathy : @signals.Signal[Int]
}

/// デイリーミッションの初期値を生成
fn create_daily_missions() -> Array[@data.DailyMission] {
  [
    { id: "eat", description: "灯で食事をする", completed: false, reward: 10 },
    { id: "talk", description: "丸山と話す", completed: false, reward: 5 },
    { id: "actions_3", description: "3つの行動をする", completed: false, reward: 20 },
  ]
}

/// 初期ゲーム状態を生成
///
/// 初期ジェム1200で初回10連ガチャ可能（ブルアカの初回無料10連に相当）。
/// コイン1000でカード強化のチュートリアル用。
pub fn create_game_state() -> GameState {
  {
    phase: @signals.signal(@data.GamePhase::Title),
    current_chapter: @signals.signal(0),
    scene_index: @signals.signal(0),
    line_index: @signals.signal(0),
    day: @signals.signal(1),
    intimacy: @signals.signal(0),
    trust: @signals.signal(0),
    understanding: @signals.signal(0),
    empathy: @signals.signal(0),
    ap: @signals.signal(base_ap),
    hand: @signals.signal([]),
    today_actions: @signals.signal([]),
    total_eat_count: @signals.signal(0),
    total_talk_count: @signals.signal(0),
    total_observe_count: @signals.signal(0),
    visit_log: @signals.signal([]),
    today_scene_text: @signals.signal(""),
    today_menu: @signals.signal(""),
    daily_missions: @signals.signal(create_daily_missions()),
    discoveries: @signals.signal([]),
    talk_memos: @signals.signal([]),
    acquired_memories: @signals.signal([]),
    memory_slots: @signals.signal(
      { trust_slot: "", understanding_slot: "", empathy_slot: "" },
    ),
    season_results: @signals.signal([]),
    message_log: @signals.signal([]),
    album_tab: @signals.signal(0),
    story_complete: @signals.signal(false),
    // 通貨（ブルアカ参考: 初期ジェムで初回ガチャ可能）
    coins: @signals.signal(1000),
    gems: @signals.signal(1200),    // 初回10連分
    eligma: @signals.signal(0),
    // カードコレクション
    owned_cards: @signals.signal([]),
    // ガチャ
    gacha_pity: @signals.signal(0),
    gacha_since_star3: @signals.signal(0),
    gacha_total_pulls: @signals.signal(0),
    gacha_results: @signals.signal([]),
    gacha_spark_available: @signals.signal(false),
    // ログインボーナス
    login_streak: @signals.signal(0),
    last_login_bonus_day: @signals.signal(0),
    // デイリザルト
    day_result: @signals.signal({
      trust_gained: 0, understanding_gained: 0, empathy_gained: 0,
      coins_earned: 0, gems_earned: 0, cards_played: 0, memories_acquired: [],
      player_level_up: false, new_player_level: 1,
      affection_level_up: false, new_affection_level: 1,
      season_milestone: false, milestone_rank: "",
      passive_coins: 0,
    }),
    last_card_result: @signals.signal({
      trust_gain: 0, understanding_gain: 0, empathy_gain: 0,
      coin_reward: 0, exp_reward: 0, gem_reward: 0, reaction_text: "",
    }),
    today_coins_earned: @signals.signal(0),
    today_gems_earned: @signals.signal(0),
    day_start_trust: @signals.signal(0),
    day_start_understanding: @signals.signal(0),
    day_start_empathy: @signals.signal(0),
    day_start_affection_level: @signals.signal(1),
    // プレイヤーランク
    player_exp: @signals.signal(0),
    player_level: @signals.signal(1),
    // 強化画面用
    enhance_target_card: @signals.signal(""),
    enhance_mode: @signals.signal("star"),
    // 親密度マイルストーン
    claimed_affection_milestone: @signals.signal(0),
    // 学マス参考リデザイン
    mood: @signals.signal(@data.Mood::Calm),
    turn_choices: @signals.signal({ cards: [], turn_number: 0 } : @data.TurnChoices),
    turn_number: @signals.signal(0),
    last_play_grade: @signals.signal(@data.PlayGrade::Normal),
    combo_chain: @signals.signal(0),
    last_card_category: @signals.signal(""),
    last_combo_bonus: @signals.signal(
      { name: "", description: "", trust_bonus: 0, understanding_bonus: 0, empathy_bonus: 0 } : @data.ComboBonus,
    ),
    weekly_event_results: @signals.signal([]),
    week_start_trust: @signals.signal(0),
    week_start_understanding: @signals.signal(0),
    week_start_empathy: @signals.signal(0),
  }
}
