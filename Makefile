.PHONY: test test-quick test-keep clean help

# Default target
help:
	@echo "Available commands for cargo-generate template:"
	@echo "  make test       - Full template test (generate, build, clippy, test)"
	@echo "  make test-quick - Quick template test (generate and check only)"
	@echo "  make test-keep  - Test and keep generated project for inspection"
	@echo "  make clean      - Remove all test directories"
	@echo "  make help       - Show this help message"

# Full test - generate project and run all checks
test:
	@echo "🧪 Running full template test..."
	@./test-template.sh

# Quick test - just generate and check
test-quick:
	@echo "⚡ Running quick template test..."
	@cargo generate --path . --name test-quick-$$(date +%s) --silent \
		--define author="Test" \
		--define email="test@test.com" \
		--define description="Test" && \
	echo "✅ Template generation successful" && \
	rm -rf test-quick-*

# Test and keep the generated project
test-keep:
	@echo "🧪 Running template test (keeping generated project)..."
	@./test-template.sh --keep

# Clean up test directories
clean:
	@echo "🧹 Cleaning up test directories..."
	@rm -rf test-generated-* test-quick-* test-project/ test-local/ test-interactive/
	@echo "✅ Cleanup complete"

# Watch for changes and test (requires cargo-watch)
watch:
	@echo "👁️  Watching for changes..."
	@cargo-watch -c -x "generate --path . --name test-watch --silent --define author=Test --define email=test@test.com --define description=Test" -s "rm -rf test-watch"