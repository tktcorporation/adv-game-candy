// ============================================================
// 第六章: それぞれの理由
// ============================================================
//
// あらすじ:
//   常連たちの過去が、自然な会話の中から少しずつ漏れ出てくる。
//   佐倉は元パティシエ——自分の店を失った人。
//   天野の実家の金物屋は去年閉店。彼が明るいのは、悲しみを隠す鎧。
//   神崎は東京の大手出版社にいたが、ある記事が原因で地方に来た。
//   みんな何かを失って、ここにいる。それでも、ここを選んでいる。
//
// 登場キャラ: 佐倉美月、天野蓮、神崎凛
// キーイベント:
//   - 佐倉がシフォンケーキを焼いてくる（元パティシエの片鱗）
//   - 天野が閉店した実家の前で立ち尽くしている場面
//   - 神崎が東京時代のことをぽつりと漏らす
//   - 主人公の気づき：この場所が「帰る場所」になりつつある
//
// --- 章の状態差分 ---
// 開始状態: 前オーナーの味を知り、自分の味を磨いている。常連の表面的な姿しか知らない。
// 終了状態: 佐倉（元パティシエ）、天野（金物屋閉店）、神崎（東京追放）の過去を知った。
//   「みんな何かを失ってここにいる」と気づく。
//   主人公の変化: 常連の「表の顔」の奥にある傷を知った → この場所の意味が深まった
//   店の変化: 単なる「カフェ」→「失ったものを持つ人が集まる場所」
//   関係性: 佐倉・天野・神崎（全員が脆弱性の開示段階に）
//
// 注: この章は3人のバックストーリーを扱うが、数日〜数週間かけて
//   自然な流れで「漏れ出てくる」構成。一度に聞き出すのではない。
// ============================================================

/// Chapter 6: それぞれの理由
pub fn get_chapter_6() -> Chapter {
  {
    id: 6,
    title: "第六章",
    subtitle: "それぞれの理由",
    unlock_revenue: 12000,
    unlock_recipes: 18,
    unlock_customers: 5,
    unlock_intimacy: 1000,
    scenes: [
      // --- Scene 1: 佐倉のシフォンケーキ ---
      // 前提: レシピノート発見から数週間。前オーナーの味を知り、自分の味も磨いている。
      //   場所: 月灯里（営業中・午後）
      //   時間: ある日の午後
      //   知識: 佐倉は毎日通う常連だが、個人的な背景は知らない。
      //   主人公は佐倉を「静かに本を読む人」としてしか認識していない。
      // 変化: 佐倉がシフォンケーキを持ってくる → プロの仕事 → 「元パティシエ」と知る
      //   「自分の味に自信がなくなったから」閉めた → 佐倉にもこの店と同じ傷がある
      // 結果: 佐倉の過去を知り、「ここのコーヒーで焼く気になった」という関係性の深化
      //   ただし佐倉はそれ以上語ろうとしない → 踏み込まない
      {
        id: "ch6_s1",
        lines: [
          { speaker: "", text: "レシピノートを見つけてから、数週間が経った。", is_choice: false, choices: [] },
          { speaker: "", text: "ある日の午後。佐倉さんがいつもと違うものを持って来た。", is_choice: false, choices: [] },
          { speaker: "", text: "紙袋。中から、甘い香りがする。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……これ。よかったら。", is_choice: false, choices: [] },
          { speaker: "", text: "紙袋の中には、小さなシフォンケーキが入っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "きめ細かいスポンジ。均一な焼き色。見るからに、素人の仕事ではない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "これ……佐倉さんが作ったんですか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "久しぶりに、焼いてみただけ。", is_choice: false, choices: [] },
          { speaker: "", text: "「久しぶり」。その言葉に、重みがあった。", is_choice: false, choices: [] },
          { speaker: "", text: "一切れいただく。", is_choice: false, choices: [] },
          { speaker: "", text: "……ふわりとした食感。甘すぎない。コーヒーに合う。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "すごく美味しい。プロの味だ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……元、ね。元プロ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはコーヒーカップに視線を落とした。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "3年前まで、自分の店をやってたの。ケーキ屋。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "閉めた理由は……いろいろ。体調とか、資金とか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "でも結局、一番の理由は——自分の味に、自信がなくなったから。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外を見ている。遠くを見るような目。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "それからずっと、焼いてなかった。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……でもここのコーヒー飲んでたら、なんか。", is_choice: false, choices: [] },
          { speaker: "", text: "言葉が途切れた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは首を振って、文庫本を開いた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……忘れて。変なこと言った。", is_choice: false, choices: [] },
          { speaker: "", text: "変なことなんかじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、そう言う代わりに、もう一切れケーキを口に運んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "……美味しい。それだけは、確かだった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s2",
      },
      // --- Scene 2: 天野の夕暮れ ---
      // 前提: 佐倉のシフォンケーキから数日後。
      //   場所: 商店街（仕入れ帰り）→ 月灯里（営業中・夕方）
      //   時間: 仕入れ帰りの夕暮れ → 1時間後
      //   知識: 天野が「金物屋の隣の——あ、もうないんだった」と言ったのはch1。
      //   主人公はその一瞬の表情を覚えているが、深くは聞いていない。
      // 変化: 閉店した金物屋の前で立ち尽くす天野を目撃（声はかけない）
      //   → 1時間後いつも通り来店 → 実家の話を初めて語る
      //   「この店、なくなってほしくない」= 天野がここに居場所を求めている
      // 結果: 天野の過去（失敗の痛み）を知った。明るさの裏を理解した状態
      {
        id: "ch6_s2",
        lines: [
          { speaker: "", text: "佐倉さんがケーキを持ってきた日から、数日後。", is_choice: false, choices: [] },
          { speaker: "", text: "仕入れの帰り道。夕暮れの商店街。", is_choice: false, choices: [] },
          { speaker: "", text: "シャッターの降りた店の前に、誰かが立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "……天野くんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "「天野金物店」。色あせた看板。錆びたシャッター。", is_choice: false, choices: [] },
          { speaker: "", text: "彼は何も言わず、ただ立っていた。リュックを背負ったまま。", is_choice: false, choices: [] },
          { speaker: "", text: "声をかけるべきか迷った。", is_choice: false, choices: [] },
          { speaker: "", text: "……かけなかった。来た道を戻って、遠回りして店に帰った。", is_choice: false, choices: [] },
          { speaker: "", text: "一時間後。天野くんが店に来た。いつもの笑顔で。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ココアください！ 今日めっちゃ寒くないすか！", is_choice: false, choices: [] },
          { speaker: "", text: "いつも通り。明るくて、元気で。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、その笑顔の温度を、前より少しだけ知っている。", is_choice: false, choices: [] },
          { speaker: "", text: "ココアを淹れる。いつもよりほんの少し、ミルクを多めに。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……あれ、今日のなんか違くないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "そう？ いつも通りだけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いや、なんか……あったかい。味が。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんはカップを両手で包んだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長さ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おれの実家、金物屋だったんすよ。去年まで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "親父が継いでたんすけど、結局もたなくて。おれのせいじゃないけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でもなんか……おれが経営学んで何とかできたんじゃないかって。", is_choice: false, choices: [] },
          { speaker: "", text: "笑顔が消えていた。初めて見る、天野くんの素の顔。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……だからこの店、なくなってほしくないんすよ。マジで。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけ言って、天野くんはココアを一気に飲み干した。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "——あっつ！ うわ、猫舌なの忘れてた！", is_choice: false, choices: [] },
          { speaker: "", text: "慌てて水を出す。天野くんが笑う。さっきとは違う、本当の笑顔。", is_choice: false, choices: [] },
          { speaker: "", text: "……そうか。この子は、ここに自分の居場所を見つけたかったんだ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch6_s3",
      },
      // --- Scene 3: 神崎の本音 ---
      // 前提: 天野の話を聞いた日から数日後。閉店間際。
      //   場所: 月灯里（閉店間際 → 閉店後）
      //   時間: 夜。閉店間際に神崎が来る。
      //   知識: 佐倉の過去（元パティシエ）、天野の過去（金物屋閉店）を知った。
      //   神崎についてはまだ「鋭い記者」としか認識していない。
      // 変化: 神崎が珍しく手ぶらで来る → 東京時代の話 → 「飛ばされた」
      //   「書きたいことが出てきちゃった」= ここに居場所を見つけつつある
      // 結果: 常連全員が「何かを失ってここにいる」と気づく
      //   この場所が「帰る場所」になりつつある → 主人公の Need に接続
      {
        id: "ch6_s3",
        lines: [
          { speaker: "", text: "それから何日かして。夜。閉店間際。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんが珍しく遅い時間に来た。", is_choice: false, choices: [] },
          { speaker: "", text: "いつものカメラバッグはなく、手ぶらだった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "まだ間に合う？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大丈夫ですよ。何にします？", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……強いのちょうだい。一番苦いやつ。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもは季節のブレンドを頼む人が。", is_choice: false, choices: [] },
          { speaker: "", text: "深煎りのエスプレッソを淹れた。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんは一口飲んで、顔をしかめた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "にっが。……いいわ、こういうの。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに肘をついて、天井を見上げている。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ねえ。東京って行ったことある？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "何度か。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "私、去年まで向こうにいたのよ。大手の出版社。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "ある記事を書いたの。嘘は書いてない。でも……都合の悪い真実だった。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "それで、まあ。こっちの支局に飛ばされたってわけ。", is_choice: false, choices: [] },
          { speaker: "", text: "エスプレッソのカップを傾ける。苦い液体が喉を通る。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "最初は腐ってたわよ。こんな田舎の商店街で何を書けっていうの、って。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……でも。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんは、カップの中の黒い液面を見つめた。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "この街の人たちの話を聞いてたら、書きたいことが出てきちゃったのよ。", is_choice: false, choices: [] },
          { speaker: "神崎凛", text: "……困ったものよね。", is_choice: false, choices: [] },
          { speaker: "", text: "困った、と言いながら笑っている。", is_choice: false, choices: [] },
          { speaker: "", text: "嘘じゃない笑顔だった。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんが帰った後、一人で片付けをしながら考えていた。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは、自分の味への自信を失った。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんは、実家の店を守れなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "神崎さんは、居場所を追われた。", is_choice: false, choices: [] },
          { speaker: "", text: "みんな、何かを失って、ここにいる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも、ここに来てくれる。この場所を選んでくれる。", is_choice: false, choices: [] },
          { speaker: "", text: "それだけで——十分な理由になる。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターを拭きながら、エスプレッソマシンが目に入った。", is_choice: false, choices: [] },
          { speaker: "", text: "藤宮時雨も、きっと同じことを思っていたのだろうか。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
