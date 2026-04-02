// ============================================================
// 第一章: 最初の常連
// ============================================================
//
// あらすじ:
//   開店から数日。佐倉美月がほぼ毎日通うようになる。
//   夕方、大学生の天野蓮がココアを求めて来店。明るい性格で店に活気が生まれる。
//   週末、古書店主の宮内孝之が訪れ、前オーナー「藤宮時雨」の名を初めて明かす。
//   カフェに少しずつ「常連」と呼べる人たちが現れ始める。
//
// 登場キャラ: 佐倉美月、天野蓮、宮内孝之
// キーイベント:
//   - 佐倉の「悪くない」が褒め言葉だと気づく
//   - 天野蓮の登場（夕方、エネルギッシュ）
//   - 宮内が「時雨」の名前を出す（三度触れ #2: 前の人）
//   - 宮内がエスプレッソマシンをじっと見つめる描写
// ============================================================

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
      // --- Scene 1: 佐倉が通い始める ---
      {
        id: "ch1_s1",
        lines: [
          { speaker: "", text: "開店から数日が経った。", is_choice: false, choices: [] },
          { speaker: "", text: "相変わらず、客はまばらだ。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、一人だけ——ほぼ毎日来る人がいる。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "午後二時。今日もドアベルが鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "あの女性——佐倉さん。いつもの窓際の席。いつもの文庫本。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "コーヒーを。", is_choice: false, choices: [] },
          { speaker: "", text: "一言だけ。メニューも見ない。", is_choice: false, choices: [] },
          { speaker: "", text: "淹れ方を少し変えてみた。蒸らしの時間を長めにとって、温度を少し下げて。", is_choice: false, choices: [] },
          { speaker: "", text: "昨日の反省を、今日の一杯に込める。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本を閉じ、カップを両手で包んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "今日のは……悪くないです。", is_choice: false, choices: [] },
          { speaker: "", text: "「悪くない」。", is_choice: false, choices: [] },
          { speaker: "", text: "初日にあれだけ辛辣だった人の「悪くない」は——", is_choice: false, choices: [] },
          { speaker: "", text: "きっと、褒め言葉なのだと気づいた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはそれ以上何も言わず、また本を開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "ページをめくる指先が、どこか穏やかに見えた。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から午後の光が、彼女の横顔を照らしている。", is_choice: false, choices: [] },
          { speaker: "", text: "……なんだろう。この人がいるだけで、店が少しだけ「カフェ」に見える。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s2",
      },
      // --- Scene 2: 天野蓮の来店 ---
      {
        id: "ch1_s2",
        lines: [
          { speaker: "", text: "夕方。空が茜色に染まり始めた頃。", is_choice: false, choices: [] },
          { speaker: "", text: "商店街のアーケードに、帰宅する人たちの影が伸びている。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが勢いよく開いた。ベルが普段の倍くらい鳴る。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "すんません、ここカフェっすよね！？", is_choice: false, choices: [] },
          { speaker: "", text: "リュックを背負った青年。息が上がっている。走ってきたのだろうか。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ココアってありますか？ あったかいやつ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ココアか……えっと、ちょっと待って。作れると思う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マジすか！ やった！", is_choice: false, choices: [] },
          { speaker: "", text: "彼はカウンターの一番端に腰かけた。リュックをドスンと隣の席に置く。", is_choice: false, choices: [] },
          { speaker: "", text: "棚の奥からココアパウダーを探す。あった。これも前の人の残り物だ。", is_choice: false, choices: [] },
          { speaker: "", text: "ミルクを温めながら、ココアを作る。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、おれ天野っす。天野蓮。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "商店街の金物屋の隣の——あ、もうないんだった。", is_choice: false, choices: [] },
          { speaker: "", text: "一瞬だけ、彼の表情が翳った。", is_choice: false, choices: [] },
          { speaker: "", text: "でもすぐに、元の笑顔に戻る。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "今はこのへんでバイトしてるんすよ。よろしくっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "よろしく。はい、ココア。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんはカップを受け取ると、大きく一口飲んだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……うまっ！ めっちゃあったまる！", is_choice: false, choices: [] },
          { speaker: "", text: "彼はそのまま、バイト先の話や大学の話を次々としゃべり始めた。", is_choice: false, choices: [] },
          { speaker: "", text: "こちらが相槌を打つ間もないくらいに。", is_choice: false, choices: [] },
          { speaker: "", text: "さっきまで静かだった店内が、急に賑やかになった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本越しにこちらを見た。", is_choice: false, choices: [] },
          { speaker: "", text: "……少しだけ、口元が緩んでいた気がする。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s3",
      },
      // --- Scene 3: 宮内孝之の来店 ---
      {
        id: "ch1_s3",
        lines: [
          { speaker: "", text: "週末の朝。", is_choice: false, choices: [] },
          { speaker: "", text: "まだ開店したばかりの時間。通りに人影は少ない。", is_choice: false, choices: [] },
          { speaker: "", text: "豆を挽いていると、ドアベルが静かに鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "穏やかな老紳士が、ゆっくりと入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "背筋が伸びている。丸い眼鏡。紺色のベスト。", is_choice: false, choices: [] },
          { speaker: "", text: "彼は入り口で足を止め、店内を見回した。", is_choice: false, choices: [] },
          { speaker: "", text: "その目が、カウンター奥のエスプレッソマシンに留まる。", is_choice: false, choices: [] },
          { speaker: "", text: "……長い、数秒だった。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ほう……この店、また開いたのか。", is_choice: false, choices: [] },
          { speaker: "", text: "「また」。この人は、前の店を知っている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。最近始めたばかりで。よろしくお願いします。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "ほうじ茶はあるかね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい、ございます。", is_choice: false, choices: [] },
          { speaker: "", text: "彼はカウンターの真ん中に座った。背筋を崩さないまま。", is_choice: false, choices: [] },
          { speaker: "", text: "ほうじ茶を淹れる。茶葉を温めた急須に入れ、少し冷ましたお湯を注ぐ。", is_choice: false, choices: [] },
          { speaker: "", text: "香ばしい香りが、静かに広がった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "老紳士は湯呑みを両手で包み、まず香りを確かめた。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "", text: "目を閉じた。何かを思い出しているような表情。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "いい香りだ。……時雨の淹れ方とは違うが、悪くない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "時雨……？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それが、前のオーナーの名前ですか。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "藤宮時雨。15年、ここでカフェをやっていた男だ。", is_choice: false, choices: [] },
          { speaker: "", text: "藤宮、時雨。", is_choice: false, choices: [] },
          { speaker: "", text: "初めて聞いた、前のオーナーの名前。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……君は、あの男のことを何も知らないのだな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。不動産屋から鍵を受け取っただけで。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "そうか。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ言って、宮内さんはほうじ茶を飲み干した。", is_choice: false, choices: [] },
          { speaker: "", text: "何か言いかけて——やめたような、そんな間があった。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……また来よう。週末の朝は、ここで茶を飲むとするか。", is_choice: false, choices: [] },
          { speaker: "", text: "穏やかな声だった。でもどこか、確かめるような響きがあった。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんが出て行った後、エスプレッソマシンの銀色が目に入る。", is_choice: false, choices: [] },
          { speaker: "", text: "藤宮時雨。15年。", is_choice: false, choices: [] },
          { speaker: "", text: "この場所には、僕の知らない時間が積もっている。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
