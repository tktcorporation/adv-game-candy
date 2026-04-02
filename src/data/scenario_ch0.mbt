// ============================================================
// 第零章: 廃墟と最初の一杯
// ============================================================
//
// あらすじ:
//   主人公が廃墟となったカフェ「月灯り」に初めて足を踏み入れる。
//   埃と静寂の中、唯一丁寧にカバーをかけられたエスプレッソマシンを見つける。
//   古い豆で最初の一杯を淹れた直後、最初の客——佐倉美月が現れる。
//   彼女は一杯飲んで「前の人は、もっと上手でしたよ」と残して去る。
//
// 登場キャラ: 佐倉美月（？？？として）
// キーイベント:
//   - エスプレッソマシンのカバー（三度触れ #1: マシン）
//   - 「前の人は上手でした」（三度触れ #1: 前の人）
//   - 窓から差す光（三度触れ #1: 光）
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
      // --- Scene 1: 廃墟のカフェに足を踏み入れる ---
      {
        id: "ch0_s1",
        lines: [
          { speaker: "", text: "朝。", is_choice: false, choices: [] },
          { speaker: "", text: "商店街の外れ、路地を一本入った先。", is_choice: false, choices: [] },
          { speaker: "", text: "錆びた看板が、かろうじて読める文字を残している。", is_choice: false, choices: [] },
          { speaker: "", text: "『月灯り』——それが、このカフェの名前だった。", is_choice: false, choices: [] },
          { speaker: "", text: "鍵を開ける。金属のこすれる音が、静かな路地に響いた。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアを押すと、埃の匂いが押し寄せてくる。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター、テーブル、棚。すべてが薄い灰色の膜に覆われている。", is_choice: false, choices: [] },
          { speaker: "", text: "割れたカップの破片が、床の隅に散らばっていた。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から差し込む光だけが、この場所がかつて生きていたことを教えてくれる。", is_choice: false, choices: [] },
          { speaker: "", text: "……光の筋の中を、埃がゆっくりと舞っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの奥に、何かがある。", is_choice: false, choices: [] },
          { speaker: "", text: "他のものとは違う。埃をかぶっていない。", is_choice: false, choices: [] },
          { speaker: "", text: "エスプレッソマシン。", is_choice: false, choices: [] },
          { speaker: "", text: "丁寧にカバーをかけられ、まるで誰かの帰りを待つように、そこにあった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……カバー、わざわざかけたんだ。", is_choice: false, choices: [] },
          { speaker: "", text: "他のものは放り出すように残されているのに。", is_choice: false, choices: [] },
          { speaker: "", text: "このマシンだけが、大切にされていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "ここが、僕のカフェになる場所……なのか。", is_choice: false, choices: [] },
          { speaker: "", text: "カバーをそっと外す。銀色の表面に、かすかに自分の顔が映った。", is_choice: false, choices: [] },
          { speaker: "", text: "まずは、一杯淹れてみよう。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s2",
      },
      // --- Scene 2: 最初の一杯 ---
      {
        id: "ch0_s2",
        lines: [
          { speaker: "", text: "棚を開ける。埃。空の容器。使いかけの砂糖。", is_choice: false, choices: [] },
          { speaker: "", text: "奥の方に、密封された缶がひとつ。", is_choice: false, choices: [] },
          { speaker: "", text: "ラベルには丁寧な手書きで「ブレンド」とだけ書かれていた。", is_choice: false, choices: [] },
          { speaker: "", text: "2年前の日付。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……使えるかな。", is_choice: false, choices: [] },
          { speaker: "", text: "蓋を開けると、かすかに——本当にかすかに、コーヒーの香りがした。", is_choice: false, choices: [] },
          { speaker: "", text: "手動のミルを見つけた。棚の隅、手の届きやすい場所に置かれていた。", is_choice: false, choices: [] },
          { speaker: "", text: "前の人も、きっとここに手を伸ばしていたのだろう。", is_choice: false, choices: [] },
          { speaker: "", text: "ゴリゴリ、と豆を挽く音が店内に響く。", is_choice: false, choices: [] },
          { speaker: "", text: "誰もいない空間に、その音だけが満ちていく。", is_choice: false, choices: [] },
          { speaker: "", text: "お湯を沸かす。ケトルが小さく鳴り始める。", is_choice: false, choices: [] },
          { speaker: "", text: "慎重に、ゆっくりと注ぐ。", is_choice: false, choices: [] },
          { speaker: "", text: "湯が粉に触れた瞬間、ふわりと香りが立った。", is_choice: false, choices: [] },
          { speaker: "", text: "2年前の豆。もう駄目かと思ったけれど。", is_choice: false, choices: [] },
          { speaker: "", text: "……できた。", is_choice: false, choices: [] },
          { speaker: "", text: "薄暗い店内で、カップからゆらゆらと湯気が立ち上る。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……苦い。雑味もある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "でも——悪くない。", is_choice: false, choices: [] },
          { speaker: "", text: "最初の一杯。", is_choice: false, choices: [] },
          { speaker: "", text: "この場所で淹れた、最初のコーヒー。", is_choice: false, choices: [] },
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
          { speaker: "", text: "まだ「営業中」の看板すら出していないのに。", is_choice: false, choices: [] },
          { speaker: "", text: "振り返ると、女性が一人、入り口に立っていた。", is_choice: false, choices: [] },
          { speaker: "", text: "30代くらいだろうか。落ち着いた佇まい。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女の視線が、店内をゆっくりと巡った。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター、壁、天井。そして——エスプレッソマシン。", is_choice: false, choices: [] },
          { speaker: "", text: "マシンを見た瞬間、彼女の表情がわずかに動いた気がした。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ここ、開いてるの？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、えっと……はい。一応。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まだ準備中みたいなものなんですけど。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "じゃあ、コーヒーを一杯。", is_choice: false, choices: [] },
          { speaker: "", text: "迷いのない注文だった。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は窓際の席に座り、鞄から文庫本を取り出した。", is_choice: false, choices: [] },
          { speaker: "", text: "慣れた動作だった。まるで、この席に座るのが初めてではないような。", is_choice: false, choices: [] },
          { speaker: "", text: "コーヒーを淹れる。さっきより少しだけ丁寧に。", is_choice: false, choices: [] },
          { speaker: "", text: "誰かのために淹れるのは、これが初めてだ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女は本から目を上げず、小さく頷いた。", is_choice: false, choices: [] },
          { speaker: "", text: "30分ほど、静かな時間が流れた。", is_choice: false, choices: [] },
          { speaker: "", text: "本のページをめくる音。時計の秒針。遠くの車の音。", is_choice: false, choices: [] },
          { speaker: "", text: "不思議と、居心地の悪さはなかった。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女がカップを置いた。空になっている。", is_choice: false, choices: [] },
          { speaker: "？？？", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "", text: "席を立ち、鞄を肩にかける。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアに手をかけたところで、ふと振り返った。", is_choice: false, choices: [] },
          { speaker: "", text: "小さな声で——", is_choice: false, choices: [] },
          { speaker: "？？？", text: "——前の人は、もっと上手でしたよ。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアベルが鳴って、彼女の背中が路地に消えた。", is_choice: false, choices: [] },
          { speaker: "", text: "……静かな店内に、コーヒーの残り香だけが漂っている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "前の人……？", is_choice: false, choices: [] },
          { speaker: "", text: "窓の外、細い路地に午後の光が差していた。", is_choice: false, choices: [] },
          { speaker: "", text: "その言葉が、いつまでも耳に残っていた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
