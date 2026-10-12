# Local account-30 directed model diagnostics (2026-09-21)

- [x] Confirm local-only target and account 30's original credential hash; preserve schedulable=false.
- [x] Test account 30 directly with its own ticket, without a ticket, and with account 31's existing ticket; all HTTP 200/completed but response.model=gpt-5.6-luna.
- [x] Test account 31 credentials with account 30's ticket in an isolated request profile; HTTP 200/completed, actual gpt-6-astra in 2.465s. This uses upstream identity 31 and is not a live gateway account-30 routing success.
- [x] Verify unchanged database credentials/settings/container and byte-identical request-descriptor copy rollback; reopen artifacts.

The previous SQL-copy/restart test did not exclude Redis OAuth cache effects. Source inspection shows application restart does not clear that external cache. A real future credential replacement should use the normal admin update/cache invalidation path. No live replacement was performed in this run.

Evidence: `.codex/account30-background-20260921/VERIFICATION.txt`.

---

