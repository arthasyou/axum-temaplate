#!/bin/bash
# Local testing script for cargo-generate template

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${YELLOW}🧪 Testing cargo-generate template...${NC}"

# Create temporary directory for testing
TEST_DIR="test-generated-$(date +%s)"
CLEANUP_NEEDED=true

# Cleanup function
cleanup() {
    if [ "$CLEANUP_NEEDED" = true ] && [ -d "$TEST_DIR" ]; then
        echo -e "${YELLOW}🧹 Cleaning up test directory...${NC}"
        rm -rf "$TEST_DIR"
    fi
}

# Set trap to cleanup on exit
trap cleanup EXIT

# Step 1: Validate cargo-generate.toml
echo -e "\n${YELLOW}1. Validating cargo-generate.toml...${NC}"
if [ ! -f "cargo-generate.toml" ]; then
    echo -e "${RED}❌ cargo-generate.toml not found${NC}"
    exit 1
fi
echo -e "${GREEN}✅ cargo-generate.toml exists${NC}"

# Step 2: Generate a test project
echo -e "\n${YELLOW}2. Generating test project...${NC}"
cargo generate --path . --name "$TEST_DIR" --silent \
    --define author="Test Author" \
    --define email="test@example.com" \
    --define description="Test project" || {
    echo -e "${RED}❌ Failed to generate project from template${NC}"
    exit 1
}
echo -e "${GREEN}✅ Project generated successfully${NC}"

# Step 3: Verify template variable substitution
echo -e "\n${YELLOW}3. Verifying template substitution...${NC}"
cd "$TEST_DIR"

if ! grep -q "name = \"$TEST_DIR\"" Cargo.toml; then
    echo -e "${RED}❌ Project name not correctly substituted${NC}"
    exit 1
fi

if ! grep -q "Test Author" Cargo.toml; then
    echo -e "${RED}❌ Author not correctly substituted${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Template variables substituted correctly${NC}"

# Step 4: Copy configuration file if needed
echo -e "\n${YELLOW}4. Setting up configuration...${NC}"
if [ -f "config/services-example.toml" ]; then
    cp config/services-example.toml config/services.toml
    echo -e "${GREEN}✅ Configuration file created${NC}"
else
    echo -e "${YELLOW}⚠️  No configuration file needed${NC}"
fi

# Step 5: Check the generated project
echo -e "\n${YELLOW}5. Checking generated project...${NC}"
cargo check --all-targets || {
    echo -e "${RED}❌ Cargo check failed${NC}"
    exit 1
}
echo -e "${GREEN}✅ Cargo check passed${NC}"

# Step 6: Build the generated project
echo -e "\n${YELLOW}6. Building generated project...${NC}"
cargo build --quiet || {
    echo -e "${RED}❌ Build failed${NC}"
    exit 1
}
echo -e "${GREEN}✅ Build successful${NC}"

# Step 7: Run clippy
echo -e "\n${YELLOW}7. Running clippy...${NC}"
cargo clippy -- -D warnings || {
    echo -e "${RED}❌ Clippy found issues${NC}"
    exit 1
}
echo -e "${GREEN}✅ Clippy passed${NC}"

# Step 8: Run tests
echo -e "\n${YELLOW}8. Running tests...${NC}"
cargo test --quiet || {
    echo -e "${RED}❌ Tests failed${NC}"
    exit 1
}
echo -e "${GREEN}✅ Tests passed${NC}"

# Success
echo -e "\n${GREEN}🎉 All template tests passed successfully!${NC}"
echo -e "${YELLOW}Generated project is in: $TEST_DIR${NC}"
echo -e "${YELLOW}Use --keep flag to preserve the test directory${NC}"

# Check if we should keep the test directory
if [ "$1" == "--keep" ]; then
    CLEANUP_NEEDED=false
    echo -e "${YELLOW}Test directory preserved at: $TEST_DIR${NC}"
fi