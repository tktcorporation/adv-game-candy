# UX Patterns from Blue Archive & Gakuen Idolmaster for ADV Game Adaptation

## Research Summary

This document synthesizes UX design patterns from Blue Archive (ブルアカ) and Gakuen Idolmaster (学マス) that can be adapted for a text-based (no images, emoji only) ADV game set in 定食屋「灯」.

---

## 1. Blue Archive: Home Screen & Navigation Patterns

### 1.1 Home Screen Information Hierarchy

Blue Archive uses **Flat Design 2.0**: broad single-color areas with selective transparency (a few percent), gradients, and shadows for depth.

**Key structural elements:**
- **Footer navigation**: Buttons separated by margins only (no dividing lines). Clean, uncluttered.
- **Font scale with large jumps**: Headers 44-46px, body 34-36px, secondary 29-31px, small 24-26px, accent 70-80px. The large ratio between sizes creates unmistakable visual hierarchy.
- **Illustrated icons with unified saturation**: Icons feel thematic without competing with core UI.
- **Skeuomorphic accents within flat design**: Notebook ruled lines on student management screens reinforce thematic coherence.

**Adaptable pattern for text ADV:**
- Use clear typographic hierarchy (large chapter title, medium dialogue, small system info)
- Use emoji as "icons" with consistent visual weight
- Separate navigation zones with whitespace, not borders

### 1.2 Cafe System (Passive Income)

- Unlocks after Chapter 2 Stage 2 (early but not immediate -- player must engage first)
- Generates credits and stamina passively based on "comfortability" score
- Comfortability increased by adding furniture or upgrading
- Players interact with characters in cafe (headpats, gifts) to raise bond levels
- Headpats refresh every 3 hours -- creates natural return cadence

**Adaptable pattern for text ADV:**
- Passive progression that accumulates while away (e.g., "days since last visit to the shop" affecting NPC dialogue warmth)
- Simple interaction options with cooldown timers creating return loops
- Bond/affection visible as a numeric level with clear thresholds for unlocking content

### 1.3 Bond Level / Affection Display

- Numeric level prominently displayed per character
- Level caps tied to rarity (3-star: max 20, 4-star: max 30, 5-star: max 100)
- Unlocks at specific thresholds: MomoTalk stories, unique items at level 20 and 25
- Multiple ways to raise: headpats, gifts (with preference system), lessons

**Adaptable pattern for text ADV:**
- Show affection as a clear number or progress bar with labeled thresholds
- Example: 「ひより 好感度: ★★★☆☆ (Lv.3/5) -- 次: Lv.4 で新しい会話解放」
- Different interaction types contribute differently (visiting, choosing kind dialogue options, etc.)

### 1.4 Story Unlock Conditions

- Content unlocks progressively: all content available after Chapter 6 Stage 1
- Each unlock requires clearing specific missions
- Clear requirements shown before attempting: enemy lineup, S-rank conditions (defeat all, time limit, survival)
- Three-star rating system per stage

**Adaptable pattern for text ADV:**
- Show chapter unlock conditions before they're available: 「第3章: 好感度Lv.2 以上で解放」
- Use a simple star/completion rating per chapter (e.g., "all choices seen" / "best ending found")

### 1.5 Daily Tasks / Mission System

- Accessed via notepad icon on upper-left of lobby
- **Daily tab**: Resets every day. Uncompleted tasks lose rewards at reset.
- **Weekly tab**: Resets every Monday. One week leeway.
- **Achievement tab**: One-time milestones giving premium currency
- **Challenge tab**: Specific stage-clearing missions
- Each task has a **shortcut button** that takes the player directly to the relevant screen
- Notification badges (red dots) appear on tabs with completable tasks

**Adaptable pattern for text ADV:**
- Daily/weekly "visit" tasks with streak tracking
- One-time story milestones with visible reward previews
- "Go to" shortcuts from task list to relevant content
- Example text UI:
  ```
  📋 今日のやること
  ✅ 灯に来店する          [完了]
  ⬜ ひよりと会話する       [→ 第2章へ]
  ⬜ 日替わり定食を注文する  [→ カウンターへ]
  ──────────────────
  🎯 達成報酬: 新しい会話シーン解放
  ```

### 1.6 New Teacher Guide Mission (Onboarding)

- Structured as day-by-day progressive tasks
- Each day unlocks new missions even if previous ones are incomplete
- Completing missions earns event items (Arona stamps) and premium currency (1200 Pyroxene)
- Can complete requirements up to 7 days in advance; rewards collected when day unlocks
- Culminates in a character upgrade reward (Nonomi to 3-star)

**Adaptable pattern for text ADV:**
- "First week" guided experience:
  - Day 1: Read prologue
  - Day 2: Visit the shop, meet the cast
  - Day 3: Make your first choice
  - Day 4: Discover a character's preference
  - Day 5-7: Unlock deeper conversations
- Rewards are story content, not currency

---

## 2. Gakuen Idolmaster (学マス): UI Patterns

### 2.1 Design System Philosophy

**Core approach: Flat 2.0 + Glassmorphism**
- Frosted-glass effect with background blur reduces information density
- White borders simulate glass thickness
- Subtle shadows + gradients create depth without visual noise
- Works exceptionally well with 3D backgrounds (or in our case, could work with rich text backgrounds)

**Font: IBM Plex Sans JP (Medium 500)**
- Sharp angles in hiragana for quick visual recognition
- Free, open-source
- Departure from franchise tradition, chosen for functional clarity

**Color strategy:**
- Parameters use CMY colors (blue, pink, yellow) for color-blindness accessibility
- Vivid accent colors only for CTAs (sale badges, tap prompts)
- Each character has distinct image colors with balanced contrast ratios

**Adaptable pattern for text ADV:**
- Use consistent color/emoji coding for game concepts:
  - 💙 = story progression
  - 💛 = affection/bond
  - 🧡 = events/special content
- Use bold/emphasis sparingly and only for actionable items
- Maintain one consistent accent color for "tap here" / "do this next"

### 2.2 Button Design Pattern

Every button has three consistent features:
1. Gradient fill
2. Border stroke with gradient
3. Subtle shadow

**Adaptable pattern for text ADV:**
- Text buttons need consistent visual treatment: `[ ▶ 次へ進む ]` vs `( 戻る )`
- Primary actions visually distinct from secondary ones
- Always the same shape/format so players learn the affordance

### 2.3 Icon-Heavy Navigation

- Home screen and all menus use single-color icons extensively
- Icons reduce text density while maintaining clarity
- Large icon + background color combinations enable intuitive navigation in Produce mode

**Adaptable pattern for text ADV:**
- Use emoji as consistent navigation icons:
  - 🏠 ホーム
  - 📖 ストーリー
  - 💬 会話
  - 📋 やること
  - ❤️ 好感度
- Always pair emoji with text label (never emoji alone)

### 2.4 Produce Mode Structure

- Player selects idol, then guides through weekly schedule
- Each week has lesson slots (Vocal/Dance/Visual) + rest + special events
- Turn-based card game during lessons: 3 cards drawn per turn from deck
- Two plan types (Sense/Logic) change available cards and strategies
- Parameters (Vo/Da/Vi) displayed prominently throughout
- Midterm and final exams serve as checkpoint gates
- Multiple playthroughs required for gradual improvement

**Adaptable pattern for text ADV:**
- Structure as "visit cycles" rather than "chapters you read once":
  - Each visit = one scene at the shop
  - Multiple visits build up affection and unlock deeper content
  - "Exam" equivalent = key story moments that require sufficient relationship level
- Show current stats clearly: 「来店回数: 12 / ひより好感度: Lv.3 / 席の距離: 一つ空け」

### 2.5 初星課題 (Initial Star Challenges) -- Guided Progression

- Acts as both tutorial and progression system
- 40 sequential challenges that naturally teach game mechanics
- Completing them unlocks features (e.g., challenge 40 unlocks "Difficulty PRO")
- Rewards are generous, incentivizing completion
- Natural discovery: "if you just follow the challenges, you'll understand what the game is about"

**Adaptable pattern for text ADV:**
- Equivalent: "灯の常連への道" (Path to becoming a regular)
  - Step 1: 灯に初来店する
  - Step 5: ひよりの名前を知る
  - Step 10: 隣の席に座る
  - Step 15: 連絡先を交換する...
- Each step visible but grayed out until prior step complete
- Completing steps unlocks new interaction types or story branches

### 2.6 Screen Help System

- Every screen has a dedicated help button
- Context-sensitive: help content changes based on which screen you're viewing
- Character-specific tutorials teach plan differences

**Adaptable pattern for text ADV:**
- `[?]` button on every screen explaining what this screen does and what you can do here
- First visit to any screen triggers a one-time tooltip

---

## 3. Common Onboarding Patterns (Cross-Game)

### 3.1 Progressive Disclosure

- Session 1: Core controls only
- Session 2: Power-ups / secondary mechanics
- Session 3: Advanced tactics
- Never frontload everything

**Text ADV application:**
- First visit: Only "read story" and "next" buttons visible
- Second visit: Choices appear
- Third visit: Affection meter becomes visible
- Later: Task list, character profiles, scene replay unlock gradually

### 3.2 Interactive Learning Over Text Walls

- Teach through gameplay, not instruction manuals
- Use animated arrows, highlight glows, hand icons (language-independent)
- Let players discover mechanics by encountering them

**Text ADV application:**
- Don't explain the affection system with a manual
- Instead, after a kind dialogue choice, show: 「💛 ひよりとの距離が少し縮まった」
- Player learns "choices affect affection" through experience

### 3.3 Reward Preview and Curiosity Loops

- Show locked content with "Coming Soon" labels
- Preview rewards before earning them
- Cosmetic rewards for experimentation
- Immediate rewards for completing onboarding steps

**Text ADV application:**
- Show locked chapters with preview text: 「第5章『文庫本』 -- ??? (好感度Lv.3で解放)」
- After completing a chapter, show what's coming: 「次回予告: ひよりが初めて自分から話しかけてくる...？」

### 3.4 Red Dot / Notification Badge System

- Small red dot on buttons indicating available actions
- Three tiers of importance: High (sound + badge), Medium (badge only), Low (subtle indicator)
- Risk of "Red Dot Blindness" from overuse -- must be selective

**Text ADV application:**
- Use sparingly: `📖 ストーリー 🔴` = new content available
- Don't put badges on everything
- One clear "NEW" indicator for the single most important next action

### 3.5 Blocking Irrelevant UI

- Tutorial hides/grays out elements not yet relevant
- Maximizes learnability by reducing cognitive load
- All elements labeled; unlabeled features use established affordances (+ symbol = add more)

**Text ADV application:**
- First playthrough: show only story navigation
- Unlock menu items as player progresses
- Gray out unreachable content with clear unlock conditions

### 3.6 Multisensory Reward Feedback

- Confetti, flashing lights, triumphant sounds on reward acceptance
- Creates positive psychological attachment

**Text ADV application (text-only):**
- Use special formatting for milestone moments:
  ```
  ═══════════════════════
  🎉 第3章クリア！
  ひよりとの距離: 二つ空け → 一つ空け
  💛 好感度 Lv.2 → Lv.3
  🔓 新しい会話シーンが解放されました
  ═══════════════════════
  ```

---

## 4. Progress & Milestone Design Patterns

### 4.1 Progress Bar Types (applicable to text)

| Type | Visual | Use Case |
|------|--------|----------|
| Linear bar | `[████░░░░░░] 40%` | Overall story progress |
| Discrete slots | `★★★☆☆` | Affection levels |
| Checklist | `✅⬜⬜⬜⬜` | Task completion |
| Card collection | `3/10 scenes` | Scene replay / CG collection |

### 4.2 Milestone Communication

- Show current level AND rewards for next level simultaneously
- Display experience remaining until next milestone
- Combine short-term goals (next scene) with long-term goals (complete all chapters)

**Text ADV application:**
```
📊 あなたの進捗
├─ 物語: 第3章 / 全10章 [████████░░░░░░░░░░░░] 30%
├─ ひより好感度: Lv.3 / Lv.5
│   └─ 次のレベルまで: あと2回の会話
├─ 席の距離: 一つ空け → 次: 隣
└─ 今日のやること: 2/3 完了
```

### 4.3 Handling "Endless Progression"

Both games use tiered systems:
- Blue Archive: Bond levels cap at rarity-dependent values (20/30/100)
- 学マス: Each produce run has a clear end (exam), but aggregate progression (P-Level) continues

**Text ADV application:**
- Story has a clear endpoint (10 chapters)
- Within that, optional depth: replay for different choices, bonus conversations
- Post-completion: "after story" or "daily life" mode for continued engagement
- Never leave the player without a visible next goal

---

## 5. Synthesis: Key Principles for Text-Based ADV

### Principle 1: ONE clear next action at all times
Both games ensure the player always knows what to do next. Adapt via:
- Persistent "next step" indicator on home screen
- Task list with the single most important action highlighted

### Principle 2: Show, don't tell
Teach mechanics through experience, not explanation. When affection increases, show it happening. When a new chapter unlocks, celebrate it.

### Principle 3: Progressive unlock of complexity
Start with just "read" and "next." Gradually reveal choices, affection tracking, scene replay, task lists. Never show everything on day one.

### Principle 4: Visible progress with clear thresholds
The player should always see:
- Where they are (current chapter, affection level, visit count)
- Where they're going (next unlock, next chapter preview)
- How to get there (what actions move the needle)

### Principle 5: Return cadence through daily/passive systems
Create reasons to come back: daily conversations, streak bonuses, passive affection growth. The shop metaphor (「灯」) naturally supports this -- a place you visit regularly.

### Principle 6: Emoji as icon system
In a text-only game, emoji serve the role of icons:
- Consistent assignment (💛 always = affection, 📖 always = story)
- Always paired with text labels
- Used sparingly to avoid visual noise

### Principle 7: Celebrate milestones with distinctive formatting
Since there are no animations or sounds, use text formatting (borders, emoji clusters, line breaks) to create "moment" feeling for key achievements.
