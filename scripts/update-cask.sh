#!/usr/bin/env bash
# Fetches the latest VectorDBZ release from GitHub and updates Casks/vectordbz.rb

set -euo pipefail

REPO="vectordbz/vectordbz"
CASK_FILE="$(dirname "$0")/../Casks/vectordbz.rb"

echo "Fetching latest release from github.com/${REPO}..."

RELEASE=$(curl -fsSL "https://api.github.com/repos/${REPO}/releases/latest")

NEW_VERSION=$(echo "$RELEASE" | grep '"tag_name"' | sed 's/.*"tag_name": *"v\([^"]*\)".*/\1/')

ASSET=$(echo "$RELEASE" | python3 -c "
import sys, json
assets = json.load(sys.stdin)['assets']
for a in assets:
    if 'darwin-arm64' in a['name'] and a['name'].endswith('.zip'):
        print(a['digest'])
        break
")

# digest field is in the form "sha256:<hex>", strip the prefix
NEW_SHA256="${ASSET#sha256:}"

if [[ -z "$NEW_VERSION" || -z "$NEW_SHA256" ]]; then
    echo "ERROR: Could not parse version or SHA256 from the GitHub API response."
    exit 1
fi

CURRENT_VERSION=$(grep 'version ' "$CASK_FILE" | sed 's/.*version "\([^"]*\)".*/\1/')

if [[ "$NEW_VERSION" == "$CURRENT_VERSION" ]]; then
    echo "Already up to date (v${CURRENT_VERSION}). Nothing to do."
    exit 0
fi

echo "Updating cask: v${CURRENT_VERSION} → v${NEW_VERSION}"

sed -i '' \
    -e "s/version \"${CURRENT_VERSION}\"/version \"${NEW_VERSION}\"/" \
    -e "s/sha256 \"[a-f0-9]*\"/sha256 \"${NEW_SHA256}\"/" \
    "$CASK_FILE"

echo "Updated ${CASK_FILE}"

git -C "$(dirname "$0")/.." add Casks/vectordbz.rb
git -C "$(dirname "$0")/.." commit -m "Update VectorDBZ to v${NEW_VERSION}"

echo ""
echo "Done! Run 'git push origin master' to publish."
