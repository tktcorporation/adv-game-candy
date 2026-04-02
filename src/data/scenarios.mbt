// Story scenarios for 廃墟カフェ復興記

/// Get all chapters
pub fn get_chapters() -> Array[Chapter] {
  [get_chapter_0(), get_chapter_1(), get_chapter_2(), get_chapter_3(), get_chapter_4(), get_chapter_5(), get_chapter_6(), get_chapter_7(), get_chapter_8()]
}

/// Chapter 0: 廃墟と最初の一杯
pub fn get_chapter_0() -> Chapter {
  {
    id: 0,
    title: "第零章",
    subtitle: "廃墟と最初の一杯",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 0,
    unlock_intimacy: 0,
    scenes: [
      {
        id: "ch0_s1",
        lines: [
          { speaker: "", text: "朝。錆びた看板の前に立っている。", is_choice: false, choices: [] },
          { speaker: "", text: "『月灯り』——それがこのカフェの名前だった。", is_choice: false, choices: [] },
          { speaker: "", text: "埃をかぶったカウンター。割れたカップの破片。窓から差し込む光だけが、この場所がかつて生きていたことを教えてくれる。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、一つだけ。エスプレッソマシンだけが、丁寧にカバーをかけられて残されていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ここが、僕のカフェになる場所……なのか。", is_choice: false, choices: [] },
          { speaker: "", text: "まずは、一杯淹れてみよう。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s2",
      },
      {
        id: "ch0_s2",
        lines: [
          { speaker: "", text: "棚の奥に、密封された豆の缶を見つけた。2年前のものだ。", is_choice: false, choices: [] },
          { speaker: "", text: "手動のミルで豆を挽く。かすかに、良い香りがした。", is_choice: false, choices: [] },
          { speaker: "", text: "お湯を沸かし、慎重にドリップする。", is_choice: false, choices: [] },
          { speaker: "", text: "……できた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "苦い。雑味もある。でも、悪くない。", is_choice: false, choices: [] },
          { speaker: "", text: "最初の一杯。この場所で淹れた、最初のコーヒー。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s3",
      },
      {
        id: "ch0_s3",
        lines: [
          { speaker: "", text: "カランカラン……。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルが鳴った。振り返ると、女性が一人立っていた。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "ここ、開いてるの？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、えっと……はい。一応。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "じゃあ、コーヒーを一杯。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は窓際の席に座り、本を開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "30分ほど静かに読書をして、コーヒーを飲み干した。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "立ち上がり際、小さな声で。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "——前の人は、もっと上手でしたよ。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが閉まった後も、その言葉が耳に残っていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "前の人……？", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

/// Chapter 1: 最初の常連
pub fn get_chapter_1() -> Chapter {
  {
    id: 1,
    title: "第一章",
    subtitle: "最初の常連",
    unlock_revenue: 500,
    unlock_recipes: 0,
    unlock_customers: 0,
    unlock_intimacy: 0,
    scenes: [
      {
        id: "ch1_s1",
        lines: [
          { speaker: "", text: "開店から数日。少しずつ、人が来るようになった。", is_choice: false, choices: [] },
          { speaker: "", text: "あの女性——佐倉さんは、ほぼ毎日来るようになった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "今日のは……悪くないです。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女の「悪くない」は、褒め言葉なのだと気づいた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s2",
      },
      {
        id: "ch1_s2",
        lines: [
          { speaker: "", text: "夕方。大学生らしき青年が入ってきた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの、ここカフェですよね？ ココアってありますか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ココアか……ちょっと待ってね。作れると思う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やった！ あ、おれ天野っす。蓮。よろしくです！", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんは、商店街でバイトをしているらしい。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s3",
      },
      {
        id: "ch1_s3",
        lines: [
          { speaker: "", text: "週末の朝。穏やかな老紳士が訪れた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ほう……この店、また開いたのか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。よろしくお願いします。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ほうじ茶はあるかね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい、ございます。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "いい香りだ。……時雨の淹れ方とは違うが、悪くない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "時雨……？ それが、前のオーナーの名前ですか？", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "藤宮時雨。15年、ここでカフェをやっていた男だ。", is_choice: false, choices: [] },
          { speaker: "", text: "初めて聞いた名前。前のオーナーの名前——藤宮時雨。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

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
      {
        id: "ch2_s1",
        lines: [
          { speaker: "", text: "レシピの研究を重ねるうちに、新しい組み合わせが見えてきた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "りんごとシナモンで……これはいけるかも。", is_choice: false, choices: [] },
          { speaker: "", text: "メニューに名前をつける。それは、この店を自分のものにしていくということ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s2",
      },
      {
        id: "ch2_s2",
        lines: [
          { speaker: "", text: "取材で来たという女性が、カウンターに座った。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "地元紙の神崎です。商店街の特集を書いていて。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うちなんかで良ければ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「なんか」って言わないで。……面白い店じゃない、ここ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんは、日替わりのおすすめを注文した。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "へえ……冒険するタイプ、好きよ。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

/// Chapter 3: 白い看板
pub fn get_chapter_3() -> Chapter {
  {
    id: 3,
    title: "第三章",
    subtitle: "白い看板",
    unlock_revenue: 3000,
    unlock_recipes: 10,
    unlock_customers: 3,
    unlock_intimacy: 0,
    scenes: [
      {
        id: "ch3_s1",
        lines: [
          { speaker: "", text: "商店街の角に、真新しい看板が立った。", is_choice: false, choices: [] },
          { speaker: "", text: "『Café BLANC』——大手チェーンのカフェ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やばくないすか？ チェーン店来ちゃいましたよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうだね。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s2",
      },
      {
        id: "ch3_s2",
        lines: [
          { speaker: "", text: "その日の午後、スーツ姿の女性が店に入ってきた。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "Café BLANCエリアマネージャーの桐谷です。ご挨拶に。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうも。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "敵対するつもりはありません。ただ、マーケットは有限ですから。", is_choice: false, choices: [] },
          { speaker: "", text: "柔らかい笑顔の奥に、確かな自信が見えた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

/// Chapter 4: 自分のやり方
pub fn get_chapter_4() -> Chapter {
  {
    id: 4,
    title: "第四章",
    subtitle: "自分のやり方",
    unlock_revenue: 5000,
    unlock_recipes: 12,
    unlock_customers: 4,
    unlock_intimacy: 300,
    scenes: [
      {
        id: "ch4_s1",
        lines: [
          { speaker: "", text: "Café BLANCがオープンしてから、客足が明らかに減った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……大丈夫？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大丈夫、じゃないかもしれない。でも、やめない。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "そう。……なら、いいんじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの「いいんじゃない」は、背中を押す言葉だった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s2",
      },
      {
        id: "ch4_s2",
        lines: [
          { speaker: "", text: "自分だけのやり方を探す。この店にしかないものを。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "効率じゃない。数字じゃない。ここに来る人が、何を求めているか。", is_choice: false, choices: [] },
          { speaker: "", text: "答えはまだ見えない。でも、探し続ける。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

/// Chapter 5: レシピノート
pub fn get_chapter_5() -> Chapter {
  {
    id: 5,
    title: "第五章",
    subtitle: "レシピノート",
    unlock_revenue: 8000,
    unlock_recipes: 15,
    unlock_customers: 5,
    unlock_intimacy: 600,
    scenes: [
      {
        id: "ch5_s1",
        lines: [
          { speaker: "", text: "エスプレッソマシンの裏側から、一冊のノートが出てきた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "これは……レシピノート？", is_choice: false, choices: [] },
          { speaker: "", text: "前のオーナー、藤宮時雨のものだった。", is_choice: false, choices: [] },
          { speaker: "", text: "レシピだけじゃない。お客さんの好みや、季節のメモ。丁寧な字で書かれていた。", is_choice: false, choices: [] },
          { speaker: "", text: "最後のページに、書きかけの手紙があった。", is_choice: false, choices: [] },
          { speaker: "", text: "『しずくへ——』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "しずく……娘さん、だろうか。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

/// Chapter 6: それぞれの理由
pub fn get_chapter_6() -> Chapter {
  {
    id: 6,
    title: "第六章",
    subtitle: "それぞれの理由",
    unlock_revenue: 12000,
    unlock_recipes: 18,
    unlock_customers: 5,
    unlock_intimacy: 1000,
    scenes: [
      {
        id: "ch6_s1",
        lines: [
          { speaker: "", text: "常連たちのことが、少しずつ分かってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは元パティシエ。3年前に自分の店を閉めた。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんの実家の金物屋は、去年閉店した。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんは東京の大手出版社にいたが、ある記事がきっかけで地方に来た。", is_choice: false, choices: [] },
          { speaker: "", text: "みんな、何かを失って、ここにいる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも、ここに来てくれる。この場所を選んでくれる。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけで、十分な理由になる。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

/// Chapter 7: 月灯りの手紙
pub fn get_chapter_7() -> Chapter {
  {
    id: 7,
    title: "第七章",
    subtitle: "月灯りの手紙",
    unlock_revenue: 18000,
    unlock_recipes: 20,
    unlock_customers: 5,
    unlock_intimacy: 1500,
    scenes: [
      {
        id: "ch7_s1",
        lines: [
          { speaker: "宮内孝之", text: "……そろそろ、話してもいい頃だろう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "宮内さん。前のオーナーのこと……知ってるんですね。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "時雨とは40年来の付き合いだ。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "あいつには娘がいた。しずくという名前の。10年前に絶縁した。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なぜ……", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "しずくは自分の夢を追いたかった。時雨はカフェを継いでほしかった。すれ違いだよ。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "2年前、しずくが自分の夢で成功したと聞いた時——時雨は店を閉めた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "成功したのに……？", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "「もう、しがみつく必要がなくなった」と言っていた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "書き置きが一つ。「このカフェは、いつか誰かが必要とする時に開けばいい」", is_choice: false, choices: [] },
          { speaker: "", text: "その言葉が、胸に深く刺さった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}

/// Chapter 8: ここにいる理由 (Final)
pub fn get_chapter_8() -> Chapter {
  {
    id: 8,
    title: "最終章",
    subtitle: "ここにいる理由",
    unlock_revenue: 25000,
    unlock_recipes: 22,
    unlock_customers: 5,
    unlock_intimacy: 2000,
    scenes: [
      {
        id: "ch8_s1",
        lines: [
          { speaker: "", text: "ある日の午後。見知らぬ女性がドアを開けた。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ここが、父の店。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あなたは——", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "藤宮しずく。……父の、娘です。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は店内を見回した。変わった場所と、変わらない場所を。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "エスプレッソマシン……まだ使ってくれてるんだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大切にされていたものだから。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "あの手紙……読んだの？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "途中までしか書かれていなかった。『しずくへ——』の続きは。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "……それでいい。続きは、きっとお互いに分かってるから。", is_choice: false, choices: [] },
          { speaker: "", text: "しずくさんはコーヒーを一杯注文した。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "美味しい。……父とは違うけど、温かい味。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外では、商店街に夕日が差していた。", is_choice: false, choices: [] },
          { speaker: "", text: "この場所は、人が集まることで生きている。", is_choice: false, choices: [] },
          { speaker: "", text: "かつて藤宮時雨が守り、今は僕が受け継いだ場所。", is_choice: false, choices: [] },
          { speaker: "", text: "『月灯り』は、今日も静かに灯っている。", is_choice: false, choices: [] },
          { speaker: "", text: "——Fin.", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
