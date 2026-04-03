// ============================================================
// 第零章: 廃墟と最初の一杯
// ============================================================
//
// あらすじ:
//   前職のチェーン飲食店を辞め、行き詰まっていた主人公。
//   不動産屋から紹介された2年間空きの物件を内見し、契約を決意する。
//   2週間後の開店準備日、掃除と設備チェックの合間にコーヒーを淹れてみる。
//   換気のため開放していたドアから、元常連の佐倉美月がコーヒーの匂いに
//   引き寄せられて入ってくる。「前の人は、もっと上手でしたよ」。
//
// 登場キャラ: 佐倉美月（？？？として）
// キーイベント:
//   - 主人公の背景（Ordinary World: 前職を辞めた経緯）
//   - 不動産屋の言葉「いつか誰かが必要とする時に」（三度触れ #1: 書き置き）
//   - エスプレッソマシンのカバー（三度触れ #1: マシン）
//   - 「前の人は上手でした」（三度触れ #1: 前の人）
//   - 窓から差す光（三度触れ #1: 光）
//   - 佐倉がこの店を「知っている」違和感（問われない問い）
//
// Want: カフェをやってみたい（漠然とした希望）
// Need: 自分の居場所を見つけること
// ============================================================

/// Chapter 0: 廃墟と最初の一杯
pub fn get_chapter_0() -> Chapter {
  {
    id: 0,
    title: "第零章",
    subtitle: "廃墟と最初の一杯",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 0,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: プロローグ — 主人公の経緯（Ordinary World） ---
      // 前提: 主人公は前職を辞めて3ヶ月、何もできずにいる
      // 目的: 不動産屋に紹介された物件の内見に向かう
      // 変化: 「いつか誰かが必要とする時に」という言葉に引っかかる
      // 結果: 内見に行く決意をした状態
      {
        id: "ch0_s0",
        lines: [
          { speaker: "", text: "三ヶ月前に、仕事を辞めた。", is_choice: false, choices: [] },
          { speaker: "", text: "チェーンの飲食店。4年間、毎日同じものを作り続けた。", is_choice: false, choices: [] },
          { speaker: "", text: "マニュアル通りの味。マニュアル通りの笑顔。マニュアル通りの「ありがとうございました」。", is_choice: false, choices: [] },
          { speaker: "", text: "辞めた理由は、うまく説明できない。", is_choice: false, choices: [] },
          { speaker: "", text: "限界だったのか、贅沢だったのか、自分でも分からない。", is_choice: false, choices: [] },
          { speaker: "", text: "ただ、あのカウンターの中にいると——息ができなくなった。", is_choice: false, choices: [] },
          { speaker: "", text: "それから三ヶ月。貯金を食い潰しながら、何もできずにいた。", is_choice: false, choices: [] },
          { speaker: "", text: "昨日、不動産屋から連絡があった。", is_choice: false, choices: [] },
          { speaker: "", text: "以前「飲食ができる物件があれば」と相談していたのを覚えていたらしい。", is_choice: false, choices: [] },
          { speaker: "", text: "「2年間引き取り手のない物件がある。家賃はほとんどかからない」", is_choice: false, choices: [] },
          { speaker: "", text: "「前のオーナーが変わった言葉を残していてね」", is_choice: false, choices: [] },
          { speaker: "", text: "「『このカフェは、いつか誰かが必要とする時に開けばいい』——って」", is_choice: false, choices: [] },
          { speaker: "", text: "……変な話だ。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、なぜだろう。その言葉が、頭から離れなかった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……内見だけなら。", is_choice: false, choices: [] },
          { speaker: "", text: "そう自分に言い聞かせて、今朝、ここに来た。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s1",
      },
      // --- Scene 1: 内見 — 廃墟のカフェとエスプレッソマシン ---
      // 前提: 内見当日。不動産屋の担当者と一緒に来ている
      // 目的: 物件の状態を確認する
      // 知識: 前のオーナーについてはほぼ何も知らない
      // 変化: エスプレッソマシンだけ大切に保管されているのを発見 → 心が動く
      // 結果: この物件を借りることを決意
      {
        id: "ch0_s1",
        lines: [
          { speaker: "", text: "商店街の外れ、路地を一本入った先。", is_choice: false, choices: [] },
          { speaker: "", text: "不動産屋の担当者が鍵を開ける。ドアが軋んだ。", is_choice: false, choices: [] },
          { speaker: "", text: "中に入ると、埃の匂いが押し寄せてくる。", is_choice: false, choices: [] },
          { speaker: "", text: "錆びた看板が、かろうじて読める文字を残している。", is_choice: false, choices: [] },
          { speaker: "", text: "『月灯り』——それが、このカフェの名前だった。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター、テーブル、棚。すべてが薄い灰色の膜に覆われている。", is_choice: false, choices: [] },
          { speaker: "", text: "割れたカップの破片が、床の隅に散らばっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から差し込む光だけが、この場所がかつて生きていたことを教えてくれる。", is_choice: false, choices: [] },
          { speaker: "", text: "……光の筋の中を、埃がゆっくりと舞っていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……2年、か。", is_choice: false, choices: [] },
          { speaker: "", text: "壁紙は剥がれかけ、蛇口は錆びている。正直、物件としては厳しい。", is_choice: false, choices: [] },
          { speaker: "", text: "担当者が「水回りは要修繕ですね」と手帳にメモしている。", is_choice: false, choices: [] },
          { speaker: "", text: "——でも、カウンターの奥に、何かがある。", is_choice: false, choices: [] },
          { speaker: "", text: "他のものとは違う。埃をかぶっていない。", is_choice: false, choices: [] },
          { speaker: "", text: "エスプレッソマシン。", is_choice: false, choices: [] },
          { speaker: "", text: "丁寧にカバーをかけられ、まるで誰かの帰りを待つように、そこにあった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……カバー、わざわざかけたんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "他のものは放り出すように残されているのに。", is_choice: false, choices: [] },
          { speaker: "", text: "このマシンだけが、大切にされていた。", is_choice: false, choices: [] },
          { speaker: "", text: "カバーをそっと外す。銀色の表面に、かすかに自分の顔が映った。", is_choice: false, choices: [] },
          { speaker: "", text: "「いつか誰かが必要とする時に」。", is_choice: false, choices: [] },
          { speaker: "", text: "——あの言葉が、また頭をよぎった。", is_choice: false, choices: [] },
          { speaker: "", text: "担当者がこちらを見ている。「どうします？」という目だ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……ここ、借ります。", is_choice: false, choices: [] },
          { speaker: "", text: "口に出した瞬間、自分でも驚いた。", is_choice: false, choices: [] },
          { speaker: "", text: "でも——あのチェーン店のカウンターでは息ができなかったのに。", is_choice: false, choices: [] },
          { speaker: "", text: "この埃だらけのカウンターの中では、不思議と——息ができた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s2",
      },
      // --- Scene 2: 開店準備日 — 掃除と最初の一杯 ---
      // 前提: 契約から2週間後。改装・掃除を進めてきた開店準備の日。
      //   水道修繕済み、電気復旧済み。エスプレッソマシンは業者に整備依頼中（未返却）。
      //   自分の仕入れた豆とドリップ器具を持ち込んでいる。
      // 目的: 開店に向けた最終準備。掃除の仕上げとドリップ器具のテスト。
      // 知識: 前オーナーについてはほぼ何も知らない（名前も知らない）
      // 変化: 初めて「自分のカウンター」でコーヒーを淹れる → 元常連の佐倉が現れる
      // 結果: 「前の人は上手でした」という言葉を受け、開店への覚悟が固まる
      {
        id: "ch0_s2",
        lines: [
          { speaker: "", text: "契約から二週間。開店準備、五日目の午後。", is_choice: false, choices: [] },
          { speaker: "", text: "掃除はようやく一通り終わった。カウンターは磨いて、蛇口からはきれいな水が出るようになった。", is_choice: false, choices: [] },
          { speaker: "", text: "壁は塗り直したし、割れたカップも片付けた。", is_choice: false, choices: [] },
          { speaker: "", text: "エスプレッソマシンは整備業者に出している。まだ戻ってこない。", is_choice: false, choices: [] },
          { speaker: "", text: "だから今日は、自分で持ち込んだドリップ器具を試してみることにした。", is_choice: false, choices: [] },
          { speaker: "", text: "ドリッパー、ペーパーフィルター、細口のケトル。昨日仕入れた豆。", is_choice: false, choices: [] },
          { speaker: "", text: "——開店はまだ先だ。でも、このカウンターで一杯淹れてみたかった。", is_choice: false, choices: [] },
          { speaker: "", text: "豆をミルに入れる。ハンドルを回すと、ゴリゴリと手応えが伝わってくる。", is_choice: false, choices: [] },
          { speaker: "", text: "前の職場では聞こえなかった音だ。機械が全部やっていたから。", is_choice: false, choices: [] },
          { speaker: "", text: "ケトルが沸いた。小さく鳴り始める。", is_choice: false, choices: [] },
          { speaker: "", text: "ドリッパーにフィルターをセットして、挽いた粉を入れる。", is_choice: false, choices: [] },
          { speaker: "", text: "お湯を細く、ゆっくり注ぐ。粉がふわりと膨らんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "湯が粉に触れた瞬間、香りが立つ。", is_choice: false, choices: [] },
          { speaker: "", text: "——この匂いだ。自分で淹れたコーヒーの匂い。", is_choice: false, choices: [] },
          { speaker: "", text: "掃除中に開け放していたドアから、午後の風が吹き込む。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーの香りが、路地に流れていく。", is_choice: false, choices: [] },
          { speaker: "", text: "……できた。", is_choice: false, choices: [] },
          { speaker: "", text: "新しいカップに注ぐ。湯気がゆらゆらと立ち上る。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "味は、いつもと同じ豆のはずだ。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、なぜだろう。少しだけ、違う気がした。", is_choice: false, choices: [] },
          { speaker: "", text: "場所が違うからか。それとも——", is_choice: false, choices: [] },
          { speaker: "", text: "このカウンターの中で淹れたからか。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s3",
      },
      // --- Scene 3: 最初の客 — 佐倉美月 ---
      // 前提: 同日・同場面の直後。ドアは換気のため開放中。看板は出ていない。
      // 目的: （主人公の目的は変わらず開店準備中）
      // 知識: 前オーナーについて何も知らない。佐倉について何も知らない。
      // 変化: 元常連の佐倉が匂いにつられて入ってくる → 「前の人」の存在を知る
      // 結果: この店には「前の記憶」を持つ人がいると知り、開店への覚悟が変わる
      {
        id: "ch0_s3",
        lines: [
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "……ドアベルが鳴った。風ではない。誰かが入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "まだ看板も出していない。営業なんてしていない。", is_choice: false, choices: [] },
          { speaker: "", text: "振り返ると、女性が一人、入り口に立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪を、肩のあたりでゆるくひとつに結んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "白いブラウスにリネンのワイドパンツ。ベージュのストールが肩にかかっている。", is_choice: false, choices: [] },
          { speaker: "", text: "30代くらいだろうか。華奢だけれど、どこか芯のある佇まい。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は一歩入って——足を止めた。", is_choice: false, choices: [] },
          { speaker: "", text: "店内をゆっくりと見回している。", is_choice: false, choices: [] },
          { speaker: "", text: "壁が塗り直されていること。カウンターが磨かれていること。", is_choice: false, choices: [] },
          { speaker: "", text: "——そして、エスプレッソマシンがあった場所が空になっていること。", is_choice: false, choices: [] },
          { speaker: "", text: "その空白を見た瞬間、伏し目がちだった目がわずかに見開かれた。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ここ、また開くの？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ——はい。まだ準備中で、開店はもう少し先なんですけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "掃除で風を通してたら、ドアが開いてて……すみません。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……コーヒーの匂いがした。外まで。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女の視線が、カウンターの上のドリッパーとカップに移った。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……一杯、もらえない？", is_choice: false, choices: [] },
          { speaker: "", text: "まだ開店もしていないのに。でも——断る理由が、見つからなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は窓際の席に座った。鞄から文庫本を取り出す。", is_choice: false, choices: [] },
          { speaker: "", text: "左手の人差し指でページの端を押さえ、右手でページをめくった。", is_choice: false, choices: [] },
          { speaker: "", text: "慣れた動作だった。まるで、この席に座るのが初めてではないような。", is_choice: false, choices: [] },
          { speaker: "", text: "……この店は2年間閉まっていたはずだ。それなのに。", is_choice: false, choices: [] },
          { speaker: "", text: "もう一杯分のコーヒーを淹れる。さっきより少しだけ丁寧に。", is_choice: false, choices: [] },
          { speaker: "", text: "誰かのために淹れるのは、前の店を辞めてから初めてだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は本から目を上げず、小さく頷いた。", is_choice: false, choices: [] },
          { speaker: "", text: "30分ほど、静かな時間が流れた。", is_choice: false, choices: [] },
          { speaker: "", text: "本のページをめくる音。窓の外を通る自転車の音。", is_choice: false, choices: [] },
          { speaker: "", text: "不思議と、居心地の悪さはなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "チェーン店の、あの息苦しさがない。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女がカップを置いた。空になっている。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "席を立ち、鞄を肩にかける。小さく会釈して、ドアに向かった。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアに手をかけたところで、ふと振り返った。", is_choice: false, choices: [] },
          { speaker: "", text: "口元だけがかすかに動いた。小さな声で——", is_choice: false, choices: [] },
          { speaker: "？？？", text: "——前の人は、もっと上手でしたよ。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルが鳴って、彼女の背中が路地に消えた。", is_choice: false, choices: [] },
          { speaker: "", text: "……静かな店内に、コーヒーの残り香だけが漂っている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "前の人……。", is_choice: false, choices: [] },
          { speaker: "", text: "この店を知っている。この席を知っている。前のオーナーの味を、知っている。", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外、細い路地に午後の光が差していた。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女はきっとまた来る。この匂いがする限り。", is_choice: false, choices: [] },
          { speaker: "", text: "——それなら、次はもう少しましなものを淹れないと。", is_choice: false, choices: [] },
          { speaker: "", text: "ドリッパーを洗いながら、エスプレッソマシンの整備業者に電話した。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……あのマシン、いつ頃戻りますか。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
