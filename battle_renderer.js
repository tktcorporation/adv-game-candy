// battle_renderer.js — Pixi.js v8 ベースの戦場レンダラー
//
// MoonBit FFI から globalThis の関数群を呼び出して描画を制御する。
// ゲームロジック(tick処理、衝突判定)はMoonBit側。ここは描画のみ。

(() => {
  if (typeof PIXI === 'undefined') {
    console.warn('Pixi.js not loaded, battle renderer disabled');
    return;
  }

  let app = null;
  let unitLayer = null;
  let effectLayer = null;
  let bgLayer = null;

  const units = new Map();
  const FIELD_W = 480;
  const FIELD_H = 200;
  const GROUND_Y = FIELD_H - 50;

  // ─── 初期化 ───

  globalThis.initBattleRenderer = async function (containerId) {
    if (app) {
      app.destroy(true);
      units.clear();
    }

    app = new PIXI.Application();
    await app.init({
      width: FIELD_W,
      height: FIELD_H,
      backgroundAlpha: 0,
      antialias: true,
      resolution: window.devicePixelRatio || 1,
      autoDensity: true,
    });

    const container = document.getElementById(containerId);
    if (!container) return;
    // コンテナの既存子要素を安全に削除
    while (container.firstChild) {
      container.removeChild(container.firstChild);
    }
    container.appendChild(app.canvas);
    app.canvas.style.width = '100%';
    app.canvas.style.maxWidth = FIELD_W + 'px';
    app.canvas.style.borderRadius = '12px';

    bgLayer = new PIXI.Container();
    unitLayer = new PIXI.Container();
    effectLayer = new PIXI.Container();
    app.stage.addChild(bgLayer);
    app.stage.addChild(unitLayer);
    app.stage.addChild(effectLayer);

    drawBackground();
    drawBases();
  };

  // ─── 背景描画 ───

  function drawBackground() {
    // 壁面（暖かい色調）
    const wall = new PIXI.Graphics();
    wall.rect(0, 0, FIELD_W, GROUND_Y);
    wall.fill({ color: 0xf5e6d3 });
    bgLayer.addChild(wall);

    // 地面（板張り風）
    const ground = new PIXI.Graphics();
    ground.rect(0, GROUND_Y, FIELD_W, FIELD_H - GROUND_Y);
    ground.fill({ color: 0xc9a96e });
    bgLayer.addChild(ground);

    // 地面ライン
    const line = new PIXI.Graphics();
    line.moveTo(0, GROUND_Y);
    line.lineTo(FIELD_W, GROUND_Y);
    line.stroke({ width: 2, color: 0xb8956a });
    bgLayer.addChild(line);

    // 奥の棚（定食屋の雰囲気）
    const shelf = new PIXI.Graphics();
    shelf.rect(0, 0, FIELD_W, 36);
    shelf.fill({ color: 0xe8d5b8 });
    bgLayer.addChild(shelf);

    // 暖簾テキスト
    const noren = new PIXI.Text({ text: '灯', style: {
      fontFamily: 'Noto Serif JP, serif',
      fontSize: 20, fill: 0x8b4513, fontWeight: 'bold',
    }});
    noren.x = 20;
    noren.y = 6;
    bgLayer.addChild(noren);
  }

  function drawBases() {
    const allyBase = new PIXI.Text({ text: '\u{1F3E0}', style: { fontSize: 36 }});
    allyBase.x = 8;
    allyBase.y = GROUND_Y - 44;
    bgLayer.addChild(allyBase);

    const enemyBase = new PIXI.Text({ text: '\u{1F47E}', style: { fontSize: 36 }});
    enemyBase.x = FIELD_W - 44;
    enemyBase.y = GROUND_Y - 44;
    bgLayer.addChild(enemyBase);
  }

  // ─── ユニット操作 ───

  globalThis.spawnBattleUnit = function (uid, emoji, x, isAlly) {
    if (!app || units.has(uid)) return;

    const container = new PIXI.Container();
    container.x = (x / 480) * FIELD_W;
    container.y = GROUND_Y - 32;

    const emojiText = new PIXI.Text({ text: emoji, style: {
      fontSize: 28, align: 'center',
    }});
    emojiText.anchor = { x: 0.5, y: 1 };
    if (!isAlly) emojiText.scale.x = -1;
    container.addChild(emojiText);

    // HPバー背景
    const hpBg = new PIXI.Graphics();
    hpBg.roundRect(-14, -36, 28, 4, 2);
    hpBg.fill({ color: 0x333333, alpha: 0.5 });
    container.addChild(hpBg);

    // HPバー
    const hpFill = new PIXI.Graphics();
    drawHpBar(hpFill, 1.0, isAlly);
    container.addChild(hpFill);

    unitLayer.addChild(container);
    units.set(uid, { container, emoji: emojiText, hpBg, hpFill, isAlly });

    // 出現アニメーション
    container.alpha = 0;
    container.scale.set(0.3);
    if (typeof anime !== 'undefined') {
      anime({ targets: container, alpha: 1, duration: 200, ease: 'outQuad' });
      anime({ targets: container.scale, x: 1, y: 1, duration: 300, ease: 'outElastic(1, 0.6)' });
    } else {
      container.alpha = 1;
      container.scale.set(1);
    }
  };

  function drawHpBar(g, ratio, isAlly) {
    g.clear();
    const w = 28 * Math.max(0, Math.min(1, ratio));
    if (w > 0) {
      g.roundRect(-14, -36, w, 4, 2);
      g.fill({ color: isAlly ? 0x4caf50 : 0xe53935 });
    }
  }

  globalThis.updateBattleUnit = function (uid, x, hpRatio) {
    const u = units.get(uid);
    if (!u) return;
    u.container.x = (x / 480) * FIELD_W;
    drawHpBar(u.hpFill, hpRatio, u.isAlly);
  };

  globalThis.removeBattleUnit = function (uid) {
    const u = units.get(uid);
    if (!u) return;

    spawnDeathEffect(u.container.x, u.container.y, u.isAlly);

    if (typeof anime !== 'undefined') {
      anime({
        targets: u.container, alpha: 0, duration: 200, ease: 'outQuad',
        complete: () => { unitLayer.removeChild(u.container); u.container.destroy(); },
      });
      anime({ targets: u.container.scale, x: 0.1, y: 0.1, duration: 200 });
    } else {
      unitLayer.removeChild(u.container);
      u.container.destroy();
    }
    units.delete(uid);
  };

  // ─── エフェクト ───

  globalThis.battleAttackEffect = function (uid, targetUid) {
    const a = units.get(uid);
    const t = units.get(targetUid);
    if (!a) return;

    if (typeof anime !== 'undefined') {
      const dir = a.isAlly ? 1 : -1;
      anime({ targets: a.container, x: a.container.x + dir * 6, duration: 80, ease: 'outQuad', direction: 'alternate' });
    }
    if (t) spawnHitSpark(t.container.x, t.container.y - 16);
  };

  globalThis.battleDamageNumber = function (x, y, damage) {
    if (!app) return;
    const pxX = (x / 480) * FIELD_W + (Math.random() - 0.5) * 20;
    const dmgText = new PIXI.Text({ text: '-' + damage, style: {
      fontFamily: 'Noto Sans JP, sans-serif', fontSize: 14, fontWeight: 'bold',
      fill: 0xff3333, stroke: { color: 0xffffff, width: 2 },
    }});
    dmgText.anchor = { x: 0.5, y: 1 };
    dmgText.x = pxX;
    dmgText.y = y - 20;
    effectLayer.addChild(dmgText);

    if (typeof anime !== 'undefined') {
      anime({
        targets: dmgText, y: dmgText.y - 30, alpha: 0, duration: 600, ease: 'outQuad',
        complete: () => { effectLayer.removeChild(dmgText); dmgText.destroy(); },
      });
    } else {
      setTimeout(() => { effectLayer.removeChild(dmgText); dmgText.destroy(); }, 600);
    }
  };

  function spawnHitSpark(x, y) {
    for (let i = 0; i < 4; i++) {
      const spark = new PIXI.Graphics();
      spark.circle(0, 0, 2 + Math.random() * 2);
      spark.fill({ color: 0xffcc00 });
      spark.x = x; spark.y = y;
      effectLayer.addChild(spark);

      const angle = (Math.PI * 2 * i) / 4 + Math.random() * 0.5;
      const dist = 10 + Math.random() * 15;
      if (typeof anime !== 'undefined') {
        anime({
          targets: spark,
          x: x + Math.cos(angle) * dist, y: y + Math.sin(angle) * dist,
          alpha: 0, duration: 300, ease: 'outQuad',
          complete: () => { effectLayer.removeChild(spark); spark.destroy(); },
        });
      } else {
        setTimeout(() => { effectLayer.removeChild(spark); spark.destroy(); }, 300);
      }
    }
  }

  function spawnDeathEffect(x, y, isAlly) {
    for (let i = 0; i < 6; i++) {
      const p = new PIXI.Graphics();
      p.circle(0, 0, 3);
      p.fill({ color: isAlly ? 0x88cc88 : 0xcc8888 });
      p.x = x; p.y = y;
      effectLayer.addChild(p);

      const angle = (Math.PI * 2 * i) / 6;
      const dist = 20 + Math.random() * 20;
      if (typeof anime !== 'undefined') {
        anime({
          targets: p,
          x: x + Math.cos(angle) * dist, y: y + Math.sin(angle) * dist - 15,
          alpha: 0, duration: 500, ease: 'outCubic',
          complete: () => { effectLayer.removeChild(p); p.destroy(); },
        });
      } else {
        setTimeout(() => { effectLayer.removeChild(p); p.destroy(); }, 500);
      }
    }
  }

  // ─── クリーンアップ ───

  globalThis.destroyBattleRenderer = function () {
    if (app) { app.destroy(true); app = null; units.clear(); }
  };
})();
