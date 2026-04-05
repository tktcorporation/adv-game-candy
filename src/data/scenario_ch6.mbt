// ============================================================
// 第六章: 商店街掃除大会
// ============================================================
//
// あらすじ:
//   商店街の一斉清掃イベント。初めてカフェの外で全員が集合する。
//   佐倉が私服（カジュアル）で現れ、雰囲気が違う。
//   掃除が始まると、佐倉が驚くほど手際がよくて体力がある。
//   天野「佐倉さんバケツ持つの速くない？」。みんな驚く。
//   カフェの中とは違うダイナミクス。軽いコメディと身体的なユーモア。
//   最後にみんなで休憩。普段と違う佐倉の一面が見える。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛
// キーイベント:
//   - 初のカフェ外シーン（商店街）
//   - 佐倉の私服（カジュアル、いつもと違う印象）
//   - 佐倉が意外と体育会系（ギャップ）
//   - 外で見る関係性の変化（距離感が自然に近くなる）
//
// --- 章の状態差分 ---
// 開始状態: 新メニュー完成。佐倉のコーヒー知識が露呈。カフェ内での関係は深化。
// 終了状態: カフェ外で全員が一緒に活動した。佐倉の意外な一面（体力・手際）を発見。
//   主人公の変化: 佐倉の「カフェの客」以外の顔を知った。気になる度合いが増した
//   店の変化: なし（ただし商店街との関係は強化）
//   関係性: 佐倉（カフェ外で見ると違う人に見える）、全員の距離が自然に縮まった
// ============================================================

/// Chapter 6: 商店街掃除大会
///
/// 背景: カフェという「ホーム」を離れ、初めて外で全員が集まる。
/// 空間が変わると関係性のダイナミクスも変わる。
/// 佐倉の運動能力というギャップでコメディを稼ぎつつ、
/// 「カフェの客」以外の佐倉の姿を主人公（と読者）に見せる。
pub fn get_chapter_6() -> Chapter {
  {
    id: 6,
    title: "第六章",
    subtitle: "商店街掃除大会",
    unlock_revenue: 12000,
    unlock_recipes: 18,
    unlock_customers: 5,
    unlock_intimacy: 1000,
    scenes: [
      // --- Scene 0: 集合 ---
      // 前提: 日曜の朝。商店街の一斉清掃イベント。各店舗から参加者が集まる。
      //   主人公は月灯り代表として参加。天野もバイトとして来る。
      // 変化: 佐倉が私服で現れる。パーカーにジーンズ、スニーカー。
      //   いつもの雰囲気と全然違って、主人公が動揺する。
      //   神崎は取材名目で参加。
      // 結果: カフェの外で全員集合。いつもと違う空気感の確立
      {
        id: "ch6_s0",
        lines: [
          { speaker: "", text: "日曜の朝、八時。商店街の入口に集合。", is_choice: false, choices: [] },
          { speaker: "", text: "年に2回の一斉清掃イベント。各店舗から最低1名参加、というのが商店街のルール。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわ〜、朝早い……。眠いっす……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野、来なくてもよかったのに。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いや、店長一人じゃ心配じゃないすか。掃除とか苦手そうだし。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "失礼な。掃除くらいできるよ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "おはよう。商店街イベントの取材、させてもらうわよ。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんはカメラを首からぶら下げて、メモ帳を片手に。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "神崎さん、完全に仕事モードっすね。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "取材と言いつつ掃除もするわよ。そのくらいの礼儀はあるの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あとは——佐倉さんは、来ないよな。店の関係者でもないし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、それが。昨日「商店街の掃除大会あるんすよ」って言ったら——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "言ったの？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "言ったっす。そしたら「……ふうん」って。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "それ、興味ないってことでは。", is_choice: false, choices: [] },
          { speaker: "", text: "その時。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……おはよう。", is_choice: false, choices: [] },
          { speaker: "", text: "振り返ると、佐倉さんが立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "——いつもと全然違う。", is_choice: false, choices: [] },
          { speaker: "", text: "髪を高い位置でポニーテールにしている。パーカーにジーンズ。白いスニーカー。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "さ、佐倉さん！？ ……いつもと全然違う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "来た！ やっぱ来た！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。運動不足だから。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "へえ。掃除で運動不足解消するタイプなんだ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん、なんかその格好新鮮っすね！ かわいい！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……掃除するのに普段着では来ない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはこちらの視線に気づいて、ポニーテールの先を無意識に触った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……何。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、なんでもない。よし、始めよう。", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s1",
      },
      // --- Scene 1: 佐倉無双 ---
      // 前提: 掃除開始。各チームに分かれてエリアを担当。
      //   月灯りチーム（主人公、天野、佐倉、神崎）は商店街の中央エリア。
      // 変化: 佐倉が信じられないほど手際よく掃除する。バケツを軽々持つ。
      //   天野が驚愕。神崎がシャッターを切りまくる。主人公は唖然。
      //   身体能力の高さがカフェでの静かな姿と完全にギャップ。
      // 結果: 佐倉の意外な一面が全員に露呈。コメディの山場
      {
        id: "ch6_s1",
        lines: [
          { speaker: "", text: "掃除道具が配られる。ほうき、ちりとり、バケツ、ぞうきん。", is_choice: false, choices: [] },
          { speaker: "", text: "商店街の会長がメガホンで指示を出す。", is_choice: false, choices: [] },
          { speaker: "", text: "「中央エリアは月灯りさんのチームね〜！」", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "よっしゃ、気合い入れてくっすよ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "じゃあ、まず落ち葉を掃いて——", is_choice: false, choices: [] },
          { speaker: "", text: "言い終わる前に、佐倉さんがほうきを手に取っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "——速い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(速い……。一掃きで落ち葉がまとまっていく。無駄がない)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え……速くないすか……？", is_choice: false, choices: [] },
          { speaker: "", text: "排水溝にたまった泥を見つけると、しゃがんで手で掻き出し始めた。躊躇なし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん！？ 素手！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……軍手はめてる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……掃除に軍手持参って、慣れてるな)", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ちょっと。すごいわねあの子。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがカメラを構えた。その横で——佐倉さんが水の入ったバケツを片手で持ち上げた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんバケツ持つの速くない！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、速いっていうか、片手！？ あれ結構重いよ！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そう？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん、実はめっちゃ運動できる人じゃないすか！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……中学の時、ソフトボール部だった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ソフトボール！？ 佐倉さんが！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ショート。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ショートって守備範囲広いポジションでしょ。機敏なわけだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "全然イメージなかった……。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……昔の話。", is_choice: false, choices: [] },
          { speaker: "", text: "気がつけば、担当エリアは他のどこよりも早く綺麗になっていた。佐倉さんが一人で半分やっている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしたちの存在意義……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "「佐倉さんと愉快な見学者たち」ね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、俺もちゃんとやってるよ！？", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s2",
      },
      // --- Scene 2: ハプニング ---
      // 前提: 掃除が進んでいる。佐倉の手際の良さに全員驚いた後。
      // 変化: 天野がバケツの水をぶちまけるハプニング。主人公が巻き添え。
      //   佐倉がとっさに天野を支えて転倒を防ぐ。反射神経の良さ。
      //   びしょ濡れの主人公を見て、佐倉が——笑った。声を出して。
      // 結果: 佐倉が声を出して笑った。全員が凍りつく。佐倉はすぐに表情を戻すが遅い
      {
        id: "ch6_s2",
        lines: [
          { speaker: "", text: "掃除も終盤。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "よし、最後にこの水撒いて——おっと！", is_choice: false, choices: [] },
          { speaker: "", text: "天野がバケツを持ったまま足を滑らせた。", is_choice: false, choices: [] },
          { speaker: "", text: "ザバァッ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うわっ！？", is_choice: false, choices: [] },
          { speaker: "", text: "バケツの水が見事に主人公に直撃した。頭から。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ——きゃっ！", is_choice: false, choices: [] },
          { speaker: "", text: "天野がバランスを崩す——その瞬間、佐倉さんが天野の腕を掴んで引き寄せた。一瞬だった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "わ……佐倉さん、ありがとうございます！ 反射神経やばっ！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……足元、気をつけて。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの視線が、びしょ濡れの主人公に移った。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの口元が——震えた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "っ——ふ。", is_choice: false, choices: [] },
          { speaker: "", text: "笑った。", is_choice: false, choices: [] },
          { speaker: "", text: "声を出して、笑った。", is_choice: false, choices: [] },
          { speaker: "", text: "口を手で押さえたけど遅い。全員が凍りついた。佐倉さんが声を出して笑ったのは、初めてだった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごめん。大丈夫？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん今笑ったっすよね！？ 聞いた！？ みんな見た！？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……笑ってない。咳。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "いい咳ね。幸せそうな咳。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、笑ってくれていいんですけど、俺びしょ濡れなんですが。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "すみませんすみませんすみません！ あたしのせいっす！", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがポケットからハンカチを差し出した。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……これ。使って。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、ありがとう。汚しちゃうけどいいですか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……洗えばいい。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはすっと視線を逸らした。ポニーテールが揺れる。耳が赤い。", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s3",
      },
      // --- Scene 3: 缶コーヒーと青空 ---
      // 前提: 掃除が終わり、商店街の広場で打ち上げ休憩。
      //   自動販売機の缶コーヒーで乾杯。
      // 変化: 外で飲む缶コーヒーは味気ないはず——なのに、みんなと飲むと美味い。
      //   佐倉が自販機のコーヒーを飲んで「……普通」。でもいつもの「普通」と声色が違う。
      //   カフェの外で見る佐倉は、少しだけ距離が近い。
      // 結果: カフェの外でも「場」が成立した。佐倉の壁が薄くなっている
      {
        id: "ch6_s3",
        lines: [
          { speaker: "", text: "掃除終了。商店街がぴかぴかになった。", is_choice: false, choices: [] },
          { speaker: "", text: "広場のベンチに座って休憩。自動販売機の缶コーヒーで打ち上げ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "つっかれた〜！ でも気持ちいいっすね！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "いい写真たくさん撮れたわ。特に佐倉ちゃんの鬼掃除シーン。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……載せないで。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "冗談よ。記事には使わない。個人的な保存。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしにも送ってくださいよ！", is_choice: false, choices: [] },
          { speaker: "", text: "主人公は缶コーヒーのプルタブを開けた。", is_choice: false, choices: [] },
          { speaker: "", text: "店で淹れるのとは全然違う、ただの缶コーヒー。", is_choice: false, choices: [] },
          { speaker: "", text: "なのに——妙に美味い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "外で飲むと、なんか美味く感じるな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "分かるっす！ 体動かした後のやつ、格別っすよね！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "コーヒーの味じゃなくて、シチュエーションの力ね。これ記事に使えるわ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "またすぐ記事に結びつける……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんも缶コーヒーを一口飲んで——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あはは！ 缶コーヒーにも容赦ないっすね！", is_choice: false, choices: [] },
          { speaker: "", text: "でも——「普通」の声色が、いつもと違った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……柔らかかった。いつもの「普通」と、全然違う)", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはベンチに座って青空を見上げている。ポニーテールが風に揺れて、カフェで本を読んでいる時とは全然違う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ねーねー、佐倉さん。今度また一緒に何かやりましょうよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。暇なら。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "暇って、佐倉さんいっつも暇じゃないすか。カフェにいるだけだし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……本を読んでる。忙しい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はいはい、忙しい忙しい。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんがこちらを見て、小さく目配せした。", is_choice: false, choices: [] },
          { speaker: "", text: "——分かってる、と言いたげな目。", is_choice: false, choices: [] },
          { speaker: "", text: "4人でベンチに並んで座っている。カフェの中とは違う距離感。肩が触れるくらい近い。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはそれを気にしていないように見えた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……佐倉さんのこと、全然知らなかったな。カフェの中だけじゃ見えないものが、こんなにある)", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが缶コーヒーをもう一口飲んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "今度は何も言わなかった。ただ、少しだけ口角が上がっていた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s4",
      },
      // --- Scene 4: 帰り道 ---
      // 前提: 打ち上げが終わり、解散。天野と神崎は別方向に帰った。
      //   主人公と佐倉が偶然同じ方向。
      // 変化: 二人きりの帰り道。外だと佐倉の言葉数が少し増える。
      //   「今日、楽しかった？」と聞くと「……別に」。でも歩調を合わせている。
      //   ハンカチを返そうとすると「洗ってからでいい」。
      // 結果: カフェの外でも二人の時間が成立した。次のステップへの布石
      {
        id: "ch6_s4",
        lines: [
          { speaker: "天野蓮", text: "じゃ、あたしこっちなんで！ おつかれっした〜！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "私も。原稿書かないと。じゃあね。", is_choice: false, choices: [] },
          { speaker: "", text: "天野と神崎さんがそれぞれの方向に帰っていく。", is_choice: false, choices: [] },
          { speaker: "", text: "残ったのは、主人公と佐倉さん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さん、どっち方面ですか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……駅の方。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、俺もそっちです。途中まで一緒に行きましょう。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(拒否じゃない。……よし)", is_choice: false, choices: [] },
          { speaker: "", text: "並んで歩く。日曜の昼下がり。カフェの外で二人きりは初めてだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今日、ありがとうございました。すごく助かった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……掃除しただけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "掃除の半分くらい佐倉さんがやってましたよね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……やりすぎた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(そこは反省するんだ……)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "楽しかったですか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。", is_choice: false, choices: [] },
          { speaker: "", text: "でも歩調を合わせている。いつの間にか半歩後ろではなく、横に並んでいる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、ハンカチ。ありがとうございました。返しますね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……洗ってからでいい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、はい。じゃあ明日——", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……急がなくていい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……つまり、また会う理由ができた、ってことか)", is_choice: false, choices: [] },
          { speaker: "", text: "分かれ道に着く。佐倉さんが足を止めた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……じゃあ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい、おつかれさまでした。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはぺこりと小さく頭を下げて、歩き出した。", is_choice: false, choices: [] },
          { speaker: "", text: "数歩。立ち止まる。振り返る。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……明日も。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……店。開けるんでしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい、もちろん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そう。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ言って、佐倉さんは行ってしまった。", is_choice: false, choices: [] },
          { speaker: "", text: "ポニーテールが揺れる背中を見送りながら、思った。", is_choice: false, choices: [] },
          { speaker: "", text: "「明日も来る」——そう言いたかったのかもしれない。ポケットの中のハンカチが、まだ少し湿っていた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
