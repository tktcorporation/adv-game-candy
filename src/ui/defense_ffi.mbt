// ディフェンスゲーム FFI — requestAnimationFrame + タイマー
//
// MoonBit → JavaScript のブリッジ。
// ゲームループは setInterval(16ms ≈ 60FPS) で実装。
// requestAnimationFrame はブラウザのリフレッシュレートに依存するため、
// ゲームロジックのtick速度を安定させるために setInterval を使う。

///|
/// setInterval で指定ms間隔のコールバックを登録。タイマーIDを返す。
extern "js" fn set_interval_ffi(callback : () -> Unit, ms : Int) -> Int =
  #| (cb, ms) => setInterval(cb, ms)

///|
/// clearInterval でタイマーを停止
extern "js" fn clear_interval_ffi(timer_id : Int) -> Unit =
  #| (id) => clearInterval(id)
