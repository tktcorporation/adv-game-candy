// コンボシステム — カード連携ボーナス（学マスのスキルカード連携に対応）
//
// 前のターンのカードカテゴリと今のカードカテゴリの組み合わせで
// ボーナスが発生する。「観察→話しかける」「食事→もう一品」など
// 物語的にも自然な流れが戦略的にも有利になる。
//
// 設計根拠:
// 学マスではカードの使用順序が重要で、特定の組み合わせで
// 追加効果が発生する。同様に、定食屋での行動にも「流れ」を持たせ、
// 「ただカードを出す」から「順番を考えてカードを出す」へ昇華する。

/// カードカテゴリの組み合わせからコンボボーナスを取得
///
/// 返り値: Some(ComboBonus) = コンボ成立、None = コンボなし
/// コンボが成立するとチェインカウンタが増加し、次のPERFECT確率も上がる。
pub fn get_combo_bonus(
  prev_category : String,
  current_category : @data.CardCategory
) -> @data.ComboBonus? {
  let current_str = match current_category {
    Eat => "eat"
    Observe => "observe"
    Talk => "talk"
    Special => "special"
    Weather => "weather"
    Seasonal => "seasonal"
  }

  // 観察 → 会話: 「気づきから会話へ」
  // 観察で得た情報をもとに話しかける自然な流れ
  if prev_category == "observe" && current_str == "talk" {
    return Some({
      name: "気づきから会話へ",
      description: "観察で気づいたことを話題にする。自然な会話のきっかけ。",
      trust_bonus: 3,
      understanding_bonus: 2,
      empathy_bonus: 0,
    })
  }

  // 会話 → 食事: 「話しながら食べる」
  // 会話の延長で一緒に食事する流れ
  if prev_category == "talk" && current_str == "eat" {
    return Some({
      name: "話しながら食べる",
      description: "会話が弾んで、気がつけば同じメニューを頼んでいた。",
      trust_bonus: 0,
      understanding_bonus: 2,
      empathy_bonus: 3,
    })
  }

  // 食事 → 食事: 「一緒に食べる喜び」
  // 同じ時間を食事で共有する
  if prev_category == "eat" && current_str == "eat" {
    return Some({
      name: "一緒に食べる喜び",
      description: "同じ空間で、同じ時間に食べる。それだけで十分。",
      trust_bonus: 0,
      understanding_bonus: 0,
      empathy_bonus: 5,
    })
  }

  // 観察 → 観察: 「深い洞察」
  // 連続観察で気づけることがある
  if prev_category == "observe" && current_str == "observe" {
    return Some({
      name: "深い洞察",
      description: "二度目の観察で、最初に見落としていたものに気づく。",
      trust_bonus: 0,
      understanding_bonus: 5,
      empathy_bonus: 0,
    })
  }

  // 会話 → 会話: 「打ち解けた空気」
  // 会話が続くと距離が縮まる
  if prev_category == "talk" && current_str == "talk" {
    return Some({
      name: "打ち解けた空気",
      description: "話が途切れない。いつの間にか、敬語が混じらなくなっている。",
      trust_bonus: 5,
      understanding_bonus: 0,
      empathy_bonus: 0,
    })
  }

  // 食事 → 観察: 「食後の余韻」
  // 食事の後、ゆっくり周りを見る余裕
  if prev_category == "eat" && current_str == "observe" {
    return Some({
      name: "食後の余韻",
      description: "食べ終わって一息。ふと、隣の席を見る余裕が生まれた。",
      trust_bonus: 1,
      understanding_bonus: 3,
      empathy_bonus: 1,
    })
  }

  // 食事 → 会話: 「食後のひとこと」
  if prev_category == "eat" && current_str == "talk" {
    return Some({
      name: "食後のひとこと",
      description: "「美味しかったですね」——食事の感想が、会話の入口になる。",
      trust_bonus: 3,
      understanding_bonus: 0,
      empathy_bonus: 2,
    })
  }

  // 会話 → 観察: 「言葉の裏を読む」
  if prev_category == "talk" && current_str == "observe" {
    return Some({
      name: "言葉の裏を読む",
      description: "話した後だからこそ、表情の変化に気づける。",
      trust_bonus: 1,
      understanding_bonus: 4,
      empathy_bonus: 0,
    })
  }

  // 観察 → 食事: 「彼女と同じものを」
  if prev_category == "observe" && current_str == "eat" {
    return Some({
      name: "彼女と同じものを",
      description: "ひよりが何を頼んだか見てから、同じものを選ぶ。",
      trust_bonus: 0,
      understanding_bonus: 3,
      empathy_bonus: 3,
    })
  }

  // Special / Weather / Seasonal は何と組み合わせてもコンボ
  if current_str == "special" || current_str == "weather" || current_str == "seasonal" {
    if prev_category != "" {
      return Some({
        name: "特別な瞬間",
        description: "日常の延長に、ふと訪れた特別な時間。",
        trust_bonus: 2,
        understanding_bonus: 2,
        empathy_bonus: 2,
      })
    }
  }

  None
}

/// コンボチェインの倍率（100倍整数）
///
/// チェイン0: 100（等倍）、チェイン1: 110（+10%）、チェイン2: 120（+20%）
/// 最大+30%（チェイン3以上）。過度なインフレを防ぐ。
pub fn get_chain_multiplier(chain : Int) -> Int {
  let bonus = if chain > 3 { 3 } else { chain }
  100 + bonus * 10
}

/// コンボ判定してステートを更新（play_card内で呼ばれる）
///
/// 返り値: コンボボーナスのパラメータ加算値 (trust, understanding, empathy)
pub fn process_combo(
  state : GameState,
  current_category : @data.CardCategory
) -> (Int, Int, Int) {
  let prev = state.last_card_category.get()
  let combo = get_combo_bonus(prev, current_category)

  let current_str = match current_category {
    Eat => "eat"
    Observe => "observe"
    Talk => "talk"
    Special => "special"
    Weather => "weather"
    Seasonal => "seasonal"
  }

  match combo {
    Some(bonus) => {
      // コンボ成立: チェインを伸ばす
      state.combo_chain.update(fn(c) { c + 1 })
      state.last_combo_bonus.set(bonus)
      state.last_card_category.set(current_str)
      add_message(state, "COMBO: " + bonus.name + " (" + bonus.description + ")")
      (bonus.trust_bonus, bonus.understanding_bonus, bonus.empathy_bonus)
    }
    None => {
      // コンボ不成立: チェインリセット
      state.combo_chain.set(0)
      state.last_combo_bonus.set(
        { name: "", description: "", trust_bonus: 0, understanding_bonus: 0, empathy_bonus: 0 },
      )
      state.last_card_category.set(current_str)
      (0, 0, 0)
    }
  }
}
