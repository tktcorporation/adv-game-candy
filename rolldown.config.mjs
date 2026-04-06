import { defineConfig } from "rolldown";
import { readFileSync, writeFileSync, copyFileSync, mkdirSync } from "fs";

export default defineConfig({
  input: "./_build/js/release/build/main/main.js",
  output: {
    dir: "dist/assets",
    format: "esm",
    minify: true,
    // コンテンツハッシュ付きファイル名でキャッシュバスティング
    entryFileNames: "[name]-[hash].js",
  },
  plugins: [
    {
      name: "copy-static",
      generateBundle(_, bundle) {
        mkdirSync("dist", { recursive: true });

        // バンドル出力からハッシュ付きファイル名を取得
        const jsFileName = Object.keys(bundle).find((f) => f.endsWith(".js"));

        // Rewrite script src path for production
        const html = readFileSync("index.html", "utf-8").replace(
          "./_build/js/release/build/main/main.js",
          `./assets/${jsFileName}`
        );
        writeFileSync("dist/index.html", html);
        copyFileSync("style.css", "dist/style.css");
        copyFileSync("animations.js", "dist/animations.js");
      },
    },
  ],
});
