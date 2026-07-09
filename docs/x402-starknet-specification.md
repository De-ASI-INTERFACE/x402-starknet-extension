# x402-Starknet Specification
**Author:** Richard Patterson | **Ref:** RP-DEASI-STRK-2026-0709-001

## Payment Schema (`scheme: starknet-erc20`)
```json
{ "scheme": "starknet-erc20", "chainId": "SN_MAIN",
  "payTo": "0x<facilitator-felt252>",
  "token": "0x<erc20-contract-felt252>",
  "amount": "<u256>", "nonce": "<felt252>",
  "expiresAt": "<block-timestamp>",
  "signature": ["<r-felt252>", "<s-felt252>"] }
```

## Starknet-Specific Invariants
1. **Cairo AA `__validate__`:** Called before `__execute__`; payment auth proven before any state mutation
2. **STARK Validity Proof:** All transitions batched into STARK proofs; no fraud/dispute window
3. **felt252 Nonce:** Account contract increments `felt252` nonce atomically per transaction
4. **Ekubo v2 CL:** Concentrated liquidity with singleton architecture; payment gate per pool key
5. **Sequencer Confirmation:** Payment included in sequencer block (~2s) before resource delivery
