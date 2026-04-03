// ============================================================
// 第一章: 最初の常連
// ============================================================
//
// あらすじ:
//   開店から数日。佐倉美月がほぼ毎日通い始める。
//   最初は無言の客だった彼女と、コーヒーを介して少しずつ距離が縮まる。
//   「悪くない」が褒め言葉だと気づく。彼女が来るだけで店が「カフェ」になる。
//   やがて夕方、大学生の天野蓮がココアを求めて飛び込んでくる。
//   佐倉と天野——性格も年齢も違う二人が同じ空間にいる不思議さ。
//
// 登場キャラ: 佐倉美月（関係深化）、天野蓮（新規）
// キーイベント:
//   - 佐倉の「悪くない」= 褒め言葉（関係性の第2段階: 日常の共有）
//   - 佐倉の Pet the Dog: 雨の日でも来る → 主人公の支え
//   - 天野の導入（佐倉との関係が定着した後に登場）
//   - 天野の一瞬の翳り（「金物屋の隣の——あ、もうないんだった」）
//   - 佐倉が天野に小さく笑う（キャラクター間の関係線の種）
//
// Want vs. Need:
//   佐倉: Want=上質なコーヒー / Need=もう一度何かを作る勇気
//   天野: Want=居心地のいい場所 / Need=失敗を自分と切り離すこと
// ============================================================

/// Chapter 1: 最初の常連
pub fn get_chapter_1() -> Chapter {
  {
    id: 1,
    title: "第一章",
    subtitle: "最初の常連",
    unlock_revenue: 500,
    unlock_recipes: 0,
    unlock_customers: 0,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 1: 佐倉が通い始める（関係の定着） ---
      {
        id: "ch1_s1",
        lines: [
          { speaker: "", text: "開店から数日が経った。", is_choice: false, choices: [] },
          { speaker: "", text: "「営業中」の看板を出してみたものの、客はまばらだ。", is_choice: false, choices: [] },
          { speaker: "", text: "通りがかりの人が一人。迷い込んだような顔で水だけ飲んで帰った人が一人。", is_choice: false, choices: [] },
          { speaker: "", text: "でも——一人だけ、ほぼ毎日来る人がいる。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "午後二時。今日もドアベルが鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "あの女性——あの日、内見中に来た人。佐倉さん。", is_choice: false, choices: [] },
          { speaker: "", text: "名前は二日目に知った。代金を置く時、小さく名乗ってくれた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "コーヒーを。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの窓際。いつもの文庫本。一言だけの注文。", is_choice: false, choices: [] },
          { speaker: "", text: "淹れ方を毎日少しずつ変えている。蒸らしの時間、温度、豆の量。", is_choice: false, choices: [] },
          { speaker: "", text: "この人が飲むのだから、少しでも良いものを出したい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本を閉じ、カップを両手で包んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "今日のは……悪くないです。", is_choice: false, choices: [] },
          { speaker: "", text: "「悪くない」。", is_choice: false, choices: [] },
          { speaker: "", text: "初日にあれだけ辛辣だった人の「悪くない」は——", is_choice: false, choices: [] },
          { speaker: "", text: "きっと、褒め言葉なのだと気づいた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはそれ以上何も言わず、また本を開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "ページをめくる指先が、どこか穏やかに見えた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s2",
      },
      // --- Scene 2: 雨の日（佐倉との関係深化 + Pet the Dog） ---
      {
        id: "ch1_s2",
        lines: [
          { speaker: "", text: "雨の日。", is_choice: false, choices: [] },
          { speaker: "", text: "朝から降り続いていて、商店街に人影はほとんどない。", is_choice: false, choices: [] },
          { speaker: "", text: "今日は誰も来ないだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターを拭きながら、窓の外を見る。雨粒が流れる景色。", is_choice: false, choices: [] },
          { speaker: "", text: "——カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんだった。傘の雫を丁寧に払いながら入ってくる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……雨なのに。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "雨だから。本が読みたくなるでしょう。", is_choice: false, choices: [] },
          { speaker: "", text: "……そういう理由もあるのか。", is_choice: false, choices: [] },
          { speaker: "", text: "いつものコーヒーを淹れる。雨の音を聞きながら。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本を読みながら、時々窓の外に目をやった。", is_choice: false, choices: [] },
          { speaker: "", text: "雨を見ている時の佐倉さんは、いつもと少しだけ表情が違う。", is_choice: false, choices: [] },
          { speaker: "", text: "……何を見ているのだろう。雨の向こうに、何があるのだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店間際。佐倉さんが立ち上がった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアに向かいかけて——足を止めた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……来週から、カフェラテも出せる？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？ ……やってみます。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "泡は細かめで。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ言って、雨の中に出ていった。", is_choice: false, choices: [] },
          { speaker: "", text: "リクエスト。初めてもらったリクエスト。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは、この店にまた来るつもりでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "その事実が、雨の日なのに——少しだけ、明るかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s3",
      },
      // --- Scene 3: 天野蓮の来店（佐倉との関係が定着した後に） ---
      {
        id: "ch1_s3",
        lines: [
          { speaker: "", text: "夕方。空が茜色に染まり始めた頃。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがまだ窓際で本を読んでいる。もう4杯目だ。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが勢いよく開いた。ベルが普段の倍くらい鳴る。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "すんません、ここカフェっすよね！？", is_choice: false, choices: [] },
          { speaker: "", text: "リュックを背負った青年。息が上がっている。走ってきたのだろうか。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ココアってありますか？ あったかいやつ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ココアか……ちょっと待って。作れると思う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジすか！ やった！", is_choice: false, choices: [] },
          { speaker: "", text: "彼はカウンターの一番端に腰かけた。リュックをドスンと隣の席に置く。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがちらりとこちらを見た。……騒がしい、と思っただろうか。", is_choice: false, choices: [] },
          { speaker: "", text: "ココアを作る。ミルクを温めて、ココアパウダーを溶かす。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、おれ天野っす。天野蓮。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "商店街の金物屋の隣の——あ、もうないんだった。", is_choice: false, choices: [] },
          { speaker: "", text: "一瞬だけ、彼の表情が翳った。", is_choice: false, choices: [] },
          { speaker: "", text: "でもすぐに、元の笑顔に戻る。切り替えが、あまりに早い。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "今はこのへんでバイトしてるんすよ。よろしくっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "よろしく。はい、ココア。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんはカップを受け取ると、大きく一口飲んだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……うまっ！ めっちゃあったまる！", is_choice: false, choices: [] },
          { speaker: "", text: "それから、バイト先の話や大学の話を次々としゃべり始めた。", is_choice: false, choices: [] },
          { speaker: "", text: "さっきまで静かだった店内が、急に賑やかになった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本越しにこちらを見た。", is_choice: false, choices: [] },
          { speaker: "", text: "……少しだけ、口元が緩んでいた気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "迷惑がっている、と思ったのに——違った。", is_choice: false, choices: [] },
          { speaker: "", text: "静かな店に、騒がしい声が加わった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんと天野くん。年齢も性格も全然違う二人。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、二人ともここを選んでくれた。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの中から見る景色が、少しだけ変わった気がした。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
