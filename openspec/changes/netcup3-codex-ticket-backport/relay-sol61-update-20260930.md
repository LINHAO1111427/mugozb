# Local relay GPT-6.1 Sol support

The local relay keeps the PR7315 backport and gains the exact `gpt-6.1-sol` model in its default catalog, model selection, native alias normalization, Codex reasoning/context metadata and token pricing. `gpt-6-sol` remains a separate identity. Official reference: https://developers.openai.com/api/docs/models/gpt-6.1-sol.

The operator requested the local program update. Only the local app image will be replaced after focused race tests and builds; remote production frontend, audit/proxy topology and harvesting settings are preserved. Existing account48 mapping may gain the exact requested Sol names while retaining complete credentials. Account41's externally observed disabled scheduling state remains preserved.

The original image is tagged `sub2api-local:pre-sol61-20260930`; the private consistent database backup passes pg_restore listing. All 286 applied SQL checksums match the source and no new migration is pending. Baseline regression tests reproduce the old behavior. Implementation and live validation are complete: focused race tests, frontend checks/build, server build and copy rollback passed. Local app is 0.2.5-ticket7315-sol61; /v1/models lists both models. 6-sol completes; 6.1 reaches upstream and receives explicit400 unsupported ChatGPT-account model. Settings/topology and account48 non-mapping credentials remain unchanged.

Artifacts: `.codex/relay-sol61-update-20260930`.
