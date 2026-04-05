// ============================================================
// 第二章: 小鉢
// ============================================================
//
// あらすじ:
//   ひよりが小鉢の漬物を残しているのを晴が見る。
//   翌日、小鉢がひじきに変わった時、ひよりが安堵した表情を見せる。
//   帰り際、晴が店主に「小鉢って変えてもらえますか」と聞くのを、
//   ひよりが路地で聞いている。
//   椅子→ハンバーグ→小鉢。善意パターン3回目。
//   3回目は、もう偶然とは呼べなかった。
//
// 登場キャラ: 椎名ひより
// キーイベント:
//   - 晴がひよりの食べ残しから好みを察する（無自覚の観察力）
//   - 店主に小鉢の交換を聞く（「自分も気になっただけ」）
//   - ひよりが路地でそれを聞いている
//   - 天丼: 善意パターン3回目
//
// --- 章の状態差分 ---
// 開始状態: 二つ空け。声を交わしたのは醤油差しの一度きり
// 終了状態: 二つ空け（変化なし）。ひよりの中で「偶然ではない」と確定した
//   晴の変化: ひよりの好みを無意識に観察し始めている（本人は自覚なし）
//   関係性: まだ会話なし。でも晴はひよりの「食べ方」を見ている
// ============================================================

/// Chapter 2: 小鉢
pub fn get_chapter_2() -> Chapter {
  {
    id: 2,
    title: "第二章",
    subtitle: "小鉢",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 0,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: 残された小鉢 ---
      // 前提: いつもの昼。二つ空けの距離が定着している
      // 変化: 晴がひよりの小鉢（漬物）が残っているのに気づく
      // 結果: 晴の中に「あの人、漬物苦手なのかな」という観察が生まれる
      {
        id: "ch2_s0",
        lines: [
          { speaker: "", text: "それから数日。二つ空けた席が、いつの間にか定位置になっていた。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日は鶏の照り焼きね。小鉢はきゅうりの漬物。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日の照り焼き、タレの配合ちょっと変えてみたんだよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "へえ。……あ、なんかいつもよりちょっと甘い？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "おお、わかる？ みりん多めにしてみたんだよねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "美味いです。ご飯進みますね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "でしょでしょ。", is_choice: false, choices: [] },
          { speaker: "", text: "照り焼きを食べながら、ふと横を見た。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女の定食。ご飯も照り焼きも味噌汁もきれいに食べている。", is_choice: false, choices: [] },
          { speaker: "", text: "——小鉢だけ、ほとんど手をつけていなかった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あ……漬物、残してる）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（でも、いつも全部きれいに食べる人なんだよな、あの人）", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は箸で一切れだけつまんで、口に運んだ。少し眉が動いた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（苦手なんだな、漬物）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "高瀬くん、漬物どう？ 今日のいい感じに漬かったと思うんだけど。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、はい。しょっぱすぎず、ちょうどいいです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "よかったあ。塩加減むずかしいんだよねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……まあ、俺が気にすることでもないか）", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s1",
      },
      // --- Scene 1: ひじきの日 ---
      // 前提: 翌日。小鉢がひじきに変わっている
      // 変化: ひよりが安堵した表情を見せる。晴はそれを見る
      // 結果: 晴は「よかったな」と思う。ただそれだけ
      {
        id: "ch2_s1",
        lines: [
          { speaker: "", text: "翌日。灯。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日はサバの塩焼きね。小鉢はひじきの煮物。", is_choice: false, choices: [] },
          { speaker: "晴", text: "はい。いただきます。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "サバ、脂のってるよ今日。秋が近いねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ほんとだ。ジューシーですね。", is_choice: false, choices: [] },
          { speaker: "", text: "しばらくして、彼女も来た。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "こんにちは。日替わりで。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ、ひよりちゃん。今日はサバだよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女の前に定食が置かれた。", is_choice: false, choices: [] },
          { speaker: "", text: "小鉢を見た瞬間——ほんの少しだけ、肩の力が抜けたように見えた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あ、ひじきだ。今日は大丈夫そうだな）", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は小鉢のひじきを一口食べて、小さくうなずいた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（よかった）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "お、今日は二人とも完食だねえ。作りがいがあるよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "美味かったです。サバもひじきも。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……美味しかったです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "嬉しいねえ。二人に言われると倍嬉しいよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s2",
      },
      // --- Scene 2: 路地 ---
      // 前提: 晴がひよりより先に食べ終わる。帰り際に店主に聞く
      // 変化: 「小鉢って変えてもらえますか」——自分のためのふりをして
      //   ひよりが路地でそれを聞いている
      // 結果: 善意パターン3回目。「もう偶然とは呼べなかった」
      {
        id: "ch2_s2",
        lines: [
          { speaker: "", text: "数日後。晴が先に食べ終わって、会計をしている。", is_choice: false, choices: [] },
          { speaker: "", text: "今日の小鉢は、またきゅうりの漬物だった。やっぱり残していた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あの、丸山さん。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ん？", is_choice: false, choices: [] },
          { speaker: "晴", text: "小鉢って、日によって変わりますよね。あれって、リクエストできたりします？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "リクエスト？ いいよ、何がいい？", is_choice: false, choices: [] },
          { speaker: "晴", text: "いや、俺っていうか……漬物よりおひたしとか、煮物系のほうが好きかなって。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "へえ、そうなの。漬物、美味しくできたと思ったんだけどなあ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いや、美味しいんですけど。なんていうか、気分的に。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいはい。じゃあ明日からちょっと考えてみるよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ありがとうございます。じゃ、また。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ。", is_choice: false, choices: [] },
          { speaker: "", text: "引き戸を開けて、路地に出た。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……なんで聞いたんだろ、俺。漬物、別に嫌いじゃないのに）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（まあいいか。煮物のほうが好きなのは本当だし）", is_choice: false, choices: [] },
          { speaker: "", text: "路地を歩いていく。", is_choice: false, choices: [] },
          { speaker: "", text: "——店の引き戸は、薄い。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "", text: "路地に出てすぐのところで、彼女は立ち止まっていた。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど、ひよりちゃん。また明日ね。", is_choice: false, choices: [] },
          { speaker: "", text: "椅子を直してくれた人。ハンバーグを譲ってくれた人。", is_choice: false, choices: [] },
          { speaker: "", text: "そして——小鉢のことを、聞いてくれた人。", is_choice: false, choices: [] },
          { speaker: "", text: "3回目は、もう偶然とは呼べなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は路地の先を見た。もう誰もいなかった。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "", text: "誰にも聞こえない声で、もう一度言った。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
