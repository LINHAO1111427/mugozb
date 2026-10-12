# Sub2API 本机中转站 · 客户端接入手册

> 本机已经有一台 Sub2API AI API 网关（**中转站**）。本手册讲清楚 Codex CLI / Codex 扩展 / 任何 OpenAI 兼容客户端怎么指向它。

---

## 1. 服务现状（实时）

| 项 | 值 | 备注 |
|---|---|---|
| **中转站入口** | `http://127.0.0.1:8088` | 只绑 loopback |
| **后台登录** | `http://127.0.0.1:8088/login` | 邮箱 `admin@sub2api.local` / 密码 `<ADMIN_PASSWORD>` |
| **Anthropic 兼容路径** | `http://127.0.0.1:8088/v1/messages` | 给 Claude Code 用 |
| **OpenAI Responses（Codex 主路径）** | `http://127.0.0.1:8088/v1/responses` | 给 Codex 用 |
| **OpenAI Chat Completions** | `http://127.0.0.1:8088/v1/chat/completions` | 给任意 OpenAI SDK 用 |
| **Codex 直连** | `http://127.0.0.1:8088/backend-api/codex/responses` | Codex CLI 特殊路径 |
| **OpenAI 风格 Models** | `http://127.0.0.1:8088/v1/models` | 列模型 |

---

## 2. 已为你建好的一份配置

### ✅ 后台分组（Admin → 分组管理）

| id | name | platform | 用途 |
|---|---|---|---|
| 1 | `default` | anthropic | 留给 Claude / Claude Code |
| **2** | **`codex`** | **openai** | **留给 Codex 与一切 OpenAI 客户端** |

### ✅ API Key

```
Key:    <SUB2API_API_KEY>
Name:   codex-local
Group:  codex (openai)
Status: active
```

密钥全权：sub2api 平台口径「sk-…」开头是这个 Key，**不是** OpenAI 官方签的。泄露后在后台一键 revoke。

### ⏳ 你接下来要做的：导入上游账号

sub2api 是**空抽屉**——它需要你给它"会聊天"的账号配额才能把请求转出去。目前**已建分组 + Key，但 `Accounts` 列表还是 0 条**。

打开浏览器 `http://127.0.0.1:8088/`，admin 登录，依次操作：

1. 左侧菜单 → **账号管理**
2. 点 **添加账号**
3. 平台下拉选 **`OpenAI / Codex`**（你的 `codex` 分组绑的就是 openai）
4. 账号类型：按你手头的资源二选一
   - **OAuth**：点生成授权链接 → 复制到浏览器打开 → 登录你的 ChatGPT/Codex 账号 → 拿到 callback 字符串 → 粘回 sub2api 完成授权
   - **API Key**：直接粘贴你的 `sk-...` OpenAI API Key
5. 勾选加入 `codex` 分组（**不勾选**就是孤账号，永远不会被中转站选中）
6. 保存

> OAuth 是把"你的 ChatGPT Plus/Pro 订阅"转给中转站用。API Key 是用"你的 OpenAI 计费账户"按 token 扣钱。

---

## 3. 本地 Codex CLI 接入（两种姿势）

### 姿势 A：Codex CLI（命令行）

Codex CLI 读 `OPENAI_BASE_URL` 和 `OPENAI_API_KEY` 两个变量：

```bash
# Linux / macOS
export OPENAI_BASE_URL="http://127.0.0.1:8088/v1"
export OPENAI_API_KEY="<SUB2API_API_KEY>"

# 验证
codex --help    # 应正常列出子命令
```

> Windows 直接 `set` 写在 cmd / PowerShell 里也行，或者放进 Codex CLI 的配置文件（`~/.codex/config.toml`，字段是 `OPENAI_BASE_URL` / `OPENAI_API_KEY`，同义）。

### 姿势 B：VS Code Codex 扩展

1. 打开 VS Code → Codex 扩展设置
2. 把 "Custom OpenAI Base URL" 设为 `http://127.0.0.1:8088/v1`
3. 把 "OpenAI API Key" 设为上面那串 sk-...
4. 重启 VS Code 让扩展重读

### 姿势 C：任意 OpenAI 兼容客户端（Cursor / Cline / Continue 等）

```yaml
# 通常是这几个字段（取决于客户端 UI）
Base URL:  http://127.0.0.1:8088/v1
API Key:   <SUB2API_API_KEY>
Model:     从 /v1/models 列出的清单里挑
```

### 姿势 D：Claude Code 走 Anthropic 兼容

如果你想用同一套中转站处理 Claude 调用：

```bash
export ANTHROPIC_BASE_URL="http://127.0.0.1:8088/v1"
export ANTHROPIC_AUTH_TOKEN="<SUB2API_API_KEY>"
# 想要更安全地隔离：让 admin 单独建一个 key 绑到 default 分组（anthropic）
```

---

## 4. 故障排除（先看这里再问）

| 现象 | 原因 / 修复 |
|---|---|
| `/v1/models` 返回 403 INSUFFICIENT_BALANCE | Key 已被 sub2api 接受，但**还没绑任何上游账号**——去后台账号管理导入账号 |
| `/v1/chat/completions` 返回 404 | 该路径只在 sub2api 判定是 anthropic 分组时才有意义；绑到 codex/openai 用 `/v1/responses` |
| Codex CLI 走默认 "codex" 模型没响应 | 模型名在中转站支持清单内；先跑 `GET /v1/models` 看 schema，sub2api 会按账号池返回可用模型 |
| 中转站外网访问不到 | 设计如此，只绑 `127.0.0.1`；远程客户端需 SSH 端口转发 / VPN / Tailscale Funnel |
| 连接超 3 秒就在转 | 网络层 OK 但 codex 子账号被上游限流，sub2api 会 sticky-session 自动切下一个账号；如反复，删单条账号或换账号池 |

---

## 5. 重启后状态保留

所有"实例数据"都落在 docker 命名卷 + Postgres，不在主机文件系统。所以**重启 sub2api 容器不会丢任何东西**：

```bash
# 仅重启应用
"C:\Program Files\Docker\Docker\resources\bin\docker-compose.exe" -f "D:\workspace\sub2api\deploy\docker-compose.yml" restart sub2api

# 完全重建（数据卷不动）
"C:\Program Files\Docker\Docker\resources\bin\docker-compose.exe" -f "D:\workspace\sub2api\deploy\docker-compose.yml" up -d --force-recreate sub2api

# 销毁（⚠️ 所有 Admin 账号 / 用户 / 用量都没了）
"C:\Program Files\Docker\Docker\resources\bin\docker-compose.exe" -f "D:\workspace\sub2api\deploy\docker-compose.yml" down -v
```

---

## 6. 端口速查

| 容器 | 宿主绑定 | 用途 |
|---|---|---|
| sub2api | `127.0.0.1:8088` | 主入口 |
| sub2api-postgres | `127.0.0.1:55433` | 本机直连 Postgres（Navicat/DBeaver 用） |
| sub2api-redis | `127.0.0.1:56379` | 本机直连 Redis（RedisInsight 用） |

宿主 PostgreSQL 直连信息：

```
host:     127.0.0.1
port:     55433
user:     sub2api
password: <POSTGRES_PASSWORD>
database: sub2api
```
