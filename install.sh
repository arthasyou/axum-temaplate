#!/bin/bash
set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Default values
TEMPLATE_REPO="https://github.com/arthasyou/axum-template.git"
PROJECT_NAME=$1

# Print banner
echo -e "${GREEN}"
echo "╔═══════════════════════════════════════╗"
echo "║       Axum Template Installer         ║"
echo "╚═══════════════════════════════════════╝"
echo -e "${NC}"

# Check if project name is provided
if [ -z "$PROJECT_NAME" ]; then
    echo -e "${YELLOW}Usage: $0 <project-name>${NC}"
    echo "Example: $0 my-awesome-api"
    exit 1
fi

# Check if cargo is installed
if ! command -v cargo &> /dev/null; then
    echo -e "${RED}Error: Cargo is not installed.${NC}"
    echo "Please install Rust: https://rustup.rs/"
    exit 1
fi

# Check if cargo-generate is installed
if ! command -v cargo-generate &> /dev/null; then
    echo -e "${YELLOW}Installing cargo-generate...${NC}"
    cargo install cargo-generate
fi

# Create the project
echo -e "${GREEN}Creating new Axum project: $PROJECT_NAME${NC}"
cargo generate --git "$TEMPLATE_REPO" --name "$PROJECT_NAME"

# Navigate to project and setup
cd "$PROJECT_NAME"

# Copy config file
if [ -f "config/services-example.toml" ]; then
    cp config/services-example.toml config/services.toml
    echo -e "${GREEN}✓ Configuration file created${NC}"
fi

# Initialize git if not already
if [ ! -d ".git" ]; then
    git init
    git add .
    git commit -m "Initial commit from Axum template"
    echo -e "${GREEN}✓ Git repository initialized${NC}"
fi

# Success message
echo -e "${GREEN}"
echo "╔═══════════════════════════════════════╗"
echo "║        Setup Complete! 🎉             ║"
echo "╚═══════════════════════════════════════╝"
echo -e "${NC}"
echo ""
echo "Next steps:"
echo "  cd $PROJECT_NAME"
echo "  cargo run"
echo ""
echo "Swagger UI will be available at:"
echo "  http://localhost:19878/swagger-ui/"
echo ""
echo "Happy coding! 🚀"