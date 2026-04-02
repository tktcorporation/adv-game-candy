import { defineConfig } from "@playwright/test";

export default defineConfig({
  testDir: "./e2e",
  timeout: 60000,
  expect: {
    timeout: 10000,
  },
  use: {
    baseURL: "http://localhost:3123",
    headless: true,
    screenshot: "only-on-failure",
    launchOptions: {
      args: ["--no-sandbox", "--disable-setuid-sandbox"],
    },
  },
  webServer: {
    command: "npx serve dist -l 3123 --no-clipboard",
    port: 3123,
    reuseExistingServer: true,
  },
  projects: [
    {
      name: "chromium",
      use: { browserName: "chromium" },
    },
  ],
});
