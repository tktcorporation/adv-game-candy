// ============================================================
// 第二章: 名前のないメニュー
// ============================================================
//
// あらすじ:
//   レシピの研究を重ね、新しいメニューを生み出し始める主人公。
//   メニューに名前をつけることは、この店を自分のものにしていくこと。
//   地元紙の記者・神崎凛が取材で訪れ、鋭い視点で店の「面白さ」を見抜く。
//   棚の奥にレシピノートらしき古いノートの背表紙がちらりと見える。
//
// 登場キャラ: 神崎凛（新規）、佐倉美月、天野蓮
// キーイベント:
//   - 新メニュー開発の楽しさ
//   - 神崎凛の登場（鋭い記者の目）
//   - 棚の奥にノートの背表紙（三度触れ #1: レシピノート — 匂わせ）
// ============================================================

/// Chapter 2: 名前のないメニュー
pub fn get_chapter_2() -> Chapter {
  {
    id: 2,
    title: "第二章",
    subtitle: "名前のないメニュー",
    unlock_revenue: 1000,
    unlock_recipes: 5,
    unlock_customers: 2,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 1: レシピ研究 ---
      {
        id: "ch2_s1",
        lines: [
          { speaker: "", text: "閉店後。カウンターの上に、材料が並んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "りんご。シナモンスティック。はちみつ。紅茶の茶葉。", is_choice: false, choices: [] },
          { speaker: "", text: "組み合わせを試す夜が、日課になりつつあった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "りんごとシナモンで……これはいけるかも。", is_choice: false, choices: [] },
          { speaker: "", text: "りんごを薄くスライスして、シナモンと一緒に紅茶に浮かべる。", is_choice: false, choices: [] },
          { speaker: "", text: "甘い香りが、夜の店内にふわりと広がった。", is_choice: false, choices: [] },
          { speaker: "", text: "一口飲む。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……悪くない。いや、結構いい。", is_choice: false, choices: [] },
          { speaker: "", text: "ノートに書き留める。配分。温度。蒸らし時間。", is_choice: false, choices: [] },
          { speaker: "", text: "……名前は、まだない。", is_choice: false, choices: [] },
          { speaker: "", text: "メニューに名前をつける。", is_choice: false, choices: [] },
          { speaker: "", text: "それは、この店を自分のものにしていくということだ。", is_choice: false, choices: [] },
          { speaker: "", text: "棚から材料を戻そうとした時、奥の方に何か見えた。", is_choice: false, choices: [] },
          { speaker: "", text: "古びたノートの背表紙。茶色い革の、手帳のようなもの。", is_choice: false, choices: [] },
          { speaker: "", text: "手を伸ばしかけて——やめた。", is_choice: false, choices: [] },
          { speaker: "", text: "今日はもう遅い。片付けよう。", is_choice: false, choices: [] },
          { speaker: "", text: "店の明かりを消す。窓の外に、三日月が見えた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s2",
      },
      // --- Scene 2: 神崎凛の取材 ---
      {
        id: "ch2_s2",
        lines: [
          { speaker: "", text: "翌日の昼下がり。珍しく、日差しが強い。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんがアイスココアを飲みながら、課題のレポートを広げている。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルが鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "ショートカットの女性が入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "カメラバッグを肩にかけ、手帳を片手に持っている。", is_choice: false, choices: [] },
          { speaker: "", text: "入った瞬間、店内を素早く見回した。観察するような目。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "地元紙の神崎です。商店街の特集を書いていて。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "少しお話聞かせてもらえます？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うちなんかで良ければ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「なんか」って言わない方がいいわよ。", is_choice: false, choices: [] },
          { speaker: "", text: "ストレートだった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "閉まってた店がまた開く。それだけで記事になるの。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……で、何か飲ませてもらえる？ おすすめで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "昨日作った新しいのがあるんですけど……まだ名前がなくて。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "名前がないメニュー？ ……面白いじゃない。それちょうだい。", is_choice: false, choices: [] },
          { speaker: "", text: "りんごとシナモンの紅茶を淹れる。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはカップを受け取ると、まず香りを確かめた。", is_choice: false, choices: [] },
          { speaker: "", text: "それからゆっくり一口。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "へえ……。", is_choice: false, choices: [] },
          { speaker: "", text: "手帳に何か書き込んでいる。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "冒険するタイプね。嫌いじゃないわ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、記者さんっすか？ この店めっちゃいいっすよ！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "常連さん？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "常連……っすかね。まだ数日だけど。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "数日で常連面できる店って、それだけで良い店の証拠よ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはそう言って、手帳にまた何か書いた。", is_choice: false, choices: [] },
          { speaker: "", text: "帰り際、彼女はドアの前で振り返った。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "名前、ちゃんとつけなさいよ。メニューに。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "名前のない良いものは、誰にも見つけてもらえないから。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルが鳴って、彼女は午後の日差しの中に消えた。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに、りんごの甘い香りだけが残っている。", is_choice: false, choices: [] },
          { speaker: "", text: "名前のないメニュー。", is_choice: false, choices: [] },
          { speaker: "", text: "……考えてみよう。この一杯にふさわしい名前を。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
