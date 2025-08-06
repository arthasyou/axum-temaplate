# Development Guide for Axum Template

This is a cargo-generate template project. It has special requirements for development and testing.

## Project Structure

- `Cargo.toml` - Working Cargo.toml for development (with real values)
- `Cargo.toml.template` - Template file used by cargo-generate (with placeholders like `{{name}}`)
- `cargo-generate.toml` - Configuration for cargo-generate

## Testing the Template

Since this is a template project, you cannot use standard Rust commands directly on the template files. Instead:

### Quick Commands

```bash
# Check the actual project code (uses Cargo.toml with real values)
cargo check
cargo build
cargo test
cargo clippy

# Test the template generation
make test         # Full test (generate, build, test)
make test-quick   # Quick test (just generate)
make test-keep    # Test and keep generated project for inspection
make clean        # Clean up test directories
```

### Manual Testing

1. **Test template generation:**
```bash
cargo generate --path . --name test-project
```

2. **Test the generated project:**
```bash
cd test-project
cp config/services-example.toml config/services.toml
cargo run
```

## Making Changes

### When modifying Rust code:
1. Edit the source files in `src/`
2. Test with `cargo check` or `cargo build`
3. Run `make test` to ensure template generation still works

### When modifying template variables:
1. Edit `Cargo.toml.template` (NOT `Cargo.toml`)
2. Update `cargo-generate.toml` if adding new placeholders
3. Run `make test` to verify variable substitution

### Important Files:
- **DO NOT** edit `Cargo.toml` template variables - this file is for development only
- **DO** edit `Cargo.toml.template` for template changes
- **DO** keep both files in sync for dependencies and features

## CI/CD

The GitHub Actions workflow (`template-test.yml`) automatically:
1. Generates a test project from the template
2. Builds the generated project
3. Runs tests on the generated project
4. Validates with clippy

## Common Issues

### "invalid character `{` in package name"
This means cargo-generate is trying to parse the template file. Make sure:
- `Cargo.toml` has real values for development
- `Cargo.toml.template` has template variables
- `cargo-generate.toml` excludes the right files

### Template generation fails
Check that:
- All placeholders in templates are defined in `cargo-generate.toml`
- The `exclude` list in `cargo-generate.toml` is correct
- No build artifacts are included (target/, test-*/)

## VSCode Integration

Use the provided tasks (Cmd/Ctrl+Shift+P → "Tasks: Run Task"):
- Test Template - Full template test
- Quick Test Template - Quick generation test
- Test and Keep - Test and keep generated project
- Clean Test Directories - Remove test artifacts