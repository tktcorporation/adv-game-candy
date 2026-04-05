# CLAUDE.md

## Build & Preview
- `moon build --target js --release && npx rolldown -c rolldown.config.mjs` — JS bundle 生成
- `npx serve dist` — ローカルプレビュー (http://localhost:3000)
- `moon check` — 型チェックのみ（高速）
- `npm run lint:scenario` — シナリオ lint

## Data SSOT
- キャラクター設定: `src/data/characters.mbt`（コメント含む）が唯一の真実源
- ストーリー構成: `src/data/scenarios.mbt` + 各章ファイル
- docs/ はポインタまたは設計経緯のみ

## シナリオ設計原則
- キャラ設定を先に詰める。設定が物語を駆動する（演出から逆算しない）
- 主人公は明るいツッコミ型。重い内省を減らし、掛け合い中心で
- 会話比率 70% 目標。ナレーションは場の空気を作る最低限に
- 専門知識が必要な舞台は避ける
- ヒロインの行動変化には明確なきっかけイベントが必要
