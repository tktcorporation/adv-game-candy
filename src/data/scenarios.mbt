// Story scenarios for 廃墟カフェ復興記「月灯り」
//
// 各章は個別ファイル（scenario_ch0.mbt 〜 scenario_ch8.mbt）に分割。
// このファイルは全章を集約するインデックスのみ。
//
// === 三度触れの法則: 追跡要素 ===
// [エスプレッソマシン]  ch0(植付) → ch4(想起) → ch8(回収)
// [「前の人」]          ch0(植付) → ch1宮内(想起) → ch8しずく(回収)
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
