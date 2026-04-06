// ============================================================
// 第六章: おかわり
// ============================================================
//
// あらすじ:
//   晴とひよりの会話が少しずつ日常に定着している。
//   小鉢の話、天気の話、本の話。穏やかな昼が続いている。
//   そこに若い女性の新規客が来て「おかわりできますか？」と聞く。
//   店主が嬉しそうに応じる。ひよりはいつもよりほんの少し無口になる。
//   晴はその変化に気づかない。
//
// 登場キャラ: 椎名ひより、モブ客（若い女性）
// キーイベント:
//   - 二人の日常会話が定着していることを自然に描写
//   - モブ客の出現でひよりが微妙に変化（第三者の存在で自分の立場を意識）
//   - 晴は何も気づかない
//   - 店主が新しい客にも嬉しそうに話す（誰にでもこう）
//
// --- 章の状態差分 ---
// 開始状態: 一つ空けの席。短い日常会話が自然にできる間柄
// 終了状態: 変わらない。ただしひよりの中に小さな不安の種が芽生えた
//   晴の変化: なし（気づいていない）
//   関係性: ひより（日常会話ができる間柄。でもひよりだけが少し揺れている）
// ============================================================

/// Chapter 6: おかわり
pub fn get_chapter_6() -> Chapter {
  {
    id: 6,
    title: "第六章",
    subtitle: "おかわり",
    unlock_player_level: 20,
    scenes: [
      // --- Scene 0: いつもの昼 ---
      // 前提: 晴とひよりの日常会話が定着した頃
      // 変化: 二人が自然に短い会話を交わす様子を描写
      // 結果: 穏やかな日常が確立している
      {
        id: "ch6_s0",
        lines: [
          { speaker: "", text: "平日の昼。灯。", is_choice: false, choices: [] },
          { speaker: "", text: "最近は、ほとんど同じ時間に着く。別に合わせているわけじゃない。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。今日は鶏の南蛮漬けね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "お、さっぱり系だ。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの席に座る。一つ隣には、もう鞄が置いてある。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、こんにちは。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……こんにちは。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんは文庫本を開いたまま、軽く頭を下げた。", is_choice: false, choices: [] },
          { speaker: "", text: "こういうのが、いつの間にか普通になった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "今日の小鉢、何でしたっけ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ほうれん草の胡麻和えです。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、好きなやつだ。よかった。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……美味しいですよ。今日の。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（ひよりさんが自分から感想言うの、珍しいな）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ、南蛮漬け定食。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。", is_choice: false, choices: [] },
          { speaker: "", text: "箸を割る。隣でページがめくれる音がする。", is_choice: false, choices: [] },
          { speaker: "", text: "静かで、居心地がいい。", is_choice: false, choices: [] },
          { speaker: "晴", text: "そういえば、外また曇ってきましたね。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……午後から雨みたいです。傘、持ってきました。", is_choice: false, choices: [] },
          { speaker: "晴", text: "マジか。俺持ってきてないな。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……天気予報、見ないんですか。", is_choice: false, choices: [] },
          { speaker: "晴", text: "見るけど、忘れるんですよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ふふ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（笑った。ちょっと笑った。いいな、あの感じ）", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s1",
      },
      // --- Scene 1: 新しい客 ---
      // 前提: 穏やかな昼。二人が食べている
      // 変化: 若い女性の新規客が来店。店主が嬉しそうに応対する
      // 結果: ひよりが少し無口になる（晴は気づかない）
      {
        id: "ch6_s1",
        lines: [
          { speaker: "", text: "引き戸が開いた。見たことのない人だ。", is_choice: false, choices: [] },
          { speaker: "", text: "若い女性。キョロキョロしながら入ってくる。初めてらしい。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい！ どこでも好きなとこ座ってね。", is_choice: false, choices: [] },
          { speaker: "", text: "女性はテーブル席に座った。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日は鶏の南蛮漬けだよ。日替わり一種類なんだけど、大丈夫？", is_choice: false, choices: [] },
          { speaker: "", text: "「はい、それで」と女性が答える。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ。ちょっと待っててね。", is_choice: false, choices: [] },
          { speaker: "", text: "店主が嬉しそうに厨房に戻る。新しい客が来るのが本当に嬉しいんだろう。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（初めての人か。ここ、分かりにくいのによく見つけたな）", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんが文庫本に目を落とした。さっきより少し深く。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいどうぞ。南蛮漬け定食ね。", is_choice: false, choices: [] },
          { speaker: "", text: "女性が食べ始める。しばらくして——", is_choice: false, choices: [] },
          { speaker: "", text: "「あの、ご飯のおかわりってできますか？」", is_choice: false, choices: [] },
          { speaker: "丸山", text: "もちろん！ いくらでもどうぞ。嬉しいねえ、たくさん食べてくれる人は。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（おかわりできたんだ。知らなかった）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はい、ご飯。南蛮漬け、お口に合った？", is_choice: false, choices: [] },
          { speaker: "", text: "「すごく美味しいです」と女性が笑う。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ほんと？ よかったあ。味付け変えたんだよね、最近。ちょっと甘めにしてさ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（店主、めちゃくちゃ嬉しそうだな。新規のお客さんにはしゃいでる）", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s2",
      },
      // --- Scene 2: 帰り際 ---
      // 前提: 店主が新規客と楽しそうに話している
      // 変化: ひよりがいつもより静かに帰る。晴は何も気づかない
      // 結果: ひよりの中に小さな不安の種が芽生えた（読者だけが感じ取る）
      {
        id: "ch6_s2",
        lines: [
          { speaker: "", text: "隣を見ると、ひよりさんはもう食べ終わっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "文庫本を閉じている。でも鞄にしまわない。ただ手元に置いている。", is_choice: false, choices: [] },
          { speaker: "晴", text: "早いですね、今日。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……そうですか。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あれ、素っ気ない。いつもならもうちょっと……）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（まあ、そういう日もあるか）", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど！ あ、そうだ、来週ね、メンチカツやろうと思ってるんだよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんが出ていく。引き戸が静かに閉まった。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもより少しだけ早い「ごちそうさま」だった気がする。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日はなんか静かだったねえ、あの子。", is_choice: false, choices: [] },
          { speaker: "晴", text: "そうですか？ いつも静かじゃないですか。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "うーん、そうなんだけどさ。微妙に違うんだよねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（店主のほうが分かるのか。まあ、毎日見てるもんな）", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。あ、傘持ってる？ 降りそうだよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "……持ってないです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ダメだねえ。ほら、ビニール傘あるから貸したげる。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、すみません。ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "", text: "外に出ると、空が暗い。もうすぐ降る。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんの姿はもうない。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あの人は傘、持ってきてたっけ。……持ってきてたって、言ってたか）", is_choice: false, choices: [] },
          { speaker: "", text: "別に何もない昼だった。いつもと同じ。——たぶん。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
