import { defineConfig } from "rolldown";
import { readFileSync, writeFileSync, copyFileSync, mkdirSync } from "fs";

export default defineConfig({
  input: "./_build/js/release/build/main/main.js",
  output: {
    dir: "dist/assets",
    format: "esm",
    minify: true,
  },
  plugins: [
    {
      name: "copy-static",
      generateBundle() {
        mkdirSync("dist", { recursive: true });
        // Rewrite script src path for production
        const html = readFileSync("index.html", "utf-8").replace(
          "./_build/js/release/build/main/main.js",
          "./assets/main.js"
        );
        writeFileSync("dist/index.html", html);
        copyFileSync("style.css", "dist/style.css");
        copyFileSync("animations.js", "dist/animations.js");
      },
    },
  ],
});
