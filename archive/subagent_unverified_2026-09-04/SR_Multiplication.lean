import SR_Carrier

set_option linter.unusedVariables false

namespace SR

/-- Bootstrap notation for linear maps in the Lean-core foundation layer. -/
notation:25 A " →ₗ[" K "] " B => A -> B

/-- Raw degree-one ordered labels at X = 6. -/
abbrev E10 : Type := Nat

def e (m : Nat) : E10 := m

/-- Multiplication preserves ordered provenance: `e_m * e_n = q_mn`. -/
def SR_mul : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6 :=
  fun m n => q m n

theorem mul_is_forced :
    ∀ (f : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6),
      (∀ m n, f (e m) (e n) = q m n) -> f = SR_mul := by
  intro f hf
  funext m n
  exact hf m n

#check E10
#check e
#check SR_mul
#check mul_is_forced

end SR
