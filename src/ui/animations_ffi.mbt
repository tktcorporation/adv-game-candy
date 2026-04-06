// animations_ffi.mbt — anime.js / SVG ヘルパーへの FFI ブリッジ
//
// animations.js で定義したグローバル関数を MoonBit から呼び出す。
// anime.js v4 による Duolingo 風マイクロインタラクション:
// - カードプレイ演出（拡大→スライドアウト）
// - パラメータバウンス（弾むカウントアップ）
// - 思い出獲得スパークル（金色フラッシュ）
// - 手札配り演出（スタガー登場）
// - 季節装飾パーティクル（桜・紅葉・雪の結晶）

///|
/// カードプレイ時のスライドアウトアニメーション
extern "js" fn animate_card_play_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateCardPlay) globalThis.animateCardPlay(s) }

///|
/// パラメータ上昇時のバウンスアニメーション
extern "js" fn animate_param_bounce_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateParamBounce) globalThis.animateParamBounce(s) }

///|
/// 思い出獲得時の金色フラッシュアニメーション
extern "js" fn animate_memory_acquire_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateMemoryAcquire) globalThis.animateMemoryAcquire(s) }

///|
/// ランク判定（S/A/B/C）の飛び込みアニメーション
extern "js" fn animate_rank_reveal_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateRankReveal) globalThis.animateRankReveal(s) }

///|
/// ストーリー解放時のキラキラ演出
extern "js" fn animate_story_unlock_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateStoryUnlock) globalThis.animateStoryUnlock(s) }

///|
/// 手札カードのスタガー配り演出
extern "js" fn animate_hand_deal_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateHandDeal) globalThis.animateHandDeal(s) }

///|
/// タイトルロゴの弾性出現アニメーション
extern "js" fn animate_title_logo_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateTitleLogo) globalThis.animateTitleLogo(s) }

///|
/// 日替わりメニューカードの登場演出
extern "js" fn animate_menu_reveal_ffi(selector : String) -> Unit =
  #| (s) => { if(globalThis.animateMenuReveal) globalThis.animateMenuReveal(s) }

///|
/// 季節の装飾パーティクル（桜/紅葉/雪の結晶）をbodyに追加
extern "js" fn add_seasonal_decoration_ffi(season : String) -> Unit =
  #| (s) => { if(globalThis.addSeasonalDecoration) globalThis.addSeasonalDecoration(s) }

///|
/// SVG: 湯気を文字列で生成
extern "js" fn create_steam_svg_ffi(size : Int) -> String =
  #| (n) => (globalThis.createSteamSvg || (() => ''))(n)

///|
/// SVG: 暖簾を文字列で生成
extern "js" fn create_noren_svg_ffi(size : Int) -> String =
  #| (n) => (globalThis.createNorenSvg || (() => ''))(n)
