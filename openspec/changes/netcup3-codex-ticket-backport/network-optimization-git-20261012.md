# 本地网络优化与源码归档

2026-10-12：按用户要求，将当前项目完整源码提交到 `origin/sub2api`，排除真实凭据、运行数据、依赖缓存、构建产物和重复源码备份。本次操作不部署、不重建容器。

## 已有优化

- `GATEWAY_OPENAI_WS_FORCE_HTTP=true`：Responses 使用 HTTP/SSE，避免当前代理路径上的 WebSocket 反复重连。
- `GATEWAY_OPENAI_HTTP2_ENABLED=true`：保留 HTTP/2 连接复用。`backend/internal/repository/http_upstream.go` 对长流启用 10 秒空闲 PING 和 5 秒 PING 超时，检测代理/NAT 静默断开的连接。
- 代理兼容错误在 60 秒窗口内达到 2 次后，允许回退 HTTP/1.1，回退有效期 600 秒。代理流熔断也配置为 2 次 / 60 秒 / 600 秒。
- 2026-10-12 只读检查到运行容器的连接池：每主机最大连接 2048、全局最大空闲连接 8192、每主机最大空闲连接 4096。Compose 未配置时的回退值仍为 1024 / 2560 / 120；运行值来自本机环境，不能据此声称适合所有机器。
- 显式透传调度配置：粘性队列长度 3、等待 120 秒，兜底等待 30 秒、队列长度 100；启用批量负载查询、过期槽位清理和调度缓存更新。
- 响应头超时设为 0，图片流保活间隔 10 秒，减少长推理/长流因本地等待限制而中断。

历史 2026-09-12 记录：优化前请求约 3.3 秒，优化后两次 Codex 请求分别为 1531 ms 和 1645 ms。请求内容并非严格相同，这些数值只是当时的功能与耗时观察，不构成受控性能对比。此次没有重跑付费模型请求。

Excel 桥接的终止事件及时返回已包含在当前 integration 源码。Prism 桥接的授权同步缓存和 403 等待预算优化位于另一个项目 `D:\Workspace\prism-bridge`，这里只保留既有记录，不将其误记为本仓库源码。

## 本次归档修正

- `.gitignore` / `.dockerignore` 排除本地密钥、运行目录、依赖缓存和旧副本；保留 integration 测试和项目构建辅助脚本。
- `CLIENT_SETUP.md` 中 6 处实际凭据替换为占位符；原件仅保留在忽略目录下。
- `docker-compose-gateway-env-test.sh` 明确本地部署的两个既有默认值：compact 模型 `gpt-5.4`、`GATEWAY_OPENAI_WS_FORCE_HTTP=true`；通用模板仍使用各自默认值。
- `deploy/docker-compose.optimized.diff` 刷新为历史原件到当前 Compose 的完整补丁，包括之后已有的源码镜像和 loopback 端口变更；这些不是本次新做的网络优化。
- `vendor_statekit` 按现有固定版本导入源码与许可证，不提交嵌套 Git 元数据或插件二进制。

## 验证与回滚

配置测试对照：BASELINE 退出 1（误判本地 compact 默认值）；MODIFIED 退出 0，输出 `docker compose Gateway environment test passed`；在独立副本执行回滚后退出 1，恢复相同报错且 SHA256 与原件一致。

历史 Compose 原件、当前 Compose 和回滚副本均通过同一组虚拟环境输入的 `docker compose config --quiet`，退出 0、stdout/stderr 为空；补丁可重建当前文件，回滚原件 SHA256 为 `54b2842063914cc4452bfaed6a9c600d0a8ebf07c508f4df1b08f32002df1155`。运行容器只读检查为 `healthy`。

首次推送被 GitHub 检测到的上游内置 Google OAuth 凭据拦截。随后移除了源码及测试中的实际凭据，客户端 ID 改为从启动环境读取，Secret 使用已有环境配置入口；Gemini 缺少 ID 或 Secret 时返回配置错误。Compose 模板已透传这四个变量。新部署如使用 Google OAuth，需在私有 `.env` 中配置 `GEMINI_CLI_OAUTH_CLIENT_ID` / `GEMINI_CLI_OAUTH_CLIENT_SECRET` 及 `ANTIGRAVITY_OAUTH_CLIENT_ID` / `ANTIGRAVITY_OAUTH_CLIENT_SECRET` 的对应值。现有运行容器未重建。

隔离 Go 容器已通过两个 OAuth 包的完整 unit race 测试、相关 OAuth 服务与 HTTP/2/代理流熔断的定向 race 测试，以及后端服务器构建。首次检查中的旧 Secret 回退测试失败记录保留，已更新为验证缺少配置错误。并未运行整个项目的全量测试。

凭据检查对照：BASELINE 检出 3 处客户端 ID 和 3 处 Secret（退出 1），MODIFIED 均为 0（退出 0），独立副本经 `ROLLBACK.sh` 恢复后再次检出 3 / 3（退出 1），原始字节哈希一致。未绕过 GitHub 推送保护；仅修订尚未发布的本次提交。

沿用四个角色：`deploy/docker-compose.yml`、`deploy/docker-compose.optimized.diff`、`VERIFICATION.txt`、`ROLLBACK.sh`。完整命令、stdout/stderr、退出码及补充记录位于 `.codex/git-publish-20261012/`。
