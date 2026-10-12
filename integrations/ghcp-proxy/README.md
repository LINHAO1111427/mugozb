# GHCP Proxy 接入 Sub2API：Copilot + ChatGPT Excel

[Nonary/ghcp_proxy](https://github.com/Nonary/ghcp_proxy) 把 GitHub Copilot 和官方 ChatGPT Excel 加载项的模型请求转换为兼容 OpenAI 的 API。它处理提供方登录、协议转换、流式响应、工具调用及用量面板；Sub2API 负责客户端 API Key、分组和账号调度。模型可用性与额度取决于各自上游账号。

链路：**客户端 → 本地 Sub2API（8088）→ GHCP（8000）→ Copilot / ChatGPT Excel**。

GHCP 是模型 API 适配层。原先 `socks connect ... EOF` 表示 SOCKS 连接过程中对端关闭了连接；该网络节点的协议、认证和连通性需要另行诊断，安装 GHCP 本身不会修复这个连接。

## 当前安装

固定上游提交：`1a73157d579dcdaa08d8ecbcd166e80ca48c9e66`，Unlicense。桥接代码在本目录，上游源码和独立虚拟环境在 `.codex/ghcp-proxy-20260925/upstream`。

| 上游 | Sub2API 账号 / 分组 | Docker 内使用的上游地址 | 登录来源 |
| --- | --- | --- | --- |
| GitHub Copilot | 37 / 5，GHCP Copilot | `http://host.docker.internal:8000/v1` | GHCP 管理页的 GitHub 设备授权 |
| ChatGPT Excel | 41 / 9，GHCP ChatGPT Excel | `http://host.docker.internal:8000/excel/v1` | Windows 官方 ChatGPT Excel 加载项的已登录会话 |

管理页：<http://127.0.0.1:8000/ui>；状态：<http://127.0.0.1:8000/health>。分别查看 `providers.copilot.ready` 和 `providers.excel.ready`；顶层 `authenticated` 保留旧的 GitHub 状态含义。`ready` 只表示本地凭据状态，真实推理仍需验证。

截至本次检查：两账号均 `inactive`、`schedulable=false`；GitHub 未登录，Excel `configured=false`、`cache_available=false`。账号、独立分组和接口已经配置完成。

上游 API Key 由本集成生成，保存在 `.runtime/bridge-key`，注册脚本自动写入两个新账号。提供方凭据留在 GHCP 的 `.runtime` 中；Excel 会话持久化使用上游提供的 Windows DPAPI。

## 完成登录和启用

在 `D:\Workspace\sub2api` 运行以下命令。

1. **Copilot**：打开管理页，用具有 Copilot 权限的 GitHub 账号完成设备授权，然后执行 `python integrations/ghcp-proxy/register.py activate --provider copilot`。
2. **Excel**：在本机 Excel 打开官方 ChatGPT 加载项并登录。在 GHCP 管理页读取缓存会话，然后执行 `python integrations/ghcp-proxy/register.py activate --provider excel`。普通浏览器中的 ChatGPT 登录不会自动成为 Excel 加载项会话。
3. 在 Sub2API 为所需分组创建或选择专用 API Key。客户端地址仍为 `http://127.0.0.1:8088/v1`，使用该分组的 Sub2API Key。

也可在两端登录后一起启用；一端未就绪时，脚本会继续处理另一端，并以退出码 1 报告尚未就绪的一端：

```powershell
python integrations/ghcp-proxy/register.py activate --provider both
python integrations/ghcp-proxy/register.py status
```

Excel 使用 Responses 接口，模型名保留 `-excel` 后缀：

```text
gpt-6-astra-excel
gpt-5.6-luna-excel
gpt-5.6-terra-excel
gpt-5.6-sol-excel
```

这些是固定版本支持的路由别名，模型目录不代表账号已获对应模型权限。Copilot 启用时从提供方读取实际模型列表，并过滤 Excel 别名。两条线路均检查模型归属；Excel 请求不依赖 GitHub 登录。

Excel 桥接入口支持 `/v1/models`、`/v1/responses` 和 `/v1/responses/compact`，外部路径加 `/excel` 前缀。直接调用该桥接入口的 Chat Completions / Anthropic Messages 返回 404。Sub2API 账号配置为 `force_responses`；本次验证覆盖 Responses 转发，未声称已验证客户端的每一种协议。

## 启停与状态

```powershell
python integrations/ghcp-proxy/manage.py prepare
python integrations/ghcp-proxy/manage.py start
python integrations/ghcp-proxy/register.py register --provider both
python integrations/ghcp-proxy/register.py status
python integrations/ghcp-proxy/manage.py stop
```

服务以隐藏后台进程监听 `127.0.0.1:8000`，日志在 `.runtime/service.log`。Windows 重启后运行 `start`。`register` 可重复执行，保留已有 Copilot 注册记录；所有命令支持单独管理一个提供方。

集成选择性加载 Excel 会话；原生客户端历史导入、上游自动更新及客户端配置改写保持关闭。凭据、缓存、日志和注册记录都在被 Git 忽略的 `.runtime` 内。Sub2API 容器、已有账号及生产服务保持原状。

## 验证与回滚

```powershell
.\.codex\ghcp-proxy-20260925\upstream\.venv\Scripts\python.exe integrations/ghcp-proxy/verify.py
.\.codex\ghcp-proxy-20260925\upstream\.venv\Scripts\python.exe integrations/ghcp-proxy/verify_upstream.py
.\.codex\ghcp-proxy-20260925\upstream\.venv\Scripts\python.exe integrations/ghcp-proxy/verify_sub2api.py
```

分别验证：双提供方鉴权、独立就绪状态、模型隔离、请求原文、流式和取消；固定上游 Excel 实现的 4 个别名 × 3 种请求；运行中 Sub2API 的两条 Responses 流式转发。后两项分别使用模拟 HTTP 提供方及临时 Sub2API 账号/分组，临时资源随测试清理。真实提供方调用仍待登录后验证。

本次完整源码包、差异、基线/修改/副本回滚记录在 `.codex/ghcp-proxy-dual-20260925/`。该目录的 `ROLLBACK.sh <目标源码目录>` 使用原始 SHA256 校验后恢复到 Copilot 单上游版本；先在副本验证，运行中的服务随后需要重启。脚本只处理源码，不处理数据库或凭据。

如需撤销 Excel 注册，先运行 `python integrations/ghcp-proxy/register.py remove --provider excel`；再按上述源码回滚流程操作。撤销全部注册可使用 `--provider both`。删除命令校验创建标记，已有其他绑定的分组会保留供人工处理。

基线阶段的 Go `-race` 测试（proxyurl/proxyutil/openai_compat）和后端构建已通过；本次追加仅修改 Python 集成层，复用同次任务的 Go 验证记录。
