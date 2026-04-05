// ============================================================
// 第七章: 隣
// ============================================================
//
// あらすじ:
//   晴が少し遅れて灯に来ると、ひよりがもう座っている。
//   晴のいつもの席の椅子がガタつくと店主が言い出し、
//   自然とひよりの隣に座ることになる。
//   ひよりは文庫本のページを押さえる指に力が入る。でも席を移らない。
//   肘がぶつかりそうな距離。「狭いですね」「……そうですね」。
//   食べ終わる頃には、もう気にならなくなっている。
//
// 登場キャラ: 椎名ひより
// キーイベント:
//   - 店主の無自覚な介入（椅子のガタつき）が二人を隣にする
//   - 初めての隣席。ひよりは動揺するが逃げない
//   - 「狭いですね」「そうですね」が距離のなさを自然にする
//   - 天丼: ページを押さえる指に力が入る（「ページがめくれない」の変奏）
//
// --- 章の状態差分 ---
// 開始状態: 一つ空けの席。日常会話ができる間柄
// 終了状態: 隣の席に座った。「狭い」けど、悪くない
//   晴の変化: 隣に座ることへの抵抗がなくなった
//   関係性: ひより（隣の席。物理的距離がゼロに近づいた）
// ============================================================

/// Chapter 7: 隣
pub fn get_chapter_7() -> Chapter {
  {
    id: 7,
    title: "第七章",
    subtitle: "隣",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 0,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: 遅刻 ---
      // 前提: 晴がいつもより少し遅れて灯に来る
      // 変化: ひよりがもう座っている。いつもの席の椅子がガタつく
      // 結果: 店主に促されて、ひよりの隣に座ることになる
      {
        id: "ch7_s0",
        lines: [
          { speaker: "", text: "いつもより十五分遅い。ちょっと寝坊した。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。遅かったね、今日。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ちょっと寝坊して。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターを見る。ひよりさんがもう座っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの俺の席は一つ向こう。そこに向かおうとしたら——", is_choice: false, choices: [] },
          { speaker: "丸山", text: "あ、そこの椅子さ、ガタつくんだよね。朝から気になってて。", is_choice: false, choices: [] },
          { speaker: "晴", text: "え？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "脚がぐらぐらしてるの。今度直すけど、今日はちょっと危ないかも。隣座んな。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、はい。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（隣って……ひよりさんの隣じゃん）", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんの隣に座る。一つ空いていたスペースがなくなった。", is_choice: false, choices: [] },
          { speaker: "", text: "近い。思ったよりずっと近い。", is_choice: false, choices: [] },
          { speaker: "晴", text: "すみません、狭いですね。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……そうですね。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんは文庫本を開いたまま答えた。", is_choice: false, choices: [] },
          { speaker: "", text: "——ページを押さえる指に、いつもより力が入っている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s1",
      },
      // --- Scene 1: 肘の距離 ---
      // 前提: 隣に座った。定食が来る
      // 変化: 最初はぎこちないが、食べているうちに慣れていく
      // 結果: 隣の距離に馴染み始める
      {
        id: "ch7_s1",
        lines: [
          { speaker: "丸山", text: "はいよ、日替わり。今日は豚の生姜焼きね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。", is_choice: false, choices: [] },
          { speaker: "", text: "箸を取る。左手が動く。ひよりさんの肘との距離が、ほんの数センチ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（近い……。味噌汁取るのも気を遣う距離だな）", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんが文庫本をそっと閉じて、鞄にしまった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、読まなくていいんですか。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ご飯が来たので。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（いや、いつも食べながら読んでたけど……まあ、いいか）", is_choice: false, choices: [] },
          { speaker: "", text: "二人で同じ生姜焼きを食べる。並んで。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日の生姜焼き、タレちょっと変えてみたんだよ。どう？", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、なんか甘辛い感じ、強くなりました？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "そうそう。味醂を多めにしてみた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……前のも好きでしたけど、今日のも美味しいです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "おっ、二人とも褒めてくれた。嬉しいねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（「二人とも」って言われると、なんか変な感じだな……）", is_choice: false, choices: [] },
          { speaker: "", text: "味噌汁に手を伸ばした。同時にひよりさんも小鉢に手を伸ばす。", is_choice: false, choices: [] },
          { speaker: "", text: "肘がぶつかった。ほんの少し。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、すみません。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……いえ。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんが下を向いた。耳が少し赤い気がする。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……気のせいか）", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s2",
      },
      // --- Scene 2: 気にならなくなる ---
      // 前提: 食事が進む。最初の緊張がほどけてくる
      // 変化: 食べ終わる頃には隣の距離が自然になっている
      // 結果: 隣の席が「ありえる場所」に変わった
      {
        id: "ch7_s2",
        lines: [
          { speaker: "", text: "食べ進めるうちに、不思議なもので、距離が気にならなくなっていった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "小鉢のきんぴら、美味くないですか。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……歯ごたえがいいですよね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごぼうがちゃんとしてるというか。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ちゃんとしてる。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いや変な言い方になった。しっかりしてるというか。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……分かります。ちゃんとしてますよね、ここのごぼう。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（繰り返された。面白い人だな）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ごぼうね、八百屋のおじさんが良いの選んでくれるんだよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。お二人さん。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（「お二人さん」はやめてほしい……）", is_choice: false, choices: [] },
          { speaker: "", text: "立ち上がる。ひよりさんも同じタイミングで席を立った。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、お先にどうぞ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……いえ、どうぞ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "じゃあ。お先に。", is_choice: false, choices: [] },
          { speaker: "", text: "会計を済ませて出る。外は晴れている。", is_choice: false, choices: [] },
          { speaker: "", text: "背中に「ごちそうさまでした」というひよりさんの声が聞こえた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……隣、別に悪くなかったな）", is_choice: false, choices: [] },
          { speaker: "", text: "次の日も、椅子はまだ直っていなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "晴は自然に、ひよりの隣に座った。", is_choice: false, choices: [] },
          { speaker: "", text: "その次の日は、椅子は直っていた。——でも、席は変えなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
