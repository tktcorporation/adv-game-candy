// Story scenarios for 廃墟カフェ復興記「月灯り」
//
// 各章は個別ファイル（scenario_ch0.mbt 〜 scenario_ch8.mbt）に分割。
// このファイルは全章を集約するインデックスのみ。
//
// === キャラクター導入順序（1章1人ルール） ===
// ch0: 佐倉美月（最初の客）
// ch1: 天野蓮（佐倉との関係定着後に）
// ch2: 宮内孝之（前オーナーの旧友）
// ch3: 神崎凛（記者）
// ch4: 桐谷楓（Café BLANC）
//
// === 三度触れの法則: 追跡要素 ===
// [エスプレッソマシン]  ch0(植付) → ch4(想起) → ch8(回収)
// [「前の人」]          ch0(植付) → ch2宮内(想起) → ch8しずく(回収)
// [レシピノート]        ch2(匂わせ) → ch5(発見) → ch7-8(回収)
// [手紙「しずくへ」]    ch5(植付) → ch7(想起) → ch8(回収)
// [窓から差す光]        ch0(植付) → ch4(想起) → ch8(回収)

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
  ]
}
