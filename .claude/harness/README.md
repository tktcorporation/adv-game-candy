# シナリオハーネス — 決定的検証レイヤー

スキル（自然言語ガイド）を補完する**決定的な検証レイヤー**。
scenario_ch*.mbt が編集されると自動で検証が走り、構造的な欠陥を検出する。

## 仕組み

```
scenario_ch*.mbt を Edit/Write
  ↓ PostToolUse hook
.claude/hooks/lint-scenario.sh（ラッパー）
  ↓ 対象ファイル判定
src/lint/lint.mbt → _build/js/.../lint.js（本体・MoonBit→JS）
  ↓ 4つのルールを実行
警告をstdoutに出力 → Claude のコンテキストに注入 → 自己修正
```

## ルールの追加方法（フィードバックループ）

**新しいミスを発見したら、ルールを追加する。**

1. `src/lint/lint.mbt` に `rule_*` 関数を追加する
2. 関数のコメントに「根拠」（どのコミット/問題から生まれたか）を書く
3. `lint_file()` 内で呼び出しを追加する
4. `moon build --target js` で再ビルド

### ルール関数の規約

```moonbit
///|
/// 何をチェックするか。
///
/// 根拠: commit XXXXXXX — どんな問題があったか
fn rule_new_check(file_path : String, lines : Array[String]) -> Array[Violation] {
  let violations : Array[Violation] = []
  // 検証ロジック
  violations
}
```

### ルールのカテゴリ

- `rule_scene_*` / `rule_chapter_*` — コメント構造の検証
- `rule_knowledge_*` — 知識追跡の検証
- `lint_uniformity` — 全章一貫性の検証

## 現在のルール一覧

| 関数名 | チェック内容 |
|--------|------------|
| `rule_scene_state_comments` | 全シーンに前提/変化/結果コメントがあるか |
| `rule_chapter_state_diff` | 章ヘッダーに状態差分があるか |
| `rule_knowledge_no_premature_use` | 知識の先取り使用がないか |
| `lint_uniformity` | 全章でフォーマットが統一されているか |

## 知識タイムライン

`src/data/knowledge-timeline.jsonl` — キャラクターの知識入手時点のデータ。
新情報がシナリオに追加されたら、ここにエントリを追加すること。

## 手動実行

```bash
npm run lint:scenario
```
