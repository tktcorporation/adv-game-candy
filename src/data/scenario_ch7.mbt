// ============================================================
// 第七章: 雨の日
// ============================================================
//
// あらすじ:
//   雨の日。客が誰も来ない。佐倉だけが来る。いつもと同じように。
//   二人きりの静かなカフェ。会話は少ないが、空気が柔らかい。
//   佐倉はいつもより長く居座る。「普通」と矛盾する行動。
//   天野が遅れて到着し「2人きりだったの？」と茶化す。
//   佐倉の即答が逆に何かを暴露してしまう——本人は気づいていない。
//
// 登場キャラ: 佐倉美月、天野蓮
// キーイベント:
//   - 雨でも来る佐倉（「別に。傘あるし」）
//   - 二人きりの沈黙が心地よい
//   - 佐倉がいつもより長く居座る（行動が「普通」を裏切る）
//   - 天野の「2人きりだったの？ 邪魔した？」→ 佐倉の即答
//   - カウンター寄りの席に座っている（窓際ではない）
//
// --- 章の状態差分 ---
// 開始状態: 商店街掃除(ch6)を経て、カフェ外でも全員で行動した。
//   佐倉はカウンター寄りの席に移動済み（本人は「窓際は雨だと湿気る」等の理由）。
//   主人公は佐倉を「無反応だけど毎日来る不思議な常連」と認識。
// 終了状態: 雨の日に二人きりで過ごした記憶が残った。
//   主人公の変化: 佐倉と二人きりでも居心地がいいと気づいた
//   店の変化: なし
//   関係性: 佐倉（行動が言葉を裏切り始める。「普通」なのにいつもより長くいる）
//           天野（二人の関係を外側から可視化する装置として機能）
// ============================================================

/// Chapter 7: 雨の日
///
/// 背景: 承前半の感情的転換点。佐倉の「無反応」が行動レベルで崩れ始める章。
/// コメディは控えめにし、二人きりの空気感を丁寧に描く。
/// 天野の登場で空気が変わり、佐倉の即答が「何かある」ことを暴露する。
pub fn get_chapter_7() -> Chapter {
  {
    id: 7,
    title: "第七章",
    subtitle: "雨の日",
    unlock_revenue: 14000,
    unlock_recipes: 20,
    unlock_customers: 5,
    unlock_intimacy: 1200,
    scenes: [
      // --- Scene 0: 雨の朝 ---
      // 前提: 朝。外は雨。主人公がカフェを開ける。
      //   場所: 月灯り（開店準備中）
      //   時間: 朝
      //   知識: 新メニュー開発(ch5)、商店街掃除(ch6)を経て、常連との距離が縮まった。
      //   佐倉はカウンター寄りの席に座るようになっている。
      // 変化: 雨で客が来ない。一人で過ごす静かな午前。
      // 結果: 「今日は誰も来ないかもな」と思い始める
      {
        id: "ch7_s0",
        lines: [
          { speaker: "", text: "朝から雨だった。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外、商店街のアスファルトが黒く光っている。", is_choice: false, choices: [] },
          { speaker: "", text: "傘をさす人もまばら。いつもの朝とは違う、静かな空気。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……こういう日は、客来ないだろうなあ。", is_choice: false, choices: [] },
          { speaker: "", text: "開店準備をしながら、雨音に耳を傾ける。", is_choice: false, choices: [] },
          { speaker: "", text: "豆を挽く。お湯を沸かす。カウンターを拭く。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの手順。でも、雨の日は音がよく響く。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、たまにはこういう日もいいか。", is_choice: false, choices: [] },
          { speaker: "", text: "看板を「OPEN」にして、カウンターの中に戻る。", is_choice: false, choices: [] },
          { speaker: "", text: "午前中——客、ゼロ。", is_choice: false, choices: [] },
          { speaker: "", text: "開店初日を思い出す。あの時も午前中ゼロだった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "さすがにこの雨じゃな。", is_choice: false, choices: [] },
          { speaker: "", text: "スマホをいじる。天気予報は終日雨。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野は今日バイト休みだし。神崎さんは家でも仕事できるし。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今日は一人かな。", is_choice: false, choices: [] },
          { speaker: "", text: "そう思った、午後——", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s1",
      },
      // --- Scene 1: 佐倉、来る ---
      // 前提: 午前中、客ゼロ。午後になった。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後
      //   知識: 佐倉は「ほぼ毎日。午後。雨でも来る」（characters.mbt参照）
      //   佐倉はカウンター寄りの席に座るようになっている。
      // 変化: 雨の中、佐倉が来る。「別に。傘あるし」。いつもと同じように座る。
      //   主人公は少しだけ嬉しい（自覚なし）
      // 結果: 二人きりの時間が始まる
      {
        id: "ch7_s1",
        lines: [
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが開いた。雨の匂いが入ってくる。", is_choice: false, choices: [] },
          { speaker: "", text: "濡れた傘を畳みながら、佐倉さんが入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "マフラーの端が少し濡れている。でも、本はちゃんとビニール袋に入れてある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いらっしゃい。", is_choice: false, choices: [] },
          { speaker: "", text: "つい、笑ってしまった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……何。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、この雨の中よく来るなって。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。傘あるし。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは傘立てに傘を置いて、いつものカウンター寄りの席に座った。", is_choice: false, choices: [] },
          { speaker: "", text: "窓際じゃなくて、カウンター寄り。最近はずっとこっちだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "コーヒー？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもは「コーヒーを」と言うのに、今日は「うん」だった。", is_choice: false, choices: [] },
          { speaker: "", text: "……なんでもないことだ。雨の日だから、少しだけ気が緩んでるだけ。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。豆を挽く音が、雨音に混じる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはまだ本を出していない。鞄の上に手を置いたまま、雨を見ている。", is_choice: false, choices: [] },
          { speaker: "", text: "カップを差し出す。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ありがとう。", is_choice: false, choices: [] },
          { speaker: "", text: "「ありがとう」。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの「ごちそうさま」とは違う。最初のひと口の前に、お礼。", is_choice: false, choices: [] },
          { speaker: "", text: "……やっぱり、雨の日は少しだけ違う。", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s2",
      },
      // --- Scene 2: 二人きりの時間 ---
      // 前提: 佐倉が来て、コーヒーを飲み始めた。他に客はいない。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後（Scene 1の直後〜数時間）
      //   知識: 佐倉は「本を読んでいるのはポーズ。実は主人公の方をチラチラ見ている」
      //   主人公はそれに気づいていない。
      // 変化: 二人きりの静かな時間。会話は少ないが、居心地がいい。
      //   佐倉が珍しくコーヒーについて話す。主人公もリラックスしている。
      //   雨音がBGM。距離が近い（カウンター寄りの席）。
      // 結果: 「二人きりでも全然気まずくない」という発見
      {
        id: "ch7_s2",
        lines: [
          { speaker: "", text: "佐倉さんがコーヒーを飲む。一口、二口。", is_choice: false, choices: [] },
          { speaker: "", text: "本を開く。けど、ページをめくるペースがいつもより遅い。", is_choice: false, choices: [] },
          { speaker: "", text: "雨音だけが店を満たしている。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの中で、グラスを磨く。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……今日、何読んでるの？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……短編集。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "面白い？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんの「普通」って、好きか嫌いかのどっちなの。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通は普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "謎が深まった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがほんの一瞬、目を細めた。笑ったのかもしれない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……おかわり、いる？", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが空のカップを見て、少し驚いた顔をした。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……もう空だった。お願い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今度は少し変えてみるよ。", is_choice: false, choices: [] },
          { speaker: "", text: "二杯目を淹れる。挽き方を少しだけ粗くした。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……粗めにした？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "分かる？ 雨の日って湿度高いから、少しだけ粗くした方がいいかなと思って。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……悪くない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "お、今日は「普通」じゃなくて「悪くない」。格上げ？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……同じ意味。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "絶対違うと思うけどな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うるさい。読めない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はいはい。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本に目を戻した。口元がほんの少し上がっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "雨音。コーヒーの香り。ページをめくる音。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……こういうの、悪くないな。)", is_choice: false, choices: [] },
          { speaker: "", text: "二人きりなのに、全然気まずくない。むしろ——落ち着く。", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s3",
      },
      // --- Scene 3: 雨と距離 ---
      // 前提: 二人きりの時間が続いている。夕方に近づく。
      //   場所: 月灯り（営業中・午後遅く）
      //   時間: 午後遅く
      //   知識: 佐倉は普段もっと早く帰る。今日は長い。
      //   主人公は佐倉の滞在時間を無意識に把握している。
      // 変化: 佐倉がいつもより長くいる。主人公がそれに気づく。
      //   佐倉が珍しく自分から話題を出す（雨の匂いについて）。
      //   距離が近い瞬間——カウンター越しのやりとり。
      // 結果: 普段の距離感から少しだけ踏み込んだ状態
      {
        id: "ch7_s3",
        lines: [
          { speaker: "", text: "時計を見ると、もう4時を過ぎていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……帰らないな。いつもなら2時間くらいなのに。)", is_choice: false, choices: [] },
          { speaker: "", text: "三杯目のコーヒーを淹れた。何も言わずにカップを差し出す。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……頼んでない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "サービス。雨の日割引。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そんな制度ない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今作った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……適当。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "経営方針はフレキシブルに。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……それ、適当って言うの。", is_choice: false, choices: [] },
          { speaker: "", text: "でもカップは受け取った。文句を言いながら飲む。いつものパターン。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……雨の日のコーヒーって、少し違う。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "味が？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……香りが。空気が湿ってるから、いつもより広がる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "へえ……。そういうの、分かるんだ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。普通のこと。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、普通の人は気づかないと思う。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……実家が、コーヒー好きだったから。それだけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だから詳しいのか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "詳しくない。……少し知ってるだけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「少し」で湿度の影響分かるの、十分詳しいと思うけど。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うるさい。二回目。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、カウントしてるんだ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……してない。", is_choice: false, choices: [] },
          { speaker: "", text: "雨が少し強くなった。窓を叩く音が変わる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが窓の外を見ている。本は閉じたまま。", is_choice: false, choices: [] },
          { speaker: "", text: "横顔が、雨越しの灰色の光に照らされている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……きれいだな。)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(——いや。灰色の光がきれいだなって話。光の話。)", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s4",
      },
      // --- Scene 4: 天野、登場 ---
      // 前提: 二人きりの時間が4時間近く続いている。雨はまだ降っている。
      //   場所: 月灯り（営業中・夕方手前）
      //   時間: 夕方手前
      //   知識: 天野は今日バイト休み。しかし何かの用事で来た。
      //   天野は佐倉と主人公の関係をいじる担当。
      // 変化: 天野が来る → 「2人きりだったの？ 邪魔した？」
      //   佐倉の即答「してない」が速すぎて逆に疑わしい
      //   空気が一変する。二人きりの静かな時間は終わり。
      //   天野が「佐倉さんいつもより長くない？」と指摘 → 佐倉が帰り支度を始める
      // 結果: 二人きりの時間の終わり。佐倉は動揺を隠してさっさと帰る。
      //   天野だけが全部分かっている。
      {
        id: "ch7_s4",
        lines: [
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "勢いよくドアが開いた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわー、びしょ濡れっす！ 傘持ってくの忘れて——", is_choice: false, choices: [] },
          { speaker: "", text: "天野がびしょ濡れで飛び込んできた。髪から雫が落ちている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今日休みだろ。何しに来たんだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "近く通ったんで雨宿りっす！ タオル貸してくださいー！", is_choice: false, choices: [] },
          { speaker: "", text: "タオルを投げる。天野がわしゃわしゃと頭を拭く。", is_choice: false, choices: [] },
          { speaker: "", text: "そして——店内を見回した。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター寄りの席に佐倉さん。カウンターの中に俺。それだけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……あれ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "2人きりだったんすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "雨だからな。今日は客が——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "へえー。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がニヤニヤしている。この顔は良くない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "邪魔した？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "してない。", is_choice: false, choices: [] },
          { speaker: "", text: "——即答。", is_choice: false, choices: [] },
          { speaker: "", text: "即答すぎた。天野も俺も、一瞬止まった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……反応はっや。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通に事実を言っただけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あーはいはい。普通普通。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がカウンターに座って、ココアを注文する。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本に目を戻した。でも、ページをめくる速度が明らかに上がっている。", is_choice: false, choices: [] },
          { speaker: "", text: "……不満がある時の癖だ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "つーか佐倉さん、今日いつもより長くないすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……雨だから。外に出たくなかっただけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でも来る時は雨の中来たんすよね？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本を閉じた。鞄に入れる。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、まだ雨——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "傘ある。", is_choice: false, choices: [] },
          { speaker: "", text: "さっさと支度して、傘を取って、ドアに向かう。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもより少しだけ——足が速い。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが閉まる。雨の音が遠くなる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……ぷっ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……何笑ってんだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いやあ、なんでもないっす。なんでも。", is_choice: false, choices: [] },
          { speaker: "", text: "ココアを飲みながら、天野はずっとニヤニヤしていた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長って、マジで鈍いっすよね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "は？ 何が。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんでもないっすー。", is_choice: false, choices: [] },
          { speaker: "", text: "絶対なんでもないことはない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、追及する前に天野はココアを飲み干して帰っていった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch7_s5",
      },
      // --- Scene 5: 閉店後 ---
      // 前提: 天野も帰った。閉店作業中。
      //   場所: 月灯り（閉店後）
      //   時間: 夕方〜夜
      //   知識: 二人きりの時間が心地よかったこと。佐倉の即答。天野の「鈍い」発言。
      //   主人公はまだ何も自覚していない。
      // 変化: 閉店作業をしながら今日を振り返る。
      //   佐倉のカップを洗う時、三杯分だったと気づく。
      //   「雨の日も来るんだな」——それが嬉しかったことに、なんとなく気づく。
      // 結果: 明確な自覚はないが、佐倉の存在が特別になり始めている
      {
        id: "ch7_s5",
        lines: [
          { speaker: "", text: "閉店。雨はまだ降っている。少し弱くなったかもしれない。", is_choice: false, choices: [] },
          { speaker: "", text: "カップを洗う。佐倉さんの分、三杯。天野の分、一杯。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……今日の売上、二人分か。まあ雨だし。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんのカップを棚に戻す。白いカップ。シンプル。佐倉さんっぽい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野が言った「鈍い」って、何のことだ？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんの即答もよく分からなかったし。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあいいか。分かっていることは一つだけだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "雨の日でも、佐倉さんは来る。それが——なんか嬉しかった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……明日は晴れるといいな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、雨でも……悪くなかったけど。", is_choice: false, choices: [] },
          { speaker: "", text: "雨音が窓を叩いている。今日の残り香みたいに、静かに。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
