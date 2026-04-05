// ============================================================
// 第十七章: 来ない日
// ============================================================
//
// あらすじ:
//   佐倉が来ない。1日目、2日目、3日目。
//   主人公は連絡先を知らないことに気づく。
//   天野「毎日会ってて連絡先知らないのウケる」。
//   4日目。佐倉が来る。「……用事があっただけ」。
//   主人公の安堵が顔に出る。佐倉がそれを見て、目を逸らす。
//   佐倉が何か言いかけて——「……なんでもない」。
//   感情が言葉になりかけて、まだなれない。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛
// キーイベント:
//   - 佐倉が3日間来ない
//   - 連絡先を知らないことに気づく
//   - 天野「毎日会ってて連絡先知らないのウケる」
//   - 4日目に佐倉が戻る
//   - 主人公の安堵が顔に出る→佐倉が見る
//   - 佐倉「……なんでもない」（感情が言葉になりかけている）
//
// --- 章の状態差分 ---
// 開始状態: ch16で主人公が佐倉を意識するようになった。
//   まだ「好き」を認められていないが、動揺は隠せない。
//   佐倉はカウンター席。いつもの日常——のはずだった。
// 終了状態: 佐倉が3日間来なかった。その不在が主人公に決定的な気づきをもたらした。
//   主人公の変化: 佐倉がいない日常に耐えられなかった。「好き」に近づいている。
//   店の変化: 佐倉がいない3日間、店の雰囲気がどこか欠けていた。
//   関係性: 佐倉（不在→戻ってきた。何か言いかけてやめた。距離が微妙に変わった）
//           天野（主人公の動揺を見て、核心を突く）
//           神崎（状況を把握。あえて何も言わない）
//   佐倉の席: カウンター席（戻ってきた時も同じ席。窓際に戻ってはいない→まだ距離は
//   完全には離れていない。だがch18以降で窓際に戻る可能性を示唆）
// ============================================================

/// Chapter 17: 来ない日
///
/// 背景: 転パートの核心。「いつもいる人がいない」ことで、
/// 存在の大きさを思い知る古典的だが普遍的な構造。
/// 設計書の「言葉×距離」マトリクスでは、転パートで佐倉は「離れる」。
/// この章はその始まり——物理的に来ないことで距離が生まれる。
/// 佐倉の「……なんでもない」は設計書の重要ポイント:
/// 「感情が言葉になりかけている」状態を表す。
pub fn get_chapter_17() -> Chapter {
  {
    id: 17,
    title: "第十七章",
    subtitle: "来ない日",
    unlock_revenue: 38000,
    unlock_recipes: 38,
    unlock_customers: 13,
    unlock_intimacy: 3400,
    scenes: [
      // --- Scene 0: 1日目 ---
      // 前提: ch16の翌日。主人公はまだ動揺を引きずっている。
      //   場所: 月灯り（午後・営業中）
      //   時間: 午後
      //   知識: 佐倉はほぼ毎日来る。雨でも来る。
      //   来なかった日は——思い出せないくらい、ない。
      // 変化: 午後になっても佐倉が来ない。
      //   主人公は気にしないふりをするが、何度もドアを見てしまう。
      //   天野が気づく。「佐倉さん、今日来ないすね」。
      //   閉店まで来なかった。
      // 結果: 佐倉が1日休んだ。気になるが、そういう日もある。
      {
        id: "ch17_s0",
        lines: [
          { speaker: "", text: "午後。いつもの時間。佐倉さんの席は空いている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まだ来ないか。遅いだけかもな。", is_choice: false, choices: [] },
          { speaker: "", text: "3時。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……まだ。)", is_choice: false, choices: [] },
          { speaker: "", text: "4時。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……まだ。)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん、今日来ないすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、そういう日もあるだろ。毎日来なきゃいけないわけじゃないし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "そうっすけど。なんか珍しくないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "別に。佐倉さんだって用事くらいあるよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "まあ、そうっすね。……店長、さっきからあの席チラチラ見すぎっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "見てない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "見てたっす。", is_choice: false, choices: [] },
          { speaker: "", text: "5時。閉店。来なかった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……明日は来るだろ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch17_s1",
      },
      // --- Scene 1: 2日目・3日目 ---
      // 前提: 佐倉が来なくて2日目、3日目。
      //   場所: 月灯り（午後・営業中）→主人公の部屋
      //   時間: 午後〜夜
      //   知識: 佐倉の連絡先を知らない。住所はch14で分かったが押しかけるのは違う。
      //   佐倉がこんなに来なかったことは初めて。
      // 変化: 2日目も来ない。3日目も。
      //   主人公の焦りが増す。天野に「連絡先知らないの？」と聞かれる。
      //   知らない。毎日会ってるのに。天野「マジで？」。
      //   夜、自分の部屋で天井を見ている。
      //   佐倉がいない店は——何かが足りない。
      // 結果: 3日間の不在。主人公は佐倉の存在の大きさを痛感している。
      {
        id: "ch17_s1",
        lines: [
          { speaker: "", text: "2日目。午後。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……長い。なんでこんなに長いんだ、午後って)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(カウンターの、あの席だけがずっと空いてる)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長。もしかして連絡してみたら？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……連絡先、知らないんだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……え。マジすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "マジ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "毎日会ってて連絡先知らないのウケるんすけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……笑うなよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いや、笑うっすよ。半年近く毎日顔合わせてて、LINE一つ交換してないとか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……聞くタイミングが、なかった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "タイミング山ほどあったと思うんすけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんか、聞いたら関係が変わる気がして。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長、それ結構大事なこと言ってるって気づいてます？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うるさいな。", is_choice: false, choices: [] },
          { speaker: "", text: "——3日目。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……まだ来ないの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……みたいですね。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……ふうん。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ。神崎さんはPCに目を戻した。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店後。家。天井を見ている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……何してんだろ。佐倉さん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "風邪？ 忙しい？ それとも——もう来ない？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……「もう来ない」。", is_choice: false, choices: [] },
          { speaker: "", text: "その可能性を考えた瞬間、胃の底が冷たくなった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんであんなに毎日来てたんだろ。あの人。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "コーヒーは「普通」。居心地がいいとも言わない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なのに毎日来て、カウンターに座って、本を読んで、「ごちそうさま」って言って帰る。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それが、なくなったら——嫌だ。はっきりと。", is_choice: false, choices: [] },
        ],
        next_scene: "ch17_s2",
      },
      // --- Scene 2: 4日目——戻ってきた ---
      // 前提: 4日目の午後。主人公は期待しないようにしている。
      //   場所: 月灯り（午後・営業中）
      //   時間: 午後
      //   知識: 3日間来なかった。理由は分からない。
      //   主人公は佐倉がいない日常の辛さを知った。
      // 変化: ドアが開く。佐倉が来た。いつも通りの姿で。
      //   主人公の安堵が——顔に出てしまう。
      //   佐倉がそれを見る。一瞬、目が合う。
      //   「……用事があっただけ」。
      //   いつものカウンター席に座る。いつもの注文。
      //   ——でも何かが、少しだけ違う。
      // 結果: 佐倉が戻ってきた。主人公の安堵が伝わった。
      {
        id: "ch17_s2",
        lines: [
          { speaker: "", text: "4日目。午後。カウンターを拭いている。もう何回拭いたか分からない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(期待するな。来ないかもしれない)", is_choice: false, choices: [] },
          { speaker: "", text: "——カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪。白いブラウス。文庫本。——佐倉さんだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……っ。", is_choice: false, choices: [] },
          { speaker: "", text: "声が出なかった。代わりに、全部顔に出た。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、こっちを見ている。目が合った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……用事があっただけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、うん。そうだよな。4日も——いや、別に数えてないけど。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……数えてるじゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "べ、別に。心配とかしてないから。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……誰も心配してるなんて言ってない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……はい。コーヒー、淹れる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカウンター席に座った。いつもの場所。窓際には行かなかった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(本のページ、進んでる。……家で読んでたんだ。ちゃんと暮らしてたんだ)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが一口飲む。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……手、震えてない。佐倉さんがいるだけで、こんなに違う)", is_choice: false, choices: [] },
        ],
        next_scene: "ch17_s3",
      },
      // --- Scene 3: 天野の一言 ---
      // 前提: 佐倉が戻ってきた午後。天野が出勤。
      //   場所: 月灯り（午後・営業中）
      //   時間: 午後（Scene 2の少し後）
      //   知識: 天野は佐倉が3日休んだことと、主人公の動揺を知っている。
      //   佐倉が戻ってきたことにも気づく。
      // 変化: 天野が佐倉に「お久しぶりっす」。佐倉は素っ気ない。
      //   天野が主人公に小声で「よかったすね」。
      //   主人公「別に」。天野「はいはい」。
      //   天野は心の中で思う——二人とも、不器用すぎる。
      // 結果: 日常が戻った。でも以前と全く同じではない。
      {
        id: "ch17_s3",
        lines: [
          { speaker: "", text: "天野が来た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、佐倉さん！ お久しぶりっす！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……3日だけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "3日でも久しぶりっすよ。毎日来るのがデフォなんで。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別にデフォじゃない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いやいや、デフォっすよ。佐倉さんが来ない月灯りとか、クリープのないコーヒーっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "古いな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え、何がっすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、なんでもない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "古いっすか？ あたしの語彙に文句つけないでほしいんすけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ごめん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "(……店長。よかったすね)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……別に。)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "(はいはい。その顔で「別に」は無理あるっすよ)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "(にやにや)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……やめろその顔。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "何もしてないっすよ？", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんのページをめくる速度が、いつもより遅い。考え事をしているのか。", is_choice: false, choices: [] },
        ],
        next_scene: "ch17_s4",
      },
      // --- Scene 4: ……なんでもない ---
      // 前提: 閉店間際。佐倉がまだいる。
      //   場所: 月灯り（閉店間際）
      //   時間: 夕方
      //   知識: 佐倉はいつもより長く居座っている。
      //   天野は片付けを始めている。
      //   この章の核心:「感情が言葉になりかけて、まだなれない」。
      // 変化: 佐倉が本を閉じる。カップを置く。
      //   いつもの「ごちそうさま」——の前に、何かを言いかける。
      //   口を開いて、閉じる。もう一度開いて——
      //   「……なんでもない」。
      //   主人公はそれを見ている。聞きたい。でも聞けない。
      //   佐倉が帰る。ドアが閉まる。
      //   主人公は一人、空いた席を見つめている。
      // 結果: 佐倉の感情が言葉の手前まで来た。まだ出てこない。
      //   二人の距離は——近いのか遠いのか、分からなくなっている。
      {
        id: "ch17_s4",
        lines: [
          { speaker: "主人公", text: "(閉店間際なのにまだいる。今日はいつもより長いな。3日分を取り戻すみたいに)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃ、あたし先上がるっす。お疲れっした。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おう。お疲れ。", is_choice: false, choices: [] },
          { speaker: "", text: "二人になった。佐倉さんが本を閉じた。カップは空。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそう——", is_choice: false, choices: [] },
          { speaker: "", text: "言いかけて、止まった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……佐倉さん？", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカウンター越しに、こっちを見ている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(いつもの無表情じゃない。何か……揺れてる)", is_choice: false, choices: [] },
          { speaker: "", text: "口を開きかけた。閉じた。もう一度——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(言葉が出てこないんだ。喉の手前で止まってる。そういう顔してる)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……何？", is_choice: false, choices: [] },
          { speaker: "", text: "聞いた。声が思ったより小さかった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが——目を伏せた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なんでもない。", is_choice: false, choices: [] },
          { speaker: "", text: "……なんでもない。", is_choice: false, choices: [] },
          { speaker: "", text: "その言葉が、いつもと同じで——いつもと全然違った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "鞄を肩にかけて、席を立った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……佐倉さん。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが足を止めた。振り向かない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……また明日。", is_choice: false, choices: [] },
          { speaker: "", text: "小さく。でもはっきりと。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。ドアが閉まった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……「うん」って言った。初めてだ。「また明日」に返事が返ってきたの。", is_choice: false, choices: [] },
          { speaker: "", text: "空のカップ。閉じた文庫本。誰もいなくなったカウンター席。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……さっき何言いかけたんだろ。佐倉さん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……聞きたかった。それだけが、確かだ。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
