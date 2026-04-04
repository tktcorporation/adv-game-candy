// ============================================================
// 第十九章: 天野の説教
// ============================================================
//
// あらすじ:
//   閉店後。天野が主人公に詰め寄る。
//   「佐倉さんに何かしたでしょ。ていうか何もしなかったでしょ。
//    それが一番ダメなんだよ」
//   神崎も「桐谷さんとのこと、ちゃんと説明しな」と背中を押す。
//   主人公は初めて、コーヒーを淹れる人としてではなく、
//   自分自身として佐倉に向き合う必要があると気づく。
//   天野「店長、たまにはちゃんとしてよ」。
//
// 登場キャラ: 天野蓮、神崎凛
// キーイベント:
//   - 天野の説教（「何もしないのが一番ダメ」）
//   - 神崎の助言（「説明しな」）
//   - 主人公の自覚（コーヒーの腕じゃなく、自分自身の問題）
//   - 行動する決意
//
// --- 章の状態差分 ---
// 開始状態: ch18で佐倉が窓際に戻った。距離が離れた。
//   主人公は原因が分からず困惑している。
//   天野と神崎は状況を理解している。
// 終了状態: 主人公が「自分から動く」と決意した。
//   主人公の変化: 受動的→能動的。コーヒーの技術ではなく自分自身で向き合う覚悟
//   店の変化: なし
//   関係性: 天野（主人公の背中を押した。後輩だが核心を突く）
//           神崎（具体的なアドバイスを与えた。「説明」が鍵）
//           佐倉（この章では不在。だからこそ存在感がある）
// ============================================================

/// Chapter 19: 天野の説教
///
/// 背景: 転パートの最後。ch20のクライマックスに向けた助走。
/// 天野がコメディ担当からシリアスに切り替わる瞬間——
/// 「たまに真面目な顔をすると周囲が驚く」設定の回収。
/// 佐倉が不在のこの章で、読者は佐倉の不在そのものを感じる。
/// 主人公が「コーヒーの人」から「一人の人間」に踏み出す転換点。
pub fn get_chapter_19() -> Chapter {
  {
    id: 19,
    title: "第十九章",
    subtitle: "天野の説教",
    unlock_revenue: 38000,
    unlock_recipes: 44,
    unlock_customers: 8,
    unlock_intimacy: 3600,
    scenes: [
      // --- Scene 0: 空のカウンター ---
      // 前提: ch18の翌日以降。数日が経過。佐倉は毎日来ているが、
      //   窓際席で、本を開いて、ページをめくらないで、早く帰る。
      //   距離が戻ったまま。
      //   今日も同じパターンだった。閉店作業中。
      // 変化: 佐倉が座らなくなったカウンター席の描写。主人公の焦り。
      // 結果: 天野が何か言いたそうにしている
      {
        id: "ch19_s0",
        lines: [
          { speaker: "", text: "閉店。", is_choice: false, choices: [] },
          { speaker: "", text: "テーブルを拭く。椅子を戻す。カップを洗う。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの閉店作業。", is_choice: false, choices: [] },
          { speaker: "", text: "——カウンターの端の席が、空いている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが座っていた席。ここ数日、誰も座らない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは来ている。毎日来ている。", is_choice: false, choices: [] },
          { speaker: "", text: "でも窓際に座って、本を開いて、ページをめくらないで、30分で帰る。", is_choice: false, choices: [] },
          { speaker: "", text: "「ごちそうさま」の声が小さくなった。", is_choice: false, choices: [] },
          { speaker: "", text: "目が合わなくなった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの木目をぼんやり見つめる。", is_choice: false, choices: [] },
          { speaker: "", text: "ここに座っていた時の佐倉さんは、たまにカップの縁を指先でなぞっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "何か考え事をしている時の癖。", is_choice: false, choices: [] },
          { speaker: "", text: "その仕草が好きだった——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "今、自分は何を考えた？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ちょっと、話あるんすけど。", is_choice: false, choices: [] },
          { speaker: "", text: "天野の声が、いつもと違った。", is_choice: false, choices: [] },
          { speaker: "", text: "「っす」の語尾は同じなのに、テンポが遅い。", is_choice: false, choices: [] },
        ],
        next_scene: "ch19_s1",
      },
      // --- Scene 1: 「何もしなかったでしょ」 ---
      // 前提: 閉店後の店内。天野と主人公の二人。
      //   天野は数日間ずっと我慢していた。
      //   主人公に直接言うべきか迷っていたが、もう限界。
      // 変化: 天野の説教。核心を突く。
      //   「何かした」のではなく「何もしなかった」のが問題だと指摘。
      //   佐倉のことを一番近くで見てきた天野だからこそ言える言葉。
      // 結果: 主人公が「何もしなかった」ことの意味を突きつけられる
      {
        id: "ch19_s1",
        lines: [
          { speaker: "天野蓮", text: "……佐倉さんのこと。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ここ数日、見てたっすよね。店長も。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "見てた。窓際に戻って、早く帰って——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "で、どうするんすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうするって言われても。原因が分からないと——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "分かるっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、佐倉さんに何かしたでしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "してないって。何も——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "そう。何もしてない。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がこっちを向いた。", is_choice: false, choices: [] },
          { speaker: "", text: "——真面目な顔だった。見たことないくらい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "何もしなかったでしょ。それが一番ダメなんだよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん、ずっと待ってたんすよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "カウンターに座って。近くにいて。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの人なりに、めちゃくちゃ頑張って近づいてきたのに。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、何もしなかったじゃん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何もって——俺は、コーヒーを——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "コーヒーの話じゃないっす。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "天野の声が、少し震えていた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしはバイトだから。佐倉さんのことも、店長のことも、毎日見てるんすよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんが最初窓際にいて、だんだんカウンターに来て。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "「普通」しか言わないのに毎日来て。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの人がどんだけ——", is_choice: false, choices: [] },
          { speaker: "", text: "天野が言葉を切った。少し息を吸って、続ける。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……で、桐谷さんと駅前にいるとこ見られて、説明もしないって——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "それ、佐倉さんにとっちゃ「どうでもいい」って言われたのと同じっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "——。", is_choice: false, choices: [] },
          { speaker: "", text: "声が出なかった。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんと駅前にいるところを——見られた？", is_choice: false, choices: [] },
          { speaker: "", text: "あの日。佐倉さんが変わった日の、前日。", is_choice: false, choices: [] },
          { speaker: "", text: "……つながった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch19_s2",
      },
      // --- Scene 2: 神崎の一押し ---
      // 前提: 天野の説教の直後。主人公が動揺している。
      //   そこに神崎が来る（原稿の締切で遅くまで残っていた、
      //   あるいは閉店後に来た——店の鍵は天野が持っている）。
      // 知識: 神崎はch18で「こじれたね」と言った人。全体像が見えている。
      // 変化: 神崎が具体的なアドバイスをする。
      //   感情論ではなく事実の整理。「桐谷さんとのこと、説明すればいいだけ」。
      //   でもそれだけじゃ足りないことも示唆する。
      // 結果: 主人公に具体的な行動指針が与えられる
      {
        id: "ch19_s2",
        lines: [
          { speaker: "神崎凛", text: "おーおー、天野ちゃんがマジの顔してんの珍しいね。", is_choice: false, choices: [] },
          { speaker: "", text: "振り向くと、入口に神崎さんが立っていた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "神崎さん……聞いてたんすか。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "途中から。でもまあ、だいたい知ってたけどね。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがカウンターの前に来て、腕を組んだ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あんたさ。桐谷さんとのこと、ちゃんと説明しな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "説明って——仕事の相談を受けただけだって？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "そう。それを言えばいい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……でも、なんで俺がわざわざ——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「わざわざ」？", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんの目が、少し鋭くなった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あんた、まだそこにいるの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……え？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「なんで俺が」じゃないでしょ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あんた、佐倉ちゃんがカウンターに座らなくなって、困ってるんでしょ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "30分で帰られて、寂しいんでしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "コーヒーの淹れ方で解決する問題じゃないよ、これは。", is_choice: false, choices: [] },
          { speaker: "", text: "……分かってる。分かってるんだ、たぶん。", is_choice: false, choices: [] },
          { speaker: "", text: "ずっと、コーヒーの腕を上げれば何かが変わると思っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんに「美味しい」と言ってもらえれば——", is_choice: false, choices: [] },
          { speaker: "", text: "でも本当は、それだけじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーの向こう側に、自分がいなかった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……あんたは真面目だから、「カフェの店長として」佐倉ちゃんに向き合ってたんだよね。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "でもさ、佐倉ちゃんが見てたのは、たぶんコーヒーじゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "カウンターの向こうで、必死にコーヒー淹れてるあんたの顔。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "それを見に来てたんだと思うよ。あの子は。", is_choice: false, choices: [] },
        ],
        next_scene: "ch19_s3",
      },
      // --- Scene 3: 決意 ---
      // 前提: 天野の説教と神崎の助言を受けた後。
      //   主人公がようやく自分の気持ちに向き合う。
      // 変化: 主人公が動くことを決める。
      //   何を言うかは決まっていない。でも「何もしない」はもうやめる。
      //   天野の最後の一言が背中を押す。
      // 結果: ch20への導線。主人公が能動的に佐倉に向き合う準備。
      {
        id: "ch19_s3",
        lines: [
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "沈黙が落ちた。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店後のカフェ。ダウンライトだけが灯っている。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの端の、誰も座っていない席。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……俺は。", is_choice: false, choices: [] },
          { speaker: "", text: "声が出た。自分でも思ったより小さい声だった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんに——ちゃんと言わなきゃいけないことがある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "桐谷さんとのことは、説明する。それは当然として。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも——それだけじゃなくて。", is_choice: false, choices: [] },
          { speaker: "", text: "言葉を探す。", is_choice: false, choices: [] },
          { speaker: "", text: "うまく言えない。何を言えばいいのか、まだ分からない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、分かっていることがひとつある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……あの席に、戻ってきてほしい。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの端を見る。佐倉さんがいつも座っていた席。", is_choice: false, choices: [] },
          { speaker: "", text: "——そこに佐倉さんがいないのが、こんなに嫌だったのか。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……それを、あたしらじゃなくて本人に言いな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……分かってる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が、何か言いたそうにしていた。", is_choice: false, choices: [] },
          { speaker: "", text: "少し迷って、それから——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "たまにはちゃんとしてよ。", is_choice: false, choices: [] },
          { speaker: "", text: "——いつもの口調だった。「っす」が消えている。素の声。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ああ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "よし、じゃああたしは帰る。明日、がんばんなよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしも帰るっす。……明日のシフト、早めに来ますから。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ありがとう。二人とも。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "礼はいいっすから、ちゃんとやってください。マジで。", is_choice: false, choices: [] },
          { speaker: "", text: "二人が帰って、一人になった。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店後のカフェ。静かだ。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの端の席に手を置いた。", is_choice: false, choices: [] },
          { speaker: "", text: "木の温度はもう冷えている。佐倉さんがいた温度は、とっくに消えている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……明日。", is_choice: false, choices: [] },
          { speaker: "", text: "明日、佐倉さんが来たら——", is_choice: false, choices: [] },
          { speaker: "", text: "何を言うか、まだ決まっていない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、「何もしない」は、もうやめる。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
