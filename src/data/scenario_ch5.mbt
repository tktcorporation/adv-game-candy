// ============================================================
// 第五章: レシピノート
// ============================================================
//
// あらすじ:
//   エスプレッソマシンの裏側を掃除中、一冊の古いノートが落ちてくる。
//   藤宮時雨のレシピノート。レシピだけでなく、客の好みや季節のメモが丁寧に記されている。
//   最後のページに書きかけの手紙——「しずくへ——」。
//   ノートのレシピを試すと、常連たちが懐かしそうな表情を見せる。
//
// 登場キャラ: 佐倉美月、宮内孝之
// キーイベント:
//   - レシピノートの発見（三度触れ #2: ノート — 発見）
//   - 「しずくへ——」の手紙（三度触れ #1: 手紙）
//   - ノートのレシピを淹れて宮内が反応する
// ============================================================

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
      // --- Scene 1: ノートの発見 ---
      {
        id: "ch5_s1",
        lines: [
          { speaker: "", text: "閉店後。大掃除をしていた。", is_choice: false, choices: [] },
          { speaker: "", text: "普段手が届かない場所——エスプレッソマシンの裏側。", is_choice: false, choices: [] },
          { speaker: "", text: "マシンを少しだけ動かすと、壁との隙間から何かが落ちた。", is_choice: false, choices: [] },
          { speaker: "", text: "小さな音。床に当たって跳ねる。", is_choice: false, choices: [] },
          { speaker: "", text: "……一冊の、ノート。", is_choice: false, choices: [] },
          { speaker: "", text: "茶色い革の表紙。角が丸くなっている。使い込まれた手触り。", is_choice: false, choices: [] },
          { speaker: "", text: "前に棚の奥で見かけた気がする。でも、ここにあったのか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "これは……レシピノート？", is_choice: false, choices: [] },
          { speaker: "", text: "開く。丁寧な手書きの文字が並んでいた。", is_choice: false, choices: [] },
          { speaker: "", text: "「ブレンド#7 — 豆: コロンビア60% グアテマラ40% 焙煎: 中深 抽出: 88℃ 3分」", is_choice: false, choices: [] },
          { speaker: "", text: "レシピだ。細かい数字と、その横に走り書きの感想。", is_choice: false, choices: [] },
          { speaker: "", text: "「少し酸味が立つ。宮内さんにはもう少し深煎りがいいかもしれない」", is_choice: false, choices: [] },
          { speaker: "", text: "……宮内さんの名前がある。", is_choice: false, choices: [] },
          { speaker: "", text: "ページをめくる。レシピだけじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "お客さんの好み。季節ごとのメモ。仕入れ先の電話番号。", is_choice: false, choices: [] },
          { speaker: "", text: "「秋のブレンド — 焙煎の香りが似合う季節。少し深めに」", is_choice: false, choices: [] },
          { speaker: "", text: "「窓際の女性 — いつもブラック。砂糖を勧めると少し笑う」", is_choice: false, choices: [] },
          { speaker: "", text: "一人ひとりのことが、大切に記録されている。", is_choice: false, choices: [] },
          { speaker: "", text: "15年分の、静かな観察と愛情。", is_choice: false, choices: [] },
          { speaker: "", text: "最後のページに近づく。", is_choice: false, choices: [] },
          { speaker: "", text: "レシピのメモが途切れ、違う文字が現れた。", is_choice: false, choices: [] },
          { speaker: "", text: "手紙だった。書きかけの。", is_choice: false, choices: [] },
          { speaker: "", text: "『しずくへ——』", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ。続きは、白い余白のまま。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "しずく……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "娘さん、だろうか。", is_choice: false, choices: [] },
          { speaker: "", text: "書きかけのまま残された手紙。", is_choice: false, choices: [] },
          { speaker: "", text: "言葉にできなかったのか、しなかったのか。", is_choice: false, choices: [] },
          { speaker: "", text: "ノートを閉じて、胸に抱えた。", is_choice: false, choices: [] },
          { speaker: "", text: "エスプレッソマシンが、静かにそこにある。", is_choice: false, choices: [] },
          { speaker: "", text: "この人は——15年、何を想いながらここに立っていたのだろう。", is_choice: false, choices: [] },
        ],
        next_scene: "ch5_s2",
      },
      // --- Scene 2: ノートのレシピを試す ---
      {
        id: "ch5_s2",
        lines: [
          { speaker: "", text: "翌朝。", is_choice: false, choices: [] },
          { speaker: "", text: "開店前の静かな時間。ノートを開いて、あるレシピを試してみた。", is_choice: false, choices: [] },
          { speaker: "", text: "「時雨ブレンド — 看板メニュー。迷ったらこれを出す」", is_choice: false, choices: [] },
          { speaker: "", text: "豆の配合を再現する。焙煎度は変えられないから、近いものを選ぶ。", is_choice: false, choices: [] },
          { speaker: "", text: "温度、抽出時間、ノートの指示通りに。", is_choice: false, choices: [] },
          { speaker: "", text: "……できた。", is_choice: false, choices: [] },
          { speaker: "", text: "一口飲む。", is_choice: false, choices: [] },
          { speaker: "", text: "——深くて、丸い。苦味の奥にほのかな甘みがある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……これが、あの人の味か。", is_choice: false, choices: [] },
          { speaker: "", text: "自分の淹れるコーヒーとは、全然違う。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、不思議と嫌じゃなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "週末の朝。宮内さんが来た。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "今日も、ほうじ茶を——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "宮内さん。今日、試してほしいものがあるんです。", is_choice: false, choices: [] },
          { speaker: "", text: "ノートのレシピで淹れたコーヒーを差し出す。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんはカップを受け取り、香りを嗅いだ。", is_choice: false, choices: [] },
          { speaker: "", text: "その手が——わずかに、震えた。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……この香りは。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは目を閉じた。長い、長い時間。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……そうか。見つけたのか。あいつのノートを。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。エスプレッソマシンの裏に、隠すように。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "隠したんじゃない。きっと……残したんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは、コーヒーを最後まで飲み干した。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "時雨の味とは違う。だが、時雨のレシピが、ちゃんと息をしている。", is_choice: false, choices: [] },
          { speaker: "宮内孝之", text: "……いい一杯だった。", is_choice: false, choices: [] },
          { speaker: "", text: "それは、宮内さんから聞いた最大の賛辞だった。", is_choice: false, choices: [] },
          { speaker: "", text: "空になったカップの向こうに、朝の光が差している。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
