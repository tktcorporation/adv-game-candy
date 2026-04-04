// ============================================================
// 第二十一章: 美味しい
// ============================================================
//
// あらすじ:
//   翌日。普通の朝。でも主人公は緊張している。
//   佐倉が来る——カウンター席に座る。窓際じゃない。
//   主人公がコーヒーを淹れる。丁寧に、でも考えすぎないように。
//   佐倉が一口飲む。
//   「……美味しい」
//   天野「え！？ 今なんて！？」
//   神崎「やっとね」
//   主人公「レシピ変えてないけど」
//   佐倉「……知ってる」
//   ——レシピは変わらなかった。変わったのは佐倉。そして佐倉はそれを知っている。
//   桐谷が寄る。「今日はみなさん楽しそうですね」。
//   佐倉「……別に普通」。でも口元は隠さない。
//   日常は続く。佐倉の席はカウンター。もう定位置。
//   最後の一文は「終わり」ではなく「続いていく」。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛、桐谷楓
// キーイベント:
//   - 佐倉がカウンター席に戻る
//   - 「……美味しい」——物語すべての帰結
//   - 「レシピ変えてないけど」「……知ってる」
//   - 天野の絶叫、神崎の微笑み
//   - 桐谷の来訪と佐倉のリアクション
//   - 日常の継続としてのエンディング
//
// --- 章の状態差分 ---
// 開始状態: ch20で主人公が告白し、佐倉が「明日ちょっと早く来る」と言った。
//   誤解は解けた。距離は戻る予兆がある。
//   主人公は佐倉のコーヒーを準備して待っている。
// 終了状態（最終状態）:
//   主人公の変化: コーヒーの腕は同じ。でも自分として佐倉に向き合えるようになった。
//   店の変化: 変わらない。月灯りはいつもの月灯り。
//   関係性: 佐倉（カウンター席が定位置。「美味しい」と言えるようになった。
//                変わったのはレシピではなく、彼女自身の心。そしてそれを自覚している）
//           天野（日常のツッコミ担当に戻る。ただし少しだけ嬉しそう）
//           神崎（見守り完了。「やっとね」）
//           桐谷（佐倉との関係も穏やか。「楽しそう」と言える外部の目）
//   物語: 終わらない。日常は続く。少しだけ変わった日常が。
// ============================================================

/// Chapter 21: 美味しい — FINAL CHAPTER
///
/// 背景: 物語の最終章。ここまでの21章すべてがこの「美味しい」のために存在する。
/// ch0の「ごちそうさま」（ゼロ反応）から始まった物語が、
/// 「美味しい」（初めての本物の感情表現）で完結する。
///
/// 核心: レシピは変わっていない。変わったのは佐倉自身。
/// そして佐倉はそれを「知っている」。自分が変わったことを自覚している。
/// これは佐倉の成長の物語でもある——感情を出せなかった人が、出せるようになった。
///
/// エンディングは「めでたしめでたし」ではなく「日常は続く」。
/// 佐倉の席がカウンターに定着したことが、言葉以上の結論。
pub fn get_chapter_21() -> Chapter {
  {
    id: 21,
    title: "最終章",
    subtitle: "美味しい",
    unlock_revenue: 42000,
    unlock_recipes: 48,
    unlock_customers: 8,
    unlock_intimacy: 4000,
    scenes: [
      // --- Scene 0: 朝 ---
      // 前提: ch20の翌日。朝。主人公はいつもより早く店に来た。
      //   佐倉が「ちょっと早く来る」と言ったから。
      //   天野もいつも通り来ている。
      // 変化: 主人公の緊張。いつもと同じ準備なのに手が慎重。
      //   天野は知っている顔をしているが、あえて普通にしている。
      // 結果: 準備完了。佐倉を待つ。
      {
        id: "ch21_s0",
        lines: [
          { speaker: "", text: "朝。目が覚めたのは、アラームが鳴る前だった。", is_choice: false, choices: [] },
          { speaker: "", text: "店に着く。鍵を開ける。照明をつけて、椅子を並べる。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもと同じ——のはずなのに、豆を計量する手が、やけに丁寧になる。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの豆。いつもの量。いつもの挽き具合。何も変えない。", is_choice: false, choices: [] },
          { speaker: "", text: "——変えたらダメだ。今日は、いつも通りでいい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おはようございまーす。……今日も早いっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が何か言いたそうにしたけれど、やめた。エプロンを着けて準備を始める。", is_choice: false, choices: [] },
          { speaker: "", text: "看板を「OPEN」にする。午前の客が来て、帰る。普通の午前。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはいつも午後に来る。「ちょっと早く来る」が何時なのか、聞いていなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch21_s1",
      },
      // --- Scene 1: カウンター ---
      // 前提: 午後。佐倉がいつもより少し早く来る。
      //   店内は空いている。天野がカウンターの内側にいる。
      // 知識: 佐倉は昨日「ちょっと早く来る」と言った。
      //   これは佐倉からの初めてのコミットメント。
      // 変化: 佐倉が入ってくる——そして、カウンターの端の席に座る。
      //   窓際ではない。以前の定位置。もう何も言い訳しない。
      //   主人公がコーヒーを淹れる。
      // 結果: コーヒーが佐倉の前に置かれる
      {
        id: "ch21_s1",
        lines: [
          { speaker: "", text: "——カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "午後。いつもより少し、早い時間。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪。白いニット。手には文庫本。", is_choice: false, choices: [] },
          { speaker: "", text: "——変わらない。いつもの佐倉さんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "店内を見回す。", is_choice: false, choices: [] },
          { speaker: "", text: "窓際の席が空いている。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは、まっすぐカウンターに向かった。", is_choice: false, choices: [] },
          { speaker: "", text: "端の席。いつもの——いつもの席。", is_choice: false, choices: [] },
          { speaker: "", text: "座る。鞄を隣に置く。文庫本をカウンターに出す。", is_choice: false, choices: [] },
          { speaker: "", text: "何も言わない。当たり前のように、そこに座っている。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がこちらを見た。目が丸い。", is_choice: false, choices: [] },
          { speaker: "", text: "「言わなくていいから」という顔で首を振った。天野は口をつぐんだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いらっしゃい。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "小さく頷く。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの豆。いつもの量。いつもの温度。", is_choice: false, choices: [] },
          { speaker: "", text: "丁寧に、でも考えすぎないように。", is_choice: false, choices: [] },
          { speaker: "", text: "蒸らし。注ぎ。抽出。", is_choice: false, choices: [] },
          { speaker: "", text: "カップに注ぐ。湯気がゆっくり立ち上がる。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター越しに、佐倉さんの前に置いた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ありがとう。", is_choice: false, choices: [] },
        ],
        next_scene: "ch21_s2",
      },
      // --- Scene 2: 美味しい ---
      // 前提: コーヒーが佐倉の前にある。カウンター越しに二人が向き合っている。
      //   天野はカウンターの内側にいるが、少し離れた位置。
      //   神崎はまだ来ていない。
      // 知識: これまで佐倉は一度も「美味しい」と言ったことがない。
      //   「ごちそうさま」「普通」「別に」——それが佐倉の語彙だった。
      //   コーヒーのレシピは最初期からずっと改善されてきたが、
      //   ここ最近は安定していて変わっていない。
      // 変化: 佐倉がコーヒーを飲む。そして——「美味しい」。
      //   たった一言。でもこの一言に22章分の重みがある。
      // 結果: 物語の核心的瞬間。
      {
        id: "ch21_s2",
        lines: [
          { speaker: "", text: "佐倉さんがカップを持ち上げた。", is_choice: false, choices: [] },
          { speaker: "", text: "両手で、そっと。", is_choice: false, choices: [] },
          { speaker: "", text: "湯気の向こうに、栗色の目が見えた。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "カップをゆっくり下ろす。", is_choice: false, choices: [] },
          { speaker: "", text: "目を閉じた。ほんの一瞬。", is_choice: false, choices: [] },
          { speaker: "", text: "そして——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……美味しい。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "——聞こえた。確かに聞こえた。", is_choice: false, choices: [] },
          { speaker: "", text: "小さな声だった。いつもと同じくらい小さな声。", is_choice: false, choices: [] },
          { speaker: "", text: "でも——", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの距離で、まっすぐ、届いた。", is_choice: false, choices: [] },
          { speaker: "", text: "静寂。", is_choice: false, choices: [] },
          { speaker: "", text: "時間が止まったような、数秒。", is_choice: false, choices: [] },
        ],
        next_scene: "ch21_s3",
      },
      // --- Scene 3: 知ってる ---
      // 前提: 佐倉が「美味しい」と言った直後。
      //   主人公は驚いている。天野は固まっている。
      // 変化: 天野の絶叫でコメディが戻る。
      //   神崎が来る。タイミングが良すぎる（あるいは外から見ていた）。
      //   主人公が「レシピ変えてないけど」——本質的な問い。
      //   佐倉が「知ってる」——物語の核心の答え。
      //   レシピは変わっていない。変わったのは佐倉自身。
      //   そして佐倉はそれを自覚している。
      // 結果: 物語のテーマが着地する
      {
        id: "ch21_s3",
        lines: [
          { speaker: "天野蓮", text: "え！？", is_choice: false, choices: [] },
          { speaker: "", text: "天野の声が、静寂を割った。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "今なんて！？ 今なんて言った！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん！ 今「美味しい」って！ 言った！？ 言ったっすよね！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うるさい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "言った！ 絶対言った！ あたし聞いた！", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "おー、なんか騒がしいね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "神崎さん！ 佐倉さんが「美味しい」って！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……へえ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがカウンターに歩いてきて、佐倉さんの隣に座った。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの方をちらりと見て——小さく笑った。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "やっとね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……何が。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ん？ 別に。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "主人公はまだ、カウンターの内側に立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが「美味しい」と言った。初めて。", is_choice: false, choices: [] },
          { speaker: "", text: "何を言えばいいのか分からなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "だから——事実だけを口にした。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……レシピ、変えてないけど。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカップを置いた。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター越しに、こっちを見た。", is_choice: false, choices: [] },
          { speaker: "", text: "まっすぐ。逸らさずに。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……知ってる。", is_choice: false, choices: [] },
          { speaker: "", text: "——。", is_choice: false, choices: [] },
          { speaker: "", text: "その二文字に、全部詰まっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "レシピは変わっていない。", is_choice: false, choices: [] },
          { speaker: "", text: "変わったのは——佐倉さん自身だ。", is_choice: false, choices: [] },
          { speaker: "", text: "そしてそれを、彼女は知っている。", is_choice: false, choices: [] },
          { speaker: "", text: "分かっていて、「美味しい」と言った。", is_choice: false, choices: [] },
          { speaker: "", text: "——ああ。", is_choice: false, choices: [] },
          { speaker: "", text: "うまく言葉にできない。", is_choice: false, choices: [] },
          { speaker: "", text: "ただ、胸の奥が熱い。", is_choice: false, choices: [] },
        ],
        next_scene: "ch21_s4",
      },
      // --- Scene 4: 日常は続く ---
      // 前提: 物語の核心が着地した後。
      //   全員が揃っている。空気がいつもの賑やかさに戻る。
      //   桐谷が差し入れに来る。
      // 変化: 桐谷と佐倉のやりとり。もう険しくない。
      //   佐倉の「別に普通」——でも口元を隠していない。
      //   日常が続く。でも、少しだけ変わった日常。
      //   佐倉の席はカウンター。もう定位置。
      //   最後の一文で「この物語は続く」と閉じる。
      // 結果: ——エンドロール。
      {
        id: "ch21_s4",
        lines: [
          { speaker: "天野蓮", text: "……あたし今、歴史的瞬間に立ち会ったっす。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……大げさ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "大げさじゃないっすよ！ あたし初めて聞いた！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に、今までだって思ってたけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え！？ じゃあなんで言わなかったんすか！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……聞かれなかったから。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "毎回聞いてたっすよ！ 店長が！ 必死に！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "まあまあ、天野ちゃん。追い詰めない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが文庫本を開いた。顔を隠すように。——でも、耳が少し赤い。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "こんにちは。新作のフィナンシェ、よかったらどうぞ——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "桐谷さん！ 今すごいことがあったんすよ！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "天野ちゃん、黙りなさい。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "ふふ。よく分からないですけど——今日はみなさん、楽しそうですね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に普通。", is_choice: false, choices: [] },
          { speaker: "", text: "——いつもの「普通」。でも今日の佐倉さんは、文庫本の後ろに顔を隠していない。", is_choice: false, choices: [] },
          { speaker: "", text: "口元が見えている。口角がほんの少し上がっている。隠す気がない。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "佐倉さんもフィナンシェどうですか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……もらう。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっ、素直！ いつもはもっと渋い顔してたのに！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……してない。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "してた。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが笑っている。天野が喜んでいる。神崎さんが楽しそうに見守っている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはフィナンシェを一口かじって、コーヒーで流し込んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "——いつもの午後だ。騒がしくて、穏やかで、少しだけ眩しい。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの席はカウンターの端。もう窓際には戻らないだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "文庫本を開く横顔。左手の人差し指がページの端を押さえる。", is_choice: false, choices: [] },
          { speaker: "", text: "今日はちゃんと、ページがめくれている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch21_s5",
      },
      // --- Scene 5: エピローグ——いつもの味 ---
      // 前提: 夕方。閉店が近い。客が減ってきた。
      //   佐倉さんはまだいる。カウンター席で本を読んでいる。
      //   いつもより長い。いつもの一時間を超えている。
      // 変化: 佐倉がおかわりを頼む（初めて）。
      //   主人公がもう一杯淹れる。
      //   最後の会話。日常は続いていく。
      // 結果: ——物語は終わらない。
      {
        id: "ch21_s5",
        lines: [
          { speaker: "", text: "夕方。神崎さんと桐谷さんはもう帰った。天野が片付けを始めている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはまだいる。いつもの一時間を超えて、もう二時間近い。", is_choice: false, choices: [] },
          { speaker: "", text: "ページは順調にめくれている。たまに、ページの合間からこっちを見ている。", is_choice: false, choices: [] },
          { speaker: "", text: "目が合うと逸らす。——でも今日は、逸らした後に口元が緩んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが空のカップを見つめている。何か考えているような顔。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……おかわり、いい？", is_choice: false, choices: [] },
          { speaker: "", text: "——初めてだった。佐倉さんがおかわりを頼んだのは。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……もちろん。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。同じ豆。同じ量。同じ温度。同じレシピ。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター越しに置く。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ありがとう。", is_choice: false, choices: [] },
          { speaker: "", text: "カップを持ち上げる。湯気の向こうの瞳が、こっちを見ている。今度は逸らさなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "一口飲んで、カップを下ろす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どう？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……だよな。", is_choice: false, choices: [] },
          { speaker: "", text: "——「普通」。いつもの返事。でも、もう分かっている。", is_choice: false, choices: [] },
          { speaker: "", text: "この「普通」は——ここにいたいという意味だ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本に視線を戻す。ページをめくる。カウンターの端の、この席で。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店まで、まだ少し時間がある。", is_choice: false, choices: [] },
          { speaker: "", text: "グラスを拭く。窓の外が夕焼けに染まっていく。", is_choice: false, choices: [] },
          { speaker: "", text: "穏やかな午後の、残りの時間。", is_choice: false, choices: [] },
          { speaker: "", text: "——明日も、同じコーヒーを淹れよう。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
