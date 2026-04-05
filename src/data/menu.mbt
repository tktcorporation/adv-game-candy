// 日替わりメニュー — 定食屋「灯」
//
// 日数のハッシュ（day % length）で決定的に選ばれる。
// 同じ日に何度アクセスしても同じメニューが表示される。

/// 全日替わりメニュー定義
///
/// intimacy_bonus はメニューの「特別感」で差をつけている。
/// 数量限定や得意メニューは高め（12）、シンプルなものは低め（8-9）。
pub fn get_daily_menus() -> Array[DailyMenu] {
  [
    { id: "d_saba_miso", name: "鯖の味噌煮定食", description: "脂ののった鯖に、白味噌の甘さ", intimacy_bonus: 10 },
    { id: "d_nikujaga", name: "肉じゃが定食", description: "じゃがいもがほくほく。家庭の味", intimacy_bonus: 10 },
    { id: "d_hamburg", name: "煮込みハンバーグ定食", description: "デミグラスソースでじっくり。数量限定", intimacy_bonus: 12 },
    { id: "d_karaage", name: "鶏の唐揚げ定食", description: "カリッと揚がった大ぶりの唐揚げ", intimacy_bonus: 10 },
    { id: "d_kakuni", name: "豚の角煮定食", description: "とろとろに煮込んだ三枚肉", intimacy_bonus: 11 },
    { id: "d_saba_shio", name: "鯖の塩焼き定食", description: "シンプルに塩で。皮がパリッと", intimacy_bonus: 9 },
    { id: "d_teriyaki", name: "鶏の照り焼き定食", description: "甘辛いタレが絡んで、ご飯が進む", intimacy_bonus: 11 },
    { id: "d_curry", name: "カレー", description: "灯の隠れた定番。スパイスが優しい", intimacy_bonus: 8 },
    { id: "d_shogayaki", name: "豚の生姜焼き定食", description: "生姜の香りが食欲をそそる", intimacy_bonus: 10 },
    { id: "d_oyakodon", name: "親子丼", description: "卵がふわとろ。丸山の得意メニュー", intimacy_bonus: 12 },
    { id: "d_sanma", name: "秋刀魚の塩焼き定食", description: "秋の味覚。大根おろしを添えて", intimacy_bonus: 11 },
    { id: "d_butaniku", name: "豚汁定食", description: "具だくさんの豚汁がメイン。冬の定番", intimacy_bonus: 10 },
  ]
}

/// 今日の日替わりメニューを取得
///
/// day % menus.length() で決定的に選択。同じ日なら必ず同じメニュー。
pub fn get_today_menu(day : Int) -> DailyMenu {
  let menus = get_daily_menus()
  menus[day % menus.length()]
}
