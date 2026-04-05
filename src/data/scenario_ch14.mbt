// ============================================================
// 第十四章: 届け物
// ============================================================
//
// あらすじ:
//   佐倉がカフェに本を忘れた。主人公が届けに行く。
//   初めて佐倉の住む場所——質素なアパートの前に立つ。
//   佐倉は家着（オーバーサイズのシャツ）で出てきて動揺。
//   「お茶くらい出す」→「やっぱいい」の高速撤回。
//   玄関先での短い時間。佐倉が「客」から「一人の人」に変わる瞬間。
//   佐倉が初めて自分の過去に触れる:「……前の人のコーヒー、好きだった」。
//   主人公「じゃあなんで俺のコーヒー飲んでんの」→佐倉、答えない。
//
// 登場キャラ: 佐倉美月、天野蓮
// キーイベント:
//   - 佐倉の忘れ物を届ける（主人公→佐倉の家）
//   - 佐倉の家着姿（オーバーサイズのシャツ）
//   - 「お茶くらい出す」→「やっぱいい」
//   - 「前の人のコーヒー、好きだった」（おばさん時代への言及）
//   - 佐倉が「カフェの客」から「一人の人」に変わる
//
// --- 章の状態差分 ---
// 開始状態: ch13でパワーシフトが起きた。主人公が頑張るのをやめ、
//   佐倉がそわそわし始めた。佐倉はカウンター席が定位置。
//   おばさんの「あと半年帰れない」で店の将来が不透明。
// 終了状態: 佐倉の私生活を初めて垣間見た。「カフェの客」という枠が外れた。
//   主人公の変化: 佐倉を「一人の人」として意識し始める。家着の姿が頭に残る。
//   店の変化: なし
//   関係性: 佐倉（カフェの外で会った。家着を見た。「前の人」発言が引っかかる）
//           天野（忘れ物に気づき、届けるよう仕向けた）
// ============================================================

/// Chapter 14: 届け物
///
/// 背景: 承後半の終盤。佐倉が「カフェの客」から「生活者としての一人の人」に
/// 変わる転換点。カフェという舞台装置の外で二人が向き合うことで、
/// 関係性のレイヤーが一段深くなる。
/// 佐倉の「前の人のコーヒー」発言は、おばさん時代からの常連であることの
/// 伏線回収であり、ch16以降の「好き」の文脈に繋がる。
pub fn get_chapter_14() -> Chapter {
  {
    id: 14,
    title: "第十四章",
    subtitle: "届け物",
    unlock_revenue: 32000,
    unlock_recipes: 32,
    unlock_customers: 10,
    unlock_intimacy: 2800,
    scenes: [
      // --- Scene 0: 忘れ物 ---
      // 前提: 閉店作業中。佐倉が帰った後。
      //   場所: 月灯り（閉店後）
      //   時間: 夕方
      //   知識: 佐倉はいつも文庫本を持っている。忘れることは珍しい。
      //   ch13で佐倉がそわそわし始めている状態。
      // 変化: 佐倉の席に本が残っている。天野が見つける。
      //   天野が「届けたら？」と仕向ける。主人公は佐倉の住所を知らない。
      //   天野が「あの方向に帰ってくの見たことある」とヒントを出す。
      // 結果: 主人公が本を届けに行くことに
      {
        id: "ch14_s0",
        lines: [
          { speaker: "", text: "閉店後。テーブルを拭いていた天野が声を上げた。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あれ、店長。佐倉さんの席に本、忘れてないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……佐倉さんの席に本、残ってるな。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "うわ、マジだ。佐倉さんが本忘れるとか初めてじゃないすか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だよな。明日返せばいいか。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "えー、毎晩読んでるかもしんないっすよ？ 届けてあげたら？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "届けるって……佐倉さんの家知らないんだけど。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あー、あたし前に見たんすよ。帰る方向。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "商店街抜けて、橋渡って、右に曲がった先のアパートの辺り。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "見てたのかよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "たまたまっす。たまたま。いい機会じゃないすか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いい機会って何の。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "聞きます？ 説明します？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いい。行ってくる。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "しおり挟んであるっすよ。読みかけだ。今日中に届けた方がいいっすね。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "いってらっしゃいっす！ あたし鍵閉めて帰るんで！", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんでそんな嬉しそうなんだよ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "別に？ 普通っすけど？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ニヤニヤしてるだろ。顔に出てるぞ。", is_choice: false, choices: [] },
          { speaker: "天野蓮", text: "あたしいつもこんな顔っすよ！", is_choice: false, choices: [] },
        ],
        next_scene: "ch14_s1",
      },
      // --- Scene 1: 佐倉の住む街 ---
      // 前提: 主人公が本を持って佐倉の家の方向へ向かう。
      //   場所: 商店街→橋→住宅街
      //   時間: 夕方〜夕暮れ
      //   知識: 主人公は佐倉のプライベートをほとんど知らない。
      //   佐倉がどこに住んでいるか、何をしているか、何も。
      // 変化: 歩きながら、佐倉について知らないことの多さに気づく。
      //   アパートが見える。質素だけど清潔な建物。
      //   佐倉の名前が郵便受けにある。急に緊張する。
      // 結果: 佐倉の家の前に着いた
      {
        id: "ch14_s1",
        lines: [
          { speaker: "", text: "商店街を抜ける。夕暮れ。橋を渡って、右に曲がる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……考えてみたら、佐倉さんのこと全然知らないな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "毎日会ってるのに。どこに住んでて、何してて、休みの日は何してるか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "名前と、コーヒーの好みと、読んでる本のジャンルくらいか。知ってるの。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……それで十分だと思ってたけど。", is_choice: false, choices: [] },
          { speaker: "", text: "小さなアパートが見えた。2階建て。古いけど、手入れはされている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……郵便受けに「佐倉」。ここか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんで緊張してんだ。本を返しに来ただけだろ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……よし。", is_choice: false, choices: [] },
          { speaker: "", text: "インターホンを押した。", is_choice: false, choices: [] },
        ],
        next_scene: "ch14_s2",
      },
      // --- Scene 2: 玄関先 ---
      // 前提: インターホンを押した。佐倉の家の前。
      //   場所: 佐倉のアパート・玄関前
      //   時間: 夕暮れ
      //   知識: 佐倉は家では家着（オーバーサイズのシャツ）。
      //   カフェでのクールな佐倉しか知らない主人公。
      // 変化: 佐倉がドアを開ける。オーバーサイズのシャツ。髪を下ろしている。
      //   カフェとは全く違う雰囲気。主人公は言葉を失う。
      //   佐倉は主人公を見て固まる。「……なんで」。
      //   本を忘れたことを伝える。佐倉の動揺。
      //   「お茶くらい出す」→「やっぱいい」の高速撤回。
      // 結果: 佐倉の私的な姿を見た
      {
        id: "ch14_s2",
        lines: [
          { speaker: "", text: "数秒の沈黙。ドアが開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "髪を下ろしている。オーバーサイズの白いシャツ。素足。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……誰だ。いや、佐倉さんだ。全然印象が違う)", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なんで。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、えっと——本。忘れてた。", is_choice: false, choices: [] },
          { speaker: "", text: "文庫本を差し出す。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……あ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ちょっと待って。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが半分閉まりかけた。でも本を受け取らないと閉められない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(隠れたいけど本は欲しい、みたいな角度でドア押さえてる……)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……はい。読みかけみたいだったから、今日中の方がいいかと思って。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……どうも。", is_choice: false, choices: [] },
          { speaker: "", text: "本を受け取る。指が少し触れた。佐倉さんが本を胸の前で抱えた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……わざわざ悪い。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、近かったし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……近くない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、そこそこ歩いたけど。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……お茶くらい出す。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え、いいの？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……やっぱいい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "早っ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……散らかってるから。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "見ないよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ダメ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "頑なだな……。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……そういう問題じゃない。こんな格好で客に会うとか……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "今は客じゃないだろ。届け物しに来ただけの人。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……それも嫌。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ドアの隙間から見えるけど、全然散らかってないじゃん。本棚すごいな。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……意外って何。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、なんとなく。", is_choice: false, choices: [] },
        ],
        next_scene: "ch14_s3",
      },
      // --- Scene 3: 前の人のコーヒー ---
      // 前提: 玄関先で話している。夕暮れの光。
      //   場所: 佐倉のアパート・玄関前
      //   時間: 夕暮れ
      //   知識: 佐倉はおばさんの時代からの常連。主人公はそこまで詳しく知らない。
      //   佐倉が毎日来る理由は明言されていない。
      // 変化: 玄関先の空気が少し柔らかくなる。
      //   佐倉が「前の人のコーヒー、好きだった」と漏らす。
      //   「前の人」＝おばさん。佐倉がなぜ毎日来るかのヒント。
      //   主人公「じゃあなんで俺のコーヒー飲んでんの」→佐倉、答えない。
      //   この沈黙が、佐倉の本当の気持ちの在処を示唆する。
      // 結果: 佐倉の「なぜ毎日来るか」の答えが、コーヒーではないことが示唆された
      {
        id: "ch14_s3",
        lines: [
          { speaker: "", text: "夕日がアパートの廊下に差し込んでいる。佐倉さんがドアの枠にもたれた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……あの店、長いの？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "え？ いや、俺はまだ数ヶ月だけど。おばさんがずっとやってた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……知ってる。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……もしかして、おばさんの時から来てた？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……前の人のコーヒー、好きだった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "前の人って……おばさんのこと？ コーヒー上手かったのか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……上手いとかじゃない。なんか……落ち着いた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "おばさん自体がゆるいもんな。あの人の周りって、空気が柔らかいっていうか。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……うん。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(——「うん」って言った。否定じゃなくて。珍しい)", is_choice: false, choices: [] },
          { speaker: "主人公", text: "じゃあ……俺のコーヒーは？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……普通。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "だよな。知ってた。毎日「普通」って言われてるし。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……毎日言ってない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "体感毎日だよ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……二日に一回くらい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "数えてるの？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……数えてない。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "じゃあなんで俺のコーヒー飲んでんの。前の人のが好きだったなら。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "…………。", is_choice: false, choices: [] },
          { speaker: "", text: "佐倉さんは答えなかった。夕日の方を見ている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……横顔赤いけど。夕日のせい？", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……夕日のせい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあいいけど。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……帰って。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はいはい。じゃあ、また明日。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "佐倉さん。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……なに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "本、カフェに忘れないでよ。次届けに来る口実なくなるから。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……バカ。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが閉まった。少し間があって、鍵の音。すぐには閉めなかったのか。", is_choice: false, choices: [] },
        ],
        next_scene: "ch14_s4",
      },
      // --- Scene 4: 帰り道 ---
      // 前提: 佐倉の家から帰る。夕暮れの道。
      //   場所: 住宅街→商店街
      //   時間: 夕暮れ
      //   知識: 佐倉の家着を見た。「前の人のコーヒー」発言を聞いた。
      //   答えなかった沈黙の意味がまだ分からない。
      // 変化: 帰りながら、佐倉の別の一面を反芻する。
      //   カフェの客ではない佐倉。家で一人で過ごしている佐倉。
      //   「なんで俺のコーヒー飲んでるんだろう」が頭から離れない。
      //   家に帰ってからも、髪を下ろした佐倉の姿が頭に残る。
      // 結果: 佐倉が「一人の人」として主人公の中に定着した
      {
        id: "ch14_s4",
        lines: [
          { speaker: "", text: "帰り道。橋を渡る。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なんで答えなかったんだろ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "前の人のコーヒーが好きだったのに、俺のを毎日飲みに来る理由。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "惰性？ 近いから？ 他に行く店がないとか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……いや。あの人、コンビニで十分って言ったことあるし。わざわざ来る理由がないなら来ない人だろ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……分かんねえ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……髪、下ろしてたな。カフェの時と全然違った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あの人にも一人で過ごす夜があるんだよな。当たり前なのに。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……明日、いつも通りに接せるかな。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "渡す時に指、触れたな。——いや、覚えすぎだろ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "本を返しに行っただけだ。それ以上でもそれ以下でもない。", is_choice: false, choices: [] },
          { speaker: "", text: "自分にそう言い聞かせた。", is_choice: false, choices: [] },
          { speaker: "", text: "——でも。「……前の人のコーヒー、好きだった」。あの声が、ずっと耳に残っていた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
