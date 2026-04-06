# DESIGN.md — 灯 (Akari) ADV Game UI Design System

## 1. Visual Theme & Atmosphere

**Mood**: 温かみのある定食屋の空気感 — 木の温もり、湯気、日差し。
Arc Browser のミニマリズムと Duolingo のマイクロインタラクションを融合。
「枠で囲まない」UI。余白・タイポグラフィ・微細なシャドウで情報階層を作る。

**Design Philosophy**:
- **引き算の美学**: ボーダーや仕切り線は最小限。情報の区切りは余白で表現
- **温かい余白**: 真っ白ではなく黄味がかったオフホワイト。定食屋の壁の色
- **季節が呼吸する**: 4つの季節テーマがCSSカスタムプロパティで自然に切り替わる
- **触り心地**: すべてのインタラクションに物理的なフィードバック（バウンス、スプリング）

## 2. Color Palette & Roles

### Core Colors
| Role | Token | Value | Usage |
|------|-------|-------|-------|
| Background | `--bg` | `#faf8f5` | メイン背景。温かいオフホワイト |
| Elevated | `--bg-elevated` | `#ffffff` | カード・ダイアログの背景 |
| Subtle | `--bg-subtle` | `#f3f0eb` | セクション区切り・disabled背景 |
| Text Primary | `--text` | `#2c2c2c` | 本文テキスト |
| Text Secondary | `--text-secondary` | `#7a7a7a` | 補足・ラベル |
| Text Tertiary | `--text-tertiary` | `#a8a098` | プレースホルダー・メタ情報 |
| Accent | `--accent` | `#e8734a` | CTA・♡・重要ハイライト |
| Accent Hover | `--accent-hover` | `#d4623b` | アクセントのホバー状態 |
| Accent Soft | `--accent-soft` | `rgba(232,115,74,0.08)` | アクセントの背景利用 |

### Semantic Colors (3-Axis Parameters)
| Role | Token | Value | Usage |
|------|-------|-------|-------|
| Trust | `--trust-color` | `#5b8def` | 信頼パラメータ |
| Trust BG | `--trust-bg` | `rgba(91,141,239,0.10)` | 信頼バッジ背景 |
| Understanding | `--understanding-color` | `#8b5cf6` | 理解パラメータ |
| Understanding BG | `--understanding-bg` | `rgba(139,92,246,0.10)` | 理解バッジ背景 |
| Empathy | `--empathy-color` | `#f59e0b` | 共感パラメータ |
| Empathy BG | `--empathy-bg` | `rgba(245,158,11,0.10)` | 共感バッジ背景 |
| Success | `--success` | `#34d399` | ミッション完了・達成 |
| Success BG | `--success-bg` | `rgba(52,211,153,0.10)` | 達成バッジ背景 |

### Card Rarity
| Rarity | Border | Glow |
|--------|--------|------|
| Normal | `#c8c0b8` | none |
| Uncommon | `#5b8def` | `0 0 0 1px rgba(91,141,239,0.15)` |
| Rare | `#f59e0b` | `0 0 12px rgba(245,158,11,0.20)` |

### Seasonal Themes
| Season | Primary | Secondary | BG Tint |
|--------|---------|-----------|---------|
| Spring | `#f0b7b7` | `#fce4ec` | `#faf8f5` |
| Summer | `#81d4fa` | `#e0f7fa` | `#f8fafb` |
| Autumn | `#ffb74d` | `#fff3e0` | `#faf9f5` |
| Winter | `#b0bec5` | `#eceff1` | `#f9f9fb` |

## 3. Typography Rules

**Font Stack**:
- Display/Title: `"Noto Serif JP", serif` — 和の品格
- Body/UI: `"Noto Sans JP", "Hiragino Kaku Gothic ProN", sans-serif` — 可読性

**Type Scale**:
| Role | Size | Weight | Letter-spacing | Font |
|------|------|--------|----------------|------|
| Logo | `3.5em` | 700 | `0.25em` | Serif |
| Page Title | `1.1em` | 600 | `0.06em` | Serif |
| Section Label | `0.75em` | 500 | `0.08em` | Sans |
| Body | `0.88em` | 400 | `0` | Sans/Serif |
| Caption | `0.78em` | 400 | `0.02em` | Sans |
| Micro | `0.72em` | 600 | `0.02em` | Sans |
| Header Title | `1.15em` | 700 | `0.12em` | Serif |

**Line Heights**:
- Narrative text (story/scene): `2.0` — 日本語の読みやすさを最優先
- UI text (buttons/labels): `1.4`
- Description: `1.6`

## 4. Component Stylings

### Buttons
```
Primary:
  background: var(--accent)
  color: #fff
  padding: 12px 28px
  border-radius: 14px
  font-weight: 600
  box-shadow: 0 2px 8px rgba(232,115,74,0.20)
  hover: translateY(-2px), shadow intensifies, glow
  active: scale(0.96), shadow reduces

Secondary:
  background: var(--bg-subtle)
  color: var(--text)
  padding: 10px 24px
  border-radius: 14px
  hover: background darken 3%
  active: scale(0.97)

Ghost:
  background: transparent
  color: var(--text-secondary)
  hover: color → var(--text)
```

### Cards (Elevated Surface)
```
background: var(--bg-elevated)
border-radius: 16px
padding: 18px 22px
box-shadow: 0 1px 3px rgba(0,0,0,0.04), 0 4px 12px rgba(0,0,0,0.03)
transition: all 0.25s cubic-bezier(0.34, 1.56, 0.64, 1)
hover: translateY(-3px), shadow → 0 8px 24px rgba(0,0,0,0.08)
```

### Hand Card (Interactive)
```
background: var(--bg-elevated)
border: 2px solid var(--rarity-{level})
border-radius: 16px
padding: 14px 18px
hover: translateY(-4px) rotateX(2deg), enhanced shadow
active: scale(0.97), flat
disabled: opacity 0.35, grayscale(0.5)
```

### Tabs (Segmented Control)
```
Container:
  background: var(--bg-subtle)
  border-radius: 12px
  padding: 3px
  gap: 2px

Tab (inactive):
  background: transparent
  color: var(--text-secondary)
  padding: 8px 12px
  border-radius: 10px

Tab (active):
  background: var(--bg-elevated)
  color: var(--text)
  box-shadow: 0 1px 3px rgba(0,0,0,0.06)
```

### Progress Bar (Visual)
```
Track:
  background: var(--bg-subtle)
  height: 6px
  border-radius: 3px
  overflow: hidden

Fill:
  background: linear-gradient(90deg, var(--accent), var(--accent-hover))
  height: 100%
  border-radius: 3px
  transition: width 0.6s cubic-bezier(0.34, 1.56, 0.64, 1)
```

### Mission Item
```
background: var(--bg-elevated)
border-radius: 12px
padding: 10px 14px
gap: 10px
transition: all 0.3s ease

Completed:
  mission-status: color var(--success), scale bounce
  mission-desc: color var(--text-secondary)
```

### Badges (Parameter Pills)
```
font-size: 0.72em
font-weight: 700
padding: 3px 8px
border-radius: 8px
color: var(--{param}-color)
background: var(--{param}-bg)
```

## 5. Layout Principles

**Spacing Scale** (8px base):
| Token | Value | Usage |
|-------|-------|-------|
| `--space-xs` | `4px` | インラインギャップ |
| `--space-sm` | `8px` | コンパクトギャップ |
| `--space-md` | `16px` | セクション間 |
| `--space-lg` | `24px` | 主要セクション間 |
| `--space-xl` | `32px` | ビュー間パディング |
| `--space-2xl` | `48px` | ヒーロー上下 |

**Container**:
- Max width: `480px` (モバイルファースト)
- Side padding: `24px` (desktop), `20px` (≤480px)
- Centered with `margin: 0 auto`

**Vertical Rhythm**:
- Home view gap: `20px` — 各セクションに十分な余白
- Card list gap: `12px`
- Within-card gap: `6px`

## 6. Depth & Elevation

| Level | Shadow | Usage |
|-------|--------|-------|
| 0 (Flat) | none | 背景と同一面 |
| 1 (Subtle) | `0 1px 3px rgba(0,0,0,0.04)` | リスト項目 |
| 2 (Card) | `0 1px 3px rgba(0,0,0,0.04), 0 4px 12px rgba(0,0,0,0.03)` | カード・日替わり |
| 3 (Float) | `0 8px 24px rgba(0,0,0,0.08)` | ホバー中カード |
| 4 (Modal) | `0 16px 48px rgba(0,0,0,0.12)` | ダイアログ・オーバーレイ |

**Glassmorphism** (日替わりメニューカード):
```
background: rgba(255,255,255,0.75)
backdrop-filter: blur(16px)
border: 1px solid rgba(255,255,255,0.4)
```

## 7. Do's and Don'ts

### Do's
- 余白を惜しまない。情報密度 < 呼吸感
- 季節カラーは背景・装飾のみ。テキスト色には使わない
- アニメーションはすべて `cubic-bezier(0.34, 1.56, 0.64, 1)`（バウンス）か `ease-out`
- 日本語テキストの行間は `2.0` を維持（物語テキスト）
- 数値の変化はカウントアップ + バウンスで「嬉しさ」を演出
- パラメータ色は3軸で統一（青=信頼、紫=理解、金=共感）

### Don'ts
- ボーダーで要素を囲まない（レアリティカード例外）
- 真っ白 `#fff` を背景に使わない（`#faf8f5` を使う）
- 情報を詰め込みすぎない。1画面1アクションを意識
- 影を濃くしない。`rgba(0,0,0)` の最大不透明度は `0.12`
- アニメーション duration は `800ms` を超えない（ページ遷移除く）
- 絵文字をデザイン要素として多用しない。テキスト内の補助のみ

## 8. Responsive Behavior

**Breakpoints**:
- Mobile (default): `max-width: 480px` — フルエッジ、padding縮小
- Desktop: `>480px` — 中央寄せ480pxコンテナ

**Adaptive Rules**:
- `#app` は常に `max-width: 480px`
- タッチ: `touch-action: manipulation` でダブルタップズーム防止
- ビューポート: `100dvh` で iOS Safari のアドレスバー対応
- フォントは相対サイズ (`em`) で親要素に追従

## 9. Animation System

### Transition Curves
| Name | Value | Usage |
|------|-------|-------|
| Bounce | `cubic-bezier(0.34, 1.56, 0.64, 1)` | カード・ボタン・UI要素 |
| Smooth | `ease-out` | フェードイン・スライド |
| Elastic | `easeOutElastic(1, .6)` | パラメータバウンス |
| Quick | `150ms ease` | ホバー・フォーカス |

### Page Transitions
- Home: 子要素が `40ms` ずつスタガーで上がる
- Story: ブラー → クリアのフェード (`0.6s`)
- Album: 下から滑り上がる (`0.4s bounce`)
- Cards: 手札配り (`0.4s bounce`, `80ms` stagger)

### Micro-interactions
- ボタン押下: `scale(0.96)` → `scale(1)` (`250ms`)
- パラメータ上昇: `scale(1.3)` バウンス (`400ms elastic`)
- ミッション達成: チェックマーク回転 (`600ms`)
- レベルアップ: パルス + スケール (`600ms`)

## 10. Agent Prompt Guide

ADVゲーム「灯」のUI変更時のクイックリファレンス:

- **新しいカードを追加**: `.hand-card` のスタイルを継承。rarity classで色分け
- **新しい画面**: `.{screen}-view` パターンに従い、入場アニメーション付与
- **パラメータ表示**: `--{param}-color` / `--{param}-bg` トークンを使用
- **ボタン追加**: `.btn` + `.btn-primary`/`.btn-secondary` + サイズclass
- **季節対応**: `var(--season-primary)` を使えば自動で季節色に変わる
