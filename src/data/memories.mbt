// 思い出データ — 学マスのメモリーに対応
//
// 特定条件を達成すると獲得する収集要素。
// 装備スロットにセットするとパッシブ効果が毎日の行動に加算される。
//
// 設計参照: docs/superpowers/specs/2026-04-06-social-game-system.md

/// 全思い出の定義
///
/// hint: 未獲得時にアルバムで表示されるヒント。
/// パッシブ効果: 装備スロットにセットした場合の毎日のボーナス値。
/// 獲得判定は game/memory_system.mbt で行う。
pub fn get_all_memories() -> Array[Memory] {
  [
    // --- 行動回数系 ---
    {
      id: "m_first_meal",
      title: "最初の日替わり",
      description: "初めて灯で食事をした日。カウンターの木の温もりを覚えている。",
      hint: "灯で初めて食事をする",
      trust_bonus: 0, understanding_bonus: 0, empathy_bonus: 2,
    },
    {
      id: "m_five_meals",
      title: "五回目の「ごちそうさま」",
      description: "五回。もう常連と言っていいのかもしれない。",
      hint: "灯で5回食事をする",
      trust_bonus: 1, understanding_bonus: 0, empathy_bonus: 2,
    },
    {
      id: "m_maruyama_laugh",
      title: "丸山の笑い話",
      description: "丸山が話す昔話は、いつも少しだけ大げさだ。",
      hint: "丸山と5回話す",
      trust_bonus: 3, understanding_bonus: 0, empathy_bonus: 0,
    },
    {
      id: "m_page_finger",
      title: "ページをめくる指",
      description: "彼女がページをめくるとき、左手の薬指で押さえる癖がある。",
      hint: "★2以上で観察を3回行う",
      trust_bonus: 0, understanding_bonus: 3, empathy_bonus: 0,
    },

    // --- 親密度ランク系 ---
    {
      id: "m_rank2",
      title: "醤油差しの距離",
      description: "「あ、醤油どうぞ」——それだけの会話。それだけで十分だった。",
      hint: "★2に到達する",
      trust_bonus: 1, understanding_bonus: 1, empathy_bonus: 1,
    },
    {
      id: "m_rank3",
      title: "名前を知った日",
      description: "椎名ひより。その名前を、丸山から聞いた。",
      hint: "★3に到達する",
      trust_bonus: 2, understanding_bonus: 2, empathy_bonus: 2,
    },
    {
      id: "m_rank4",
      title: "隣の席の温度",
      description: "隣に座っても、もう驚かれない。それがうれしい。",
      hint: "★4に到達する",
      trust_bonus: 2, understanding_bonus: 2, empathy_bonus: 3,
    },
    {
      id: "m_rank5",
      title: "この席が二人の場所になった",
      description: "「いつもの席」が、いつの間にか「二人の席」になっていた。",
      hint: "★5に到達する",
      trust_bonus: 3, understanding_bonus: 3, empathy_bonus: 3,
    },

    // --- 天候系 ---
    {
      id: "m_rainy_day",
      title: "雨の日の灯",
      description: "雨の音が、灯の中では遠く聞こえる。ここだけ別の世界みたいだ。",
      hint: "雨の日に灯を訪れる",
      trust_bonus: 1, understanding_bonus: 1, empathy_bonus: 1,
    },
    {
      id: "m_snowy_day",
      title: "窓の外の雪",
      description: "雪が降っている。灯の中は温かくて、窓が少し曇っている。",
      hint: "雪の日に灯を訪れる",
      trust_bonus: 1, understanding_bonus: 1, empathy_bonus: 2,
    },

    // --- 季節の節目系 ---
    {
      id: "m_spring_s",
      title: "春の記憶・特等席",
      description: "春の終わりに、最高の時間を過ごした。桜が散るのを、二人で見た。",
      hint: "春の節目でSランクを取る",
      trust_bonus: 2, understanding_bonus: 2, empathy_bonus: 3,
    },
    {
      id: "m_summer_s",
      title: "夏の記憶・特等席",
      description: "風鈴の音と、彼女の笑い声。忘れられない夏になった。",
      hint: "夏の節目でSランクを取る",
      trust_bonus: 2, understanding_bonus: 3, empathy_bonus: 2,
    },
    {
      id: "m_autumn_s",
      title: "秋の記憶・特等席",
      description: "同じ本を読んでみた。感想を言い合えるようになった秋。",
      hint: "秋の節目でSランクを取る",
      trust_bonus: 3, understanding_bonus: 2, empathy_bonus: 2,
    },
    {
      id: "m_winter_s",
      title: "冬の記憶・特等席",
      description: "「よいお年を」じゃなくて、「また来年も」と言えた。",
      hint: "冬の節目でSランクを取る",
      trust_bonus: 2, understanding_bonus: 2, empathy_bonus: 3,
    },

    // --- 特別行動系 ---
    {
      id: "m_recommend_food",
      title: "初めてのおすすめ",
      description: "「これ、美味しいですよ」と声をかけた。心臓がうるさかった。",
      hint: "特別行動「これ、美味しいですよ」を使う",
      trust_bonus: 1, understanding_bonus: 1, empathy_bonus: 2,
    },
    {
      id: "m_book_conversation",
      title: "初めての本の話",
      description: "本の話をしたとき、彼女の目が少しだけ輝いた気がした。",
      hint: "特別行動「本の話を振ってみる」を使う",
      trust_bonus: 2, understanding_bonus: 3, empathy_bonus: 0,
    },

    // --- コレクション系 ---
    {
      id: "m_all_menus",
      title: "全メニュー制覇",
      description: "灯のメニューを全部食べた。丸山が「よく食べるねぇ」と笑った。",
      hint: "全ての日替わりメニューを食べる",
      trust_bonus: 2, understanding_bonus: 1, empathy_bonus: 3,
    },
    {
      id: "m_ten_discoveries",
      title: "観察眼",
      description: "いくつもの小さな発見を重ねてきた。この店のこと、あの人のこと。",
      hint: "発見ノートを10個集める",
      trust_bonus: 0, understanding_bonus: 4, empathy_bonus: 0,
    },
  ]
}
