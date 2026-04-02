// ============================================================
// 第三章: 白い看板
// ============================================================
//
// あらすじ:
//   商店街の角に大手チェーン「Café BLANC」がオープンし、客足に影響が出始める。
//   エリアマネージャーの桐谷楓が挨拶に訪れる。柔らかい物腰だが確かな自信。
//   天野が危機感を口にし、佐倉は静かに見守る。
//   小さな個人店と大手チェーンの対比が始まる。
//
// 登場キャラ: 桐谷楓（新規）、天野蓮、佐倉美月
// キーイベント:
//   - Café BLANCの出現（脅威の提示）
//   - 桐谷楓の登場（敵ではなくライバル）
//   - 天野の素直な危機感と佐倉の静かな態度の対比
// ============================================================

/// Chapter 3: 白い看板
pub fn get_chapter_3() -> Chapter {
  {
    id: 3,
    title: "第三章",
    subtitle: "白い看板",
    unlock_revenue: 3000,
    unlock_recipes: 10,
    unlock_customers: 3,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 1: チェーン店の出現 ---
      {
        id: "ch3_s1",
        lines: [
          { speaker: "", text: "朝、仕入れに出た帰り道。", is_choice: false, choices: [] },
          { speaker: "", text: "商店街の角に、真新しい看板が立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "白い。まっさらな白。", is_choice: false, choices: [] },
          { speaker: "", text: "『Café BLANC』——大手チェーンのカフェ。", is_choice: false, choices: [] },
          { speaker: "", text: "ガラス張りの外壁。統一されたロゴ。行列のできるカウンター。", is_choice: false, choices: [] },
          { speaker: "", text: "何もかもが、新しい。", is_choice: false, choices: [] },
          { speaker: "", text: "紙袋を抱えたまま、しばらく立ち尽くしていた。", is_choice: false, choices: [] },
          { speaker: "", text: "夕方。天野くんが店に飛び込んできた。いつもより勢いがある。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、見ました？ あの角の！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うん。見たよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やばくないすか？ チェーン店っすよ、チェーン店！", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "コーヒー280円とか書いてあったし……", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうだね。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんの心配は、そのまま僕の心配でもあった。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが窓際でコーヒーを飲んでいる。いつもと変わらない。", is_choice: false, choices: [] },
          { speaker: "", text: "こちらの会話が聞こえているはずだけど、本から目を上げない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さんは心配じゃないんすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……美味しいコーヒーが飲める店が増えるのは、悪いことじゃないでしょう。", is_choice: false, choices: [] },
          { speaker: "", text: "ページをめくる。それだけ。", is_choice: false, choices: [] },
          { speaker: "", text: "……佐倉さんの「美味しいコーヒー」がどの店を指しているのか。", is_choice: false, choices: [] },
          { speaker: "", text: "聞く勇気は、まだなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s2",
      },
      // --- Scene 2: 桐谷楓の来訪 ---
      {
        id: "ch3_s2",
        lines: [
          { speaker: "", text: "数日後の午後。", is_choice: false, choices: [] },
          { speaker: "", text: "見慣れないスーツ姿の女性が、ドアを開けた。", is_choice: false, choices: [] },
          { speaker: "", text: "ベルの音すら上品に聞こえる、そんな佇まい。", is_choice: false, choices: [] },
          { speaker: "", text: "髪をきちんとまとめ、名刺入れを手にしている。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "失礼いたします。Café BLANCエリアマネージャーの桐谷です。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "近隣のご挨拶に伺いました。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうも。", is_choice: false, choices: [] },
          { speaker: "", text: "名刺を受け取る。厚手の紙に、シンプルなロゴ。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "素敵な雰囲気のお店ですね。こういう個人店は、私も好きなんです。", is_choice: false, choices: [] },
          { speaker: "", text: "営業トークだろう。でも、嫌な感じはしなかった。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "よろしければ、一杯いただけますか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "もちろん。何がいいですか。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "おまかせで。店主さんの自信作を。", is_choice: false, choices: [] },
          { speaker: "", text: "試されている——と思った。", is_choice: false, choices: [] },
          { speaker: "", text: "深煎りのブレンドを丁寧に淹れる。", is_choice: false, choices: [] },
          { speaker: "", text: "桐谷さんはカップを受け取ると、まず色を確認した。", is_choice: false, choices: [] },
          { speaker: "", text: "香りを嗅ぎ、一口。", is_choice: false, choices: [] },
          { speaker: "", text: "プロの所作だった。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "……なるほど。", is_choice: false, choices: [] },
          { speaker: "", text: "何が「なるほど」なのかは、分からなかった。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "敵対するつもりはありません。ただ、マーケットは有限ですから。", is_choice: false, choices: [] },
          { speaker: "桐谷楓", text: "お互い、良い店を作りましょう。", is_choice: false, choices: [] },
          { speaker: "", text: "柔らかい笑顔の奥に、確かな自信が見えた。", is_choice: false, choices: [] },
          { speaker: "", text: "代金を置いて、桐谷さんは店を出た。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに、カップがひとつ残されている。", is_choice: false, choices: [] },
          { speaker: "", text: "中身は——半分だけ、飲まれていた。", is_choice: false, choices: [] },
          { speaker: "", text: "……合格でも不合格でもない。保留、ということだろうか。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外、白い看板が遠くに見えた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
