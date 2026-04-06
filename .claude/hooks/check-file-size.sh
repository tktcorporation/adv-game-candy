#!/bin/bash
# PostToolUse hook: ファイルサイズ上限チェック
#
# Edit/Write で .mbt ファイルを変更した後に自動実行。
# 300行を超えるファイルは分割を促す警告を出す。
# Claude のコンテキストに警告が注入され、自発的に分割を検討する。

set -euo pipefail

INPUT=$(cat)

FILE_PATH=$(echo "$INPUT" | grep -oP '"file_path"\s*:\s*"\K[^"]+' || true)

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# .mbt ファイルのみチェック
if ! echo "$FILE_PATH" | grep -qP '\.mbt$'; then
  exit 0
fi

if [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

LINE_COUNT=$(wc -l < "$FILE_PATH")
WARN_THRESHOLD=300
ERROR_THRESHOLD=500

if [ "$LINE_COUNT" -gt "$ERROR_THRESHOLD" ]; then
  echo "⚠️ FILE TOO LARGE: $FILE_PATH ($LINE_COUNT 行) — 上限 ${ERROR_THRESHOLD} 行を超過。責務ごとにファイルを分割すること。"
  echo "   例: ui/app.mbt → ui/app_render.mbt + ui/app_handlers.mbt + ui/app_state.mbt"
elif [ "$LINE_COUNT" -gt "$WARN_THRESHOLD" ]; then
  echo "📏 FILE SIZE WARNING: $FILE_PATH ($LINE_COUNT 行) — ${WARN_THRESHOLD} 行超過。分割を検討すること。"
fi
