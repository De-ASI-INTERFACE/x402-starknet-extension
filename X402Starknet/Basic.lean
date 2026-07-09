-- ============================================================
-- x402-Starknet: Basic Re-export Shim
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- Chain: Starknet / Cairo AA / Ekubo Protocol v2
--
-- Re-exports X402Starknet.PaymentVerification as the single
-- authoritative source of all shared types and definitions.
-- Chain-prefixed theorem aliases are provided for ergonomic use.
--
-- Note: Starknet Cairo AA accounts use a monotone nonce for
-- replay protection, so replay_prevented returns an equality:
-- a.nonce = s.current_nonce.
-- ============================================================
import X402Starknet.PaymentVerification

namespace X402Starknet

/-- Alias: nonce freshness under the Starknet chain prefix.
    Starknet Cairo AA replay protection uses account nonce equality:
    a.nonce = s.current_nonce. -/
theorem starknet_replay_prevented
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    a.nonce = s.current_nonce :=
  replay_prevented a s h

/-- Alias: block timestamp expiry enforcement under the Starknet chain prefix.
    Delegates to within_expiry: s.block_time ≤ a.expires_at. -/
theorem starknet_not_expired
    (a : PaymentAuth) (s : FacilitatorState) (h : verify a s) :
    s.block_time ≤ a.expires_at :=
  within_expiry a s h

end X402Starknet
