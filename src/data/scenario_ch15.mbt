// ============================================================
// 第十五章: 夏祭り
// ============================================================
//
// あらすじ:
//   夏祭り。商店街の出店準備で全員が手伝う。
//   佐倉は意外と手際がいい（ch6で確認済み）。主人公はまた驚く。
//   祭りの夜。屋台を回る。花火が遠くに見える。
//   佐倉と主人公が少しだけ群れから離れる。花火の瞬間。
//   何も起きない。でも空気が変わる。
//   天野が遠くから見ている:「あれ絶対両方気づいてないんだよなあ」
//   承（日常パート）の最終章。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛、桐谷楓
// キーイベント:
//   - 出店準備のドタバタ（全員集合）
//   - 佐倉の有能さ再確認
//   - 花火のシーン（佐倉と主人公、二人きり）
//   - 「何も起きない」が最大のイベント
//   - 天野の観察「あれ絶対両方気づいてないんだよなあ」
//   - 承パートの終了
//
// --- 章の状態差分 ---
// 開始状態: ch14で佐倉の私的な姿を見た。「一人の人」として意識し始めている。
//   佐倉の「前の人のコーヒー」発言が引っかかっている。
//   全員の関係性が成熟期。桐谷も自然にグループに溶け込みつつある。
// 終了状態: 夏祭りの花火の瞬間、何かが変わった（ように見える）。
//   主人公の変化: 佐倉と一緒にいる時の空気が違うことに、まだ言語化できていない
//   店の変化: なし
//   関係性: 佐倉（花火の瞬間、横にいた。何かが変わったような、変わらないような）
//           天野（二人の変化に気づいている。「あれ絶対両方気づいてない」）
//           神崎（祭りに参加。楽しそう。観察は続けている）
//           桐谷（自然にグループに参加。佐倉との関係も少し改善）
// ============================================================

/// Chapter 15: 夏祭り
///
/// 背景: 承パートの最終章。日常の延長としての「特別な夜」を描く。
/// 花火のシーンは意図的に「何も起きない」。だが読者には二人の気持ちが
/// 見えている——当人たちだけが気づいていない。
/// 天野の一言「あれ絶対両方気づいてないんだよなあ」が読者の代弁。
/// ここから転パートへ。日常が揺らぎ始める。
pub fn get_chapter_15() -> Chapter {
  {
    id: 15,
    title: "第十五章",
    subtitle: "夏祭り",
    unlock_revenue: 34000,
    unlock_recipes: 34,
    unlock_customers: 11,
    unlock_intimacy: 3000,
    scenes: [
      // --- Scene 0: 出店準備 ---
      // 前提: 夏祭り当日の朝。商店街の出店準備。
      //   場所: 月灯り（朝）→商店街
      //   時間: 朝〜昼
      //   知識: 商店街の付き合いで月灯りも出店する。
      //   ch6で佐倉は体育会系であることが判明済み。
      //   全キャラが集合する。桐谷もCafe BLANCとして参加。
      // 変化: 出店準備が始まる。テント設営、看板作り。
      //   天野が暴走気味。神崎が指揮を取ろうとして混乱。
      //   佐倉が黙々とテントを組み立てる。手際がいい。
      //   桐谷が差し入れを持ってくる。佐倉と桐谷の距離が前より近い。
      // 結果: 準備完了。夜の祭りへ。
      {
        id: "ch15_s0",
        lines: [
          { speaker: "天野蓮", text: "店長！ テント届いたっす！ でっかいっすよ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おう。設営マニュアルは——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "マニュアルとかいらないっす！ 気合でいくっす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "気合でテント立つわけないだろ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "はい、やめやめ。ちょっと見せて。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "えーっと、まずフレームをこう組んで……ここにポールを差して……", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "神崎さん、それ逆っすよ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……あ、ほんとだ。取材はできるけど、こういうのは苦手なのよね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……貸して。", is_choice: false, choices: [] },
          { speaker: "", text: "三十秒でフレームが組み上がった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え、はっっっや。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さん、テント設営慣れてるの？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……昔、キャンプ行ってた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "へえ。インドア派だと思ってた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……インドア派。今は。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんマジで何でもできるっすよね。前も掃除の時すごかったし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別にすごくない。普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "普通の人はテントを三十秒で組めないと思う。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……練習すればできる。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "おはようございます！ Cafe BLANCの桐谷です。差し入れ持ってきました！", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわ、マジすか！ アイスコーヒーにサンドイッチ！ 桐谷さん神っす！", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "皆さん朝から大変そうだったので。あ、佐倉さんもいらっしゃるんですね。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……アイスコーヒー、もらう。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、はい！ どうぞ！", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……ふうん。佐倉ちゃん、受け取るんだ。成長。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……成長って何。", is_choice: false, choices: [] },
        ],
        next_scene: "ch15_s1",
      },
      // --- Scene 1: 看板騒動 ---
      // 前提: テント設営完了。次は看板作り。
      //   場所: 商店街（テントの前）
      //   時間: 昼
      //   知識: 月灯りの出店メニューは冷たいコーヒーとかき氷。
      // 変化: 看板を誰が書くかで揉める。天野の字が壊滅的。
      //   佐倉が黙って書く。意外と達筆。
      //   ドタバタしながらも準備が完成していく。
      //   チームとしての一体感。
      // 結果: 出店の準備が完成
      {
        id: "ch15_s1",
        lines: [
          { speaker: "主人公", text: "次は看板だな。誰か字がきれいな人——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしやるっす！", is_choice: false, choices: [] },
          { speaker: "", text: "天野が筆ペンを掴んで、段ボールに「月灯り」と書いた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "どうっすか！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……読めない。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "これ「月」じゃなくて「肉」に見える。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっ。肉灯り。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "焼肉屋になってるだろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、あたしの字そんなひどいすか……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "正直に言うと、かなり。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが立ち上がった。天野から筆ペンを受け取る。", is_choice: false, choices: [] },
          { speaker: "", text: "新しい段ボールに、すらすらと書いていく。", is_choice: false, choices: [] },
          { speaker: "", text: "「月灯り——夏のアイスコーヒーとかき氷」", is_choice: false, choices: [] },
          { speaker: "", text: "流れるような文字。丁寧で、少しだけ個性がある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うっっっま。佐倉さん書道やってたとか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……少し。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "少しでこのレベルか……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "佐倉ちゃん、隠し持ってるスキルが多すぎない？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……隠してない。聞かれないだけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃあ聞くっす！ 他にできることある？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "絶対あるっすよ！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあまあ。看板できたし、あとはメニューの仕込みだけだ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "私は取材もかねてぶらぶらするわ。面白いネタ拾えそう。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "サボりっすね。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "取材。取材よ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch15_s2",
      },
      // --- Scene 2: 祭りの夜 ---
      // 前提: 出店は無事に営業開始。夜になった。
      //   場所: 商店街（夏祭り・夜）
      //   時間: 夜
      //   知識: 出店は好調。交代で屋台を見ている。
      //   祭りの賑やかさと、提灯の光。
      // 変化: 出店を天野と桐谷に任せて、主人公と佐倉が屋台を回る。
      //   佐倉がりんご飴を見ている。「……別に欲しくない」と言いつつ視線が離れない。
      //   主人公が買う。佐倉は受け取る。
      //   二人で歩く。祭りの雑踏の中、会話は少ない。
      // 結果: 二人が自然に一緒にいる状態
      {
        id: "ch15_s2",
        lines: [
          { speaker: "", text: "夜。提灯の明かり。出店は好調。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、ちょっと休憩してきていいっすよ。あたしと桐谷さんで回せるんで。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、はい！ 私も手伝いますよ。任せてください。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いいのか？ じゃあ少しだけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんも一緒に行ったらいいじゃないすか。ずっと立ちっぱだったし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別にいい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "遠慮しないでいいっすよ。ね、店長？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、一人で回るのも寂しいし。行く？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがエプロンを外した。了承。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(佐倉さん、浴衣じゃないけど……髪飾り、夏っぽいのつけてるな)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、りんご飴。佐倉さん、めっちゃ見てるけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "食べる？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に欲しくない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも視線が離れない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "じゃあ俺が食べたいから。ついでに二つ買うだけだから。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……好きにすれば。", is_choice: false, choices: [] },
          { speaker: "", text: "二つ買って渡す。佐倉さんが小さくかじった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どう？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……甘い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "りんご飴だからな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ。でも、嫌そうではなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch15_s3",
      },
      // --- Scene 3: 花火 ---
      // 前提: 祭りの終盤。花火が始まる。
      //   場所: 商店街の外れ（花火が見える場所）
      //   時間: 夜（遅め）
      //   知識: 二人は出店から少し離れた場所にいる。
      //   花火は遠くの河川敷から上がる。
      // 変化: 花火が上がる。遠くだけど見える。
      //   二人きり。周りの音が遠い。
      //   何も起きない。告白もキスも手を繋ぐこともない。
      //   ただ、同じ花火を見ている。佐倉の横顔が花火に照らされる。
      //   主人公は何か言おうとして——言わない。理由は自分でも分からない。
      //   佐倉も、何かを飲み込んだように見えた。
      // 結果: 「何も起きなかった」が最大のイベントとして刻まれた
      {
        id: "ch15_s3",
        lines: [
          { speaker: "", text: "商店街の外れ。人通りが少ない。", is_choice: false, choices: [] },
          { speaker: "", text: "——ドン。遠くで低い音。花火だ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……あ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが空を見た。", is_choice: false, choices: [] },
          { speaker: "", text: "花火が開く。赤、青、金。佐倉さんの横顔が、一瞬ごとに違う色に照らされる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……きれいだ。花火か、横顔か。分からないけど)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……きれいだな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "", text: "二人で並んで、花火を見ている。肩が触れそうで触れない距離。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(何か言おうとした。何を。分からない。——言えなかった)", is_choice: false, choices: [] },
          { speaker: "", text: "花火はまだ続いている。遠い歓声。ここだけが静かだった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……花火、久しぶり。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "俺も。いつぶりだろ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……一人で見ても、つまらないから。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうだな。", is_choice: false, choices: [] },
          { speaker: "", text: "最後の大玉が上がった。白い光が夜空いっぱいに広がる。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが少しだけ目を細めた。笑っている。口元だけ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(この表情、覚えてるだろうな。ずっと)", is_choice: false, choices: [] },
        ],
        next_scene: "ch15_s4",
      },
      // --- Scene 4: 天野の観察 ---
      // 前提: 花火が終わった。二人が出店に戻る。
      //   場所: 商店街（出店の前）
      //   時間: 夜（祭り終盤）
      //   知識: 天野と神崎は二人の不在に気づいている。
      //   天野は二人の関係の変化を追い続けている。
      //   神崎も観察者ポジション。
      // 変化: 二人が戻ってくる。何事もなかったかのように。
      //   天野が神崎に小声で「あれ絶対両方気づいてないんだよなあ」。
      //   片付け。祭りが終わる。いつもの日常に戻っていく——ように見えて。
      //   何かが、もう元には戻らない。
      // 結果: 承パート終了。次章（ch16）から転パートへ。
      {
        id: "ch15_s4",
        lines: [
          { speaker: "天野蓮", text: "おかえりっす。花火見えました？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ああ、ちょっとだけ。遠かったけどな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんも一緒に見たんすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……たまたま同じ方向にいただけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はいはい、たまたまっすね。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "あ、お二人とも。かき氷まだ残ってますよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ああ、もらう。", is_choice: false, choices: [] },
          { speaker: "", text: "片付けが始まる。みんなで動くと、あっという間だった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "（……あれ絶対両方気づいてないんだよなあ）", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "（鈍いのよ、二人とも。でも——今はそれでいいんじゃない？）", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "（いいんすかね？ じれったいんすけど）", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "（急かすと壊れるものもあるの。見守りなさい）", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "（うーー。了解っす）", is_choice: false, choices: [] },
          { speaker: "", text: "片付けが終わった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……じゃあ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "うん。お疲れ。今日、ありがとな。テントとか看板とか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別に。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが歩き出す。二歩。三歩。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……りんご飴。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……美味しかった。", is_choice: false, choices: [] },
          { speaker: "", text: "振り向かずに言って、そのまま歩いていった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……りんご飴が美味しかった。それだけの報告のはずなのに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんだろ、これ。胸の奥がざわざわする。", is_choice: false, choices: [] },
          { speaker: "", text: "花火の残像が、まだまぶたの裏に焼きついていた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
