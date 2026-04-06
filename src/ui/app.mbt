// メインUI — 定食屋「灯」に通うADV
//
// カードシステムUI。手札から行動カードを選んでプレイする。
// Title → Story(ch0) → Home → ActionSelect(手札) → Scene → Home のサイクル。
// ヘッダーに3軸パラメータ・季節・天候を表示。

/// 季節に対応するCSSクラス名を返す
fn season_class(state : @game.GameState) -> String {
  let day = state.day.get()
  let season = @data.get_season(day)
  match season {
    Spring => "season-spring"
    Summer => "season-summer"
    Autumn => "season-autumn"
    Winter => "season-winter"
  }
}

/// 天候に対応するCSSクラス名を返す
fn weather_class(state : @game.GameState) -> String {
  let day = state.day.get()
  let weather = @data.get_weather(day)
  match weather {
    Rainy => "weather-rainy"
    Snowy => "weather-snowy"
    _ => ""
  }
}

/// メインアプリコンポーネント
pub fn app(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="app",
    [
      render_header(state),
      @dom.div(
        class="main-content",
        [
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Title },
            fn() { render_title_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Home },
            fn() { render_home_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::ActionSelect },
            fn() { render_action_select_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Scene },
            fn() { render_scene_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Story },
            fn() { render_story_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::Album },
            fn() { render_album_view(state) },
          ),
          @dom.show(
            fn() { state.phase.get() == @data.GamePhase::DayResult },
            fn() { render_day_result_view(state) },
          ),
        ],
      ),
      render_message_log(state),
    ],
  )
}

// =========================================================================
// ヘッダー
// =========================================================================

/// ヘッダー — ステータス表示
///
/// Title フェーズ以外で表示。3軸パラメータ・季節・天候・AP を常時表示。
fn render_header(state : @game.GameState) -> @dom.DomNode {
  @dom.header_(
    class="game-header",
    [
      @dom.div(
        class="header-title",
        [
          @dom.h1(class="title", [@dom.text("灯")]),
          // 季節・天候・日数
          @dom.span(
            class="subtitle",
            [@dom.text_dyn(fn() {
              let day = state.day.get()
              let season = @data.get_season(day)
              let weather = @data.get_weather(day)
              let day_in_season = @data.get_day_in_season(day)
              let s = @data.season_to_string(season) + " " + day_in_season.to_string() + "日目 " + @data.weather_to_icon(weather)
              s
            })],
          ),
        ],
      ),
      // ♡親密度Lv + AP（簡素化: 3軸数値はHome画面に移動）
      @dom.div(
        class="header-stats",
        [
          @dom.span(
            class="stat stat-affection",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              "♡Lv" + level.to_string()
            })],
          ),
          @dom.span(
            class="stat stat-ap",
            [@dom.text_dyn(fn() {
              "AP " + state.ap.get().to_string() + "/" + @game.get_max_ap(state).to_string()
            })],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// Title ビュー
// =========================================================================

/// タイトル画面 — 初回起動時のみ表示
fn render_title_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="title-view",
    [
      @dom.div(
        class="title-logo",
        [@dom.text("灯")],
      ),
      @dom.div(
        class="title-tagline",
        [@dom.text("定食屋の片隅で、少しずつ近づく二人の物語")],
      ),
      @dom.button(
        class="btn btn-primary btn-large",
        on=@dom.events().click(fn(_e) { @game.start_game(state) }),
        [@dom.text("はじめる")],
      ),
      @dom.div(
        class="title-hint",
        [@dom.text("タップして物語を始める")],
      ),
    ],
  )
}

// =========================================================================
// Home ビュー
// =========================================================================

/// ホーム画面 — 親密度・目標・日替わり・アクション・ミッション
///
/// 情報階層: ♡親密度+関係性テキスト → 次の目標 → 日替わり → アクション → ミッション → ステータス
/// 学マス参考: 目標の常時表示。ブルアカ参考: ♡+数字のシンプルさ。
fn render_home_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="home-view",
    [
      // ♡ 親密度 + 関係性テキスト（画面上部に大きく）
      @dom.div(
        class="affection-display",
        [
          @dom.div(
            class="affection-level",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              let next_pts = @game.affection_points_for_level(level + 1)
              let current_pts = state.intimacy.get()
              "♡ 親密度 Lv" + level.to_string() + " (" + current_pts.to_string() + "/" + next_pts.to_string() + ")"
            })],
          ),
          @dom.div(
            class="affection-desc",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              @data.get_affection_description(level)
            })],
          ),
        ],
      ),
      // 次の目標セクション（学マス風: 常に目標が見える）
      @dom.div(
        class="next-goal",
        [
          @dom.div(
            class="next-goal-header",
            [@dom.text("次の目標")],
          ),
          @dom.div(
            class="next-goal-content",
            [@dom.text_dyn(fn() {
              let current_ch = state.current_chapter.get()
              let chapters = @data.get_chapters()
              let player_lv = state.player_level.get()
              let exp = state.player_exp.get()
              if current_ch + 1 < chapters.length() {
                let next = chapters[current_ch + 1]
                let needed_lv = next.unlock_player_level
                let chapter_label = next.title + " 「" + next.subtitle + "」"
                if player_lv >= needed_lv {
                  "📖 " + chapter_label + " — 読めます！"
                } else {
                  let exp_to_next = @game.exp_for_next_level(player_lv) - exp
                  "📖 " + chapter_label + " — PLv" + needed_lv.to_string() + " (EXP あと" + exp_to_next.to_string() + ")"
                }
              } else {
                "📖 全章クリア済み"
              }
            })],
          ),
          // PLv進捗 — CSSプログレスバー + テキストラベル
          @dom.div(
            class="plv-progress",
            [
              @dom.span(
                class="plv-label",
                [@dom.text_dyn(fn() {
                  let player_lv = state.player_level.get()
                  let exp = state.player_exp.get()
                  let needed = @game.exp_for_next_level(player_lv)
                  "PLv" + player_lv.to_string() + "  " + exp.to_string() + "/" + needed.to_string()
                })],
              ),
              @dom.div(
                class="progress-track",
                [
                  @dom.div(
                    class="progress-fill",
                    dyn_style=fn() {
                      let exp = state.player_exp.get()
                      let needed = @game.exp_for_next_level(state.player_level.get())
                      let pct = if needed > 0 { exp * 100 / needed } else { 100 }
                      "width:" + pct.to_string() + "%"
                    },
                    [],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      // 今日の日替わり
      @dom.div(
        class="daily-menu-card",
        [
          @dom.div(
            class="menu-label",
            [@dom.text("🍽 今日の日替わり")],
          ),
          @dom.div(
            class="menu-name",
            [@dom.text_dyn(fn() {
              let menu = @data.get_today_menu(state.day.get())
              menu.name
            })],
          ),
          @dom.div(
            class="menu-desc",
            [@dom.text_dyn(fn() {
              let menu = @data.get_today_menu(state.day.get())
              menu.description
            })],
          ),
        ],
      ),
      // メインアクションボタン
      @dom.div(
        class="home-actions",
        [
          @dom.show(
            fn() { state.ap.get() > 0 },
            fn() {
              @dom.button(
                class="btn btn-primary btn-large",
                on=@dom.events().click(fn(_e) { @game.go_to_akari(state) }),
                [@dom.text("🍽 灯に行く")],
              )
            },
          ),
          @dom.show(
            fn() { state.ap.get() == 0 },
            fn() {
              @dom.button(
                class="btn btn-primary btn-large",
                on=@dom.events().click(fn(_e) { @game.next_day(state) }),
                [@dom.text("次の日へ")],
              )
            },
          ),
        ],
      ),
      // AP ゲージ
      @dom.div(
        class="ap-gauge",
        [@dom.text_dyn(fn() {
          let ap = state.ap.get()
          let max_ap = @game.get_max_ap(state)
          let mut dots = ""
          for i in 0..<max_ap {
            if i < ap {
              dots = dots + "●"
            } else {
              dots = dots + "○"
            }
          }
          "AP " + dots + " (" + ap.to_string() + "/" + max_ap.to_string() + ")"
        })],
      ),
      // AP が残っていても次の日へ行けるボタン
      @dom.show(
        fn() { state.ap.get() > 0 && state.ap.get() < @game.get_max_ap(state) },
        fn() {
          @dom.div(
            class="home-secondary-actions",
            [
              @dom.button(
                class="btn btn-secondary btn-small",
                on=@dom.events().click(fn(_e) { @game.next_day(state) }),
                [@dom.text("次の日へ")],
              ),
            ],
          )
        },
      ),
      // デイリーミッション
      @dom.div(
        class="daily-missions",
        [
          @dom.div(
            class="missions-header",
            [@dom.text("デイリー")],
          ),
          @dom.for_each(
            fn() { state.daily_missions.get() },
            fn(mission, _i) {
              @dom.div(
                class="mission-item",
                [
                  @dom.div(
                    class="mission-status",
                    [@dom.text(if mission.completed { "✓" } else { "○" })],
                  ),
                  @dom.div(
                    class="mission-desc",
                    [@dom.text(mission.description)],
                  ),
                  @dom.div(
                    class="mission-reward",
                    [@dom.text("+" + mission.reward.to_string())],
                  ),
                ],
              )
            },
          ),
        ],
      ),
      // ステータス（3軸 + 通貨）— 下部に補助的に表示
      @dom.div(
        class="home-status",
        [
          @dom.div(
            class="param-summary",
            [@dom.text_dyn(fn() {
              "信頼 " + state.trust.get().to_string() +
              " ▸ 理解 " + state.understanding.get().to_string() +
              " ▸ 共感 " + state.empathy.get().to_string()
            })],
          ),
          @dom.div(
            class="currency-badges",
            [
              @dom.span(
                class="currency-badge",
                [@dom.text_dyn(fn() {
                  "🪙 " + state.coins.get().to_string()
                })],
              ),
              @dom.span(
                class="currency-badge",
                [@dom.text_dyn(fn() {
                  "💎 " + state.gems.get().to_string()
                })],
              ),
            ],
          ),
        ],
      ),
      // フッターボタン
      @dom.div(
        class="home-footer",
        [
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) { @game.open_album(state) }),
            [@dom.text("アルバム")],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// ActionSelect ビュー — 手札カードUI
// =========================================================================

/// 行動選択画面 — 手札からカードを選んでプレイ
fn render_action_select_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="action-select-view",
    [
      @dom.div(
        class="action-header",
        [@dom.text_dyn(fn() {
          let day = state.day.get()
          let weather = @data.get_weather(day)
          let weather_text = @data.weather_to_string(weather)
          "灯の中。" + weather_text + "の昼時。"
        })],
      ),
      // AP ゲージ
      @dom.div(
        class="ap-gauge",
        [@dom.text_dyn(fn() {
          let ap = state.ap.get()
          let mut dots = ""
          for i in 0..<@game.base_ap {
            if i < ap {
              dots = dots + "●"
            } else {
              dots = dots + "○"
            }
          }
          "AP " + dots
        })],
      ),
      // 手札カード一覧
      @dom.div(
        class="hand-cards",
        [
          @dom.for_each(
            fn() { state.hand.get() },
            fn(card, _i) { render_hand_card(state, card) },
          ),
          // 手札が空のとき
          @dom.show(
            fn() { state.hand.get().length() == 0 },
            fn() {
              @dom.div(
                class="hand-empty",
                [@dom.text("今日の手札はすべて使いました。")],
              )
            },
          ),
        ],
      ),
      // 帰るボタン
      @dom.div(
        class="action-footer",
        [
          @dom.button(
            class="btn btn-secondary",
            on=@dom.events().click(fn(_e) { @game.leave_akari(state) }),
            [@dom.text("帰る")],
          ),
        ],
      ),
    ],
  )
}

/// 手札カード — 1枚分のUI
///
/// カード名・説明・APコスト・実効パラメータ値・♡合計を表示。
/// 実効値は preview_card_gains() で計算（★ランク・レベル・メモリーボーナス反映済み）。
/// APが足りない場合はdisabled表示。レアリティでボーダー色を変える。
fn render_hand_card(
  state : @game.GameState,
  card : @data.ActionCard
) -> @dom.DomNode {
  let card_id = card.id
  let can_play = state.ap.get() >= card.ap_cost
  let rarity_class = match card.rarity {
    Normal => "rarity-normal"
    Uncommon => "rarity-uncommon"
    Rare => "rarity-rare"
  }
  let base_class = if can_play {
    "hand-card " + rarity_class
  } else {
    "hand-card disabled " + rarity_class
  }
  // 実効値を計算（base値ではなくスケーリング後の値）
  let (eff_t, eff_u, eff_e) = @game.preview_card_gains(state, card)
  let total_gain = eff_t + eff_u + eff_e
  @dom.div(
    class="hand-card-wrapper",
    [
      if can_play {
        @dom.button(
          class=base_class,
          on=@dom.events().click(fn(_e) { @game.play_card(state, card_id) }),
          [
            // カードヘッダー: 名前 + APコスト
            @dom.div(
              class="card-header",
              [
                @dom.span(class="card-name", [@dom.text(card.name)]),
                @dom.span(
                  class="card-cost",
                  [@dom.text(card.ap_cost.to_string() + " AP")],
                ),
              ],
            ),
            // カード説明
            @dom.div(
              class="card-desc",
              [@dom.text(card.description)],
            ),
            // 3軸パラメータ（実効値）
            @dom.div(
              class="card-params",
              [
                @dom.show(
                  fn() { eff_t > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-trust",
                      [@dom.text("信+" + eff_t.to_string())],
                    )
                  },
                ),
                @dom.show(
                  fn() { eff_u > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-understanding",
                      [@dom.text("理+" + eff_u.to_string())],
                    )
                  },
                ),
                @dom.show(
                  fn() { eff_e > 0 },
                  fn() {
                    @dom.span(
                      class="card-param param-empathy",
                      [@dom.text("共+" + eff_e.to_string())],
                    )
                  },
                ),
              ],
            ),
            // ♡合計寄与（親密度にどれだけ進むか一目で分かる）
            @dom.div(
              class="card-affection-total",
              [@dom.text("♡+" + total_gain.to_string())],
            ),
          ],
        )
      } else {
        @dom.div(
          class=base_class,
          [
            @dom.div(
              class="card-header",
              [
                @dom.span(class="card-name", [@dom.text(card.name)]),
                @dom.span(
                  class="card-cost",
                  [@dom.text(card.ap_cost.to_string() + " AP")],
                ),
              ],
            ),
            @dom.div(
              class="card-desc",
              [@dom.text(card.description)],
            ),
            @dom.div(
              class="card-params",
              [
                @dom.span(
                  class="card-param",
                  [@dom.text("AP不足")],
                ),
              ],
            ),
          ],
        )
      },
    ],
  )
}

// =========================================================================
// Scene ビュー
// =========================================================================

/// Scene ビュー — 行動結果のテキスト + 獲得値 + リアクション表示
///
/// 学マス参考: カード使用後に「何が得られたか」を明示。
/// シーンテキスト → 結果（パラメータ・通貨） → リアクション → ボタン の順。
fn render_scene_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="scene-view",
    [
      // メニュー名
      @dom.div(
        class="scene-menu",
        [@dom.text_dyn(fn() { state.today_menu.get() })],
      ),
      // シーンテキスト
      @dom.div(
        class="scene-text",
        [@dom.text_dyn(fn() { state.today_scene_text.get() })],
      ),
      // 結果セクション（獲得値・報酬・リアクション）
      @dom.div(
        class="scene-result",
        [
          @dom.div(
            class="scene-result-header",
            [@dom.text("結 果")],
          ),
          // パラメータ獲得値 + ♡合計
          @dom.div(
            class="scene-gains",
            [@dom.text_dyn(fn() {
              let r = state.last_card_result.get()
              let mut s = ""
              if r.trust_gain > 0 {
                s = s + "信頼 +" + r.trust_gain.to_string() + "  "
              }
              if r.understanding_gain > 0 {
                s = s + "理解 +" + r.understanding_gain.to_string() + "  "
              }
              if r.empathy_gain > 0 {
                s = s + "共感 +" + r.empathy_gain.to_string() + "  "
              }
              let total = r.trust_gain + r.understanding_gain + r.empathy_gain
              s = s + "♡ +" + total.to_string()
              s
            })],
          ),
          // 通貨・EXP報酬
          @dom.div(
            class="scene-rewards",
            [@dom.text_dyn(fn() {
              let r = state.last_card_result.get()
              let mut s = "+" + r.coin_reward.to_string() + " コイン  +" + r.exp_reward.to_string() + " EXP"
              if r.gem_reward > 0 {
                s = s + "  +" + r.gem_reward.to_string() + " 星石"
              }
              s
            })],
          ),
          // ひよりのリアクション
          @dom.show(
            fn() { state.last_card_result.get().reaction_text != "" },
            fn() {
              @dom.div(
                class="scene-reaction",
                [@dom.text_dyn(fn() {
                  "♪ " + state.last_card_result.get().reaction_text
                })],
              )
            },
          ),
        ],
      ),
      // ボタン
      @dom.div(
        class="scene-actions",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) { @game.finish_scene(state) }),
            [@dom.text_dyn(fn() {
              // 次の章が解放可能かチェック
              let current = state.current_chapter.get()
              let chapters = @data.get_chapters()
              if current + 1 < chapters.length() {
                let next = chapters[current + 1]
                if state.player_level.get() >= next.unlock_player_level {
                  "ストーリーが解放されました"
                } else {
                  "ごちそうさまでした"
                }
              } else {
                "ごちそうさまでした"
              }
            })],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// Story ビュー
// =========================================================================

/// Story ビュー — ADV形式のテキスト表示
fn render_story_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="story-view",
    [
      // 章タイトル
      @dom.div(
        class="chapter-header",
        [@dom.text_dyn(fn() {
          match @game.get_current_chapter(state) {
            Some(ch) => ch.title + " 「" + ch.subtitle + "」"
            None => ""
          }
        })],
      ),
      // テキスト表示エリア
      @dom.div(
        class="story-text-area",
        [
          // 話者名
          @dom.div(
            class="speaker-name",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.speaker
                None => ""
              }
            })],
          ),
          // テキスト本文
          @dom.div(
            class="story-text",
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(line) => line.text
                None => ""
              }
            })],
          ),
        ],
      ),
      // 進行ボタン
      @dom.div(
        class="story-controls",
        [
          @dom.button(
            class="btn btn-primary",
            on=@dom.events().click(fn(_e) { @game.advance_story(state) }),
            [@dom.text_dyn(fn() {
              match @game.get_current_line(state) {
                Some(_) => "▼"
                None => "次へ"
              }
            })],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// Album ビュー
// =========================================================================

/// アルバム画面 — 味の記憶・発見ノート・会話メモ・ストーリー回想
fn render_album_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-view",
    [
      // ヘッダー
      @dom.div(
        class="album-header",
        [
          @dom.h2(class="section-title", [@dom.text("アルバム")]),
          @dom.button(
            class="btn btn-close",
            on=@dom.events().click(fn(_e) { @game.close_album(state) }),
            [@dom.text("×")],
          ),
        ],
      ),
      // タブ
      @dom.div(
        class="album-tabs",
        [
          render_album_tab(state, 0, "味の記憶"),
          render_album_tab(state, 1, "発見ノート"),
          render_album_tab(state, 2, "会話メモ"),
          render_album_tab(state, 3, "ストーリー"),
          render_album_tab(state, 4, "思い出"),
        ],
      ),
      // タブコンテンツ
      // Tab 0: 味の記憶
      @dom.show(
        fn() { state.album_tab.get() == 0 },
        fn() { render_album_visits(state) },
      ),
      // Tab 1: 発見ノート
      @dom.show(
        fn() { state.album_tab.get() == 1 },
        fn() { render_album_discoveries(state) },
      ),
      // Tab 2: 会話メモ
      @dom.show(
        fn() { state.album_tab.get() == 2 },
        fn() { render_album_talks(state) },
      ),
      // Tab 3: ストーリー回想
      @dom.show(
        fn() { state.album_tab.get() == 3 },
        fn() { render_album_stories(state) },
      ),
      // Tab 4: 思い出コレクション
      @dom.show(
        fn() { state.album_tab.get() == 4 },
        fn() { render_album_memories(state) },
      ),
    ],
  )
}

/// アルバムタブボタン — アクティブ状態をCSSクラスで表現
fn render_album_tab(
  state : @game.GameState,
  tab_index : Int,
  label : String
) -> @dom.DomNode {
  @dom.button(
    dyn_class=fn() {
      if state.album_tab.get() == tab_index {
        "album-tab active"
      } else {
        "album-tab"
      }
    },
    on=@dom.events().click(fn(_e) { state.album_tab.set(tab_index) }),
    [@dom.text(label)],
  )
}

/// アルバム: 味の記憶（訪問記録）
fn render_album_visits(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      // メニュー制覇状況
      @dom.div(
        class="menu-collection",
        [@dom.text_dyn(fn() {
          let all_menus = @data.get_daily_menus()
          let log = state.visit_log.get()
          let mut unique_count = 0
          for menu in all_menus {
            let mut found = false
            for record in log {
              if record.menu_id == menu.id {
                found = true
                break
              }
            }
            if found {
              unique_count = unique_count + 1
            }
          }
          "制覇: " +
          unique_count.to_string() +
          " / " +
          all_menus.length().to_string() +
          " メニュー"
        })],
      ),
      // 訪問記録リスト
      @dom.div(
        class="visit-log",
        [
          @dom.for_each(
            fn() { state.visit_log.get() },
            fn(record, _i) {
              let menus = @data.get_daily_menus()
              let mut menu_name = record.menu_id
              for m in menus {
                if m.id == record.menu_id {
                  menu_name = m.name
                  break
                }
              }
              @dom.div(
                class="visit-entry",
                [
                  @dom.div(
                    class="visit-day",
                    [@dom.text(record.day.to_string() + "日目")],
                  ),
                  @dom.div(
                    class="visit-menu",
                    [@dom.text(menu_name)],
                  ),
                  @dom.div(
                    class="visit-scene",
                    [@dom.text(record.scene_text)],
                  ),
                ],
              )
            },
          ),
        ],
      ),
    ],
  )
}

/// アルバム: 発見ノート
fn render_album_discoveries(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      @dom.for_each(
        fn() { state.discoveries.get() },
        fn(discovery, _i) {
          @dom.div(
            class="album-entry",
            [@dom.text(discovery)],
          )
        },
      ),
      @dom.show(
        fn() { state.discoveries.get().length() == 0 },
        fn() {
          @dom.div(
            class="album-empty",
            [@dom.text("まだ何も発見していない。灯で観察してみよう。")],
          )
        },
      ),
    ],
  )
}

/// アルバム: 会話メモ
fn render_album_talks(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      @dom.for_each(
        fn() { state.talk_memos.get() },
        fn(memo, _i) {
          @dom.div(
            class="album-entry",
            [@dom.text(memo)],
          )
        },
      ),
      @dom.show(
        fn() { state.talk_memos.get().length() == 0 },
        fn() {
          @dom.div(
            class="album-empty",
            [@dom.text("まだ丸山と話していない。灯で話しかけてみよう。")],
          )
        },
      ),
    ],
  )
}

/// アルバム: ストーリー回想
fn render_album_stories(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content",
    [
      @dom.div(
        class="album-story-list",
        [@dom.text_dyn(fn() {
          let chapters = @data.get_chapters()
          let current = state.current_chapter.get()
          let mut result = ""
          for i, ch in chapters {
            if i <= current {
              result = result + "✓ " + ch.title + " 「" + ch.subtitle + "」\n"
            } else {
              result = result + "？ " + ch.title + "\n"
            }
          }
          result
        })],
      ),
    ],
  )
}

// =========================================================================
// アルバム: 思い出コレクション
// =========================================================================

/// アルバム: 思い出コレクション
///
/// 全思い出の一覧。獲得済みはタイトルと説明、未獲得はヒントを表示。
/// 装備状態も表示。
fn render_album_memories(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="album-content album-memories",
    [
      // 獲得数
      @dom.div(
        class="memory-count",
        [@dom.text_dyn(fn() {
          let all = @data.get_all_memories()
          let acquired = state.acquired_memories.get()
          acquired.length().to_string() + " / " + all.length().to_string() + " 獲得"
        })],
      ),
      // 思い出一覧
      @dom.div(
        class="memory-list",
        [@dom.text_dyn(fn() {
          let all = @data.get_all_memories()
          let acquired = state.acquired_memories.get()
          let mut result = ""
          for memory in all {
            let mut is_acquired = false
            for record in acquired {
              if record.memory_id == memory.id {
                is_acquired = true
                break
              }
            }
            if is_acquired {
              result = result + "✦ " + memory.title + "\n"
              result = result + "  " + memory.description + "\n"
              let bonus_text = "  [+" + memory.trust_bonus.to_string() + "信 +" + memory.understanding_bonus.to_string() + "理 +" + memory.empathy_bonus.to_string() + "共]\n\n"
              result = result + bonus_text
            } else {
              result = result + "？ ???\n"
              result = result + "  ヒント: " + memory.hint + "\n\n"
            }
          }
          result
        })],
      ),
    ],
  )
}

// =========================================================================
// DayResult ビュー — 1日の成果まとめ
// =========================================================================

/// DayResult画面 — 1日の記録と明日の目標を表示
///
/// build_day_result() が生成した DayResultData を表示する。
/// 「次の日へ」ボタンで advance_to_next_day() を呼び、翌日へ遷移する。
///
/// 設計意図: ブルアカのステージクリア画面を参考に、
/// プレイヤーが「今日何をして何を得たか」を振り返れるようにする。
fn render_day_result_view(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="day-result-view",
    [
      // タイトル
      @dom.div(
        class="day-result-title",
        [@dom.text_dyn(fn() {
          "── " + state.day.get().to_string() + "日目の記録 ──"
        })],
      ),
      // 行動回数
      @dom.div(
        class="day-result-actions",
        [@dom.text_dyn(fn() {
          "今日の行動: " + state.day_result.get().cards_played.to_string() + "回"
        })],
      ),
      // パラメータ変化
      @dom.div(
        class="day-result-gains",
        [@dom.text_dyn(fn() {
          let r = state.day_result.get()
          let mut s = ""
          if r.trust_gained > 0 {
            s = s + "信頼 +" + r.trust_gained.to_string() + "  "
          }
          if r.understanding_gained > 0 {
            s = s + "理解 +" + r.understanding_gained.to_string() + "  "
          }
          if r.empathy_gained > 0 {
            s = s + "共感 +" + r.empathy_gained.to_string() + "  "
          }
          let total = r.trust_gained + r.understanding_gained + r.empathy_gained
          if total > 0 {
            s = s + "♡ +" + total.to_string()
          }
          s
        })],
      ),
      // 親密度レベルアップ
      @dom.show(
        fn() { state.day_result.get().affection_level_up },
        fn() {
          @dom.div(
            class="day-result-levelup",
            [@dom.text_dyn(fn() {
              let r = state.day_result.get()
              "♡ 親密度 → Lv" + r.new_affection_level.to_string() + " UP!"
            })],
          )
        },
      ),
      // プレイヤーレベルアップ
      @dom.show(
        fn() {
          // PLv変化があった場合（day_start_affection_levelの類似パターンで検出）
          state.day_result.get().new_player_level > 1
        },
        fn() {
          @dom.div(
            class="day-result-plv",
            [@dom.text_dyn(fn() {
              "PLv " + state.day_result.get().new_player_level.to_string()
            })],
          )
        },
      ),
      // 通貨獲得
      @dom.div(
        class="day-result-currency",
        [@dom.text_dyn(fn() {
          let r = state.day_result.get()
          let mut s = "コイン +" + r.coins_earned.to_string()
          if r.gems_earned > 0 {
            s = s + "  星石 +" + r.gems_earned.to_string()
          }
          if r.passive_coins > 0 {
            s = s + "  (パッシブ +" + r.passive_coins.to_string() + ")"
          }
          s
        })],
      ),
      // 明日の目標
      @dom.div(
        class="day-result-next",
        [
          @dom.div(
            class="day-result-next-header",
            [@dom.text("明日の目標")],
          ),
          @dom.div(
            class="day-result-next-story",
            [@dom.text_dyn(fn() {
              let current_ch = state.current_chapter.get()
              let chapters = @data.get_chapters()
              let player_lv = state.player_level.get()
              let exp = state.player_exp.get()
              if current_ch + 1 < chapters.length() {
                let next = chapters[current_ch + 1]
                let needed_lv = next.unlock_player_level
                if player_lv >= needed_lv {
                  "📖 次の章が読めます！"
                } else {
                  let exp_to_next = @game.exp_for_next_level(player_lv) - exp
                  "📖 " + next.title + "まで: PLv" + needed_lv.to_string() + " (EXP あと" + exp_to_next.to_string() + ")"
                }
              } else {
                "📖 全章クリア済み"
              }
            })],
          ),
          @dom.div(
            class="day-result-next-affection",
            [@dom.text_dyn(fn() {
              let level = @game.get_affection_level(state.intimacy.get())
              let milestones = @data.get_affection_milestones()
              let mut next_milestone = 0
              for m in milestones {
                if m.level > level {
                  next_milestone = m.level
                  break
                }
              }
              if next_milestone > 0 {
                "♡ 次のマイルストーン: Lv" + next_milestone.to_string()
              } else {
                ""
              }
            })],
          ),
        ],
      ),
      // ボタン
      @dom.div(
        class="day-result-btn",
        [
          @dom.button(
            class="btn btn-primary btn-large",
            on=@dom.events().click(fn(_e) { @game.advance_to_next_day(state) }),
            [@dom.text("次の日へ")],
          ),
        ],
      ),
    ],
  )
}

// =========================================================================
// メッセージログ
// =========================================================================

/// メッセージログ
fn render_message_log(state : @game.GameState) -> @dom.DomNode {
  @dom.div(
    class="message-log",
    [
      @dom.for_each(
        fn() { state.message_log.get() },
        fn(msg, _i) {
          @dom.div(class="message-entry", [@dom.text(msg)])
        },
      ),
    ],
  )
}
