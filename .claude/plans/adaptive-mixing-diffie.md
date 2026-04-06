# 体験設計リライト — 「灯」UXオーバーホール

## Context

**問題**: ゲームを触っても「何をすべきか」「なぜカードをタップするのか」が分からない。
- カードに「共+10」と表示されるが実際は15%スケーリング後の「共+1」→ 嘘の情報
- Scene画面はシーンテキスト + ボタンだけ → 何が起きたか不明
- DayResult phase はロジック実装済みだがUI未実装 → 1日の振り返りがない
- Home画面は数値の羅列 → 目標が見えない

**方針**: チュートリアルは作らない。UI自体を見れば分かる状態にする。
スコープは体験の核（Home/カード/Scene/DayResult/ヘッダー）のみ。ガチャ/強化UIは含めない。
席の距離ビジュアルは使わない（ユーザーが分かりにくいと判断）。

---

## 実装順序

型定義 → state追加 → データ関数 → ロジック修正 → UI変更 の順で型安全に進める。

### Step 1: 型定義 (`src/data/types.mbt`)

`CardResult` struct を追加（L329付近、DayResultDataの後）:

```moonbit
/// カードプレイ結果（Scene画面表示用）
///
/// play_card() で生成し、Scene画面で表示する。
/// base値ではなくスケーリング後の実効値を保持。
pub(all) struct CardResult {
  trust_gain : Int
  understanding_gain : Int
  empathy_gain : Int
  coin_reward : Int
  exp_reward : Int
  gem_reward : Int
  reaction_text : String
}
```

### Step 2: state追加 (`src/game/state.mbt`)

GameState struct に追加（L121 `day_result` の近く）:
```moonbit
  last_card_result : @signals.Signal[@data.CardResult]
```

`create_game_state()` (L171) の初期化に追加（L225付近）:
```moonbit
    last_card_result: @signals.signal({
      trust_gain: 0, understanding_gain: 0, empathy_gain: 0,
      coin_reward: 0, exp_reward: 0, gem_reward: 0, reaction_text: "",
    }),
```

### Step 3: データ関数 (`src/data/characters.mbt`)

#### 3a. `get_reaction_text()` を新規追加（L196の後）

行動タイプ × 親密度レベルのマトリクスで1行リアクションを返す。
上限なし対応（Lv50+にもテキストあり）。

```moonbit
pub fn get_reaction_text(action_type : String, affection_level : Int) -> String {
  match action_type {
    "eat" => if affection_level < 3 { "" }
             else if affection_level < 10 { "箸の動きが揃った。" }
             else if affection_level < 20 { "「……美味しいですね」" }
             else if affection_level < 30 { "二人分のいただきます。" }
             else if affection_level < 50 { "自然に小鉢を分けた。" }
             else { "「今日も一緒ですね」" }
    "observe" => if affection_level < 3 { "本に集中している。" }
                 else if affection_level < 10 { "ちらりとこちらを見た。" }
                 else if affection_level < 20 { "視線が合って微笑んだ。" }
                 else if affection_level < 30 { "「……見すぎですよ」" }
                 else if affection_level < 50 { "読んでる本を見せてくれた。" }
                 else { "肩が触れても離れない。" }
    "talk" => if affection_level < 3 { "丸山が間に入ってくれた。" }
              else if affection_level < 10 { "小さく頷いた。" }
              else if affection_level < 20 { "自分から話し始めた。" }
              else if affection_level < 30 { "穏やかに笑っている。" }
              else if affection_level < 50 { "声を出して笑った。" }
              else { "「……ずっと、こうしていたい」" }
    _ => ""
  }
}
```

#### 3b. `get_affection_description()` のLv50+拡張 (L170-174)

現在の `else` 節（L172-174）を分割:
```moonbit
  } else if level < 70 {
    "いつからか、灯に来る理由が変わっていた。"
  } else if level < 100 {
    "灯にいる時間が、一日で一番穏やかだ。"
  } else {
    "言葉にしなくても、伝わっている気がする。"
  }
```

#### 3c. `get_affection_milestones()` のLv60+拡張 (L194の後)

```moonbit
    { level: 60, reward_type: "gem", reward_amount: 200, description: "200 星石" },
    { level: 70, reward_type: "gem", reward_amount: 200, description: "200 星石 + ボンドストーリー" },
    { level: 80, reward_type: "gem", reward_amount: 250, description: "250 星石" },
    { level: 100, reward_type: "gem", reward_amount: 300, description: "300 星石 + ボンドストーリー" },
```

### Step 4: カード実効値プレビュー (`src/game/card_system.mbt`)

`calculate_card_gains()` (L249) の後に追加:

```moonbit
/// カードプレイ前の獲得値プレビュー（UI表示用）
///
/// play_card() と同じ計算ロジックで実効値を返す。
/// app.mbt のカード表示で、base値ではなく実効値を表示するために使用。
pub fn preview_card_gains(
  state : GameState,
  card : @data.ActionCard
) -> (Int, Int, Int) {
  let card_star = get_card_star_rank(state, card.id)
  let card_level = get_card_level(state, card.id)
  let effective_star = if card_star > 0 { card_star } else { 1 }
  let effective_level = if card_level > 0 { card_level } else { 1 }
  let memory_ids : Array[String] = []
  for record in state.acquired_memories.get() {
    memory_ids.push(record.memory_id)
  }
  let (m_t, m_u, m_e) = calculate_memory_bonus(
    state.memory_slots.get(), memory_ids,
  )
  calculate_card_gains(card, effective_star, effective_level, m_t, m_u, m_e)
}
```

**注**: `get_card_star_rank` / `get_card_level` は `gacha_system.mbt` にある（同じ `@game` パッケージ）。
`calculate_memory_bonus` は `memory_system.mbt` にある（同じ `@game` パッケージ）。
パッケージ内なので直接呼べる。

### Step 5: play_card() 修正 (`src/game/logic.mbt`)

L354（`grant_action_rewards` の直前）付近に `last_card_result` セットを追加:

```moonbit
  // カード結果をScene表示用に保存
  let coin_reward = get_card_coin_reward(card.rarity)
  let exp_reward = get_card_exp_reward(card.rarity)
  let gem_reward = get_card_gem_reward(card.rarity)
  let affection_level = get_affection_level(state.intimacy.get())
  let reaction = @data.get_reaction_text(action_str, affection_level)
  state.last_card_result.set({
    trust_gain, understanding_gain, empathy_gain,
    coin_reward, exp_reward, gem_reward,
    reaction_text: reaction,
  })
```

既存のL360-362のメッセージ生成は `coin_reward` が重複するので、新しい変数を使うように調整。

### Step 6: UI変更 (`src/ui/app.mbt`)

#### 6a. ヘッダー簡素化 (`render_header` L76-136)

- `header-params` div (L99-116) を **削除**（信頼/理解/共感の3行）
- `header-stats` の `get_affection_display(state)` を `"♡Lv" + level + " (" + current + "/" + next + ")"` 形式に変更

変更後のヘッダー:
```
灯  春 3日目 ☀️  ♡Lv3(15/45)  AP 4/5
```

#### 6b. Home画面リデザイン (`render_home_view` L169-349)

情報を並べ替え。上から:

1. **♡親密度 + 関係性テキスト** (NEW)
   - `@game.get_affection_level(state.intimacy.get())` → レベル
   - `@data.get_affection_description(level)` → テキスト
2. **次の目標セクション** (NEW)
   - 次の章名: `@data.get_chapters()[current + 1].title + subtitle`
   - PLv進捗バー: `state.player_exp.get()` / `@game.exp_for_next_level(state.player_level.get())`
   - テキスト表現: `"PLv " + level + " ████░░░░ " + exp + "/" + needed`
3. **今日の日替わり** (既存 L178-200、そのまま)
4. **メインボタン「灯に行く」/ 「次の日へ」** (既存 L262-303、そのまま)
5. **AP ゲージ** (既存 L247-261、そのまま)
6. **デイリーミッション** (既存 L304-335、報酬表示を `coins+gems` に改善)
7. **3軸パラメータ + 通貨** (NEW — 下部に小さく)
   - `"信頼 " + trust + " ▸ 理解 " + understanding + " ▸ 共感 " + empathy`
   - `"コイン " + coins + "  星石 " + gems`
8. **フッター: アルバム** (既存 L337-348)

#### 6c. カード表示修正 (`render_hand_card` L424-531)

カードパラメータ部分 (L464-495) を変更:

Before:
```moonbit
@dom.text("信+" + card.trust_gain.to_string())
```

After:
```moonbit
// preview_card_gains で実効値を取得
let (t, u, e) = @game.preview_card_gains(state, card)
// 各軸を表示（0より大きい場合のみ）
// + ♡合計表示
let total = t + u + e
```

表示形式: `"信+2 理+1 共+1  ♡+4"`

**注**: `@dom.text_dyn` ではなく、render時点で `preview_card_gains` を呼ぶ。
カードは `for_each` 内でレンダリングされるので、各カードごとに計算される。

#### 6d. Scene画面強化 (`render_scene_view` L538-579)

シーンテキストとボタンの間に結果セクションを挿入:

```moonbit
// 結果セクション
@dom.div(
  class="scene-result",
  [
    @dom.div(
      class="scene-gains",
      [@dom.text_dyn(fn() {
        let r = state.last_card_result.get()
        let mut parts : Array[String] = []
        if r.trust_gain > 0 { parts.push("信頼 +" + r.trust_gain.to_string()) }
        if r.understanding_gain > 0 { parts.push("理解 +" + r.understanding_gain.to_string()) }
        if r.empathy_gain > 0 { parts.push("共感 +" + r.empathy_gain.to_string()) }
        let total = r.trust_gain + r.understanding_gain + r.empathy_gain
        parts.push("♡ +" + total.to_string())
        parts.join("  ")  // ← Array.join があるか要確認、なければ手動結合
      })],
    ),
    @dom.div(
      class="scene-rewards",
      [@dom.text_dyn(fn() {
        let r = state.last_card_result.get()
        "+" + r.coin_reward.to_string() + " コイン  +" + r.exp_reward.to_string() + " EXP"
      })],
    ),
    @dom.show(
      fn() { state.last_card_result.get().reaction_text != "" },
      fn() {
        @dom.div(
          class="scene-reaction",
          [@dom.text_dyn(fn() { "♪ " + state.last_card_result.get().reaction_text })],
        )
      },
    ),
  ],
)
```

#### 6e. DayResult画面実装 (`render_day_result_view` — 新規関数)

`app()` 関数 (L30-67) に DayResult phase の表示を追加:
```moonbit
@dom.show(
  fn() { state.phase.get() == @data.GamePhase::DayResult },
  fn() { render_day_result_view(state) },
),
```

新規関数 `render_day_result_view`:
```moonbit
fn render_day_result_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="day-result-view",
    [
      // タイトル
      @dom.div(class="day-result-title",
        [@dom.text_dyn(fn() { state.day.get().to_string() + "日目の記録" })]),
      // 行動回数
      @dom.div(class="day-result-actions",
        [@dom.text_dyn(fn() { "今日の行動: " + state.day_result.get().cards_played.to_string() + "回" })]),
      // パラメータ変化
      @dom.div(class="day-result-gains",
        [@dom.text_dyn(fn() {
          let r = state.day_result.get()
          "信頼 +" + r.trust_gained.to_string() +
          "  理解 +" + r.understanding_gained.to_string() +
          "  共感 +" + r.empathy_gained.to_string()
        })]),
      // 親密度レベルアップ（条件付き）
      @dom.show(
        fn() { state.day_result.get().affection_level_up },
        fn() { @dom.div(class="day-result-levelup",
          [@dom.text_dyn(fn() {
            let r = state.day_result.get()
            "♡ 親密度 → Lv" + r.new_affection_level.to_string() + " UP!"
          })]) },
      ),
      // 通貨獲得
      @dom.div(class="day-result-currency",
        [@dom.text_dyn(fn() {
          let r = state.day_result.get()
          "コイン +" + r.coins_earned.to_string() +
          "  星石 +" + r.gems_earned.to_string()
        })]),
      // 明日の目標
      @dom.div(class="day-result-next-goal", [
        @dom.text_dyn(fn() {
          let current_ch = state.current_chapter.get()
          let chapters = @data.get_chapters()
          let player_lv = state.player_level.get()
          let exp = state.player_exp.get()
          if current_ch + 1 < chapters.length() {
            let next = chapters[current_ch + 1]
            let needed_lv = next.unlock_player_level
            if player_lv < needed_lv {
              let exp_needed = @game.exp_for_next_level(player_lv) - exp
              "次の章まで: PLv" + needed_lv.to_string() + " (EXP あと" + exp_needed.to_string() + ")"
            } else {
              "次の章が読めます！"
            }
          } else {
            ""
          }
        }),
      ]),
      // ボタン
      @dom.div(class="day-result-actions-btn", [
        @dom.button(
          class="btn btn-primary btn-large",
          on=@dom.events().click(fn(_e) { @game.advance_to_next_day(state) }),
          [@dom.text("次の日へ")],
        ),
      ]),
    ],
  )
}
```

---

## 修正ファイル一覧（実装順）

| 順 | ファイル | 変更内容 |
|----|---------|---------|
| 1 | `src/data/types.mbt` L329付近 | `CardResult` struct追加 |
| 2 | `src/game/state.mbt` L121, L225付近 | `last_card_result` Signal追加 + 初期化 |
| 3 | `src/data/characters.mbt` L157, L181, L196付近 | `get_reaction_text()` 追加、`get_affection_description()` 拡張、milestones拡張 |
| 4 | `src/game/card_system.mbt` L270付近 | `preview_card_gains()` pub関数追加 |
| 5 | `src/game/logic.mbt` L354付近 | `play_card()`で`last_card_result`設定 |
| 6 | `src/ui/app.mbt` L30-67, L76-136, L169-349, L424-531, L538-579 | ヘッダー簡素化、Home改善、カード実数値、Scene強化、DayResult画面追加 |

## 検証方法

1. `moon check` — 型チェック（各Step後に実行）
2. `moon build --target js --release && npx rolldown -c rolldown.config.mjs` — フルビルド
3. ブラウザ確認 (`npx serve dist`):
   - Home: ♡親密度 + 関係性テキスト + 次の目標 + PLv進捗バー + 通貨
   - カード: 実効値（1-2程度の小さい数値） + ♡+N 表示
   - Scene: シーンテキスト + 獲得値 + コイン/EXP + リアクションテキスト
   - DayResult: 1日の成果 + レベルアップ + 明日の目標
   - ヘッダー: ♡Lv + AP のみ（3軸なし）
4. `node _build/js/release/build/sim/sim.js` — シミュレーター（バランス変更なし）
