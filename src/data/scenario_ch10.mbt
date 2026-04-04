// ============================================================
// 第十章: チェーン店偵察
// ============================================================
//
// あらすじ:
//   天野に誘われて、主人公がCafe BLANCに偵察に行く。
//   コーヒーは美味い。店内はきれい。価格は安い。天野「……勝てなくない？」
//   帰り道で佐倉に遭遇。匂いでチェーン店に行ったことを看破される。
//   対比: チェーン店の佐倉（退屈・居心地悪そう）vs 月灯りの佐倉（「普通」だが落ち着いて読書）
//   佐倉の言葉と行動の乖離が読者に可視化される章。
//
// 登場キャラ: 天野蓮、佐倉美月
// キーイベント:
//   - Cafe BLANC偵察（コーヒーは良い。店もきれい。安い）
//   - 天野「……勝てなくない？」
//   - 佐倉「匂いでわかる……あっちの店行ってたでしょ」
//   - 月灯りに戻った佐倉がカウンター席で落ち着いて読書
//   - 言葉と行動の乖離が可視化される
//
// --- 章の状態差分 ---
// 開始状態: ch9でCafe BLANCオープン。桐谷と初対面。
//   佐倉はカウンター寄りの席（距離ゼロ圏に突入しつつある）。
//   言葉はまだガード固い。でも物理的距離は近い。
//   店の経営: チェーン店の影響はまだ不明。
// 終了状態: チェーン店の実力を実感。経営的な焦り。
//   主人公の変化: 「うちにしかないもの」を探さないといけないと自覚
//   店の変化: 競合の実力を把握。明確な脅威。
//   関係性: 佐倉（言葉は辛辣だが、月灯りに「帰ってくる」行動で本心が漏れている）
//           天野（主人公と佐倉の間を読む力がさらに上がっている）
// ============================================================

/// Chapter 10: チェーン店偵察
///
/// 背景: 承後半の開始章。チェーン店という外部脅威を具体的に描き、
/// 同時に佐倉の「言葉と距離の乖離」を読者に意識させる。
/// チェーン店は「いい店」として描く。主人公の焦りはそこから来る。
/// 佐倉が月灯りで見せる「普通」が、実は特別な状態であることを
/// チェーン店との対比で浮かび上がらせる。
pub fn get_chapter_10() -> Chapter {
  {
    id: 10,
    title: "第十章",
    subtitle: "チェーン店偵察",
    unlock_revenue: 20000,
    unlock_recipes: 26,
    unlock_customers: 7,
    unlock_intimacy: 1800,
    scenes: [
      // --- Scene 0: 偵察計画 ---
      // 前提: Cafe BLANCがオープンして数日。気になるが行けていない。
      //   場所: 月灯り（開店前）
      //   時間: 朝
      //   知識: 天野はCafe BLANCに興味津々。主人公は怖くて行けていない。
      // 変化: 天野が偵察を提案する。「敵を知り己を知れば〜」
      //   主人公、しぶしぶ承諾。定休日に行くことに。
      // 結果: 偵察が決まった状態
      {
        id: "ch10_s0",
        lines: [
          { speaker: "", text: "開店前。天野がいつもより早く来た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。明日定休日っすよね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。久しぶりにゆっくりしようかなって。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ダメっす。偵察行くっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "偵察。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "Cafe BLANCっすよ！ オープンしてもう三日経ってるのに、まだ行ってないじゃないすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや……行きづらくない？ 隣の店主が偵察って。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "定休日に私服で行けばバレないっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "桐谷さんに顔知られてるんだけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "客として行くなら問題ないっしょ。あっちも挨拶に来てくれたんだし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "敵を知り己を知れば百戦なんとかっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "危うい知識だな……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "とにかく！ 明日の午前、集合っす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……はいはい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、佐倉さんには内緒で。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんで。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんとなくっす。女の勘っす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それ便利な言葉だよな……。", is_choice: false, choices: [] },
        ],
        next_scene: "ch10_s1",
      },
      // --- Scene 1: Cafe BLANC潜入 ---
      // 前提: 定休日。天野と二人でCafe BLANCに入る。
      //   場所: Cafe BLANC（店内）
      //   時間: 午前
      //   知識: チェーン店。白を基調とした内装。桐谷がスタッフ。
      //   主人公は素人から腕を上げたが、プロのチェーン店と比較すると不安がある。
      // 変化: コーヒーが美味い。店がきれい。安い。Wi-Fiもコンセントも完備。
      //   天野「……勝てなくない？」。主人公は正面から受け止める。
      //   桐谷に見つかる。桐谷は嬉しそう。
      // 結果: チェーン店の実力を把握。焦りが具体化。
      {
        id: "ch10_s1",
        lines: [
          { speaker: "", text: "翌日。Cafe BLANCの前。", is_choice: false, choices: [] },
          { speaker: "", text: "ガラス張りの外観。白い壁。観葉植物。おしゃれだ。完全におしゃれ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわー、きれいっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……帰りたくなってきた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "来たからには入るっすよ！", is_choice: false, choices: [] },
          { speaker: "", text: "中に入る。白いカウンター。木目調のテーブル。席は月灯りの3倍はある。", is_choice: false, choices: [] },
          { speaker: "", text: "Wi-Fi完備。全席にコンセント。BGMはジャズ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……神崎さんが見たら引っ越しそうっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "やめろ。想像しただけで胃が痛い。", is_choice: false, choices: [] },
          { speaker: "", text: "注文する。ブレンドコーヒー。420円。……うちより100円安い。", is_choice: false, choices: [] },
          { speaker: "", text: "天野はカフェラテを頼んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "一口飲む。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……美味いな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "美味いっすね……。", is_choice: false, choices: [] },
          { speaker: "", text: "安定した味。酸味と苦みのバランスが良い。嫌なところがない。", is_choice: false, choices: [] },
          { speaker: "", text: "個性があるかと言われれば——ない。でも「失敗がない」という個性がある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ラテもちゃんと美味いっす。ミルクの温度完璧。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "マシンの性能が違うからな。うちは手動で温度管理してるし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "フードメニューもめちゃ豊富。サンドイッチだけで6種類って。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うちのフードメニュー、何種類だっけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "トーストと、あとトースト。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "一種類じゃん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……勝てなくない？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "正直な感想ありがとう。俺もそう思う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、いやっ、あたしはうちの方が好きっすよ！？ ただ客観的に見て——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いいんだよ。事実だし。コーヒーの品質、店の設備、メニューの幅、価格。全部向こうが上だ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……じゃあ、うちの勝ってるところは？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……考えとく。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ！ 店長さん！", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが奥から出てきた。嬉しそう。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "来てくださったんですか？ 嬉しい！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、えっと……定休日なんで、つい。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "お味、どうでしたか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……美味しかったです。正直に。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "よかった！ でも店長さんのコーヒーの方が、私は好きですよ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "手で淹れた味って、なんか……温度がある気がするんです。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "温度？", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "うーん、うまく言えないんですけど。……あ、すみません、お客さん来ちゃった。また話しましょう！", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんが小走りで戻っていった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……いい人っすね、ほんとに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ああ。だからこそ厄介なんだよな。", is_choice: false, choices: [] },
        ],
        next_scene: "ch10_s2",
      },
      // --- Scene 2: 匂いでバレる ---
      // 前提: Cafe BLANCを出た帰り道。
      //   場所: 商店街の路地
      //   時間: 昼前
      //   知識: 佐倉は定休日でもこの辺りを歩く（家が近い）。
      //   コーヒーに詳しい佐倉は匂いに敏感。
      // 変化: 佐倉とばったり会う。佐倉が匂いでチェーン店に行ったことを看破。
      //   辛辣な指摘。でも「怒っている」のではなく「拗ねている」ニュアンス。
      //   天野がニヤニヤしている。
      // 結果: 佐倉にバレた状態。佐倉の「言葉にしない不満」が表面化。
      {
        id: "ch10_s2",
        lines: [
          { speaker: "", text: "Cafe BLANCを出て、商店街を歩いていたら——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、スーパーの袋を下げて立っていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、佐倉さん。偶然。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの鼻がぴくりと動いた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……匂いでわかる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "あっちの店、行ってたでしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……え、わかるの？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "BLANCのブレンドはブラジルのナチュラルがベース。独特の甘い残り香がある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "すっご……犬みたい。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……犬じゃない。普通にわかる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "普通にはわからないと思うけど……。偵察というか、勉強のつもりで。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……で、どうだった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "正直、レベル高かった。コーヒーも美味かったし、設備も段違いだし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ふうん。", is_choice: false, choices: [] },
          { speaker: "", text: "興味なさそうな声。でも、スーパーの袋を持つ手が少し強い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんも行ったことある？ BLANC。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……一回だけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうだった？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーは悪くない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だよな。美味いよな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……でも一回しか行ってない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんで一回だけなんすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。本が読みにくかった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え、あっちの方が広くて静かっぽくないすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………合わなかっただけ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが視線を逸らした。", is_choice: false, choices: [] },
          { speaker: "", text: "……嘘ではないんだろう。でも、全部でもない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ふーん……。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が意味ありげにニヤニヤしている。", is_choice: false, choices: [] },
        ],
        next_scene: "ch10_s3",
      },
      // --- Scene 3: 帰る場所 ---
      // 前提: 佐倉と天野と合流。定休日だが、佐倉は月灯りの方向に歩いている。
      //   場所: 商店街 → 月灯り（閉まっている）の前
      //   時間: 昼
      //   知識: 月灯りは定休日なので閉まっている。
      //   佐倉は「たまたま通りかかった」と言うだろう。
      // 変化: 3人で月灯りの前を通る。佐倉が閉まっている月灯りをちらりと見る。
      //   主人公が「明日はいつも通り開けるよ」と言う。
      //   佐倉「……聞いてない」。でも足が少し軽くなった気がする。
      //   天野がすべてを見ている。
      // 結果: 佐倉にとって月灯りが「通っている店」以上の意味を持つことが示唆される。
      {
        id: "ch10_s3",
        lines: [
          { speaker: "主人公", text: "佐倉さん、これから買い物？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……もう終わった。帰るところ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃあ途中まで一緒っすね。", is_choice: false, choices: [] },
          { speaker: "", text: "三人で商店街を歩く。定休日に佐倉さんと歩くのは初めてだ。", is_choice: false, choices: [] },
          { speaker: "", text: "なんだか変な感じ。カフェの外で会うと、距離感がわからなくなる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "にしても、BLANCすごかったっすねー。あの設備は真似できないっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そうだな。マシンだけで何百万するだろうし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うちの勝ってるところ……なんかあります？ 佐倉さん的に。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……知らない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、毎日通ってるのに？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "近いから通ってるだけ。BLANCも同じくらい近い。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でもBLANCには一回しか行ってないんすよね？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがスーパーの袋を持ち替えた。逃げ道を塞がれた顔。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あはは、ごめんなさいっす。つっこみすぎたっすね。", is_choice: false, choices: [] },
          { speaker: "", text: "月灯りの前を通りかかる。シャッターが降りている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、ちらりとシャッターを見た。一瞬だけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "明日はいつも通り開けるよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……聞いてない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、なんとなく。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……勝手にすれば。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが少しだけ——ほんの少しだけ——歩く速度を落とした。", is_choice: false, choices: [] },
          { speaker: "", text: "隣のCafe BLANCは今日も営業中。白い看板が眩しい。", is_choice: false, choices: [] },
          { speaker: "", text: "でも佐倉さんは、そっちには一度も目を向けなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch10_s4",
      },
      // --- Scene 4: 翌日——「普通」の意味 ---
      // 前提: 定休日明け。月灯りは通常営業。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後
      //   知識: 昨日の偵察で、チェーン店との差を実感した。
      //   佐倉はいつもの時間に来るかどうか分からない。
      // 変化: 佐倉がいつも通り来る。カウンター席。いつもの「コーヒーを」。
      //   主人公はBLANCを意識して丁寧に淹れる。佐倉は一口飲んで「……普通」。
      //   でも、いつもより長く居座る。カップの縁を指先でなぞっている。
      //   神崎がいたら「それ、褒め言葉だよ」と言いそうだ。
      //   主人公は佐倉の「普通」の意味を考え始める。
      // 結果: 「普通」が実は佐倉なりの最上級の肯定かもしれない、という気づきの入り口。
      {
        id: "ch10_s4",
        lines: [
          { speaker: "", text: "翌日。午後。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが入ってきた。いつもの時間。いつもの鞄。いつもの文庫本。", is_choice: false, choices: [] },
          { speaker: "", text: "迷いなくカウンター席に座った。窓際じゃなく。カウンター。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーを。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもより丁寧に淹れる。BLANCのことが頭にある。負けたくない。", is_choice: false, choices: [] },
          { speaker: "", text: "温度。蒸らし時間。注ぎ方。全部意識する。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカップを受け取る。香りを——嗅いだ？ いつもはすぐ飲むのに。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……だよな。", is_choice: false, choices: [] },
          { speaker: "", text: "普通。いつもの評価。", is_choice: false, choices: [] },
          { speaker: "", text: "BLANCのコーヒーには「悪くない」と言った。うちには「普通」。", is_choice: false, choices: [] },
          { speaker: "", text: "——でも。BLANCには一回しか行ってない。ここには毎日来る。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本を開いた。カウンター越し、俺のすぐ目の前。", is_choice: false, choices: [] },
          { speaker: "", text: "ページをめくる音が規則的に聞こえる。落ち着いているときのリズム。", is_choice: false, choices: [] },
          { speaker: "", text: "BLANCでは「本が読みにくかった」と言っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "ここでは——こんなに落ち着いて読んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "カップの縁を、指先でなぞっている。考え事をするときの癖。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長。佐倉さん、今日もう3杯目っすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え、3杯？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いつも2杯なのに。お代わり、あたしがこっそり淹れたっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……長居だな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ね。「普通」なのに3杯飲む人いないっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が小声でニヤニヤしている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが帰ったのは、閉店の30分前だった。いつもより1時間長い。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ありがとうございます。……また明日。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "返事はない。いつも通り。", is_choice: false, choices: [] },
          { speaker: "", text: "でも——ドアの前で、ほんの一瞬だけ足が止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "振り返らずに、出ていった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ねえ店長。「普通」って、佐倉さんにとってどういう意味だと思います？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……普通は普通だろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "そうっすかね。", is_choice: false, choices: [] },
          { speaker: "", text: "天野はそれ以上言わなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店作業をしながら考える。BLANCのコーヒーは確かに美味かった。", is_choice: false, choices: [] },
          { speaker: "", text: "うちが勝っているところ。……まだ、わからない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、佐倉さんは明日も来るだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "なぜか——それだけは確信があった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
