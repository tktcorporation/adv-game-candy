// ============================================================
// 第七章: 月灯りの手紙
// ============================================================
//
// あらすじ:
//   宮内がついに藤宮時雨の真実を語る。
//   40年来の友人だったこと。時雨には娘・しずくがいたこと。
//   10年前に絶縁——しずくは自分の夢を追い、時雨はカフェを継いでほしかった。
//   しずくが自分の夢で成功したと聞いた時、時雨は店を閉めた。
//   「もう、しがみつく必要がなくなった」——手放すことが愛だった。
//
// 登場キャラ: 宮内孝之、佐倉美月
// キーイベント:
//   - 宮内が時雨の過去を語る（物語の核心）
//   - 手紙「しずくへ——」への言及（三度触れ #2: 手紙）
//   - 「このカフェは、いつか誰かが必要とする時に開けばいい」
//   - 佐倉がカフェの外で涙を見せる（目撃しない）
//
// --- 章の状態差分 ---
// 開始状態: 常連の過去を知っている。前オーナー「時雨」のレシピを使っている。
//   しかし時雨がなぜ店を閉めたか、しずくとの関係はまだ不明。
// 終了状態: 宮内から時雨の全体像が語られた。
//   40年来の友、娘しずくとの絶縁、しずくの成功、店を閉めた理由。
//   「いつか誰かが必要とする時に」の真の意味を理解。
//   主人公の変化: この店の歴史を受け継ぐ責任と喜びを自覚
//   関係性: 宮内（相互扶助→変容の承認「もう大丈夫だな」）
// ============================================================

/// Chapter 7: 月灯りの手紙
pub fn get_chapter_7() -> Chapter {
  {
    id: 7,
    title: "第七章",
    subtitle: "月灯りの手紙",
    unlock_revenue: 18000,
    unlock_recipes: 20,
    unlock_customers: 5,
    unlock_intimacy: 1500,
    scenes: [
      // --- Scene 1: 宮内の沈黙が破れる前 ---
      // 前提: 常連たちの過去を知った後。秋。
      //   場所: 月灯里（営業中・朝）
      //   時間: 秋の土曜日の朝（宮内の定例来店）
      //   知識: 主人公はレシピノートから前オーナー「時雨」の名前とレシピを知っている。
      //   「しずくへ」の手紙の存在も知っている。
      //   宮内が時雨の旧友であることは分かっているが、詳細は聞いていない。
      // 変化: 宮内が「そろそろ話してもいい頃」と切り出す → 時雨の過去を語り始める
      // 結果: 宮内が語る準備ができた状態（次シーンへ）
      {
        id: "ch7_s1",
        lines: [
          { speaker: "", text: "常連たちの過去を、少しずつ知った。秋が深まっている。", is_choice: false, choices: [] },
          { speaker: "", text: "秋の朝。空気が澄んで、コーヒーの香りがいつもより遠くまで届く。", is_choice: false, choices: [] },
          { speaker: "", text: "週末。宮内さんが来た。いつものほうじ茶を出す。", is_choice: false, choices: [] },
          { speaker: "", text: "でも今日は、何かが違った。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは湯呑みを手にしたまま、しばらく黙っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "言葉を探しているような、覚悟を決めているような。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……そろそろ、話してもいい頃だろう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "宮内さん？", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "時雨のことだ。……前のオーナーのこと。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "君がここを続けている。あのノートも見つけた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "なら——知っておくべきだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんはほうじ茶を一口すすり、静かに話し始めた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s2",
      },
      // --- Scene 2: 時雨の物語 ---
      // 前提: Scene 1の直後。宮内が語り始めた。
      //   場所: 月灯里（同日・同場面）
      //   時間: 同日の朝（連続した会話）
      //   知識: 主人公はノートの「しずくへ」を宮内に伝える。
      // 変化: 宮内が語る — 40年来の友、娘しずくとの絶縁、しずくの成功、店を閉めた理由
      //   「しがみつく必要がなくなった」= 手放すことが愛だった
      //   ここで初めて「15年」「40年」という具体的な時間が明かされる
      // 結果: 時雨の全体像が明らかに。「いつか誰かが必要とする時に」の意味が深まる
      {
        id: "ch7_s2",
        lines: [
          { speaker: "宮内孝之", text: "時雨とは、40年来の付き合いだ。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "わしが古書店を開いた年に、あいつもこのカフェを始めた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "隣同士で、よく茶を飲んだものだ。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんの目が、遠くを見ている。40年前の景色を。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "あいつには……娘がいた。しずくという名の。", is_choice: false, choices: [] },
          { speaker: "", text: "——しずく。あの手紙の宛名。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ノートの最後に……書きかけの手紙がありました。「しずくへ」って。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……そうか。やはり、書いていたか。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは目を閉じた。重い瞼だった。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "しずくは聡い子だった。でも、カフェには興味がなかった。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "自分の夢を追いたいと言った。デザインだったか。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "時雨はこのカフェを継いでほしかった。15年守ってきた場所を。", is_choice: false, choices: [] },
          { speaker: "", text: "親と子。想いはあるのに、向かう方向が違う。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "10年前に——絶縁した。", is_choice: false, choices: [] },
          { speaker: "", text: "その言葉が、静かな店内に落ちた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "時雨は何も言わなくなった。わしにも、誰にも。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ただ黙々と、カフェを続けていた。毎日、同じように。", is_choice: false, choices: [] },
          { speaker: "", text: "15年間。同じ場所で、同じことを。", is_choice: false, choices: [] },
          { speaker: "", text: "それは執着だったのか、祈りだったのか。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "そして2年前——しずくが、自分の夢で成功したと風の噂で聞いた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "成功したのに……？", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "その翌週だ。時雨がわしの店に来て、一言だけ言った。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんの声が、少しだけ震えた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "「もう、しがみつく必要がなくなった」——と。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "しがみつく……。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "時雨にとってこのカフェは、しずくとの最後の繋がりだった。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ここにいれば、いつかしずくが帰ってくるかもしれない。そう思っていたんだろう。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "でも、しずくが自分の足で立てたと分かった時——", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "もう、待つ理由がなくなったんだ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s3",
      },
      // --- Scene 3: 書き置き ---
      // 前提: Scene 2の直後。時雨の物語を聞き終えた。
      //   場所: 月灯里（同日）→ 閉店後
      //   時間: 朝〜閉店後
      //   知識: 時雨がなぜ店を閉めたか、しずくとの関係、書き置きの意味を全て知った。
      //   宮内が「確かめるために」毎週来ていたことも分かった。
      // 変化: 宮内の「もう大丈夫だな」= 主人公への承認
      //   ノートの「しずくへ」の意味を理解する
      //   窓の外で佐倉が立ち止まっている（目撃しない）→ 余韻
      // 結果: この店の歴史と自分の役割を理解した状態。物語の核心に到達。
      {
        id: "ch7_s3",
        lines: [
          { speaker: "主人公", text: "それで、店を……。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "閉めた。静かに。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "書き置きが一つだけ、カウンターに残されていた。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは、ゆっくりと言った。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "「このカフェは、いつか誰かが必要とする時に開けばいい」", is_choice: false, choices: [] },
          { speaker: "", text: "……その言葉が、胸の奥に深く沈んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "いつか誰かが必要とする時に。", is_choice: false, choices: [] },
          { speaker: "", text: "——それが、僕だったのだろうか。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "君がここを開けた時、正直驚いた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "だから毎週来たんだ。あいつの代わりに……確かめるために。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "確かめる……？", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "この店を、大切にしてくれる人間かどうかを。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんが、初めて笑った。穏やかな、深い笑み。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……大丈夫だな。もう、大丈夫だ。", is_choice: false, choices: [] },
          { speaker: "", text: "ほうじ茶が冷めていた。でも、宮内さんはそれを飲み干した。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんが帰った後、しばらく動けなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "ノートを開く。最後のページ。", is_choice: false, choices: [] },
          { speaker: "", text: "『しずくへ——』", is_choice: false, choices: [] },
          { speaker: "", text: "書けなかったのではない。", is_choice: false, choices: [] },
          { speaker: "", text: "言葉にしてしまったら、本当に終わりになるから。", is_choice: false, choices: [] },
          { speaker: "", text: "だから、書かなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外で、佐倉さんが立ち止まっているのが見えた。", is_choice: false, choices: [] },
          { speaker: "", text: "……こちらには背を向けて。", is_choice: false, choices: [] },
          { speaker: "", text: "何をしているのかは、分からなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "分からなくていいと思った。", is_choice: false, choices: [] },
          { speaker: "", text: "秋の夕暮れが、商店街を琥珀色に染めていた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
