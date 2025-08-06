# Axum Template

一个简洁的 Axum Web 框架模板项目，提供了基础的项目结构和示例 API。

## 特性

- 基于 Axum Web 框架
- JWT 认证中间件
- 结构化的错误处理
- Swagger UI 文档集成 (utoipa)
- 日志记录 (tracing)
- CORS 支持
- 示例 CRUD API

## 项目结构

```
src/
├── error/          # 错误处理模块
├── handlers/       # 请求处理器
├── models/         # 数据模型
├── routes/         # 路由定义
├── logging.rs      # 日志配置
├── settings.rs     # 配置管理
└── main.rs         # 应用入口
```

## 快速开始

1. 复制配置文件：
```bash
cp config/services-example.toml config/services.toml
```

2. 运行项目：
```bash
cargo run
```

3. 访问 Swagger UI：
```
http://localhost:19878/swagger-ui/
```

## 示例 API

项目包含一个示例 API，展示了基本的 CRUD 操作：

- `GET /example/health` - 健康检查（无需认证）
- `GET /example/items` - 获取所有项目
- `GET /example/items/{id}` - 获取单个项目
- `POST /example/items` - 创建新项目
- `DELETE /example/items/{id}` - 删除项目

除了健康检查外，其他端点都需要 JWT 认证。在请求头中添加：
```
Authorization: Bearer <your-jwt-token>
```

## 配置

主要配置文件位于 `config/services.toml`：

- `http.port` - HTTP 服务端口
- `jwt.*` - JWT 认证相关配置

## 依赖

- `axum` - Web 框架
- `tokio` - 异步运行时
- `tracing` - 日志记录
- `serde` - 序列化/反序列化
- `validator` - 请求验证
- `utoipa` - OpenAPI 文档生成
- `toolcraft-*` - 实用工具库

## 扩展指南

1. **添加新的 API**：
   - 在 `models/` 中定义数据模型
   - 在 `handlers/` 中实现业务逻辑
   - 在 `routes/` 中定义路由和 OpenAPI 文档

2. **添加数据库**：
   - 添加数据库依赖（如 sqlx）
   - 在 `settings.rs` 中添加数据库配置
   - 创建数据库连接池并注入到路由中

3. **自定义中间件**：
   - 在适当的位置创建中间件模块
   - 在路由配置中添加中间件层

## 许可证

MIT