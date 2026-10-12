# Account30 original identity with account31 existing ticket

The user corrected the previous full-credential transfer: account30 must authenticate with its original credentials. Those credentials are restored and the exact OAuth Redis cache was cleared.

The initial direct existing-ticket combination returned Astra. A later replay of that identical ticket before expiry returned Luna; the newer31 ticket also returned Luna. A successful first sample therefore does not establish a reliable solution. Live gateway verification stopped at the account30 paused precondition without sending an inference request.

Final state: original30 credentials, account30 paused, account31 enabled, unchanged31 credentials/settings, healthy local service. The original candidate ticket install was superseded by a background ticket update. No new application source deployment or remote changes occurred. Existing local harvesting remained enabled.

Full command/result/hash evidence and copy-only executable rollback: `.codex/account30-ownquota-ticket31-20260922/VERIFICATION.txt`. Stable original30 + donor31 -> actual Astra and per-request provider debit attribution remain unresolved.


## Gateway confirmation

A real request pinned to account30 returned `gpt-5.6-luna` while the usage log recorded account30 and the Redis token matched original30. Both account mappings are identity mappings; the OAuth subjects and ChatGPT account IDs differ. This establishes the provider identity/entitlement boundary. A fail-closed mismatch policy can prevent a wrong-model response or fail over to another Astra-capable account, but cannot preserve account30 provider quota while using account31 capability.


## Same-account refresh result

Refreshing account30 through its own OAuth refresh token preserved its upstream identity but changed the token hash. A direct request with the refreshed credentials and the existing account30 ticket still returned `gpt-5.6-luna`. The mismatch is therefore not a stale access token; a donor ticket cannot grant Astra entitlement to this identity.
