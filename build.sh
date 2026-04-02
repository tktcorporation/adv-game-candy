#!/bin/bash
# Build script for deployment (Netlify / Cloudflare Pages)
set -e

# Install MoonBit if not available
if ! command -v moon &> /dev/null; then
  curl -fsSL https://cli.moonbitlang.com/install/unix.sh | bash
  export PATH="$HOME/.moon/bin:$PATH"
fi

# Update registry and build
moon update
moon build --target js --release

# Bundle with rolldown (minify + copy static files)
rm -rf dist
npm install --prefer-offline --no-audit 2>/dev/null || npm install
npx rolldown -c rolldown.config.mjs

echo "Build complete! Output in dist/"
