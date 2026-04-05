// ============================================================
// 第三章: 雨の日
// ============================================================
//
// あらすじ:
//   雨の日。客が少ない。ひよりの鞄が濡れて文庫本が出せない。
//   手持ち無沙汰のひよりに店主が話しかけ、巻き込まれる形で
//   晴とひよりが初めて「会話」をする。天気の話。短いが初めて。
//   帰り際、雨の中で一瞬同じ方向に歩く。
//
// 登場キャラ: 椎名ひより
// キーイベント:
//   - 本が読めない = ひよりの「盾」が外れる
//   - 店主の饒舌が触媒になり初会話
//   - 天気という当たり障りのない話題
//   - 帰り際に一瞬だけ並んで歩く
//   - 天丼: 本が濡れて読めない（「ページがめくれない」の変奏）
//
// --- 章の状態差分 ---
// 開始状態: 二つ空け。会話はまだない（醤油差しの一言を除く）
// 終了状態: 二つ空け（維持）。初めての「会話」が成立した
//   晴の変化: ひよりと話した。声を聞いた。短いが確かな会話
//   関係性: 「同じ店の客」から「天気の話をしたことがある人」へ
// ============================================================

/// Chapter 3: 雨の日
pub fn get_chapter_3() -> Chapter {
  {
    id: 3,
    title: "第三章",
    subtitle: "雨の日",
    unlock_intimacy: 150,
    scenes: [
      // --- Scene 0: 雨 ---
      // 前提: 雨の日。客が少ない。静かな店内
      // 変化: ひよりの鞄が濡れている。文庫本を出せない
      // 結果: いつもの「盾」がない状態で、定食を待つひより
      {
        id: "ch3_s0",
        lines: [
          { speaker: "", text: "雨だった。朝から止まない、梅雨の走りみたいな雨。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。降ってますね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。今日は暇だよ、この雨じゃねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "他にお客さんいないんですか。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "さっき一人帰ったきり。雨の日ってみんな近場で済ませちゃうんだよねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "まあ、ここ路地の奥ですもんね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日は肉じゃがね。こういう日は温かいもんだよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いいですね。", is_choice: false, choices: [] },
          { speaker: "", text: "しばらくして、引き戸が開いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……こんにちは。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。おお、濡れちゃったねえ。タオル使う？", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……大丈夫です。ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女はいつもの席——二つ空けたところに座った。", is_choice: false, choices: [] },
          { speaker: "", text: "鞄をカウンターの下に置く。いつもならここで文庫本を出す。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あ。鞄、けっこう濡れてるな……本、出せないのか）", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は手持ち無沙汰に、箸置きを指先でなぞっていた。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ひよりちゃん、鞄大丈夫？ 新聞紙あるよ、中に詰めとく？", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……いえ、帰ったら乾かします。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s1",
      },
      // --- Scene 1: 初会話 ---
      // 前提: 本が読めないひより。饒舌な店主。空いた店内
      // 変化: 店主が天気の話を振り、晴とひよりが巻き込まれて会話する
      // 結果: 短いが、初めて「会話」と呼べるやりとりが生まれた
      {
        id: "ch3_s1",
        lines: [
          { speaker: "丸山", text: "しっかし降るねえ。天気予報、午後から止むって言ってたけど。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ほんとですか。帰りまでに止むといいな。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "傘持ってきた？", is_choice: false, choices: [] },
          { speaker: "晴", text: "折り畳みだけ。あんまり役に立たないやつ。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あはは。そっちのお嬢さんは？ 傘あった？", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……傘は、持ってきたんですけど。風が強くて。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "だよねえ。横殴りだもん。傘の意味ないよね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "わかります。折り畳みなんて骨が折れそうでした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "壊れなかった？", is_choice: false, choices: [] },
          { speaker: "晴", text: "ギリギリ。もう一回あの風来たら終わりです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あはは。まあ食べて元気出して。はい、肉じゃが。二人分ね。", is_choice: false, choices: [] },
          { speaker: "", text: "定食が来た。肉じゃがの湯気が、雨の冷えた空気に映える。", is_choice: false, choices: [] },
          { speaker: "晴", text: "肉じゃが、雨の日にちょうどいいですね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "でしょ？ ねえ、そう思わない？", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。あったかいです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日の肉じゃが、じゃがいもがね、いいのが入ったんだよ。ほくほくでさ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、たしかに。崩れてないのにちゃんと味が入ってて。すごいですね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "弱火でじっくりがコツなんだよねえ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……お出汁の味が、しっかりしてます。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "お、わかる？ 昆布を長めに引いたんだよ。嬉しいこと言ってくれるねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（すごいな。出汁の違いがわかるのか）", is_choice: false, choices: [] },
          { speaker: "晴", text: "俺、出汁の違いとか全然わかんないんですよね。美味いか美味くないかだけで。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "それでいいんだよ。美味いって言ってもらえりゃ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……味がわかるのと、美味しいと思うのは、別ですから。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ……それ、いいこと言いますね。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女が少しうつむいた。箸を動かし続けている。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ほんとだよねえ。名言だよ、今の。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s2",
      },
      // --- Scene 2: 帰り道 ---
      // 前提: 食べ終わって帰る。雨はまだ降っている
      // 変化: 一瞬だけ同じ方向に歩く。傘の距離
      // 結果: 短い並歩き。言葉は少ないが、確かに並んだ
      {
        id: "ch3_s2",
        lines: [
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。気をつけてね、足元。", is_choice: false, choices: [] },
          { speaker: "晴", text: "はい。折り畳み、がんばります。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あはは、がんばれ。", is_choice: false, choices: [] },
          { speaker: "", text: "折り畳み傘を開いて、路地に出た。雨はまだ降っている。", is_choice: false, choices: [] },
          { speaker: "", text: "——後ろで、引き戸が開いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。ひよりちゃんも気をつけてね。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女も出てきた。傘を開く。白い傘。", is_choice: false, choices: [] },
          { speaker: "", text: "路地は一本道。出口は同じ方向。自然と、並んで歩く形になった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "……雨、止みそうにないですね。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……そうですね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "本、大丈夫でした？ 鞄、けっこう濡れてたから。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……少しだけ。表紙が。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あー……それは、つらいですね。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……乾けば、読めますから。", is_choice: false, choices: [] },
          { speaker: "晴", text: "それならよかった。", is_choice: false, choices: [] },
          { speaker: "", text: "路地の出口。ここで道が左右に分かれる。", is_choice: false, choices: [] },
          { speaker: "晴", text: "じゃ、俺こっちなんで。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。お疲れさまです。", is_choice: false, choices: [] },
          { speaker: "", text: "軽く頭を下げて、別れた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（話した。……初めてちゃんと話したな、あの人と）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（天気の話と、本の話。それだけなんだけど）", is_choice: false, choices: [] },
          { speaker: "", text: "折り畳み傘が風に煽られた。やっぱり役に立たない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、雨の日も悪くないな、と思った。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
