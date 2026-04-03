// Character definitions for 廃墟カフェ復興記

/// Get all characters
pub fn get_characters() -> Array[Character] {
  [
    {
      id: "sakura",
      name: "佐倉 美月",
      age: 32,
      background: "元パティシエ。3年前に自分の店を閉めた。",
      pattern: "平日の午後、ほぼ毎日",
      favorite_menu: "r_deep_blend",
      challenge_menu: "r_houjicha_latte",
      intro_chapter: 0,
    },
    {
      id: "amano",
      name: "天野 蓮",
      age: 19,
      background: "大学生。経営学部。実家の金物屋は去年閉店。",
      pattern: "夕方〜夜、週3-4回",
      favorite_menu: "r_cocoa",
      challenge_menu: "r_caramel_latte",
      intro_chapter: 1,
    },
    {
      id: "miyauchi",
      name: "宮内 孝之",
      age: 58,
      background: "古書店「栞堂」店主。前オーナーの旧友。",
      pattern: "週末の朝",
      favorite_menu: "r_houjicha",
      challenge_menu: "r_houjicha_latte",
      intro_chapter: 2,
    },
    {
      id: "kanzaki",
      name: "神崎 凛",
      age: 28,
      background: "地元紙の記者。元大手出版社。",
      pattern: "不定期、取材の合間",
      favorite_menu: "r_seasonal_blend",
      challenge_menu: "r_apple_cinnamon",
      intro_chapter: 3,
    },
    {
      id: "kiritani",
      name: "桐谷 楓",
      age: 26,
      background: "Café BLANCエリアマネージャー。",
      pattern: "不定期",
      favorite_menu: "r_vanilla_coffee",
      challenge_menu: "r_tsukiakari",
      intro_chapter: 4,
    },
  ]
}

/// Get intimacy ranks
pub fn get_intimacy_ranks() -> Array[IntimacyRank] {
  [
    { stars: 1, min_points: 0, description: "初対面。表面的なやりとり。" },
    { stars: 2, min_points: 100, description: "名前を覚えてもらえた。好みが分かる。" },
    { stars: 3, min_points: 300, description: "サイドエピソード解放。特別な頼みごと。" },
    { stars: 4, min_points: 600, description: "深い話ができる。特別なスキル。" },
    { stars: 5, min_points: 1000, description: "最終エピソード。エンディングに影響。" },
  ]
}

/// Get login bonus tiers
pub fn get_login_bonus_tiers() -> Array[LoginBonusTier] {
  [
    { day: 1, reward: 200 },
    { day: 3, reward: 300 },
    { day: 7, reward: 500 },
    { day: 14, reward: 800 },
    { day: 21, reward: 1000 },
    { day: 28, reward: 2000 },
  ]
}
