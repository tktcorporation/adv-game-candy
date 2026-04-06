// ============================================================
// 第九章: ただいま
// ============================================================
//
// あらすじ:
//   5日目。今日も来ないだろうと思いながら灯に来る。
//   食べ始めたところで、引き戸が開く。ひよりが立っている。
//   少し疲れた顔。「こんにちは」。席に向かう。
//   一瞬迷って——晴の隣に座る。自分から。
//   晴が「おかえり」と言おうとして言えなくて、
//   「今日、鶏の照り焼きですよ」と言う。
//   ひよりが小さく笑う。口元だけ。
//   食べ終わる頃、ひよりが「……美味しいね」と言う。
//   敬語ではなく。晴に向けて。
//   店主が奥で嬉しそうに何か呟いている。
//
// 登場キャラ: 椎名ひより
// キーイベント:
//   - ひよりが自分から隣に座る（自分の意思で選ぶ）
//   - 「美味しいね」が敬語ではない初めての言葉（天丼フレーズの昇華）
//   - 晴が「おかえり」を言えず「鶏の照り焼きですよ」で迎える（不器用さ）
//   - 店主の鼻歌がエピローグ
//   - ラスト: 「この席が、二人の場所になった」的な余韻
//
// --- 章の状態差分 ---
// 開始状態: ひより不在4日目。晴は感情を自覚している
// 終了状態: ひよりが戻った。隣の席が「二人の場所」になった
//   晴の変化: 不器用ながらも、気持ちを行動で示せるようになった
//   関係性: ひより（隣の席が定位置。敬語の壁が一枚外れた）
// ============================================================

/// Chapter 9: ただいま
pub fn get_chapter_9() -> Chapter {
  {
    id: 9,
    title: "第九章",
    subtitle: "ただいま",
    unlock_player_level: 35,
    scenes: [
      // --- Scene 0: 5日目 ---
      // 前提: 5日目。期待を持たないようにして灯に来る
      // 変化: 今日も来ないだろうと思いながら食べ始める
      // 結果: 諦めに近い気持ちで定食を食べている
      {
        id: "ch9_s0",
        lines: [
          { speaker: "", text: "5日目。", is_choice: false, choices: [] },
          { speaker: "", text: "灯の前で足が止まる。引き戸の向こうに、いつもの光がある。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……行くか）", is_choice: false, choices: [] },
          { speaker: "", text: "今日も来ないだろう。分かっている。分かっているけど、ここに来ないという選択肢はなかった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。今日は鶏の照り焼きだよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いいですね。", is_choice: false, choices: [] },
          { speaker: "", text: "席に座る。隣は空いている。5日目。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ、照り焼き定食。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。", is_choice: false, choices: [] },
          { speaker: "", text: "箸を割る。鶏を一切れ、口に運ぶ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……美味い。今日はちゃんと味がする）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "どう？ 今日の照り焼き。タレ、いい感じでしょ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "美味いです。昨日のより好きかも。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "おっ、嬉しいこと言ってくれるねえ。", is_choice: false, choices: [] },
          { speaker: "", text: "隣の席は見ないようにした。見ると考えてしまうから。", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s1",
      },
      // --- Scene 1: 引き戸 ---
      // 前提: 晴が食べている途中
      // 変化: 引き戸が開く。ひよりが立っている
      // 結果: ひよりが自分から晴の隣に座る
      {
        id: "ch9_s1",
        lines: [
          { speaker: "", text: "——引き戸が、開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "風が入ってくる。昼の光。入り口に、人が立っている。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……え）", is_choice: false, choices: [] },
          { speaker: "", text: "長い髪。カーディガン。トートバッグ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……こんにちは。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんだった。", is_choice: false, choices: [] },
          { speaker: "", text: "少し疲れた顔をしている。でも、いつもの穏やかな目。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "おお！ いらっしゃい。久しぶりだね。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……すみません。少し、お休みしてました。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いいんだよ、いいんだよ。来てくれただけで嬉しい。今日は鶏の照り焼きだよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……日替わりで。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんがカウンターに歩いてくる。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（隣か、一つ空けた向こうか——）", is_choice: false, choices: [] },
          { speaker: "", text: "一瞬、足が止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "——隣に座った。晴の、すぐ隣に。自分から。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……っ）", is_choice: false, choices: [] },
          { speaker: "", text: "心臓が跳ねた。箸を持つ手が止まる。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（おかえり——いや、違う、何て言えば）", is_choice: false, choices: [] },
          { speaker: "晴", text: "今日、鶏の照り焼きですよ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（何言ってんだ俺。そんなの今店主が言ったばっかりだろ）", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんが、ほんの少し——口元を緩めた。", is_choice: false, choices: [] },
          { speaker: "", text: "笑った。小さく、本当に小さく。", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s2",
      },
      // --- Scene 2: 隣で食べる ---
      // 前提: ひよりが隣に座った。定食が来る
      // 変化: 5日ぶりの隣。同じ定食を並んで食べる
      // 結果: 言葉は少ないが、二人の間に安堵が満ちている
      {
        id: "ch9_s2",
        lines: [
          { speaker: "丸山", text: "はいよ、照り焼き定食。お待たせ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……いただきます。", is_choice: false, choices: [] },
          { speaker: "", text: "小さく手を合わせて、箸を取る。いつもの仕草。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……いる。隣に、いる。五日ぶりに）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "二人揃って照り焼きだね。いいねえ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（さっきより美味い。同じ定食なのにな）", is_choice: false, choices: [] },
          { speaker: "晴", text: "小鉢、今日はひじきですね。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。", is_choice: false, choices: [] },
          { speaker: "晴", text: "味噌汁、豆腐多めです。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……そうですね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（何を報告してるんだ。メニューの実況か）", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんが鶏を一切れ食べて、少し目を細めた。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "久しぶりの灯メシ、どう？", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……美味しいです。すごく。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "そりゃよかった。いつでもおいで。ここはどこにも行かないからさ。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。", is_choice: false, choices: [] },
          { speaker: "", text: "静かに食べる。箸の音。味噌汁の湯気。店主の鼻歌。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（何も特別なことはない。ただ隣で同じもの食べてるだけ。……それが、こんなにいい）", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s3",
      },
      // --- Scene 3: 美味しいね ---
      // 前提: 食べ終わりに近い。穏やかな空気
      // 変化: ひよりが「美味しいね」と敬語ではなく言う
      // 結果: 二人の場所が確定する。物語の着地点
      {
        id: "ch9_s3",
        lines: [
          { speaker: "丸山", text: "そろそろ食べ終わり？ お茶入れようか。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、いいんですか。ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……私も、お願いします。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさんが最後の一口を食べて、箸を置いた。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……美味しいね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "——え。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（敬語じゃない。「美味しかったです」でも「美味しいです」でもなく——）", is_choice: false, choices: [] },
          { speaker: "", text: "ただ、「美味しいね」と。晴に向けて。", is_choice: false, choices: [] },
          { speaker: "", text: "ひよりさん自身、言ってから少し驚いたような顔をした。でも、訂正しなかった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（それしか言えなかった。でも、それで十分だった）", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。お二人さん。", is_choice: false, choices: [] },
          { speaker: "", text: "今日は「お二人さん」に、何も思わなかった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "じゃあ、また明日。", is_choice: false, choices: [] },
          { speaker: "ひより", text: "……はい。また明日。", is_choice: false, choices: [] },
          { speaker: "", text: "外に出る。午後の光。路地の風。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（振り返らなくていい。明日もあの席にいる）", is_choice: false, choices: [] },
          { speaker: "", text: "店の中から、店主の鼻歌が聞こえる。いつもより少し上機嫌な気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター8席。そのうちの2つが、いつの間にか——二人の場所になっていた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
