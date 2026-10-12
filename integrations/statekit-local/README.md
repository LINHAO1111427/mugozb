# 本地 STATE Kit 集成

入口：<http://127.0.0.1:18089/admin/plugins>。

本目录使用 Sub2API 0.2.7（`aea725f2ea644d5592d0bbb1d63b607efa7e200a`）与作者签名的 STATE Kit 0.3.4，加入作者的宿主适配及本地控制链路测试。宿主源码在 `host/`，分支为 `local/statekit-controls`。它与工作区原来的 PR 7315 服务分别使用镜像、端口、数据库和 Redis 卷。

已接入的控制：

- 按分组选择账号，查看账号名称；从 IP 管理选择代理或填写代理地址。
- STATE 总开关、每个账号的开关、手动查找、全部开启账号查找。
- 自动续期与补票、尝试次数、间隔、失败冷却和提前续期时间。
- 票据状态、有效期、尝试记录、出口检测、实际响应模型核验和停止模型测试。

新实例默认关闭 STATE 和自动采集，账号列表为空。按账号保存并开启后才会采集。状态刷新是只读操作。

## 启动

在本目录运行：

```powershell
python fetch-plugin.py
python prepare-local.py
docker build -f Dockerfile.checks -t sub2api:statekit-local . --progress plain
python start-local.py
```

首次从其他机器复现时，先运行 `python prepare-host.py`，再执行上述命令。

管理员是 `admin@statekit.local`，随机密码保存在本目录 `.env` 的 `ADMIN_PASSWORD`；脚本重复运行会保留密码和现有插件配置。

宿主首次使用要求管理员本人在控制台阅读并确认部署协议。若启动脚本显示 `Administrator acknowledgement pending`，在本地页面完成确认后再次运行 `python start-local.py`，脚本会安装签名插件、启动插件进程。它不代替管理员签署电子确认。

进入“插件管理 → STATE Kit → 配置”，设置代理，添加自己的 OpenAI OAuth 账号并选择套餐、模型。保存开关后点击“查找票据”；开启“自动续期与补票”后再保存即可自动续票。只有采集及业务出口复验通过才显示可用；HTTP 200 或票据长度单独不证明目标模型可用。

## 验证与维护

`Dockerfile.checks` 在生成服务镜像前执行宿主资源目录竞态测试、真实签名插件安装及进程联调、控制动作测试、前端目录测试、类型检查、前端及后端构建。`Dockerfile.plugin-tests` 对上游插件执行全量 `go test -race ./...` 和构建；`node --test ../../vendor_statekit/plugin/ui-tests/*.test.cjs` 执行插件 UI 测试。

控制测试通过本机 HTTP 代理桩验证手动触发、自动触发、关闭停止、重复动作去重、只读状态和停用插件拒绝动作。它不访问真实上游。插件引擎测试另用本机上游桩验证成功采票、复验、持久化及模型不匹配作废。

`prepare-host.py --output 新目录` 可从固定提交重建集成源码；`DIFF_FILE.diff` 包含全部宿主改动。Wire 重新生成时需保留 `NewPluginResourceDirectory` 的注入，位置见 `host/backend/cmd/server/wire_gen.go`。

完成首次确认和插件安装后，运行 `python verify-local.py` 验证实际控制 API。它要求空账号的新实例，检查开关保存、关闭时拒绝手动采集、资源/动作接口就绪，并恢复初始关闭配置。

实际页面检查：先执行 `npm install --prefix private/browser --no-audit --no-fund playwright-core@1.58.2`，再运行 `node verify-browser.cjs`（使用本机 Chrome）。它打开真实宿主的插件 iframe，检查分组、代理、手动/自动控制和日志，保存 `evidence/local-controls.png`。它不会代签管理员协议。

停止本实例：`docker compose -f compose.yml stop`。保留数据卸载容器：`docker compose -f compose.yml down`。`ROLLBACK.sh` 用哈希校验撤销指定源码副本中的本次适配；它不回退数据库或线上版本。

测试结果和限制见 `VERIFICATION.txt`。本地测试通过不等于已获得真实上游票据，实际票据还依赖账号授权、代理及上游响应。
