#!/bin/bash
# Install script that avoids GitHub authentication issues

set -e

PROJECT_NAME=${1:-my-project}
TEMP_DIR=$(mktemp -d)

echo "Creating new project: $PROJECT_NAME"

# Clone the template repository using git (no API calls)
git clone --depth 1 https://github.com/arthasyou/axum-temaplate.git "$TEMP_DIR/template" 2>/dev/null || {
    echo "Failed to clone template repository"
    exit 1
}

# Use cargo-generate with local path (avoids GitHub API)
cargo generate --path "$TEMP_DIR/template" --name "$PROJECT_NAME"

# Cleanup
rm -rf "$TEMP_DIR"

echo "✅ Project $PROJECT_NAME created successfully!"
echo "📁 cd $PROJECT_NAME && cargo run"