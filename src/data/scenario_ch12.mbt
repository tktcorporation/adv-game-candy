// ============================================================
// 第十二章: ピクニック
// ============================================================
//
// あらすじ:
//   定休日。天野がピクニックを提案。佐倉は「行かない」と言うが、
//   当日、公園に現れる（天野が裏で誘っていた）。
//   カフェの外で会うと空気が違う。みんな少しリラックスしている。
//   風が吹いて佐倉の髪が揺れる。主人公の心臓が跳ねる（自覚なし）。
//   佐倉が自然に笑う。一瞬。そして我に返る。
//   神崎はすべてを静かに観察している。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛
// キーイベント:
//   - 佐倉「行かない」→来る
//   - カフェ外での空気の変化
//   - 風に揺れる髪。主人公のドキッ（自覚なし）
//   - 佐倉が自然に笑う→我に返る
//   - 神崎の静かな観察
//
// --- 章の状態差分 ---
// 開始状態: ch11で客数減少。桐谷の差し入れ。佐倉のピリつき。
//   佐倉はカウンター席。距離ゼロ圏。言葉は辛辣・ガード固い。
//   主人公は佐倉の変化に気づき始めているが、理由は分からない。
// 終了状態: カフェの外で「日常の延長」を共有した。
//   主人公の変化: 佐倉を「客」ではなく「人」として見る瞬間が増えている。
//     心臓が跳ねた。でも恋だとは思っていない。
//   佐倉の変化: 油断して笑った。それに自分で驚いた。ガードが緩んでいることへの不安。
//   関係性: 全員がカフェの外でも繋がっていることを実感した。
//           神崎が主人公の変化にも気づき始めている。
// ============================================================

/// Chapter 12: ピクニック
///
/// 背景: 日常の舞台（カフェ）から離れることで、キャラの別の面を見せる。
/// 佐倉が「行かない→来る」のパターンは、彼女の「素直になれない」を象徴する。
/// 主人公の心臓が跳ねるシーンは、恋愛の自覚の「前段階」。
/// 佐倉の笑いは物語全体で見ても貴重な瞬間。ここで「笑った→我に返る」を描く。
/// 神崎は読者の代弁者として、主人公の鈍感さにも言及する。
pub fn get_chapter_12() -> Chapter {
  {
    id: 12,
    title: "第十二章",
    subtitle: "ピクニック",
    unlock_revenue: 24000,
    unlock_recipes: 30,
    unlock_customers: 9,
    unlock_intimacy: 2200,
    scenes: [
      // --- Scene 0: 天野の提案 ---
      // 前提: 定休日前日の閉店後。
      //   場所: 月灯り（閉店後）
      //   時間: 夕方
      //   知識: 客数減少でみんな少し疲れている。天野が空気を変えたい。
      // 変化: 天野が明日のピクニックを提案。主人公は乗り気。
      //   「佐倉さんも誘いましょうよ」→主人公が聞く→佐倉「行かない」
      //   天野が「じゃあしょうがないっすね〜」と言いつつ裏で画策。
      // 結果: ピクニック計画成立。佐倉は不参加（表向き）。
      {
        id: "ch12_s0",
        lines: [
          { speaker: "", text: "閉店後。天野が掃除をしながら言った。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。明日ピクニック行かないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ピクニック？ 急だな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "最近ずっとお店のことばっかじゃないすか。息抜きっすよ息抜き。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "河原公園、桜がまだ残ってるらしいっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いいかもな。たまには外の空気吸わないと。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたし弁当作るっす！ 卵焼きだけは上手いんすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "卵焼きだけ？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "他は……店長担当で！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "結局俺が作るのか……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、神崎さんには連絡したっす。来るって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "行動が早い。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんも誘いましょうよ。店長から言った方がいいっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え、俺？ ……わかった。", is_choice: false, choices: [] },
          { speaker: "", text: "翌日を待たずに、天野がその場で佐倉さんに連絡先を聞いていたらしい。", is_choice: false, choices: [] },
          { speaker: "", text: "——というか、いつの間に交換してたんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "メッセージを送る。「明日、ピクニック行きませんか？ みんなで」", is_choice: false, choices: [] },
          { speaker: "", text: "返信は10分後。", is_choice: false, choices: [] },
          { speaker: "", text: "「行かない」", is_choice: false, choices: [] },
          { speaker: "", text: "句点なし。一言。佐倉さんらしい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "断られた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あー、想定内っす。大丈夫、任せてください。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何する気だ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "女の子には女の子のルートがあるんすよ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がスマホを操作しながらニヤニヤしている。不穏だ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch12_s1",
      },
      // --- Scene 1: 来ないはずの人 ---
      // 前提: 定休日。河原公園。天野・神崎・主人公の3人で集合。
      //   場所: 河原公園
      //   時間: 午前（晴れ）
      //   知識: 佐倉は「行かない」と言った。天野が裏で画策した。
      // 変化: ピクニック開始。レジャーシート広げて食べ物並べて。
      //   しばらくして佐倉が現れる。「……通りかかっただけ」。
      //   天野「えー偶然〜！ じゃあ座ってくっすよ〜！」
      //   佐倉、しぶしぶ座る。
      // 結果: 佐倉がピクニックに参加した状態
      {
        id: "ch12_s1",
        lines: [
          { speaker: "", text: "河原公園。晴れ。風が気持ちいい。", is_choice: false, choices: [] },
          { speaker: "", text: "桜の花びらがまだ少し残っている。芝生の上にレジャーシートを広げた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "最高っすね！ ピクニック日和！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "久しぶりに外で仕事以外のことしてる気がする。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "神崎さん、PC持ってきてないよね？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……スマホはある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "仕事禁止っす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "サンドイッチ作ってきた。あとコーヒーは水筒に入れてある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしの卵焼きもどうぞ！ 自信作っす！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……甘い卵焼き。子供っぽくて悪くないね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "褒めてるんすか貶してるんすか。", is_choice: false, choices: [] },
          { speaker: "", text: "食べながら笑う。カフェとは違う空気だ。開放感がある。", is_choice: false, choices: [] },
          { speaker: "", text: "30分くらい経った頃だろうか。", is_choice: false, choices: [] },
          { speaker: "", text: "公園の入り口から、見慣れた姿が歩いてきた。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪。白いブラウス。文庫本を持った——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さん？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……通りかかっただけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えーっ！ 偶然！ すごーい！ じゃあせっかくだから座ってくっすよ！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に、そういうつもりは——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "サンドイッチあるっすよ。店長の手作り。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがレジャーシートの端にちょこんと座った。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "偶然ねえ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがコーヒーを飲みながら、口角だけで笑っている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はい、佐倉さんにも卵焼き！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ありがとう。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが卵焼きを一切れ食べた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "どうっすか！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……甘い。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "感想それだけ！？ 佐倉さん、店長と同じこと言うっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "俺は美味いって言ったぞ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……美味しいとは言ってない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ひどい！", is_choice: false, choices: [] },
        ],
        next_scene: "ch12_s2",
      },
      // --- Scene 2: 風と髪 ---
      // 前提: ピクニック中。みんなでくつろいでいる。
      //   場所: 河原公園（レジャーシートの上）
      //   時間: 昼
      //   知識: 佐倉は普段、髪をゆるくまとめている。
      //   カフェの中では風が吹かない。外だからこそ見える変化。
      // 変化: 風が吹いて佐倉の髪が揺れる。主人公の心臓が跳ねる。
      //   佐倉は気づかず本を読んでいる。神崎が主人公の反応を見ている。
      //   主人公は「なんだ今の」と思うが、すぐ忘れようとする。
      // 結果: 主人公に恋愛感情の萌芽（ただし自覚なし）
      {
        id: "ch12_s2",
        lines: [
          { speaker: "", text: "食後。みんなそれぞれくつろいでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "天野はスマホで写真を撮っている。神崎さんは芝生に寝転がっている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは——やっぱり本を読んでいる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さん、ピクニックに来て本読むの？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……通りかかっただけだから。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まだそれ言う？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……事実だから。", is_choice: false, choices: [] },
          { speaker: "", text: "ふっ、と風が吹いた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの髪が揺れた。まとめていたゴムが緩かったのか、ほどけかけて——", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪が、風に流れた。", is_choice: false, choices: [] },
          { speaker: "", text: "陽の光を受けて、少しだけ明るく見える。", is_choice: false, choices: [] },
          { speaker: "", text: "——どくん。", is_choice: false, choices: [] },
          { speaker: "", text: "心臓が、跳ねた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや。……髪、ほどけかけてる。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "あ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが慌てて髪をまとめ直した。耳が少し赤い——のは日差しのせいか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……風が強い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だな。……いい天気だけど。", is_choice: false, choices: [] },
          { speaker: "", text: "なんだ今の。心臓。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒー飲みすぎたか。水筒のコーヒー、ちょっと濃かったかもしれない。", is_choice: false, choices: [] },
          { speaker: "", text: "……うん。カフェインだ。カフェインのせいだ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんが、寝転がったまま——こっちを見ていた。", is_choice: false, choices: [] },
          { speaker: "", text: "目が合った。神崎さんの口角が上がっている。", is_choice: false, choices: [] },
          { speaker: "", text: "——見られてた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なに。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "何も。いい天気だなって。", is_choice: false, choices: [] },
          { speaker: "", text: "絶対嘘だ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch12_s3",
      },
      // --- Scene 3: 佐倉、笑う ---
      // 前提: ピクニック中盤。場が温まっている。
      //   場所: 河原公園
      //   時間: 午後
      //   知識: 佐倉がカフェ外で声を出して笑うことはほぼない。
      //   天野は場を盛り上げるのが上手い。
      // 変化: 天野がおどけたことをして、佐倉がつい笑う。
      //   自然な笑い。声が出た。佐倉自身が驚く。
      //   すぐに口元を手で押さえて、表情を消そうとする。
      //   主人公は「今、笑った？」と思う。
      //   佐倉「……笑ってない」。でも、もう手遅れ。
      // 結果: 佐倉の笑顔という「ご褒美」が読者に提供される。でも佐倉は閉じる。
      {
        id: "ch12_s3",
        lines: [
          { speaker: "天野蓮", text: "あ、あのベンチのとこ見てくださいっす！ 猫！", is_choice: false, choices: [] },
          { speaker: "", text: "天野が指さした先に、三毛猫がいる。日向ぼっこしている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "呼んでみるっす。ぬこぬこぬこー。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "呼び方。", is_choice: false, choices: [] },
          { speaker: "", text: "猫がちらっとこちらを見て——無視した。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "シカトされた！ じゃあサンドイッチで釣るっす！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "猫にサンドイッチはダメでしょ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃあ何で釣れば……", is_choice: false, choices: [] },
          { speaker: "", text: "天野がそろそろと猫に近づく。猫はじっとしている。", is_choice: false, choices: [] },
          { speaker: "", text: "あと一歩——というところで、猫がするっと天野の足の間をすり抜けた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あっ、待っ——うわっ！", is_choice: false, choices: [] },
          { speaker: "", text: "天野がバランスを崩して、芝生に尻もちをついた。", is_choice: false, choices: [] },
          { speaker: "", text: "猫は悠然と——", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの足元に歩いていった。", is_choice: false, choices: [] },
          { speaker: "", text: "すりすり。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっ、ずるい！ 佐倉さんには行くの！？", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本を下ろして、猫を見た。", is_choice: false, choices: [] },
          { speaker: "", text: "猫が佐倉さんの膝にぽすんと乗った。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんで！？ あたし5分追いかけたのに！", is_choice: false, choices: [] },
          { speaker: "", text: "天野が芝生まみれで抗議している。猫は佐倉さんの膝で丸くなっている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが——", is_choice: false, choices: [] },
          { speaker: "", text: "笑った。", is_choice: false, choices: [] },
          { speaker: "", text: "小さく、でもはっきりと。声が出ていた。", is_choice: false, choices: [] },
          { speaker: "", text: "「ふ」——それだけの音。でも、初めて聞いた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、はっとした顔をした。", is_choice: false, choices: [] },
          { speaker: "", text: "自分が笑ったことに——自分で驚いている。", is_choice: false, choices: [] },
          { speaker: "", text: "すぐに手で口元を押さえた。表情が消える。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……笑ってない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いや、今めっちゃ笑ったっすよね！？ 見たっすよ！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……見間違い。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "絶対笑った！ あたし証人！ 店長も見ましたよね！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。見た。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが猫をそっと膝から下ろして、本を持ち上げて顔を隠した。", is_choice: false, choices: [] },
          { speaker: "", text: "……耳が赤い。今度は日差しのせいじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "猫が「にゃあ」と鳴いて、またどこかに行ってしまった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "猫に好かれるタイプなんだね、佐倉ちゃん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……猫は静かな人のところに来るだけ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ふうん。笑顔の人のところにも来ると思うけど。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……笑ってない。", is_choice: false, choices: [] },
        ],
        next_scene: "ch12_s4",
      },
      // --- Scene 4: 帰り道 ---
      // 前提: ピクニックが終わって帰路。
      //   場所: 公園 → 駅方面
      //   時間: 夕方
      //   知識: 天野と神崎は別方向。主人公と佐倉は同じ方向（カフェ近辺）。
      // 変化: 二人きりになる。佐倉が珍しく自分から話す（ぎこちなく）。
      //   「……今日は、別に、つまらなくはなかった」
      //   主人公「来てくれてよかった」。佐倉「……勝手に来ただけ」。
      //   神崎が別れ際に主人公にだけ聞こえるように「鈍いね」と言う。
      // 結果: 佐倉との距離が一段階近づいた。でも二人とも自覚なし。
      {
        id: "ch12_s4",
        lines: [
          { speaker: "", text: "夕方。片付けを終えて、帰路につく。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃ、あたしこっちっす。楽しかったっす！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "私もこっち。お疲れ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野と神崎さんが駅方面に向かう。", is_choice: false, choices: [] },
          { speaker: "", text: "残ったのは、俺と佐倉さん。カフェの方向は同じだ。", is_choice: false, choices: [] },
          { speaker: "", text: "並んで歩く。少し距離を空けて。", is_choice: false, choices: [] },
          { speaker: "", text: "……沈黙。でも、嫌な沈黙じゃない。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……今日は。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に、つまらなくはなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが前を向いたまま言った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そっか。来てくれてよかった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……勝手に来ただけ。誘われてない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "通りかかっただけ、だっけ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも、楽しかったなら良かった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……楽しかったとは言ってない。「つまらなくはなかった」。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はは。佐倉さんらしいな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……何それ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが少しだけ——本当に少しだけ——歩く速度を落とした。", is_choice: false, choices: [] },
          { speaker: "", text: "並んでいる距離が、さっきより近い。気づいてないのか、気づいて——", is_choice: false, choices: [] },
          { speaker: "", text: "……考えすぎか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……私はここ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、うん。じゃあまた明後日。定休日明けに。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に、行くとは——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いつも通りの時間に開けてるから。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが背を向けて歩き出した。", is_choice: false, choices: [] },
          { speaker: "", text: "三歩くらい行ったところで、小さく——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "カフェじゃないのに。何も出してないのに。", is_choice: false, choices: [] },
          { speaker: "", text: "……でも、なんか——嬉しかった。", is_choice: false, choices: [] },
          { speaker: "", text: "振り返ると、さっきの分かれ道に神崎さんがまだ立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "帰ったと思ったのに。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "忘れ物。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんが水筒を掲げて見せた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、すみません。ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ん。", is_choice: false, choices: [] },
          { speaker: "", text: "水筒を受け取る時、神崎さんが小さく言った。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……鈍いね、あんた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "何も。いいピクニックだった。また誘って。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんが手を振って去っていった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……鈍い？ 何がだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "夕日に照らされた帰り道を一人で歩く。", is_choice: false, choices: [] },
          { speaker: "", text: "風が吹いた。さっきの——佐倉さんの髪を揺らした風と同じ匂いがした。", is_choice: false, choices: [] },
          { speaker: "", text: "……また、少しだけ胸が跳ねた。", is_choice: false, choices: [] },
          { speaker: "", text: "カフェインのせいだ。たぶん。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
