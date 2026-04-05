// ============================================================
// 第八章: 学園祭
// ============================================================
//
// あらすじ:
//   天野の大学の学園祭。コーヒーブースを出すことになり、主人公と佐倉も手伝いに行く。
//   天野の策略で佐倉と主人公は二人きりで迷子になる。
//   カフェの外で並んで歩く——初めてのこと。
//   佐倉が大学生に間違われて微妙な顔をする。
//   非日常の空間で、いつもと少しだけ違う二人の距離。
//
// 登場キャラ: 佐倉美月、天野蓮
// キーイベント:
//   - カフェの外で初めて佐倉と並んで歩く
//   - 天野の策略で二人きりに（「あたし先行ってるんで！」→消える）
//   - 佐倉が大学生に間違われる → 微妙な顔
//   - 学園祭の喧騒の中で二人だけ静かな空間
//   - 佐倉「……こういうの、久しぶり」（ぽろっと出た本音）
//
// --- 章の状態差分 ---
// 開始状態: 雨の日(ch7)を経て、二人きりの時間が心地よいと知っている。
//   佐倉はカウンター寄りの席。主人公は佐倉の存在が少し特別だと薄々感じている。
// 終了状態: カフェの外で一緒に過ごした記憶ができた。
//   主人公の変化: 佐倉を「カフェの客」以外の場所で意識し始めた
//   店の変化: なし（カフェ外のエピソード）
//   関係性: 佐倉（カフェの外でも一緒にいられる。「客と店主」を超え始める）
//           天野（完全に仕掛け人として機能。本人は楽しんでいる）
// ============================================================

/// Chapter 8: 学園祭
///
/// 背景: カフェ外エピソード第2弾。ch6(商店街掃除)は全員だったが、
/// 今回は天野の策略で佐倉と主人公が二人きりになる。
/// カフェという「ホーム」を離れた時の関係性の変化を描く。
/// コメディ多めで、天野の仕掛けと佐倉のリアクションが見所。
pub fn get_chapter_8() -> Chapter {
  {
    id: 8,
    title: "第八章",
    subtitle: "学園祭",
    unlock_revenue: 16000,
    unlock_recipes: 22,
    unlock_customers: 5,
    unlock_intimacy: 1400,
    scenes: [
      // --- Scene 0: 天野の誘い ---
      // 前提: 雨の日(ch7)から数日後。通常営業中。
      //   場所: 月灯り（営業中・午後）
      //   時間: 午後。天野がバイト中。
      //   知識: 天野は大学生。学園祭シーズンが近い。
      // 変化: 天野が学園祭のコーヒーブースの手伝いを頼む。
      //   佐倉も巻き込まれる（天野の計画的犯行）。
      // 結果: 学園祭に3人で行くことが決まる
      {
        id: "ch8_s0",
        lines: [
          { speaker: "天野蓮", text: "店長ー。来週の土曜、ヒマっすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "土曜は営業日だけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "臨時休業で！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "軽いな。何。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うちの大学の学園祭でコーヒーブース出すんすけど、人手が足りなくて！", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長のコーヒー出したら絶対ウケるっすよ！ 宣伝にもなるし！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、宣伝になるなら考えなくもないけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やった！ あ、ちなみに——", is_choice: false, choices: [] },
          { speaker: "", text: "天野がちらっと佐倉さんの方を見た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんも来ません？ 人手は多い方がいいんで！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なんで私。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんコーヒー詳しいじゃないすか。味のチェック係ってことで！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……詳しくない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "湿度で挽き方変える人が言います？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがカップの縁をなぞっている。考え事の癖。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……暇だったら。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "土曜っすよ？ 暇でしょ？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……決めつけないで。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃあ予定あるんすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………ない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "決まりっす！", is_choice: false, choices: [] },
          { speaker: "", text: "天野がガッツポーズをしている。佐倉さんはため息をついた。", is_choice: false, choices: [] },
          { speaker: "", text: "……なんか、天野の手のひらの上で転がされてる気がする。二人とも。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s1",
      },
      // --- Scene 1: 学園祭の朝 ---
      // 前提: 土曜日。天野の大学キャンパスに到着。
      //   場所: 天野の大学キャンパス（正門前→ブースエリア）
      //   時間: 午前
      //   知識: 佐倉を「カフェの外」で見るのはch6(商店街掃除)以来。
      //   主人公は佐倉の私服をちゃんと見るのが初めてに近い。
      // 変化: カフェではない場所で佐倉と一緒にいる違和感と新鮮さ。
      //   ブースで準備をする。佐倉が意外と手際がいい。
      // 結果: ブースの準備完了。天野の計画フェーズ1。
      {
        id: "ch8_s1",
        lines: [
          { speaker: "", text: "土曜日。天野の大学の正門前。色とりどりの看板とのぼり。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "こっちっす！ ブースは中庭の——あ、佐倉さん来てる！", is_choice: false, choices: [] },
          { speaker: "", text: "正門の柱にもたれて、佐倉さんが待っていた。白いブラウスにベージュのスカート。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……遅い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野が自分の大学で迷って。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "黙っててください！", is_choice: false, choices: [] },
          { speaker: "", text: "中庭に向かう。佐倉さんが隣を歩いている。カフェの外で並んで歩く。少し不思議な感じ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃあ設営っす！ 店長、器具こっちに！", is_choice: false, choices: [] },
          { speaker: "", text: "ドリッパーやケトルを並べる。佐倉さんが黙ってカップを並べ始めた。間隔が均一。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん手際いいっすね！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……並べてるだけ。", is_choice: false, choices: [] },
          { speaker: "", text: "30分で準備完了。見本のコーヒーを一杯淹れる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "味見してもらっていい？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……少し薄い。紙コップだから香りが逃げる。もう少し濃いめに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "了解。さすが味チェック係。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……その呼び方やめて。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s2",
      },
      // --- Scene 2: 天野の策略 ---
      // 前提: ブースが動き出して1時間ほど。客が来ている。
      //   場所: 天野の大学キャンパス（コーヒーブース）
      //   時間: 午前〜昼
      //   知識: 天野は佐倉と主人公を二人きりにしたがっている。
      // 変化: 天野が「材料足りない」と嘘をついて二人を買い出しに行かせる。
      //   天野は友達に任せてブースを離脱する準備（二人を合流させない）。
      // 結果: 佐倉と主人公が学園祭の中を二人で歩くことに
      {
        id: "ch8_s2",
        lines: [
          { speaker: "", text: "ブースが動き出すと、意外に客が来た。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ほらー！ ウケてるっす！", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはブースの端で黙ってコーヒーを飲んでいる。手伝いに来たはずでは。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やっべ、砂糖とミルク足りない！ 店長と佐倉さん、購買まで行ってきてくれません？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "購買どこだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "3号館の地下！ まっすぐ行って右曲がって左曲がって——", is_choice: false, choices: [] },
          { speaker: "主人公", text: "分からん。お前も来い。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ブース離れらんないっす！ 佐倉さん、着いてってあげてください！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……私も道知らない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "二人で迷えば怖くないっす！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……意味が分からない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも佐倉さんは立ち上がった。天野がスマホで誰かにメッセージを打っている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……嫌な予感がする。)", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s3",
      },
      // --- Scene 3: 迷子 ---
      // 前提: 購買に向かうが、二人とも道が分からない。
      //   場所: 天野の大学キャンパス（構内を歩いている）
      //   時間: 昼前
      //   知識: 佐倉と並んで歩くのはカフェ外では珍しい。
      //   佐倉が大学生に間違われるフラグ。
      // 変化: 完全に迷子。3号館が見つからない。
      //   佐倉が大学生に道を聞かれる（間違われている）。
      //   二人で学園祭を歩く羽目に。カフェとは違う距離感。
      // 結果: 迷子のまま学園祭を満喫（？）する流れに
      {
        id: "ch8_s3",
        lines: [
          { speaker: "", text: "15分歩いた。3号館は見つからない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ここどこだ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……さっきの建物、2回目。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "完全に回ってる。天野の道案内がわざと適当だったんじゃ……。", is_choice: false, choices: [] },
          { speaker: "学生A", text: "あ、すみませーん！ お二人、何学部ですか？ アンケートお願いしたいんですけど！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、学生じゃなくて——", is_choice: false, choices: [] },
          { speaker: "学生A", text: "え、マジですか！？ お姉さん絶対この大学の人だと思った！", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが微妙な顔をしている。", is_choice: false, choices: [] },
          { speaker: "", text: "……嫌なのか嬉しいのか分からない顔。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……違う。", is_choice: false, choices: [] },
          { speaker: "学生A", text: "あ、すみません！ 失礼しましたー！", is_choice: false, choices: [] },
          { speaker: "", text: "学生が去っていく。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大学生に見えるってことは、若く見られてるんじゃない？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に嬉しくない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "誰も嬉しいとは言ってないけど。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが少しだけ歩くペースを上げた。", is_choice: false, choices: [] },
          { speaker: "", text: "耳が赤い。……寒いのかな。秋だし。", is_choice: false, choices: [] },
          { speaker: "", text: "天野に電話する。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おい、3号館見つからないんだけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あー、それ！ ごめん、3号館今日工事で閉まってたわ！ 購買やってないかも！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……先に言え。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "てへ。じゃあ二人で学祭楽しんできてください！ ブースはあたしの友達に任せたんで！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おい——", is_choice: false, choices: [] },
          { speaker: "", text: "電話が切れた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……切られた？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ハメられた。完全に。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……やっぱり。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え、気づいてた？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "天野さんが自然にモノを頼む時は、裏がある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……鋭いな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……それなのに来たのは、別の理由。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "別の理由？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………学園祭、見てみたかっただけ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが目を逸らした。", is_choice: false, choices: [] },
          { speaker: "", text: "……じゃあ、まあ。せっかく来たし。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "回る？ 学園祭。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……どっちでも。", is_choice: false, choices: [] },
          { speaker: "", text: "「どっちでも」は、佐倉語で「いい」だと、最近分かってきた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s4",
      },
      // --- Scene 4: 二人の学園祭 ---
      // 前提: 天野の策略で、二人で学園祭を回ることに。
      //   場所: 天野の大学キャンパス（模擬店エリア〜中庭〜ベンチ）
      //   時間: 昼〜午後
      //   知識: カフェでは「客と店主」の構図。ここにはそれがない。
      //   佐倉はこういう場に慣れていない様子。
      // 変化: 模擬店を回る。佐倉が焼きそばを「……普通」と評する。
      //   人混みで離れそうになる → 主人公が佐倉の袖を掴む。
      //   ベンチに座って一息つく。佐倉がぽろっと「こういうの、久しぶり」。
      // 結果: カフェの外でも一緒にいられることが分かった
      {
        id: "ch8_s4",
        lines: [
          { speaker: "", text: "模擬店エリア。焼きそば、たこ焼き、クレープ、射的。活気がある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何か食べる？ 腹減らない？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……少し。", is_choice: false, choices: [] },
          { speaker: "", text: "焼きそばを二つ買った。ベンチに座って食べる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どう？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "出た。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……焼きそばに何を期待してるの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、一回でいいから「美味しい」って聞いてみたい。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……焼きそばで？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんでもいいよ。コーヒーでも焼きそばでも。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは黙って焼きそばを食べ続けた。", is_choice: false, choices: [] },
          { speaker: "", text: "食べ終わって、また歩く。演劇ステージの前で人が急に増えた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おっと——佐倉さん、大丈夫？", is_choice: false, choices: [] },
          { speaker: "", text: "振り返ると、佐倉さんが人波に押されて離れそうになっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "とっさに、袖を掴んだ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……っ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はぐれると面倒だし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが振り払わないので、そのまま人混みを抜けた。", is_choice: false, choices: [] },
          { speaker: "", text: "静かな裏庭に出た。銀杏の木が黄色い葉を落としている。", is_choice: false, choices: [] },
          { speaker: "", text: "手を離した。……なんとなく。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ここ、静かだな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "", text: "ベンチに並んで座る。少し間を空けて。", is_choice: false, choices: [] },
          { speaker: "", text: "遠くからステージの歓声が聞こえる。銀杏の葉がひらひら落ちる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが、ぽつりと言った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……こういうの、久しぶり。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "学園祭？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……人と、外を歩くの。", is_choice: false, choices: [] },
          { speaker: "", text: "あ、と思った。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがそういうことを言うのは、珍しい。すごく。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……忘れて。変なこと言った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "変じゃないよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは何も言わなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、ベンチの間の距離が——さっきより少しだけ縮まった気がした。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s5",
      },
      // --- Scene 5: 帰り道 ---
      // 前提: 学園祭を一通り回った。夕方。
      //   場所: 天野の大学キャンパス（正門前）→ 帰路
      //   時間: 夕方
      //   知識: 二人で過ごした時間の記憶。天野の策略だったと分かっている。
      // 変化: 天野と合流。天野がニヤニヤしている。
      //   帰り道、佐倉が「……悪くなかった」。天野が「出た、『悪くない』！」。
      //   日常に戻る予感。でも何かが変わった。
      // 結果: カフェ以外でも佐倉と一緒にいられた記憶。関係性の一歩前進。
      {
        id: "ch8_s5",
        lines: [
          { speaker: "", text: "夕方。正門前で天野と合流した。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おー、おかえりっす！ どうだった？ 学祭！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "購買やってなかったんだけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あ、そうだっけ。ごめんごめん。", is_choice: false, choices: [] },
          { speaker: "", text: "全然悪びれてない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "で、二人で学祭回ったんすか？ 楽しかった？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ……楽しかったけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんは？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……悪くなかった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "出た！ 佐倉さんの「悪くない」！ それ「めっちゃ楽しかった」の意味っすよね！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……違う。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はいはーい。", is_choice: false, choices: [] },
          { speaker: "", text: "三人で駅に向かう。天野が真ん中。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いやー、ブースの売上やばかったっすよ。店長のコーヒー、学祭ぶっちぎりっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、ちゃんとした豆使えばそりゃな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "来年もやりましょうよ！ 毎年恒例で！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "気が早いな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんも来てくれます？ 来年も？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……来年のことは、来年。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "断ってないからオッケーっす！", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがため息をつく。でも、口元は怒っていない。", is_choice: false, choices: [] },
          { speaker: "", text: "駅に着いた。天野が手を振る。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃ、あたしこっちなんで！ お疲れっしたー！", is_choice: false, choices: [] },
          { speaker: "", text: "天野が改札に消えた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんと二人、残された。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……今日、付き合わせて悪かったな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。暇だったし。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが改札に向かう。反対方向のホーム。", is_choice: false, choices: [] },
          { speaker: "", text: "三歩ほど歩いて——立ち止まった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒー。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "ブースのコーヒー。紙コップじゃなくて、ちゃんとしたカップで飲みたい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……月曜、来る？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……行く。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもは「来る」側の佐倉さんが、「行く」と言った。", is_choice: false, choices: [] },
          { speaker: "", text: "……同じことなんだけど。なんか、違う気がした。", is_choice: false, choices: [] },
          { speaker: "", text: "夕焼けの駅。人の波。学園祭の余韻。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの後ろ姿が改札に消えるまで、なぜか見ていた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
