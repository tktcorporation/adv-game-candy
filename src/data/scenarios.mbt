// Story scenarios for 月灯り（ラブコメ版）
//
// 各章は個別ファイル（scenario_ch0.mbt 〜 scenario_ch21.mbt）に分割。
// このファイルは全章を集約するインデックスのみ。
//
// === 構成 ===
// 起（ch0-2）:    舞台・キャラ確立
// 承前半（ch3-9）: 日常の確立。カフェの仲間になっていく
// 承後半（ch10-15）: 日常の深化。カフェ外にも広がる
// 転（ch16-19）:  恋愛が動く。すれ違い
// 結（ch20-21）:  解決とその後
//
// === キャラクター導入順序 ===
// ch0: 佐倉美月（最初の客・メインヒロイン）
// ch1: 天野蓮（バイト）
// ch4: 神崎凛（常連・フリーライター）
// ch9: 桐谷楓（チェーン店スタッフ）
//
// === 物語の背骨: 佐倉の「無反応→美味しい」 ===
// ch0:  「ごちそうさま」（ゼロ反応）
// ch3:  帰り際にわずかに立ち止まる
// ch7:  雨の日、いつもより長居
// ch13: 主人公が頑張るのをやめる→佐倉がそわそわ
// ch21: 「……美味しい」
//
// === 佐倉の「言葉×距離」 ===
// 序盤:  窓際の一番遠い席
// 中盤:  カウンター寄りに移動
// 後半:  カウンター席。距離ゼロ。辛辣だが近い
// 転:    距離が離れる（すれ違い）
// 結:    カウンター席が定位置に

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
