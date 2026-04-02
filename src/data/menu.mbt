// Menu items and recipes for 廃墟カフェ復興記

/// Get initial menu items
pub fn get_initial_menu() -> Array[MenuItem] {
  [
    { id: "blend_coffee", name: "ブレンドコーヒー", description: "基本のドリップコーヒー。丁寧に淹れた一杯。", cost: 50, price: 300, unlock_chapter: 0 },
    { id: "cafe_latte", name: "カフェラテ", description: "エスプレッソとミルクの定番。", cost: 80, price: 400, unlock_chapter: 0 },
    { id: "houjicha", name: "ほうじ茶", description: "香ばしい和のお茶。", cost: 30, price: 250, unlock_chapter: 0 },
  ]
}

/// Get all recipes (unlockable)
pub fn get_all_recipes() -> Array[Recipe] {
  [
    // Chapter 0 recipes
    { id: "r_blend", name: "ブレンドコーヒー", base: "coffee_beans", sub1: "", sub2: "", description: "基本のドリップコーヒー", cost: 50, price: 300, unlock_chapter: 0 },
    { id: "r_latte", name: "カフェラテ", base: "coffee_beans", sub1: "milk", sub2: "", description: "エスプレッソ＋ミルク", cost: 80, price: 400, unlock_chapter: 0 },
    { id: "r_houjicha", name: "ほうじ茶", base: "houjicha_leaf", sub1: "", sub2: "", description: "香ばしい和のお茶", cost: 30, price: 250, unlock_chapter: 0 },
    // Chapter 1 recipes
    { id: "r_cocoa", name: "ココア", base: "cacao", sub1: "milk", sub2: "sugar", description: "甘くて温かいココア", cost: 70, price: 350, unlock_chapter: 1 },
    { id: "r_caramel_latte", name: "キャラメルラテ", base: "coffee_beans", sub1: "milk", sub2: "sugar", description: "甘いキャラメル風味のラテ", cost: 90, price: 450, unlock_chapter: 1 },
    { id: "r_milk_tea", name: "ミルクティー", base: "black_tea", sub1: "milk", sub2: "", description: "紅茶とミルクの優しい味", cost: 60, price: 350, unlock_chapter: 1 },
    // Chapter 2 recipes
    { id: "r_apple_cinnamon", name: "アップルシナモンティー", base: "black_tea", sub1: "apple", sub2: "cinnamon", description: "りんごとシナモンの秋の味", cost: 80, price: 420, unlock_chapter: 2 },
    { id: "r_lemon_tea", name: "レモンティー", base: "black_tea", sub1: "lemon", sub2: "", description: "爽やかなレモンの香り", cost: 50, price: 320, unlock_chapter: 2 },
    { id: "r_strawberry_latte", name: "ストロベリーラテ", base: "coffee_beans", sub1: "milk", sub2: "strawberry", description: "苺の甘酸っぱさが香る", cost: 100, price: 480, unlock_chapter: 2 },
    { id: "r_honey_latte", name: "はちみつラテ", base: "coffee_beans", sub1: "milk", sub2: "honey", description: "蜂蜜の優しい甘さ", cost: 85, price: 430, unlock_chapter: 2 },
    // Chapter 3 recipes
    { id: "r_matcha_latte", name: "抹茶ラテ", base: "matcha", sub1: "milk", sub2: "", description: "香り高い抹茶とミルク", cost: 90, price: 450, unlock_chapter: 3 },
    { id: "r_vanilla_coffee", name: "バニラコーヒー", base: "coffee_beans", sub1: "vanilla", sub2: "milk", description: "バニラが香る特別な一杯", cost: 95, price: 460, unlock_chapter: 3 },
    { id: "r_cinnamon_cocoa", name: "シナモンココア", base: "cacao", sub1: "milk", sub2: "cinnamon", description: "スパイシーで温かいココア", cost: 85, price: 430, unlock_chapter: 3 },
    // Chapter 4-5 recipes
    { id: "r_deep_blend", name: "深煎りブレンド", base: "coffee_beans", sub1: "", sub2: "", description: "佐倉さんの好きな深い味", cost: 60, price: 350, unlock_chapter: 4 },
    { id: "r_houjicha_latte", name: "ほうじ茶ラテ", base: "houjicha_leaf", sub1: "milk", sub2: "", description: "和と洋の出会い", cost: 70, price: 380, unlock_chapter: 4 },
    { id: "r_seasonal_blend", name: "季節のブレンド", base: "coffee_beans", sub1: "seasonal", sub2: "", description: "その時だけの特別な味", cost: 100, price: 500, unlock_chapter: 5 },
    // Hidden recipes
    { id: "r_shigure_blend", name: "時雨ブレンド", base: "coffee_beans", sub1: "vanilla", sub2: "honey", description: "前のオーナーのレシピ。ノートから再現した一杯。", cost: 90, price: 550, unlock_chapter: 5 },
    { id: "r_tsukiakari", name: "月灯りスペシャル", base: "coffee_beans", sub1: "cinnamon", sub2: "honey", description: "この店の名を冠した一杯。", cost: 100, price: 600, unlock_chapter: 7 },
  ]
}

/// Get all ingredients
pub fn get_all_ingredients() -> Array[Ingredient] {
  [
    // Base
    { id: "coffee_beans", name: "コーヒー豆", category: "base", unlock_chapter: 0 },
    { id: "black_tea", name: "紅茶葉", category: "base", unlock_chapter: 0 },
    { id: "houjicha_leaf", name: "ほうじ茶葉", category: "base", unlock_chapter: 0 },
    { id: "matcha", name: "抹茶", category: "base", unlock_chapter: 3 },
    { id: "cacao", name: "カカオ", category: "premium", unlock_chapter: 1 },
    // Dairy
    { id: "milk", name: "ミルク", category: "dairy", unlock_chapter: 0 },
    { id: "cream", name: "生クリーム", category: "dairy", unlock_chapter: 2 },
    // Fruit
    { id: "lemon", name: "レモン", category: "fruit", unlock_chapter: 2 },
    { id: "strawberry", name: "いちご", category: "fruit", unlock_chapter: 2 },
    { id: "apple", name: "りんご", category: "fruit", unlock_chapter: 2 },
    // Sweetener
    { id: "sugar", name: "砂糖", category: "sweetener", unlock_chapter: 0 },
    { id: "honey", name: "はちみつ", category: "sweetener", unlock_chapter: 1 },
    { id: "brown_sugar", name: "黒糖", category: "sweetener", unlock_chapter: 2 },
    // Spice
    { id: "cinnamon", name: "シナモン", category: "spice", unlock_chapter: 3 },
    { id: "vanilla", name: "バニラ", category: "spice", unlock_chapter: 3 },
    // Special
    { id: "seasonal", name: "季節の素材", category: "special", unlock_chapter: 5 },
  ]
}
