// ステージデータ — バランス調整だけでレベル量産
//
// 各ステージは敵ウェーブのパラメータだけで定義される。
// HP/攻撃力/出現タイミングを変えるだけで難易度が変わる。
//
// tick = 1/60秒。delay/interval は tick 単位。
// 60tick = 1秒、600tick = 10秒、3600tick = 60秒。

/// 全ステージデータ
///
/// 季節ごとに10ステージ（春1-10, 夏11-20, ...）。
/// 最初は5ステージだけ定義し、順次追加。
pub fn get_all_stages() -> Array[StageDef] {
  [
    // === 春ステージ（チュートリアル〜基本） ===
    {
      id: 1, name: "昼休みの来客",
      description: "はらぺこ小僧がやってくる。おにぎりで迎え撃て！",
      enemy_base_hp: 300, cost_speed: 120,
      waves: [
        { enemy_id: "enemy_kid", count: 5, interval: 180, delay: 120 },
      ],
      reward_akari: 5, reward_coins: 100,
      star_thresholds: [3600, 2400, 1200],
    },
    {
      id: 2, name: "午後のラッシュ",
      description: "サラリーマンも混ざってきた。壁役が重要だ。",
      enemy_base_hp: 500, cost_speed: 120,
      waves: [
        { enemy_id: "enemy_kid", count: 3, interval: 180, delay: 60 },
        { enemy_id: "enemy_salaryman", count: 3, interval: 300, delay: 600 },
      ],
      reward_akari: 5, reward_coins: 150,
      star_thresholds: [4200, 3000, 1800],
    },
    {
      id: 3, name: "速攻注意報",
      description: "飢えたOLは速い。唐揚げで対抗しよう。",
      enemy_base_hp: 400, cost_speed: 130,
      waves: [
        { enemy_id: "enemy_kid", count: 3, interval: 150, delay: 60 },
        { enemy_id: "enemy_ol", count: 4, interval: 240, delay: 480 },
      ],
      reward_akari: 8, reward_coins: 200,
      star_thresholds: [4800, 3600, 2400],
    },
    {
      id: 4, name: "混合部隊",
      description: "いろんな空腹が押し寄せる。編成を考えよう。",
      enemy_base_hp: 600, cost_speed: 140,
      waves: [
        { enemy_id: "enemy_kid", count: 5, interval: 120, delay: 60 },
        { enemy_id: "enemy_salaryman", count: 3, interval: 240, delay: 300 },
        { enemy_id: "enemy_ol", count: 2, interval: 300, delay: 900 },
      ],
      reward_akari: 8, reward_coins: 250,
      star_thresholds: [5400, 4200, 3000],
    },
    {
      id: 5, name: "大食いチャレンジ",
      description: "大食いチャンピオン登場！ボスを倒せ！",
      enemy_base_hp: 800, cost_speed: 150,
      waves: [
        { enemy_id: "enemy_kid", count: 5, interval: 120, delay: 60 },
        { enemy_id: "enemy_salaryman", count: 3, interval: 180, delay: 300 },
        { enemy_id: "enemy_champ", count: 1, interval: 600, delay: 1200 },
      ],
      reward_akari: 10, reward_coins: 300,
      star_thresholds: [6000, 4800, 3600],
    },
    // === 春ステージ後半（中級） ===
    {
      id: 6, name: "早食い乱入",
      description: "早食い名人が壁を素通りする！遠距離が必要だ。",
      enemy_base_hp: 600, cost_speed: 140,
      waves: [
        { enemy_id: "enemy_kid", count: 4, interval: 150, delay: 60 },
        { enemy_id: "enemy_speed", count: 3, interval: 300, delay: 480 },
        { enemy_id: "enemy_salaryman", count: 2, interval: 240, delay: 900 },
      ],
      reward_akari: 10, reward_coins: 300,
      star_thresholds: [5400, 4200, 3000],
    },
    {
      id: 7, name: "物量作戦",
      description: "数の暴力。壁を途切れさせるな。",
      enemy_base_hp: 700, cost_speed: 160,
      waves: [
        { enemy_id: "enemy_kid", count: 10, interval: 90, delay: 60 },
        { enemy_id: "enemy_ol", count: 5, interval: 180, delay: 600 },
      ],
      reward_akari: 12, reward_coins: 350,
      star_thresholds: [6000, 4800, 3600],
    },
    {
      id: 8, name: "課長の接待",
      description: "課長が来た。長期戦を覚悟しろ。",
      enemy_base_hp: 1000, cost_speed: 150,
      waves: [
        { enemy_id: "enemy_salaryman", count: 5, interval: 180, delay: 60 },
        { enemy_id: "enemy_ol", count: 3, interval: 240, delay: 600 },
        { enemy_id: "enemy_boss", count: 1, interval: 600, delay: 1800 },
      ],
      reward_akari: 15, reward_coins: 400,
      star_thresholds: [7200, 5400, 3600],
    },
    {
      id: 9, name: "総力戦",
      description: "全種類の空腹が同時に来る。最強編成で挑め。",
      enemy_base_hp: 1200, cost_speed: 160,
      waves: [
        { enemy_id: "enemy_kid", count: 8, interval: 90, delay: 60 },
        { enemy_id: "enemy_salaryman", count: 4, interval: 180, delay: 300 },
        { enemy_id: "enemy_ol", count: 3, interval: 240, delay: 600 },
        { enemy_id: "enemy_speed", count: 2, interval: 360, delay: 900 },
        { enemy_id: "enemy_champ", count: 2, interval: 600, delay: 1500 },
      ],
      reward_akari: 15, reward_coins: 500,
      star_thresholds: [7800, 6000, 4200],
    },
    {
      id: 10, name: "灯を守れ",
      description: "春の最終決戦。課長とチャンピオンが同時に来る！",
      enemy_base_hp: 1500, cost_speed: 170,
      waves: [
        { enemy_id: "enemy_kid", count: 10, interval: 60, delay: 60 },
        { enemy_id: "enemy_salaryman", count: 5, interval: 150, delay: 300 },
        { enemy_id: "enemy_ol", count: 4, interval: 180, delay: 600 },
        { enemy_id: "enemy_champ", count: 1, interval: 600, delay: 1200 },
        { enemy_id: "enemy_boss", count: 1, interval: 600, delay: 2400 },
      ],
      reward_akari: 20, reward_coins: 600,
      star_thresholds: [9000, 7200, 5400],
    },
  ]
}

/// IDからステージを検索
pub fn get_stage_by_id(id : Int) -> StageDef? {
  for stage in get_all_stages() {
    if stage.id == id {
      return Some(stage)
    }
  }
  None
}

/// 最大ステージID
pub fn get_max_stage_id() -> Int {
  let stages = get_all_stages()
  let mut max = 0
  for stage in stages {
    if stage.id > max {
      max = stage.id
    }
  }
  max
}
