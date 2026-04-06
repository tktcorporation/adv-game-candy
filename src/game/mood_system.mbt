// ムードシステム — ひよりの気分（学マスのコンディションに対応）
//
// 毎日変化する「ひよりの気分」が、どのカードを選ぶかの判断基準になる。
// 気分に合ったカードを出すとPERFECT確率が上がり、獲得量にボーナスが乗る。
//
// 設計根拠:
// 学マスではレッスン開始時のコンディション（好調/絶好調 等）が
// Vo/Da/Vi どのレッスンを受けるかの意思決定を左右する。
// 同様に、ひよりの気分が「今日は観察すべきか、話しかけるべきか」の指針になり、
// 毎日の行動に意味のある差異を生む。

/// 日付からひよりの気分を決定（決定的ハッシュ）
///
/// 天候と同様、日付ベースの決定的生成でセーブ/ロード互換。
/// Calm:30%, Bookworm:30%, Hungry:25%, Special:15%
pub fn get_daily_mood(day : Int) -> @data.Mood {
  let hash = ((day * 8431 + 2903) % 100 + 100) % 100
  if hash < 30 {
    @data.Mood::Calm
  } else if hash < 60 {
    @data.Mood::Bookworm
  } else if hash < 85 {
    @data.Mood::Hungry
  } else {
    @data.Mood::Special
  }
}

/// 気分の表示名
pub fn mood_to_string(mood : @data.Mood) -> String {
  match mood {
    Calm => "穏やか"
    Bookworm => "本に夢中"
    Hungry => "お腹すいた"
    Special => "特別な日"
  }
}

/// 気分のアイコン
pub fn mood_to_icon(mood : @data.Mood) -> String {
  match mood {
    Calm => "☁"
    Bookworm => "📖"
    Hungry => "🍚"
    Special => "✨"
  }
}

/// 気分の説明テキスト（UI表示用）
pub fn mood_to_description(mood : @data.Mood) -> String {
  match mood {
    Calm => "ひよりは穏やかな様子。話しかけやすそうだ。"
    Bookworm => "ひよりは本に夢中。そっと観察するチャンス。"
    Hungry => "ひよりもお腹が空いているみたい。一緒に食べよう。"
    Special => "今日のひよりは、なんだか少し違う。"
  }
}

/// 気分がカードカテゴリとマッチするか判定
///
/// マッチ時: PERFECT確率2倍 + パラメータ+50%ボーナス
/// Special気分: 全カテゴリとマッチ（+25%ボーナス）
pub fn is_mood_match(mood : @data.Mood, category : @data.CardCategory) -> Bool {
  match mood {
    Calm => {
      match category {
        Talk | Special => true
        _ => false
      }
    }
    Bookworm => {
      match category {
        Observe | Special => true
        _ => false
      }
    }
    Hungry => {
      match category {
        Eat | Seasonal => true
        _ => false
      }
    }
    Special => true  // 特別な日は何でもマッチ
  }
}

/// ムードボーナス倍率を計算（100倍整数）
///
/// マッチ時: 150（+50%）、Special全マッチ時: 125（+25%）
/// 非マッチ時: 100（ボーナスなし）
pub fn get_mood_multiplier(mood : @data.Mood, category : @data.CardCategory) -> Int {
  if is_mood_match(mood, category) {
    match mood {
      Special => 125  // 特別な日は控えめボーナス
      _ => 150        // 通常マッチは+50%
    }
  } else {
    100  // ボーナスなし
  }
}

/// カードプレイのグレードを判定（学マスのPERFECTレッスンに対応）
///
/// ムード一致時: PERFECT 40%, GOOD 40%, NORMAL 20%
/// ムード不一致時: PERFECT 10%, GOOD 30%, NORMAL 60%
/// コンボチェイン中はPERFECT確率がさらに上がる。
pub fn determine_play_grade(
  day : Int,
  turn : Int,
  mood : @data.Mood,
  category : @data.CardCategory,
  combo_chain : Int
) -> @data.PlayGrade {
  let mood_match = is_mood_match(mood, category)
  // コンボボーナス: チェイン数×5%をPERFECT確率に加算
  let combo_bonus = if combo_chain > 0 { combo_chain * 5 } else { 0 }

  let (perfect_rate, good_rate) = if mood_match {
    (40 + combo_bonus, 40)
  } else {
    (10 + combo_bonus, 30)
  }

  // 決定的ランダム（日+ターンベース）
  let hash = ((day * 3571 + turn * 7919) % 100 + 100) % 100

  if hash < perfect_rate {
    @data.PlayGrade::Perfect
  } else if hash < perfect_rate + good_rate {
    @data.PlayGrade::Good
  } else {
    @data.PlayGrade::Normal
  }
}

/// グレードの倍率（100倍整数）
pub fn grade_multiplier(grade : @data.PlayGrade) -> Int {
  match grade {
    Perfect => 150   // 1.5倍
    Good => 120      // 1.2倍
    Normal => 100    // 1.0倍
  }
}

/// グレードの表示テキスト
pub fn grade_to_string(grade : @data.PlayGrade) -> String {
  match grade {
    Perfect => "PERFECT!"
    Good => "GOOD!"
    Normal => ""
  }
}

/// 毎日のムードを更新（日送り時に呼ばれる）
pub fn update_daily_mood(state : GameState) -> Unit {
  let day = state.day.get()
  let mood = get_daily_mood(day)
  state.mood.set(mood)
}
