// ============================================================
// 第十八章: 誤解
// ============================================================
//
// あらすじ:
//   桐谷が主人公を駅前に呼び出す。自分のキャリアについての相談。
//   二人が普通に話しているところを、たまたま佐倉が見かけてしまう。
//   佐倉は文脈を知らない。翌日、カフェに来るが本のページが進まない。
//   早く帰る。天野「佐倉さん今日変じゃない？」。神崎「あーあ。こじれたね」。
//   佐倉が窓際席に戻る——中盤で縮まった距離の逆行。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛、桐谷楓
// キーイベント:
//   - 桐谷の仕事相談（駅前で二人きり）
//   - 佐倉が目撃する（文脈なし）
//   - 翌日の佐倉の異変（本を読めない、早退）
//   - 窓際席への回帰（距離の逆行）
//
// --- 章の状態差分 ---
// 開始状態: ch17で佐倉が戻ってきたが「……なんでもない」で言葉を飲んだ。
//   感情が言葉になりかけている状態。カウンター席。距離は近い。
//   主人公は佐倉のことが気になっているが自覚が曖昧。
// 終了状態: 佐倉が桐谷と主人公の駅前の場面を目撃。誤解。
//   主人公の変化: 佐倉の異変に気づくが原因が分からない
//   店の変化: なし
//   関係性: 佐倉（距離が離れる。窓際に戻る。言葉が減る）
//           桐谷（仕事相談をしただけ。本人に悪意なし）
//           天野（佐倉の異変に気づく）
//           神崎（状況を正確に把握している）
// ============================================================

/// Chapter 18: 誤解
///
/// 背景: 転パートのクライマックス。ch0-17で積み上げた距離が一気に崩れる。
/// 佐倉の窓際席回帰は、読者にとって最も切ない逆行。
/// 桐谷に悪意がないことが重要——誰も悪くないのにすれ違う。
/// 佐倉の「本のページが進まない」描写で、普段の読書がポーズだったことも暗示。
pub fn get_chapter_18() -> Chapter {
  {
    id: 18,
    title: "第十八章",
    subtitle: "誤解",
    unlock_revenue: 36000,
    unlock_recipes: 42,
    unlock_customers: 8,
    unlock_intimacy: 3400,
    scenes: [
      // --- Scene 0: 桐谷からの連絡 ---
      // 前提: 平日の午後。カフェは落ち着いている。
      //   佐倉はカウンター席で本を読んでいる（ch17で戻ってきた直後）。
      //   天野がシフトに入っている。
      // 変化: 桐谷からメッセージが来る。「相談がある」。
      //   主人公は仕事の話だと思い、閉店後に駅前で会う約束をする。
      // 結果: 駅前で桐谷と会う約束が成立
      {
        id: "ch18_s0",
        lines: [
          { speaker: "", text: "午後。いつもの時間帯。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはカウンターの端に座って、文庫本を開いている。", is_choice: false, choices: [] },
          { speaker: "", text: "ページをめくる音が、静かに店内に落ちる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、ミルクもう一本出していいっすか。ラテの仕込み。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ああ、頼む。", is_choice: false, choices: [] },
          { speaker: "", text: "スマホが震えた。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんからのメッセージ。", is_choice: false, choices: [] },
          { speaker: "", text: "『店長さん、今日のお仕事終わりにお時間ありますか？ ちょっとご相談したいことがあって』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(相談？ なんだろう。メニューの共同企画とかかな)", is_choice: false, choices: [] },
          { speaker: "", text: "『大丈夫ですよ。駅前のベンチあたりでいいですか？』と返す。", is_choice: false, choices: [] },
          { speaker: "", text: "すぐに既読がついた。", is_choice: false, choices: [] },
          { speaker: "", text: "『ありがとうございます！ 19時にお待ちしてます』", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なに見てニヤニヤしてんすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "してない。桐谷さんから連絡。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "へー。桐谷さんから。ふーん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんだよその含みのある「ふーん」は。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "べっつにー。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの端で、ページをめくる音が一瞬止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "——気のせいかもしれない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは何事もなかったように、視線を本に落としている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch18_s1",
      },
      // --- Scene 1: 駅前（桐谷の相談） ---
      // 前提: 閉店後。駅前のベンチ。桐谷が先に来ている。
      //   桐谷はチェーン店の仕事に悩みを抱えている。
      //   主人公にとってはただの仕事仲間との会話。
      // 変化: 桐谷のキャリアの悩みを聞く。個人店の良さを語る主人公。
      //   二人は普通に——ただし傍から見れば「親しげに」話している。
      // 結果: 桐谷の相談が終わる。主人公は普通に帰る。
      {
        id: "ch18_s1",
        lines: [
          { speaker: "", text: "駅前。ロータリー脇のベンチに、桐谷さんがいた。", is_choice: false, choices: [] },
          { speaker: "", text: "制服ではなく私服——ふわっとしたワンピースに薄手のカーディガン。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、店長さん。すみません、急に呼び出しちゃって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、全然。で、相談って？", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "……実は、ちょっと迷ってて。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "Cafe BLANCで働き始めて、もうすぐ一年になるんですけど。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "最近、自分がやりたいことと、会社が求めることが、ずれてきた気がして。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ずれ？", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "チェーン店って、マニュアルがあるじゃないですか。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "味も、接客も、全部決まってる。安定してるけど——", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "私、もっとお客さん一人一人に合わせたことがしたいなって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ああ、なんか分かるかも。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "店長さんのお店、見てて思うんです。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "お客さんの好みに合わせて淹れ方変えてるでしょう？ あれ、すごいなって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、最初は全然できなかったよ。今でも手探り。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも、常連さんの顔見て淹れるのは……うん、楽しいかな。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "……やっぱりそうですよね。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "私も、いつか自分のお店持ちたいなって、最近思うようになって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "桐谷さんなら向いてると思うよ。接客上手いし。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "……ありがとうございます。そう言ってもらえると、ちょっと楽になります。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが少し笑った。柔らかい、いつもの笑顔より少しだけ頼りない表情。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、俺が言えたことじゃないけどね。おばさんに丸投げされただけだし。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "でも、続けてるじゃないですか。それが大事だと思います。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうかな。", is_choice: false, choices: [] },
          { speaker: "", text: "しばらく、他愛のない話をした。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒー豆の仕入れ先のこと。常連さんの話。店の掃除が地味に大変なこと。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、もうこんな時間。すみません、長くなっちゃって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、楽しかったよ。また何かあったらいつでも。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "はい。本当にありがとうございました。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが小さくお辞儀をして、改札の方に歩いていく。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いい子だよなあ、桐谷さん。", is_choice: false, choices: [] },
          { speaker: "", text: "何の変哲もない、仕事仲間との会話。", is_choice: false, choices: [] },
          { speaker: "", text: "——のはずだった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch18_s2",
      },
      // --- Scene 2: 目撃 ---
      // 前提: 同じ時間帯。駅前。佐倉が通りかかる。
      //   佐倉は買い物帰り。偶然の遭遇。
      //   ただし佐倉からは「主人公が私服の桐谷と笑って話している」ように見える。
      // 知識: 佐倉は桐谷が主人公に相談していることを知らない。
      //   ch17で自分の気持ちを飲み込んだ直後。感情的に脆い時期。
      // 変化: 佐倉が二人を見かける。立ち止まる。そして、声をかけずに去る。
      // 結果: 誤解が生まれる。佐倉は「桐谷と主人公は親しい」と認識。
      {
        id: "ch18_s2",
        lines: [
          { speaker: "", text: "——少し時間を巻き戻す。", is_choice: false, choices: [] },
          { speaker: "", text: "駅前のロータリー。人通りは多くも少なくもない、夕方の時間帯。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉美月は、書店の紙袋を下げて駅前を歩いていた。", is_choice: false, choices: [] },
          { speaker: "", text: "——ふと、足が止まる。", is_choice: false, choices: [] },
          { speaker: "", text: "ロータリー脇のベンチに、見覚えのある背中。", is_choice: false, choices: [] },
          { speaker: "", text: "隣に座っているのは——ふわっとしたワンピースの女性。", is_choice: false, choices: [] },
          { speaker: "", text: "笑っている。二人とも、穏やかに。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉の指が、紙袋の持ち手を少し強く握った。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "声をかければいい。手を振ればいい。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけのことが、できなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉は視線を逸らして、人混みに紛れるように歩き出した。", is_choice: false, choices: [] },
          { speaker: "", text: "紙袋の中の新しい文庫本が、かすかに音を立てた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch18_s3",
      },
      // --- Scene 3: 翌日——ページが進まない ---
      // 前提: 翌日の午後。佐倉がカフェに来る。
      //   ただし、いつもと何かが違う。天野がシフト中。
      // 知識: 主人公は昨日佐倉に見られたことを知らない。
      //   佐倉は誤解したまま。でもカフェには来る（来ないという選択肢がない）。
      // 変化: 佐倉が窓際席に座る。本を開くが、ページが進まない。
      //   コーヒーを飲み干すのが早い。30分で帰る。
      //   天野が異変に気づく。
      // 結果: 主人公が「何かあったのか」と困惑する
      {
        id: "ch18_s3",
        lines: [
          { speaker: "", text: "翌日。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが入ってきた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いらっしゃい。いつもの——", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは軽く頷いただけで、まっすぐ窓際の席に向かった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "窓際。一番奥の、カウンターから一番遠い席。", is_choice: false, choices: [] },
          { speaker: "", text: "——最初の頃に座っていた、あの席。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……あれ。佐倉さん、今日あっちなんすね。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは文庫本を開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを運ぶ。いつもの配合。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ありがとう。", is_choice: false, choices: [] },
          { speaker: "", text: "目が合わなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに戻って、グラスを拭く。", is_choice: false, choices: [] },
          { speaker: "", text: "……何かが違う。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本を開いているけれど——ページが、めくれない。", is_choice: false, choices: [] },
          { speaker: "", text: "5分。10分。同じページのまま。", is_choice: false, choices: [] },
          { speaker: "", text: "指がページの端を押さえている。いつもの仕草。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、押さえているだけで、めくらない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん、今日なんか変じゃないっすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうか？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ページめくってないっすよ。ずっと。", is_choice: false, choices: [] },
          { speaker: "", text: "言われて、意識する。", is_choice: false, choices: [] },
          { speaker: "", text: "——本当だ。さっきから一度もめくっていない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカップを置いた。空だった。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもは一時間はいるのに、まだ30分も経っていない。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ——佐倉さん。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはもう鞄を肩にかけていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今日、早いね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……用事があるから。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そっか。じゃあ——", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが閉まった。", is_choice: false, choices: [] },
          { speaker: "", text: "……早い。挨拶を返す間もなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch18_s4",
      },
      // --- Scene 4: こじれたね ---
      // 前提: 佐倉が帰った直後。天野と主人公だけ。
      //   しばらくして神崎が来る。
      // 知識: 神崎は観察力が鋭い。状況を見ればだいたい分かる。
      //   天野は佐倉の異変に気づいているが原因が分からない。
      //   主人公は自分が原因だとは思っていない。
      // 変化: 神崎が「あーあ」と状況を読む。主人公の困惑。
      //   天野が「昨日何かあった？」と聞くが、主人公は思い当たらない。
      // 結果: 主人公は原因不明のまま。不安だけが残る。
      {
        id: "ch18_s4",
        lines: [
          { speaker: "天野蓮", text: "……なんか今日の佐倉さん、全然違かったっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ああ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、なんかした？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "してないよ。何も。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ほんとにー？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "本当に。昨日だって普通に——", is_choice: false, choices: [] },
          { speaker: "", text: "——昨日。", is_choice: false, choices: [] },
          { speaker: "", text: "昨日は閉店後に桐谷さんと駅前で話しただけだ。それだけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……何もしてないと思うけど。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "やっほー。コンセント借りるよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、神崎さん。今日佐倉さん変だったんすよ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "変？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "窓際に座って、本読まないで、30分で帰った。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "窓際に戻った？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はい。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……ふうん。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがカウンターに座って、ノートPCを開く。", is_choice: false, choices: [] },
          { speaker: "", text: "ペンをカチカチ鳴らしながら、主人公を見た。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あんた、昨日何してた？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……閉店後に桐谷さんと駅前で会ってた。仕事の相談。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "駅前ね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。キャリアの悩みがあるって言うから——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あーあ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……え？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "こじれたね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何が？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……鈍いね、あんた。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはそれ以上言わずに、画面に向かった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……あたしもなんか分かった気がするっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、何が。教えてくれよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "それは自分で考えてくださいっす。", is_choice: false, choices: [] },
          { speaker: "", text: "二人とも、それ以上何も言わなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "……分からない。何があったのか分からない。", is_choice: false, choices: [] },
          { speaker: "", text: "ただ、窓際に戻った佐倉さんの背中が、妙に遠く見えた。", is_choice: false, choices: [] },
          { speaker: "", text: "最初の頃と同じ距離。なのに、あの頃より遠く感じるのは——", is_choice: false, choices: [] },
          { speaker: "", text: "——近かった頃を、知ってしまったからだ。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
