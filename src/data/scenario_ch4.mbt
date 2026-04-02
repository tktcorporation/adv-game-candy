// ============================================================
// 第四章: 自分のやり方
// ============================================================
//
// あらすじ:
//   Café BLANC開店後、客足が目に見えて減る。
//   効率や数字では勝てないと分かりつつも、自分だけの価値を探す主人公。
//   佐倉が静かに背中を押す。天野は率直に悩みを打ち明ける。
//   エスプレッソマシンに触れた時、前の人の温もりを感じる。
//
// 登場キャラ: 佐倉美月、天野蓮
// キーイベント:
//   - 客足の減少と経営の不安
//   - 佐倉の「いいんじゃない」（背中を押す言葉）
//   - エスプレッソマシンに手を置く（三度触れ #2: マシン）
//   - 窓から差す光が前と違って見える（三度触れ #2: 光）
// ============================================================

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
      // --- Scene 1: 客足の減少 ---
      {
        id: "ch4_s1",
        lines: [
          { speaker: "", text: "雨の日が続いていた。", is_choice: false, choices: [] },
          { speaker: "", text: "窓を打つ雨粒の向こうに、白い看板がぼんやりと光っている。", is_choice: false, choices: [] },
          { speaker: "", text: "Café BLANCがオープンしてから、二週間。", is_choice: false, choices: [] },
          { speaker: "", text: "客足が、明らかに減った。", is_choice: false, choices: [] },
          { speaker: "", text: "今日の来客は、まだ二人。午後三時を過ぎている。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターを拭く。もう十分きれいなのに、手が止められない。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんだ。傘の雫を払いながら入ってくる。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "いつもの。", is_choice: false, choices: [] },
          { speaker: "", text: "変わらない。雨でも、この人は来る。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。手順は同じなのに、今日はやけに長く感じる。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……暇そうね。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんにしては、珍しく直球だった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……はい。正直、厳しいです。", is_choice: false, choices: [] },
          { speaker: "", text: "取り繕う気力もなかった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……大丈夫？", is_choice: false, choices: [] },
          { speaker: "", text: "本を閉じて、こちらを見ている。", is_choice: false, choices: [] },
          { speaker: "", text: "この人がこちらを真っ直ぐ見るのは、初めてかもしれない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大丈夫、じゃないかもしれない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも——やめない。", is_choice: false, choices: [] },
          { speaker: "", text: "口に出すと、少しだけ本当になる気がした。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "そう。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なら、いいんじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは、また本を開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "でもその「いいんじゃない」は、突き放す言葉ではなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "静かに、確かに、背中を押されたのだと思った。", is_choice: false, choices: [] },
          { speaker: "", text: "雨は、まだ降り続けている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s2",
      },
      // --- Scene 2: 自分だけのもの ---
      {
        id: "ch4_s2",
        lines: [
          { speaker: "", text: "閉店後。", is_choice: false, choices: [] },
          { speaker: "", text: "一人きりの店内で、カウンターに肘をついている。", is_choice: false, choices: [] },
          { speaker: "", text: "売上のメモを見る。数字は正直だ。", is_choice: false, choices: [] },
          { speaker: "", text: "効率では勝てない。値段でも勝てない。メニューの数でも。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……じゃあ、僕にしかできないことって何だ。", is_choice: false, choices: [] },
          { speaker: "", text: "答えは出ない。出ないけど、考え続ける。", is_choice: false, choices: [] },
          { speaker: "", text: "ふと、エスプレッソマシンに手を置いた。", is_choice: false, choices: [] },
          { speaker: "", text: "ひんやりとした金属の感触。でも、どこか温かい気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "15年。藤宮時雨がこの場所で淹れ続けた時間。", is_choice: false, choices: [] },
          { speaker: "", text: "あの人は、何を考えながらこのマシンに触れていたのだろう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "効率じゃない。数字じゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ここに来る人が、何を求めているか。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは毎日来る。本を読みに。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんは夕方来る。誰かと話しに。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは週末の朝来る。何かを確かめに。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを飲みに来ているんじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "——ここに、いに来ている。", is_choice: false, choices: [] },
          { speaker: "", text: "答えはまだ見えない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、探し続ける理由なら、もう分かっている。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から差し込む街灯の光が、エスプレッソマシンの表面に反射している。", is_choice: false, choices: [] },
          { speaker: "", text: "初めて来た日と同じ光景のはずなのに。", is_choice: false, choices: [] },
          { speaker: "", text: "今は、少しだけ違って見えた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
