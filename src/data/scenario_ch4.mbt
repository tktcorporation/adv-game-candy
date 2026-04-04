// ============================================================
// 第四章: 白い看板
// ============================================================
//
// あらすじ:
//   商店街の角に大手チェーン「Café BLANC」がオープンし、客足に影響が出始める。
//   エリアマネージャーの桐谷楓が挨拶に訪れる。柔らかい物腰だが確かな自信。
//   コーヒーを半分だけ飲んで帰る——合格でも不合格でもない、保留。
//   天野が率直に危機感を口にし、佐倉は「いいんじゃない」と静かに背中を押す。
//   閉店後、エスプレッソマシンに手を置いた主人公が「自分だけの価値」を考え始める。
//
// 登場キャラ: 桐谷楓（新規）、佐倉美月、天野蓮
// キーイベント:
//   - Café BLANCの出現（外部からの揺さぶり = 拡大する円・第4段階）
//   - 桐谷楓の登場（敵ではなくライバル。プロの所作）
//   - コーヒーを半分だけ飲む（好奇心ギャップ：何が「なるほど」なのか）
//   - 佐倉の「いいんじゃない」（関係性の第3段階: 脆弱性の開示に近づく）
//   - エスプレッソマシンに手を置く（三度触れ #2: マシン — 想起）
//   - 窓から差す光が前と違って見える（三度触れ #2: 光 — 想起）
//
// Want vs. Need:
//   桐谷: Want=BLANCの売上目標達成 / Need=効率の外にある「味」の価値を認めること
//
// --- 章の状態差分 ---
// 開始状態: メニューに名前をつけ始めた。店が軌道に乗り始めている。
// 終了状態: Café BLANC出現で客足が減少。桐谷楓がコーヒーを半分だけ飲んで帰る（保留）。
//   佐倉の「いいんじゃない」で背中を押される。
//   主人公の変化: 「自分だけの価値」を探す必要性を自覚
//   店の変化: 客足が減り、経営的な危機感
//   関係性: 桐谷（ライバル・保留）、佐倉（脆弱性の開示に近づく）
// ============================================================

/// Chapter 4: 白い看板
pub fn get_chapter_4() -> Chapter {
  {
    id: 4,
    title: "第四章",
    subtitle: "白い看板",
    unlock_revenue: 5000,
    unlock_recipes: 12,
    unlock_customers: 4,
    unlock_intimacy: 300,
    scenes: [
      // --- Scene 1: チェーン店の出現と桐谷楓 ---
      // 前提: 開店から1ヶ月半ほど。メニューに名前をつけ始めた。
      //   場所: 商店街（仕入れ帰り）→ 月灯里（数日後）
      //   時間: ある朝 → 数日後の午後
      //   知識: 主人公は店が軌道に乗り始めている実感がある。
      //   Café BLANCの存在をこの場面で初めて知る。
      // 変化: 大手チェーン出現 → 桐谷楓が挨拶に来る → コーヒーを半分だけ飲んで帰る
      //   「なるほど」の真意が分からない = 保留の不安
      // 結果: 競合の出現で「自分の店の価値」を問われる状態に
      {
        id: "ch4_s1",
        lines: [
          { speaker: "", text: "朝、仕入れに出た帰り道。", is_choice: false, choices: [] },
          { speaker: "", text: "商店街の角に、真新しい看板が立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "白い。まっさらな白。", is_choice: false, choices: [] },
          { speaker: "", text: "『Caf\u{e9} BLANC』——大手チェーンのカフェ。", is_choice: false, choices: [] },
          { speaker: "", text: "ガラス張りの外壁。統一されたロゴ。行列のできるカウンター。", is_choice: false, choices: [] },
          { speaker: "", text: "何もかもが、新しい。", is_choice: false, choices: [] },
          { speaker: "", text: "紙袋を抱えたまま、しばらく立ち尽くしていた。", is_choice: false, choices: [] },
          { speaker: "", text: "数日後の午後。見慣れないスーツ姿の女性がドアを開けた。", is_choice: false, choices: [] },
          { speaker: "", text: "セミロングの茶髪をきちんとハーフアップにまとめている。ブラウスにはアイロンの折り目がくっきりと残っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "小ぶりのピアスがひとつだけ。薄い化粧だが、眉だけはきっちり描いてある——隙のない人だ。", is_choice: false, choices: [] },
          { speaker: "", text: "ヒールの音が、店の床板に響く。歩き方が美しかった。", is_choice: false, choices: [] },
          { speaker: "", text: "革の名刺入れを手にしている。使い込まれた色合い。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "失礼いたします。Caf\u{e9} BLANCエリアマネージャーの桐谷です。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "近隣のご挨拶に伺いました。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうも。", is_choice: false, choices: [] },
          { speaker: "", text: "名刺を受け取る。厚手の紙に、シンプルなロゴ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "素敵な雰囲気のお店ですね。こういう個人店は、私も好きなんです。", is_choice: false, choices: [] },
          { speaker: "", text: "営業トークだろう。でも、嫌な感じはしなかった。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "よろしければ、一杯いただけますか。店主さんの自信作を。", is_choice: false, choices: [] },
          { speaker: "", text: "試されている——と思った。", is_choice: false, choices: [] },
          { speaker: "", text: "深煎りのブレンドを丁寧に淹れる。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんはカップを受け取ると、まず色を確認した。次に鼻を近づけ、香りを嗅ぐ。", is_choice: false, choices: [] },
          { speaker: "", text: "——評価の手順だ。色、香り、味。決まったプロトコルがある。", is_choice: false, choices: [] },
          { speaker: "", text: "一口飲んだ瞬間、営業用の笑顔がふっと消えた。素の表情。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "……なるほど。", is_choice: false, choices: [] },
          { speaker: "", text: "何が「なるほど」なのかは、分からなかった。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "敵対するつもりはありません。ただ、マーケットは有限ですから。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "お互い、良い店を作りましょう。", is_choice: false, choices: [] },
          { speaker: "", text: "柔らかい笑顔の奥に、確かな自信が見えた。", is_choice: false, choices: [] },
          { speaker: "", text: "代金を置いて、桐谷さんは店を出た。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに、カップがひとつ残されている。", is_choice: false, choices: [] },
          { speaker: "", text: "中身は——半分だけ、飲まれていた。", is_choice: false, choices: [] },
          { speaker: "", text: "……合格でも不合格でもない。保留、ということだろうか。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s2",
      },
      // --- Scene 2: 揺れる日常 ---
      // 前提: Café BLANCオープンから2週間。客足が減っている。
      //   場所: 月灯里（営業中）
      //   時間: 午後〜夕方〜閉店間際
      //   知識: 主人公は売上の減少を実感。佐倉と天野はまだ通い続けている。
      // 変化: 天野が心配を口にする → 佐倉が「大丈夫？」と初めて直接的に気遣う
      //   佐倉の「いいんじゃない」= 静かな背中押し
      // 結果: 不安を抱えながらも「やめない」と決意した状態
      {
        id: "ch4_s2",
        lines: [
          { speaker: "", text: "Caf\u{e9} BLANCがオープンしてから、二週間。", is_choice: false, choices: [] },
          { speaker: "", text: "客足が、明らかに減った。", is_choice: false, choices: [] },
          { speaker: "", text: "今日の来客は、まだ二人。午後三時を過ぎている。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターを拭く。もう十分きれいなのに、手が止められない。", is_choice: false, choices: [] },
          { speaker: "", text: "夕方。天野くんが店に飛び込んできた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、あの角の見ました？ コーヒー280円っすよ！", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やばくないすか……？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。分かってる。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんの心配は、そのまま僕の心配でもあった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが窓際でコーヒーを飲んでいる。いつもと変わらない。", is_choice: false, choices: [] },
          { speaker: "", text: "こちらの会話が聞こえているはずだけど、本から目を上げない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんは心配じゃないんすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……美味しいコーヒーが飲める店が増えるのは、悪いことじゃないでしょう。", is_choice: false, choices: [] },
          { speaker: "", text: "ページをめくる。それだけ。", is_choice: false, choices: [] },
          { speaker: "", text: "……佐倉さんの「美味しいコーヒー」がどの店を指しているのか。", is_choice: false, choices: [] },
          { speaker: "", text: "聞く勇気は、まだなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "閉店間際。佐倉さんが帰り際にカウンターの前で足を止めた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……大丈夫？", is_choice: false, choices: [] },
          { speaker: "", text: "本を閉じて、こちらを見ている。", is_choice: false, choices: [] },
          { speaker: "", text: "この人がこちらを真っ直ぐ見るのは、珍しいことだった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大丈夫、じゃないかもしれない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも——やめない。", is_choice: false, choices: [] },
          { speaker: "", text: "口に出すと、少しだけ本当になる気がした。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "そう。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なら、いいんじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは小さく頷いて、ドアに向かった。", is_choice: false, choices: [] },
          { speaker: "", text: "でもその「いいんじゃない」は、突き放す言葉ではなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "静かに、確かに、背中を押されたのだと思った。", is_choice: false, choices: [] },
        ],
        next_scene: "ch4_s3",
      },
      // --- Scene 3: 自分だけのもの ---
      // 前提: 同日の閉店後。佐倉の「いいんじゃない」を受けた直後。
      //   場所: 月灯里（閉店後・一人）
      //   時間: 同日夜
      //   知識: 主人公は宮内から「前のオーナーもよく新しいものを試していた」と聞いている。
      //   前オーナーの名前はまだ知らない。在籍期間も正確には知らない。
      // 変化: 売上では勝てない → でも常連がここに「いに来ている」と気づく
      //   エスプレッソマシンに触れ、前オーナーのことを想う
      // 結果:「自分だけの価値」を探す覚悟が芽生えた状態
      {
        id: "ch4_s3",
        lines: [
          { speaker: "", text: "閉店後。一人きりの店内。", is_choice: false, choices: [] },
          { speaker: "", text: "売上のメモを見る。数字は正直だ。", is_choice: false, choices: [] },
          { speaker: "", text: "効率では勝てない。値段でも勝てない。メニューの数でも。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……じゃあ、僕にしかできないことって何だ。", is_choice: false, choices: [] },
          { speaker: "", text: "答えは出ない。出ないけど、考え続ける。", is_choice: false, choices: [] },
          { speaker: "", text: "ふと、エスプレッソマシンに手を置いた。", is_choice: false, choices: [] },
          { speaker: "", text: "ひんやりとした金属の感触。でも、どこか温かい気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "前のオーナーも、このマシンに触れていたのだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんが話してくれた断片。「よく新しいものを試していた」。", is_choice: false, choices: [] },
          { speaker: "", text: "どれくらいの間、ここに立ち続けたのだろう。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "効率じゃない。数字じゃない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ここに来る人が、何を求めているか。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは毎日来る。本を読みに。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんは夕方来る。誰かと話しに。", is_choice: false, choices: [] },
          { speaker: "", text: "宮内さんは週末の朝来る。何かを確かめに。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを飲みに来ているんじゃない。", is_choice: false, choices: [] },
          { speaker: "", text: "——ここに、いに来ている。", is_choice: false, choices: [] },
          { speaker: "", text: "答えはまだ見えない。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、探し続ける理由なら、もう分かっている。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から差し込む街灯の光が、エスプレッソマシンの表面に反射している。", is_choice: false, choices: [] },
          { speaker: "", text: "初めて来た日と同じ光景のはずなのに。", is_choice: false, choices: [] },
          { speaker: "", text: "今は、少しだけ違って見えた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
