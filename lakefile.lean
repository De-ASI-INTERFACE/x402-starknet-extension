import Lake
open Lake DSL

package «x402-starknet» where
  name := "x402-starknet"

require mathlib from git
  "https://github.com/leanprover-community/mathlib4" @ "v4.14.0"

lean_lib «X402Starknet» where
  roots := #[`X402Starknet]
