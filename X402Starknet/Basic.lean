-- x402-Starknet Basic | Author: Richard Patterson (@De-ASI-INTERFACE)
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic

namespace X402Starknet

/-- Payment authorization for Starknet AA payment gates -/
structure PaymentAuth where
  nonce      : Nat  -- felt252 nonce from account contract
  amount     : Nat  -- u256 token amount
  expires_at : Nat  -- block timestamp
  deriving Repr, DecidableEq

/-- Starknet account contract state -/
structure AccountState where
  current_nonce : Nat  -- monotonically incrementing
  block_time    : Nat
  deriving Repr

/-- AA validation: nonce must match account nonce and not be expired -/
def validate (a : PaymentAuth) (s : AccountState) : Prop :=
  a.nonce = s.current_nonce ∧ s.block_time ≤ a.expires_at

/-- Nonce match theorem: validated payment uses correct account nonce -/
theorem starknet_nonce_valid
    (a : PaymentAuth) (s : AccountState) (h : validate a s)
    : a.nonce = s.current_nonce := h.1

/-- Expiry theorem -/
theorem starknet_not_expired
    (a : PaymentAuth) (s : AccountState) (h : validate a s)
    : s.block_time ≤ a.expires_at := h.2

end X402Starknet
