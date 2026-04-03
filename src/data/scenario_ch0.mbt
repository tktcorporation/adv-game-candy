// ============================================================
// 第零章: 廃墟と最初の一杯
// ============================================================
//
// あらすじ:
//   前職の飲食店を辞め、行き詰まっていた主人公。
//   不動産屋から「2年間引き取り手のない物件がある。前のオーナーが
//   『いつか誰かが必要とする時に開けばいい』と言い残した場所だ」と聞く。
//   内見のつもりで訪れた廃墟カフェ「月灯り」で、唯一丁寧にカバーを
//   かけられたエスプレッソマシンを見つける。
//   持参した豆で一杯淹れてみたところ、営業中でもないのに客が現れる。
//   佐倉美月——彼女は一杯飲んで「前の人は、もっと上手でしたよ」と残して去る。
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
      // --- Scene 1: 廃墟のカフェに足を踏み入れる ---
      {
        id: "ch0_s1",
        lines: [
          { speaker: "", text: "商店街の外れ、路地を一本入った先。", is_choice: false, choices: [] },
          { speaker: "", text: "錆びた看板が、かろうじて読める文字を残している。", is_choice: false, choices: [] },
          { speaker: "", text: "『月灯り』——それが、このカフェの名前だった。", is_choice: false, choices: [] },
          { speaker: "", text: "不動産屋から預かった鍵を差し込む。金属のこすれる音が、静かな路地に響いた。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアを押すと、埃の匂いが押し寄せてくる。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター、テーブル、棚。すべてが薄い灰色の膜に覆われている。", is_choice: false, choices: [] },
          { speaker: "", text: "割れたカップの破片が、床の隅に散らばっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から差し込む光だけが、この場所がかつて生きていたことを教えてくれる。", is_choice: false, choices: [] },
          { speaker: "", text: "……光の筋の中を、埃がゆっくりと舞っていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……2年、か。", is_choice: false, choices: [] },
          { speaker: "", text: "2年分の埃と、2年分の静寂。", is_choice: false, choices: [] },
          { speaker: "", text: "あちこち傷んでいる。壁紙は剥がれかけ、蛇口は錆びている。", is_choice: false, choices: [] },
          { speaker: "", text: "正直、物件としては厳しい。", is_choice: false, choices: [] },
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
        ],
        next_scene: "ch0_s2",
      },
      // --- Scene 2: 最初の一杯 ---
      {
        id: "ch0_s2",
        lines: [
          { speaker: "", text: "内見のつもりだった。見るだけのつもりだった。", is_choice: false, choices: [] },
          { speaker: "", text: "でも——鞄の中に、今朝買った豆がある。", is_choice: false, choices: [] },
          { speaker: "", text: "飲食店を辞めてから唯一続けている習慣。自分でコーヒーを淹れること。", is_choice: false, choices: [] },
          { speaker: "", text: "試してみたい、と思った。このカウンターの中で、一杯だけ。", is_choice: false, choices: [] },
          { speaker: "", text: "水道はまだ生きていた。蛇口を捻ると、錆びた水が出て、やがて透明になる。", is_choice: false, choices: [] },
          { speaker: "", text: "棚に手動のミルがあった。前の人のものだ。少し迷って、借りることにする。", is_choice: false, choices: [] },
          { speaker: "", text: "ゴリゴリ、と豆を挽く音が店内に響く。", is_choice: false, choices: [] },
          { speaker: "", text: "誰もいない空間に、その音だけが満ちていく。", is_choice: false, choices: [] },
          { speaker: "", text: "前の職場では聞こえなかった音だ。機械が全部やっていたから。", is_choice: false, choices: [] },
          { speaker: "", text: "お湯を沸かす。ケトルが小さく鳴り始める。", is_choice: false, choices: [] },
          { speaker: "", text: "慎重に、ゆっくりと注ぐ。", is_choice: false, choices: [] },
          { speaker: "", text: "湯が粉に触れた瞬間、ふわりと香りが立った。", is_choice: false, choices: [] },
          { speaker: "", text: "……できた。", is_choice: false, choices: [] },
          { speaker: "", text: "棚の奥に残っていたカップを洗って使う。少し欠けているけれど。", is_choice: false, choices: [] },
          { speaker: "", text: "薄暗い店内で、カップからゆらゆらと湯気が立ち上る。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "味は、いつもと同じ豆のはずだ。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、なぜだろう。少しだけ、違う気がした。", is_choice: false, choices: [] },
          { speaker: "", text: "場所が違うからか。それとも——", is_choice: false, choices: [] },
          { speaker: "", text: "カップを置く音が、やけに大きく聞こえた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s3",
      },
      // --- Scene 3: 最初の客 ---
      {
        id: "ch0_s3",
        lines: [
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "……ドアベルが鳴った。", is_choice: false, choices: [] },
          { speaker: "", text: "鍵は——閉めていなかったか。", is_choice: false, choices: [] },
          { speaker: "", text: "振り返ると、女性が一人、入り口に立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪を、肩のあたりでゆるくひとつに結んでいる。", is_choice: false, choices: [] },
          { speaker: "", text: "白いブラウスにリネンのワイドパンツ。ベージュのストールが肩にかかっている。", is_choice: false, choices: [] },
          { speaker: "", text: "30代くらいだろうか。華奢だけれど、どこか芯のある佇まい。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は一歩入って——足を止めた。", is_choice: false, choices: [] },
          { speaker: "", text: "店内をゆっくりと見回している。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター、壁、天井。そして——エスプレッソマシン。", is_choice: false, choices: [] },
          { speaker: "", text: "マシンを見た瞬間、伏し目がちだった目がわずかに見開かれた。", is_choice: false, choices: [] },
          { speaker: "", text: "……懐かしそうな、寂しそうな。どちらとも言えない顔。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ここ、開いてるの？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ——いえ、すみません。まだ営業してなくて。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "内見で来ただけなんです。鍵を閉め忘れて……", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は少し黙った。それから——", is_choice: false, choices: [] },
          { speaker: "？？？", text: "コーヒーの匂いがしたから。外まで。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……一杯、もらえない？", is_choice: false, choices: [] },
          { speaker: "", text: "断る理由が、見つからなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は窓際の席に座った。鞄から文庫本を取り出す。", is_choice: false, choices: [] },
          { speaker: "", text: "左手の人差し指でページの端を押さえ、右手でページをめくった。", is_choice: false, choices: [] },
          { speaker: "", text: "慣れた動作だった。まるで、この席に座るのが初めてではないような。", is_choice: false, choices: [] },
          { speaker: "", text: "……おかしい。この店は2年間閉まっていたはずだ。", is_choice: false, choices: [] },
          { speaker: "", text: "もう一杯分のコーヒーを淹れる。さっきより少しだけ丁寧に。", is_choice: false, choices: [] },
          { speaker: "", text: "誰かのために淹れるのは、辞めてから初めてだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうぞ。カップ、少し欠けてますけど。", is_choice: false, choices: [] },
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
          { speaker: "", text: "内見のつもりだった。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、あのカウンターの中に立った時——息ができた。", is_choice: false, choices: [] },
          { speaker: "", text: "前の店では、できなかったのに。", is_choice: false, choices: [] },
          { speaker: "", text: "不動産屋に電話をかけた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あの物件——借ります。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
