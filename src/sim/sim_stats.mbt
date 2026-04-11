// シミュレーション統計 — 型定義 + トラッカー + ヘルパー

// =========================================================================
// シミュレーション結果（統計データ付き）
// =========================================================================

/// 拡張スナップショット — 1時点のゲーム状態
struct DaySnapshot {
  day : Int
  trust : Int
  understanding : Int
  empathy : Int
  intimacy : Int
  affection_level : Int
  akari_points : Int
  coins : Int
  total_visits : Int
  deck_size : Int
  chapter : Int
  stamina : Int
}

/// シミュレーション全体の統計
struct SimStats {
  // カードプレイ統計
  total_card_plays : Int
  buff_grant_count : Int       // バフ付与回数
  buff_consume_count : Int     // バフ消費回数
  buff_miss_count : Int        // バフなしで消費カードを使った回数
  // 灯ポイント経済
  akari_from_actions : Int     // 行動から得た灯P
  akari_from_missions : Int    // ミッション報酬の灯P
  akari_from_challenges : Int  // 週チャレンジ報酬の灯P
  akari_from_login : Int       // ログインボーナスの灯P
  akari_from_chapters : Int    // 章クリア報酬の灯P
  akari_spent_on_visits : Int  // 灯訪問に消費した灯P
  // ミッション
  missions_completed : Int     // 達成ミッション数
  missions_total : Int         // 発生ミッション数
  // 週チャレンジ
  challenge_s_count : Int
  challenge_a_count : Int
  challenge_b_count : Int
  challenge_c_count : Int
  // カード別プレイ回数（上位追跡用）
  card_play_counts : Array[(String, Int)]
}

/// シミュレーション結果の統合
struct SimResult {
  snapshots : Array[DaySnapshot]
  stats : SimStats
}

/// スナップショット取得
fn take_snapshot(state : @game.GameState) -> DaySnapshot {
  {
    day: state.day.get(),
    trust: state.trust.get(),
    understanding: state.understanding.get(),
    empathy: state.empathy.get(),
    intimacy: state.intimacy.get(),
    affection_level: @game.get_affection_level(state.intimacy.get()),
    akari_points: state.akari_points.get(),
    coins: state.coins.get(),
    total_visits: state.total_visits.get(),
    deck_size: state.deck.get().card_ids.length(),
    chapter: state.current_chapter.get(),
    stamina: state.stamina.get(),
  }
}

// =========================================================================
// 統計トラッカー（シミュレーション中に蓄積）
// =========================================================================

/// ミュータブルな統計カウンター
struct MutStats {
  mut total_card_plays : Int
  mut buff_grant_count : Int
  mut buff_consume_count : Int
  mut buff_miss_count : Int
  mut akari_from_actions : Int
  mut akari_from_missions : Int
  mut akari_from_challenges : Int
  mut akari_from_login : Int
  mut akari_from_chapters : Int
  mut akari_spent_on_visits : Int
  mut missions_completed : Int
  mut missions_total : Int
  mut challenge_s_count : Int
  mut challenge_a_count : Int
  mut challenge_b_count : Int
  mut challenge_c_count : Int
  card_plays : Array[(String, Int)]
}

fn new_mut_stats() -> MutStats {
  {
    total_card_plays: 0,
    buff_grant_count: 0,
    buff_consume_count: 0,
    buff_miss_count: 0,
    akari_from_actions: 0,
    akari_from_missions: 0,
    akari_from_challenges: 0,
    akari_from_login: 0,
    akari_from_chapters: 0,
    akari_spent_on_visits: 0,
    missions_completed: 0,
    missions_total: 0,
    challenge_s_count: 0,
    challenge_a_count: 0,
    challenge_b_count: 0,
    challenge_c_count: 0,
    card_plays: [],
  }
}

/// カードプレイ記録
fn record_card_play(stats : MutStats, card_id : String) -> Unit {
  let mut found = false
  for i, entry in stats.card_plays {
    let (id, count) = entry
    if id == card_id {
      stats.card_plays[i] = (id, count + 1)
      found = true
      break
    }
  }
  if !found {
    stats.card_plays.push((card_id, 1))
  }
}

/// MutStats → SimStats に変換
fn freeze_stats(ms : MutStats) -> SimStats {
  let sorted = sort_card_plays(ms.card_plays)
  {
    total_card_plays: ms.total_card_plays,
    buff_grant_count: ms.buff_grant_count,
    buff_consume_count: ms.buff_consume_count,
    buff_miss_count: ms.buff_miss_count,
    akari_from_actions: ms.akari_from_actions,
    akari_from_missions: ms.akari_from_missions,
    akari_from_challenges: ms.akari_from_challenges,
    akari_from_login: ms.akari_from_login,
    akari_from_chapters: ms.akari_from_chapters,
    akari_spent_on_visits: ms.akari_spent_on_visits,
    missions_completed: ms.missions_completed,
    missions_total: ms.missions_total,
    challenge_s_count: ms.challenge_s_count,
    challenge_a_count: ms.challenge_a_count,
    challenge_b_count: ms.challenge_b_count,
    challenge_c_count: ms.challenge_c_count,
    card_play_counts: sorted,
  }
}

/// カード使用回数を降順ソート（単純選択ソート）
fn sort_card_plays(plays : Array[(String, Int)]) -> Array[(String, Int)] {
  let result : Array[(String, Int)] = []
  for entry in plays {
    result.push(entry)
  }
  for i in 0..<result.length() {
    let mut max_idx = i
    for j in (i + 1)..<result.length() {
      if result[j].1 > result[max_idx].1 {
        max_idx = j
      }
    }
    if max_idx != i {
      let tmp = result[i]
      result[i] = result[max_idx]
      result[max_idx] = tmp
    }
  }
  result
}

// =========================================================================
// ヘルパー
// =========================================================================

/// 完了ミッション数をカウント
fn count_completed_missions(state : @game.GameState) -> Int {
  let missions = state.daily_missions.get()
  let mut count = 0
  for m in missions {
    if m.completed {
      count = count + 1
    }
  }
  count
}

/// ミッション報酬の灯P推定
fn estimate_mission_akari(
  new_missions : Int,
  action_count : Int,
  has_buff : Bool
) -> Int {
  let mut akari = 0
  if action_count == 1 && new_missions >= 1 { akari = akari + 3 }
  if action_count == 3 && new_missions >= 1 { akari = akari + 5 }
  if has_buff && new_missions >= 1 { akari = akari + 2 }
  akari
}

/// ゲームフェーズの文字列表現（デバッグ用）
fn phase_to_string(p : @data.GamePhase) -> String {
  match p {
    Title => "Title"
    Story => "Story"
    Home => "Home"
    DailyAction => "DailyAction"
    DailyScene => "DailyScene"
    Visit => "Visit"
    VisitScene => "VisitScene"
    WeeklyChallenge => "WeeklyChallenge"
    DayResult => "DayResult"
    LoginBonus => "LoginBonus"
    Album => "Album"
    Gacha => "Gacha"
    DeckEdit => "DeckEdit"
    StageSelect => "StageSelect"
    Battle => "Battle"
    BattleResult => "BattleResult"
  }
}
