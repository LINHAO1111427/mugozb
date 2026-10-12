# Local gateway concurrency validation

The user requests local performance optimization before a later server deployment. Preserve the completed STATE Kit integration and remote topology. No remote commands or production configuration mutations are part of this task.

Observed starting point: local administrator concurrency=5, default.user_concurrency=5, no provider accounts. Gateway admission uses the authenticated user's concurrency and then the selected account's concurrency. STATE Kit harvesting has a separate four-job semaphore; it does not impose that semaphore on forwarded requests. Historical deployment files show a 640 MiB application limit, 512 MiB PostgreSQL, 128 MiB Redis, and PostgreSQL max_connections=100. Current host defaults (256 SQL connections, 1024 Redis pool entries, 128-512 usage workers) exceed the appropriate pool budget for that deployment.

Use dedicated local fixture user/group/account/API key and an asynchronous local SSE upstream. Reproduce the five-slot admission limit, then increase bounded quotas and test staged concurrent streams with completion validation, upstream active-request measurements, latency percentiles, errors, memory, and connection reuse. Separately exercise the real signed plugin transport at parallel loads. Local fixtures establish gateway capacity, not provider quota or successful real ticket collection.

Deliver a reusable workload, measured configuration with bounded memory/connection pools, explicit targeted quota updater with snapshot/rollback, focused race/build evidence, and deployment guidance. Keep audit/usage recording intact. Do not enable automatic harvesting. Baseline, modified and rollback evidence must distinguish quota tuning, runtime tuning, plugin transport and external proxy failure.
