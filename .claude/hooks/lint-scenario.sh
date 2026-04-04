#!/bin/bash
# PostToolUse hook ラッパー
#
# Claude が Edit/Write で scenario_ch*.mbt を変更した後に自動実行される。
# stdinからツール情報（JSON）を受け取り、対象ファイルが scenario_ch*.mbt の場合のみ
# MoonBit リンター（JSにコンパイル済み）を呼び出す。
#
# リンターの出力は stdout に流れ、Claude のコンテキストに注入される。
# これにより Claude は違反を認識し、自己修正できる。

set -euo pipefail

PROJECT_ROOT="$(cd "$(dirname "$0")/../.." && pwd)"

# stdin から PostToolUse イベントデータを読み取る
INPUT=$(cat)

# file_path を抽出（Edit/Write ツールの場合）
FILE_PATH=$(echo "$INPUT" | grep -oP '"file_path"\s*:\s*"\K[^"]+' || true)

# file_path が空の場合はスキップ
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# scenario_ch*.mbt でなければスキップ
if ! echo "$FILE_PATH" | grep -qP 'scenario_ch\d+\.mbt$'; then
  exit 0
fi

# MoonBitリンター実行（ビルド済みJSを使用。未ビルドなら先にビルド）
LINT_JS="$PROJECT_ROOT/_build/js/debug/build/lint/lint.js"
if [ ! -f "$LINT_JS" ]; then
  moon build --target js 2>/dev/null
fi

exec node "$LINT_JS" "$FILE_PATH"
