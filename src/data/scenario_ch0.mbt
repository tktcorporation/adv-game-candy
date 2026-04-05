// ============================================================
// 第0章: 店長、はじめました
// ============================================================
//
// あらすじ:
//   親戚のおばさんに「ちょっと店見てて〜」と丸投げされた主人公。
//   カフェの営業なんてしたことない。コーヒーの淹れ方もよく分からない。
//   そこに最初の客——佐倉美月が来る。コーヒーを全部飲んで
//   「ごちそうさま」とだけ言って帰る。感想なし。主人公は拍子抜け。
//
// 登場キャラ: 佐倉美月
// キーイベント:
//   - 主人公がカフェを任される経緯
//   - 佐倉との出会い（無反応）
//   - 「ごちそうさま」——これが物語の始まり
//
// --- 章の状態差分 ---
// 開始状態: 主人公はカフェ経営ゼロ経験。店は一応営業できる状態。
// 終了状態: 最初の客（佐倉）が来た。無反応だった。明日も来るのか分からない。
//   主人公の変化: 「なんだったんだあの人」→気になる
//   店の変化: なし（まだ何も始まっていない）
//   関係性: 佐倉（名前も知らない。無反応の客）
// ============================================================

/// Chapter 0: 店長、はじめました
pub fn get_chapter_0() -> Chapter {
  {
    id: 0,
    title: "第零章",
    subtitle: "店長、はじめました",
    unlock_revenue: 0,
    unlock_recipes: 0,
    unlock_customers: 0,
    unlock_intimacy: 0,
    scenes: [
      // --- Scene 0: おばさんの置き手紙 ---
      // 前提: 朝。主人公がカフェ「月灯り」に来ると、おばさんがいない
      // 変化: 置き手紙で「しばらく旅行行ってくるね〜」→店を任される
      // 結果: 困惑しつつも店を開けることに
      {
        id: "ch0_s0",
        lines: [
          { speaker: "", text: "朝。カフェ「月灯り」の前に立っている。", is_choice: false, choices: [] },
          { speaker: "", text: "おばさんから呼び出されたはずなのに、店のドアに張り紙がしてある。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……なにこれ。", is_choice: false, choices: [] },
          { speaker: "", text: "『しばらく旅行行ってきます！ 店のことよろしくね〜☆ 冷蔵庫のプリン食べていいよ！ ——おばちゃんより』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "は？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いやいやいや。「よろしくね」じゃないんだけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "カフェの経営なんてしたことないんだけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "てかコーヒーの淹れ方知らないんだけど。", is_choice: false, choices: [] },
          { speaker: "", text: "スマホを取り出す。おばさんに電話。", is_choice: false, choices: [] },
          { speaker: "", text: "『おかけになった番号は、現在電波の届かない——』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "どこ行ったんだよ……。", is_choice: false, choices: [] },
          { speaker: "", text: "もう一度張り紙を見る。端っこに小さく追伸。", is_choice: false, choices: [] },
          { speaker: "", text: "『P.S. コーヒーは棚の上のやつ使って。お湯入れるだけだから大丈夫！』", is_choice: false, choices: [] },
          { speaker: "主人公", text: "インスタントかよ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……まあ、とりあえず中入るか。", is_choice: false, choices: [] },
          { speaker: "", text: "鍵を開けて店内に入る。小さなカフェ。カウンターが6席、テーブルが3つ。", is_choice: false, choices: [] },
          { speaker: "", text: "窓から朝の光が差し込んでいる。埃っぽくはない。おばさんが掃除だけはしていたらしい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……悪くない場所だけど。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "俺に何しろってんだ。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s1",
      },
      // --- Scene 1: 最初の一杯（ひどい） ---
      // 前提: 仕方なく店を開けることにした主人公。コーヒーを淹れてみる
      // 変化: 自分で飲んで絶望する
      // 結果: とりあえず看板を出す
      {
        id: "ch0_s1",
        lines: [
          { speaker: "", text: "棚の上にインスタントコーヒーの瓶。その隣に、豆の袋がいくつか。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……豆、あるじゃん。ミルも。ドリッパーも。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "せめてインスタントじゃなくてちゃんと淹れるか。", is_choice: false, choices: [] },
          { speaker: "", text: "スマホで「コーヒー 淹れ方」を検索。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "豆を挽いて……お湯を注いで……蒸らす？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "蒸らすってなに。", is_choice: false, choices: [] },
          { speaker: "", text: "見よう見まねで淹れてみる。", is_choice: false, choices: [] },
          { speaker: "", text: "……できた。たぶん。色はコーヒーっぽい。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "にが。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "いや、苦いとかじゃなくて。なんか、薄いのに苦い。最悪のバランス。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……これ出す？ 人に？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……出すしかないか。", is_choice: false, choices: [] },
          { speaker: "", text: "意を決して、表の看板を「OPEN」にひっくり返した。", is_choice: false, choices: [] },
        ],
        next_scene: "ch0_s2",
      },
      // --- Scene 2: 最初の客 ---
      // 前提: 開店したが誰も来ない。午後になった
      // 知識: 主人公はこの客について何も知らない
      // 変化: 佐倉が来る。コーヒーを飲んで「ごちそうさま」。感想なし
      // 結果: 「なんだったんだあの人」→翌日も来るか気になる
      {
        id: "ch0_s2",
        lines: [
          { speaker: "", text: "午前中、客はゼロ。", is_choice: false, choices: [] },
          { speaker: "", text: "午後になった。まだゼロ。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "まあ、そうだよな。いきなり来ないよな。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンターの中でスマホをいじっていたら——", is_choice: false, choices: [] },
          { speaker: "", text: "カランカラン。", is_choice: false, choices: [] },
          { speaker: "", text: "ドアが開いた。", is_choice: false, choices: [] },
          { speaker: "", text: "女の子が一人、入ってきた。", is_choice: false, choices: [] },
          { speaker: "", text: "栗色の髪をゆるくひとつに結んでいる。白いニット。手に文庫本。", is_choice: false, choices: [] },
          { speaker: "", text: "店内をゆっくり見回して——窓際の一番奥の席に座った。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、いらっしゃいませ。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……コーヒーを。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "はい。コーヒー。えっと……少々お待ちください。", is_choice: false, choices: [] },
          { speaker: "", text: "さっき自分で飲んであの味だったコーヒーを、人に出すのか。", is_choice: false, choices: [] },
          { speaker: "", text: "……出すしかない。", is_choice: false, choices: [] },
          { speaker: "", text: "カップを窓際の席に運ぶ。彼女はもう本を開いていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……どうぞ。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女はちらりとカップを見て、本に視線を戻した。", is_choice: false, choices: [] },
          { speaker: "", text: "一口。", is_choice: false, choices: [] },
          { speaker: "", text: "……。", is_choice: false, choices: [] },
          { speaker: "", text: "反応、なし。", is_choice: false, choices: [] },
          { speaker: "", text: "美味しいとも、まずいとも言わない。ただ、ページをめくっている。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "(……感想、ないのか。)", is_choice: false, choices: [] },
          { speaker: "", text: "30分くらいだろうか。彼女は本を閉じて、立ち上がった。", is_choice: false, choices: [] },
          { speaker: "", text: "カップは空だった。全部飲んでいた。", is_choice: false, choices: [] },
          { speaker: "佐倉美月", text: "……ごちそうさま。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "あ、ありがとうございます。あの——", is_choice: false, choices: [] },
          { speaker: "", text: "言いかけた時には、もうドアが閉まっていた。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "なんだったんだ、あの人。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "美味しかったのか？ まずかったのか？", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……でも、全部飲んでたな。", is_choice: false, choices: [] },
          { speaker: "", text: "空のカップを洗いながら、なんとなく窓の外を見た。", is_choice: false, choices: [] },
          { speaker: "", text: "彼女の姿は、もうなかった。", is_choice: false, choices: [] },
          { speaker: "主人公", text: "……明日も来るのかな。", is_choice: false, choices: [] },
          { speaker: "", text: "なんでそんなことが気になるのか、自分でもよく分からなかった。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
