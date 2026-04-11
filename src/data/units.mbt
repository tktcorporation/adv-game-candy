// 食材キャラ + 敵キャラ データ定義
//
// にゃんこ大戦争式ディフェンスのマスターデータ。
// 食材キャラはガチャで入手、敵キャラはステージのウェーブで出現する。
//
// tick = 1/60秒想定（60FPS）。speed=2 なら 2px/tick = 120px/秒。

// =========================================================================
// 食材キャラ（プレイヤー側）
// =========================================================================

/// 全食材キャラのマスターデータ
///
/// コスト・HP・攻撃のバランス:
///   N: 低コスト、数で押す。おにぎり(壁)とたまご焼き(バランス)
///   R: 中コスト、役割特化。味噌汁(遠距離)と唐揚げ(速攻)
///   SR: 高コスト、高性能。ハンバーグ(重壁)とサバ(中距離火力)
///   SSR: 最高コスト、圧倒的。親子丼とフルコース
pub fn get_all_allies() -> Array[AllyDef] {
  [
    // --- N: 壁 + バランス ---
    {
      id: "ally_onigiri", name: "おにぎり", emoji: "\u{1F359}",
      rarity: Rarity::N, deploy_cost: 30, cooldown: 60,
      hp: 150, attack: 8, speed: 2, attack_range: 30,
      attack_interval: 30,
      description: "灯の定番。安くて腹持ちがいい。",
    },
    {
      id: "ally_tamagoyaki", name: "たまご焼き", emoji: "\u{1F373}",
      rarity: Rarity::N, deploy_cost: 50, cooldown: 90,
      hp: 100, attack: 15, speed: 3, attack_range: 30,
      attack_interval: 30,
      description: "甘いのかしょっぱいのか。丸山は甘い派。",
    },
    // --- R: 役割特化 ---
    {
      id: "ally_misoshiru", name: "味噌汁", emoji: "\u{1F372}",
      rarity: Rarity::R, deploy_cost: 80, cooldown: 120,
      hp: 60, attack: 20, speed: 1, attack_range: 120,
      attack_interval: 45,
      description: "温かい一杯は心の支え。遠くからじんわり効く。",
    },
    {
      id: "ally_karaage", name: "唐揚げ", emoji: "\u{1F357}",
      rarity: Rarity::R, deploy_cost: 70, cooldown: 90,
      hp: 120, attack: 20, speed: 5, attack_range: 30,
      attack_interval: 25,
      description: "揚げたてアツアツ。スピードが命。",
    },
    // --- SR: 高性能 ---
    {
      id: "ally_hamburg", name: "煮込みハンバーグ", emoji: "\u{1F356}",
      rarity: Rarity::SR, deploy_cost: 120, cooldown: 180,
      hp: 300, attack: 25, speed: 1, attack_range: 30,
      attack_interval: 35,
      description: "丸山自慢の一品。どっしり構える。",
    },
    {
      id: "ally_saba", name: "サバの味噌煮", emoji: "\u{1F41F}",
      rarity: Rarity::SR, deploy_cost: 100, cooldown: 150,
      hp: 80, attack: 35, speed: 2, attack_range: 80,
      attack_interval: 40,
      description: "脂が乗って旨味が凝縮。中距離の切り札。",
    },
    // --- SSR: 最強 ---
    {
      id: "ally_oyakodon", name: "親子丼", emoji: "\u{1F35B}",
      rarity: Rarity::SSR, deploy_cost: 150, cooldown: 240,
      hp: 200, attack: 40, speed: 3, attack_range: 30,
      attack_interval: 25,
      description: "親子の絆は何よりも強い。数量限定。",
    },
    {
      id: "ally_teishoku", name: "日替わり定食", emoji: "\u{1F371}",
      rarity: Rarity::SSR, deploy_cost: 200, cooldown: 300,
      hp: 400, attack: 50, speed: 2, attack_range: 50,
      attack_interval: 30,
      description: "灯の全てが詰まった至高の一膳。",
    },
  ]
}

/// IDから食材キャラを検索
pub fn get_ally_by_id(id : String) -> AllyDef? {
  for ally in get_all_allies() {
    if ally.id == id {
      return Some(ally)
    }
  }
  None
}

/// 初期所持キャラ（ゲーム開始時）
pub fn get_starter_allies() -> Array[String] {
  ["ally_onigiri", "ally_tamagoyaki", "ally_karaage"]
}

// =========================================================================
// 敵キャラ（空腹モンスター）
// =========================================================================

/// 全敵キャラのマスターデータ
pub fn get_all_enemies() -> Array[EnemyDef] {
  [
    {
      id: "enemy_kid", name: "はらぺこ小僧", emoji: "\u{1F476}",
      hp: 80, attack: 8, speed: 3, attack_range: 30,
      attack_interval: 30,
    },
    {
      id: "enemy_salaryman", name: "空腹サラリーマン", emoji: "\u{1F474}",
      hp: 200, attack: 15, speed: 2, attack_range: 30,
      attack_interval: 35,
    },
    {
      id: "enemy_ol", name: "飢えたOL", emoji: "\u{1F469}",
      hp: 120, attack: 25, speed: 4, attack_range: 30,
      attack_interval: 25,
    },
    {
      id: "enemy_champ", name: "大食いチャンピオン", emoji: "\u{1F4AA}",
      hp: 500, attack: 30, speed: 1, attack_range: 40,
      attack_interval: 40,
    },
    {
      id: "enemy_speed", name: "早食い名人", emoji: "\u{1F3C3}",
      hp: 150, attack: 10, speed: 7, attack_range: 30,
      attack_interval: 20,
    },
    {
      id: "enemy_boss", name: "お腹ぺこぺこ課長", emoji: "\u{1F47A}",
      hp: 800, attack: 40, speed: 1, attack_range: 50,
      attack_interval: 45,
    },
  ]
}

/// IDから敵キャラを検索
pub fn get_enemy_by_id(id : String) -> EnemyDef? {
  for enemy in get_all_enemies() {
    if enemy.id == id {
      return Some(enemy)
    }
  }
  None
}
