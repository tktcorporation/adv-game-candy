// ============================================================
// 第九章: 白い看板
// ============================================================
//
// あらすじ:
//   カフェの隣にチェーンコーヒー店「Cafe BLANC」がオープンする。
//   スタッフの桐谷楓が挨拶に来る。礼儀正しくて感じがいい。ちょっと天然。
//   佐倉のカップ音がいつもより大きい（微妙な動揺）。
//   天野が「あの人感じいいね」と素直に言い、佐倉が無言になる。
//   三角関係のような緊張の最初のヒント——ただし実際には恋愛感情はない。
//   佐倉の不安は「自分の居場所が脅かされる」不安。
//
// 登場キャラ: 佐倉美月、天野蓮、桐谷楓（初登場）
// キーイベント:
//   - Cafe BLANCオープン（チェーン店が隣に来た）
//   - 桐谷楓の初登場（有能・礼儀正しい・天然）
//   - 佐倉のカップ音が強い（言葉にならない動揺）
//   - 天野「あの人感じいいね」→ 佐倉の沈黙
//   - 最初の三角関係的テンション（実際は佐倉の不安）
//
// --- 章の状態差分 ---
// 開始状態: 学園祭(ch8)でカフェ外でも一緒に過ごした。
//   佐倉はカウンター寄りの席。主人公との距離が少しずつ縮んでいる。
//   店の経営は安定期。常連が定着している。
// 終了状態: チェーン店が隣にオープン。桐谷楓という新キャラが登場。
//   主人公の変化: 経営的な危機感 + 桐谷の人柄に好印象
//   店の変化: 競合出現。経営への影響はまだ不明。
//   関係性: 桐谷（初対面。好印象。「競合だけど悪い人じゃない」）
//           佐倉（桐谷の存在に無意識に反応。言葉にはしないがカップ音で表現）
//           天野（状況を素直に観察。佐倉の変化に気づき始める）
// ============================================================

/// Chapter 9: 白い看板
///
/// 背景: 承前半の最終章。桐谷楓を導入し、ch10以降の承後半（三角テンション）への
/// 布石を打つ。佐倉の「居場所の不安」を、桐谷という外部刺激で可視化する。
/// 桐谷は好感の持てるキャラとして描く（「嫌な敵」にしない）。
/// 佐倉の嫉妬は微細で、本人も自覚していないレベル。
pub fn get_chapter_9() -> Chapter {
  {
    id: 9,
    title: "第九章",
    subtitle: "白い看板",
    unlock_revenue: 18000,
    unlock_recipes: 24,
    unlock_customers: 6,
    unlock_intimacy: 1600,
    scenes: [
      // --- Scene 0: 白い看板 ---
      // 前提: 学園祭(ch8)から数日後。いつもの朝。
      //   場所: 月灯り（開店前）→ 隣の空き店舗
      //   時間: 朝
      //   知識: 隣の店舗はしばらく空いていた。主人公は気にしていなかった。
      // 変化: 朝来たら隣に真っ白な看板が設置されている。「Cafe BLANC」。
      //   チェーン店だと分かる。主人公に経営的な危機感が芽生える。
      // 結果: 競合の出現を認識した状態
      {
        id: "ch9_s0",
        lines: [
          { speaker: "", text: "朝。店に向かう途中で、足が止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "隣の空き店舗に看板が出ていた。真っ白。洗練されたロゴ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「Cafe BLANC」……カフェ？ 隣に？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "チェーン店じゃん。あの駅前にもあるやつ。", is_choice: false, choices: [] },
          { speaker: "", text: "覗き込むと、白を基調としたきれいな店内が見える。内装工事の仕上げ中。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……マジか。資本力が違いすぎる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "メニューも豊富だろうし、宣伝力も段違いだし。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いや。考えてもしょうがない。今日も開けるか。", is_choice: false, choices: [] },
          { speaker: "", text: "看板を「OPEN」にする。隣の白い看板が、朝日を受けて眩しかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s1",
      },
      // --- Scene 1: 常連の反応 ---
      // 前提: Cafe BLANCの看板が出た日。午後の営業中。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後
      //   知識: 佐倉はカウンター寄りの席。天野はバイト中。
      //   佐倉と天野はまだCafe BLANCのことを知らない（はず）。
      // 変化: 天野が「隣にカフェできるんすね」と話題に出す。
      //   佐倉の反応がいつもと違う——本のページをめくるのが止まる。
      //   主人公は経営の不安を口にする。佐倉が珍しくフォローっぽいことを言う。
      // 結果: 全員がCafe BLANCの存在を認識した状態
      {
        id: "ch9_s1",
        lines: [
          { speaker: "", text: "午後。天野がバイトに来た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長！ 隣にカフェできるんすね！ 看板出てたっすよ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……知ってる。朝見た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "Cafe BLANCって、あのチェーンっすよね？ 駅前にもあるやつ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そうみたいだな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわー、大丈夫すか？ 客取られたりしません？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……あんまり大声で言わないでくれ。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター寄りの席で、佐倉さんが本を読んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "——いや。ページをめくる手が止まっている。", is_choice: false, choices: [] },
          { speaker: "", text: "聞いているのだろう。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "まあ、うちはうちの良さがあるっすから！ 味で勝負っす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "お前いい子だな……。でも現実問題、チェーンの資本力には——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーの味は、規模と関係ない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、本から目を上げずに言った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……佐倉さん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。一般論。", is_choice: false, choices: [] },
          { speaker: "", text: "本に目を戻す。でも、ページはめくらない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんに褒められてるっすよ、店長。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……褒めてない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はいはい、一般論っすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも実際、チェーン店の方が安くて早いだろ。品質も安定してるし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、あたしはここのが好きっすけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "お前はバイトだからだろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "失礼な！ 本心っすよ！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……安くて早いのが良ければ、コンビニで十分。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それも一般論？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そう。一般論。", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s2",
      },
      // --- Scene 2: 桐谷楓 ---
      // 前提: 午後の営業中。Cafe BLANCの話題の直後。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後（Scene 1の少し後）
      //   知識: Cafe BLANCは隣にできるチェーン店。まだ開店前。
      //   桐谷楓のcharacters.mbt設定を参照。
      // 変化: 桐谷楓がカフェに挨拶に来る。礼儀正しく、感じが良く、少し天然。
      //   差し入れを持ってくる。コーヒーの香りを嗅ぐ仕草。
      //   主人公は「いい人だな」と思う。佐倉のカップ音が強くなる。
      // 結果: 桐谷と主人公が初対面。好印象。佐倉に微妙な変化。
      {
        id: "ch9_s2",
        lines: [
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "セミロングの茶髪をポニーテールにまとめた女性が入ってきた。白いシャツにエプロン。手に紙袋。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あの、すみません。隣の……Cafe BLANCの桐谷です。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "来週オープンなんですけど、ご挨拶にと思いまして。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、わざわざどうも。月灯りの——えっと、店長です。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "店長さんですね。よろしくお願いします。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あの、これ——よかったら。うちの焼き菓子なんですけど。", is_choice: false, choices: [] },
          { speaker: "", text: "紙袋を差し出される。中にマドレーヌが入っている。きちんとしたパッケージ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "えっ、いいんですか？ ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "いえ、これ余っちゃって——", is_choice: false, choices: [] },
          { speaker: "", text: "余っちゃって、と言っているが、包装がきれい。明らかにわざわざ持ってきている。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが店内を見回した。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "わあ……いい雰囲気ですね。手作り感があって。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、コーヒーの香りがすごくいい。何の豆ですか？", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーの前に必ず香りを嗅ぐ——職業病か、それとも習慣か。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今日はエチオピアのナチュラルをベースに——", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、ナチュラルですか！ フルーティーな感じ、いいですよね。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーの知識がある。当然か。プロだし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、よかったら一杯飲んでいきます？ 店長のコーヒー美味いっすよ！", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "え、いいんですか？ じゃあ……お言葉に甘えて。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに座る。佐倉さんの二つ隣。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れて出す。桐谷さんは両手でカップを受け取り、まず香りを嗅いだ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "……美味しい。丁寧に淹れてますね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "うちはチェーンなので、どうしてもマニュアル通りになっちゃうんですけど……", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "こういう手淹れの味って、いいですよね。あ、競合のこと褒めちゃダメですかね。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが困ったように首を傾げて笑った。天然だ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、全然。嬉しいです。", is_choice: false, choices: [] },
          { speaker: "", text: "——コトン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカップをソーサーに置いた音。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもより、少し——強い。", is_choice: false, choices: [] },
          { speaker: "", text: "ちらっと見る。佐倉さんは本を読んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "……ように見える。ページ、めくってないけど。", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s3",
      },
      // --- Scene 3: 桐谷と佐倉 ---
      // 前提: 桐谷がコーヒーを飲んでいる。佐倉が同じ空間にいる。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後（Scene 2の直後）
      //   知識: 桐谷は礼儀正しく、佐倉にも声をかける人。
      //   佐倉は初対面の人に壁を作るタイプ。
      // 変化: 桐谷が佐倉に話しかける。佐倉は最低限の返答。
      //   桐谷は気にしない（or 気づいていないふり）。
      //   微妙な空気感。佐倉のカップ音がまた強い。
      // 結果: 佐倉と桐谷の最初のやりとり。佐倉の微妙な壁。
      {
        id: "ch9_s3",
        lines: [
          { speaker: "桐谷楓", text: "あの、お客さんもよくいらっしゃるんですか？", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが佐倉さんの方を見て微笑んだ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "一拍、間があった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……まあ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "常連さんなんですね。素敵です。こういうお店に通ってくれる方って、貴重ですよね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……近いから来てるだけ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、ご近所なんですか？ じゃあ、うちにもぜひ来てくださいね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本に目を落とした。会話終了の合図。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんは一瞬きょとんとして——それから、穏やかに笑った。", is_choice: false, choices: [] },
          { speaker: "", text: "気にしていないのか。それとも、気づいていないふりか。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、そろそろ戻らないと。内装の最終チェックがあって。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "今日はありがとうございました、店長さん。とっても美味しかったです。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "こちらこそ。マドレーヌありがとうございます。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "また来てもいいですか？ ……あ、やっぱり競合なのにマズいですかね？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "全然。客としてならいつでも歓迎です。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "よかった。じゃあ、また。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんがお辞儀をして出ていった。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。ドアが閉まる。", is_choice: false, choices: [] },
          { speaker: "", text: "——コトン。", is_choice: false, choices: [] },
          { speaker: "", text: "また、佐倉さんのカップ音。今日二回目。", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s4",
      },
      // --- Scene 4: 天野の感想 ---
      // 前提: 桐谷が帰った直後。佐倉と天野と主人公の3人。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後（Scene 3の直後）
      //   知識: 天野は人の好意に素直。佐倉は桐谷に壁を作った。
      // 変化: 天野が「あの人感じいいね」と素直に言う。
      //   佐倉が無言になる。本のページをめくる速度が上がる。
      //   主人公は佐倉の変化に「？」と思うが追及しない。
      //   天野は何かに気づいている。
      // 結果: 佐倉の微妙な動揺が可視化された状態
      {
        id: "ch9_s4",
        lines: [
          { speaker: "天野蓮", text: "あの人、感じいいっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。礼儀正しいし、コーヒーの知識もあるし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "競合なのにわざわざ挨拶来るとか、ちゃんとした人っすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、敵って感じはしないよな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マドレーヌも美味しかったし。ね、佐倉さん？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……食べてない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "食べます？ 一個あげますよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……いらない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの声が、いつもより少しだけ硬い。", is_choice: false, choices: [] },
          { speaker: "", text: "本のページをめくる速度が上がっている。……不満のサイン。", is_choice: false, choices: [] },
          { speaker: "", text: "何に不満なんだろう。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "桐谷さんって言ったっすよね。あの人がお隣なら、仲良くやれそう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だといいけど。チェーン店は手強いぞ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でも桐谷さん、店長のコーヒー褒めてたじゃないすか。「丁寧」って。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "社交辞令かもよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いやー、あの人ガチっすよ。目が本気だったもん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そうかな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あと笑顔がめっちゃ自然じゃなかったすか？ 営業スマイルじゃないやつ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ……感じのいい人だったのは確か。", is_choice: false, choices: [] },
          { speaker: "", text: "——パタン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本を閉じた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あれ、もう帰る？ まだ1時間——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……用事思い出した。", is_choice: false, choices: [] },
          { speaker: "", text: "嘘だ。", is_choice: false, choices: [] },
          { speaker: "", text: "……と思ったけど、根拠はない。ないけど、分かる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが鞄を肩にかける。目が合わない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……また明日。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "返事なし。カランカラン。ドアが閉まった。", is_choice: false, choices: [] },
          { speaker: "", text: "……「ごちそうさま」はいつも言うのに。「また明日」には答えなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch9_s5",
      },
      // --- Scene 5: 閉店後 ---
      // 前提: 佐倉が早く帰った。閉店作業中。天野がまだいる。
      //   場所: 月灯り（閉店作業中）
      //   時間: 夕方
      //   知識: 天野は佐倉の変化に気づいている。主人公は「？」状態。
      // 変化: 天野が佐倉の変化を暗に指摘する。
      //   主人公は「何の話？」と本気で分からない。
      //   天野のため息。「店長マジで……」。
      //   窓から隣の白い看板が見える。
      // 結果: 佐倉の不安が伏線として仕込まれた状態。次章（ch10）への橋渡し。
      {
        id: "ch9_s5",
        lines: [
          { speaker: "", text: "閉店作業。天野がテーブルを拭いている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。佐倉さん、今日なんか変じゃなかったすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "変？ そうか？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "カップ置く時の音、いつもより強かったっすよ。2回も。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……気づかなかったな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "帰るのも早かったし。用事って——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "用事があったんだろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、マジで言ってます？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え、何が。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長って、ほんっとに鈍いっすよね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だから何がだよ。具体的に言ってくれ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしが言ったら意味ないんすよ。自分で気づかないと。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "禅問答か。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……まあ、桐谷さん自体はいい人っすよ。それは間違いない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でも——タイミングってあるじゃないすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "タイミング？ 何の。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんでもないっす。じゃ、お疲れっした！", is_choice: false, choices: [] },
          { speaker: "", text: "天野が帰っていった。一人で残りの片付け。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんのカップ……今日は一杯だけか。いつもより少ないな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "桐谷さんのカップはきちんと飲み干してある。感じのいい人だ。", is_choice: false, choices: [] },
          { speaker: "", text: "二つのカップを並べて棚に戻す。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野が言った「タイミング」って、何のことだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外。月灯りの古い木の看板の隣に、白くて新しい看板。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんか、嫌な予感がする。コーヒーとは関係ない何かが変わりそうな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……気のせいだといいけど。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
