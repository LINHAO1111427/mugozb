# Explicit authorization: enable automatic ticket harvesting

On 2026-09-20, the user instructed: “自动打票别关，开启”. This authorizes persistent
automatic harvesting on 163.7.10.75 and supersedes the earlier disabled-by-default
deployment instruction for this host. Keep it enabled unless the user directs otherwise.

The authenticated admin settings API enabled `openai_codex_ticket_enabled` and saved
the previously verified SOCKS5 proxy at 70.39.241.3:7081 as the dedicated harvesting proxy.
Proxy credentials remain in the server database, excluded from these records.

The running service captured and persisted format-valid 312-character tickets for account 15
(自用GPT), for both `gpt-6-astra` and `gpt-5.6-sol`. The admin API reports `ready=true`
and `blocked=false` for both. No application restart or source deployment occurred.

The existing partial-settings handler also changed two OIDC flags while OIDC was disabled.
Both were restored to their original effective values. Final settings comparison confirms
only the authorized harvesting settings differ. General proxy settings and Compose remain intact.

Rollback verification used a separate settings snapshot copy and left live harvesting enabled.
Evidence: `.codex/enable-ticket-20260920/VERIFICATION.txt` and `result.json`.

## Correction after actual Astra request verification

The later public gateway request sent `gpt-6-astra` but the upstream response reported
`gpt-5.6-luna` (usage record 26854). Astra effectiveness validation therefore failed.
The earlier direct Astra probe also reported Luna. HTTP 200, a 312-character header,
and `ready=true` establish capture and local format/TTL checks only; they do not
establish successful access to Astra.

The current harvester reads the response header without reading its body, then
labels the captured state with the requested model and assigns a local TTL. It does
not verify `response.model`. Whether the observed mismatch is caused by the state,
its use on the request, or upstream account/routing behavior remains undetermined.
Automatic harvesting remains enabled per the user's instruction. This correction
changes the verification conclusion only. Evidence:
`.codex/astra-gateway-20260920/VERIFICATION.txt`.


## Follow-up: local-ticket transfer and server capture

The user authorized trying the local gateway ticket on the server. With server
account 15 and the existing general HTTP proxy, the stored 312-character state
returned Luna, while local account 27's 332-character state returned Astra. A
request without a state also returned Astra. A fresh 292-character state captured
for server account 15 on that same proxy was replayed successfully as Astra.
These direct upstream tests used fresh session IDs and establish observed success
for the tested candidates, not a universal rule about ticket length or lifetime.
The freshly verified state is stored privately on the server. The live account
record and harvesting settings were left intact. Evidence:
`.codex/ticket-transfer-20260920/VERIFICATION.txt`.


## Live public gateway follow-up

The subsequent user request asked whether the deployed gateway actually worked.
A new public-endpoint baseline still returned Luna. The exact original ticket was
backed up, copy rollback was verified, and only account 15's Astra ticket was
conditionally replaced with its own previously verified 292-character state.
The running harvester loaded that state without a restart. At 16:41 CST, the public
`/v1/responses` endpoint returned `gpt-6-astra`, HTTP 200, `ASTRA_OK`, and
`response.completed` in 2.863 seconds. Usage record 26856 confirms no mismatch.
The new ticket remains installed and harvesting enabled; settings and proxy
topology remain intact. Local ticket expiry is 17:34:03 CST. The model correctness
of a subsequent automatic refresh is still unverified. Evidence:
`.codex/live-astra-20260920/VERIFICATION.txt`.

## Model-effective validation fix (2026-09-21)

The harvester now reads a bounded SSE response body and extracts the terminal
`response.model` before persisting a ticket. A captured state is stored with
`verified_model` and is injected, advertised as ready, or treated as schedulable
only when that value matches the outbound model. Legacy tickets without the
verification field are fail-closed. A successful HTTP response that declares a
different model (for example `gpt-5.6-luna` for `gpt-6-astra`) invalidates the
old ticket instead of saving the mismatch.

Focused service tests with `-race`, a baseline comparison, and a server build
were run from local fixtures. No server settings, account data, ticket blobs,
harvesting state, or production deployment were changed by this source fix.
Evidence: `.codex/astra-model-validation-20260921/VERIFICATION.txt`.
