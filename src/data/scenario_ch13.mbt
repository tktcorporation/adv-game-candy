// ============================================================
// 第十三章: 半年帰れない
// ============================================================
//
// あらすじ:
//   おばさんから電話。「あと半年くらい帰れないかも〜」。
//   主人公は店を続けるかどうか決断を迫られる。
//   ずっと佐倉の反応を気にしてコーヒーを淹れてきた。
//   この章で主人公は「もう頑張るのやめる。自分が好きなもの作る」と開き直る。
//   佐倉はこの変化に動揺する。今まで「評価する側」だったのに、
//   主人公が自分の承認を必要としなくなった。
//   パワーシフト。追う側が逆転し始める。
//   佐倉がいつもより遅くまで店にいる。何か言いかけて、やめる。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛
// キーイベント:
//   - おばさんの電話「半年帰れない」
//   - 主人公の決断「頑張るのをやめる。自分の好きなものを作る」
//   - 佐倉の動揺（評価者のポジションを失う不安）
//   - パワーシフト: 追う側の逆転
//   - 佐倉が何か言いかけて止まる
//
// --- 章の状態差分 ---
// 開始状態: ch12でピクニック。佐倉の笑顔。主人公の心臓が跳ねた（自覚なし）。
//   佐倉はカウンター席。距離ゼロ圏。言葉は辛辣だが行動は近い。
//   チェーン店の影響で客は減少傾向。主人公は焦っている。
// 終了状態: おばさん半年不在確定。主人公は店を続ける決断。
//   主人公の変化: 「佐倉さんに認めてもらう」から「自分の好きなものを作る」にシフト。
//     力が抜けて、逆にいい味が出始める。
//   佐倉の変化: 評価者の立場を失いそうで不安。主人公が自分を見なくなった気がする。
//     でも——店に来ることはやめられない。むしろ長くいる。
//   関係性: パワーバランスが逆転。佐倉が「追う側」に回り始める。
//           天野は変化に気づいている。神崎は確信に近づいている。
// ============================================================

/// Chapter 13: 半年帰れない — POWER SHIFT CHAPTER
///
/// 背景: 物語全体の転換点の一つ。主人公の動機が「佐倉に認められたい」から
/// 「自分が好きなものを作りたい」に変わることで、二人の関係のパワーバランスが動く。
/// 佐倉がずっと「評価する側」だったのに、主人公が評価を求めなくなると、
/// 佐倉は自分の居場所の根拠を失いかける。
/// 結果的に佐倉の方が主人公を意識するようになる。
/// 主人公の「頑張りをやめる」は投げやりではなく、自然体への移行。
pub fn get_chapter_13() -> Chapter {
  {
    id: 13,
    title: "第十三章",
    subtitle: "半年帰れない",
    unlock_revenue: 26000,
    unlock_recipes: 32,
    unlock_customers: 10,
    unlock_intimacy: 2400,
    scenes: [
      // --- Scene 0: おばさんの電話 ---
      // 前提: いつもの朝。開店準備中。
      //   場所: 月灯り（開店前）
      //   時間: 朝
      //   知識: おばさんは旅行に行ったまま連絡が取れなかった。
      //   ここで久しぶりに電話が来る。
      // 変化: おばさん「あと半年くらい帰れないかも〜」。軽い。
      //   主人公は呆れつつも、半年という期間の重さに気づく。
      //   天野に報告。天野は心配と嬉しさが混在。
      // 結果: 半年間、店を続けるかどうかの選択を突きつけられた状態
      {
        id: "ch13_s0",
        lines: [
          { speaker: "", text: "朝。開店準備をしていたら、スマホが鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "画面に「おばちゃん」。……久しぶりだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "もしもし。", is_choice: false, choices: [] },
          { speaker: "", text: "『あーもしもし！ 元気〜？ お店やってる〜？』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "やってるよ。というか、やらされてるよ。", is_choice: false, choices: [] },
          { speaker: "", text: "『あはは〜、ごめんね〜。実はね——』", is_choice: false, choices: [] },
          { speaker: "", text: "『あと半年くらい帰れないかも〜。』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……は？", is_choice: false, choices: [] },
          { speaker: "", text: "『友達の友達のツテで南米のコーヒー農園巡りしてたら、すっごく面白くてさ〜。まだ回りたいとこがいっぱいあって〜。』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "半年。……半年って、あと半年？", is_choice: false, choices: [] },
          { speaker: "", text: "『うん！ ダメ？ お店、任せちゃダメ？』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、ダメとかいいとかじゃなくて——", is_choice: false, choices: [] },
          { speaker: "", text: "『冷蔵庫のプリンもう食べちゃった？ 新しいの送ろうか？』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "プリンはとっくにない。てかそういう話じゃなくて。", is_choice: false, choices: [] },
          { speaker: "", text: "『大丈夫大丈夫。あなた、意外とちゃんとやれてるでしょ？ おばちゃんは知ってるよ〜。』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何を根拠に……。", is_choice: false, choices: [] },
          { speaker: "", text: "『じゃあね〜！ 体に気をつけてね〜！ あ、いい豆見つけたら送るから！』", is_choice: false, choices: [] },
          { speaker: "", text: "プツン。切れた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "半年か……。", is_choice: false, choices: [] },
        ],
        next_scene: "ch13_s1",
      },
      // --- Scene 1: 続けるのか ---
      // 前提: おばさんの電話を受けた直後。天野がバイトに来る。
      //   場所: 月灯り（開店後・午前）
      //   時間: 午前
      //   知識: 客数は減少傾向。チェーン店に押されている。
      //   半年、このまま続けるのか。辞めることもできる。
      // 変化: 天野に報告。天野は「辞めないっすよね！？」と焦る。
      //   主人公は考える。何のために店をやっているのか。
      //   最初はおばさんに頼まれただけ。でも今は——
      //   佐倉さんの「普通」を「美味しい」に変えたくて頑張ってきた。
      //   ……でも、それって正しい動機なのか？
      // 結果: 主人公が自分の動機と向き合う
      {
        id: "ch13_s1",
        lines: [
          { speaker: "天野蓮", text: "おはようございまーっす！ ……あれ、店長顔死んでるっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おばさんから電話あった。あと半年帰れないって。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "半年！？ マジっすか！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "マジ。南米のコーヒー農園巡りだって。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "フリーダムすぎる……。で、お店は？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "任せちゃダメ？ って。軽く。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "辞めないっすよね！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……わからない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "冗談。辞めないよ。たぶん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "「たぶん」が怖いっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……天野。俺さ、何のためにこの店やってるんだろうな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え、急に哲学っすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "最初はおばさんに頼まれたからだった。仕方なく。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも途中から——佐倉さんの「普通」を変えたくてさ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あの人に一度でいいから「美味しい」って言ってもらいたくて。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "豆を変えたり、淹れ方を変えたり、新メニュー作ったり。全部それが動機だった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……それ、めちゃくちゃいい話だと思うっすけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でもさ、それって結局——人の評価のために作ってるってことだろ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さんに認めてもらうためのコーヒーって。……それ、美味いのか？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "桐谷さんが言ってたんだよ。「手で淹れた味には温度がある」って。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "その温度って、誰かに認めてもらうために淹れたコーヒーにもあるのかな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長……。", is_choice: false, choices: [] },
        ],
        next_scene: "ch13_s2",
      },
      // --- Scene 2: 頑張るのをやめる ---
      // 前提: 午後の営業。佐倉がいつもの時間に来ている。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後
      //   知識: 主人公は午前中ずっと考えていた。
      //   佐倉はカウンター席で本を読んでいる。
      //   神崎もいる。
      // 変化: 主人公が宣言する。「もう頑張るのやめるわ。自分が好きなもの作る」。
      //   佐倉の本のページが止まる。
      //   主人公が力を抜いてコーヒーを淹れる。いつもと同じ豆、同じ手順。
      //   でも何かが違う。天野「……なんか今日のコーヒー美味くないすか？」。
      //   佐倉は何も言わない。でも、カップの縁をなぞる指が止まっている。
      // 結果: パワーシフト開始。主人公が佐倉の評価から自由になった。
      {
        id: "ch13_s2",
        lines: [
          { speaker: "", text: "午後。佐倉さんがいつもの時間に来た。カウンター席。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんもいつもの隅の席。PCを開いている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんにコーヒーを出す。いつもの動作。", is_choice: false, choices: [] },
          { speaker: "", text: "……でも今日は、違うことを考えている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、まだ考えてるっすか？ 朝の。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。ずっと考えてた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "で？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……もう頑張るのやめるわ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え！？ 辞めるんすか！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "辞めない。頑張るのをやめるだけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……どういう意味っすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "誰かに認めてもらうためにコーヒーを淹れるのをやめる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "自分が好きなもの作る。飲みたいもの淹れる。それだけ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの本のページが——止まった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "BLANCには勝てない。設備も資本も違う。そこで張り合っても意味がない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも、俺が美味いと思うコーヒーは俺にしか淹れられない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それを飲みたい人が来てくれればいい。来なかったら——まあ、その時はその時だ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "なんかカッコいいこと言ってるっすけど、大丈夫っすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大丈夫じゃないかもな。でも、嘘ついてコーヒー淹れるよりマシだろ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……悪くないじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがPCから顔を上げた。珍しく、まっすぐこっちを見ている。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「自分の好きなもの作る」——それが一番強いよ。たぶん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうだろうな。", is_choice: false, choices: [] },
          { speaker: "", text: "豆を挽く。いつもの豆。いつもの手順。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、力が抜けている。いい意味で。", is_choice: false, choices: [] },
          { speaker: "", text: "「認めてもらおう」じゃなくて、「俺が飲みたい味」。", is_choice: false, choices: [] },
          { speaker: "", text: "淹れたコーヒーを、まず自分で一口飲んだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。これでいい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしにも一杯くださいっす。", is_choice: false, choices: [] },
          { speaker: "", text: "天野に淹れる。天野が一口飲んで——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……なんか今日のコーヒー、美味くないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "同じ豆だよ。同じ淹れ方。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いや、でも……なんか違う。なんだろ。柔らかい？", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの向こうで、佐倉さんがカップの縁をなぞる指を止めた。", is_choice: false, choices: [] },
          { speaker: "", text: "本を見ている——ふりをしている。ページが動いていない。", is_choice: false, choices: [] },
        ],
        next_scene: "ch13_s3",
      },
      // --- Scene 3: 佐倉のそわそわ ---
      // 前提: 主人公が「頑張るのをやめた」直後の時間。
      //   場所: 月灯り（営業中・午後〜夕方）
      //   時間: 夕方に近い午後
      //   知識: 佐倉はずっと「評価する側」だった。
      //   主人公が評価を求めなくなったことで、佐倉の立場が揺らぐ。
      //   佐倉は自覚していないが、「必要とされなくなる不安」が生まれている。
      // 変化: 佐倉がいつもより長く店にいる。帰る気配がない。
      //   コーヒーのお代わりを頼む（珍しく自分から）。
      //   主人公は佐倉を「いつもの客」として扱う。特別視しない。
      //   その「特別視しない」が、佐倉には初めての体験。
      //   佐倉がそわそわしている。天野だけが気づく。
      // 結果: パワーシフトが進行。佐倉が追う側に回り始める。
      {
        id: "ch13_s3",
        lines: [
          { speaker: "", text: "いつもなら佐倉さんが帰る時間を過ぎている。", is_choice: false, choices: [] },
          { speaker: "", text: "まだカウンターにいる。本は——閉じかけてはまた開く。落ち着かない。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……お代わり。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが自分からお代わりを頼むのは珍しい。いつもは天野が気を利かせるか、黙って帰るかだった。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。さっきと同じ。力の抜けた、自分のための味。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが一口飲んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもなら「普通」と言うタイミング。", is_choice: false, choices: [] },
          { speaker: "", text: "……何も言わなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "主人公はそれに気づかない。自分のコーヒーを飲みながらカップを磨いている。", is_choice: false, choices: [] },
          { speaker: "", text: "——今までなら、佐倉さんの反応を気にして、ちらちら見ていた。", is_choice: false, choices: [] },
          { speaker: "", text: "今日はそれがない。自分の世界でコーヒーと向き合っている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが——ちらっと、主人公の方を見た。", is_choice: false, choices: [] },
          { speaker: "", text: "視線は本の上。でも目は——こちらを見ている。", is_choice: false, choices: [] },
          { speaker: "", text: "主人公は気づかない。カップを磨いている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、また本に目を落とした。", is_choice: false, choices: [] },
          { speaker: "", text: "……そしてまた、ちらっと見た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "(……佐倉さん、めっちゃ見てるじゃん……)", is_choice: false, choices: [] },
          { speaker: "", text: "天野が洗い物をしながら、小さく口の中で呟いた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……今日の。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……今日のコーヒー。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……いつもと同じ豆？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。同じ豆、同じ淹れ方。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そう。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ。でも、佐倉さんがコーヒーについて自分から質問するのは——初めてかもしれない。", is_choice: false, choices: [] },
          { speaker: "", text: "主人公はそのことの重大さに気づいていない。", is_choice: false, choices: [] },
        ],
        next_scene: "ch13_s4",
      },
      // --- Scene 4: 言いかけて、やめる ---
      // 前提: 閉店間際。佐倉がまだいる。
      //   場所: 月灯り（閉店間際）
      //   時間: 夕方
      //   知識: 佐倉はいつもの時間をとっくに過ぎている。
      //   他の客はもういない。天野は片付けを始めている。
      //   佐倉が閉店まで残るのは初めて。
      // 変化: 天野が先に帰る（空気を読んで）。主人公と佐倉の二人。
      //   佐倉が何か言いかけて——止まる。
      //   主人公「どうした？」。佐倉「……なんでもない」。
      //   佐倉が帰る。いつもの「ごちそうさま」。
      //   でも今日は——少しだけ、声が小さかった。
      // 結果: 佐倉の感情が言葉の手前まで来ている。パワーシフト完了。
      {
        id: "ch13_s4",
        lines: [
          { speaker: "", text: "閉店の15分前。他の客はもういない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがまだカウンターにいる。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもより2時間近く長い。こんなの初めてだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、あたし先上がっていいっすか？ 明日朝イチで大学あって。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ああ、いいよ。片付けはやっとく。お疲れ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "っす。……佐倉さんも、お疲れっす。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "", text: "天野が出ていった。二人きりになった。", is_choice: false, choices: [] },
          { speaker: "", text: "静かだ。BGMも止めてある。コーヒーの残り香だけが漂っている。", is_choice: false, choices: [] },
          { speaker: "", text: "主人公はカウンターの内側で、グラスを拭いている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは——本を閉じていた。", is_choice: false, choices: [] },
          { speaker: "", text: "カップの縁をなぞっている。空のカップ。お代わりは頼まない。", is_choice: false, choices: [] },
          { speaker: "", text: "帰る準備をしているようで、していない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……閉店、そろそろだけど。急がないよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、口を開きかけた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……あの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "言葉が続かない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの指がカップの縁をなぞるのが速くなっている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうした？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なんでもない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そう？", is_choice: false, choices: [] },
          { speaker: "", text: "主人公はそれ以上追わなかった。以前の自分なら気になって仕方なかっただろう。", is_choice: false, choices: [] },
          { speaker: "", text: "でも今は——佐倉さんが話したい時に話すだろう、と思えた。", is_choice: false, choices: [] },
          { speaker: "", text: "その余裕が、佐倉さんにはかえって——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……半年。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……おばさん、半年帰らないって。天野さんが言ってた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ああ。うん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……お店、続けるの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "続けるよ。", is_choice: false, choices: [] },
          { speaker: "", text: "迷いなく言った。自分でも驚くくらい。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そう。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが立ち上がった。鞄を肩にかける。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアに向かう途中で——また、足が止まった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……あのさ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "長い沈黙。佐倉さんの背中が見える。少し力が入っている。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なんでもない。ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。ドアが閉まった。", is_choice: false, choices: [] },
          { speaker: "", text: "……今日の「ごちそうさま」は、いつもより少しだけ声が小さかった。", is_choice: false, choices: [] },
          { speaker: "", text: "一人でカウンターを拭く。佐倉さんがいた席は、まだ少し温かい。", is_choice: false, choices: [] },
          { speaker: "", text: "空のカップを洗う。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……何を言おうとしてたんだろうな。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、追わない。待つ。", is_choice: false, choices: [] },
          { speaker: "", text: "明日も、いつもの時間に開ける。", is_choice: false, choices: [] },
          { speaker: "", text: "自分が好きなコーヒーを、好きなように淹れる。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけでいい。それだけで——きっと、いいはずだ。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
