// ============================================================
// 第十一章: 桐谷さんの差し入れ
// ============================================================
//
// あらすじ:
//   チェーン店の影響で客が減り始めている。数字は嘘をつかない。
//   桐谷が純粋な好意でコーヒー豆の差し入れを持ってくる。
//   佐倉が微妙にピリつく。神崎は観察してニヤニヤ。
//   桐谷と佐倉の初めての直接会話。丁寧だが緊張感がある。
//   天野「佐倉さん今日なんか怖くない？」
//
// 登場キャラ: 佐倉美月、天野蓮、桐谷楓、神崎凛
// キーイベント:
//   - 客数減少の兆候
//   - 桐谷のコーヒー豆差し入れ（純粋な好意）
//   - 佐倉のピリつき
//   - 桐谷×佐倉の初会話（丁寧だが緊張）
//   - 天野「佐倉さん今日なんか怖くない？」
//   - 神崎の観察者としての存在感
//
// --- 章の状態差分 ---
// 開始状態: ch10でチェーン店の実力を実感。佐倉の「普通」の意味を考え始めた。
//   佐倉はカウンター席。言葉は辛辣だが距離はゼロ圏。
//   桐谷とは互いに好印象。佐倉は桐谷に壁を作っている。
// 終了状態: 客数減少が現実に。桐谷の好意が佐倉を刺激。
//   主人公の変化: 経営の不安 + 桐谷への感謝 + 佐倉の変化への疑問
//   店の変化: 客数が目に見えて減っている。
//   関係性: 桐谷×佐倉の直接関係が始まった（緊張含み）
//           神崎が佐倉の嫉妬を見抜いている
//           天野が佐倉の変化を率直に指摘
// ============================================================

/// Chapter 11: 桐谷さんの差し入れ
///
/// 背景: チェーン店の影響という外圧と、桐谷という人間的脅威の二重構造。
/// 佐倉の嫉妬は「恋愛的嫉妬」ではなく「居場所の不安」が根底にある。
/// 桐谷を「嫌な敵」にしないことが重要。佐倉のピリつきは一方的なもの。
/// 神崎を観察者として配置し、読者の代弁をさせる。
pub fn get_chapter_11() -> Chapter {
  {
    id: 11,
    title: "第十一章",
    subtitle: "桐谷さんの差し入れ",
    unlock_revenue: 22000,
    unlock_recipes: 28,
    unlock_customers: 8,
    unlock_intimacy: 2000,
    scenes: [
      // --- Scene 0: 減った客 ---
      // 前提: チェーン店オープンから1週間以上経過。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後
      //   知識: 天野がレジの売上を把握している。主人公も薄々気づいている。
      // 変化: 客が減っている。天野が数字を報告する。主人公は平静を装う。
      //   佐倉はいつも通りカウンター席にいる。変わらない。
      // 結果: 経営への影響が具体的な数字で示される
      {
        id: "ch11_s0",
        lines: [
          { speaker: "", text: "午後。店内に客は二人。佐倉さんと、窓際のおじいさん。", is_choice: false, choices: [] },
          { speaker: "", text: "先週の同じ曜日は五人いた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。ちょっといいっすか。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がレジの横で声をひそめる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "今週の売上、先週より二割落ちてるっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……知ってる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やっぱ気づいてたっすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "午前中がごっそり減った。BLANC、モーニングセットが380円だからな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "380円！？ うちの原価とほぼ同じじゃないすか！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "チェーンの仕入れ力だよ。大量発注で単価が違う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……大丈夫っすか？ お店。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "すぐどうこうはないけど。このペースが続くと考えないといけない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしのバイト代削ってもいいっすよ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "削らないよ。……まだ大丈夫だから。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの向こうで、佐倉さんがコーヒーを飲んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもと同じ姿勢。同じ席。同じ文庫本。", is_choice: false, choices: [] },
          { speaker: "", text: "客が減っても佐倉さんだけは変わらない。それが——少し、救いだった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch11_s1",
      },
      // --- Scene 1: コーヒー豆の差し入れ ---
      // 前提: 客が少ない午後の営業中。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後（Scene 0の少し後）
      //   知識: 桐谷は定期的に挨拶に来る。差し入れを「余った」と言って持ってくる。
      //   今日はコーヒー豆。これは明らかに「選んで」持ってきている。
      // 変化: 桐谷がコーヒー豆を差し入れに来る。高品質のケニア。
      //   主人公は純粋に嬉しい。佐倉のカップ音が強くなる。
      //   神崎がたまたま居合わせて観察している。
      // 結果: 桐谷の好意が佐倉を刺激した状態
      {
        id: "ch11_s1",
        lines: [
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "こんにちは。お邪魔します。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、桐谷さん。どうも。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あの、これ——よかったら使ってください。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが紙袋を差し出す。中に、コーヒー豆の袋。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "コーヒー豆？", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "ケニアのAAです。うちの仕入れルートで余っちゃって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ケニアAA……。これ、結構いい豆じゃないですか。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、知ってますか？ フルーティーで明るい酸味があって。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "店長さんの淹れ方なら、すごく活きると思うんです。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いいんですか？ 高い豆だと思うけど。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "ほんとに余っちゃったんです。うちのマシンだと、この豆の個性が出しきれなくて。", is_choice: false, choices: [] },
          { speaker: "", text: "「余った」と言っているが——豆の袋が未開封だ。開けてもいない。", is_choice: false, choices: [] },
          { speaker: "", text: "わざわざ選んで持ってきてくれたのだろう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ありがとう。大事に使います。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "いい香りが出たら、一杯飲ませてくださいね。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが笑った。柔らかい、自然な笑顔。", is_choice: false, choices: [] },
          { speaker: "", text: "——コトン。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターで、佐倉さんのカップ音。", is_choice: false, choices: [] },
          { speaker: "", text: "隅のテーブルで、神崎さんがPCから顔を上げた。ペンのノック音が止まっている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch11_s2",
      },
      // --- Scene 2: 桐谷と佐倉 ---
      // 前提: 桐谷が差し入れを渡した直後。店内に桐谷・佐倉・神崎・天野。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後（Scene 1の直後）
      //   知識: ch9で桐谷と佐倉は最低限のやりとりだけした。
      //   今回が二度目の同席。桐谷は佐倉に話しかける人。
      //   佐倉は桐谷に壁を作っているが、理由を自覚していない。
      // 変化: 桐谷が佐倉に話しかける。今度は本について。
      //   佐倉は丁寧だが壁がある。桐谷は気づいている（前回と違い）。
      //   会話自体は成立するが、空気が硬い。
      // 結果: 桐谷×佐倉の関係が一歩進む。ただし緊張含み。
      {
        id: "ch11_s2",
        lines: [
          { speaker: "桐谷楓", text: "あ、佐倉さん……ですよね？ 前にお会いしました。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ええ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "いつも本を読んでますよね。何を読んでるんですか？", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんがカウンターの横に立って、佐倉さんの手元を覗き込んだ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ミステリ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、私もミステリ好きです！ その作家さん、新刊出ましたよね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……読んだ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "えっ、もう！？ 早いですね。面白かったですか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……まあまあ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの返事が短い。いつもより更に短い。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "私もこの方のシリーズ好きで。あ、でも佐倉さんに比べたらまだまだで——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。好きに読めばいい。", is_choice: false, choices: [] },
          { speaker: "", text: "……言い方がちょっと冷たい。佐倉さんらしいといえばそうだけど。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんの笑顔が一瞬だけ固まった。——気づいている。今回は。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "……そうですよね。ありがとうございます。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが一歩引いた。でも笑顔は崩さない。プロだ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本に目を落とす。ページはめくらない。", is_choice: false, choices: [] },
          { speaker: "", text: "店内に、微妙な空気が漂っている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch11_s3",
      },
      // --- Scene 3: 神崎の観察 ---
      // 前提: 桐谷×佐倉の会話の直後。桐谷が帰る。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後（Scene 2の直後）
      //   知識: 神崎は観察力が鋭い。佐倉の気持ちに最初に気づく人。
      //   ここで神崎が「(ニヤニヤ)」する。
      // 変化: 桐谷が帰った後、神崎が佐倉をいじる。
      //   佐倉は「何のこと」ととぼける。神崎は深追いしない。
      //   天野が「佐倉さん今日なんか怖くない？」と直球。
      // 結果: 佐倉のピリつきが全員に認知された状態
      {
        id: "ch11_s3",
        lines: [
          { speaker: "桐谷楓", text: "じゃあ、そろそろ。お豆、楽しみにしてますね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ありがとうございます。いい豆だから頑張ります。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが帰っていった。カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "……沈黙。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……ふーん。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがPCの画面から顔を上げて、にやにやしている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なに。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "いい豆もらったじゃない。よかったね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。ケニアAAだって。試すのが楽しみだ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ふふ。……佐倉ちゃん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なに。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "本のページ、この10分くらいめくってないよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……考え事してただけ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "へえ。何の考え事？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……トリックのロジックを反芻してた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ふーん。トリックね。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんの口角が上がっている。完全に面白がっている。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なに、その顔。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "何も。面白い小説読んでるんだなって。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの目が少し細くなった。ただし、神崎さんは怯まない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの〜……佐倉さん、今日なんか怖くないすか？", is_choice: false, choices: [] },
          { speaker: "", text: "天野が洗い物をしながら、率直に言った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……怖い？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんかこう……空気がピリッとしてるっていうか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……してない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "してるって。あたしの腕の毛が立ってるもん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……気のせい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野、あんまり——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "気のせいだから。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本を持ち上げて顔を隠した。", is_choice: false, choices: [] },
          { speaker: "", text: "……本が逆さまだ。", is_choice: false, choices: [] },
          { speaker: "", text: "指摘する勇気は、誰にもなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch11_s4",
      },
      // --- Scene 4: 閉店後——豆を挽く ---
      // 前提: 佐倉も神崎も帰った。閉店作業中。
      //   場所: 月灯り（閉店後）
      //   時間: 夕方
      //   知識: 桐谷の差し入れたケニアAAがある。
      //   天野と主人公の二人。佐倉の行動について振り返る。
      // 変化: 桐谷の豆を試してみる。美味しい。
      //   天野が佐倉の反応について考察する。主人公は鈍い。
      //   天野「あの人、お店が好きなんすよ。たぶんお店だけじゃなくて」
      //   主人公は「店が好き」の部分しか聞いていない。
      // 結果: 佐倉の感情の伏線を強化。主人公の鈍感さを維持。
      {
        id: "ch11_s4",
        lines: [
          { speaker: "", text: "閉店後。桐谷さんにもらったケニアAAを開封する。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いい香りだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おー！ なんかフルーツっぽい匂い！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "挽いてみるか。", is_choice: false, choices: [] },
          { speaker: "", text: "ミルで豆を挽く。甘い香りが広がる。丁寧にドリップ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……うわ、美味い。なんかキラキラした味がする。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "キラキラ……まあ、明るい酸味だよな。華やか。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "桐谷さん、センスいいっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。嬉しいけど、複雑だ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "複雑？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "競合の人にいい豆もらうとか、普通ないだろ。いい人すぎて罪悪感ある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "考えすぎっすよ。桐谷さんは純粋にコーヒー好きなだけじゃないすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……だといいけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ところで店長。今日の佐倉さん、やっぱ変だったっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "怖かった？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "怖いっていうか。桐谷さんが来ると空気変わるんすよね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そうかな。佐倉さんは元々あんな感じだろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いやー、店長相手の時とは温度が違うっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "温度？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長に「普通」って言う時は、なんか……冷たくないんすよ。慣れてるっていうか。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でも桐谷さんに対しては、ガチの壁。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "人見知りなんだろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……あの人、お店が好きなんすよ。たぶんお店だけじゃなくて。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "店が好き、か。……だったら嬉しいな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "…………。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長って、ほんっとに……", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんでもないっす。じゃ、お疲れした！", is_choice: false, choices: [] },
          { speaker: "", text: "天野が帰っていく。一人でケニアAAをもう一杯淹れた。", is_choice: false, choices: [] },
          { speaker: "", text: "美味い。でも、なんだろう。いつもの豆で淹れる方が——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いや、気のせいか。", is_choice: false, choices: [] },
          { speaker: "", text: "空になったカップを洗う。佐倉さんのカップ。今日は2杯。いつも通り。", is_choice: false, choices: [] },
          { speaker: "", text: "ただ、カップの底に——いつもはない、小さな欠けがあった。", is_choice: false, choices: [] },
          { speaker: "", text: "置く時に力が入りすぎたのだろう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……新しいの買わないとな。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが怖かった理由は、考えてもよく分からなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
