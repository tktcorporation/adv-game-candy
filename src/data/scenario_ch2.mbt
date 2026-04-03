// ============================================================
// 第二章: 名前のないメニュー
// ============================================================
//
// あらすじ:
//   レシピの研究を重ね、新しいメニューを生み出し始める主人公。
//   棚の奥にレシピノートらしき古いノートの背表紙がちらりと見える。
//   ある週末の朝、古書店「栞堂」の店主・宮内孝之が初めて来店する。
//   「前の人」を知っているらしい宮内の佇まいに、主人公は何かを感じる。
//   宮内は多くを語らず、ほうじ茶だけ飲んで帰る。でもまた来ると言った。
//
// 登場キャラ: 宮内孝之（新規）、佐倉美月、天野蓮
// キーイベント:
//   - 新メニュー開発の楽しさ（メニューに名前をつける = 店を自分のものにする）
//   - 棚の奥にノートの背表紙（三度触れ #1: レシピノート — 匂わせ）
//   - 宮内孝之の登場（「前の人」への接続線。確かめに来ている）
//   - 宮内の「悪くない場所だ」（佐倉の「悪くない」と対になる表現）
//
// Want vs. Need:
//   宮内: Want=旧友の店が大切にされているか確かめたい
//         Need=旧友との未完の関係に折り合いをつけること
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
      // --- Scene 2: 宮内孝之の来店 ---
      {
        id: "ch2_s2",
        lines: [
          { speaker: "", text: "翌週の土曜日。朝一番の客だった。", is_choice: false, choices: [] },
          { speaker: "", text: "開店してすぐ、ドアベルが鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "白髪交じりの短髪をきちんと整えた男性。丸い銀縁眼鏡をかけている。", is_choice: false, choices: [] },
          { speaker: "", text: "紺色のカーディガンにシャツ、スラックス。背筋がまっすぐで、座っていなくても姿勢の良さが分かる。", is_choice: false, choices: [] },
          { speaker: "", text: "指が長い。古い本を扱い慣れた手——そんな印象を受けた。", is_choice: false, choices: [] },
          { speaker: "", text: "店内に入ると、ゆっくりと見回した。", is_choice: false, choices: [] },
          { speaker: "", text: "壁。天井。カウンター。エスプレッソマシン。", is_choice: false, choices: [] },
          { speaker: "", text: "目が鋭い。でも口元には深い皺が刻まれていて、かつてよく笑っていた顔だと分かった。", is_choice: false, choices: [] },
          { speaker: "", text: "初めて来た客の視線ではなかった。何かを確かめるような目だ。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……ほう。", is_choice: false, choices: [] },
          { speaker: "", text: "一言だけ漏らして、カウンターの端に腰かけた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いらっしゃいませ。何にしましょう。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ほうじ茶はあるかね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい、ありますよ。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……前は、なかったんだがな。", is_choice: false, choices: [] },
          { speaker: "", text: "「前は」。", is_choice: false, choices: [] },
          { speaker: "", text: "その言葉が引っかかった。この人は、以前のこの店を知っている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……前のお店に、来られていたんですか。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "隣で古書店をやっている。宮内だ。", is_choice: false, choices: [] },
          { speaker: "", text: "古書店「栞堂」。通りの角にある、あの小さな店。", is_choice: false, choices: [] },
          { speaker: "", text: "看板は見たことがあった。でも、店主と話すのは初めてだ。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ここの前のオーナーとは……長い付き合いでね。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ言って、宮内さんは窓の外に目をやった。", is_choice: false, choices: [] },
          { speaker: "", text: "続きを待ったけれど、来なかった。", is_choice: false, choices: [] },
          { speaker: "", text: "ほうじ茶を淹れる。丁寧に温度を計って、少し冷ました湯で。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは湯呑みを両手で包むように持った。左手の薬指に、古い銀の指輪が光る。", is_choice: false, choices: [] },
          { speaker: "", text: "香りを確かめ、目を閉じた。味わうように——一口。", is_choice: false, choices: [] },
          { speaker: "", text: "何も言わない。でも、もう一口飲んだ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s3",
      },
      // --- Scene 3: 宮内の視線とその余韻 ---
      {
        id: "ch2_s3",
        lines: [
          { speaker: "", text: "しばらくの沈黙。宮内さんはほうじ茶を飲みながら、店内をじっと見ていた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが来た。いつもの窓際に座り、いつものコーヒーを注文する。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんはちらりと佐倉さんを見た。知らない顔だ、というように。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんも一瞬だけ目を上げたが、すぐに本に戻った。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんが夕方来た時には、宮内さんはもう帰った後だった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、今日なんか難しい顔してないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そう？ ……ちょっと、考え事。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、新メニューっすか！ なに作ったんすか！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "りんごとシナモンの紅茶。まだ名前がないんだけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジすか、飲みたい！ ……名前ないのもなんかいいっすね。秘密メニューっぽくて。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんに淹れてみる。大きく一口飲んで、目を丸くした。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うまっ！ りんごの味が後からくる！", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんの素直な反応に、少し救われる。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、さっきの宮内さんの横顔が頭から離れなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "あの人は、この店に何を見ていたのだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "「前のオーナーとは長い付き合い」。", is_choice: false, choices: [] },
          { speaker: "", text: "その先の言葉を、宮内さんは飲み込んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店後、カウンターを拭きながら思い出す。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんが帰り際に言った一言。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……悪くない場所だ。また来る。", is_choice: false, choices: [] },
          { speaker: "", text: "「悪くない」。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんと同じ言葉。でも、意味が違う気がした。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの「悪くない」は、コーヒーへの評価。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんの「悪くない」は——この店を引き継いだ人間への、暫定的な許可。", is_choice: false, choices: [] },
          { speaker: "", text: "そんな気がした。", is_choice: false, choices: [] },
          { speaker: "", text: "名前のないメニュー。まだ語られない過去。", is_choice: false, choices: [] },
          { speaker: "", text: "この店には、僕の知らないものがたくさんある。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
