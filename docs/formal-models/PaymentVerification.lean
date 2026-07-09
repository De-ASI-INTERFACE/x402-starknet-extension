-- x402-Starknet Payment Verification | Author: Richard Patterson
import X402Starknet.Basic

namespace X402Starknet.Verification

/-- After validation, increment nonce to prevent replay -/
def execute (a : PaymentAuth) (s : AccountState)
    (h : validate a s) : AccountState :=
  { s with current_nonce := s.current_nonce + 1 }

/-- Post-execution nonce is strictly greater, preventing replay -/
theorem executed_nonce_incremented
    (a : PaymentAuth) (s : AccountState) (h : validate a s)
    : (execute a s h).current_nonce = s.current_nonce + 1 := by
  simp [execute]

end X402Starknet.Verification
