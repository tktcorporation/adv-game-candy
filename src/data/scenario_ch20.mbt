// ============================================================
// 第二十章: 普通でもいいから
// ============================================================
//
// あらすじ:
//   閉店間際。佐倉が帰ろうとする。主人公が呼び止める。
//   「桐谷さんとは何もない」。佐倉「……聞いてない」。
//   「聞いてなくても言う」。
//   そして核心の告白——「普通でもいいから、明日も来てよ」。
//   佐倉「……バカ。普通じゃなかったら来ないけど」。
//   ドアに向かう。止まる。少し振り返る。
//   「……明日、ちょっと早く来るから」——彼女が初めて自分から約束する。
//   マフラーに隠れた、小さな笑顔。
//
// 登場キャラ: 佐倉美月（メイン）、天野蓮（冒頭のみ）
// キーイベント:
//   - 主人公が佐倉を呼び止める
//   - 桐谷との誤解の解消
//   - 核心の告白: 「普通でもいいから、明日も来てよ」
//   - 佐倉の返し: 「バカ」「明日、ちょっと早く来るから」
//   - 佐倉が初めて自分から「行く」と宣言する
//
// --- 章の状態差分 ---
// 開始状態: ch19で主人公が動く決意をした。
//   佐倉はまだ窓際席。距離は離れたまま。
//   天野が早めにシフトに来ている（見守り体制）。
// 終了状態: 誤解が解けた。告白に近い言葉を交わした。
//   主人公の変化: 自分の言葉で、自分として佐倉に向き合った
//   店の変化: なし
//   関係性: 佐倉（距離が戻る予兆。「明日早く来る」= 彼女からの初めてのコミット）
//           天野（裏方として見守り完了。出番を控える）
// ============================================================

/// Chapter 20: 普通でもいいから — CLIMAX
///
/// 背景: 物語のクライマックス。22章すべてがこの瞬間のために存在する。
/// 告白は「好き」ではなく「明日も来てよ」——この二人らしい距離感。
/// 佐倉の「バカ」は彼女にとっての最大級の感情表現。
/// 「明日、ちょっと早く来るから」が佐倉からの初めてのアクション。
/// これまでずっと「来る側」だった佐倉が、初めて「来る」と宣言する。
/// 派手な演出はいらない。静かに、確実に、距離が変わる瞬間。
pub fn get_chapter_20() -> Chapter {
  {
    id: 20,
    title: "第二十章",
    subtitle: "普通でもいいから",
    unlock_revenue: 40000,
    unlock_recipes: 46,
    unlock_customers: 8,
    unlock_intimacy: 3800,
    scenes: [
      // --- Scene 0: 今日こそ ---
      // 前提: ch19の翌日。主人公は昨夜決意した。
      //   天野が約束通り早めにシフトに来ている。
      //   開店前の準備。主人公の緊張。
      // 変化: 天野が空気を読んで、余計なことを言わない。
      //   珍しくまっすぐ応援する。
      // 結果: 開店。佐倉を待つ。
      {
        id: "ch20_s0",
        lines: [
          { speaker: "", text: "朝。いつもより早く店に来た。", is_choice: false, choices: [] },
          { speaker: "", text: "豆を挽く。湯を沸かす。カップを並べる。", is_choice: false, choices: [] },
          { speaker: "", text: "全部いつもと同じ。なのに、手が少し震えている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おはようございまーす。……今日も早いっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おはよう。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がエプロンを着けながら、こっちをちらりと見た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……緊張してるっすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "してない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "カップ三回並べ直してるっすよ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野はそれ以上何も言わなかった。茶化さなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "黙ってミルクの準備を始めた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……今日、閉店間際に佐倉さんと話す時間、もらっていいか。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が少し笑った。嬉しそうな、安心したような顔。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "片付けはあたしがやるんで。気にしないでください。", is_choice: false, choices: [] },
          { speaker: "", text: "看板を「OPEN」にする。", is_choice: false, choices: [] },
          { speaker: "", text: "——待つ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch20_s1",
      },
      // --- Scene 1: いつもの午後 ---
      // 前提: 午後。佐倉がいつもの時間に来る。
      //   窓際席。いつもと同じパターン。
      //   主人公はタイミングを計っている。
      //   天野は裏方に徹している。
      // 変化: 佐倉の滞在中、主人公は普通に仕事をする。
      //   でも佐倉を意識している。
      //   佐倉もどこか落ち着かない（窓の外を見ている時間が長い）。
      // 結果: 閉店時間が近づく
      {
        id: "ch20_s1",
        lines: [
          { speaker: "", text: "午後。カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが入ってきた。窓際の席に向かう。ここ数日と同じ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いらっしゃい。", is_choice: false, choices: [] },
          { speaker: "", text: "小さく頷くだけ。目は合わない。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れて、窓際の席に運ぶ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ありがとう。", is_choice: false, choices: [] },
          { speaker: "", text: "文庫本を開く。ページは進まない。窓の外を見ている時間のほうが長い。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの中で、手を動かし続ける。グラスを拭く。豆を計量する。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長、そのグラスもう5回拭いてるっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……黙ってろ。", is_choice: false, choices: [] },
          { speaker: "", text: "時間が過ぎる。他の客が帰り、また来て、また帰る。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんだけが、窓際にいる。", is_choice: false, choices: [] },
          { speaker: "", text: "——閉店30分前。佐倉さんが文庫本を閉じた。", is_choice: false, choices: [] },
          { speaker: "", text: "鞄に手を伸ばす。帰る仕草。", is_choice: false, choices: [] },
          { speaker: "", text: "——今だ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch20_s2",
      },
      // --- Scene 2: 呼び止める ---
      // 前提: 佐倉が帰ろうとしている。閉店間際。
      //   天野はさりげなく裏に引っ込んでいる。
      //   店内に他の客はいない。
      // 変化: 主人公が佐倉を呼び止める。
      //   桐谷との誤解を解く。佐倉は聞きたくないふりをする。
      //   でも足は止まっている。
      // 結果: 誤解が解ける。でもまだ核心には触れていない。
      {
        id: "ch20_s2",
        lines: [
          { speaker: "主人公", text: "佐倉さん。", is_choice: false, choices: [] },
          { speaker: "", text: "声が出た。思ったより大きかった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの手が止まった。鞄の持ち手を握ったまま。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……何。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ちょっと——時間、もらえますか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……用事があるから。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "すぐ終わる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは少しの間動かなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "それから、鞄を膝の上に戻した。", is_choice: false, choices: [] },
          { speaker: "", text: "座り直す。窓際の席のまま、こちらを見ない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、聞いている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "桐谷さんとは、何もない。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの肩が、ほんの少し動いた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……聞いてない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "聞いてなくても言う。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターを出た。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの席に近づく。近すぎない距離で立ち止まる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あの日、駅前で桐谷さんと会ってた。仕事の相談を受けてた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "キャリアの悩みがあるって。それだけ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に、誰と会おうと。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。そうだと思う。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんには関係ない話だし、俺がわざわざ言うことでもない。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも——言わなかったのが、ダメだったんだと思う。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの指が、テーブルの上で少し動いた。", is_choice: false, choices: [] },
          { speaker: "", text: "カップの縁をなぞる——いつもの仕草。", is_choice: false, choices: [] },
          { speaker: "", text: "ただし、カップはもう空だ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch20_s3",
      },
      // --- Scene 3: 告白 ---
      // 前提: 誤解は解けた。でも主人公が言いたいのはそこじゃない。
      //   佐倉は窓際に座ったまま。こちらを見ていない。
      //   でも空のカップの縁をなぞっている——聞いている証拠。
      // 変化: 主人公がカフェの店長としてではなく、自分自身として言葉を出す。
      //   「普通でもいいから、明日も来てよ」——この一言がすべて。
      //   佐倉の返し。「バカ」。そして「明日、ちょっと早く来るから」。
      // 結果: 言葉がやっと距離に追いつく。関係が動く。
      {
        id: "ch20_s3",
        lines: [
          { speaker: "主人公", text: "……俺は——", is_choice: false, choices: [] },
          { speaker: "", text: "言葉を探す。", is_choice: false, choices: [] },
          { speaker: "", text: "気の利いた台詞なんか出てこない。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーの知識も、メニュー開発の経験も、ここでは何の役にも立たない。", is_choice: false, choices: [] },
          { speaker: "", text: "ただ、思ったことを言うしかない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんがカウンターに座らなくなって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "30分で帰るようになって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「ごちそうさま」の声が小さくなって。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの肩が、少し強張った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "——俺、すごく嫌だった。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "沈黙。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外で、風が街路樹を揺らしている。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……それは。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの声が小さい。窓の方を向いたまま。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……客が減ったら困るから？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "違う。", is_choice: false, choices: [] },
          { speaker: "", text: "即答だった。自分でも驚くくらい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "客が減ったとか、売上がどうとか、そういうのじゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんが——佐倉さんが、いないのが嫌だったんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの指が止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "カップの縁から離れて、テーブルの上に置かれた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うまいコーヒーが淹れられるようになれば、何か変わると思ってた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんに「美味しい」って言ってもらえたら、それでいいと思ってた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも——たぶん、そうじゃなかった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "コーヒーの向こう側に、俺がいなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、ゆっくりとこちらを向いた。", is_choice: false, choices: [] },
          { speaker: "", text: "——目が合った。何日ぶりだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の瞳が、少し潤んでいるように見えたのは、夕陽のせいかもしれない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "普通でもいいから——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "明日も来てよ。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "長い沈黙だった。", is_choice: false, choices: [] },
          { speaker: "", text: "たぶん数秒。でも、もっと長く感じた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは目を逸らした。窓の外に——いや、どこも見ていない。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……バカ。", is_choice: false, choices: [] },
          { speaker: "", text: "小さい声だった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "普通じゃなかったら来ないけど。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "「普通」。いつもの単語。", is_choice: false, choices: [] },
          { speaker: "", text: "でも今の「普通」は、今までの「普通」と全然違った。", is_choice: false, choices: [] },
        ],
        next_scene: "ch20_s4",
      },
      // --- Scene 4: 明日 ---
      // 前提: 告白の直後。空気が変わった。
      //   佐倉が立ち上がる。帰る。
      //   でも、いつもと違うことが起きる。
      // 変化: 佐倉がドアの前で立ち止まる。振り返る。
      //   初めて、自分から「明日行く」と宣言する。
      //   それは佐倉にとっての、最大限のアクション。
      // 結果: 二人の関係が、静かに、確実に動いた。
      {
        id: "ch20_s4",
        lines: [
          { speaker: "", text: "佐倉さんが立ち上がった。", is_choice: false, choices: [] },
          { speaker: "", text: "鞄を持つ。文庫本をしまう。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの仕草。いつもの動き。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの言葉。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、声がさっきより少しだけ大きかった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがドアに向かって歩く。", is_choice: false, choices: [] },
          { speaker: "", text: "背中を見る。栗色の髪。白いニット。マフラーに顔を半分埋めて。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアノブに手をかけて——", is_choice: false, choices: [] },
          { speaker: "", text: "止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "少しだけ、振り返った。", is_choice: false, choices: [] },
          { speaker: "", text: "マフラーの上から覗く目が、ほんの一瞬だけこちらを見て——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……明日、ちょっと早く来るから。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが閉まった。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "——「ちょっと早く来る」。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはいつも「来ている」側だった。", is_choice: false, choices: [] },
          { speaker: "", text: "聞かれれば「別に」と言い、理由を求められれば「普通に」と返す。", is_choice: false, choices: [] },
          { speaker: "", text: "自分から「行く」とは一度も言わなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "——初めてだ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、自分から来ると言った。", is_choice: false, choices: [] },
          { speaker: "", text: "マフラーの下で、笑っていた気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "気がするだけかもしれない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……明日か。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの端の席を見る。", is_choice: false, choices: [] },
          { speaker: "", text: "明日、あの席に戻ってくるだろうか。", is_choice: false, choices: [] },
          { speaker: "", text: "——分からない。でも、待てる。", is_choice: false, choices: [] },
          { speaker: "", text: "「ちょっと早く来る」のなら、「ちょっと早く」コーヒーを準備しておこう。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの配合。いつもの温度。", is_choice: false, choices: [] },
          { speaker: "", text: "——レシピは、変えない。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
