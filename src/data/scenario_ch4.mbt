// ============================================================
// 第四章: Wi-Fiありますか
// ============================================================
//
// あらすじ:
//   フリーライターの神崎凛がWi-Fiとコンセントを求めてカフェに現れる。
//   ノートPCを広げ、ずっと居座る。鋭い観察眼で店の空気を読み取り、
//   佐倉と主人公の微妙な距離感に即座に気づく。「面白い店ね」。
//   3人目の常連が加わり、カフェに「場」の空気が生まれ始める。
//   佐倉の席が窓際からわずかにカウンター寄りに移動している。
//
// 登場キャラ: 神崎凛（新規）、佐倉美月、天野蓮
// キーイベント:
//   - 神崎凛の登場（Wi-Fi目当て。観察力が鋭い）
//   - 佐倉と主人公のやりとりを神崎が面白がる
//   - 3人の常連が揃い、カフェが「場」になる
//   - 佐倉の席がわずかにカウンター寄りに（本人は理由をつける）
//
// --- 章の状態差分 ---
// 開始状態: 佐倉は帰り際にわずかに立ち止まるようになった（ch3）。
//   天野がバイトとして定着。佐倉の豆で淹れたコーヒーが好評。
// 終了状態: 神崎凛が常連に加わり、3人の常連が揃った。カフェに「場」の空気。
//   主人公の変化: 常連が増えて嬉しい反面、佐倉の無反応は変わらず気になる
//   店の変化: Wi-Fi環境を整備。常連3人が定着し活気が出てきた
//   関係性: 神崎（観察者ポジション確立）、佐倉（席が少し近づいた）
// ============================================================

/// Chapter 4: Wi-Fiありますか
///
/// 背景: 承前半の入口。3人目の常連・神崎凛の登場で「観察する第三者」が加わり、
/// 佐倉と主人公の関係を客観視する視点が生まれる。
/// 佐倉の席移動（窓際→カウンター寄り）が始まるタイミング。
pub fn get_chapter_4() -> Chapter {
  {
    id: 4,
    title: "第四章",
    subtitle: "Wi-Fiありますか",
    unlock_revenue: 5000,
    unlock_recipes: 12,
    unlock_customers: 4,
    unlock_intimacy: 300,
    scenes: [
      // --- Scene 0: 新しい客 ---
      // 前提: 午後。佐倉がいつもの席（窓際だが、以前より1席カウンター寄り）で読書中。
      //   天野がカウンター内で作業。平和な午後。
      // 変化: 神崎凛が入店。第一声が「Wi-Fiありますか」。
      //   PCを広げて仕事を始める。コンセントの位置を確認する手際の良さ。
      // 結果: 新しいタイプの客が来た。佐倉とは違う「居座り方」
      {
        id: "ch4_s0",
        lines: [
          { speaker: "", text: "午後。いつもの静かな時間。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが文庫本を開いている。今日は窓際の端ではなく、ひとつカウンター寄りの席。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……あれ、いつもの席じゃないな)", is_choice: false, choices: [] },
          { speaker: "", text: "天野がカウンターの中でグラスを磨いている。鼻歌混じり。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが開いた。ショートカットの女性。革ジャンにデニム。小柄だが姿勢がいい。", is_choice: false, choices: [] },
          { speaker: "", text: "肩にメッセンジャーバッグ。リップだけが鮮やかな赤。", is_choice: false, choices: [] },
          { speaker: "", text: "店内をぐるっと見回して——コンセントの位置を確認している。一瞬で。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "Wi-Fiありますか。", is_choice: false, choices: [] },
          { speaker: "", text: "挨拶より先にそれだった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "えっと……あります、一応。パスワードはカウンターに——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "速度は？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……普通、だと思います。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "普通ね。まあいいわ。エスプレッソちょうだい。", is_choice: false, choices: [] },
          { speaker: "", text: "言うが早いか、壁際の席に座ってバッグからノートPCを取り出した。", is_choice: false, choices: [] },
          { speaker: "", text: "電源アダプタ。マウス。スマホスタンド。手慣れた動きで展開していく。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……なんか、仕事場みたいになってきたっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、使ってくれるのはありがたいよ。", is_choice: false, choices: [] },
          { speaker: "", text: "エスプレッソを淹れて持っていく。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんは受け取ると、片手でカップを持ち、もう片方はキーボードに置いたまま一口。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……悪くないね。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ言って、もう画面に集中している。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんといい勝負の無愛想さっすね。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本越しにちらりとこちらを見た。視線が合いそうになって、すぐ戻す。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……聞こえてるよ、天野。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "聞こえるように言ってるんすけど。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s1",
      },
      // --- Scene 1: 観察者の目 ---
      // 前提: 神崎が2時間ほど居座っている。佐倉も同じ時間帯にいる。
      //   主人公が佐倉にコーヒーのおかわりを持っていく場面を神崎が見ている。
      // 変化: 神崎が佐倉と主人公のやりとりを観察し、面白がり始める。
      //   「あの子、あんたのこと見てるじゃない」と主人公に言う。
      // 結果: 第三者の目を通して、佐倉と主人公の関係が読者に客観視される
      {
        id: "ch4_s1",
        lines: [
          { speaker: "", text: "2時間が経った。神崎さんはまだいる。エスプレッソは2杯目。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんもまだいる。文庫本は40ページほど進んでいる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さん、おかわりどうですか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……同じので。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ブレンドですね。今日はちょっと豆の挽き方変えてみたんですけど——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "——わかりますか、違い。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "普通か……。", is_choice: false, choices: [] },
          { speaker: "", text: "カップを持って戻る。毎日このやりとりをしている気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに戻ると、神崎さんがPCから顔を上げてにやにやしていた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ねえ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あの子、さっきからずっとあんたの方見てるの、気づいてる？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？ 佐倉さんが？ いや、本読んでますけど——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "本のページ、全然進んでないわよ。あんたがカウンターに戻ってから特にね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そんなことは——", is_choice: false, choices: [] },
          { speaker: "", text: "思わず佐倉さんの方を見る。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ほら、今ページめくるの速くなったでしょ。見られてるの気づいたのよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、それはたまたま——", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "鈍いわね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジっすか。あたしも思ってたんすよそれ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野まで——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いやだって、佐倉さん店長のこと——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……聞こえてる。", is_choice: false, choices: [] },
          { speaker: "", text: "低い声が店内に響いた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは文庫本で顔の下半分を隠している。耳が赤い。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……本が面白いだけ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "その本、30分前から同じページじゃない？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはコーヒーを一口飲んで読書に戻った。ただし、本を持つ手に力が入っている。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "面白い店ね。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはにやりと笑って、PCに視線を戻した。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s2",
      },
      // --- Scene 2: 三人の常連 ---
      // 前提: 神崎が通い始めて数日後。佐倉、天野、神崎が同時にいる夕方。
      //   店に「場」の空気が生まれつつある。
      // 変化: 天野が神崎に絡む。神崎が切り返す。佐倉が小さく笑う。
      //   主人公は「店が生きている」と感じる。
      // 結果: 3人の常連が揃い、カフェが「居場所」としての色を持ち始める
      {
        id: "ch4_s2",
        lines: [
          { speaker: "", text: "神崎さんが通い始めて、数日が経った。", is_choice: false, choices: [] },
          { speaker: "", text: "火曜と金曜は確実に来る。「締め切り前は毎日来るから覚悟しなさい」と宣言された。", is_choice: false, choices: [] },
          { speaker: "", text: "夕方。佐倉さんがいつもの席——窓際寄りだが、以前より確実にカウンターに近い——で読書。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんが壁際でPCを叩いている。天野がカウンター内で洗い物。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "神崎さんって何書いてるんすか？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "商店街の特集記事。「消えゆく個人商店の灯火」。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわ、暗っ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "暗いんじゃなくて、リアルなの。この商店街、10年で3割閉店してるのよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……マジっすか。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "マジよ。でもね、面白い店が新しく出てきてるの。こことかね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "面白いって、うちですか？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "コーヒーの腕はまだまだだけど、人が集まる空気があるじゃない？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まだまだって言われた……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あはは、バッサリっすね！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "褒めてるのよ、半分は。空気を作れる店は珍しいの。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "残り半分は？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "Wi-Fiが遅い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それはすみません……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、回線アップグレードしましょうよ！ あたしスマホで調べますよ！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ついでにコンセント増やして。あと、このテーブル低いのよね。PC置くと肩こるの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "要望多いな……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でもこの人いるとなんか店が賑やかになるっすよね！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "賑やかって。私、基本黙ってPC叩いてるだけよ？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "それがいいんすよ。佐倉さんは静かだし、神崎さんはキーボードがカタカタ言うし。BGMっすよBGM。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "BGM扱いは初めてだわ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本の向こうで、小さく口元を緩めた。", is_choice: false, choices: [] },
          { speaker: "", text: "声を出して笑うことはない。でも、確かに笑っていた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あ、佐倉ちゃん笑った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……笑ってない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いや今ぜったい笑ったっすよ！ あたし見た！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは文庫本を少し高く持ち上げて、顔を隠した。", is_choice: false, choices: [] },
          { speaker: "", text: "でも本の上から見える耳が、また赤くなっている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s3",
      },
      // --- Scene 3: 面白い店 ---
      // 前提: 同日の閉店間際。佐倉は帰った。神崎がまだ残っている。
      // 変化: 神崎が主人公に「あの子のこと気になってるでしょ」と直球。
      //   主人公は否定するが、神崎は見透かしている。
      //   「無反応に見えて、ちゃんと来てるのが答えじゃない？」
      // 結果: 神崎という「鏡」を通して、主人公が佐倉の行動の意味を考え始める
      {
        id: "ch4_s3",
        lines: [
          { speaker: "", text: "閉店間際。佐倉さんは「ごちそうさま」と言って帰った。いつも通り。", is_choice: false, choices: [] },
          { speaker: "", text: "天野はシフト上がりで先に帰った。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんだけが残っている。PCを閉じて、3杯目のエスプレッソを飲んでいる。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ねえ、ひとつ聞いていい？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんですか。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "あの子——佐倉ちゃん。毎日来てるんでしょ？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ええ、まあ。ほぼ毎日。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "何を出しても「普通」。でも毎日来る。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……はい。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "気にならない？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、正直、気にはなります。一度くらい何か感想くれてもいいのにって。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "そこじゃないのよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「普通」って言いながら毎日通う人間がいたら、それ自体が答えでしょ。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "本当にどうでもいい店には、そもそも来ないわよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それは……そうかもしれないですけど。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "まあ、あんたが鈍いのは見てて分かったからいいけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "鈍くないですよ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "鈍い人間は自覚がないものよ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "面白い店。また来るわ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはバッグを肩にかけて、さっさと出ていった。", is_choice: false, choices: [] },
          { speaker: "", text: "一人になった店内。カウンターを拭く。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが今日座っていた席を見る。窓際の端から、ひとつ分こちら寄り。", is_choice: false, choices: [] },
          { speaker: "", text: "いつから移動したんだろう。聞いたら「日当たり」とか言うんだろうな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……答え、か。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんの言葉が、妙に引っかかって離れなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
