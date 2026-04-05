// ============================================================
// 第五章: メニュー開発会議
// ============================================================
//
// あらすじ:
//   主人公が新メニューを作りたいと宣言。天野が張り切って試作するも大惨事。
//   「別に興味ない」はずの佐倉が、やたら具体的なコーヒーのアドバイスを始める。
//   神崎がすかさず「佐倉ちゃん、詳しいじゃん」とツッコむ。
//   佐倉は「実家がうるさかっただけ」とかわすが、知識量が明らかにおかしい。
//   全員で新ドリンクを完成させる。佐倉の「無関心」の仮面にヒビが入った章。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛
// キーイベント:
//   - 天野の試作が大惨事（コメディ）
//   - 佐倉がコーヒーの具体的アドバイスをする（「普通」の矛盾）
//   - 「実家がうるさかっただけ」（佐倉のコーヒー知識の理由）
//   - 全員で新メニュー完成（一体感の醸成）
//
// --- 章の状態差分 ---
// 開始状態: 3人の常連が定着。佐倉は「普通」を貫いている。
// 終了状態: 新メニュー完成。佐倉がコーヒーに詳しいことが露呈。
//   主人公の変化: 佐倉が無関心ではないことに薄々気づき始めた
//   店の変化: 新メニュー追加。常連参加型のイベントが生まれた
//   関係性: 佐倉（無関心の仮面にヒビ）、天野（失敗しても場を盛り上げる存在）
//     神崎（佐倉の変化を見逃さない観察者）
// ============================================================

/// Chapter 5: メニュー開発会議
///
/// 背景: 佐倉の「無関心」が崩れ始める転換点。
/// 「何を出しても普通」と言う人間が、具体的なコーヒーの改善案を出すのは矛盾。
/// 読者はここで佐倉が「実は気にしている」ことを確信する。
pub fn get_chapter_5() -> Chapter {
  {
    id: 5,
    title: "第五章",
    subtitle: "メニュー開発会議",
    unlock_revenue: 8000,
    unlock_recipes: 15,
    unlock_customers: 5,
    unlock_intimacy: 600,
    scenes: [
      // --- Scene 0: 新メニュー宣言 ---
      // 前提: 常連が3人定着。メニューがマンネリ化してきた。
      //   主人公は「何か新しいものを作りたい」と思っている。
      // 変化: 主人公が新メニュー開発を宣言。天野が即座にノリノリ。
      //   佐倉は「……ふうん」。神崎は「面白そうじゃない」。
      // 結果: 翌日の閉店後に「メニュー開発会議」をやることに
      {
        id: "ch5_s0",
        lines: [
          { speaker: "", text: "午後の営業中。常連の3人が揃っている、いつもの光景。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカウンター寄りの席で読書。神崎さんが壁際でPC。天野がカウンターの中。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なあ天野、最近メニューがマンネリだと思わないか。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え、急にどしたんすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、同じものばっかり出してるなって。新しいドリンク作りたいんだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おっ！ いいっすね！ あたしも何か作りたい！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……天野に作らせるのは少し不安だけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ひど！ あたしだってやればできるっすよ！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "面白そうじゃない。取材させてもらっていい？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "取材って大げさな……ただの試作ですよ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「個人カフェのメニュー開発密着」。読者ウケするわよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジ？ あたしら取材されちゃう！？", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの方をちらりと見る。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんも、よかったら意見もらえたら——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ふうん。", is_choice: false, choices: [] },
          { speaker: "", text: "本から目を上げない。興味なさそう。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん、絶対興味あるのに〜。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃあ明日の閉店後、メニュー開発会議しましょ！ 佐倉さんもまだいるでしょどうせ！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "否定しなかった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "沈黙はイエスよね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そうは言ってない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、翌日。佐倉さんはいつもより30分遅くまで店にいた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch5_s1",
      },
      // --- Scene 1: 天野の大惨事 ---
      // 前提: 翌日の閉店後。4人でメニュー開発会議。
      //   天野が「あたしに任せてください！」と張り切っている。
      // 変化: 天野が独自のアレンジドリンクを試作 → 壮絶な味 → 全員悶絶
      //   コメディの山場。佐倉まで表情が崩れる。
      // 結果: 天野の試作は全滅。でも場が盛り上がった。次の案を考える流れに
      {
        id: "ch5_s1",
        lines: [
          { speaker: "", text: "翌日、閉店後。", is_choice: false, choices: [] },
          { speaker: "", text: "看板をCLOSEDにして、カウンターに材料を並べる。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒー豆、牛乳、シロップ各種、チョコレート、スパイス類。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "よっしゃ！ あたしに任せてくださいっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まずは基本のアレンジからにしない？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "基本なんて退屈っすよ！ インパクトが大事！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "嫌な予感しかしないわ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野はカウンターの中に入り、意気揚々と材料を手に取った。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "名付けて『天野スペシャル』！ エスプレッソにチョコとシナモンと——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "待って、そのシロップはキャラメルじゃなくてメープル——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "大丈夫っすよ！ 甘いもん同士合うでしょ！", is_choice: false, choices: [] },
          { speaker: "", text: "ドボドボドボ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "入れすぎ入れすぎ入れすぎ！", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あっ。", is_choice: false, choices: [] },
          { speaker: "", text: "カップの中で、茶色と黄色とよく分からない色が混ざり合っている。", is_choice: false, choices: [] },
          { speaker: "", text: "香りは……甘い。甘すぎる。そして何かが根本的に間違っている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "で、できた！ 天野スペシャルです！ どうぞ！", is_choice: false, choices: [] },
          { speaker: "", text: "小さなカップに分けて、全員に配る。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ッ——！", is_choice: false, choices: [] },
          { speaker: "", text: "甘い。甘いのに苦い。苦いのにしょっぱい。味覚が混乱している。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……これは、なに？ 新しい罰ゲーム？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっ、そんなひどいっすか？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ひどいかどうか以前に、これはコーヒーなの？", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカップを口元に運ぶ。一口。", is_choice: false, choices: [] },
          { speaker: "", text: "——表情が、動いた。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの無表情が崩れて、眉間にしわが寄っている。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん！？ 大丈夫っすか！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……水。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが水を求めた。初めてのことだった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ごめんなさい！ ごめんなさい！ あたしの味覚がおかしかったっす！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "おかしかったっていうか、そもそも味見した？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……してないっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "しろよ……。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が自分でも一口飲んで——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ッ——まっず！！", is_choice: false, choices: [] },
          { speaker: "", text: "全員が笑った。佐倉さんまで、口元を押さえて肩を震わせていた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch5_s2",
      },
      // --- Scene 2: 佐倉の助言 ---
      // 前提: 天野の試作が全滅。「ちゃんと考えよう」という空気。
      //   主人公がカフェラテのアレンジを試みるが、バランスに苦戦。
      // 変化: 佐倉が「別に」と言いながら具体的なアドバイスを始める。
      //   温度、配合、抽出時間——明らかに素人じゃない知識量。
      //   神崎が「詳しいじゃん」とツッコむ。佐倉は「実家がうるさかっただけ」。
      // 結果: 佐倉がコーヒーに詳しいことが全員に露呈。「無関心」の矛盾が表面化
      {
        id: "ch5_s2",
        lines: [
          { speaker: "主人公", text: "……気を取り直して。俺がやるよ。", is_choice: false, choices: [] },
          { speaker: "", text: "カフェラテをベースにアレンジを試みる。季節のシロップを少し。", is_choice: false, choices: [] },
          { speaker: "", text: "できた。飲んでみる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うーん……悪くないけど、なんかぼやけるな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしにはよく分かんないっすけど……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "美味しいけど、特徴がないわね。どこにでもありそう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だよなあ……。ミルクの量かな。それとも温度——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……エスプレッソの温度が高すぎる。", is_choice: false, choices: [] },
          { speaker: "", text: "全員が佐倉さんの方を見た。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本を閉じていた。いつの間にか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ミルクと合わせるなら、抽出温度はもう少し下げた方がいい。92度じゃなくて88度。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "88度……？ なんで分かるんですか、今の温度。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……音。お湯を注ぐ音で大体分かる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっ、すごくないすかそれ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。あと、ミルクはフォームを厚くしすぎない方がいい。エスプレッソの苦味を活かすなら薄く。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "シロップは後入れじゃなくて、エスプレッソに先に混ぜて。そうすると香りが立つから。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが3文以上続けて話したのは、初めてだった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "佐倉ちゃん、詳しいじゃん。", is_choice: false, choices: [] },
          { speaker: "", text: "ペンをノックしながら、にやにやしている。いつもの顔だ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……実家がうるさかっただけ。コーヒーにこだわる家で。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ふうん。「うるさかった」だけで、抽出温度を音で判別できるようになるものなの？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはカップの縁を指先でなぞった。考え事をする時の癖。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……やってみたら。", is_choice: false, choices: [] },
          { speaker: "", text: "話題を変えた。明らかに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、はい。やってみます。", is_choice: false, choices: [] },
          { speaker: "", text: "言われた通りにやってみる。温度を下げて、シロップを先入れ。フォームは薄く。", is_choice: false, choices: [] },
          { speaker: "", text: "——全然違う。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うわ、これ美味い。さっきと全然違う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジだ！ 全然違う！ 佐倉さんすごい！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別にすごくない。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "すごいわよ。認めなさい。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
        ],
        next_scene: "ch5_s3",
      },
      // --- Scene 3: 完成 ---
      // 前提: 佐倉のアドバイスでベースが完成。全員で仕上げに向かう。
      // 変化: 天野が名前を考える。神崎がメモを取る。佐倉が「もう少し甘くていい」と追加助言。
      //   全員で作った新メニューが完成。
      //   佐倉がそれを飲んで——「……普通」。でも2口目を飲んでいる。
      // 結果: チームで何かを作り上げた達成感。佐倉の矛盾がさらに浮き彫りに
      {
        id: "ch5_s3",
        lines: [
          { speaker: "主人公", text: "あとは仕上げだな。もう少し何か加えたい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はちみつとかどうっすか！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はちみつか……重くならないかな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……少量なら。風味が丸くなる。", is_choice: false, choices: [] },
          { speaker: "", text: "また佐倉さんが口を開いた。もう本を手に取ろうともしない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん、もうがっつり参加してるじゃないすか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……してない。聞かれたから答えてるだけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "聞いてないっすよ？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの耳がまた赤くなっている。もうパターンが分かってきた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "いいじゃない。佐倉ちゃんが参加すると味がまとまるんだから。", is_choice: false, choices: [] },
          { speaker: "", text: "はちみつを少量。最後の試作。", is_choice: false, choices: [] },
          { speaker: "", text: "4つのカップに注いで、全員で飲む。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "美味っ！ これいい！ いいっすよ！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "悪くないわね。ちゃんと個性がある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "よし、これで行こう。問題は名前だけど——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "『月灯りラテ』！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "安直ね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、分かりやすくていいじゃないすか！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ……店の名前が入ってるのは悪くないか。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "記事にはしやすいわ。「看板メニュー誕生」って書けるもの。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やった！ 採用！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんはどうですか。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはカップを見つめている。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "出たっ！ 普通！", is_choice: false, choices: [] },
          { speaker: "", text: "でも——佐倉さんはカップに口をつけた。2口目。", is_choice: false, choices: [] },
          { speaker: "", text: "感想を聞かれた後に、もう一口飲む。", is_choice: false, choices: [] },
          { speaker: "", text: "それが「普通」じゃないことくらい、もう分かっていた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……ねえ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんが小声で耳打ちしてきた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あの子、自分のアドバイスで作ったコーヒー飲んで「普通」って言ったのよ。矛盾してると思わない？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……思います。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "でしょ。可愛いじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはにやりと笑った。", is_choice: false, choices: [] },
          { speaker: "", text: "片付けをしながら、ふと思った。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは今日、俺の店のコーヒーを「改善」してくれた。", is_choice: false, choices: [] },
          { speaker: "", text: "興味がないなら、そんなことしないだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "「普通」の裏側に何があるのか——少しだけ、見えた気がした。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
