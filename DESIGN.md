# Design System: 灯（あかり）— ADVゲーム

## 1. Visual Theme & Atmosphere

「灯」は定食屋の片隅で少しずつ近づく二人の物語を描くADVゲーム。
デザインは **温かいミニマリズム** — Notion の warm neutral アプローチを定食屋の情緒に翻訳したもの。

背景は pure white ではなく、和紙のような微かに黄味がかったオフホワイト（`#faf8f5`）。
テキストは pure black を避け、墨色（`#2a2825`）で柔らかさを保つ。
ボーダーは主張せず、`1px solid rgba(0,0,0,0.06)` の "whisper border" で構造を暗示する。
シャドウは多層構成で最大 opacity 0.06、感じ取れるが見えない深度を演出。

フォントは Noto Serif JP（見出し・物語テキスト）と Noto Sans JP（UI・ボタン）の二本立て。
Serif は display サイズで letter-spacing を広げ（0.15-0.3em）、書道的な余白感を出す。
Sans は UI 要素で控えめな letter-spacing（0.02-0.04em）で端正さを維持。

アクセントカラーは焦がしオレンジ（`#d4693d`）一色。定食屋の暖簾、行灯の灯り、
茜色の夕焼けを想起させる色で、CTA と親密度表示にのみ使用。装飾には使わない。

季節で背景色・パーティクル・パターンが変化し、四季の移ろいが視覚的に伝わる。
春は桜色、夏は水色、秋は琥珀、冬は灰青。変化は微細で、メインコンテンツを邪魔しない。

**Key Characteristics:**
- Noto Serif JP（display）+ Noto Sans JP（UI）の二書体構成
- 和紙ベースの warm neutral: `#faf8f5` 背景、`#2a2825` 墨色テキスト
- Whisper border: `1px solid rgba(0,0,0,0.06)` — 構造を暗示するだけ
- Multi-layer shadow: 最大 opacity 0.06 の 2-3 層スタック
- 焦がしオレンジ（`#d4693d`）が唯一のアクセント — CTA と♡のみ
- 8px ベースの spacing scale
- 季節テーマで CSS custom properties が切り替わる（春/夏/秋/冬）
- モバイルファースト（max-width: 480px）の縦型レイアウト

## 2. Color Palette & Roles

### Primary
- **墨色** (`#2a2825`): 主テキスト、見出し。pure black を避けた温かい黒
- **和紙白** (`#faf8f5`): ページ背景。黄味のある off-white
- **焦がしオレンジ** (`#d4693d`): Primary CTA、♡親密度、アクティブ要素

### Accent States
- **深オレンジ** (`#c05a30`): ボタン hover / pressed
- **オレンジ薄** (`rgba(212, 105, 61, 0.08)`): オレンジの soft background
- **オレンジ影** (`rgba(212, 105, 61, 0.2)`): CTA ボタンの glow shadow

### Warm Neutral Scale
- **白** (`#ffffff`): カード・elevated surface
- **生成り** (`#f3f0eb`): subtle surface、セクション背景
- **砂色** (`#e8e3dc`): ボーダー hover、divider
- **鼠色** (`#9b9590`): セカンダリテキスト、キャプション
- **薄鼠** (`#b8b2ab`): プレースホルダー、disabled テキスト

### 3-Axis Parameter Colors
- **信頼/Trust** — Blue: `#4a7dd7` (text), `rgba(74, 125, 215, 0.1)` (bg)
- **理解/Understanding** — Purple: `#7c52e0` (text), `rgba(124, 82, 224, 0.1)` (bg)
- **共感/Empathy** — Gold: `#d4940a` (text), `rgba(212, 148, 10, 0.1)` (bg)

### Card Rarity
- **Normal** — `#c8c0b8` (subtle gray)
- **Uncommon** — `#4a7dd7` (trust blue と同系)
- **Rare** — `#d4940a` (empathy gold と同系)

### Seasonal Theme Overrides
| Season | Primary | Secondary | Background |
|--------|---------|-----------|------------|
| Spring | `#e8a5a5` | `#f8dce2` | `#faf8f5` |
| Summer | `#6bbfe8` | `#d5f0f8` | `#f8fafb` |
| Autumn | `#e8a040` | `#f8e8d0` | `#faf9f5` |
| Winter | `#9badb8` | `#e0e5ea` | `#f9f9fb` |

### Shadows & Depth
- **Shadow SM**: `0 1px 2px rgba(0,0,0,0.03), 0 1px 3px rgba(0,0,0,0.02)` — カード基本
- **Shadow MD**: `0 2px 4px rgba(0,0,0,0.03), 0 4px 12px rgba(0,0,0,0.04)` — hover / elevated
- **Shadow LG**: `0 4px 8px rgba(0,0,0,0.03), 0 8px 24px rgba(0,0,0,0.05)` — overlay / modal
- **Whisper Border**: `1px solid rgba(0,0,0,0.06)` — カード・セクション区切り

## 3. Typography Rules

**Serif**: `"Noto Serif JP", serif` — 物語テキスト、見出し、ロゴ
**Sans**: `"Noto Sans JP", "Hiragino Kaku Gothic ProN", sans-serif` — UI 全般

| Role | Font | Size | Weight | Line Height | Letter Spacing |
|------|------|------|--------|-------------|----------------|
| Title Logo | Serif | 64px (4em) | 700 | 1.00 | 0.3em |
| Section Title | Serif | 17.6px (1.1em) | 600 | 1.30 | 0.05em |
| Story Text | Serif | 16.8px (1.05em) | 400 | 2.00 | 0.02em |
| Chapter Header | Serif | 12.8px (0.8em) | 400 | 1.40 | 0.08em |
| Body | Sans | 16px (1em) | 400 | 1.50 | normal |
| Card Name | Sans | 14.7px (0.92em) | 600 | 1.30 | 0.01em |
| Button | Sans | 14.4px (0.9em) | 500 | 1.00 | 0.02em |
| Button Large | Sans | 15.2px (0.95em) | 600 | 1.00 | 0.03em |
| Caption | Sans | 12px (0.75em) | 500 | 1.40 | 0.02em |
| Label / Stat | Sans | 12px (0.75em) | 500 | 1.30 | 0.04em |
| Param Badge | Sans | 11.2px (0.7em) | 600 | 1.30 | 0.02em |
| Card Param | Sans | 11.5px (0.72em) | 700 | 1.20 | 0.01em |

## 4. Component Stylings

### Buttons
- **Primary**: `#d4693d` bg, `#fff` text, 12px radius, `10px 24px` padding, multi-layer orange shadow
  - Hover: `#c05a30` bg, translateY(-1px), stronger glow
  - Active: scale(0.97), translateY(0)
  - Ripple: pseudo-element expands on :active
- **Secondary**: `#f3f0eb` bg, `#2a2825` text, 12px radius
  - Hover: `#e8e3dc` bg
- **Small**: 8px radius, `5px 14px` padding, 0.78em text
- **Close**: transparent bg, `#9b9590` text, hover → `#2a2825`

### Cards (Action / Hand)
- White bg, whisper border, 14px radius, shadow-sm
- Hover: shadow-md, translateY(-2px)
- Active: scale(0.98), translateY(0)
- Disabled: opacity 0.35, grayscale(0.5)
- **Rarity border**: 2px solid with rarity color (normal/uncommon/rare)
- **Rare shimmer**: pseudo-element sweeps diagonally, 4s cycle

### Daily Menu Card
- Glassmorphism: `rgba(255,255,255,0.75)` bg, `backdrop-filter: blur(12px)`
- Whisper border: `1px solid rgba(255,255,255,0.4)`
- 14px radius, shadow-sm

### Album Tabs
- Segmented control: `#f3f0eb` bg container, 12px outer radius
- Inactive: transparent bg, `#9b9590` text
- Hover: white bg, `#2a2825` text
- Active tab: distinguished by background change

### Mission Items
- White bg, 12px radius, shadow-sm
- Status icon left (accent color), description center, reward right
- Transition on completion

### Parameter Badges
- Pill shape (8px radius), tinted background with parameter color
- Trust: blue tint, Understanding: purple tint, Empathy: gold tint

## 5. Layout Principles

### Spacing Scale (8px base)
| Token | Value | Usage |
|-------|-------|-------|
| `--space-1` | 4px | 密接な要素間（badge 内 padding） |
| `--space-2` | 8px | 関連要素間（ラベルと値） |
| `--space-3` | 12px | コンポーネント内 gap |
| `--space-4` | 16px | セクション内 gap、カード padding |
| `--space-6` | 24px | メインコンテンツ padding、セクション間 |
| `--space-8` | 32px | 大セクション間 |
| `--space-12` | 48px | ページ区切り |

### Layout
- **Container**: max-width 480px, centered — モバイルADV体験
- **Main content**: padding 0 24px 24px
- **Header**: sticky top, padding 16px 24px 12px, mask-image で下端をフェード
- **Card stack**: 縦並び、gap 10-12px
- **Center alignment**: タイトル画面・日付・ゲージのみ。他は左揃え基本

### Whitespace Philosophy
- ゲシュタルトの近接の法則に従う: 関連要素は近く、セクション間は広く
- story-text の line-height: 2.0 — 行間に余白を持たせ、読みやすさと余韻を両立
- 空の状態（empty state）にも十分な padding（32-40px）

## 6. Depth & Elevation

4段階の depth system。Shadow は全て多層構成で soft。

| Level | Surface | Shadow | Usage |
|-------|---------|--------|-------|
| 0 | `#faf8f5` (bg) | none | ページ背景 |
| 1 | `#f3f0eb` (subtle) | none | セクション背景、missions |
| 2 | `#ffffff` (elevated) | shadow-sm + whisper border | カード、メニュー、entries |
| 3 | `#ffffff` | shadow-md | hover 状態、フォーカス |
| 4 | `#ffffff` | shadow-lg | overlay、modal |

**原則**: Shadow で浮遊感を出すのではなく、背景色の微差 + whisper border で階層を作る。
Shadow は hover 時のフィードバックとして使い、静止状態では最小限。

## 7. Do's and Don'ts

### Do's
- warm neutral を使う（グレーに黄味を混ぜる）
- 余白で情報を区切る（ボーダーではなく）
- Serif を物語テキスト・見出しに、Sans を UI に使い分ける
- アクセントカラーは CTA と♡にのみ
- 季節テーマは CSS custom properties で切り替え
- transition は要素サイズに合わせる（小: 150ms, 中: 200ms, 大: 300ms）
- カードの hover で translateY(-2px) + shadow 増加

### Don'ts
- pure black (#000000) をテキストに使わない → `#2a2825`
- pure white (#ffffff) を背景に使わない → `#faf8f5`
- アクセントカラーを装飾的に使わない（背景色、大面積の塗りは NG）
- border-radius を全て同じにしない（カード: 14px, ボタン: 12px, badge: 8px, 入力: 6px）
- shadow を単層にしない（常に 2-3 層スタック）
- transition: all を使わない（変化するプロパティを明示）
- アニメーションを 0.5s 超にしない（UI フィードバックとして遅すぎる）

## 8. Responsive Behavior

モバイルファーストの縦型レイアウト（max-width: 480px）。

| Breakpoint | Behavior |
|------------|----------|
| < 375px | padding を 16px に縮小、フォントサイズ微調整 |
| 375-480px | デフォルトデザイン |
| > 480px | 中央揃え、左右に背景パターンが見える |

- タッチターゲット: 最小 44px (iOS HIG 準拠)
- `touch-action: manipulation` で連続タップズームを防止
- `min-height: 100dvh` で mobile viewport に対応
- sticky header は mask-image で下端をフェードアウト

## 9. Agent Prompt Guide

### Quick Color Reference
```
Background:     #faf8f5 (warm off-white)
Surface:        #ffffff (cards)
Subtle:         #f3f0eb (sections)
Text Primary:   #2a2825 (warm near-black)
Text Secondary: #9b9590 (warm gray)
Text Tertiary:  #b8b2ab (light warm gray)
Accent:         #d4693d (burnt orange)
Accent Hover:   #c05a30 (deep orange)
Trust:          #4a7dd7 (blue)
Understanding:  #7c52e0 (purple)
Empathy:        #d4940a (gold)
Border:         rgba(0,0,0,0.06) (whisper)
```

### Ready-to-use Prompt
「定食屋の温かみを和紙ベースの off-white + 墨色テキスト + Noto Serif JP で表現。
 アクセントは焦がしオレンジ一色のみ。ボーダーは whisper-weight (opacity 0.06)、
 シャドウは 2-3 層スタック (max opacity 0.05)。余白で語り、装飾は最小限。」
