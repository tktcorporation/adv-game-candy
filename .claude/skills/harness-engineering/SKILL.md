---
name: harness-engineering
description: |
  ハーネスエンジニアリングの原則に基づき、エージェントのミスを構造的に防止するスキル。
  「同じミスを二度としない」ためのフィードバックループを回す。
  ミスを発見した時、リンタールール追加、知識タイムライン更新、hookの改善など
  決定的な検証レイヤーを強化する作業で使う。
  「ハーネスを改善して」「リンタールールを追加して」「知識タイムラインを更新して」
  「hookを追加して」「検証を自動化して」「同じミスが起きないようにして」で発動。
  シナリオの整合性問題を修正した後にも自動的に適用すること。
---

# ハーネスエンジニアリングスキル

> Agent = Model + Harness
> モデルがミスをするたびに、ハーネスを改良して二度と起きないようにする。
> — Mitchell Hashimoto

---

## 核心原則

### 1. 決定的な検証は自然言語の指示より信頼できる

| メカニズム | 分類 | 信頼度 |
|-----------|------|--------|
| CLAUDE.md の指示 | Guide × Inferential | 低 — コンテキスト圧迫で忘れる |
| スキル | Guide × Inferential | 中 — 必要時にロードされるが強制力なし |
| PostToolUse hook + リンター | Sensor × Computational | **高 — 100%発火、回避不能** |
| PreToolUse hook | Sensor × Computational | **最高 — 実行前にブロック可能** |

**原則: 2回以上繰り返されたミスは、自然言語の指示ではなくコードで防ぐ。**

### 2. フィードバックループを回す

```
ミスを発見
  ↓
パターンを言語化（「知識の先取り」「フォーマット不統一」等）
  ↓
決定的な検証を追加（リンタールール or hook）
  ↓
次回から自動検出
  ↓
新しいミスを発見... (ループ)
```

### 3. リンターのエラーメッセージ = 是正指示

リンターの出力はClaude のコンテキストに注入される。
エラーメッセージ自体が「何が問題で、どう直すべきか」を伝える是正指示として書く。

```
✗ 悪いメッセージ: "Validation failed"
✓ 良いメッセージ: "知識先取り: 「15年」は ch3_s1 で入手する情報。ch2 では使用不可"
```

---

## このプロジェクトのハーネス構成

### 現在のレイヤー

```
Layer 1: Computational Sensor（決定的・事後検証）
  └─ PostToolUse hook → scripts/lint-scenario.ts
       ├─ ruleSceneStateComments    — シーン状態コメント有無
       ├─ ruleChapterStateDiff      — 章ヘッダー状態差分有無
       ├─ ruleKnowledgeNoPrematureUse — 知識の先取り検出
       └─ lintUniformity            — 全章フォーマット統一

Layer 2: Computational Guide（決定的・事前誘導）
  └─ .claude/rules/, settings.json permissions

Layer 3: Inferential Guide（推論的・事前誘導）
  ├─ scenario-continuity スキル
  ├─ scenario-writing スキル
  └─ narrative-design スキル
```

### 主要ファイル

| ファイル | 役割 |
|---------|------|
| `src/lint/lint.mbt` | リンター本体（MoonBit → JSにコンパイル） |
| `src/data/knowledge-timeline.jsonl` | 知識入手タイムライン |
| `.claude/hooks/lint-scenario.sh` | PostToolUse hookラッパー |
| `.claude/settings.json` | hook登録 |
| `.claude/harness/README.md` | ハーネスの説明 |

---

## ミスを発見した時のワークフロー

### Step 1: パターンを分類する

| パターン | 対処 | 例 |
|---------|------|-----|
| 構造的欠如 | リンタールール追加 | 「状態コメントがない」 |
| 知識不整合 | timeline.jsonl にエントリ追加 | 「名前を先取りしている」 |
| フォーマット不統一 | 既存の uniformity ルールがカバー | 「ch0だけに適用した」 |
| 因果関係の破綻 | スキルの改善（自然言語） | 「なぜこの人がここに？」 |
| 物理的矛盾 | リンタールール追加 or スキル改善 | 「設備と描写が合わない」 |

### Step 2: 決定的に検証できるか判断する

**正規表現やキーワードマッチで検出できる？**
- YES → リンタールール (`scripts/lint-scenario.ts`) に追加
- NO → スキルの自然言語ガイド (scenario-continuity 等) に追加

### Step 3: 実装する

#### リンタールール追加の場合

`src/lint/lint.mbt` に関数を追加:

```moonbit
///|
/// [何をチェックするか]
///
/// 根拠: commit XXXXXXX — [どんな問題があったか]
fn rule_new_check(file_path : String, lines : Array[String]) -> Array[Violation] {
  let violations : Array[Violation] = []
  // 検証ロジック
  violations
}
```

`lint_file()` 内で呼び出しを追加:

```moonbit
fn lint_file(...) -> Array[Violation] {
  let violations : Array[Violation] = []
  violations.append(rule_scene_state_comments(file_path, lines))
  violations.append(rule_chapter_state_diff(file_path, content))
  violations.append(rule_knowledge_no_premature_use(file_path, lines, timeline))
  violations.append(rule_new_check(file_path, lines))  // ← 追加
  violations
}
```

ビルド: `moon build --target js`

#### 知識タイムライン更新の場合

`src/data/knowledge-timeline.jsonl` にエントリ追加:

```jsonl
{"subject":"protagonist","info":"[何の情報か]","source":"[誰から]","chapter":"ch[N]","scene":"s[M]","keywords":["キーワード1","キーワード2"],"note":"[補足]"}
```

### Step 4: 検証する

```bash
npm run lint:scenario
```

全章に対してリンターを実行し、新ルールが正しく動作することを確認する。

---

## hook の追加・変更ガイド

### PostToolUse hook（事後検証）

scenario_ch*.mbt の編集後に自動検証。ブロックはしない（既に書き込み済み）。
警告をClaude のコンテキストに注入し、自己修正を促す。

**現在の設定** (`settings.json`):
```json
"PostToolUse": [{
  "matcher": "Edit|Write",
  "hooks": [{
    "type": "command",
    "command": "$CLAUDE_PROJECT_DIR/.claude/hooks/lint-scenario.sh",
    "timeout": 30
  }]
}]
```

### PreToolUse hook（事前ブロック）

本当に危険な操作（データ損失等）にのみ使う。
シナリオの構造チェックには PostToolUse が適切。

### Stop hook（完了時検証）

将来的に追加を検討。「全章の修正伝播が完了しているか」を確認する用途。

---

## チェックリスト

シナリオの整合性問題を修正した後:

- [ ] このミスは正規表現やキーワードで検出可能か？
  - YES → リンタールールを追加したか
  - NO → スキルの自然言語ガイドを改善したか
- [ ] 新しい情報が追加された場合、knowledge-timeline.jsonl を更新したか
- [ ] `npm run lint:scenario` で全章が通過するか
- [ ] 追加したルールの根拠（コミットハッシュ/問題の説明）をJSDocに書いたか
