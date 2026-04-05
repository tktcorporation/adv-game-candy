// ============================================================
// 第一章: 日替わり
// ============================================================
//
// あらすじ:
//   数日後。いつもの灯。今日の日替わりは数量限定の煮込みハンバーグ。
//   主人公が来た時、「あと一つだけど」と店主。
//   主人公は「じゃあ今日はカレーでいいです」と譲った。
//   別にヒロインのためじゃない。後から来る誰かのために、でもない。
//   ただ「カレーでもいいか」と思っただけ。
//   ヒロインが来る。「日替わりで」。店主が「ラスト一つね」と出す。
//   主人公は何も言わない。
//   ——でもヒロインは、店主の会話の断片から気づいてしまう。
//
// 登場キャラ: ヒロイン
// キーイベント:
//   - 主人公が日替わりを譲る（無自覚の善意。ch0の椅子と同じ構造）
//   - ヒロインが後から気づく
//   - 直接お礼を言えない（言ったら「見てた」ことがバレる）
//   - 翌日、ヒロインの席が近くなる
//
// --- 章の状態差分 ---
// 開始状態: 顔見知り。話したことはない
// 終了状態: ヒロインは主人公の善意に気づいた。でも言えない。席が近くなった
//   主人公の変化: なし（自分が何かしたとは思っていない）
//   関係性: ヒロイン（話したことはまだない。でもヒロイン側に変化が起きた）
// ============================================================

/// Chapter 1: 日替わり
pub fn get_chapter_1() -> Chapter {
  {
    id: 1,
    title: "第一章",
    subtitle: "日替わり",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 1,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: ラスト一つ ---
      // 前提: 数日後。いつもの灯。今日は限定メニュー
      // 変化: 主人公が日替わりを譲る。深い理由はない
      // 結果: カレーを食べる主人公
      {
        id: "ch1_s0",
        lines: [
          { speaker: "", text: "数日後。いつもの昼。灯。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "店主", text: "いらっしゃい。今日の日替わり、煮込みハンバーグなんだけどね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "お、いいですね。", is_choice: false, choices: [] },
          { speaker: "店主", text: "ごめんね、あと一つしか残ってないんだよ。仕込み足りなかった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、ラスト一つ。", is_choice: false, choices: [] },
          { speaker: "店主", text: "どうする？ カレーならいつでも出せるけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "んー……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "じゃあ今日はカレーで。", is_choice: false, choices: [] },
          { speaker: "店主", text: "いいの？ ハンバーグ、美味しくできたんだけどなあ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "カレーも好きなんで。全然。", is_choice: false, choices: [] },
          { speaker: "店主", text: "そう？ じゃあカレーね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（ハンバーグちょっと食べたかったけど、まあいいか。カレーはカレーで美味いし）", is_choice: false, choices: [] },
          { speaker: "", text: "カレーが来た。食べる。普通に美味い。", is_choice: false, choices: [] },
          { speaker: "", text: "福神漬けが多めに添えてある。店主の気遣いだろう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（福神漬け多いな。サービスか。ありがたい）", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s1",
      },
      // --- Scene 1: ラスト一つの行方 ---
      // 前提: 主人公がカレーを食べている。ヒロインが来店
      // 変化: 店主が「ラスト一つね」とヒロインにハンバーグを出す
      //   主人公は何も言わない。意識もしていない
      // 結果: 二人とも黙って食べている。普通の昼
      {
        id: "ch1_s1",
        lines: [
          { speaker: "", text: "カレーを食べていたら、引き戸が開いた。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "こんにちは。", is_choice: false, choices: [] },
          { speaker: "店主", text: "いらっしゃい。", is_choice: false, choices: [] },
          { speaker: "", text: "あの人だ。いつもの反対側の席に座った。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "日替わりで。", is_choice: false, choices: [] },
          { speaker: "店主", text: "はいよ。今日は煮込みハンバーグ、ラスト一つね。ぎりぎり間に合ったね。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "……そうですか。", is_choice: false, choices: [] },
          { speaker: "", text: "しばらくして、ハンバーグの定食が彼女の前に置かれた。", is_choice: false, choices: [] },
          { speaker: "", text: "俺はカレーを食べている。向こうはハンバーグ。", is_choice: false, choices: [] },
          { speaker: "", text: "別に何も思わない。カレーは美味い。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s2",
      },
      // --- Scene 2: 気づく ---
      // 前提: 主人公が食べ終わって帰った後
      // 視点: ここだけヒロイン側の描写（主人公は去った後）
      // 変化: ヒロインが店主の言葉から「あの人が譲った」ことに気づく
      // 結果: 文庫本のページがめくれない（ch0ラストと同じ演出の反復）
      {
        id: "ch1_s2",
        lines: [
          { speaker: "", text: "主人公が会計を済ませて帰っていった。", is_choice: false, choices: [] },
          { speaker: "", text: "店内は彼女だけになった。", is_choice: false, choices: [] },
          { speaker: "店主", text: "ハンバーグどうだった？", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "……美味しかったです。", is_choice: false, choices: [] },
          { speaker: "店主", text: "よかった。今日の仕込み少なくてさ、足りるかなって思ってたんだけど。", is_choice: false, choices: [] },
          { speaker: "店主", text: "あの子が譲ってくれたから、最後の一つ回せたんだよねえ。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "……あの子。", is_choice: false, choices: [] },
          { speaker: "店主", text: "さっきのカレーの子。ハンバーグ食べたそうだったけど、「カレーでいいです」って。いい子だよねえ。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は箸を置いた。ハンバーグの皿は空になっている。", is_choice: false, choices: [] },
          { speaker: "", text: "文庫本を開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "——ページが、めくれなかった。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "店主", text: "まいど。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は店を出た。", is_choice: false, choices: [] },
          { speaker: "", text: "路地の角で、一度だけ振り返った。", is_choice: false, choices: [] },
          { speaker: "", text: "主人公が歩いていった方向を。", is_choice: false, choices: [] },
        ],
        next_scene: "ch1_s3",
      },
      // --- Scene 3: 翌日 ---
      // 前提: 翌日の昼
      // 変化: ヒロインの席が変わった。反対側ではなく、二つ空けて隣
      //   主人公は理由が分からない。会話はまだない
      // 結果: 「近くなった」。それだけ。でもそれが全て
      {
        id: "ch1_s3",
        lines: [
          { speaker: "", text: "翌日。昼。灯。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの席に座って、日替わりを待っている。今日は豚の角煮。", is_choice: false, choices: [] },
          { speaker: "", text: "引き戸が開いた。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "こんにちは。", is_choice: false, choices: [] },
          { speaker: "店主", text: "いらっしゃい。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女が入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもなら反対側の端に行く。", is_choice: false, choices: [] },
          { speaker: "", text: "——今日は、二つ空けたところに座った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（……近い）", is_choice: false, choices: [] },
          { speaker: "", text: "話しかけるわけではない。文庫本を出して、日替わりを頼んで、読み始める。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもと同じ。でも、座る場所だけが違う。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（たまたま……だよな？）", is_choice: false, choices: [] },
          { speaker: "", text: "定食が来た。二人とも同じ角煮。", is_choice: false, choices: [] },
          { speaker: "", text: "黙って食べる。箸の音と、店主の鼻歌。", is_choice: false, choices: [] },
          { speaker: "", text: "静かだけど、前よりなんとなく——近い。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女が小鉢に手を伸ばした。おひたし。", is_choice: false, choices: [] },
          { speaker: "", text: "醤油差しが主人公の向こう側にある。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女が一瞬そちらを見た。手を引っ込めかける。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "醤油差しを取って、彼女の前に置いた。", is_choice: false, choices: [] },
          { speaker: "ヒロイン", text: "……ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "", text: "初めて、声を聞いた。", is_choice: false, choices: [] },
          { speaker: "", text: "——近くで聞くと、思ったよりずっと静かで、きれいな声だった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（……）", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ。それ以上は何も起きなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "二人とも黙って食べ終わって、二人とも「ごちそうさま」を言って、店を出た。", is_choice: false, choices: [] },
          { speaker: "", text: "帰り道。午後の日差し。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（今日、あの人近かったな）", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（いつも反対側なのに。なんでだろ）", is_choice: false, choices: [] },
          { speaker: "主人公", text: "（……たまたまか）", is_choice: false, choices: [] },
          { speaker: "", text: "たまたまだと思った。理由は何もないはずだった。", is_choice: false, choices: [] },
          { speaker: "", text: "——知らないだけだった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
