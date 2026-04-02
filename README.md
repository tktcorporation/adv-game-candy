# 月灯り - 廃墟カフェ復興記

廃墟となったカフェ「月灯り」を復興させる、ストーリー駆動のカフェ経営ゲーム。

MoonBit + [luna.mbt](https://github.com/mizchi/luna.mbt) で構築されたブラウザゲームです。

## ゲーム概要

- **ノベルADVパート**: キャラクターとの出会い、前オーナーの謎を追う物語
- **カフェ経営パート**: メニュー選択、営業、レシピ開発
- **親密度システム**: 常連客との絆を深め、ストーリーを解放
- **デイリーミッション & ログインボーナス**: 毎日の目標と報酬

## ビルド & 実行

### 前提条件

- [MoonBit](https://www.moonbitlang.com/) ツールチェーン

### ビルド

```bash
moon update
moon build --target js --release
```

### 実行

ビルド後、`index.html` をローカルHTTPサーバーで開いてください。

```bash
# 例: Python のシンプルHTTPサーバー
python3 -m http.server 8080
# ブラウザで http://localhost:8080 を開く
```

## プロジェクト構成

```
src/
  data/       # ゲームデータ（シナリオ、キャラクター、レシピ）
  game/       # ゲームロジック（状態管理、営業ロジック）
  ui/         # UI コンポーネント（luna.mbt DSL）
  main/       # エントリーポイント
docs/
  DESIGN.md   # ゲームデザインドキュメント
  story/      # ストーリー設定資料
```

## 技術スタック

- **言語**: MoonBit
- **UIフレームワーク**: luna.mbt (mizchi/luna) - Fine-grained reactive UI
- **ターゲット**: JavaScript (ブラウザ)
- **リアクティブ**: mizchi/signals (alien-signals inspired)
