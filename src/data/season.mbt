// 季節・天候データ — 季節サイクルと天候の決定ロジック
//
// 30日で1季節。春→夏→秋→冬で1年（120日）。
// 天候は day のハッシュで決定的に決まる（セーブ/ロード互換）。
//
// 設計参照: docs/superpowers/specs/2026-04-06-social-game-system.md

/// 1季節あたりの日数
pub let days_per_season : Int = 30

/// 日数から季節を取得
///
/// day=1-30: Spring, 31-60: Summer, 61-90: Autumn, 91-120: Winter, 121-: Spring...
pub fn get_season(day : Int) -> Season {
  let index = (day - 1) / days_per_season % 4
  match index {
    0 => Season::Spring
    1 => Season::Summer
    2 => Season::Autumn
    _ => Season::Winter
  }
}

/// 日数から年数を取得（1始まり）
pub fn get_year(day : Int) -> Int {
  (day - 1) / (days_per_season * 4) + 1
}

/// その日が季節の最終日（節目イベント日）かどうか
///
/// 各季節の30日目に季節の節目イベントが発生する。
pub fn is_season_milestone(day : Int) -> Bool {
  (day - 1) % days_per_season == days_per_season - 1 && day > 1
}

/// 季節内の何日目か（1始まり）
pub fn get_day_in_season(day : Int) -> Int {
  (day - 1) % days_per_season + 1
}

/// 日数から天候を決定的に取得
///
/// day のハッシュ値をもとに確率分布に従って天候を決定する。
/// 晴れ50% / 曇り25% / 雨20% / 雪5%（冬のみ、他季節は雨に振替）。
/// ハッシュは day * 7919（素数）で分散を確保。
pub fn get_weather(day : Int) -> Weather {
  // 決定的ハッシュ（day が同じなら常に同じ天候）
  let hash = ((day * 7919) % 100 + 100) % 100  // 0-99 に正規化
  let season = get_season(day)
  if hash < 50 {
    Weather::Sunny
  } else if hash < 75 {
    Weather::Cloudy
  } else if hash < 95 {
    Weather::Rainy
  } else {
    // 残り5%: 冬なら雪、それ以外は雨にフォールバック
    match season {
      Winter => Weather::Snowy
      _ => Weather::Rainy
    }
  }
}

/// 季節の日本語名を取得
pub fn season_to_string(season : Season) -> String {
  match season {
    Spring => "春"
    Summer => "夏"
    Autumn => "秋"
    Winter => "冬"
  }
}

/// 天候の日本語名を取得
pub fn weather_to_string(weather : Weather) -> String {
  match weather {
    Sunny => "晴れ"
    Cloudy => "曇り"
    Rainy => "雨"
    Snowy => "雪"
  }
}

/// 天候のアイコンを取得（UI表示用）
pub fn weather_to_icon(weather : Weather) -> String {
  match weather {
    Sunny => "☀"
    Cloudy => "☁"
    Rainy => "☂"
    Snowy => "⛄"
  }
}

/// 季節の節目イベントのランクを判定（学マスの試験結果に対応）
///
/// 3軸パラメータのバランスと合計値で S/A/B/C を判定する。
/// Sランク条件は「3軸すべて40以上」= 戦略的な育成が必要。
pub fn evaluate_milestone_rank(
  trust : Int,
  understanding : Int,
  empathy : Int
) -> MilestoneRank {
  let total = trust + understanding + empathy
  // Sランク: 3軸バランスよく高い
  if trust >= 40 && understanding >= 40 && empathy >= 40 {
    MilestoneRank::S
  } else if total >= 100 {
    MilestoneRank::A
  } else if total >= 60 {
    MilestoneRank::B
  } else {
    MilestoneRank::C
  }
}

/// ランクの日本語表示
pub fn rank_to_string(rank : MilestoneRank) -> String {
  match rank {
    S => "S"
    A => "A"
    B => "B"
    C => "C"
  }
}

/// 季節の節目テキスト（ランク別）
///
/// 各季節×各ランクで異なるご褒美テキストが表示される。
/// Sランクは特別な思い出シーン、Cランクでも何かしらの体験がある。
pub fn get_milestone_text(season : Season, rank : MilestoneRank) -> String {
  match (season, rank) {
    (Spring, S) =>
      "桜の花びらが風に舞う夕暮れ。帰り道、自然と二人で並んで歩いていた。「きれいですね」——彼女がそう言った。"
    (Spring, A) =>
      "春風が心地よい。灯の前で、少しだけ立ち話をした。「また明日」と言えた。"
    (Spring, B) =>
      "春が終わる。灯に通い始めて一ヶ月。少しずつ、この場所が「いつもの場所」になってきた。"
    (Spring, C) =>
      "春が過ぎていく。まだ、名前も知らない。でも、同じ定食屋に通っているという事実だけが、細い糸のようにつながっている。"
    (Summer, S) =>
      "商店街の夏祭り。人混みの中で、ふいに彼女と目が合った。「あ」——同時に声が出て、二人とも笑った。"
    (Summer, A) =>
      "暑い日が続く。灯の中だけは涼しくて、二人とも少しだけ長居をするようになった。"
    (Summer, B) =>
      "蝉の声が遠くに聞こえる。灯のカウンターで、冷たいお茶を飲む。隣の席が、少しだけ近くなった気がする。"
    (Summer, C) =>
      "夏が終わる。汗ばむ日々の中で、灯に来ることだけが日課になっていた。"
    (Autumn, S) =>
      "彼女が読んでいた本を、自分も読んでみた。感想を伝えると、彼女は少し驚いて、それからゆっくり微笑んだ。「……読んでくれたんですね」"
    (Autumn, A) =>
      "秋の灯は、少しだけ温かい。秋刀魚の匂いの中で、自然な会話が増えた。"
    (Autumn, B) =>
      "紅葉の季節。丸山が「今年の秋刀魚は脂がのってるよ」と教えてくれた。彼女も同じメニューを選んでいた。"
    (Autumn, C) =>
      "秋が深まる。少し肌寒くなった灯の中で、それでも通い続けている自分がいる。"
    (Winter, S) =>
      "大晦日の灯。最後の客は、二人だけだった。「よいお年を」の代わりに、「来年もよろしくお願いします」と言った。彼女が小さく頷いた。"
    (Winter, A) =>
      "冬の灯は、湯気で窓が曇る。温かい料理と、温かい場所。ここに来る理由が、増えた気がする。"
    (Winter, B) =>
      "寒くなった。それでも灯に通う。温かい定食と、向かい側の彼女がいるから。"
    (Winter, C) =>
      "冬が来た。灯の暖簾をくぐるたびに、少しだけほっとする。外は寒くても、ここは温かい。"
  }
}
