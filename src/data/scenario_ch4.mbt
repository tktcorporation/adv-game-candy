// ============================================================
// 第四章: 名前
// ============================================================
//
// あらすじ:
//   店主が「お兄さん名前なんだっけ」と聞く。「高瀬です」。
//   店主が「ひよりちゃんはもう3年くらい来てくれてるもんねえ」と
//   無意識に情報漏洩。晴は彼女の名前を知る。
//   帰り際、晴が「お先に」とひよりに初めて直接話す。
//   翌日、ひよりの席が一つ近くなる。
//
// 登場キャラ: 椎名ひより
// キーイベント:
//   - 店主の情報漏洩で互いの名前を知る
//   - 晴の「お先に」= ひよりへの最初の直接発話
//   - ひよりの「ごちそうさまでした」が晴に聞かせることを意識した発話に変わる
//   - 翌日、一つ空けの席に
//   - 天丼: 「ごちそうさまでした」の意識的な発話
//
// --- 章の状態差分 ---
// 開始状態: 二つ空け。雨の日に短い会話をした
// 終了状態: 一つ空け。名前を知った。「お先に」「ごちそうさまでした」が直接の言葉に
//   晴の変化: ひよりの名前を知った。「お先に」を自分から言った
//   関係性: 「名前を知っている人」へ。席が一つ近づいた
// ============================================================

/// Chapter 4: 名前
pub fn get_chapter_4() -> Chapter {
  {
    id: 4,
    title: "第四章",
    subtitle: "名前",
    unlock_intimacy: 250,
    scenes: [
      // --- Scene 0: 高瀬です ---
      // 前提: 雨の日の会話以来、少しだけ空気がやわらかくなった
      // 変化: 店主が晴に名前を聞く。晴が名乗る
      // 結果: 店主の無意識な情報漏洩で、ひよりの名前が晴に伝わる
      {
        id: "ch4_s0",
        lines: [
          { speaker: "", text: "雨の日から数日。天気は回復して、いつもの昼。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日はアジフライ。カラッと揚がったよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "おお、いいですね。揚げ物の日はテンション上がる。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "でしょ。ソースとタルタル、両方あるからね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "両方つけていいんですか。贅沢だ。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "そういえばさ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "はい？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "お兄さん、名前なんだっけ。もうずいぶん来てくれてるのに、聞いてなかったなって。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、高瀬です。高瀬晴。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "高瀬くんね。晴って、いい名前だねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ありがとうございます。親がつけたんで、俺は何もしてないですけど。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あはは。まあそりゃそうだ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "丸山さんは、常連さんの名前けっこう覚えてるんですか。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まあねえ。二十年やってるとね、自然に覚えちゃうんだよ。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ひよりちゃんなんか、もう三年くらい来てくれてるもんねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ひより……。", is_choice: false, choices: [] },
          { speaker: "", text: "二つ向こうで、箸が止まった気がした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ほら、いつも本読んでる子。静かだけど、ちゃんと全部食べてくれるんだよ。いい子だよねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "はあ、三年。俺より全然長いじゃないですか。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "先輩だよ、高瀬くんから見たら。ねえ、ひよりちゃん。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……そんな、先輩とかじゃ。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "三年通えば先輩だよ。灯の大先輩。", is_choice: false, choices: [] },
          { speaker: "晴", text: "じゃあ俺、まだ新入りですね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あはは。でも毎日来てくれるから、もう十分常連だよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（ひより。あの人、ひよりっていうんだ）", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s1",
      },
      // --- Scene 1: お先に ---
      // 前提: 名前を知った直後の帰り際
      // 変化: 晴がひよりに直接「お先に」と言う。初めての直接発話
      // 結果: ひよりの「ごちそうさまでした」が変わる
      {
        id: "ch4_s1",
        lines: [
          { speaker: "晴", text: "ごちそうさまです。アジフライ、最高でした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど、高瀬くん。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（高瀬くん。なんか照れるな）", is_choice: false, choices: [] },
          { speaker: "", text: "席を立つ。彼女はまだ食べている。味噌汁を最後に飲むタイプらしい。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもならそのまま出る。でも今日は——名前を知ってしまったからか。", is_choice: false, choices: [] },
          { speaker: "晴", text: "お先に。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女のほうを見て言った。初めて、直接。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女が顔を上げた。少しだけ目を見開いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……お疲れさまです。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……あ。目が合った）", is_choice: false, choices: [] },
          { speaker: "", text: "引き戸を開けて出た。路地。午後の日差し。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（言えた。なんかちょっとだけ、よかった）", is_choice: false, choices: [] },
          { speaker: "", text: "——店の中では。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "高瀬くん、いい子だよねえ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……高瀬、さん。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "そうそう、高瀬晴くん。晴って、いい名前だよねえ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は味噌汁を飲み干して、静かに箸を置いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもより少しだけ、声が大きかった。", is_choice: false, choices: [] },
          { speaker: "", text: "まるで——もう出ていった誰かにも、聞こえるように。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s2",
      },
      // --- Scene 2: 一つ空け ---
      // 前提: 翌日。「お先に」の翌日
      // 変化: ひよりの席が一つ近くなる
      // 結果: 二つ空け→一つ空け。距離が縮まった
      {
        id: "ch4_s2",
        lines: [
          { speaker: "", text: "翌日。昼。灯。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ、高瀬くん。今日は豚の生姜焼き。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。生姜焼き、好きなんですよね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "知ってるよ。いつも嬉しそうに食べるもん。", is_choice: false, choices: [] },
          { speaker: "晴", text: "そんな顔してます？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "してるしてる。目がね、違うんだよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "うわ、恥ずかしい。", is_choice: false, choices: [] },
          { speaker: "", text: "食べ始めたところで、引き戸が開いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "こんにちは。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい、ひよりちゃん。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女が入ってきた。二つ空けた席の方に向かう——と思った。", is_choice: false, choices: [] },
          { speaker: "", text: "一つ、通り過ぎた。一つ空けた席に、座った。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……近い）", is_choice: false, choices: [] },
          { speaker: "ひより", text: "日替わりで。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ。今日は生姜焼き。高瀬くんの好物だよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いや、言わなくていいですそれ。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あはは。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……生姜焼き、いい匂いですね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、美味いですよ。今日の。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "お、高瀬くんが太鼓判。期待していいよ、ひよりちゃん。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。楽しみです。", is_choice: false, choices: [] },
          { speaker: "", text: "一つ空けた距離。前よりまた一つ近い。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（たまたま……とは、もう思わないけど）", is_choice: false, choices: [] },
          { speaker: "", text: "小鉢はほうれん草のおひたしだった。二人とも、きれいに食べた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
