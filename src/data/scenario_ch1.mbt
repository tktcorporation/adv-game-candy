// ============================================================
// 第一章: バイト来ました
// ============================================================
//
// あらすじ:
//   天野蓮がバイト志望で突撃してくる。元気すぎて主人公は戸惑う。
//   採用したのかしてないのか曖昧なまま働き始める天野。
//   佐倉がいつも通り来て、いつも通り「ごちそうさま」で帰る。
//   天野が佐倉の存在に気づいて「あの人毎日来るの？」と聞くが、
//   主人公も理由を知らない。天野は主人公を「店長」と呼び始める。
//
// 登場キャラ: 天野蓮（新規）、佐倉美月
// キーイベント:
//   - 天野蓮がバイトとして加入
//   - 天野が主人公を「店長」と呼び始める
//   - 佐倉の無反応が継続（「ごちそうさま」のみ）
//   - 天野が佐倉の存在に疑問を持つ（観察者の導入）
//
// --- 章の状態差分 ---
// 開始状態: 主人公が一人でカフェを回している。佐倉は毎日来る無反応の客。
// 終了状態: 天野がバイトに加入。佐倉の「毎日来るのに無反応」という異様さが
//   第三者（天野）の視点で可視化された。
//   主人公の変化: 一人→バイトができた。少し賑やかになった
//   店の変化: スタッフが増えた（天野）
//   関係性: 天野（バイト。「店長」呼び）、佐倉（変化なし。窓際の遠い席）
// ============================================================

/// Chapter 1: バイト来ました
pub fn get_chapter_1() -> Chapter {
  {
    id: 1,
    title: "第一章",
    subtitle: "バイト来ました",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 1,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: 突撃バイト志願 ---
      // 前提: 開店数日目。主人公は一人で店を回している。暇。
      // 変化: 天野蓮が「バイト募集してますか」と飛び込んでくる
      // 結果: 勢いに押されて半ば採用してしまう
      {
        id: "ch1_s0",
        lines: [
          { speaker: "", text: "開店から数日。客は佐倉さんと、たまに通りすがりの人がちらほら。", is_choice: false, choices: [] },
          { speaker: "", text: "暇すぎてカウンターの木目を数え始めた頃——", is_choice: false, choices: [] },
          { speaker: "", text: "ガシャン、とドアが勢いよく開いた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ちわっす！ ここ、バイト募集してますか！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……してないけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジすか。じゃあ今からしません？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、なに、その交渉術。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたし天野蓮っす。近所の大学通ってて、バイト探してて。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ここ通りかかるたびに「暇そうだな〜」って思ってたんすよね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……外からそう見えてたのか。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いやもう、めっちゃ暇そうっすよ。木目数えてたでしょ今。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "見てたの!?", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "窓からバッチリ。あはは。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……座って。とりあえず。", is_choice: false, choices: [] },
          { speaker: "", text: "天野と名乗った女の子は、カウンターにどかっと座った。", is_choice: false, choices: [] },
          { speaker: "", text: "ショートボブの黒髪。パーカーにジーンズ。リュックは片方の肩にだけかかっている。", is_choice: false, choices: [] },
          { speaker: "", text: "左手首にカラフルなヘアゴムが何本も巻いてある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "飲食の経験は？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ゼロっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……コーヒー淹れられる？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "缶コーヒーなら開けられるっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それはスキルじゃない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でもあたし元気だけはあるんで！ 声出しとか任せてくださいっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "カフェで声出しは要らない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃあ皿洗いとか！ 掃除とか！ なんでもやるっすよ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、一人で回すの大変だなとは思ってたけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でしょ！？ あたしの目に狂いはなかったっすね！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、採用したとは言ってない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、じゃあとりあえず今日タダ働きするんで、見てからでいいっすよ。", is_choice: false, choices: [] },
          { speaker: "", text: "言うが早いか、天野はカウンターの中に入ってきた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おい、まだ許可してないって。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "エプロンどこっすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "聞いてないし。……棚の上。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おっ、かわいいじゃないすかこのエプロン。", is_choice: false, choices: [] },
          { speaker: "", text: "……なし崩し的にバイトが一人増えた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s1",
      },
      // --- Scene 1: 天野、仕事を覚える（覚えない） ---
      // 前提: 天野が働き始めた。主人公が教える側
      // 変化: 天野のノリに振り回される。「店長」呼びが定着
      // 結果: なんだかんだ天野がいると店が明るくなる
      {
        id: "ch1_s1",
        lines: [
          { speaker: "主人公", text: "じゃあまず、カップの場所覚えて。ここと——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はいっす店長！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……店長？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "だって店長でしょ？ 店を任されてるんだから店長っすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "任されたっていうか、押し付けられたっていうか……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "細かいことはいいんすよ。で、カップ。ここっすね。了解っす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……あの、コーヒーの淹れ方は——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あっ、これミルっすか？ ガリガリするやつ。やっていいすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いいけど、量は——", is_choice: false, choices: [] },
          { speaker: "", text: "ガリガリガリガリガリガリ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわ、めっちゃいい匂いするっすね！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "挽きすぎ。それ3杯分くらいある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジすか。あはは、まあ多い分にはいいっしょ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "よくない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長って意外とツッコミ多いっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "君がボケすぎなんだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えへへ。でもほら、あたしがいると賑やかでいいでしょ？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、静かすぎるよりはいいけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "素直じゃないっすね〜店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "素直に言ってるんだけど。", is_choice: false, choices: [] },
          { speaker: "", text: "天野は覚えが悪いわけじゃない。ただ、全部のテンポが速すぎる。", is_choice: false, choices: [] },
          { speaker: "", text: "教えたそばから「了解っす！」と動き出して、半分合ってて半分違う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、グラス拭くのってこう？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "逆。内側から。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おっ、こうっすか。了解了解。", is_choice: false, choices: [] },
          { speaker: "", text: "……でも、天野がいると店内の空気が違う。さっきまでの静寂が嘘みたいだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……悪くないかもな、バイト)", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s2",
      },
      // --- Scene 2: いつもの人 ---
      // 前提: 午後。天野がバイト中。佐倉がいつも通り来店
      // 知識: 天野は佐倉のことを知らない。主人公は「毎日来る客」としか認識していない
      // 変化: 佐倉がいつも通りコーヒーを飲んで「ごちそうさま」。天野が佐倉の存在に気づく
      // 結果: 「あの人毎日来るの？」「知らん」——観察者が加わった
      {
        id: "ch1_s2",
        lines: [
          { speaker: "", text: "午後。天野にカップの場所と皿洗いを一通り教えた頃。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが入ってきた。いつも通り。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪、白いニット、文庫本。迷わず窓際の一番奥の席に座る。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーを。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい、少々お待ちください。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）ね、店長。あの人誰すか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……（小声）常連さん。毎日来る。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）毎日！？ こんな開店したばっかの店に！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……（小声）声でかい。淹れるから待ってて。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れて、窓際の席に運ぶ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはもう本を開いている。顔を上げずに小さく頷いた。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "", text: "——表情、変わらず。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がカウンターの中からじーっと佐倉さんを見ている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……じろじろ見ない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "だって気になるじゃないすか。反応ゼロっすよ？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いつもああだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いつも……。", is_choice: false, choices: [] },
          { speaker: "", text: "30分ほど経った。佐倉さんは本を閉じて、静かに立ち上がった。", is_choice: false, choices: [] },
          { speaker: "", text: "カップは空。全部飲んでいる。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。ドアが閉まった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……えっ、それだけ？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それだけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "美味しいとか、まずいとか、なんもなし？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんもなし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……でも全部飲んでたっすよね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。いつもそう。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "不思議な人っすねえ。名前は？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……知らない。聞いたことない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "毎日来てんのに名前知らないんすか！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "聞くタイミングがないんだよ。来て、飲んで、「ごちそうさま」で帰るから。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……それ、逆にすごくないすか。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s3",
      },
      // --- Scene 3: 気になるけど分からない ---
      // 前提: 佐倉が帰った後。天野と二人でカウンターにいる
      // 変化: 天野が「あの人なんで毎日来るの？」と核心を突く。主人公も答えを持っていない
      // 結果: 佐倉という存在が「不思議な常連」として天野にも認識された。
      //   主人公の中で「なんでだろう」という疑問が強くなる
      {
        id: "ch1_s3",
        lines: [
          { speaker: "", text: "閉店作業。天野が皿を洗い、主人公がカウンターを拭く。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ねえ店長。あの人、なんで毎日来るんすかね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "知らん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、気にならないんすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……気にならないと言えば嘘になるけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でしょ！ だって普通、なんか言うじゃないすか。「美味しい」とか「薄い」とか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、普通はね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの人、コーヒー飲んでる時ずっと本読んでたっすよね。こっち見もしないで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "毎回そうだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でも全部飲む。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "全部飲む。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……なんか、気になるっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……だろ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野はしばらく考え込むように皿を拭いていたが、急に顔を上げた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、そうだ店長。あたし明日も来ていいっすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いつの間に採用が確定したんだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "だって今日一日働いたじゃないすか。しかもタダで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それを言われると弱い。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やった！ じゃあ明日もよろしくっす、店長！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……はいはい。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が「おつかれっしたー！」と元気よく帰っていく。", is_choice: false, choices: [] },
          { speaker: "", text: "一人になった店内。", is_choice: false, choices: [] },
          { speaker: "", text: "窓際の、佐倉さんがいつも座る席を見る。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんで毎日来るんだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "天野に聞かれて、改めて気になった。", is_choice: false, choices: [] },
          { speaker: "", text: "美味しいとも言わない。まずいとも言わない。でも全部飲んで、「ごちそうさま」。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……一度くらい、感想聞いてみたいもんだけどな。", is_choice: false, choices: [] },
          { speaker: "", text: "空のカウンターに、天野のエプロンがたたまれて置いてあった。", is_choice: false, choices: [] },
          { speaker: "", text: "明日は二人体制か。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、悪くないか。", is_choice: false, choices: [] },
          { speaker: "", text: "電気を消して、店を出た。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
