# Account 41 bridge / Sol routing repair (2026-09-30)

- [x] Inspect Git/OpenSpec, current accounts/groups and preserve source hashes.
- [x] Configure exact gpt-6-sol and gpt-6.1-sol bridge aliases with the root upstream URL.
- [x] Share a two-retry HTTP/SSE budget; preserve provider errors and avoid whole-account penalties for model access errors.
- [x] Add token sync/routing repair, preserving all credential metadata and activating only after a completed probe.
- [x] Pass 122 Python tests / 23 subtests, focused Go race tests and full server build.
- [x] Deploy only account41's sidecar; verify gateway 200/completed for gpt-6-sol, usage32881 account41, and streaming completion.
- [x] Test executable copy rollback; record metadata recovery, limitations, source hashes and final state.
- [ ] Verify a successful gpt-6.1-sol provider response. Current source48 is denied: Model access has changed. Local mappings are enabled; provider access remains pending.

Current (2026-09-30 14:55 +08:00 retest): account41 active, schedulable=false in groups2/9; this state was observed before probing and left unchanged. Account48 remains the same token identity; non-secret metadata was rebuilt from its existing JWT claims after a partial-update correction. Source51 was already deleted and account52 remains disabled with revoked-token error. Evidence: `.codex/sol-models-20260930/VERIFICATION.txt`.

---

See the verification report for exact commands, failed intermediate attempts, source48 metadata recovery and provider restrictions. No production frontend, audit, proxy or harvesting configuration was changed.

- [x] Retest 6.1 through bridge and group2 gateway: bridge model_not_supported, gateway404; same-session 6-sol control completed. Evidence: `.codex/sol61-retest-20260930/VERIFICATION.txt`.

## Authorized session recovery (2026-10-01)

- [x] Diagnose unconfigured memory session after container start; reproduce401 and preserve the existing source48 identity.
- [x] Reimport48's existing session, require200/completed before clearing41 error and enabling scheduling.
- [x] Confirm actual normal gateway usage35794/account41 and successful streaming response; preserve credentials, mappings, groups, settings and container identities/start times.
- [x] Extend/reopen the same four roles, verify patch reconstruction and self-contained offline descriptor rollback with original hash.

Current41:active/schedulable, session configured/unexpired. No program deployment
or restart. Startup automatic resync remains unimplemented. Other model access
is not established by this Sol control. Evidence:
`.codex/account48-bridge41-20260929/VERIFICATION.txt` (authorized follow-up).
