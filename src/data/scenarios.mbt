// Story scenarios for 灯（あかり）
//
// 各章は個別ファイル（scenario_ch0.mbt 〜 scenario_ch21.mbt）に分割。
// このファイルは全章を集約するインデックスのみ。
//
// === 舞台 ===
// 定食屋「灯（あかり）」。駅から少し離れた路地の奥。
// カウンター8席、テーブル2つ。日替わり定食が一種類だけ。
// 店主（丸山）が一人で切り盛りしている。
//
// === 物語の骨格 ===
// 主人公（高瀬晴）とヒロイン（椎名ひより）は同じ定食屋の常連客。
// カウンターの端と端から始まり、席の距離が縮まるにつれて関係が深まる。
// 主人公の無自覚な善意が、ひよりの心を少しずつ動かしていく。
//
// === 構成（予定） ===
// ch0:   いつもの席（出会い。椅子を直す）
// ch1:   日替わり（ハンバーグを譲る。席が近くなる）
// ch2〜: 未執筆
//
// === ひよりの「席×言葉」推移 ===
// 序盤:  カウンターの反対側。「日替わりで」「ごちそうさま」のみ
// 中盤:  二つ空け→一つ空け。短い会話が生まれる
// 後半:  隣の席。名前を呼び合う
// 転:    来なくなる、または距離が戻る
// 結:    隣の席が定位置に。「……美味しいね」

/// Get all chapters
pub fn get_chapters() -> Array[Chapter] {
  [
    get_chapter_0(),
    get_chapter_1(),
    get_chapter_2(),
    get_chapter_3(),
    get_chapter_4(),
    get_chapter_5(),
    get_chapter_6(),
    get_chapter_7(),
    get_chapter_8(),
    get_chapter_9(),
    get_chapter_10(),
    get_chapter_11(),
    get_chapter_12(),
    get_chapter_13(),
    get_chapter_14(),
    get_chapter_15(),
    get_chapter_16(),
    get_chapter_17(),
    get_chapter_18(),
    get_chapter_19(),
    get_chapter_20(),
    get_chapter_21(),
  ]
}
