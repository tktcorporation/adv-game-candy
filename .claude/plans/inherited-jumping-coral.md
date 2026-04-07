# 2日目白画面バグ修正 + ゲームロードマップUI追加

## Context

ユーザーが2日目に進むと画面が真っ白になるバグが発生している。原因は `LoginBonus` フェーズのUIが未実装であること。また、ゲームの目的や進捗が見えず迷子になるため、ロードマップ的な全体進捗UIが必要。

---

## 修正1: 白画面バグ（LoginBonusフェーズUI未実装）

### 原因

`src/ui/app.mbt:38-83` の `app()` 関数で、`@dom.show` に `LoginBonus` フェーズが含まれていない。`advance_to_next_day()` (`src/game/logic_daily.mbt:90-94`) が2日目でログインボーナスを検出すると `LoginBonus` フェーズに遷移するが、対応するビューがないため何も表示されない。

### 修正内容

1. **`src/ui/app_day_result.mbt`** に `render_login_bonus_view()` を追加
   - ログインボーナスの連続日数と報酬内容を表示
   - 「受け取る」ボタンで `@game.claim_login_bonus(state)` を呼ぶ（既存関数、`src/game/progression_system.mbt:63-85`）
   - 報酬テーブルは `get_login_bonus_rewards()` (`src/game/progression_system.mbt:30-40`) から取得

2. **`src/ui/app.mbt`** の `app()` 関数に `LoginBonus` の `@dom.show` ブロックを追加（77行目付近）

### 既存リソース（再利用）
- `@game.claim_login_bonus(state)` — 報酬付与 + Home遷移（実装済み）
- `@game.get_login_bonus_rewards()` — 報酬テーブル（実装済み）
- `state.login_streak` — 連続ログイン日数（Signal、実装済み）

---

## 修正2: ゲームロードマップUI

### 問題

プレイヤーが「今何をすべきか」「ゲーム全体のどこにいるか」を把握できない。Home画面には個別の情報（ミッション、バフ等）はあるが、俯瞰的な進捗表示がない。

### 修正内容

**`src/ui/app_home.mbt`** の Home画面に「ロードマップ」セクションを追加（親密度表示の直後）。

表示内容:
1. **ストーリー進捗バー**: 全10章中X章クリア（テキストベースの進捗表示: `████░░░░░░ 3/10`）
2. **次の目標**: 状況に応じた動的メッセージ
   - 灯Pが足りない → 「灯Pを貯めて灯に行こう（あとX灯P）」
   - 灯Pがある → 「灯に行って物語を進めよう」
   - 次の章が解放済み → 「新しい物語が待っています！」
   - 全章クリア → 「物語は完結。灯にはいつでも通えます」
3. **次章タイトル**: 未クリアの次章名と必要来店数（ネタバレにならない範囲）

### 利用する既存データ
- `@data.get_chapters()` — 章一覧（タイトル、unlock_visit_count）
- `state.current_chapter` — 現在の章
- `state.total_visits` — 累計来店数
- `state.akari_points` — 灯ポイント
- `@game.visit_cost` — 来店コスト

---

## 修正対象ファイル

| ファイル | 変更内容 |
|---------|---------|
| `src/ui/app.mbt` | LoginBonus の `@dom.show` 追加（1ブロック） |
| `src/ui/app_day_result.mbt` | `render_login_bonus_view()` 関数追加 |
| `src/ui/app_home.mbt` | ロードマップセクション追加 |

---

## 検証方法

1. `moon check` で型チェック通過を確認
2. `moon build --target js --release && npx rolldown -c rolldown.config.mjs` でビルド
3. `npx serve dist` でローカルプレビュー
4. 手動テスト:
   - ゲーム開始 → chapter0読了 → 行動でスタミナ消費 → 次の日へ → **LoginBonusビューが表示されること**を確認（白画面にならない）
   - 報酬受け取り → Home画面に遷移すること
   - Home画面でロードマップセクションが表示され、章進捗と次の目標が見えること
