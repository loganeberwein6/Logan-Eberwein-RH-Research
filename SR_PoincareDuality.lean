import SR_Stage9
import SR_Multiplication

namespace SR

/-
Stage 10: relative Poincaré duality audit.

The orientation induced by the Stage 9 logarithmic scale produces a rank-one
pairing on the four-dimensional degree-one carrier `E10`.  Consequently the
ordinary absolute pairing is not nondegenerate on `E10`; its radical is the
kernel of the logarithmic weighted-sum functional.  This is the relative
feature requested in the Stage 10 audit.
-/

/-- Logarithmic weight on the frozen `X = 6` support. -/
noncomputable def logWeight6 : SupportIndex6 → ℝ
  | PrimeIndex6.p2 => Real.log 2
  | PrimeIndex6.p3 => Real.log 3
  | PrimeIndex6.p4 => Real.log 4
  | PrimeIndex6.p5 => Real.log 5

/-- The logarithmic weighted sum on `E10`. -/
noncomputable def E10_logWeightSum (x : E10) : ℂ :=
  x PrimeIndex6.p2 * (logWeight6 PrimeIndex6.p2 : ℂ) +
  x PrimeIndex6.p3 * (logWeight6 PrimeIndex6.p3 : ℂ) +
  x PrimeIndex6.p4 * (logWeight6 PrimeIndex6.p4 : ℂ) +
  x PrimeIndex6.p5 * (logWeight6 PrimeIndex6.p5 : ℂ)

/--
The Stage 10 Poincaré pairing on degree-one classes.

It is the real part of the rank-one orientation form induced by the
logarithmic product law.
-/
noncomputable def PD_pairing (x y : E10) : ℝ :=
  Complex.re (E10_logWeightSum x * E10_logWeightSum y)

theorem logWeight6_pos :
    ∀ i : SupportIndex6, 0 < logWeight6 i := by
  intro i
  cases i <;> simp [logWeight6] <;> exact Real.log_pos (by norm_num)

theorem E10_logWeightSum_basis (i : SupportIndex6) :
    E10_logWeightSum (e i.toNat) = (logWeight6 i : ℂ) := by
  change E10_logWeightSum (e (PrimeIndex6.toNat i)) = (logWeight6 i : ℂ)
  rw [e_eq_basisFun_toNat i]
  cases i <;> simp [E10_logWeightSum, logWeight6, Pi.basisFun_apply]

theorem PD_pairing_basis (i j : SupportIndex6) :
    PD_pairing (e i.toNat) (e j.toNat) =
      logWeight6 i * logWeight6 j := by
  rw [PD_pairing, E10_logWeightSum_basis i, E10_logWeightSum_basis j]
  simp [Complex.ofReal_re]

theorem PD_symmetric :
    ∀ x y : E10, PD_pairing x y = PD_pairing y x := by
  intro x y
  simp [PD_pairing, mul_comm]

/-- Dagger on `E10` is trivial: degree-one labels carry no conjugate index. -/
def dagger_10 (x : E10) : E10 :=
  x

theorem dagger_10_basis (i : SupportIndex6) :
    dagger_10 (e i.toNat) = e i.toNat := by
  rfl

theorem PD_dagger_compat :
    ∀ x y : E10,
      PD_pairing (dagger_10 x) y = PD_pairing x (dagger_10 y) := by
  intro x y
  rfl

/-- The radical predicate for the Stage 10 pairing. -/
def PD_radical (x : E10) : Prop :=
  ∀ y : E10, PD_pairing x y = 0

theorem PD_radical_of_logWeightSum_zero (x : E10)
    (hx : E10_logWeightSum x = 0) :
    PD_radical x := by
  intro y
  simp [PD_pairing, hx]

/-- The logarithmic weighted sum as a linear functional. -/
noncomputable def E10_logWeightSumLinear : E10 →ₗ[ℂ] ℂ where
  toFun := E10_logWeightSum
  map_add' := by
    intro x y
    simp [E10_logWeightSum, add_mul, add_assoc]
    ring
  map_smul' := by
    intro a x
    simp [E10_logWeightSum, mul_assoc]
    ring_nf

/--
A concrete nonzero radical vector:
`log(3) e₂ - log(2) e₃`.
-/
noncomputable def PD_radical_witness : E10 := fun i =>
  match i with
  | PrimeIndex6.p2 => (Real.log 3 : ℂ)
  | PrimeIndex6.p3 => -(Real.log 2 : ℂ)
  | PrimeIndex6.p4 => 0
  | PrimeIndex6.p5 => 0

theorem PD_radical_witness_weight_zero :
    E10_logWeightSum PD_radical_witness = 0 := by
  simp [E10_logWeightSum, PD_radical_witness, logWeight6]
  ring

theorem PD_radical_witness_in_radical :
    PD_radical PD_radical_witness :=
  PD_radical_of_logWeightSum_zero PD_radical_witness
    PD_radical_witness_weight_zero

theorem PD_radical_witness_ne_zero :
    PD_radical_witness ≠ 0 := by
  intro h
  have hcoord := congrArg (fun x : E10 => x PrimeIndex6.p2) h
  have hlog : (Real.log 3 : ℂ) ≠ 0 := by
    exact Complex.ofReal_ne_zero.mpr (ne_of_gt (Real.log_pos (by norm_num)))
  change (Real.log 3 : ℂ) = 0 at hcoord
  exact hlog hcoord

/-- The absolute Stage 10 pairing has nontrivial radical on `E10`. -/
theorem PD_radical_nontrivial_X6 :
    ∃ x : E10, x ≠ 0 ∧ PD_radical x := by
  exact ⟨PD_radical_witness, PD_radical_witness_ne_zero,
    PD_radical_witness_in_radical⟩

/-- Therefore the absolute nondegeneracy statement requested for `E10` is false. -/
theorem PD_not_nondegenerate_X6 :
    ¬ (∀ x : E10, x ≠ 0 → ∃ y : E10, PD_pairing x y ≠ 0) := by
  intro h
  rcases PD_radical_nontrivial_X6 with ⟨x, hx_ne, hx_rad⟩
  rcases h x hx_ne with ⟨y, hy⟩
  exact hy (hx_rad y)

/--
The relative quotient needed for Poincaré duality is the quotient by the
rank-one pairing radical.
-/
noncomputable def PD_relative_quotient_X6 : Type :=
  E10 ⧸ LinearMap.ker E10_logWeightSumLinear

/--
Stage 10 relative conclusion currently available: the absolute pairing is
degenerate, and the relative carrier is the quotient by the logarithmic
weighted-sum kernel.
-/
theorem PD_relative_requires_quotient_X6 :
    (∃ x : E10, x ≠ 0 ∧ PD_radical x) ∧ Nonempty PD_relative_quotient_X6 := by
  constructor
  · exact PD_radical_nontrivial_X6
  · exact ⟨Submodule.Quotient.mk (p := LinearMap.ker E10_logWeightSumLinear) 0⟩

#check logWeight6
#check E10_logWeightSum
#check E10_logWeightSumLinear
#check PD_pairing
#check logWeight6_pos
#check E10_logWeightSum_basis
#check PD_pairing_basis
#check PD_symmetric
#check dagger_10
#check dagger_10_basis
#check PD_dagger_compat
#check PD_radical
#check PD_radical_witness
#check PD_radical_witness_weight_zero
#check PD_radical_witness_in_radical
#check PD_radical_witness_ne_zero
#check PD_radical_nontrivial_X6
#check PD_not_nondegenerate_X6
#check PD_relative_quotient_X6
#check PD_relative_requires_quotient_X6

end SR
