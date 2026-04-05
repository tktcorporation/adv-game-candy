// ============================================================
// 第三章: ツンデレ先輩
// ============================================================
//
// あらすじ:
//   新しい豆でコーヒーが改善され、主人公も淹れ方を研究し始めた。
//   佐倉がいつも通り来店。飲んで「ごちそうさま」——だが帰り際に
//   わずかに立ち止まった。天野だけが気づく。
//   「佐倉さん今日ちょっと止まらなかった？」——天野は佐倉を
//   「ツンデレ先輩」と名付ける。佐倉は不快そうにするが、翌日も来る。
//   天野と佐倉の掛け合いが始まり、店の空気が変わっていく。
//
// 登場キャラ: 佐倉美月、天野蓮
// キーイベント:
//   - 佐倉が帰り際にわずかに立ち止まる（最初のヒビ。無意識の変化）
//   - 天野が佐倉を「ツンデレ先輩」と呼ぶ（キャラ間の関係線の確立）
//   - 佐倉が天野に対して初めて感情を見せる（不快→でも来る）
//   - 佐倉の名前が判明する（天野が直接聞く）
//
// --- 章の状態差分 ---
// 開始状態: 豆が変わりコーヒーは前より良くなった。佐倉は無反応の常連。
// 終了状態: 佐倉に最初の変化（帰り際の一瞬の立ち止まり）。
//   天野が佐倉を「ツンデレ先輩」と呼び始め、佐倉の名前も判明。
//   佐倉は天野を迷惑そうにしつつも、翌日も来る。
//   主人公の変化: 佐倉の微細な変化に天野経由で気づき始める
//   店の変化: 天野と佐倉の掛け合いが生まれ、店が「場所」になりつつある
//   関係性: 佐倉（名前判明。わずかに壁にヒビ）、天野（佐倉をいじる担当として確立）
// ============================================================

/// Chapter 3: ツンデレ先輩
pub fn get_chapter_3() -> Chapter {
  {
    id: 3,
    title: "第三章",
    subtitle: "ツンデレ先輩",
    unlock_revenue: 0,
    unlock_recipes: 1,
    unlock_customers: 2,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: 研究の日々 ---
      // 前提: 豆を変えてから数日。主人公は淹れ方も研究し始めている
      // 変化: 少しずつコーヒーが上達している。天野は相変わらず元気
      // 結果: 「今日こそ何か反応あるかも」と期待する日常が描かれる
      {
        id: "ch3_s0",
        lines: [
          { speaker: "", text: "豆を変えてから、毎朝の開店準備が変わった。", is_choice: false, choices: [] },
          { speaker: "", text: "スマホで淹れ方の動画を見る。湯温は何度がいいか。注ぎ方はどうか。", is_choice: false, choices: [] },
          { speaker: "", text: "蒸らし時間を5秒変えるだけで味が変わるらしい。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おっす店長！ 今日もやってんすねコーヒー研究。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ああ。湯温を85度にしてみたんだけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしに言われてもさっぱりっすよ。飲んでみていいすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……ん。おっ、なんか前より……ええと、まろい？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「まろい」って日本語ないけど。まあ言いたいことは分かる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あはは。でもマジで美味しくなってるっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうだといいんだけどな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "今日こそ窓際の人から何か反応もらえるかもっすよ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……期待しないでおく。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、夢がないっすね〜。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "現実を見てるだけだ。あの人の「ごちそうさま」は鉄壁だぞ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "鉄壁のごちそうさま。なんかカッコいいっすね。必殺技みたい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "全然カッコよくない。こっちはダメージ受けてる側だから。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s1",
      },
      // --- Scene 1: 一瞬の立ち止まり ---
      // 前提: 午後。佐倉が来店。新しい豆+改善した淹れ方のコーヒーを出す
      // 知識: 佐倉は前回の豆を自分で指差した。その豆で淹れている
      // 変化: 佐倉が帰り際にわずかに立ち止まる。天野だけが気づく
      // 結果: 言葉は変わらない。でも「立ち止まった」——最初のヒビ
      {
        id: "ch3_s1",
        lines: [
          { speaker: "", text: "午後。カランカラン。佐倉さんが入ってくる。窓際の奥の席。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーを。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。", is_choice: false, choices: [] },
          { speaker: "", text: "今日の一杯。豆はあの人が指差したグアテマラ。湯温85度。蒸らし30秒。", is_choice: false, choices: [] },
          { speaker: "", text: "自分なりに、ベストを尽くした。", is_choice: false, choices: [] },
          { speaker: "", text: "カップを運ぶ。佐倉さんは本を読んでいる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはカップに手を伸ばし、一口飲んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "……本に視線を戻す。", is_choice: false, choices: [] },
          { speaker: "", text: "いつも通りだ。何も変わらない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……だよな)", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターに戻る。天野がこっちを見て、肩をすくめた。", is_choice: false, choices: [] },
          { speaker: "", text: "35分後。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが本を閉じた。カップは空。立ち上がる。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアに向かう。——ドアノブに手をかけた瞬間、佐倉さんの足が止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "ほんの一瞬。振り返りかけて——やめた。カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "主人公はカップを下げに行っていて、気づかなかった。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの人今、ちょっと止まらなかった？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……止まった？ どこで？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ドアのとこ。出る直前に一瞬。振り返りかけて、やめたっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……見間違いじゃない？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "見間違いじゃないっすよ。あたしずっと見てたもん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ずっと見てたのか……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "だって面白いんすもん、あの人。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……でも、一瞬止まっただけだろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "その「一瞬」がすごいんじゃないすか。今まで完全にノーリアクションだったのに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "豆変えたの、効いてるんじゃないすかね。", is_choice: false, choices: [] },
          { speaker: "", text: "天野の言葉に、少しだけ胸が軽くなった。", is_choice: false, choices: [] },
          { speaker: "", text: "……気のせいかもしれない。でも、ゼロじゃなかった。たぶん。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s2",
      },
      // --- Scene 2: 命名「ツンデレ先輩」 ---
      // 前提: 翌日。天野が佐倉に興味津々。今日も佐倉は来るはず
      // 変化: 天野が佐倉に直接話しかけ、名前を聞き出す。「ツンデレ先輩」と命名
      // 結果: 佐倉は不快そうだが、天野のペースに巻き込まれつつある
      {
        id: "ch3_s2",
        lines: [
          { speaker: "天野蓮", text: "ね〜店長、今日も来るかなあ、佐倉さん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "来るだろ。毎日来るから。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "よし。今日はあたし、あの人に話しかけるっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "やめとけ。迷惑になる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "大丈夫っすよ。接客の一環ってことで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……不安しかない。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。佐倉さんが入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "窓際の席に座る。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーを。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "はいっす！ ただいま！", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんが一瞬だけ顔を上げた。天野を見て——何も言わず、本を開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れて、天野がカップを運ぶ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "どうぞっす！ ……あの、毎日来てくださってありがとうございますっす！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたし新しく入ったバイトの天野っす。よろしくっす！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……どうも。", is_choice: false, choices: [] },
          { speaker: "", text: "最小限の返事。でも返事があった。天野は引かない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの、お名前聞いてもいいすか？ 常連さんなのにお名前知らなくて。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……佐倉。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "佐倉さん！ よろしくっす佐倉さん！", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……元気ね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "よく言われるっす！ えへへ。", is_choice: false, choices: [] },
          { speaker: "", text: "天野がカウンターに戻ってくる。小さくガッツポーズ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）名前ゲットっす。佐倉さんっていうんすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……（小声）よく聞けたな。俺、何日通われても聞けなかったのに。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）聞けばいいだけじゃないすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……（小声）それはそうなんだけど。", is_choice: false, choices: [] },
        ],
        next_scene: "ch3_s3",
      },
      // --- Scene 3: それでも来る ---
      // 前提: 佐倉が帰った後。天野が「ツンデレ先輩」と名付ける
      // 変化: 翌日、佐倉が「ツンデレ先輩」呼びに不快を見せるが、また来る
      // 結果: 天野×佐倉のラインが確立。佐倉は迷惑そうだが壁が少しずつ崩れている
      {
        id: "ch3_s3",
        lines: [
          { speaker: "", text: "佐倉さんが帰った後。天野が腕を組んで唸っている。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うーん。あの佐倉さんって人、なんかこう……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんかこう、なに。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "クールっていうか、壁があるっていうか。でも毎日来るし、昨日はちょっと止まったし。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あれっすよ。ツンデレっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ツンデレ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "間違いないっす。毎日来てんのに無反応って、もうツンデレの教科書っしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いやいや、ツンデレって好意が前提だろ。あの人は別に——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "毎日来てる時点で好意っしょ。コーヒー一杯のために毎日通う？ 普通しないっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "決めた。あたしの中で佐倉さんは今日から「ツンデレ先輩」っす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "本人に言うなよ絶対。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えへへ〜。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "その笑い方が一番不安なんだけど。", is_choice: false, choices: [] },
          { speaker: "", text: "——翌日。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。佐倉さんが入ってくる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あっ、佐倉先輩こんにちわっす！", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの眉がぴくりと動いた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……先輩？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "だって佐倉さん常連の先輩じゃないすか。あたしより先にこの店来てたんだし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……別にそういうのじゃない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え〜、いいじゃないすか。佐倉先輩！ 今日もいつもの席っすか？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは何か言いたそうにしたが、結局何も言わず窓際の席に座った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……（小声）おい天野。先輩呼びは——", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）大丈夫大丈夫。嫌がってるようで嫌がってないっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……（小声）どこを見てそう判断してるんだ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）だって、本当に嫌なら明日から来ないっしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れて運ぶ。いつも通り佐倉さんは本を読んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "——が、ページをめくるスピードが普段より少し速い気がする。", is_choice: false, choices: [] },
          { speaker: "", text: "35分後。佐倉さんが立ち上がる。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ありがとうございます佐倉先輩！ また明日っすね！", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは天野をちらりと見た。少し目が細くなった。", is_choice: false, choices: [] },
          { speaker: "", text: "怒っているのか、呆れているのか——どちらとも取れる表情。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……好きに呼べば。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "やった！ 公認っす！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あれ公認なのか……？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "「好きに呼べば」っすよ？ これ許可っしょ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「諦め」とも言うけどな……。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ねえ店長。佐倉先輩、絶対明日も来るっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、たぶんな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でしょ！ あの人、口では迷惑そうにしてるけど、嫌じゃないっすよあれ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "ほら、やっぱツンデレっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうなのかな。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんの席を片付ける。カップは空。「好きに呼べば」——今までで一番長い台詞だった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ま、天野のおかげかもな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おっ、素直っすね店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "たまにはな。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外は夕焼けだった。佐倉さんがいつも通る道が、オレンジ色に染まっている。", is_choice: false, choices: [] },
          { speaker: "", text: "明日もきっと、同じ時間に、同じ席に、あの人は座る。", is_choice: false, choices: [] },
          { speaker: "", text: "そう思うと——悪くない気分だった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
