# Backport PR 7315 to Netcup3

The user requested integration of Tinghecui's Codex turn-state ticket branch.
That deleted branch is preserved at upstream PR 7315 head 3c2f05c9.
Apply only its 61-file delta onto the running 0.2.5 source (86f93c28).

The upstream main branch has dropped this merge. Its withdrawal reason is
unverified; retain the source and provenance for independent maintenance.

Keep harvesting disabled and do not issue synthetic production requests.
Do not publish the changed frontend over the separately customized static
frontend. Do not alter account bindings, proxies, audit or Guardian.

Validate ticket state isolation, lifecycle, disabled behavior, settings
redaction and gateway compilation. Deployment requires rollback artifacts,
a consistent database backup and post-deployment health verification.
