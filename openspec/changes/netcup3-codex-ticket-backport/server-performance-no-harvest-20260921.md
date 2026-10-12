# Server performance and no harvesting ? latest user instruction

The user explicitly requested server-only optimization on 163.7.10.75, maximum sustainable concurrency for current hardware, and no more ticket harvesting. This supersedes the historical enable-harvesting instruction. Local relay runtime/configuration was not changed.

The live server had already moved to official Sub2API 0.2.7 (revision aea725f2ea644d5592d0bbb1d63b607efa7e200a) plus STATE Kit 0.3.4. Disabled the plugin through its management API, persisted enabled=false and auto_harvest=false, and set legacy openai_codex_ticket_enabled=false. Verified no plugin process across recreation. No real provider load or ticket probes.

Measured hardware: 2 vCPU, 1966 MiB RAM, 4095 MiB swap; app limit 640 MiB, PostgreSQL 512 MiB/max_connections=100, Redis 128 MiB. Existing user limit 5 and only active account limit 10 caused admission queueing. Oversized default pools were bounded: SQL 32/8, Redis 64/8, usage workers 8?16 with sync overflow, GOMEMLIMIT=384MiB, GOMAXPROCS=2, bounded upstream connection pools. User 1, account 17 and default concurrency are now 128. Only the application was recreated, at an observed zero-active-stream moment; image/frontend, dependency start times, proxy/network/port topology and account/key/group bindings were preserved.

Official matching source passed focused -race tests and server build. On-server isolated SSE benchmark: original 16-worker test peaked at 5 upstream streams with p95 13.2791s; tuned identical workload peaked at 16 with p95 2.2488s. 128 long streams with 256 KiB inputs/10s duration completed 256/256. 256 short streams also completed, but p95 and available-memory pressure favored 128 as the operating tier. All 1920 requests and accounting rows were confirmed; test containers/database/listener removed. Provider quotas are not established by mock tests.

Exact original files/settings and consistent database dump were preserved privately. Copy rollback restores byte-identical original Compose and 5/10 quotas; isolated runtime rollback again reproduced 5 upstream streams. Live rollback restores performance settings only and keeps all harvesting disabled. Local evidence: .codex/server-performance-20260921. Server evidence: /opt/sub2api/releases/performance-20260921.

Later real traffic returned token_revoked for account 17 at 13:01:40 CST. It became error/unschedulable, leaving zero active provider accounts; accounts 15/16 were already invalid. Read-only comparison against the original database backup confirmed no other field drift in protected account/key/group/proxy fields. Harvesting remained off and post-recreation logs contained no harvest lines. Revocation cause is unproven; fresh valid provider credentials are required for real inference. This failure is recorded separately from gateway performance and health.

## Later explicit local ticket export request

The user subsequently requested exporting the current local account tickets. This permits read-only local inspection/export without restarting harvesting or changing local/server settings. Identified account 29 on localhost:8088 from current usage, exported its two existing 332-character Astra/Sol tickets, preserved original hashes and verified exact bytes plus temporary-copy cleanup. Configured expiry: 2026-09-21 19:01:32 CST; no upstream validity probe. Evidence: .codex/local-ticket-export-20260921/VERIFICATION.txt. The server no-harvesting instruction remains in effect.

## Account-29 to account-30 ticket test

At the subsequent user request, account 29's current unexpired gpt-6-astra ticket was conditionally copied to local account 30 and tested once. The first request was blocked by account-1 zero balance; the bounded group-2 retry completed HTTP 200 with TICKET30_OK but reported gpt-5.6-luna (model mismatch). Account 30's original ticket was restored and the same later comparison also returned Luna. No cross-account Astra success is claimed; no ticket remains cross-installed. Evidence: .codex/local-ticket-transfer-20260921/VERIFICATION.txt.
