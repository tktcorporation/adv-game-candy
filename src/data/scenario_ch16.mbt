// ============================================================
// 第十六章: 好きでしょ
// ============================================================
//
// あらすじ:
//   転パート開始。神崎が主人公に直球:「佐倉ちゃんのこと好きでしょ」。
//   主人公は否定する。だがその日から、全てが変わる。
//   佐倉の髪、指、ページをめくる仕草——全部が目に入る。
//   コーヒーを何度もこぼす。天野「店長今日3回こぼしてるけど」。
//   佐倉が異変に気づく。「……なに」「なんでもない」。
//   パワーバランスが完全に逆転——今度は主人公が普通にいられない。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛
// キーイベント:
//   - 神崎「佐倉ちゃんのこと好きでしょ」
//   - 主人公の否定→でも意識が止まらない
//   - コーヒー3回こぼす（動揺の物理的表現）
//   - 佐倉「……なに」→主人公「なんでもない」（役割逆転）
//   - 動揺のバランスが逆転:今度は主人公が普通でいられない
//
// --- 章の状態差分 ---
// 開始状態: 夏祭り(ch15)の夜以降。花火の記憶が残っている。
//   佐倉はカウンター席。いつもの日常——のはず。
//   主人公はまだ自分の気持ちを自覚していない。
// 終了状態: 神崎の一言で意識が変わった。佐倉が気になって仕方ない。
//   主人公の変化: 佐倉を意識して動揺するようになった。今までの余裕がなくなった。
//   店の変化: 主人公がミスを連発している。
//   関係性: 佐倉（意識してしまい、まともに話せない。視線が泳ぐ）
//           神崎（直球を投げた。「ようやく」と思っている）
//           天野（主人公の動揺を楽しんでいる）
// ============================================================

/// Chapter 16: 好きでしょ
///
/// 背景: 転パートの開始点。ch0-15で佐倉が少しずつ壁を崩してきたのに対し、
/// ここからは主人公の側が崩れる番。神崎の一言がトリガー。
/// 「好き」という言葉を突きつけられることで、無自覚だった感情が
/// 一気に意識の表面に出てくる。
/// 佐倉のディテール（髪、指、仕草）への過剰な注目は、
/// 恋愛の初期段階の認知変化を表現する。
pub fn get_chapter_16() -> Chapter {
  {
    id: 16,
    title: "第十六章",
    subtitle: "好きでしょ",
    unlock_revenue: 36000,
    unlock_recipes: 36,
    unlock_customers: 12,
    unlock_intimacy: 3200,
    scenes: [
      // --- Scene 0: 神崎の直球 ---
      // 前提: 祭りの数日後。午前中、佐倉がまだ来ていない時間。
      //   場所: 月灯り（午前・営業中）
      //   時間: 午前
      //   知識: 神崎は二人の変化をずっと観察してきた。
      //   祭りの花火の件も天野から聞いている（or 自分で見ていた）。
      //   神崎は「見守る」側だったが、ここで一歩踏み込む。
      // 変化: 神崎がコーヒーを飲みながら、何気なく切り出す。
      //   「佐倉ちゃんのこと好きでしょ」——ストレート。
      //   主人公は動揺して否定する。神崎は「ふーん」とだけ。
      //   でもその一言が刺さる。
      // 結果: 「好き」という言葉が主人公の中に刺さった状態
      {
        id: "ch16_s0",
        lines: [
          { speaker: "", text: "午前中。神崎さんがいつもの席でコーヒー二杯目。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ねえ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "一つ聞いていい？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何。", is_choice: false, choices: [] },
          { speaker: "", text: "まっすぐこっちを見ている。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "佐倉ちゃんのこと、好きでしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……は？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "好きでしょって言ってるの。佐倉ちゃんのこと。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……え、なんでいきなり。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "いきなりじゃないと思うけど。私から見たら半年前から。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いやいや。何言ってんの。客だよ？ 常連の。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "客ねえ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "客だよ。大事な常連さん。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "祭りの夜、二人で花火見てたじゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あれはたまたま——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "本を届けに家まで行ったじゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あれは忘れ物を——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "佐倉ちゃんが来ない日、窓の方ばっかり見てるじゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……見てない。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "見てる。私は観察するのが仕事なの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……別に、特別な感情とかない。佐倉さんは、ただの——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ただの？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ただの、常連。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ふーん。", is_choice: false, choices: [] },
          { speaker: "", text: "PCに目を戻した。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "まあ、いいけど。聞いてみただけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……「好きでしょ」。その三文字が、頭の中で反響してる)", is_choice: false, choices: [] },
        ],
        next_scene: "ch16_s1",
      },
      // --- Scene 1: 午後——佐倉が来る ---
      // 前提: 午前の神崎の一言が頭に残ったまま。午後。
      //   場所: 月灯り（午後・営業中）
      //   時間: 午後
      //   知識: 佐倉はいつも午後に来る。今日もそのはず。
      //   主人公は「好きでしょ」を否定したが、意識が変わっている。
      // 変化: 佐倉が来る。いつも通り——なのに、全てが違って見える。
      //   髪の結び方。本を持つ指。カップに唇をつける角度。
      //   主人公の心拍が上がっている。自分でも分かる。
      //   コーヒーを淹れる手が震える。一杯目をこぼす。
      // 結果: 佐倉を前にして平静を保てない状態
      {
        id: "ch16_s1",
        lines: [
          { speaker: "", text: "午後。カランカラン。佐倉さんが入ってきた。いつも通り。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(——なんで。いつもと同じはずなのに。髪の結び目のほつれた毛まで見えてる)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(今まで何百回と見てたはずなのに、初めて見るみたいだ)", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒー。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、うん。はい。コーヒー。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(声裏返りそう。落ち着け。豆を挽いて、お湯を注いで——手、震えてる)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(落ち着け。何をやってるんだ俺は)", is_choice: false, choices: [] },
          { speaker: "", text: "カップに注ぐ。——こぼした。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……っ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……っ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ごめん、淹れ直す。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別にいい。そのままで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、こぼしたやつは出せないだろ。ちょっと待って。", is_choice: false, choices: [] },
          { speaker: "", text: "淹れ直してカップを置く。佐倉さんの指がカップに伸びてくる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……指を目で追ってる。やめろ)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(やめろやめろやめろ)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(なんでもない顔。なんでもない顔しろ。……できてるか分からない)", is_choice: false, choices: [] },
        ],
        next_scene: "ch16_s2",
      },
      // --- Scene 2: 崩壊する日常 ---
      // 前提: 佐倉がいる午後の営業。天野もいる。
      //   場所: 月灯り（午後・営業中）
      //   時間: 午後（Scene 1の続き）
      //   知識: 主人公は明らかに様子がおかしい。
      //   天野は察しがいい。佐倉は異変に気づくがまだ原因が分からない。
      // 変化: 主人公がミスを連発する。二杯目もこぼす。砂糖と塩を間違える。
      //   天野「店長今日3回こぼしてるけど」。
      //   佐倉がページをめくるのを横目で見てしまう。
      //   髪を耳にかける仕草。今まで何とも思わなかったのに。
      //   全部が目に入る。全部が気になる。
      // 結果: 完全に動揺が表面化している
      {
        id: "ch16_s2",
        lines: [
          { speaker: "", text: "その後もダメだった。コーヒーを出す時にまたこぼした。二回目。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(佐倉さんがページめくるたびに見てしまう。左手の人差し指。いつもの仕草なのに)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、砂糖入れすぎっす。あとそれ塩っす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……え。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……砂糖じゃなくて塩の容器持ってた。危ない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……あぶな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、今日なんかヤバくないすか？ 3回こぼしてるし。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "3回？ 2回じゃなかった？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "さっき奥でもう1回やってたの見たっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……あー。すまん。ちょっと寝不足で。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ほんとに寝不足っすか？ なんかニヤニヤが止まんないんすけど。あたしが。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "寝不足だよ。それ以外の何があるんだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっとー、例えば、誰かのこと意識しちゃって手元がおぼつかないとか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……違う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "否定が遅い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "遅くない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "今のも遅かったっすよ。まあいいっすけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(佐倉さんが髪を耳にかけた。たったそれだけなのに。耳たぶが——俺は何を見てるんだ)", is_choice: false, choices: [] },
          { speaker: "", text: "カップを持つ手に力を入れすぎた。こぼす寸前。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……4回目いきそうっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うるさい。", is_choice: false, choices: [] },
        ],
        next_scene: "ch16_s3",
      },
      // --- Scene 3: ……なに ---
      // 前提: 主人公の動揺が続いている。佐倉も異変に気づいた。
      //   場所: 月灯り（午後・営業中）
      //   時間: 午後（Scene 2の続き）
      //   知識: 佐倉は人の変化に敏感（ただし自分のことは鈍い）。
      //   いつもは主人公がフラットに接してくれるのが佐倉の居心地の良さ。
      // 変化: 佐倉がカップを置く。主人公を見る。
      //   「……なに」——主人公の様子がおかしいことを指摘。
      //   主人公「なんでもない」——これは佐倉のセリフだったはず。
      //   役割が完全に逆転している。佐倉は少し困惑した顔。
      //   主人公は逃げるようにキッチンに引っ込む。
      // 結果: 二人の間のダイナミクスが変わった
      {
        id: "ch16_s3",
        lines: [
          { speaker: "", text: "佐倉さんがカップを置いた。こっちを見ている。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……さっきからずっとこっち見てる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "見てない。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……見てた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……見てない。たまたま視線が。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……たまたまが何回あったか数えようか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "数えないで。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……7回。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "数えてるじゃん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なんか変。今日。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんでもない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(——「なんでもない」。それ、佐倉さんの口癖だったはずなのに)", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが少しだけ目を見開いた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ちょっと奥で仕込みしてくる。天野、頼む。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、はいっす。", is_choice: false, choices: [] },
          { speaker: "", text: "キッチンに逃げ込んだ。壁に背をつける。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……何やってんだ俺。)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(佐倉さんは客だ。大事な常連。それだけ。)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(神崎さんの冗談に振り回されてるだけだ。)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……でも。花火の横顔。玄関先の髪。「前の人のコーヒー、好きだった」の声。全部再生される)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……好き？ 俺が？ 佐倉さんを？)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……いや。分からない。分かるわけない。)", is_choice: false, choices: [] },
        ],
        next_scene: "ch16_s4",
      },
      // --- Scene 4: 閉店後 ---
      // 前提: 佐倉が帰った後。閉店作業中。
      //   場所: 月灯り（閉店後）
      //   時間: 夕方
      //   知識: 今日の主人公は明らかにおかしかった。
      //   天野は事情を察している。神崎は午前中に種を蒔いた張本人。
      // 変化: 天野が「寝不足、治りそうすか？」とからかう。
      //   主人公は疲弊している。佐倉のカップを洗いながら考え事。
      //   佐倉の席——カウンターのいつもの場所。
      //   いつから近くなったんだっけ。最初は窓際だったのに。
      //   ——気づいてしまう。距離が縮まっていたこと。それが嬉しかったこと。
      // 結果: 主人公が自分の気持ちの正体に近づいている（まだ認められない）
      {
        id: "ch16_s4",
        lines: [
          { speaker: "", text: "閉店後。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。寝不足、治りそうすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うるさい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あはは。まあ、頑張ってくださいっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何を頑張るんだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "さあ？ 店長が一番分かってんじゃないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……分かんねえよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "嘘つけっす。じゃ、お疲れっした！", is_choice: false, choices: [] },
          { speaker: "", text: "天野が帰った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いつからあそこに座るようになったんだっけ。最初は窓際だったのに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いつの間にかカウンターに移動してきて……近い。すぐそこにいる。毎日。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……佐倉さんが近くに来てくれた時——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……嬉しかった、かもしれない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……明日からどうしよう。普通に接すればいい。コーヒー淹れて、「ごちそうさま」聞いて。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それだけの、はずなのに。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんのカップに触れた。冷たい陶器。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……これに佐倉さんの唇が——やめろ。気持ち悪いだろ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……でも心臓がうるさい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「佐倉ちゃんのこと、好きでしょ」……参ったな。", is_choice: false, choices: [] },
          { speaker: "", text: "答えは、まだ出せなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
