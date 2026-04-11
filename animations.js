// animations.js — anime.js ヘルパー + SVG イラスト生成
//
// MoonBit FFI (extern "js") から呼ばれるグローバル関数群。
// anime.js v4 の API を使用して Duolingo 風のマイクロインタラクションを実装。
// SVG はテンプレートリテラルで定食屋の世界観に合うモチーフを生成。
//
// セキュリティ: SVG はすべてハードコードされた静的文字列のため、
// ユーザー入力は一切含まれない。XSS リスクなし。

// =========================================================================
// anime.js ラッパー — MoonBit から呼べるグローバル関数
// =========================================================================

/**
 * カードプレイ時の飛び出し→消失アニメーション
 * カードが拡大→上にスライドして消える
 */
window.animateCardPlay = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    scale: [1, 1.05, 0.9],
    opacity: [1, 1, 0],
    translateY: [0, -8, -60],
    duration: 500,
    easing: 'easeInOutQuad',
  });
};

/**
 * パラメータ上昇時のカウントアップ + バウンスアニメーション
 * 数値が弾むように大きくなって元に戻る
 */
window.animateParamBounce = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    scale: [1, 1.3, 1],
    duration: 400,
    easing: 'easeOutElastic(1, .6)',
  });
};

/**
 * 思い出獲得時のスパークルエフェクト
 * ゴールドの光が放射状に広がる
 */
window.animateMemoryAcquire = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    backgroundColor: ['rgba(245, 158, 11, 0.15)', 'rgba(245, 158, 11, 0)'],
    scale: [0.95, 1],
    duration: 600,
    easing: 'easeOutQuad',
  });
};

/**
 * ランク判定の大文字が飛び込むアニメーション (S/A/B/C)
 */
window.animateRankReveal = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    scale: [3, 1],
    opacity: [0, 1],
    rotate: [15, 0],
    duration: 800,
    easing: 'easeOutElastic(1, .5)',
  });
};

/**
 * ストーリー解放時のキラキラエフェクト
 */
window.animateStoryUnlock = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    borderColor: ['var(--accent)', 'var(--rarity-rare)', 'var(--accent)'],
    boxShadow: [
      '0 0 0px rgba(245, 158, 11, 0)',
      '0 0 20px rgba(245, 158, 11, 0.4)',
      '0 0 0px rgba(245, 158, 11, 0)'
    ],
    duration: 1200,
    easing: 'easeInOutSine',
  });
};

/**
 * 手札カードのスタガー配り演出
 * anime.js の stagger を使って時差付きで出現
 */
window.animateHandDeal = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    translateY: [60, 0],
    opacity: [0, 1],
    scale: [0.85, 1],
    delay: function(_el, i) { return i * 100; },
    duration: 500,
    easing: 'easeOutBack',
  });
};

/**
 * タイトル画面のロゴアニメーション
 */
window.animateTitleLogo = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    opacity: [0, 1],
    scale: [0.5, 1],
    translateY: [30, 0],
    duration: 1200,
    easing: 'easeOutElastic(1, .6)',
  });
};

/**
 * ボタンのタップフィードバック
 */
window.animateButtonPress = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    scale: [1, 0.92, 1],
    duration: 250,
    easing: 'easeOutQuad',
  });
};

/**
 * ミッション達成のチェックマークアニメーション
 */
window.animateMissionComplete = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    scale: [0, 1.2, 1],
    rotate: [0, 360],
    duration: 600,
    easing: 'easeOutBack',
  });
};

/**
 * 日替わりメニューカードの登場
 */
window.animateMenuReveal = function(selector) {
  if (typeof anime === 'undefined') return;
  anime({
    targets: selector,
    opacity: [0, 1],
    translateY: [20, 0],
    rotateX: [15, 0],
    duration: 600,
    easing: 'easeOutQuad',
  });
};

// =========================================================================
// SVG イラスト生成 — 定食屋「灯」の世界観モチーフ
//
// すべてのSVGはハードコードされた静的文字列で、ユーザー入力は含まない。
// DOM挿入は createElementNS + DOM API を使い、innerHTML は使わない。
// =========================================================================

/**
 * SVG文字列からDOM要素を安全に作成するヘルパー
 * DOMParser を使って安全にパース
 */
function parseSvgString(svgString) {
  var parser = new DOMParser();
  var doc = parser.parseFromString(svgString, 'image/svg+xml');
  return doc.documentElement;
}

/**
 * 湯気SVG — 食事シーンの温かみを表現
 * path にアニメーションを内包し、ゆらゆら揺れる
 */
window.createSteamSvg = function(size) {
  size = size || 48;
  return '<svg viewBox="0 0 40 60" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<path d="M12 55 Q8 40 14 28 Q20 16 14 5" fill="none" stroke="rgba(200,190,180,0.4)" stroke-width="2.5" stroke-linecap="round">' +
      '<animate attributeName="d" values="M12 55 Q8 40 14 28 Q20 16 14 5;M12 55 Q16 40 10 28 Q4 16 14 5;M12 55 Q8 40 14 28 Q20 16 14 5" dur="3s" repeatCount="indefinite"/>' +
    '</path>' +
    '<path d="M22 55 Q18 42 22 32 Q26 22 20 8" fill="none" stroke="rgba(200,190,180,0.3)" stroke-width="2" stroke-linecap="round">' +
      '<animate attributeName="d" values="M22 55 Q18 42 22 32 Q26 22 20 8;M22 55 Q26 42 20 32 Q14 22 20 8;M22 55 Q18 42 22 32 Q26 22 20 8" dur="3.5s" repeatCount="indefinite"/>' +
    '</path>' +
    '<path d="M30 55 Q26 44 30 35 Q34 26 28 12" fill="none" stroke="rgba(200,190,180,0.25)" stroke-width="1.5" stroke-linecap="round">' +
      '<animate attributeName="d" values="M30 55 Q26 44 30 35 Q34 26 28 12;M30 55 Q34 44 28 35 Q22 26 28 12;M30 55 Q26 44 30 35 Q34 26 28 12" dur="4s" repeatCount="indefinite"/>' +
    '</path>' +
  '</svg>';
};

/**
 * 箸SVG — 定食屋のシンボル
 */
window.createChopsticksSvg = function(size) {
  size = size || 40;
  return '<svg viewBox="0 0 40 50" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<line x1="12" y1="5" x2="18" y2="48" stroke="#8B6914" stroke-width="2.5" stroke-linecap="round"/>' +
    '<line x1="22" y1="5" x2="28" y2="48" stroke="#8B6914" stroke-width="2.5" stroke-linecap="round"/>' +
    '<rect x="10" y="3" width="5" height="8" rx="1" fill="#C41E3A" opacity="0.8"/>' +
    '<rect x="20" y="3" width="5" height="8" rx="1" fill="#C41E3A" opacity="0.8"/>' +
  '</svg>';
};

/**
 * 桜の花びらSVG — 春の装飾
 */
window.createSakuraSvg = function(size) {
  size = size || 32;
  return '<svg viewBox="0 0 30 30" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<g transform="translate(15,15)">' +
      '<ellipse cx="0" cy="-8" rx="4" ry="8" fill="#f8b4c8" opacity="0.7" transform="rotate(0)">' +
        '<animateTransform attributeName="transform" type="rotate" values="0;5;0;-5;0" dur="4s" repeatCount="indefinite"/>' +
      '</ellipse>' +
      '<ellipse cx="0" cy="-8" rx="4" ry="8" fill="#f8b4c8" opacity="0.7" transform="rotate(72)"/>' +
      '<ellipse cx="0" cy="-8" rx="4" ry="8" fill="#f8b4c8" opacity="0.7" transform="rotate(144)"/>' +
      '<ellipse cx="0" cy="-8" rx="4" ry="8" fill="#f8b4c8" opacity="0.7" transform="rotate(216)"/>' +
      '<ellipse cx="0" cy="-8" rx="4" ry="8" fill="#f8b4c8" opacity="0.7" transform="rotate(288)"/>' +
      '<circle cx="0" cy="0" r="3" fill="#e8879e" opacity="0.6"/>' +
    '</g>' +
  '</svg>';
};

/**
 * 雪の結晶SVG — 冬の装飾
 */
window.createSnowflakeSvg = function(size) {
  size = size || 28;
  return '<svg viewBox="0 0 30 30" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<g transform="translate(15,15)" stroke="#b8d4e8" stroke-width="1.5" fill="none" opacity="0.6">' +
      '<line x1="0" y1="-12" x2="0" y2="12"/>' +
      '<line x1="-10.4" y1="-6" x2="10.4" y2="6"/>' +
      '<line x1="-10.4" y1="6" x2="10.4" y2="-6"/>' +
      '<line x1="0" y1="-12" x2="-3" y2="-9"/>' +
      '<line x1="0" y1="-12" x2="3" y2="-9"/>' +
      '<line x1="0" y1="12" x2="-3" y2="9"/>' +
      '<line x1="0" y1="12" x2="3" y2="9"/>' +
      '<circle cx="0" cy="0" r="2" fill="#b8d4e8" opacity="0.4"/>' +
      '<animateTransform attributeName="transform" type="rotate" from="0 15 15" to="360 15 15" dur="20s" repeatCount="indefinite"/>' +
    '</g>' +
  '</svg>';
};

/**
 * 本SVG — ひよりのシンボル
 */
window.createBookSvg = function(size) {
  size = size || 36;
  return '<svg viewBox="0 0 40 40" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<rect x="8" y="6" width="24" height="30" rx="2" fill="#e8ddd0" stroke="#c8b8a8" stroke-width="1.5"/>' +
    '<line x1="20" y1="6" x2="20" y2="36" stroke="#c8b8a8" stroke-width="1"/>' +
    '<rect x="8" y="6" width="2" height="30" rx="1" fill="#a08060"/>' +
    '<line x1="14" y1="14" x2="18" y2="14" stroke="#c8b8a8" stroke-width="0.8"/>' +
    '<line x1="14" y1="18" x2="18" y2="18" stroke="#c8b8a8" stroke-width="0.8"/>' +
    '<line x1="14" y1="22" x2="17" y2="22" stroke="#c8b8a8" stroke-width="0.8"/>' +
    '<line x1="22" y1="14" x2="30" y2="14" stroke="#c8b8a8" stroke-width="0.8"/>' +
    '<line x1="22" y1="18" x2="29" y2="18" stroke="#c8b8a8" stroke-width="0.8"/>' +
    '<line x1="22" y1="22" x2="28" y2="22" stroke="#c8b8a8" stroke-width="0.8"/>' +
  '</svg>';
};

/**
 * 暖簾SVG — 定食屋「灯」の入口
 */
window.createNorenSvg = function(size) {
  size = size || 64;
  return '<svg viewBox="0 0 80 50" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<rect x="5" y="0" width="70" height="6" rx="2" fill="#8B4513"/>' +
    '<rect x="10" y="6" width="14" height="38" rx="0 0 4 4" fill="#1a3a5c" opacity="0.85">' +
      '<animate attributeName="transform" type="translate" values="0,0;1,0;0,0;-1,0;0,0" dur="5s" repeatCount="indefinite"/>' +
    '</rect>' +
    '<rect x="26" y="6" width="14" height="40" rx="0 0 4 4" fill="#1a3a5c" opacity="0.85">' +
      '<animate attributeName="transform" type="translate" values="0,0;-0.5,0;0,0;0.5,0;0,0" dur="5.5s" repeatCount="indefinite"/>' +
    '</rect>' +
    '<rect x="42" y="6" width="14" height="40" rx="0 0 4 4" fill="#1a3a5c" opacity="0.85">' +
      '<animate attributeName="transform" type="translate" values="0,0;0.5,0;0,0;-0.5,0;0,0" dur="5.3s" repeatCount="indefinite"/>' +
    '</rect>' +
    '<rect x="58" y="6" width="14" height="38" rx="0 0 4 4" fill="#1a3a5c" opacity="0.85">' +
      '<animate attributeName="transform" type="translate" values="0,0;-1,0;0,0;1,0;0,0" dur="4.8s" repeatCount="indefinite"/>' +
    '</rect>' +
    '<text x="40" y="32" text-anchor="middle" font-size="14" fill="#e8ddd0" font-family="serif">灯</text>' +
  '</svg>';
};

/**
 * お茶碗SVG — 食事モチーフ
 */
window.createBowlSvg = function(size) {
  size = size || 44;
  return '<svg viewBox="0 0 50 40" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<ellipse cx="25" cy="28" rx="20" ry="10" fill="#f5f0e8" stroke="#c8b8a8" stroke-width="1.5"/>' +
    '<path d="M5 28 Q5 18 25 16 Q45 18 45 28" fill="#f5f0e8" stroke="#c8b8a8" stroke-width="1.5"/>' +
    '<ellipse cx="25" cy="35" rx="8" ry="3" fill="none" stroke="#c8b8a8" stroke-width="1"/>' +
    '<path d="M15 20 Q12 12 18 8" fill="none" stroke="rgba(200,190,180,0.3)" stroke-width="1.5" stroke-linecap="round">' +
      '<animate attributeName="d" values="M15 20 Q12 12 18 8;M15 20 Q18 12 14 8;M15 20 Q12 12 18 8" dur="3s" repeatCount="indefinite"/>' +
    '</path>' +
    '<path d="M25 18 Q22 10 26 5" fill="none" stroke="rgba(200,190,180,0.25)" stroke-width="1.2" stroke-linecap="round">' +
      '<animate attributeName="d" values="M25 18 Q22 10 26 5;M25 18 Q28 10 24 5;M25 18 Q22 10 26 5" dur="3.5s" repeatCount="indefinite"/>' +
    '</path>' +
    '<path d="M35 20 Q32 13 36 9" fill="none" stroke="rgba(200,190,180,0.2)" stroke-width="1" stroke-linecap="round">' +
      '<animate attributeName="d" values="M35 20 Q32 13 36 9;M35 20 Q38 13 34 9;M35 20 Q32 13 36 9" dur="4s" repeatCount="indefinite"/>' +
    '</path>' +
  '</svg>';
};

/**
 * 傘SVG — 雨の日モチーフ
 */
window.createUmbrellaSvg = function(size) {
  size = size || 36;
  return '<svg viewBox="0 0 40 44" width="' + size + '" xmlns="http://www.w3.org/2000/svg">' +
    '<path d="M20 8 Q2 10 4 22 L20 18 L36 22 Q38 10 20 8Z" fill="#e8734a" opacity="0.8"/>' +
    '<line x1="20" y1="8" x2="20" y2="38" stroke="#8B6914" stroke-width="2" stroke-linecap="round"/>' +
    '<path d="M20 38 Q20 42 16 42" fill="none" stroke="#8B6914" stroke-width="2" stroke-linecap="round"/>' +
    '<line x1="20" y1="18" x2="12" y2="21" stroke="#d4623b" stroke-width="0.8" opacity="0.5"/>' +
    '<line x1="20" y1="18" x2="28" y2="21" stroke="#d4623b" stroke-width="0.8" opacity="0.5"/>' +
  '</svg>';
};

/**
 * 季節の装飾をbodyに追加するヘルパー
 * メインアプリの初期化後に呼ばれ、季節に応じた浮遊するSVG粒子を挿入
 *
 * パフォーマンス最適化:
 *   - 同じ季節なら DOM を再生成しない（_currentSeason でキャッシュ）
 *   - パーティクル数を削減（6→4, 5→3, 4→3）
 *   - will-change: transform で合成レイヤーを確保
 *
 * DOM要素は createElement + DOM API で安全に構築。
 * SVG文字列の挿入には DOMParser を使用（XSS安全）。
 */
var _currentSeason = null;

window.addSeasonalDecoration = function(season) {
  // 同じ季節なら何もしない（日替わりで不要な DOM チャーンを回避）
  if (_currentSeason === season) return;
  _currentSeason = season;

  // 既存の装飾を除去
  var existing = document.getElementById('seasonal-deco');
  if (existing) existing.remove();

  var container = document.createElement('div');
  container.id = 'seasonal-deco';
  container.style.cssText = 'position:fixed;top:0;left:0;width:100%;height:100%;pointer-events:none;z-index:0;overflow:hidden;';

  var particles = [];
  if (season === 'spring') {
    for (var i = 0; i < 4; i++) {
      particles.push({
        svg: createSakuraSvg(14 + Math.random() * 12),
        x: Math.random() * 100,
        delay: Math.random() * 8,
        dur: 12 + Math.random() * 8
      });
    }
  } else if (season === 'autumn') {
    for (var j = 0; j < 3; j++) {
      var leaf = document.createElement('div');
      leaf.style.cssText = 'position:absolute;width:8px;height:8px;border-radius:50% 0 50% 0;' +
        'background:rgba(255,140,0,' + (0.15 + Math.random() * 0.1) + ');' +
        'left:' + (Math.random() * 100) + '%;top:-10px;' +
        'will-change:transform;' +
        'animation:leafFall ' + (14 + Math.random() * 8) + 's linear ' + (Math.random() * 10) + 's infinite;' +
        'transform:rotate(' + (Math.random() * 360) + 'deg);';
      container.appendChild(leaf);
    }
  } else if (season === 'winter') {
    for (var k = 0; k < 3; k++) {
      particles.push({
        svg: createSnowflakeSvg(10 + Math.random() * 10),
        x: Math.random() * 100,
        delay: Math.random() * 12,
        dur: 18 + Math.random() * 10
      });
    }
  }

  particles.forEach(function(p) {
    var el = document.createElement('div');
    // DOMParser で安全に SVG をパース（静的文字列のみ）
    var svgNode = parseSvgString(p.svg);
    el.appendChild(document.importNode(svgNode, true));
    el.style.cssText = 'position:absolute;left:' + p.x + '%;top:-20px;' +
      'will-change:transform;' +
      'animation:particleFall ' + p.dur + 's linear ' + p.delay + 's infinite;' +
      'opacity:0.5;';
    container.appendChild(el);
  });

  document.body.appendChild(container);
};

// =========================================================================
// 浮遊パーティクル用 CSS keyframes を動的に注入
// =========================================================================
(function() {
  var style = document.createElement('style');
  style.textContent =
    '@keyframes particleFall {' +
      '0% { transform: translateY(-20px) rotate(0deg); opacity: 0; }' +
      '10% { opacity: 0.6; }' +
      '90% { opacity: 0.4; }' +
      '100% { transform: translateY(110vh) rotate(360deg); opacity: 0; }' +
    '}' +
    '@keyframes leafFall {' +
      '0% { transform: translateY(-20px) rotate(0deg) translateX(0); opacity: 0; }' +
      '10% { opacity: 0.3; }' +
      '50% { transform: translateY(50vh) rotate(180deg) translateX(30px); }' +
      '90% { opacity: 0.2; }' +
      '100% { transform: translateY(110vh) rotate(360deg) translateX(-20px); opacity: 0; }' +
    '}';
  document.head.appendChild(style);
})();
