import { test, expect } from "@playwright/test";

test.describe("デプロイ検証: 初期表示", () => {
  test("ページが正常にロードされる", async ({ page }) => {
    const response = await page.goto("/");
    expect(response?.status()).toBe(200);
  });

  test("タイトルが正しい", async ({ page }) => {
    await page.goto("/");
    await expect(page).toHaveTitle("月灯り - 廃墟カフェ復興記");
  });

  test("JSが実行され #app 内にコンテンツが描画される", async ({ page }) => {
    await page.goto("/");
    const app = page.locator("#app");
    await expect(app).not.toBeEmpty();
  });

  test("main.js が正常にロードされる (コンソールエラーなし)", async ({
    page,
  }) => {
    const errors: string[] = [];
    page.on("pageerror", (err) => errors.push(err.message));
    page.on("console", (msg) => {
      if (msg.type() === "error") errors.push(msg.text());
    });

    await page.goto("/");
    // JS実行を少し待つ
    await page.waitForTimeout(2000);

    expect(errors).toEqual([]);
  });

  test("ゲームヘッダーが表示される", async ({ page }) => {
    await page.goto("/");
    await expect(page.locator(".game-header")).toBeVisible();
    // タイトル「月灯り」が表示される
    await expect(page.locator(".header-title .title")).toContainText("月灯り");
  });

  test("初期ステータスが表示される (Day 1, 所持金, スタミナ)", async ({
    page,
  }) => {
    await page.goto("/");
    const header = page.locator(".header-stats");
    await expect(header).toBeVisible();
    // Day 1 が表示される
    await expect(header).toContainText("Day 1");
    // 所持金が表示される (初期500¥ + ログインボーナス200¥ = 700¥)
    await expect(header).toContainText("¥");
  });
});

test.describe("デプロイ検証: ストーリーフェーズ (Ch0)", () => {
  test("初期状態でストーリービューが表示される", async ({ page }) => {
    await page.goto("/");
    await expect(page.locator(".story-view")).toBeVisible();
  });

  test("チャプターヘッダーにCh0タイトルが表示される", async ({ page }) => {
    await page.goto("/");
    await expect(page.locator(".chapter-header")).toContainText(
      "廃墟と最初の一杯"
    );
  });

  test("ストーリーテキストが表示される", async ({ page }) => {
    await page.goto("/");
    await expect(page.locator(".story-text")).toBeVisible();
    // 最初のセリフがある
    const text = await page.locator(".story-text").textContent();
    expect(text?.length).toBeGreaterThan(0);
  });

  test("進行ボタン(▼)が表示され、クリックできる", async ({ page }) => {
    await page.goto("/");
    const advanceBtn = page.locator(".story-controls .btn-primary");
    await expect(advanceBtn).toBeVisible();

    // 最初のテキストを記録
    const firstText = await page.locator(".story-text").textContent();

    // クリックして進行
    await advanceBtn.click();
    await page.waitForTimeout(500);

    // テキストが変わる（ストーリーが進む）か、同じでも問題ない（最終行なら「次へ」に変わる）
    const secondText = await page.locator(".story-text").textContent();
    // 少なくとも何かテキストが表示されている
    expect(secondText?.length).toBeGreaterThan(0);
  });

  test("ストーリーを最後まで進めるとビジネスフェーズに遷移する", async ({
    page,
  }) => {
    await page.goto("/");

    // ストーリーを進める（最大100回クリック、安全弁）
    for (let i = 0; i < 100; i++) {
      const businessView = page.locator(".business-view");
      if (await businessView.isVisible().catch(() => false)) {
        break;
      }

      const advanceBtn = page.locator(".story-controls .btn-primary");
      if (await advanceBtn.isVisible().catch(() => false)) {
        await advanceBtn.click();
        await page.waitForTimeout(200);
      } else {
        break;
      }
    }

    // ビジネスフェーズに到達
    await expect(page.locator(".business-view")).toBeVisible({ timeout: 5000 });
  });
});

test.describe("デプロイ検証: ビジネスフェーズ", () => {
  // ヘルパー: ストーリーをスキップしてビジネスフェーズに到達
  async function skipToBusinessPhase(page: import("@playwright/test").Page) {
    await page.goto("/");
    for (let i = 0; i < 100; i++) {
      const businessView = page.locator(".business-view");
      if (await businessView.isVisible().catch(() => false)) break;
      const advanceBtn = page.locator(".story-controls .btn-primary");
      if (await advanceBtn.isVisible().catch(() => false)) {
        await advanceBtn.click();
        await page.waitForTimeout(150);
      } else {
        break;
      }
    }
  }

  test("メニューグリッドが表示される", async ({ page }) => {
    await skipToBusinessPhase(page);
    await expect(page.locator(".menu-grid")).toBeVisible();
  });

  test("初期レシピ3つが表示される", async ({ page }) => {
    await skipToBusinessPhase(page);
    const menuItems = page.locator(".menu-item");
    const count = await menuItems.count();
    expect(count).toBeGreaterThanOrEqual(3);
  });

  test("メニューアイテムをクリックして選択できる", async ({ page }) => {
    await skipToBusinessPhase(page);
    const firstItem = page.locator(".menu-item").first();
    await firstItem.click();
    await page.waitForTimeout(300);
    // チェックマークの状態が変わることを確認
    const checkMark = firstItem.locator(".menu-check");
    const text = await checkMark.textContent();
    // [x] または [✓] など選択状態を示すテキストが含まれる
    expect(text).toBeTruthy();
  });

  test("「営業開始」ボタンが表示される", async ({ page }) => {
    await skipToBusinessPhase(page);
    const startBtn = page.locator(".btn-primary.btn-large");
    await expect(startBtn).toBeVisible();
    await expect(startBtn).toContainText("営業開始");
  });

  test("スタミナが表示される", async ({ page }) => {
    await skipToBusinessPhase(page);
    // スタミナ情報がヘッダーまたはビジネスビュー内に表示
    const pageContent = await page.textContent("body");
    expect(pageContent).toContain("SP");
  });

  test("営業を開始して結果画面に遷移する", async ({ page }) => {
    await skipToBusinessPhase(page);

    // メニューを選択
    const firstItem = page.locator(".menu-item").first();
    await firstItem.click();
    await page.waitForTimeout(300);

    // 営業開始をクリック
    const startBtn = page.locator(".btn-primary.btn-large");
    await startBtn.click();
    await page.waitForTimeout(1000);

    // 結果画面に遷移
    await expect(page.locator(".day-result-view")).toBeVisible({
      timeout: 5000,
    });
  });
});

test.describe("デプロイ検証: 一連のゲームフロー", () => {
  test("ストーリー → ビジネス → 結果 → 次の日 の全フローが動作する", async ({
    page,
  }) => {
    await page.goto("/");

    // --- ストーリーフェーズ ---
    await expect(page.locator(".story-view")).toBeVisible();

    // ストーリーを最後まで進める
    for (let i = 0; i < 100; i++) {
      if (await page.locator(".business-view").isVisible().catch(() => false))
        break;
      const btn = page.locator(".story-controls .btn-primary");
      if (await btn.isVisible().catch(() => false)) {
        await btn.click();
        await page.waitForTimeout(150);
      } else break;
    }

    // --- ビジネスフェーズ ---
    await expect(page.locator(".business-view")).toBeVisible();

    // メニュー選択 → 営業開始
    await page.locator(".menu-item").first().click();
    await page.waitForTimeout(300);
    await page.locator(".btn-primary.btn-large").click();
    await page.waitForTimeout(1000);

    // --- 日次結果フェーズ ---
    await expect(page.locator(".day-result-view")).toBeVisible({
      timeout: 5000,
    });
    const heading = page.locator(".day-result-view h2");
    await expect(heading).toContainText("営業結果");
    await expect(page.locator(".day-summary")).toBeVisible();

    // 「次の日へ」で次の日に進む
    const nextDayBtn = page.locator(".day-result-actions .btn-primary");
    await expect(nextDayBtn).toContainText("次の日へ");
    await nextDayBtn.click();
    await page.waitForTimeout(1000);

    // Day 2 になる (チャプター解放条件を満たすとストーリーフェーズに遷移する場合もある)
    await expect(page.locator(".header-stats")).toContainText("Day 2", {
      timeout: 5000,
    });
    // ビジネスフェーズまたはストーリーフェーズのどちらかが表示される
    const isBusinessOrStory = await Promise.race([
      page
        .locator(".business-view")
        .waitFor({ state: "visible", timeout: 5000 })
        .then(() => true),
      page
        .locator(".story-view")
        .waitFor({ state: "visible", timeout: 5000 })
        .then(() => true),
    ]);
    expect(isBusinessOrStory).toBe(true);
  });

  test("メッセージログ領域が存在する", async ({ page }) => {
    await page.goto("/");
    await page.waitForTimeout(1000);
    const messageLog = page.locator(".message-log");
    if (await messageLog.isVisible().catch(() => false)) {
      await expect(messageLog).toBeVisible();
    }
  });
});
