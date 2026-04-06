// ============================================================
// 第五章: 文庫本
// ============================================================
//
// あらすじ:
//   一つ空けが定着した頃。晴がひよりの文庫本の表紙をちらっと見る。
//   知っている本だった。思わず「あ、それ面白いですよね」。
//   ひよりが目を見開く。「……読んだんですか」。
//   初めてのまともな会話。本の話。3-5往復で終わる。
//   店主が嬉しそうに見ている。
//
// 登場キャラ: 椎名ひより
// キーイベント:
//   - 晴が自分から話しかける（受動的な晴にとって大きな変化）
//   - 本という共通の話題
//   - ひよりが「好き」という感情の言葉を使う（本に対してだが）
//   - 店主の「いいねえ」
//
// --- 章の状態差分 ---
// 開始状態: 一つ空け。名前を知っている。挨拶はする
// 終了状態: 一つ空け（維持）。本という共通の話題が生まれた
//   晴の変化: 自分から話しかけた。受動的だった晴が初めて能動的に動いた
//   関係性: 「挨拶する人」から「好きな本の話をした人」へ
// ============================================================

/// Chapter 5: 文庫本
pub fn get_chapter_5() -> Chapter {
  {
    id: 5,
    title: "第五章",
    subtitle: "文庫本",
    unlock_player_level: 16,
    scenes: [
      // --- Scene 0: 一つ空けの日常 ---
      // 前提: 一つ空けが定着。「お先に」「お疲れさまです」が日課になった
      // 変化: 距離が近い分、ひよりの文庫本の表紙が見える
      // 結果: 晴が表紙に気づく。知っている本
      {
        id: "ch5_s0",
        lines: [
          { speaker: "", text: "一つ空けの距離が、いつの間にか当たり前になっていた。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日はカツ煮ね。いい豚が入ったんだよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "おお、いいですね。カツ煮好きです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "高瀬くんは揚げ物好きだねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "だって美味いじゃないですか、丸山さんの揚げ物。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "嬉しいこと言ってくれるねえ。", is_choice: false, choices: [] },
          { speaker: "", text: "引き戸が開いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "こんにちは。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、こんにちは。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい、ひよりちゃん。今日はカツ煮だよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。日替わりで。", is_choice: false, choices: [] },
          { speaker: "", text: "一つ空けた席に座る。鞄から文庫本を出す。いつもの光景。", is_choice: false, choices: [] },
          { speaker: "", text: "——その表紙が、目に入った。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あ。あれ——知ってる。あの本、読んだことある）", is_choice: false, choices: [] },
          { speaker: "", text: "水色の背表紙。見覚えのある装丁。真ん中あたりを読んでいる。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（ちょうど話が動くところだな、あのへん）", is_choice: false, choices: [] },
        ],
        next_scene: "ch5_s1",
      },
      // --- Scene 1: それ、面白いですよね ---
      // 前提: 晴が本に気づいた。知っている本
      // 変化: 晴が自分から話しかける。本の話で初めてのまともな会話
      // 結果: ひよりが「好き」という言葉を使う。晴にとって大きな一歩
      {
        id: "ch5_s1",
        lines: [
          { speaker: "丸山", text: "はい、カツ煮。二人分ね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……いただきます。", is_choice: false, choices: [] },
          { speaker: "", text: "二人とも黙って食べる。卵のとじ具合がちょうどいい。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日のカツ煮、出汁を変えてみたんだけど、どう？", is_choice: false, choices: [] },
          { speaker: "晴", text: "美味いです。なんか、いつもよりちょっと甘い？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "お、わかる？ みりんの種類変えたんだよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……卵が、ふわっとしてます。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "火を止めるタイミングなんだよねえ。", is_choice: false, choices: [] },
          { speaker: "", text: "食べ終わった。彼女はまた本を開いた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（話しかけていいのかな。読書中だし。……でも）", is_choice: false, choices: [] },
          { speaker: "", text: "迷っているうちに、口が先に動いた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、それ——面白いですよね。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女が顔を上げた。目を見開いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……読んだんですか。", is_choice: false, choices: [] },
          { speaker: "晴", text: "はい。去年の夏くらいに。一気に読んじゃって。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……一気に。", is_choice: false, choices: [] },
          { speaker: "晴", text: "途中から止まらなくなって。あの、川のシーンあたりから。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……わかります。あそこから、全部変わりますよね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "そうそう。それまで静かだったのに、急に。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……私も、そこで読む手が止まらなくなりました。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ですよね。あの作家さん、ああいう転換がすごい。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。この人の本は全部好きです。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（——好き、か）", is_choice: false, choices: [] },
          { speaker: "晴", text: "……いいですね。俺も読んでみようかな、他のやつ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……おすすめ、あります。", is_choice: false, choices: [] },
          { speaker: "晴", text: "え、ほんとですか。聞きたいです。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……二冊目に出た短編集が。読みやすくて。", is_choice: false, choices: [] },
          { speaker: "晴", text: "短編集。メモしとこ。ありがとうございます。", is_choice: false, choices: [] },
        ],
        next_scene: "ch5_s2",
      },
      // --- Scene 2: いいねえ ---
      // 前提: 初めての本格的な会話が終わった
      // 変化: 店主が嬉しそうに見ている。空気が変わった
      // 結果: 晴が自分から動いた日。二人の間に「本」という共通の話題ができた
      {
        id: "ch5_s2",
        lines: [
          { speaker: "丸山", text: "いいねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "え？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いやいや、何でも。本の話してるの、いいなと思って。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いや、別にそんな大した話じゃ……。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ひよりちゃん、本の話する相手いなかったでしょ。俺は本読まないからねえ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……丸山さん。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あはは、ごめんごめん。余計なこと言った。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（店主、デリカシー……まあ、悪い人じゃないんだけど）", is_choice: false, choices: [] },
          { speaker: "晴", text: "じゃ、ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど、高瀬くん。", is_choice: false, choices: [] },
          { speaker: "晴", text: "お先に。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……お疲れさまです。", is_choice: false, choices: [] },
          { speaker: "", text: "引き戸を開けて、路地に出た。午後の日差し。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（話しかけた。……俺から話しかけた）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（本の話。それだけなんだけど、なんか——嬉しかったな）", is_choice: false, choices: [] },
          { speaker: "", text: "「おすすめ、あります」。あの声が、まだ耳に残っていた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（短編集、買って帰ろ）", is_choice: false, choices: [] },
          { speaker: "", text: "明日もあの店に行く理由が、一つ増えた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
