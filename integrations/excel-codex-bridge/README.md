# Excel Codex Bridge + current Sub2API

## Shared repair and independent source accounts (2026-10-01)

The quality/completion fixes now live in the shared `src/excel_codex_bridge/server.py`.
They apply to every account using an image built from this source. An account ID
does not change reasoning, model checks, image handling or stream completion logic.
Existing containers keep their current images until deliberately upgraded.

Build the same shared runtime once, using the locally installed dependency image:

```powershell
docker build --network none -f integrations/excel-codex-bridge/Dockerfile.runtime -t excel-codex-bridge:quality-20261001 integrations/excel-codex-bridge
```

Create an isolated bridge from an existing local OpenAI OAuth source. Replace53
with the chosen source ID; explicitly select the destination group. `create`
imports only that source session into memory and registers the new account
inactive/unschedulable. `activate` requires an actual completed, model-matching
probe before it enables that new account:

```powershell
python integrations/excel-codex-bridge/bridge_accounts.py create --source-account-id 53 --group-id 9
python integrations/excel-codex-bridge/bridge_accounts.py activate --source-account-id 53 --probe-model gpt-6-sol-excel
python integrations/excel-codex-bridge/bridge_accounts.py status --source-account-id 53
```

Source53 was connected to new bridge account54 in test group9. Its independent
container is `excel-codex-account53`; normal/streaming sidecar responses and the
pinned Sub2API admin test completed with actual `gpt-6-sol`. A real high-effort
tool call and tool-result continuation returned the correct fixture result84.
Full gateway-key billing was not tested: the authenticated administrator's
balance was zero. No balance was changed and no temporary key was created.

Sessions remain memory-only. After a container restart or source OAuth refresh,
reload that same source explicitly:

```powershell
python integrations/excel-codex-bridge/bridge_accounts.py sync --source-account-id 53
```

Per-source descriptors and separate API/admin keys live in the ignored
`.runtime/accounts/<source-id>` directory. OAuth tokens are never saved there.
The helper preserves the source account and refuses an existing container or
account managed by another integration. Existing old instances need a reviewed
migration; they are not silently taken over. The default is the current direct
network path; this helper does not copy or change another instance's proxy.

Explicit rollback of a newly managed bridge (this deletes its gateway account
and container, leaving its OAuth source and shared groups intact):

```powershell
python integrations/excel-codex-bridge/bridge_accounts.py remove --source-account-id 53
```

The shared implementation reports unsupported reasoning efforts rather than
silently lowering them, reports model mismatches, refuses image-free fallback,
and releases responses at the terminal SSE event. These changes do not grant
provider entitlement or quota. The neutral color fixture was misidentified by
both the old and new images; image recognition accuracy is not claimed fixed.
Live timings varied and the single paired comparison is not a sustained speed
benchmark. See `.codex/excel-quality-speed-20261001/VERIFICATION.txt`.

Run the portable integration suite with `python -m pytest -q
integrations/excel-codex-bridge/tests` in an environment with the test dependencies.

This is an optional sidecar integration for the deployed `docker-compose.sub2api.yml` stack.
It packages `Kaixxrua/excel-codex-bridge` at revision
`9254d3f25b0323bbf71db4f25a242fe32027a544` and exposes its Responses-only sidecar on the
same Compose network. Sub2API remains the client-facing relay, scheduler, quota and usage
boundary; the sidecar only holds one explicitly imported Codex/Excel session in memory.

The integration is disabled by default. It does not register an account, start a container,
enable harvesting, or alter existing settings until the corresponding command is run.

## Prepare and start

From the repository root:

```powershell
python integrations/excel-codex-bridge/manage.py prepare
python integrations/excel-codex-bridge/manage.py init-secrets
docker compose -f deploy/docker-compose.yml -f deploy/docker-compose.excel-codex.yml --profile excel-codex up -d --build excel-codex-bridge
```

The optional service has no published host port. It is reachable by the main relay as
`http://excel-codex-bridge:8000/v1` on `deploy_sub2api-network`. The API key and admin key
are separate random files under `.runtime/secrets/` and are ignored by Git.

## Import a session and register the relay account

Run the following only after signing in with Codex or the Excel ChatGPT pane on this machine:

```powershell
python integrations/excel-codex-bridge/manage.py sync-session --login auto
python integrations/excel-codex-bridge/manage.py configure-existing
python integrations/excel-codex-bridge/manage.py status
```

The integration reuses the existing `GHCP ChatGPT Excel (local)` account 41/group 9. The
configuration command keeps it inactive and unschedulable; it never probes the provider or turns
the account on. After `session-status` reports a configured, unexpired session, activate it
deliberately:

```powershell
python integrations/excel-codex-bridge/manage.py activate
```

Activation only updates the integration-owned account's model mapping/status. The twelve aliases
are the sidecar's configured Excel aliases, including the `-1m-excel` variants. No synthetic
inference request is sent.

To remove only this integration's account and empty group:

```powershell
python integrations/excel-codex-bridge/manage.py remove
```

Stop the optional service with `docker compose ... --profile excel-codex stop
excel-codex-bridge`. The session is memory-only and disappears when the sidecar stops.

The sidecar source and tests retain the upstream Unlicense. `LICENSE`, `UPSTREAM-LICENSE` and
`UPSTREAM_REVISION.txt` record the provenance.


## Account 41 recovery and Sol model routes (2026-09-30)

The local account-41 upstream URL is now `http://excel-codex-bridge:8000`.
Both `gpt-6-sol` and `gpt-6.1-sol` map to their matching `-excel` aliases;
no alias substitutes a different upstream model. Account 41 retains groups 2/9.

The configured source is local OAuth account 48. Import and recover it with:

```powershell
python integrations/excel-codex-bridge/manage.py sync-account --source-account-id 48
```

`sync-account` reads redacted account metadata through the admin API and reads
only the selected local source token from PostgreSQL into process memory. It
imports the token through Docker stdin, repairs the root URL and mappings, and
clears old errors/cooldowns and restores scheduling only after a completed probe.
Tokens are not written to task artifacts. The session remains memory-only;
repeat the command after a sidecar restart or source-token refresh.

A model whose provider quota is temporarily full can prevent that recovery
probe from completing. To check account health using a different configured
model explicitly, append `--probe-model gpt-6-astra-excel`. A successful health
probe does not establish access to every advertised model.

HTTP 408/425/429/5xx and pre-output SSE rate-limit failures share at most two
retries. Each delay is at most five seconds; a longer Retry-After is passed
through. A stream is not replayed after output starts. Non-streaming failures
retain the provider error code instead of becoming a missing-completion 502.
The provider's exact model-access-changed 403 is reported as a model-specific
400 with upstream_status=403, so it does not disable the entire gateway account.

Verified on 2026-09-30: gpt-6-sol completed through local port 8088 with usage
account_id=41, and the streaming bridge completed too. gpt-6.1-sol reached the
provider but was denied with "Model access has changed"; the local route exists,
but this source account currently has no verified provider access to that model.
