# x402-Starknet Extension
**HTTP 402 Payment-Gated Routing on Starknet**
**Author:** Richard Patterson (@De-ASI-INTERFACE) | **Version:** 1.0.0 | **Date:** 2026-07-09 | **License:** MIT

## Overview
The x402-Starknet Extension adapts the x402 HTTP 402 payment standard to Starknet using Cairo smart contracts, STARK validity proofs (StarkEx), and Starknet's native account abstraction. It defines `scheme: starknet-erc20` for ERC-20 token payments (STRK, ETH, USDC) with Ekubo Protocol v2 as the canonical concentrated liquidity AMM routing surface. Cairo's type system enforces payment invariants at compile time; Lean 4 proofs provide an independent formal verification layer. The `__validate__` / `__execute__` AA entrypoint separation ensures payment authorization is cryptographically proven before any state change.
**Reference ID:** RP-DEASI-STRK-2026-0709-001
