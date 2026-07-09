-- ============================================================
-- x402-Starknet: Payment Verification Formal Proofs
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: Starknet / Cairo AA / Ekubo Protocol v2
-- ============================================================
import Mathlib.Data.Finset.Basic
import Mathlib.Data.Nat.Basic
import Mathlib.Logic.Basic

namespace X402Starknet

structure PaymentAuth where
  nonce      : Nat    -- felt252 account nonce
  amount     : Nat    -- u256 token amount
  expires_at : Nat    -- block timestamp
  token      : Nat    -- ERC-20 contract felt252
  deriving Repr, DecidableEq

structure FacilitatorState where
  current_nonce : Nat    -- monotone account nonce
  block_time    : Nat
  deriving Repr

def not_expired (a : PaymentAuth) (s : FacilitatorState) : Prop := s.block_time ≤ a.expires_at
def nonce_fresh (a : PaymentAuth) (s : FacilitatorState) : Prop := a.nonce = s.current_nonce
def amount_positive (a : PaymentAuth) : Prop := 0 < a.amount
def verify (a : PaymentAuth) (s : FacilitatorState) : Prop :=
  not_expired a s ∧ nonce_fresh a s ∧ amount_positive a

theorem replay_prevented (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.nonce = s.current_nonce := h.2.1
theorem within_expiry (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : s.block_time ≤ a.expires_at := h.1
theorem positive_amount (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) : 0 < a.amount := h.2.2

def settle (a : PaymentAuth) (s : FacilitatorState) : FacilitatorState :=
  { s with current_nonce := s.current_nonce + 1 }

theorem settled_nonce_used (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    (settle a s).current_nonce = s.current_nonce + 1 := by simp [settle]

theorem post_settlement_replay_blocked (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    (settle a s).current_nonce ≠ s.current_nonce := by simp [settle]

end X402Starknet
