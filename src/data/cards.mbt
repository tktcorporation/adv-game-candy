// 行動カードデータ — 学マスのスキルカードに対応
//
// 毎日の手札にドローされ、APを消費してプレイする。
// 3軸パラメータ（信頼/理解/共感）への影響が異なり、
// どのカードを使うかがゲームの戦略的選択になる。
//
// 設計参照: docs/superpowers/specs/2026-04-06-social-game-system.md

// =========================================================================
// 初期カードプール — ゲーム開始時から使える基本カード
// =========================================================================

/// 初期デッキのカード一覧
///
/// 12枚の基本カード。Eat/Observe/Talk/General の4カテゴリ。
/// これらは UnlockCondition::Always なので最初から手札に出現する。
pub fn get_initial_cards() -> Array[ActionCard] {
  [
    // --- Eat系（共感メイン）---
    {
      id: "c_eat_daily", name: "日替わりを食べる",
      description: "今日のメニューを頼む。同じものを食べる、それだけのこと。",
      category: CardCategory::Eat, rarity: CardRarity::Normal, ap_cost: 2,
      trust_gain: 2, understanding_gain: 3, empathy_gain: 10,
      unlock_condition: UnlockCondition::Always, scene_key: "eat",
    },
    {
      id: "c_eat_savor", name: "じっくり味わう",
      description: "急がず、一口ずつ。丸山の料理に向き合う時間。",
      category: CardCategory::Eat, rarity: CardRarity::Normal, ap_cost: 2,
      trust_gain: 1, understanding_gain: 5, empathy_gain: 12,
      unlock_condition: UnlockCondition::Always, scene_key: "eat",
    },
    {
      id: "c_eat_side", name: "小鉢を追加する",
      description: "今日は小鉢も頼んでみる。少しだけ贅沢な気分。",
      category: CardCategory::Eat, rarity: CardRarity::Uncommon, ap_cost: 2,
      trust_gain: 3, understanding_gain: 2, empathy_gain: 14,
      unlock_condition: UnlockCondition::Always, scene_key: "eat",
    },

    // --- Observe系（理解メイン）---
    {
      id: "c_obs_counter", name: "カウンター越しの観察",
      description: "彼女の横顔を、カウンター越しにそっと見る。",
      category: CardCategory::Observe, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 1, understanding_gain: 5, empathy_gain: 1,
      unlock_condition: UnlockCondition::Always, scene_key: "observe",
    },
    {
      id: "c_obs_glance", name: "さりげなく視線を",
      description: "ページをめくる指。読んでいる本の背表紙。",
      category: CardCategory::Observe, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 2, understanding_gain: 4, empathy_gain: 2,
      unlock_condition: UnlockCondition::Always, scene_key: "observe",
    },
    {
      id: "c_obs_menu", name: "メニューを眺める",
      description: "壁に貼られたメニューを見る。丸山のこだわりが透けて見える。",
      category: CardCategory::Observe, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 1, understanding_gain: 4, empathy_gain: 3,
      unlock_condition: UnlockCondition::Always, scene_key: "observe",
    },

    // --- Talk系（信頼メイン）---
    {
      id: "c_talk_chat", name: "丸山に世間話",
      description: "「今日も暑いですね」——何気ない一言から始まる。",
      category: CardCategory::Talk, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 5, understanding_gain: 2, empathy_gain: 1,
      unlock_condition: UnlockCondition::Always, scene_key: "talk",
    },
    {
      id: "c_talk_hiyori", name: "ひよりのことを聞く",
      description: "丸山なら知っているかもしれない。あの人のこと。",
      category: CardCategory::Talk, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 3, understanding_gain: 5, empathy_gain: 1,
      unlock_condition: UnlockCondition::Always, scene_key: "talk",
    },
    {
      id: "c_talk_cooking", name: "料理の話を聞く",
      description: "「この味噌煮、何分煮込んでるんですか？」",
      category: CardCategory::Talk, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 4, understanding_gain: 3, empathy_gain: 2,
      unlock_condition: UnlockCondition::Always, scene_key: "talk",
    },

    // --- General系（バランス）---
    {
      id: "c_gen_atmosphere", name: "灯の雰囲気を楽しむ",
      description: "木のカウンター、湯気の匂い、テレビの音。ただ、ここにいる。",
      category: CardCategory::Eat, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 3, understanding_gain: 3, empathy_gain: 3,
      unlock_condition: UnlockCondition::Always, scene_key: "eat",
    },
    {
      id: "c_gen_linger", name: "食後にゆっくりする",
      description: "食べ終わっても、すぐには立たない。湯呑みのお茶を啜る。",
      category: CardCategory::Eat, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 2, understanding_gain: 3, empathy_gain: 4,
      unlock_condition: UnlockCondition::Always, scene_key: "eat",
    },
    {
      id: "c_gen_tv", name: "テレビを見る",
      description: "カウンター上のテレビ。丸山がチャンネルを変える。",
      category: CardCategory::Talk, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 3, understanding_gain: 2, empathy_gain: 2,
      unlock_condition: UnlockCondition::Always, scene_key: "talk",
    },
  ]
}

// =========================================================================
// 進行解放カード — ランク・章・条件で追加されるカード
// =========================================================================

/// 進行に応じて解放されるカード
///
/// IntimacyRankReached / ChapterCleared で条件指定。
/// プレイヤーの成長とともにデッキが膨らみ、戦略の幅が広がる。
pub fn get_unlockable_cards() -> Array[ActionCard] {
  [
    // ★2解放（醤油差し程度の距離）
    {
      id: "c_sp_recommend", name: "「これ、美味しいですよ」",
      description: "思わず声をかけてしまった。彼女がこちらを見る。",
      category: CardCategory::Special, rarity: CardRarity::Uncommon, ap_cost: 2,
      trust_gain: 5, understanding_gain: 5, empathy_gain: 8,
      unlock_condition: UnlockCondition::IntimacyRankReached(2),
      scene_key: "special",
    },
    {
      id: "c_obs_book", name: "本の背表紙を読む",
      description: "今日はどんな本を読んでいるのか。タイトルが気になる。",
      category: CardCategory::Observe, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 1, understanding_gain: 7, empathy_gain: 2,
      unlock_condition: UnlockCondition::IntimacyRankReached(2),
      scene_key: "observe",
    },

    // ★3解放（名前を知る距離）
    {
      id: "c_sp_book_talk", name: "本の話を振ってみる",
      description: "「その本、面白いですか？」——初めて、本のことを聞いた。",
      category: CardCategory::Special, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 8, understanding_gain: 10, empathy_gain: 3,
      unlock_condition: UnlockCondition::IntimacyRankReached(3),
      scene_key: "special",
    },
    {
      id: "c_talk_name", name: "名前を呼んでみる",
      description: "「椎名さん」——名前を呼ぶのは、こんなに緊張するものなのか。",
      category: CardCategory::Talk, rarity: CardRarity::Rare, ap_cost: 1,
      trust_gain: 8, understanding_gain: 3, empathy_gain: 5,
      unlock_condition: UnlockCondition::IntimacyRankReached(3),
      scene_key: "talk",
    },

    // ★4解放（隣の席の距離）
    {
      id: "c_sp_next_seat", name: "隣の席に座る",
      description: "今日は、こちら側に座ってみる。一つだけ間を空けて。",
      category: CardCategory::Special, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 10, understanding_gain: 5, empathy_gain: 10,
      unlock_condition: UnlockCondition::IntimacyRankReached(4),
      scene_key: "special",
    },
    {
      id: "c_eat_share", name: "「これ、少し食べます？」",
      description: "小鉢を差し出す。こんなこと、前ならできなかった。",
      category: CardCategory::Eat, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 8, understanding_gain: 3, empathy_gain: 15,
      unlock_condition: UnlockCondition::IntimacyRankReached(4),
      scene_key: "special",
    },
  ]
}

// =========================================================================
// 天候限定カード — 特定天候でのみ手札に出現
// =========================================================================

/// 天候限定カード
///
/// その日の天候が一致した場合のみドロー候補に入る。
/// 通常よりやや効果が高く、プレイヤーに「今日は雨だからあのカードが…」という期待を作る。
pub fn get_weather_cards() -> Array[ActionCard] {
  [
    {
      id: "c_w_rain_umbrella", name: "雨の日の傘",
      description: "店を出ると雨。傘を持っていない彼女が、少し困った顔をしている。",
      category: CardCategory::Weather, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 15, understanding_gain: 3, empathy_gain: 5,
      unlock_condition: UnlockCondition::WeatherOnly(Weather::Rainy),
      scene_key: "special",
    },
    {
      id: "c_w_rain_warmth", name: "雨音を聴きながら",
      description: "雨の日の灯は、少しだけ特別だ。外の音が遠くなる。",
      category: CardCategory::Weather, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 3, understanding_gain: 5, empathy_gain: 5,
      unlock_condition: UnlockCondition::WeatherOnly(Weather::Rainy),
      scene_key: "eat",
    },
    {
      id: "c_w_snow_miso", name: "雪の日の味噌汁",
      description: "窓の外で雪が降っている。味噌汁が、いつもより温かい。",
      category: CardCategory::Weather, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 3, understanding_gain: 3, empathy_gain: 18,
      unlock_condition: UnlockCondition::WeatherOnly(Weather::Snowy),
      scene_key: "eat",
    },
    {
      id: "c_w_sunny_walk", name: "晴れた日の帰り道",
      description: "店を出ると、夕陽がきれいだ。同じ方向に歩く影が二つ。",
      category: CardCategory::Weather, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 4, understanding_gain: 4, empathy_gain: 4,
      unlock_condition: UnlockCondition::WeatherOnly(Weather::Sunny),
      scene_key: "eat",
    },
  ]
}

// =========================================================================
// 季節限定カード — 特定季節でのみ手札に出現
// =========================================================================

/// 季節限定カード
///
/// その季節の間のみドロー候補に入る。
/// 季節の雰囲気を感じさせるフレーバーと、やや高めの効果。
pub fn get_seasonal_cards() -> Array[ActionCard] {
  [
    // 春
    {
      id: "c_s_spring_sakura", name: "桜の話題",
      description: "「桜、もう咲きましたね」——季節の挨拶が、会話のきっかけになる。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 5, understanding_gain: 5, empathy_gain: 5,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Spring),
      scene_key: "talk",
    },
    {
      id: "c_s_spring_new", name: "春の新メニュー",
      description: "丸山が試作した春限定メニュー。筍の天ぷらが添えてある。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 2,
      trust_gain: 3, understanding_gain: 3, empathy_gain: 14,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Spring),
      scene_key: "eat",
    },

    // 夏
    {
      id: "c_s_summer_cold", name: "冷やし茶漬け",
      description: "夏の灯の隠れメニュー。氷の音が涼しい。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 2,
      trust_gain: 2, understanding_gain: 4, empathy_gain: 14,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Summer),
      scene_key: "eat",
    },
    {
      id: "c_s_summer_festival", name: "夏祭りの話題",
      description: "商店街の夏祭り。丸山が焼き鳥の出店を出すらしい。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 5, understanding_gain: 5, empathy_gain: 5,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Summer),
      scene_key: "talk",
    },

    // 秋
    {
      id: "c_s_autumn_reading", name: "読書の秋",
      description: "秋は読書の季節。ひよりの読むペースが少し速い気がする。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 2, understanding_gain: 8, empathy_gain: 3,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Autumn),
      scene_key: "observe",
    },
    {
      id: "c_s_autumn_sanma", name: "秋刀魚を一緒に",
      description: "旬の秋刀魚。同じものを選んだ二人。丸山がにやりと笑う。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 2,
      trust_gain: 4, understanding_gain: 4, empathy_gain: 14,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Autumn),
      scene_key: "eat",
    },

    // 冬
    {
      id: "c_s_winter_nabe", name: "温かい鍋の季節",
      description: "丸山が「今日は鍋にしようか」と言い出した。灯の冬の風物詩。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 2,
      trust_gain: 5, understanding_gain: 3, empathy_gain: 15,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Winter),
      scene_key: "eat",
    },
    {
      id: "c_s_winter_year", name: "年末の挨拶",
      description: "「よいお年を」——その一言が、関係の証になる。",
      category: CardCategory::Seasonal, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 8, understanding_gain: 3, empathy_gain: 5,
      unlock_condition: UnlockCondition::SeasonOnly(Season::Winter),
      scene_key: "talk",
    },
  ]
}

// =========================================================================
// ガチャ専用カード — ガチャでのみ入手可能な限定カード
// =========================================================================

/// ガチャ専用カード
///
/// 通常プレイでは入手不可。ガチャで引くことで初めてデッキに追加される。
/// 効果はやや高め＋ユニークなフレーバーテキスト。
pub fn get_gacha_exclusive_cards() -> Array[ActionCard] {
  [
    // --- Rare (SSR相当) ---
    {
      id: "c_g_silent_meal", name: "二人きりの定食屋",
      description: "他に客がいない夕方。灯に、二人だけの時間が流れる。",
      category: CardCategory::Eat, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 10, understanding_gain: 8, empathy_gain: 15,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "special",
    },
    {
      id: "c_g_same_book", name: "同じ本を読んでいた",
      description: "文庫本の表紙が同じだと気づいた瞬間、目が合った。",
      category: CardCategory::Observe, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 5, understanding_gain: 18, empathy_gain: 10,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "special",
    },
    {
      id: "c_g_closing_time", name: "閉店まで",
      description: "気づけば、二人とも最後の客だった。丸山が笑っている。",
      category: CardCategory::Talk, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 15, understanding_gain: 5, empathy_gain: 12,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "special",
    },
    {
      id: "c_g_birthday_menu", name: "誕生日の特別メニュー",
      description: "丸山がこっそり作った、一人分だけの特別な一皿。",
      category: CardCategory::Eat, rarity: CardRarity::Rare, ap_cost: 2,
      trust_gain: 12, understanding_gain: 5, empathy_gain: 18,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "special",
    },

    // --- Uncommon (SR相当) ---
    {
      id: "c_g_counter_clean", name: "カウンターを拭く手",
      description: "食べ終わったカウンターを、さっと拭く仕草。誰に頼まれたわけでもなく。",
      category: CardCategory::Observe, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 3, understanding_gain: 7, empathy_gain: 3,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "observe",
    },
    {
      id: "c_g_regular_seat", name: "「いつもの」が通じる日",
      description: "丸山が注文を聞く前に料理を出した。常連の特権。",
      category: CardCategory::Talk, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 6, understanding_gain: 3, empathy_gain: 5,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "talk",
    },
    {
      id: "c_g_chopstick_rest", name: "箸置きの向き",
      description: "彼女がそっと箸置きの向きを揃えた。几帳面な人だ。",
      category: CardCategory::Observe, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 2, understanding_gain: 8, empathy_gain: 2,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "observe",
    },
    {
      id: "c_g_maruyama_secret", name: "丸山の秘密レシピ",
      description: "「これは誰にも教えてないんだけどな」——秘伝のタレの話を聞く。",
      category: CardCategory::Talk, rarity: CardRarity::Uncommon, ap_cost: 1,
      trust_gain: 7, understanding_gain: 4, empathy_gain: 3,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "talk",
    },
    {
      id: "c_g_extra_rice", name: "おかわりの温かさ",
      description: "「ご飯、もう一杯いきますか？」——丸山の気遣いが沁みる。",
      category: CardCategory::Eat, rarity: CardRarity::Uncommon, ap_cost: 2,
      trust_gain: 4, understanding_gain: 3, empathy_gain: 10,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "eat",
    },

    // --- Normal (R相当) ---
    {
      id: "c_g_tea_refill", name: "お茶のおかわり",
      description: "湯呑みが空になったタイミングで、丸山が黙って注いでくれた。",
      category: CardCategory::Eat, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 3, understanding_gain: 2, empathy_gain: 4,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "eat",
    },
    {
      id: "c_g_weather_talk", name: "天気の話から",
      description: "「今日は冷えますね」——天気の話は、距離を測る道具だ。",
      category: CardCategory::Talk, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 4, understanding_gain: 2, empathy_gain: 2,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "talk",
    },
    {
      id: "c_g_menu_board", name: "手書きメニューの観察",
      description: "壁のメニュー、よく見ると値段の数字が何度も書き直されている。",
      category: CardCategory::Observe, rarity: CardRarity::Normal, ap_cost: 1,
      trust_gain: 2, understanding_gain: 5, empathy_gain: 2,
      unlock_condition: UnlockCondition::GachaOnly, scene_key: "observe",
    },
  ]
}

// =========================================================================
// カードプール統合
// =========================================================================

/// 全カードを統合したマスターリストを取得
///
/// カードシステムの初期化やデッキ構築で使用する。
/// 解放条件のフィルタリングは呼び出し側で行う。
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
  for card in get_gacha_exclusive_cards() {
    result.push(card)
  }
  result
}
