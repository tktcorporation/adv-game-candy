// ============================================================
// 第零章: いつもの席
// ============================================================
//
// あらすじ:
//   晴が昼に通う飯屋「灯」。カウンター8席の小さな店。
//   いつも同じ時間帯に来る女の人がいる。前から気づいてた。
//   でも目が合っても会釈すらしない距離感。お互い、ただの客。
//   ある日、店が混んでいて相席状態に。隣になった。
//   晴は相手のことが気になるが、何も起きない。
//   ——帰り際、晴のある行動をひよりが見ていた。
//
// 登場キャラ: 椎名ひより
// キーイベント:
//   - 日常描写。晴とひよりは同じ店の常連
//   - 距離は遠い。言葉は交わさない
//   - 帰り際、晴が店主のために椅子を直すのをひよりが見る
//     ——晴は気づいていない
//
// --- 章の状態差分 ---
// 開始状態: 2人とも常連。互いの顔は知ってるが話したことはない。
// 終了状態: まだ話していない。でもひよりの中で何かが引っかかった（読者だけが知る）。
//   晴の変化: なし。いつも通り。
//   関係性: ひより（同じ店の客。それだけ）
// ============================================================

/// Chapter 0: いつもの席
pub fn get_chapter_0() -> Chapter {
  {
    id: 0,
    title: "第零章",
    subtitle: "いつもの席",
    unlock_player_level: 0,
    scenes: [
      // --- Scene 0: 灯 ---
      // 前提: 平日の昼。晴がいつもの店に来る
      // 変化: 日常を描く。店と晴の関係
      // 結果: いつもの昼飯
      {
        id: "ch0_s0",
        lines: [
          { speaker: "", text: "平日の昼。十二時半。", is_choice: false, choices: [] },
          { speaker: "", text: "駅から少し離れた路地を入ったところに、その店はある。", is_choice: false, choices: [] },
          { speaker: "", text: "「灯」。看板が小さくて、知らないと通り過ぎる。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター8席。テーブルは2つ。ランチは日替わり定食が一種類だけ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの端に座る。いつもの席。", is_choice: false, choices: [] },
          { speaker: "晴", text: "日替わりで。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ。今日は鯖の味噌煮ね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、いいですね。", is_choice: false, choices: [] },
          { speaker: "", text: "この店を見つけたのは、引っ越してきて二週間目くらいだった。", is_choice: false, choices: [] },
          { speaker: "", text: "路地の奥で「定食」ののぼりが出てるのが見えて、ふらっと入った。", is_choice: false, choices: [] },
          { speaker: "", text: "それから、ほぼ毎日。味がいいし、量もちょうどいいし、静か。", is_choice: false, choices: [] },
          { speaker: "", text: "鯖が来た。味噌汁と小鉢がついて850円。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s1",
      },
      // --- Scene 1: いつもの人 ---
      // 前提: 食べている途中。いつもの時間帯
      // 変化: いつも見かける女の人が来る。反対側に座る。遠い
      // 結果: 目が合うわけでもない。ただ、同じ空間にいるだけ
      {
        id: "ch0_s1",
        lines: [
          { speaker: "", text: "引き戸が開いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "こんにちは。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。好きなとこ座って。", is_choice: false, choices: [] },
          { speaker: "", text: "女の人が一人。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの反対側に座った。いつもあっち側。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あ、今日も来てるな、あの人）", is_choice: false, choices: [] },
          { speaker: "", text: "前から知っている。知っている、というか——見かけている。", is_choice: false, choices: [] },
          { speaker: "", text: "だいたい同じ時間帯に来る人。", is_choice: false, choices: [] },
          { speaker: "", text: "話したことは一度もない。", is_choice: false, choices: [] },
          { speaker: "", text: "髪が長い。鞄から文庫本を出して、定食が来るまで読んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "注文は同じ。「日替わりで」。声は小さいけど、はっきりしてる。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ。", is_choice: false, choices: [] },
          { speaker: "", text: "同じ店に通う人。互いの名前も知らない。目も合わない。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの端と端。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……まあ、そんなもんだよな。飯屋の他の客なんて）", is_choice: false, choices: [] },
          { speaker: "", text: "鯖を食べる。向こう側でも、静かに箸が動いている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s2",
      },
      // --- Scene 2: 帰り際 ---
      // 前提: 食べ終わった。会計
      // 変化: 晴が立ち上がる時、隣の椅子が少しずれてるのを直す
      //   ——誰にも言わず、自然に。癖みたいな動作
      //   ひよりが本越しにそれを見ている（晴は気づいていない）
      // 結果: 晴にとっては何でもない日。でも何かが動いた
      {
        id: "ch0_s2",
        lines: [
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。", is_choice: false, choices: [] },
          { speaker: "", text: "会計を済ませて、席を立つ。", is_choice: false, choices: [] },
          { speaker: "", text: "——ふと、隣の椅子が斜めにずれているのが目に入った。", is_choice: false, choices: [] },
          { speaker: "", text: "さっきまで座っていたお客さんが動かしたまま帰ったらしい。", is_choice: false, choices: [] },
          { speaker: "", text: "直した。カウンターに沿うように。", is_choice: false, choices: [] },
          { speaker: "", text: "別に誰に頼まれたわけでもない。なんとなく。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あ、ありがとね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いえ。じゃ、また。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ。", is_choice: false, choices: [] },
          { speaker: "", text: "引き戸を開けて出る。昼の日差し。いつもの路地。", is_choice: false, choices: [] },
          { speaker: "", text: "何でもない昼飯だった。", is_choice: false, choices: [] },
          { speaker: "", text: "——店の中では。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの反対側で、彼女が本から目を上げていた。", is_choice: false, choices: [] },
          { speaker: "", text: "晴が椅子を直した手元を、見ていた。", is_choice: false, choices: [] },
          { speaker: "", text: "……文庫本のページが、しばらくめくれなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
