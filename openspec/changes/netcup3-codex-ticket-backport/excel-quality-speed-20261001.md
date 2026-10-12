# Excel bridge response fidelity and completion latency

The operator asked to remove Excel bridge limitations and improve perceived
quality and request speed. TARGET stays the current local integration:
`integrations/excel-codex-bridge/src/excel_codex_bridge/server.py`.
Its original bytes are preserved. The reviewed candidate is
`.codex/excel-quality-speed-20261001/MODIFIED_FILE.py`.

## Observed problems and candidate behavior

- `Bridge.responses`: unsupported explicit reasoning efforts previously fell
  through to medium. Return `400/unsupported_reasoning_effort`; supported
  low/medium/high/xhigh and existing spelling aliases retain their wire value.
- `Bridge._non_stream` and new `_validated_stream`: compare an observed model
  with the actual upstream request, accepting known native/Excel/1m aliases.
  Mismatches become `502/upstream_model_mismatch` or streaming `response.failed`.
  Nonstream success retains the reported upstream model instead of relabeling it.
  A missing upstream identity is not proof of matching; nonstream does not invent it.
- `Bridge._send_with_pictures`: retain inline-to-upload compatibility, but reject
  removed image input with `422/image_input_unavailable`. Refused uploads keep the
  provider failure instead of another image-free inference attempt.
- `Bridge._read_completed_payload` and `_validated_stream`: stop at a valid
  terminal event, release the connection, and do not wait for transport EOF.
  Truncated streams emit an explicit failure instead of generating completion
  from finished items. Nonstream incomplete payloads are errors.

## Evidence

52 candidate contracts pass; the original and rollback copies each reproduce
45 failures / 7 passes under the identical new contracts. The deterministic EOF
fixture delays transport closure by 120ms: baseline/rollback consume it, candidate
does not. This is not a measurement of live provider inference speed.

122 compatibility tests / 23 subtests pass with candidate-path/hash assertions.
The copied test fixtures were corrected to return the requested model rather
than always gpt-5.6-sol; two expected aliases now use the actual provider name.
The original fixture run's 14 failures and the precise fixture diff are retained.
Existing authentication, model routing, HTTP/SSE retry limits, session isolation,
tool conversion, usage and compression contracts remain covered.

Focused Go race tests and a full server build pass against current backend
sources, mounted read-only with disposable build output. No Go source changed.
The unified diff reconstructs candidate bytes. Executable self-contained
ROLLBACK.sh restores pristine bytes on a separate copy, and the same behavior
probe reproduces baseline. Original source SHA256:
`e4fe9c624846438ef1fbe5cf34f7e1edec9c4225d336ccf45cac98b6d83033e7`.

## Live observations and remaining limits

Read-only local state: accounts41/48 are active but unschedulable;50/52 are error
and unschedulable. Their state was not changed. In the last24h, account41 Sol's
22 recorded requests have median first-token time2575ms; Astra's138 have
median4746.5ms and p95 11222.95ms. These differing workloads are not an A/B test.
The logged model mismatch flags (41:1,52:21) are native versus `-excel` alias
differences, not evidence of a weaker model. Existing response relabeling also
means old logs cannot independently prove the actual provider identity.

No provider inference, ticket capture, credentials update, account activation,
production settings write or deployment was performed. Frontend, audit and proxy
topology were not changed. Upstream quota, entitlement, native tool semantics,
supported reasoning levels, accepted file formats and context limits cannot be
unlocked by this patch. Tool outputs already streamed before a late model mismatch
cannot be retracted; clients must honor the terminal failure.

The initial candidate-only state above is superseded by the authorized follow-up
below. All four roles and literal execution evidence remain under
`.codex/excel-quality-speed-20261001`.

## Shared installation and source53 test bridge

The operator authorized a new bridge from source53 and explicitly required a
shared implementation reusable for later accounts. Installed the verified server
in the common package, added `Dockerfile.runtime` and `bridge_accounts.py`, and
moved the regression fixtures into portable integration tests. The helper accepts
any positive source ID, separates each instance/session/API and admin keys,
validates OAuth identity/expiry, uses the common model catalog, and activates only
after a completed identity-matching provider response. Create/sync/activate/status
and explicit remove are separate actions. Source53 is a fixture selection, not a
runtime special case.

Built `excel-codex-bridge:quality-20261001`. Created bridge account54 from existing
OAuth53, with root URL `http://excel-codex-account53:8000`, group9 only, and a
separate healthy container. Active/schedulable after a successful provider probe.
The shared source, delivery artifact and deployed server SHA256 are identical:
`0b7c543054237e557be58ebf25a86f2707a8c41ebce65e8b6f5c9816bcd45397`.

190 Python tests /23 subtests pass; the same-task focused Go race/full build
success preceded deployment, with no subsequent Go changes. Real normal and
streaming Sol requests complete, the account54 admin model-test SSE succeeds,
and a high-effort function call/result continuation returns84 from83+1.
One same-source paired text sample measured old7057.39ms/new3315.28ms. The
samples are sequential, include different process warmup, and cannot establish
sustained speed improvement. The new normal samples ranged2487.37–4105.72ms.

The first image prompt disclosed the answer and is not treated as accuracy
evidence. The neutral prompt uses a byte-validated64x64 red/blue PNG. Both old
and new bridge images returned RED CYAN, so image recognition accuracy remains
unresolved. This differs from the fixed local behavior that previously omitted
an image after upload errors. The disposable same-source control was removed.

Normal billed gateway verification stopped before key creation because the
authenticated administrator (user1) has zero balance. No balance or existing key
was changed. The successful pinned account54 admin test is not mislabeled as a
normal usage-log success.

Credentials/scheduling of41/48/50/52/53, existing container identities and global
settings match the pre-deployment snapshot. Full account metadata projection
hashes48/53 changed during work; exact metadata causes were not established and
no restoration was attempted. The first strict full-state comparison failed and
is retained in task records; the final check states its narrower verified scope.
No ticket harvesting was enabled. Original server bytes remain in BASELINE_FILE.py;
copy rollback reproduces original behavior while the shared deployed repair stays
installed. Added-file manifest and fixture patches supplement the same four roles.
