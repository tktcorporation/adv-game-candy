// ============================================================
// 第八章: 休み
// ============================================================
//
// あらすじ:
//   ひよりが来ない。1日目「たまにはあるか」。2日目、少し気になる。
//   3日目、店主に聞いてしまう。「たまにこういう時あるよ」。
//   4日目、定食を食べるが味がしない。隣の席が空いている。
//   こんなに気になると思わなかった。連絡先を知らない。
//   名前と、読んでいる本と、漬物が苦手なことしか知らない。
//
// 登場キャラ: 椎名ひより（不在）
// キーイベント:
//   - 4日間の時間経過を丁寧に描く（各日を1シーンに）
//   - 空席が関係性の象徴（距離を縮める装置が、不在を語る装置に反転）
//   - 晴が店主に聞く＝受動的な晴が能動的に情報を求める
//   - 連絡先を知らないという脆さ
//   - 晴が自分の感情を自覚する
//
// --- 章の状態差分 ---
// 開始状態: 隣の席が定位置。毎日顔を合わせている
// 終了状態: 4日間ひよりが来ない。晴は自分の感情を自覚した
//   晴の変化: 受動→能動（店主に聞く）。感情の自覚
//   関係性: ひより（不在。でも不在だからこそ存在が大きい）
// ============================================================

/// Chapter 8: 休み
pub fn get_chapter_8() -> Chapter {
  {
    id: 8,
    title: "第八章",
    subtitle: "休み",
    unlock_visit_count: 13,
    scenes: [
      // --- Scene 0: 1日目 ---
      // 前提: いつもの昼。ひよりが来ない
      // 変化: 待っているわけではないが、隣が空いている
      // 結果: 「たまにはあるか」で済ませる
      {
        id: "ch8_s0",
        lines: [
          { speaker: "", text: "平日の昼。灯。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。今日はサバの塩焼きね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いいですね。", is_choice: false, choices: [] },
          { speaker: "", text: "いつもの席に座る。隣は空いている。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "はいよ、サバ定食。今日はいい脂のってるよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いただきます。", is_choice: false, choices: [] },
          { speaker: "", text: "食べる。美味い。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "今日は静かだねえ。天気いいのに。", is_choice: false, choices: [] },
          { speaker: "晴", text: "そうですね。", is_choice: false, choices: [] },
          { speaker: "", text: "食べ終わる頃になっても、引き戸は開かなかった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（今日は来ないのか。……まあ、たまにはあるか）", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。", is_choice: false, choices: [] },
          { speaker: "", text: "隣の席が、妙に広く見えた。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s1",
      },
      // --- Scene 1: 2日目 ---
      // 前提: 翌日。また来ない
      // 変化: 少し気になり始める。食事中に引き戸のほうを見てしまう
      // 結果: 認めないが、待っている自分がいる
      {
        id: "ch8_s1",
        lines: [
          { speaker: "", text: "翌日。昼。灯。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。今日は肉じゃがだよ。", is_choice: false, choices: [] },
          { speaker: "", text: "席に座る。隣は空いている。", is_choice: false, choices: [] },
          { speaker: "晴", text: "日替わりで。", is_choice: false, choices: [] },
          { speaker: "", text: "肉じゃがが来た。じゃがいもがほくほくしている。", is_choice: false, choices: [] },
          { speaker: "", text: "食べている途中で、引き戸のほうを見た。無意識に。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……別に、待ってるわけじゃない）", is_choice: false, choices: [] },
          { speaker: "", text: "テーブル席に常連のおじさんが二人。カウンターは俺だけ。", is_choice: false, choices: [] },
          { speaker: "", text: "店主がおじさんたちと野球の話をしている。笑い声が遠い。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（昨日も来なかった。今日も来ない。風邪でも引いたかな）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……いや、別に。そこまで考えることじゃない）", is_choice: false, choices: [] },
          { speaker: "", text: "肉じゃが、美味しいはずなのに、なんとなく箸が進まない。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。あれ、今日はちょっと残してるね。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ……すみません。お腹あんまり空いてなくて。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "そういう日もあるよね。", is_choice: false, choices: [] },
          { speaker: "", text: "帰り道。午後の日差し。隣を歩く人は、いない。", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s2",
      },
      // --- Scene 2: 3日目 ---
      // 前提: 3日目。さすがに気になる
      // 変化: 晴が店主に聞く。受動的な晴が初めて能動的に情報を求める
      // 結果: 「たまにあるよ」としか返ってこない。連絡先を知らないことに気づく
      {
        id: "ch8_s2",
        lines: [
          { speaker: "", text: "3日目。", is_choice: false, choices: [] },
          { speaker: "", text: "店に入る前に、少しだけ足が止まった。", is_choice: false, choices: [] },
          { speaker: "", text: "——今日もいないかもしれない。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。", is_choice: false, choices: [] },
          { speaker: "", text: "カウンター。隣の席。空。", is_choice: false, choices: [] },
          { speaker: "", text: "今日の日替わりはアジフライだった。ソースをかけて、食べる。", is_choice: false, choices: [] },
          { speaker: "", text: "サクサクしている。美味い。……はずだ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "……あの。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ん？", is_choice: false, choices: [] },
          { speaker: "晴", text: "ここに、いつも来てる……その、隣の席の人。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ああ、ひよりちゃん？", is_choice: false, choices: [] },
          { speaker: "晴", text: "最近来てないですよね。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "そうだねえ。3日くらい？ たまにこういう時あるよ。忙しかったり、体調崩したり。", is_choice: false, choices: [] },
          { speaker: "晴", text: "……そうですか。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "心配？", is_choice: false, choices: [] },
          { speaker: "晴", text: "いや、別に。なんとなく気になっただけです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "そっか。まあ、来たくなったら来るでしょ。ここはいつでも開いてるからさ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……連絡先を知らない）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（名前は知ってる。漬物が苦手なことも知ってる。でも、LINEも何も知らない）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "お、アジフライ冷めちゃうよ。揚げたて食べなきゃ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ、はい。すみません。", is_choice: false, choices: [] },
          { speaker: "", text: "最後の一切れを口に運ぶ。冷めていた。", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "まいど。元気出しなよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……そんなに顔に出てるのかな）", is_choice: false, choices: [] },
        ],
        next_scene: "ch8_s3",
      },
      // --- Scene 3: 4日目 ---
      // 前提: 4日目。もう「たまには」では済まない
      // 変化: 定食を食べるが味がしない。晴が自分の感情を自覚する
      // 結果: 隣の空席が、晴に自分の気持ちを突きつける
      {
        id: "ch8_s3",
        lines: [
          { speaker: "", text: "4日目。", is_choice: false, choices: [] },
          { speaker: "", text: "灯の引き戸を開ける。", is_choice: false, choices: [] },
          { speaker: "晴", text: "こんにちはー。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "いらっしゃい。今日はね、ブリの照り焼き。自信作。", is_choice: false, choices: [] },
          { speaker: "晴", text: "いいですね。", is_choice: false, choices: [] },
          { speaker: "", text: "席に座る。隣は空いている。4日目。", is_choice: false, choices: [] },
          { speaker: "", text: "ブリの照り焼きが来た。見た目は完璧だ。照りが美しい。", is_choice: false, choices: [] },
          { speaker: "", text: "一口食べる。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……美味い、んだろうな。たぶん）", is_choice: false, choices: [] },
          { speaker: "", text: "味がしない。舌では分かっている。美味しいはずだ。", is_choice: false, choices: [] },
          { speaker: "", text: "でも、どこか遠い。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "どう？ ブリ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "美味しいです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "よかった。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（嘘はついてない。美味しいはずだから）", is_choice: false, choices: [] },
          { speaker: "", text: "隣の席を見る。誰もいない。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（ほんの一週間前まで、ここにいたのにな）", is_choice: false, choices: [] },
          { speaker: "丸山", text: "……なあ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "はい？", is_choice: false, choices: [] },
          { speaker: "丸山", text: "ブリ、残すなら無理しなくていいよ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "あ……すみません。", is_choice: false, choices: [] },
          { speaker: "", text: "箸を置いた。ブリは半分残っている。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（こんなに気になると、思わなかった）", is_choice: false, choices: [] },
          { speaker: "晴", text: "（あの人がいるのが当たり前になってた。……寂しいんだ、俺）", is_choice: false, choices: [] },
          { speaker: "晴", text: "ごちそうさまです。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "おう、まいど。明日また来な。", is_choice: false, choices: [] },
          { speaker: "晴", text: "……はい。", is_choice: false, choices: [] },
          { speaker: "丸山", text: "元気な顔見せてよ。心配になるからさ。", is_choice: false, choices: [] },
          { speaker: "晴", text: "はは。すみません。", is_choice: false, choices: [] },
          { speaker: "", text: "外に出た。夕方の風。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（名前。読む本。漬物が苦手。笑うと口元が緩む。それしか知らない）", is_choice: false, choices: [] },
          { speaker: "", text: "でも、それが全部、ちゃんと残っている。", is_choice: false, choices: [] },
          { speaker: "晴", text: "（……また来てくれよ）", is_choice: false, choices: [] },
          { speaker: "", text: "誰にも届かない言葉が、路地に消えた。", is_choice: false, choices: [] },
        ],
        next_scene: "",
      },
    ],
  }
}
