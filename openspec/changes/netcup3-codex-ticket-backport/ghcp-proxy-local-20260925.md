# Local GHCP Proxy integration

Requested on 2026-09-25: explain Nonary/ghcp_proxy and integrate it with Sub2API.
Pinned source: 1a73157d579dcdaa08d8ecbcd166e80ca48c9e66 (Unlicense).

User follow-up explicitly requested both GitHub Copilot and ChatGPT Excel.
Use existing OpenAI API Key upstream accounts with independent provider groups.
The authenticated ASGI wrapper routes /v1 to Copilot and /excel/v1 to Excel.
It validates model ownership, filters Excel aliases from the Copilot catalog,
preserves request bytes/chunks and streaming events, blocks inference aliases,
and checks each provider's own login state. Excel never requires GitHub login.

The Windows service binds 127.0.0.1:8000. The existing local Sub2API container
can reach it at host.docker.internal:8000 (verified with a temporary listener).
GHCP data stays under integrations/ghcp-proxy/.runtime. The lifecycle now loads
the official Excel add-in's existing cached session, with DPAPI persistence on
Windows. Native-client trace ingestion, upstream auto-updates and client-settings
rewrites remain disabled. Excel supports models, Responses and compact routes;
direct Excel Chat Completions/Messages paths return 404.

Preserve Copilot group 5/account 37; add Excel group 9/account 41. Both are
inactive and unschedulable pending their respective logins. Activation checks
provider readiness and model catalogs independently; Excel's four aliases are
configured identifiers, not proof of provider entitlement. Existing frontend,
ticket harvesting, production settings and proxy topology are retained.

Validation: disabled/enabled ASGI fixtures; eight provider routes; all four
readiness combinations; expired Excel sessions; isolated model catalogs;
chunked tool payload preservation; incremental SSE and cancellation; provider
errors; pinned Excel handlers against mock HTTP (4 aliases x 3 request types);
both local Sub2API Responses streams through Docker-to-host; source-copy rollback.
The initial focused Go race tests/server build passed; no Go changes followed.

Verified: initial and dual-provider fixture/build/rollback checks passed. Local
dashboard HTTP 200. Follow-up GitHub authorization completed, but the SDK model
list returned a provider 403, surfaced as local HTTP 502. The standard entitlement
endpoint confirms chat_enabled=false and access_type_sku=no_access; the standard
token exchange returns HTTP 403 / No access to GitHub Copilot found. Activation
stopped before any account update. Copilot account 37 remains inactive and
unschedulable with its original model mapping. Excel remains unconfigured.
Copilot entitlement and real-provider inference are pending. Diagnostic evidence:
.codex/ghcp-proxy-activation-20260925/VERIFICATION.txt.
Evidence: .codex/ghcp-proxy-dual-20260925/VERIFICATION.txt supersedes the initial
Copilot-only integration evidence. Account 37's full configuration and the
Sub2API container identity match the before snapshot. An unrelated live account
35 snapshot drifted during checks; its snapshot includes volatile usage metadata,
and no task action wrote that account. The exact drift cause is not established.
