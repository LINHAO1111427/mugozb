# Local Sol61 client version configuration

The operator explicitly requested correcting local relay configuration for the
newly added `gpt-6.1-sol`. The existing exact model mapping was already present.
Account48 is Pro; its native Codex models response differs by client version.

With the same account credentials, version0.158.0 omits Sol61 from the upstream
catalog and inference returns HTTP400 with the reported ChatGPT-account error.
Official Codex release rust-v0.159.2 is published; version0.159.2 advertises Sol61
and inference completes with actual model gpt-6.1-sol.

Changed only settings.openai_codex_client_version_synced from0.158.0 to0.159.2.
After the existing60-second cache expired, cleared account48's sole model cooldown
(gpt-6.1-sol, caused by the preceding400) through the admin recovery endpoint.
Other account blocking fields were null. Preserved account credentials, model
mappings, scheduling state and every other settings value. Account41 remains
paused for scheduling; its separately served Excel upstream is unchanged.

Focused Go race tests and a full server build passed before the live settings
change. Gateway8088 now completes both regular and streaming Sol61 requests,
including a streaming request carrying the older local client0.155.0 headers;
the actual response model is gpt-6.1-sol and text is SOL61_CONFIG_OK. Sol6 control
also completes. No executable/image deployment was required.

Version rollback was tested on a separate descriptor copy, including replaying
its restored0.158.0 against upstream and reproducing the baseline400. Live
settings retain0.159.2. A live rollback entry point restores only the version,
not an expired runtime cooldown. Evidence: .codex/sol61-config-20260930.
