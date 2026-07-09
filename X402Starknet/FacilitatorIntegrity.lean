-- ============================================================
-- x402-Starknet: Facilitator State Integrity
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Finset.Basic
import X402Starknet.PaymentVerification

namespace X402Starknet.Facilitator

theorem nonce_strictly_increases (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.current_nonce < (settle a s).current_nonce := by simp [settle]

structure TimeStep where
  s_before : FacilitatorState; s_after : FacilitatorState
  mono : s_before.block_time ≤ s_after.block_time

theorem expiry_is_monotone (a : PaymentAuth) (ts : TimeStep) (h_valid : not_expired a ts.s_before) :
    ts.s_before.block_time ≤ a.expires_at := h_valid

end X402Starknet.Facilitator
