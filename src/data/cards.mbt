// ひよりの日常行動カード — Layer 1 のコアデータ
//
// 学マスのスキルカードに対応。ひよりが1日にできる行動。
// 初期デッキ8枚 + 進行で追加。デッキ構築の素材。
//
// 設計根拠: 各カードが「バフ付与 or バフ消費」の役割を持ち、
// 「バフを積んでから大技」の掛け算が戦略の核心。

// =========================================================================
// 初期デッキ — ゲーム開始時の8枚
// =========================================================================

/// 初期デッキカード
///
/// バフ付与カード（低コスト）とバフ消費カード（高コスト高リターン）の混成。
/// 8枚で「ひよりの基本的な日常」を表現する。
pub fn get_initial_cards() -> Array[ActionCard] {
  [
    // --- 勇気バフ付与 → 信頼系 ---
    {
      id: "c_explore_walk", name: "近所を散歩する",
      description: "知らない路地を歩く。小さな勇気が生まれる。",
      category: ActionCategory::Explore, stamina_cost: 1,
      trust_gain: 4, understanding_gain: 1, empathy_gain: 1,
      grants_buff: "courage", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "explore",
    },
    {
      id: "c_social_friend", name: "友人に連絡する",
      description: "久しぶりにメッセージを送る。既読がつくまでドキドキ。",
      category: ActionCategory::Social, stamina_cost: 1,
      trust_gain: 5, understanding_gain: 1, empathy_gain: 2,
      grants_buff: "courage", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "social",
    },
    // --- 好奇心バフ付与 → 理解系 ---
    {
      id: "c_read_novel", name: "小説を読む",
      description: "ページをめくる。物語の世界に没頭する静かな時間。",
      category: ActionCategory::Read, stamina_cost: 1,
      trust_gain: 1, understanding_gain: 5, empathy_gain: 1,
      grants_buff: "curiosity", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "read",
    },
    {
      id: "c_study_library", name: "図書館で調べもの",
      description: "気になったことを調べる。知識は好奇心の種。",
      category: ActionCategory::Study, stamina_cost: 1,
      trust_gain: 1, understanding_gain: 4, empathy_gain: 1,
      grants_buff: "curiosity", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "study",
    },
    // --- 安心バフ付与 → 共感系 ---
    {
      id: "c_cook_simple", name: "簡単な自炊",
      description: "卵焼きと味噌汁。自分で作ると、少しだけ安心する。",
      category: ActionCategory::Cook, stamina_cost: 1,
      trust_gain: 1, understanding_gain: 1, empathy_gain: 5,
      grants_buff: "comfort", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "cook",
    },
    {
      id: "c_shop_grocery", name: "スーパーで買い物",
      description: "今日の特売を眺める。献立を考えるのは少し楽しい。",
      category: ActionCategory::Shop, stamina_cost: 1,
      trust_gain: 1, understanding_gain: 2, empathy_gain: 4,
      grants_buff: "comfort", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "shop",
    },
    // --- バフ消費カード（大技）---
    {
      id: "c_cook_challenge", name: "新しいレシピに挑戦",
      description: "ネットで見つけたレシピ。失敗しても、それも経験。",
      category: ActionCategory::Cook, stamina_cost: 2,
      trust_gain: 3, understanding_gain: 3, empathy_gain: 8,
      grants_buff: "", consumes_buff: "comfort", buff_bonus_multiplier: 1500,
      scene_key: "cook",
    },
    {
      id: "c_explore_new", name: "知らない店に入る",
      description: "いつもと違う道を選ぶ。勇気が一歩を後押しする。",
      category: ActionCategory::Explore, stamina_cost: 2,
      trust_gain: 8, understanding_gain: 3, empathy_gain: 3,
      grants_buff: "", consumes_buff: "courage", buff_bonus_multiplier: 1500,
      scene_key: "explore",
    },
  ]
}

// =========================================================================
// 解放カード — 進行で追加
// =========================================================================

/// 進行で解放されるカード
///
/// 灯訪問回数が条件。訪問するほどひよりの日常が豊かになる。
pub fn get_unlockable_cards() -> Array[ActionCard] {
  [
    // 3回来店後
    {
      id: "c_read_cafe", name: "喫茶店で読書",
      description: "いつもと違う場所で本を開く。灯じゃない場所も悪くない。",
      category: ActionCategory::Read, stamina_cost: 2,
      trust_gain: 2, understanding_gain: 8, empathy_gain: 3,
      grants_buff: "", consumes_buff: "curiosity", buff_bonus_multiplier: 1500,
      scene_key: "read",
    },
    // 5回来店後
    {
      id: "c_cook_recipe", name: "灯の味を再現する",
      description: "あの日替わり、家でも作れるかな。丸山さんの味には敵わないけど。",
      category: ActionCategory::Cook, stamina_cost: 2,
      trust_gain: 3, understanding_gain: 5, empathy_gain: 10,
      grants_buff: "", consumes_buff: "comfort", buff_bonus_multiplier: 1500,
      scene_key: "cook",
    },
    // 8回来店後
    {
      id: "c_social_invite", name: "誰かを誘ってみる",
      description: "一人で過ごすのも悪くないけど、たまには誰かと。",
      category: ActionCategory::Social, stamina_cost: 2,
      trust_gain: 10, understanding_gain: 2, empathy_gain: 5,
      grants_buff: "", consumes_buff: "courage", buff_bonus_multiplier: 1500,
      scene_key: "social",
    },
    // 10回来店後
    {
      id: "c_study_deep", name: "じっくり考え事",
      description: "最近のことを振り返る。灯で感じたこと、晴くんのこと。",
      category: ActionCategory::Study, stamina_cost: 2,
      trust_gain: 3, understanding_gain: 10, empathy_gain: 5,
      grants_buff: "", consumes_buff: "curiosity", buff_bonus_multiplier: 1500,
      scene_key: "study",
    },
  ]
}

/// カードIDから解放に必要な訪問回数を返す
pub fn get_card_unlock_visits(card_id : String) -> Int {
  match card_id {
    "c_read_cafe" => 3
    "c_cook_recipe" => 5
    "c_social_invite" => 8
    "c_study_deep" => 10
    _ => 0  // 初期カード
  }
}

// =========================================================================
// 天候限定カード
// =========================================================================

/// 天候限定カード（特定天候でのみ手札に出現）
pub fn get_weather_cards() -> Array[ActionCard] {
  [
    {
      id: "c_w_rain_indoor", name: "雨の日は家で",
      description: "窓の外の雨音。温かいお茶を入れて、ゆっくり過ごす。",
      category: ActionCategory::Read, stamina_cost: 1,
      trust_gain: 2, understanding_gain: 5, empathy_gain: 5,
      grants_buff: "comfort", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "read",
    },
    {
      id: "c_w_sunny_park", name: "晴れの日の公園",
      description: "天気がいいから外に出る。ベンチに座って空を見上げる。",
      category: ActionCategory::Explore, stamina_cost: 1,
      trust_gain: 5, understanding_gain: 2, empathy_gain: 3,
      grants_buff: "courage", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "explore",
    },
  ]
}

// =========================================================================
// 季節限定カード
// =========================================================================

/// 季節限定カード
pub fn get_seasonal_cards() -> Array[ActionCard] {
  [
    {
      id: "c_s_spring_hanami", name: "お花見",
      description: "桜の下で、おにぎりを食べる。一人でも、きれいなものはきれい。",
      category: ActionCategory::Explore, stamina_cost: 2,
      trust_gain: 5, understanding_gain: 3, empathy_gain: 8,
      grants_buff: "", consumes_buff: "courage", buff_bonus_multiplier: 1500,
      scene_key: "explore",
    },
    {
      id: "c_s_summer_ice", name: "かき氷を作る",
      description: "夏はやっぱりかき氷。シロップをかけすぎた。",
      category: ActionCategory::Cook, stamina_cost: 1,
      trust_gain: 2, understanding_gain: 2, empathy_gain: 6,
      grants_buff: "comfort", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "cook",
    },
    {
      id: "c_s_autumn_book", name: "読書の秋",
      description: "秋の夜長に、少し厚い本を手に取る。",
      category: ActionCategory::Read, stamina_cost: 1,
      trust_gain: 1, understanding_gain: 7, empathy_gain: 2,
      grants_buff: "curiosity", consumes_buff: "", buff_bonus_multiplier: 1000,
      scene_key: "read",
    },
    {
      id: "c_s_winter_stew", name: "シチューを煮込む",
      description: "冬はやっぱり温かいもの。コトコト、ゆっくり。",
      category: ActionCategory::Cook, stamina_cost: 2,
      trust_gain: 3, understanding_gain: 3, empathy_gain: 10,
      grants_buff: "", consumes_buff: "comfort", buff_bonus_multiplier: 1500,
      scene_key: "cook",
    },
  ]
}

// =========================================================================
// カードプール統合
// =========================================================================

/// 全カードのマスターリスト
pub fn get_all_cards() -> Array[ActionCard] {
  let result : Array[ActionCard] = []
  for card in get_initial_cards() {
    result.push(card)
  }
  for card in get_unlockable_cards() {
    result.push(card)
  }
  for card in get_weather_cards() {
    result.push(card)
  }
  for card in get_seasonal_cards() {
    result.push(card)
  }
  result
}

/// IDからカードを検索
pub fn get_card_by_id(id : String) -> ActionCard? {
  for card in get_all_cards() {
    if card.id == id {
      return Some(card)
    }
  }
  None
}
