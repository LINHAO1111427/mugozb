# Account49 Excel integration

The user explicitly requested connecting current local account49 to Excel, permitting a new account using its information. Created independent Excel sidecar and API-key account50 named ChatGPT Excel - account 49. It imports only source49 access_token and matching ChatGPT account headers into memory; original source49 credentials, account41 and existing containers are unchanged.

Account50 is active/schedulable, groups2/9 (matching existing Excel account), priority0, and advertises only the existing twelve exact Excel aliases. The existing built image and Docker network are reused; no host port, proxy, ticket-harvesting, frontend or audit changes. No Go binary is deployed.

Validation: original sidecar baseline HTTP401; new sidecar HTTP200/completed/EXCEL49_OK; real admin model-test flow succeeded for gpt-6-sol-excel. Intermediate TPM and 502 failures are recorded. The returned alias is normalized by the bridge and not independent underlying-model proof. Existing Python tests passed70 plus23 subtests. A separate descriptor rollback copy restored the original state; live account50 remains configured.

The session is memory-only and requires resync after container restart or source49 credential renewal: python .codex/excel-account49-20260929/task.py sync. Provider acceptance is verified for this test, not guaranteed indefinitely. Evidence and executable conditional rollback: .codex/excel-account49-20260929/VERIFICATION.txt and ROLLBACK.sh.
