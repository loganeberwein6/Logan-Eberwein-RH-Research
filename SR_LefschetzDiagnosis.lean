import SR_PoincareDuality
import SR_GNS

namespace SR

/-
Stage 11A: carrier diagnosis for arithmetic Lefschetz.

The Stage 10 pairing is the logarithmic product pairing.  This file records
that replacing it by the bivariant `SR_mul` description does not change the
rank-one nature, and that the naive full `E20_6` product pairing is again
rank-one when it is built only from the same logarithmic orientation scalar.
-/

/-- Logarithmic product weight on the ordered degree-two support at `X = 6`. -/
noncomputable def e20LogWeight6 (ij : SupportIndex6 × SupportIndex6) : ℝ :=
  logWeight6 ij.1 * logWeight6 ij.2

/-- The logarithmic orientation scalar on `E20_6`. -/
noncomputable def E20_logWeightSum (x : E20_6) : ℂ :=
  x (PrimeIndex6.p2, PrimeIndex6.p2) * (e20LogWeight6 (PrimeIndex6.p2, PrimeIndex6.p2) : ℂ) +
  x (PrimeIndex6.p2, PrimeIndex6.p3) * (e20LogWeight6 (PrimeIndex6.p2, PrimeIndex6.p3) : ℂ) +
  x (PrimeIndex6.p2, PrimeIndex6.p4) * (e20LogWeight6 (PrimeIndex6.p2, PrimeIndex6.p4) : ℂ) +
  x (PrimeIndex6.p2, PrimeIndex6.p5) * (e20LogWeight6 (PrimeIndex6.p2, PrimeIndex6.p5) : ℂ) +
  x (PrimeIndex6.p3, PrimeIndex6.p2) * (e20LogWeight6 (PrimeIndex6.p3, PrimeIndex6.p2) : ℂ) +
  x (PrimeIndex6.p3, PrimeIndex6.p3) * (e20LogWeight6 (PrimeIndex6.p3, PrimeIndex6.p3) : ℂ) +
  x (PrimeIndex6.p3, PrimeIndex6.p4) * (e20LogWeight6 (PrimeIndex6.p3, PrimeIndex6.p4) : ℂ) +
  x (PrimeIndex6.p3, PrimeIndex6.p5) * (e20LogWeight6 (PrimeIndex6.p3, PrimeIndex6.p5) : ℂ) +
  x (PrimeIndex6.p4, PrimeIndex6.p2) * (e20LogWeight6 (PrimeIndex6.p4, PrimeIndex6.p2) : ℂ) +
  x (PrimeIndex6.p4, PrimeIndex6.p3) * (e20LogWeight6 (PrimeIndex6.p4, PrimeIndex6.p3) : ℂ) +
  x (PrimeIndex6.p4, PrimeIndex6.p4) * (e20LogWeight6 (PrimeIndex6.p4, PrimeIndex6.p4) : ℂ) +
  x (PrimeIndex6.p4, PrimeIndex6.p5) * (e20LogWeight6 (PrimeIndex6.p4, PrimeIndex6.p5) : ℂ) +
  x (PrimeIndex6.p5, PrimeIndex6.p2) * (e20LogWeight6 (PrimeIndex6.p5, PrimeIndex6.p2) : ℂ) +
  x (PrimeIndex6.p5, PrimeIndex6.p3) * (e20LogWeight6 (PrimeIndex6.p5, PrimeIndex6.p3) : ℂ) +
  x (PrimeIndex6.p5, PrimeIndex6.p4) * (e20LogWeight6 (PrimeIndex6.p5, PrimeIndex6.p4) : ℂ) +
  x (PrimeIndex6.p5, PrimeIndex6.p5) * (e20LogWeight6 (PrimeIndex6.p5, PrimeIndex6.p5) : ℂ)

/-- The same Stage 10 pairing, written through `SR_mul`. -/
noncomputable def bivariant_pairing (x y : E10) : ℝ :=
  Complex.re (E20_logWeightSum (SR_mul x y))

/-- Full degree-two pairing formed from the same logarithmic orientation scalar. -/
noncomputable def Full_pairing (x y : E20_6) : ℝ :=
  Complex.re (E20_logWeightSum x * E20_logWeightSum y)

theorem e20LogWeight6_swap (i j : SupportIndex6) :
    e20LogWeight6 (i, j) = e20LogWeight6 (j, i) := by
  simp [e20LogWeight6, mul_comm]

theorem Full_pairing_symmetric :
    ∀ x y : E20_6, Full_pairing x y = Full_pairing y x := by
  intro x y
  simp [Full_pairing, mul_comm]

/-- R1 diagnosis: the bivariant pairing is exactly the `SR_mul`-then-orient form. -/
theorem bivariant_pairing_uses_SR_mul (x y : E10) :
    bivariant_pairing x y = Complex.re (E20_logWeightSum (SR_mul x y)) := by
  rfl

/-- Radical predicate for the naive full degree-two product pairing. -/
def Full_pairing_radical (x : E20_6) : Prop :=
  ∀ y : E20_6, Full_pairing x y = 0

theorem Full_pairing_radical_of_weight_zero (x : E20_6)
    (hx : E20_logWeightSum x = 0) :
    Full_pairing_radical x := by
  intro y
  simp [Full_pairing, hx]

/-- A nonzero full-pairing radical witness using two degree-two coordinates. -/
noncomputable def Full_pairing_radical_witness : E20_6 := fun ij =>
  match ij with
  | (PrimeIndex6.p2, PrimeIndex6.p2) => (Real.log 3 : ℂ)
  | (PrimeIndex6.p2, PrimeIndex6.p3) => -(Real.log 2 : ℂ)
  | _ => 0

theorem Full_pairing_radical_witness_weight_zero :
    E20_logWeightSum Full_pairing_radical_witness = 0 := by
  simp [E20_logWeightSum, Full_pairing_radical_witness, e20LogWeight6, logWeight6]
  ring

theorem Full_pairing_radical_witness_in_radical :
    Full_pairing_radical Full_pairing_radical_witness :=
  Full_pairing_radical_of_weight_zero Full_pairing_radical_witness
    Full_pairing_radical_witness_weight_zero

theorem Full_pairing_radical_witness_ne_zero :
    Full_pairing_radical_witness ≠ 0 := by
  intro h
  have hcoord := congrFun h (PrimeIndex6.p2, PrimeIndex6.p2)
  have hlog : (Real.log 3 : ℂ) ≠ 0 := by
    exact Complex.ofReal_ne_zero.mpr (ne_of_gt (Real.log_pos (by norm_num)))
  change (Real.log 3 : ℂ) = 0 at hcoord
  exact hlog hcoord

/-- R2 diagnosis: the naive full `E20_6` product pairing is still degenerate. -/
theorem Full_pairing_radical_nontrivial_X6 :
    ∃ x : E20_6, x ≠ 0 ∧ Full_pairing_radical x := by
  exact ⟨Full_pairing_radical_witness, Full_pairing_radical_witness_ne_zero,
    Full_pairing_radical_witness_in_radical⟩

/-- Diagonal embedding of degree-one classes into the mixed `E11` carrier. -/
noncomputable def E10_to_E11_diag : E10 →ₗ[ℂ] E11 where
  toFun x := ULift.up fun ij =>
    if hdiag : ij.1 = ij.2 then
      x ij.1
    else
      0
  map_add' := by
    intro x y
    apply ULift.ext
    funext ij
    by_cases hdiag : ij.1 = ij.2 <;> simp [hdiag]
  map_smul' := by
    intro a x
    apply ULift.ext
    funext ij
    by_cases hdiag : ij.1 = ij.2 <;> simp [hdiag]

/-- R3 Weil/GNS analog using the current observed mixed GNS functional. -/
noncomputable def W_pairing (x y : E10) : ℝ :=
  Complex.re (Gamma_obs (dagger (E10_to_E11_diag x) * E10_to_E11_diag y))

def W_pairing_radical (x : E10) : Prop :=
  ∀ y : E10, W_pairing x y = 0

theorem W_pairing_e2_e2 :
    W_pairing (e 2) (e 2) = 1 := by
  change Complex.re ((dagger (E10_to_E11_diag (e 2)) *
    E10_to_E11_diag (e 2)).coeff (PrimeIndex6.p2, PrimeIndex6.p2)) = 1
  rw [E11_mul_coeff]
  norm_num [E10_to_E11_diag, Gamma_obs, dagger, E11.coeff, e,
    PrimeIndex6.ofNat?, Pi.single, Function.update]

theorem W_pairing_e3_left_zero :
    W_pairing_radical (e 3) := by
  intro y
  change Complex.re ((dagger (E10_to_E11_diag (e 3)) *
    E10_to_E11_diag y).coeff (PrimeIndex6.p2, PrimeIndex6.p2)) = 0
  rw [E11_mul_coeff]
  simp [E10_to_E11_diag, dagger, E11.coeff, e,
    PrimeIndex6.ofNat?, Pi.single, Function.update]

theorem W_pairing_e3_nonzero :
    e 3 ≠ (0 : E10) := by
  intro hzero
  have hcoord := congrFun hzero PrimeIndex6.p3
  norm_num [e, PrimeIndex6.ofNat?, Pi.single, Function.update] at hcoord

/--
R3 diagnosis: the current singleton-observed GNS pairing is nonzero but still
degenerate on the full degree-one carrier.
-/
theorem W_pairing_radical_nontrivial_X6 :
    ∃ x : E10, x ≠ 0 ∧ W_pairing_radical x := by
  exact ⟨e 3, W_pairing_e3_nonzero, W_pairing_e3_left_zero⟩

#check bivariant_pairing
#check bivariant_pairing_uses_SR_mul
#check Full_pairing
#check Full_pairing_symmetric
#check Full_pairing_radical
#check Full_pairing_radical_nontrivial_X6
#check E10_to_E11_diag
#check W_pairing
#check W_pairing_e2_e2
#check W_pairing_radical_nontrivial_X6

end SR
