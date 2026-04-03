// ============================================================
// 第三章: 名前をつけること
// ============================================================
//
// あらすじ:
//   名前のないメニューを出し続ける主人公。
//   地元紙の記者・神崎凛が商店街の特集取材で訪れる。
//   鋭い目と率直な物言いで、店の「面白さ」を見抜く。
//   「名前のない良いものは、誰にも見つけてもらえない」——その言葉が刺さる。
//   天野が神崎に絡み、佐倉が小さく笑う。店の「空気」が少しずつ変わっている。
//   宮内が二度目の来店。前回より少しだけ長く居る。
//
// 登場キャラ: 神崎凛（新規）、佐倉美月、天野蓮、宮内孝之
// キーイベント:
//   - 神崎凛の登場（鋭い記者の目、率直な物言い）
//   - 「名前をつけなさい」——店のアイデンティティへの問いかけ
//   - キャラクター間の関係線が生まれ始める（天野↔神崎、佐倉の反応）
//   - 宮内の二度目の来店（関係の反復接触）
//
// Want vs. Need:
//   神崎: Want=いい記事のネタ / Need=自分の仕事にもう一度誇りを持つこと
// ============================================================

/// Chapter 3: 名前をつけること
pub fn get_chapter_3() -> Chapter {
  {
    id: 3,
    title: "第三章",
    subtitle: "名前をつけること",
    unlock_revenue: 3000,
    unlock_recipes: 10,
    unlock_customers: 3,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 1: 神崎凛の取材 ---
      {
        id: "ch3_s1",
        lines: [
          { speaker: "", text: "昼下がり。珍しく、日差しが強い。", is_choice: false, choices: [] },
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
          { speaker: "主人公", text: "最近作った新しいのがあるんですけど……まだ名前がなくて。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "名前がないメニュー？ ……面白いじゃない。それちょうだい。", is_choice: false, choices: [] },
          { speaker: "", text: "りんごとシナモンの紅茶を淹れる。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはカップを受け取ると、まず香りを確かめた。", is_choice: false, choices: [] },
          { speaker: "", text: "それからゆっくり一口。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "へえ……。", is_choice: false, choices: [] },
          { speaker: "", text: "手帳に何か書き込んでいる。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "冒険するタイプね。嫌いじゃないわ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s2",
      },
      // --- Scene 2: 店の「空気」 ---
      {
        id: "ch3_s2",
        lines: [
          { speaker: "天野蓮", text: "あ、記者さんっすか？ この店めっちゃいいっすよ！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "常連さん？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "常連……っすかね。まだ数週間だけど。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "数週間で常連面できる店って、それだけで良い店の証拠よ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんが嬉しそうに笑う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ココアがマジでうまいんすよ。あと店長の人柄っすね。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "人柄、ね。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはこちらを見た。値踏みするような、でも嫌味のない目。", is_choice: false, choices: [] },
          { speaker: "", text: "窓際で、佐倉さんが本越しにこちらを見た。", is_choice: false, choices: [] },
          { speaker: "", text: "……少しだけ、口元が緩んでいた。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんが褒められて嬉しいのか、佐倉さんが笑ったのか。", is_choice: false, choices: [] },
          { speaker: "", text: "どちらにせよ、この店の空気が変わりつつあることを感じた。", is_choice: false, choices: [] },
          { speaker: "", text: "一人だった店が、少しずつ「みんなの場所」になっている。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんは手帳にまた何か書いてから、立ち上がった。", is_choice: false, choices: [] },
          { speaker: "", text: "帰り際、ドアの前で振り返った。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "名前、ちゃんとつけなさいよ。メニューに。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "名前のない良いものは、誰にも見つけてもらえないから。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルが鳴って、彼女は午後の日差しの中に消えた。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに、りんごの甘い香りだけが残っている。", is_choice: false, choices: [] },
          { speaker: "", text: "名前のないメニュー。", is_choice: false, choices: [] },
          { speaker: "", text: "……考えてみよう。この一杯にふさわしい名前を。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s3",
      },
      // --- Scene 3: 宮内の二度目 ---
      {
        id: "ch3_s3",
        lines: [
          { speaker: "", text: "次の土曜日。朝。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんが来た。先週と同じ時間に。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ほうじ茶を。", is_choice: false, choices: [] },
          { speaker: "", text: "先週と同じ注文。同じ席。", is_choice: false, choices: [] },
          { speaker: "", text: "でも今日は、少しだけ表情が柔らかい気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "ほうじ茶を淹れる。前回よりほんの少しだけ温度を下げてみた。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは一口飲んで、わずかに頷いた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "先週より、いい。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ。でも、嬉しかった。", is_choice: false, choices: [] },
          { speaker: "", text: "しばらく沈黙が続く。宮内さんは窓の外を見ている。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……新しいメニューを作っているそうだな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え、どこで……。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "商店街は狭い。噂は早いよ。", is_choice: false, choices: [] },
          { speaker: "", text: "少しだけ、口元が緩んだ。笑った……のかもしれない。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "前のオーナーも、よく新しいものを試していた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "失敗作を飲まされたことも、一度や二度じゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんの声が、少しだけ温かくなった。", is_choice: false, choices: [] },
          { speaker: "", text: "「前のオーナー」の話をする時だけ、この人は別の顔を見せる。", is_choice: false, choices: [] },
          { speaker: "", text: "聞きたいことは、たくさんあった。", is_choice: false, choices: [] },
          { speaker: "", text: "でも——今はまだ、聞かない方がいい気がした。", is_choice: false, choices: [] },
          { speaker: "", text: "この人が自分から話してくれるのを、待とう。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんはほうじ茶を飲み干し、代金を置いて立ち上がった。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "来週も、来る。", is_choice: false, choices: [] },
          { speaker: "", text: "「また来る」ではなく、「来週も」。", is_choice: false, choices: [] },
          { speaker: "", text: "小さな違いだけど、確かに距離が縮まった気がした。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
