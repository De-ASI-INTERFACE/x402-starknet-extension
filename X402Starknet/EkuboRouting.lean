-- ============================================================
-- x402-Starknet: Ekubo Protocol v2 Routing Invariants
-- Author: Richard Patterson (@De-ASI-INTERFACE)
-- Date: 2026-07-09
-- ============================================================
import Mathlib.Data.Nat.Basic
import X402Starknet.PaymentVerification

namespace X402Starknet.Ekubo

structure PoolKey where
  token0 : Nat; token1 : Nat
  fee : Nat; tick_spacing : Nat; extension : Nat
  deriving Repr

structure RouteNode where
  pool_key : PoolKey
  sqrt_ratio_limit : Nat
  skip_ahead : Nat
  deriving Repr

structure GatedSwap where
  auth : PaymentAuth
  route : RouteNode
  amount_in : Nat
  min_amount_out : Nat
  deriving Repr

def route_authorized (gs : GatedSwap) (s : FacilitatorState) : Prop := verify gs.auth s
def route_sane (gs : GatedSwap) : Prop := 0 < gs.min_amount_out ∧ gs.auth.amount = gs.amount_in
def gated_swap_valid (gs : GatedSwap) (s : FacilitatorState) : Prop := route_authorized gs s ∧ route_sane gs

theorem gated_swap_requires_payment (gs : GatedSwap) (s : FacilitatorState) (h : gated_swap_valid gs s) :
    gs.auth.nonce = s.current_nonce := replay_prevented gs.auth s h.1

end X402Starknet.Ekubo
