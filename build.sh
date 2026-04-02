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

# Assemble dist directory
rm -rf dist
mkdir -p dist
cp index.html dist/
cp style.css dist/

# Copy JS output and rewrite the import path
mkdir -p dist/assets
cp _build/js/release/build/main/main.js dist/assets/main.js

# Rewrite index.html to use the new path
sed -i "s|./_build/js/release/build/main/main.js|./assets/main.js|g" dist/index.html

echo "Build complete! Output in dist/"
