#!/bin/bash
set -e

echo "🔄 Updating Pelias Docker submodule..."

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

# Change to the pelias/docker submodule directory
cd "$SCRIPT_DIR/docker"

echo "📥 Fetching latest changes from upstream..."
git fetch origin

# Get current and latest commit hashes
CURRENT_COMMIT=$(git rev-parse HEAD)
LATEST_COMMIT=$(git rev-parse origin/master)

if [ "$CURRENT_COMMIT" = "$LATEST_COMMIT" ]; then
    echo "✅ Already up to date!"
    exit 0
fi

echo "🔄 Updating to latest commit..."
git pull origin master

# Go back to project root
cd "$PROJECT_ROOT"

echo "📝 Committing submodule update..."
git add pelias/docker
git commit -m "Update pelias/docker submodule to latest version

Previous: ${CURRENT_COMMIT:0:8}
Current:  ${LATEST_COMMIT:0:8}"

echo "✅ Pelias Docker submodule updated successfully!"
echo "🔍 You can check the changes with: git log --oneline -n 5 pelias/docker" 