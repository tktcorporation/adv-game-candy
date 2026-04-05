// ============================================================
// 第二章: 豆を変えたら
// ============================================================
//
// あらすじ:
//   コーヒーを改善したい主人公がスーパーに豆を買いに行く。
//   そこで偶然佐倉に遭遇。佐倉は黙って特定の豆の袋を指差して去る。
//   カフェに戻り、その豆で淹れ直す。佐倉がいつも通り来店、飲んで
//   「ごちそうさま」——だが天野は「今日ちょっと長くなかった？」と気づく。
//   言葉は変わらない。でも滞在時間が少しだけ変わった、かもしれない。
//
// 登場キャラ: 佐倉美月、天野蓮
// キーイベント:
//   - 主人公がコーヒー改善に本気になり始める
//   - スーパーで佐倉と偶然遭遇（カフェ外で初めて会う）
//   - 佐倉が豆を指差す（無言のアドバイス。コーヒーに詳しい伏線）
//   - 滞在時間の微細な変化（天野だけが気づく）
//
// --- 章の状態差分 ---
// 開始状態: 天野がバイトに入り、店が少し賑やかに。コーヒーはまだ素人の味。
// 終了状態: 佐倉が指差した豆でコーヒーを改善。佐倉の反応は言葉上は変わらないが、
//   滞在時間が微妙に伸びた（天野だけが気づく程度の変化）。
//   主人公の変化: 「美味しいと思ってもらえるコーヒーを淹れたい」と自覚
//   店の変化: 豆が変わった（スーパーの豆→佐倉が指差した豆）
//   関係性: 佐倉（カフェ外で初遭遇。名前はまだ知らない。コーヒーに詳しい？）
//            天野（佐倉の変化に敏感な観察者として機能し始める）
// ============================================================

/// Chapter 2: 豆を変えたら
pub fn get_chapter_2() -> Chapter {
  {
    id: 2,
    title: "第二章",
    subtitle: "豆を変えたら",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 1,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: もうちょっとマシなコーヒーを ---
      // 前提: 天野が加わって数日。主人公は自分のコーヒーの味に不満を持っている
      // 変化: 天野に「豆が悪いのでは」と指摘され、スーパーに買いに行くことに
      // 結果: 主人公、コーヒー改善に動き始める
      {
        id: "ch2_s0",
        lines: [
          { speaker: "", text: "天野がバイトに入って数日。店のリズムが少しずつできてきた。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、一つだけ変わらないことがある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……うーん。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "どしたんすか店長。渋い顔して。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "コーヒー。もうちょっとなんとかならないかなって。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "え、今のでいいんじゃないすか？ あたし飲めるっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "天野の「飲める」はあんまり参考にならない。ココアしか頼まないだろ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "バレてた。あはは。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "毎日あの人が来て、毎日何の反応もなくて。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "せめて一回くらい、何か言わせたいんだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あー、窓際の人っすね。確かに、あの無反応は気になるっすよね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でも店長、そもそも豆ってどこで買ってんすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おばさんが置いてった棚の残り。もうほとんどない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっ、ずっとそれ使ってたんすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……他に何使えばいいか分かんなくて。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いや、まずそこからじゃないすか！ 豆買いに行きましょうよ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "買いに行くって……どこに。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "スーパーっすよスーパー。とりあえず。専門店は敷居高いし。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "スーパーのコーヒー豆で大丈夫なのか……？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "今の「おばさんの残り物」よりはマシっしょ！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それはそう。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "じゃ、あたし店番してるんで行ってきてくださいっす。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "一人で店番大丈夫？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "余裕っすよ。客来なかったら木目数えてるんで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それは俺への嫌味か。", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s1",
      },
      // --- Scene 1: スーパーでの遭遇 ---
      // 前提: 主人公がスーパーのコーヒー豆コーナーで悩んでいる
      // 知識: 佐倉はコーヒーに詳しい（実家がコーヒー好き）。主人公はそれを知らない
      // 変化: 佐倉がスーパーにいて、豆の袋を黙って指差して去る
      // 結果: 主人公は困惑しつつその豆を買う。佐倉がコーヒーに詳しい？という疑問
      {
        id: "ch2_s1",
        lines: [
          { speaker: "", text: "近所のスーパー。コーヒー豆のコーナーに来た。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……種類多すぎないか。", is_choice: false, choices: [] },
          { speaker: "", text: "ブラジル、コロンビア、エチオピア、グアテマラ——", is_choice: false, choices: [] },
          { speaker: "", text: "「深煎り」「中煎り」「浅煎り」。パッケージに書いてある説明が全部同じに見える。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「芳醇なコクと豊かな香り」……それ全部に書いてない？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "「バランスの取れた味わい」……バランスって何。", is_choice: false, choices: [] },
          { speaker: "", text: "棚の前で腕を組んで5分。完全に詰んでいる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……適当に選ぶか。もう。", is_choice: false, choices: [] },
          { speaker: "", text: "手を伸ばしかけた時——", is_choice: false, choices: [] },
          { speaker: "", text: "視界の端に、栗色の髪が映った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……え。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんだった。", is_choice: false, choices: [] },
          { speaker: "", text: "カフェの外で見るのは初めてだ。白いニットにロングスカート。買い物かごを持っている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ……どうも。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは主人公の顔を見て、それからコーヒー豆の棚を見た。", is_choice: false, choices: [] },
          { speaker: "", text: "何かを品定めするように、一瞬だけ目を細めて——", is_choice: false, choices: [] },
          { speaker: "", text: "棚の中段にある、一つの袋を指差した。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え——", is_choice: false, choices: [] },
          { speaker: "", text: "グアテマラ。中深煎り。「チョコレートのような甘みとナッツの余韻」と書いてある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あの、これが——", is_choice: false, choices: [] },
          { speaker: "", text: "振り返った時には、佐倉さんはもう歩いていた。", is_choice: false, choices: [] },
          { speaker: "", text: "買い物かごを持ったまま、すたすたと別の売り場に消えていく。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……行っちゃった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんだったんだ今の。", is_choice: false, choices: [] },
          { speaker: "", text: "指差された豆の袋を手に取る。特別高いわけでもない。普通のスーパーの豆。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……でも、あの人がわざわざ指差すってことは。", is_choice: false, choices: [] },
          { speaker: "", text: "理由は分からない。でも、なんとなく信じてみようと思った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……コーヒーに詳しいのか、あの人。", is_choice: false, choices: [] },
          { speaker: "", text: "レジに向かいながら、カフェでの佐倉さんを思い出す。", is_choice: false, choices: [] },
          { speaker: "", text: "何を出しても無表情。「ごちそうさま」だけ。", is_choice: false, choices: [] },
          { speaker: "", text: "——でも今、確かに豆を選んでくれた。迷いなく。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……不思議な人だな、ほんとに。", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s2",
      },
      // --- Scene 2: 新しい豆で淹れる ---
      // 前提: 主人公がスーパーから戻った。天野が店番中
      // 変化: 買ってきた豆で淹れ直す。自分で飲んで「前よりいい」と感じる
      // 結果: 佐倉が来る準備が整った
      {
        id: "ch2_s2",
        lines: [
          { speaker: "天野蓮", text: "おかえりっす。買えました？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ああ。……ちょっと変なことがあったけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "変なこと？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "スーパーであの——窓際の人に会った。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えっ、マジすか！ 話したんすか！？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、話してない。一言も。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……は？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "俺がコーヒー豆の前で悩んでたら、黙ってこれ指差して、行った。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……なにそれ。RPGの導きの精霊みたいじゃないすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "例えがおかしいけど、まあそんな感じ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "へー。あの人コーヒー分かるんすかね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "分からない。でも迷いがなかった。一発で指差した。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "おー。じゃあ早速淹れてみましょうよ。", is_choice: false, choices: [] },
          { speaker: "", text: "袋を開ける。豆の色は前のものより少し明るい。", is_choice: false, choices: [] },
          { speaker: "", text: "ミルで挽く。……香りが違う。甘い匂いがする。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわ、いい匂い。前のと全然違うっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……確かに。", is_choice: false, choices: [] },
          { speaker: "", text: "丁寧にお湯を注ぐ。今回はちゃんと蒸らした。スマホで調べた「蒸らし30秒」を守る。", is_choice: false, choices: [] },
          { speaker: "", text: "……できた。", is_choice: false, choices: [] },
          { speaker: "", text: "一口飲む。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……あ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "どうすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……前よりいい。確実に。まだ全然プロには程遠いけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "飲んでいいすか。……おっ、ほんとだ。なんか丸い味するっすね。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "丸い味って何。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、なんていうか……とんがってない？ 前のは舌刺す感じだったけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それ、割と的確かもしれない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えへへ。あたしの舌もまんざらじゃないっしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "普段ココアしか飲まない舌だけどな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "それ関係ないっす！", is_choice: false, choices: [] },
        ],
        next_scene: "ch2_s3",
      },
      // --- Scene 3: ちょっとだけ長かった ---
      // 前提: 午後。佐倉がいつも通り来店。今日は新しい豆のコーヒー
      // 知識: 佐倉はこの豆を自分で指差した。それを飲むことを知っている
      // 変化: 佐倉は「ごちそうさま」で帰る。言葉は同じ。だが天野が「今日長くなかった？」と気づく
      // 結果: 言葉は変わらない。でも何かが変わったかもしれない——そう思わせる
      {
        id: "ch2_s3",
        lines: [
          { speaker: "", text: "午後。カランカラン。佐倉さんが入ってきた。いつもと同じ時間。", is_choice: false, choices: [] },
          { speaker: "", text: "窓際の奥の席に座る。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーを。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。", is_choice: false, choices: [] },
          { speaker: "", text: "新しい豆で淹れる。あの人が指差した豆で。カップを運ぶ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どうぞ。……今日、豆変えてみたんですけど。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "本のページをめくる手が一瞬止まった。ような気がした。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんはカップに手を伸ばし、一口。……表情は変わらない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……やっぱり、何も言わないか)", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）どうだったすか？ 反応あった？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……（小声）ない。いつも通り。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……（小声）そっすか。まあ、そう簡単にはいかないすよね。", is_choice: false, choices: [] },
          { speaker: "", text: "——40分後。佐倉さんが本を閉じて、立ち上がった。カップは空。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。いつもと同じ言葉。同じ表情。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "……ね、店長。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ん？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あの人、今日ちょっと長くなかったすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……長い？", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いつも30分くらいじゃないすか。今日40分いたっすよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうだっけ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "そうっすよ。あたし時計見てたもん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんで計ってるんだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "だって気になるじゃないすか！ あの人の生態！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "生態って。野生動物じゃないんだから。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でも10分長いって、結構なことじゃないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……たまたまだろ。本が面白かっただけかもしれない。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "そうっすかね〜。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんだよその顔。ニヤニヤして。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "べっつに〜。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "でもあたし思うんすけど、あの人ちゃんと分かってるっすよ。豆変わったの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……そうかな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "だって自分で選んだ豆じゃないすか。そりゃ分かるっしょ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それはそうか。", is_choice: false, choices: [] },
          { speaker: "", text: "空になったカップを洗う。いつもの「ごちそうさま」。でも10分長かった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、豆は正解だったのかもな。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
