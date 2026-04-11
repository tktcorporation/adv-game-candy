# にゃんこ大戦争式「食材ディフェンス」でLayer 1を置き換える

## Context

現在のLayer 1（行動カードシステム）は「手札4枚から選ぶだけ」で意思決定がなく面白くない。
にゃんこ大戦争式のタワーディフェンスに丸ごと置き換える。

**選定理由**:
- にゃんこ大戦争は実質1Dゲーム（横方向のx座標のみ）→ 実装がシンプル
- レベル = 敵ウェーブパラメータだけで無限量産可能
- 食材キャラのガチャ → ソシャゲ収益モデルと直結
- Layer 2（灯ストーリー）はそのまま活かせる

## ゲーム設計

### コンセプト
定食屋「灯」の食材たちが、お腹を空かせた敵（空腹モンスター）から店を守る。

```
[灯の城]  おにぎり→ たまご→    ←サラリーマン ←学生  [敵の城]
  HP:100   味噌汁→            ←OL           HP:500
           ↑出撃コスト消費     ↑ウェーブで自動出現
```

### コアメカニクス
- **フィールド**: 横480px、1D（x座標のみ）
- **出撃コスト**: 時間経過で自動増加（毎秒+5）。上限100
- **プレイヤー操作**: 下部の食材キャラボタンをタップして出撃
- **自動戦闘**: キャラは自動で歩き、射程内の敵を自動攻撃
- **勝利条件**: 敵の城のHPを0にする
- **敗北条件**: 灯のHPが0になる

### 食材キャラ（プレイヤー側）
| キャラ | コスト | HP | 攻撃 | 速度 | 射程 | レア | 特徴 |
|--------|-------|-----|------|------|------|------|------|
| おにぎり | 30 | 150 | 8 | 2 | 30 | N | 壁。安くて硬い |
| たまご焼き | 50 | 100 | 15 | 3 | 30 | N | バランス型 |
| 味噌汁 | 80 | 60 | 20 | 1 | 120 | R | 遠距離。脆い |
| 唐揚げ | 70 | 120 | 20 | 5 | 30 | R | 速攻型 |
| 煮込みハンバーグ | 120 | 300 | 25 | 1 | 30 | SR | 重壁。高コスト |
| サバの味噌煮 | 100 | 80 | 35 | 2 | 80 | SR | 中距離火力 |
| 親子丼 | 150 | 200 | 40 | 3 | 30 | SSR | 高火力バランス |
| 日替わり定食 | 200 | 400 | 50 | 2 | 50 | SSR | 最強。ガチャ目玉 |

### 敵キャラ（空腹モンスター）
| 敵 | HP | 攻撃 | 速度 | 射程 | 特徴 |
|----|-----|------|------|------|------|
| はらぺこ小僧 | 80 | 8 | 3 | 30 | 雑魚。数で攻める |
| 空腹サラリーマン | 200 | 15 | 2 | 30 | 標準的な敵 |
| 飢えたOL | 120 | 25 | 4 | 30 | 速い。痛い |
| 大食いチャンピオン | 500 | 30 | 1 | 40 | ボス。硬くて強い |
| 早食い名人 | 150 | 10 | 7 | 30 | 超速。壁を抜ける |
| お腹ぺこぺこ課長 | 800 | 40 | 1 | 50 | 中ボス |

### レベルデータ構造（1レベル = パラメータだけ）
```
Level {
  id: 1,
  name: "昼休みの来客",
  enemy_base_hp: 300,
  cost_speed: 5,          // コスト回復速度（/秒）
  waves: [
    { enemy_id: "hungry_kid", count: 3, interval: 120, delay: 0 },
    { enemy_id: "hungry_salaryman", count: 2, interval: 180, delay: 300 },
  ],
  reward_akari: 5,
  reward_coins: 100,
  star_thresholds: [180, 120, 60],  // 3星/2星/1星のクリアタイム(秒)
}
```

### ストーリーとの統合
- ステージクリア → 灯ポイント獲得 → 灯訪問 → ストーリー解放（Layer 2はそのまま）
- ステージマップ = 季節ごと（春ステージ1-10, 夏11-20, ...）
- 3星クリアでボーナス灯ポイント

### ガチャ統合
- 既存のコイン通貨で食材キャラガチャ
- N/R/SR/SSR のレアリティ
- 被りで「強化素材」→ キャラレベルアップ

---

## 技術実装

### ゲームループ（requestAnimationFrame）

MoonBitからJS FFIで`requestAnimationFrame`を呼ぶ。
既に`animations_ffi.mbt`でFFIパターンが確立されている。

```
extern "js" fn request_animation_frame_ffi(callback : () -> Unit) -> Unit =
  #| (cb) => requestAnimationFrame(cb)
```

ただし、luna.mbtのreactive DOMと共存させるため、
**ゲーム状態をSignalで管理し、毎フレームSignalを更新 → DOMが自動反映** が基本戦略。

重い描画（多数ユニット移動）はCSS transform + anime.jsに任せ、
MoonBit側はロジック（位置計算、衝突判定、ダメージ処理）に集中。

### ユニット描画方式

各ユニットはdiv要素。位置はCSS `left` プロパティ。
にゃんこ大戦争と同様、絵文字/テキストでキャラ表現（画像不要）。

```css
.unit { position: absolute; bottom: 60px; transition: left 0.1s linear; }
.unit-onigiri::before { content: "🍙"; font-size: 24px; }
.unit-egg::before { content: "🥚"; font-size: 24px; }
```

### 衝突判定（1D）

```
if abs(ally.x - enemy.x) < ally.range {
  // ally attacks enemy
}
```

---

## ファイル構成

### 新規作成ファイル

| ファイル | 行数目安 | 内容 |
|---------|---------|------|
| `src/data/types_defense.mbt` | ~120行 | UnitDef, EnemyDef, Level, BattleState等の型 |
| `src/data/units.mbt` | ~150行 | 食材キャラ + 敵キャラのデータ定義 |
| `src/data/levels.mbt` | ~200行 | ステージ20-30個のレベルデータ |
| `src/game/defense_core.mbt` | ~250行 | ゲームループ、tick処理、勝敗判定 |
| `src/game/defense_battle.mbt` | ~200行 | 衝突判定、ダメージ計算、出撃処理 |
| `src/game/defense_state.mbt` | ~150行 | BattleState生成、Signal管理 |
| `src/ui/app_battle.mbt` | ~250行 | 戦闘画面UI（フィールド+出撃ボタン） |
| `src/ui/app_stages.mbt` | ~150行 | ステージ選択画面UI |
| `src/ui/defense_ffi.mbt` | ~50行 | requestAnimationFrame等のFFI |

### 変更するファイル

| ファイル | 変更内容 |
|---------|---------|
| `src/data/types.mbt` | GamePhaseに`StageSelect`, `Battle`, `BattleResult`追加 |
| `src/game/state.mbt` | BattleState関連のSignal追加。旧Layer1フィールドは残す(後方互換) |
| `src/game/gacha_system.mbt` | カード排出 → キャラ排出に変更 |
| `src/ui/app.mbt` | 新フェーズの表示分岐追加 |
| `src/ui/app_home.mbt` | 「今日の行動」→「ステージ選択」ボタンに変更 |
| `src/game/moon.pkg` | 依存追加不要（同パッケージ内） |
| `src/ui/moon.pkg` | 依存追加不要（同パッケージ内） |
| `src/data/moon.pkg` | 依存追加不要（同パッケージ内） |

### 削除/無効化するファイル

旧Layer 1のカードシステムは**削除せず残す**（ビルドが通る限り）。
Home画面の導線だけ「ステージ選択」に切り替える。

---

## 実装順序

### Phase 1: 型定義 + 最小限のゲームループ
1. `src/data/types_defense.mbt` — 型定義（UnitDef, EnemyDef, Level, BattleState）
2. `src/data/types.mbt` — GamePhaseに新フェーズ追加
3. `src/data/units.mbt` — 食材キャラ3体 + 敵2体（最小限）
4. `src/data/levels.mbt` — テスト用3ステージ
5. `moon check` で型チェック通過

### Phase 2: ゲームロジック
1. `src/game/defense_state.mbt` — BattleState生成
2. `src/game/defense_core.mbt` — tick処理（移動、タイマー、敵ウェーブ）
3. `src/game/defense_battle.mbt` — 衝突判定、ダメージ、出撃、勝敗判定
4. `src/game/state.mbt` — GameStateに統合

### Phase 3: UI
1. `src/ui/defense_ffi.mbt` — requestAnimationFrame FFI
2. `src/ui/app_battle.mbt` — 戦闘画面（フィールド + HP + 出撃ボタン）
3. `src/ui/app_stages.mbt` — ステージ選択
4. `src/ui/app.mbt` — フェーズ分岐追加
5. `src/ui/app_home.mbt` — ステージ選択への導線

### Phase 4: 統合 + バランス
1. ガチャ → キャラ排出に変更
2. ステージクリア → 灯ポイント報酬
3. レベルデータ20ステージ追加
4. ビルド + ブラウザ動作確認

---

## 検証方法

1. `moon check` — 型チェック（各Phase完了時）
2. `moon build --target js --release && npx rolldown -c rolldown.config.mjs` — ビルド
3. `npx serve dist` → ブラウザで動作確認（戦闘画面、出撃、敵移動、勝敗判定）
4. ステージ1-3をプレイしてバランス確認
