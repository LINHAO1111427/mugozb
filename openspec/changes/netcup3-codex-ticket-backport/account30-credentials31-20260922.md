# Local account 30 complete credential update (2026-09-22)

- [x] Preserve original account-30 credentials and source account-31 snapshots under private ACLs.
- [x] PUT account-31 complete credentials to local account 30 through the admin API; HTTP 200.
- [x] Delete oauth:token:openai:account:30 (DEL=1, immediate EXISTS=0).
- [x] Verify direct Astra completion and normal /v1/responses completion on account 30. Exact usage 14871: requested/returned gpt-6-astra, 2.159s; Redis matches new token.
- [x] Remove isolated test session, verify original-credential copy rollback, reopen four artifacts and retain new live credentials.

Account 30 remains active/schedulable with account 31's upstream identity; settings, existing ticket fields and application uptime are unchanged. Evidence: `.codex/account30-credentials31-20260922/VERIFICATION.txt`.

---

