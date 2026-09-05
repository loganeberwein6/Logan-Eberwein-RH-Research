import SR_Carrier
import Mathlib.LinearAlgebra.StdBasis

namespace SR

/-- Raw degree-one ordered labels at X = 6. -/
abbrev E10 : Type :=
  PrimeIndex6 -> ℂ

/-- Ordered degree-one basis vector `e_m`; invalid labels map to zero. -/
def e (m : Nat) : E10 :=
  match PrimeIndex6.ofNat? m with
  | some mi => Pi.single mi 1
  | none => 0

/-- Multiplication preserves ordered provenance: `e_m * e_n = q_mn`. -/
noncomputable def SR_mul : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6 where
  toFun x :=
    { toFun := fun y => fun current => x current.1 * y current.2
      map_add' := by
        intro y z
        funext current
        simp [mul_add]
      map_smul' := by
        intro a y
        funext current
        simp [mul_left_comm] }
  map_add' := by
    intro x z
    ext y current
    simp [add_mul]
  map_smul' := by
    intro a x
    ext y current
    simp [mul_assoc]

theorem e_eq_basisFun_toNat (i : PrimeIndex6) :
    e i.toNat = Pi.basisFun ℂ PrimeIndex6 i := by
  funext current
  cases i <;> cases current <;>
    simp [e, PrimeIndex6.toNat, PrimeIndex6.ofNat?, Pi.basisFun_apply, Pi.single, Function.update]

theorem SR_mul_basis (m n : Nat) :
    SR_mul (e m) (e n) = q m n := by
  funext current
  cases hm : PrimeIndex6.ofNat? m with
  | none =>
      simp [SR_mul, e, q, hm]
  | some mi =>
      cases hn : PrimeIndex6.ofNat? n with
      | none =>
          simp [SR_mul, e, q, hn]
      | some ni =>
          cases mi <;> cases ni <;> cases current with
          | mk left right =>
              cases left <;> cases right <;>
                simp [SR_mul, e, q, hm, hn, basisValue, Pi.single, Function.update]

theorem mul_is_forced :
    ∀ (f : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6),
      (∀ m n, f (e m) (e n) = q m n) → f = SR_mul := by
  intro f hf
  apply (Pi.basisFun ℂ PrimeIndex6).ext
  intro i
  apply (Pi.basisFun ℂ PrimeIndex6).ext
  intro j
  rw [← e_eq_basisFun_toNat i, ← e_eq_basisFun_toNat j]
  rw [hf i.toNat j.toNat, SR_mul_basis i.toNat j.toNat]

#check E10
#check e
#check SR_mul
#check SR_mul_basis
#check mul_is_forced

end SR
