# Axum Template

A clean and minimal Axum web framework template with JWT authentication, Swagger UI, and a well-structured project layout.

## 🚀 Quick Start

### Method 1: Using cargo-generate (Recommended)

```bash
# Install cargo-generate (only needed once)
cargo install cargo-generate

# Create a new project from this template
cargo generate --git https://github.com/arthasyou/axum-template.git --name my-project
```

### Method 2: Using the install script

```bash
# One-liner to create a new project
curl -sSL https://raw.githubusercontent.com/arthasyou/axum-template/main/install.sh | sh -s -- my-project
```

### Method 3: Manual clone

```bash
git clone https://github.com/YOUR_USERNAME/axum-template.git my-project
cd my-project
rm -rf .git
git init
# Manually update the project name in Cargo.toml
```

## Features

- 🚀 **Axum Web Framework** - Fast and ergonomic web framework
- 🔐 **JWT Authentication** - Built-in JWT middleware for secure APIs
- 📚 **Swagger UI** - Auto-generated API documentation with utoipa
- 📝 **Structured Logging** - Logging with tracing and file output
- 🔧 **Error Handling** - Consistent error responses with proper HTTP status codes
- 🌐 **CORS Support** - Pre-configured CORS middleware
- ✨ **Example CRUD API** - Working example with best practices

## Project Structure

```
src/
├── error/          # Error handling and custom error types
├── handlers/       # Request handlers (business logic)
├── models/         # Data models and DTOs
├── routes/         # Route definitions and OpenAPI docs
├── logging.rs      # Logging configuration
├── settings.rs     # Application configuration
└── main.rs         # Application entry point
```

## Getting Started

1. Copy the configuration file:
```bash
cp config/services-example.toml config/services.toml
```

2. Run the application:
```bash
cargo run
```

3. Access Swagger UI:
```
http://localhost:19878/swagger-ui/
```

## Example API Endpoints

The template includes a complete CRUD example:

- `GET /example/health` - Health check (no auth required)
- `GET /example/items` - List all items
- `GET /example/items/{id}` - Get a specific item
- `POST /example/items` - Create a new item
- `DELETE /example/items/{id}` - Delete an item

All endpoints (except health check) require JWT authentication. Include the token in the Authorization header:
```
Authorization: Bearer <your-jwt-token>
```

## Configuration

The main configuration file is `config/services.toml`:

- `http.port` - HTTP server port (default: 19878)
- `jwt.*` - JWT authentication settings

## Dependencies

- `axum` - Web framework
- `tokio` - Async runtime
- `tracing` - Structured logging
- `serde` - Serialization/deserialization
- `validator` - Request validation
- `utoipa` - OpenAPI documentation generation
- `toolcraft-*` - Utility libraries for common patterns

## Extending the Template

### Adding New APIs

1. Define your data models in `models/`
2. Implement business logic in `handlers/`
3. Define routes and OpenAPI documentation in `routes/`

### Adding a Database

1. Add database dependencies (e.g., `sqlx`)
2. Add database configuration to `settings.rs`
3. Create a connection pool and inject it into your routes

### Custom Middleware

1. Create your middleware module
2. Add it to the router in `routes/mod.rs`

## Development

```bash
# Format code
cargo fmt

# Run linter
cargo clippy

# Run tests
cargo test

# Check code without building
cargo check
```

## License

MIT