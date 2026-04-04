// ============================================================
// 最終章: ここにいる理由
// ============================================================
//
// あらすじ:
//   ある日の午後、見知らぬ女性がカフェを訪れる。
//   藤宮しずく——前オーナーの娘。
//   エスプレッソマシンがまだ使われていることに気づき、手紙のことを尋ねる。
//   「続きは、きっとお互いに分かってるから」——未完の手紙は、完成していた。
//   コーヒーを一杯。「父とは違うけど、温かい味」。
//   この場所は、人が集まることで生きている。月灯りは今日も静かに灯っている。
//
// 登場キャラ: 藤宮しずく（新規）、佐倉美月、天野蓮
// キーイベント:
//   - エスプレッソマシン（三度触れ #3: 回収）
//   - 「前の人」→しずくが父を語る（三度触れ #3: 回収）
//   - 手紙「しずくへ——」の結末（三度触れ #3: 回収）
//   - 窓から差す光（三度触れ #3: 回収）
//   - 「ごちそうさま」→「またね」の反転（ch0の佐倉と対比）
//
// --- 章の状態差分 ---
// 開始状態: 時雨の真実を知り、日常が成熟した状態。全ての伏線が回収を待っている。
// 終了状態: しずくが来店し、手紙の件に決着。佐倉の「いい店ね」= 最終的な承認。
//   「待合室」が「誰かの場所」になった。月灯りは今日も灯っている。
//   主人公の変化: Want（カフェをやりたい）→ Need（居場所を見つけた）が統合
//   店の変化: 「待合室」→「みんなの場所」→ 今日も灯りがついている
//   関係性: 佐倉（変容の承認「いい店ね」）、全キャラがこの場所と結ばれた
// ============================================================

/// Chapter 8: ここにいる理由 (Final)
pub fn get_chapter_8() -> Chapter {
  {
    id: 8,
    title: "最終章",
    subtitle: "ここにいる理由",
    unlock_revenue: 25000,
    unlock_recipes: 22,
    unlock_customers: 5,
    unlock_intimacy: 2000,
    scenes: [
      // --- Scene 1: いつもの午後 ---
      // 前提: 宮内から時雨の真実を聞いてから数日〜数週間後。秋が深まった。
      //   場所: 月灯里（営業中）
      //   時間: 秋の午後
      //   知識: 時雨の全体像、しずくの存在、店の歴史を全て知っている。
      //   常連たちの過去も知っている。日常が成熟している。
      // 変化: 「いつも」の風景を味わう → この積み重ねこそが価値だと感じる
      // 結果: 穏やかな日常が確立された状態（嵐の前の静けさ）
      {
        id: "ch8_s1",
        lines: [
          { speaker: "", text: "宮内さんから時雨さんの話を聞いてから、しばらく経った。秋の深まった午後。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から差し込む光が、夏とは違う角度で床を照らしている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが窓際で本を読んでいる。天野くんがカウンターでレポートを書いている。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの午後。いつもの光景。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、「いつも」が積み重なって今がある。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。豆を挽く音。お湯の沸く音。", is_choice: false, choices: [] },
          { speaker: "", text: "この音が、この場所の心臓の鼓動だ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "店長、今日のブレンドいつもと違くないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "分かる？ 少しだけ配合を変えてみたんだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おれでも分かるくらいっすからね。成長したっしょ、おれも。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本越しに小さく笑った。", is_choice: false, choices: [] },
          { speaker: "", text: "穏やかな時間。これがずっと続けばいいと思った。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s2",
      },
      // --- Scene 2: しずくの来店 ---
      // 前提: Scene 1の直後。いつもの午後が続いている。
      //   場所: 月灯里（営業中）
      //   時間: 同日の午後
      //   知識: 主人公は「しずく」の名前をノートの手紙から知っている。
      //   宮内から「娘がいた。しずくという名の」と聞いている。
      //   しずくが実際にどういう人かは知らない。
      // 変化: しずく本人が来店 → エスプレッソマシンを見て「父の店」と言う
      //   「まだ使ってくれてるんだ」→ マシンの「帰りを待つ」意味が回収される
      // 結果: ノートの手紙の宛名の本人が目の前にいる状態
      {
        id: "ch8_s2",
        lines: [
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルが鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "見知らぬ女性が、入り口に立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "30歳くらいだろうか。きちんとした服装。でも、表情はどこか不安げ。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は一歩踏み入れて——足を止めた。", is_choice: false, choices: [] },
          { speaker: "", text: "店内を見回している。壁、天井、カウンター。", is_choice: false, choices: [] },
          { speaker: "", text: "変わった場所と、変わらない場所を確かめるように。", is_choice: false, choices: [] },
          { speaker: "", text: "そして——彼女の視線が、エスプレッソマシンに止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "長い、数秒間。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ここが、父の店。", is_choice: false, choices: [] },
          { speaker: "", text: "静かな声だった。震えてはいない。でも、力を込めている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あなたは——", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "藤宮しずく。……父の、娘です。", is_choice: false, choices: [] },
          { speaker: "", text: "——しずく。", is_choice: false, choices: [] },
          { speaker: "", text: "ノートの最後のページ。あの書きかけの手紙の宛名。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんが手を止めた。佐倉さんが本を閉じた。", is_choice: false, choices: [] },
          { speaker: "", text: "店内の空気が、ほんの少しだけ変わった。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "突然すみません。……一度、来てみたかったんです。", is_choice: false, choices: [] },
          { speaker: "", text: "しずくさんはゆっくりと歩き、カウンターの前に立った。", is_choice: false, choices: [] },
          { speaker: "", text: "そして、エスプレッソマシンに手を伸ばした。触れるか触れないかの距離で、止まる。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "……まだ使ってくれてるんだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "大切にされていたものだから。", is_choice: false, choices: [] },
          { speaker: "", text: "しずくさんは少しだけ目を伏せて、頷いた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s3",
      },
      // --- Scene 3: 手紙の続き ---
      // 前提: Scene 2の直後。しずくがカウンターの前にいる。
      //   場所: 月灯里（同日・同場面）
      //   時間: 同日の午後（連続）
      //   知識: しずくは父の店を知っている。エスプレッソマシンの意味も分かっている。
      //   しずくは手紙の存在を予感している（「最後のページに何か書いてあった？」）
      // 変化: コーヒーを淹れる → 「父とは違うけど温かい味」
      //   手紙について尋ねる → 「続きはお互いに分かってるから」= 未完の手紙は完成していた
      // 結果: 時雨としずくの関係に決着がついた状態
      {
        id: "ch8_s3",
        lines: [
          { speaker: "", text: "しずくさんが、窓際の席に座った。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがいつも座る、あの席の隣。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは黙って少し椅子をずらし、場所を空けた。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "コーヒーを一杯……お願いします。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。丁寧に。今までで一番丁寧に。", is_choice: false, choices: [] },
          { speaker: "", text: "カップを差し出す。しずくさんは両手で受け取った。", is_choice: false, choices: [] },
          { speaker: "", text: "香りを確かめて、一口。", is_choice: false, choices: [] },
          { speaker: "", text: "……目を閉じた。宮内さんと同じだ。味の向こうに何かを探すような表情。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "美味しい。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "……父とは違うけど。温かい味。", is_choice: false, choices: [] },
          { speaker: "", text: "しばらく沈黙が流れた。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんは何も言わず、レポートに目を戻した。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは本を開いたが、ページをめくる気配はない。", is_choice: false, choices: [] },
          { speaker: "", text: "みんな、聞いている。でも、踏み込まない。", is_choice: false, choices: [] },
          { speaker: "", text: "それが、この店の優しさだと思った。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "……あの。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "父が残したもの……ノートとか、ありましたか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……はい。レシピノートが。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "最後のページに……何か、書いてあった？", is_choice: false, choices: [] },
          { speaker: "", text: "知っているのだ。父が何を書こうとしていたか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「しずくへ」——とだけ。続きは、書かれていませんでした。", is_choice: false, choices: [] },
          { speaker: "", text: "しずくさんはカップに目を落とした。", is_choice: false, choices: [] },
          { speaker: "", text: "長い、長い沈黙。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーの湯気だけが、二人の間でゆらゆらと揺れている。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "……それでいい。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "続きは、きっとお互いに分かってるから。", is_choice: false, choices: [] },
          { speaker: "", text: "その声は穏やかだった。", is_choice: false, choices: [] },
          { speaker: "", text: "悲しみではなく、受け入れた人の声だった。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s4",
      },
      // --- Scene 4: 月灯り ---
      // 前提: Scene 3の直後。手紙の話が終わった。
      //   場所: 月灯里（同日）
      //   時間: 同日の午後（連続）
      //   知識: しずくは受け入れた。手紙の件は解決した。
      // 変化: しずくが「また来てもいいですか」→ ch0佐倉の「ごちそうさま」との対比
      //   去っていく → ch0の佐倉と同じ光に照らされるが、言葉が違う
      // 結果: 「待合室」が「誰かの場所」になった
      {
        id: "ch8_s4",
        lines: [
          { speaker: "", text: "しずくさんはコーヒーを飲み干した。", is_choice: false, choices: [] },
          { speaker: "", text: "カップの底に、何も残っていない。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "父は……この店を「待合室」みたいに思ってたんだと思います。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "いつか誰かが来るまで、灯りをつけておく場所。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "でも今は、待合室じゃない。ちゃんと「誰かの場所」になってる。", is_choice: false, choices: [] },
          { speaker: "", text: "しずくさんが立ち上がった。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から差し込む午後の光が、彼女の横顔を照らしている。", is_choice: false, choices: [] },
          { speaker: "", text: "初めてここに来た日、佐倉さんの横顔を照らしていたのと同じ光。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "ごちそうさまでした。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアに手をかける。", is_choice: false, choices: [] },
          { speaker: "", text: "振り返った。", is_choice: false, choices: [] },
          { speaker: "藤宮しずく", text: "——また、来てもいいですか。", is_choice: false, choices: [] },
          { speaker: "", text: "「ごちそうさま」ではなく、「また」。", is_choice: false, choices: [] },
          { speaker: "", text: "あの日の佐倉さんとは、違う言葉。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "もちろん。いつでも。", is_choice: false, choices: [] },
          { speaker: "", text: "しずくさんは小さく笑って、ドアを開けた。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルの音が、路地に響いて消えた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s5",
      },
      // --- Scene 5: エピローグ ---
      // 前提: しずくが帰った直後。佐倉と天野がいる。
      //   場所: 月灯里（同日）
      //   時間: 同日の夕方
      //   知識: 全てが明かされた後。
      // 変化: 佐倉の「いい店ね」（「悪くない」→「いい店」への変化 = 承認）
      //   日常の音が響く → 場所は人が集まることで生きている
      // 結果: 物語の完結。月灯りは今日も灯っている。
      {
        id: "ch8_s5",
        lines: [
          { speaker: "", text: "しずくさんが去った後、店内に静かな時間が戻った。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……すげえもん見ちゃったな。", is_choice: false, choices: [] },
          { speaker: "", text: "天野くんがぼそりと言った。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……いい店ね、ここ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがそう言ったのは、初めてだった。", is_choice: false, choices: [] },
          { speaker: "", text: "「悪くない」ではなく。", is_choice: false, choices: [] },
          { speaker: "", text: "「いい店」。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターを拭く。いつもの動作。", is_choice: false, choices: [] },
          { speaker: "", text: "エスプレッソマシンが、午後の光を受けて静かに光っている。", is_choice: false, choices: [] },
          { speaker: "", text: "藤宮時雨が守り、僕が受け継いだもの。", is_choice: false, choices: [] },
          { speaker: "", text: "場所は、人が集まることで生きている。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんがページをめくる音。天野くんのペンが走る音。", is_choice: false, choices: [] },
          { speaker: "", text: "遠くから、商店街の喧騒がかすかに聞こえる。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外、路地に夕日が差し始めていた。", is_choice: false, choices: [] },
          { speaker: "", text: "『月灯り』は、今日も静かに灯っている。", is_choice: false, choices: [] },
          { speaker: "", text: "——Fin.", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
