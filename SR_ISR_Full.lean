import SR_ISR

namespace SR

set_option maxHeartbeats 50000

/-
Stage 14: full-support `I_SR` audit and Rees-signed form at X = 6.

Stage 13 intentionally used the currently available singleton GNS observable.
Stage 14 separates two issues:

* the full-support GNS matrix obtained from all diagonal `E10` inputs but the
  existing `Gamma_obs`;
* the independently Rees-graded signed real form, whose sign source is the
  interior/exit wall rather than the singleton GNS observable.
-/

/-- Full-support GNS/E11 matrix coefficient induced by diagonal basis inputs. -/
noncomputable def I_SR_full_matrix (i j : SupportIndex6) : ℂ :=
  Gamma_obs (dagger (h i.toNat i.toNat) * h j.toNat j.toNat)

/-- Full-support GNS/E11 bilinear form built from all X=6 support labels. -/
noncomputable def I_SR_full (x y : E10) : ℂ :=
  ∑ i : SupportIndex6, ∑ j : SupportIndex6,
    star (x i) * y j * I_SR_full_matrix i j

/-- Constructor-level `(1,1)` basis vector avoiding numeric label lookup. -/
def h6 (i j : PrimeIndex6) : E11 :=
  ULift.up fun current => basisValue (i, j) current

theorem E11_mul_h22_h33_observed_zero :
    hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0 := by
  exact E11_mul_hIdxD_p2p2_p3p3_coeff_p2p2_zero

theorem I_SR_full_matrix_eq_observed_product (i j : SupportIndex6) :
    I_SR_full_matrix i j =
      star ((h i.toNat i.toNat).coeff (PrimeIndex6.p2, PrimeIndex6.p2)) *
        (h j.toNat j.toNat).coeff (PrimeIndex6.p2, PrimeIndex6.p2) := by
  rw [I_SR_full_matrix]
  change (dagger (h i.toNat i.toNat) * h j.toNat j.toNat).coeff
    (PrimeIndex6.p2, PrimeIndex6.p2) =
      star ((h i.toNat i.toNat).coeff (PrimeIndex6.p2, PrimeIndex6.p2)) *
        (h j.toNat j.toNat).coeff (PrimeIndex6.p2, PrimeIndex6.p2)
  rw [E11_mul_coeff]
  simp [dagger, E11.coeff]

/--
Stage 14A fork result: with the current `Gamma_obs`, the off-diagonal
GNS term produced from `h₂₂ * h₃₃` is observed as zero.
-/
theorem E11_mul_offDiagonal_observed_zero :
    hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0 := by
  exact E11_mul_h22_h33_observed_zero

/-- Rees sign for X=6: interior products are negative, exits positive. -/
def Rees_sign6 (i j : SupportIndex6) : ℝ :=
  match i, j with
  | PrimeIndex6.p2, PrimeIndex6.p2 => -1
  | _, _ => 1

theorem Rees_sign6_p2_p2 :
    Rees_sign6 PrimeIndex6.p2 PrimeIndex6.p2 = -1 := by
  rfl

theorem Rees_sign6_p2_p3 :
    Rees_sign6 PrimeIndex6.p2 PrimeIndex6.p3 = 1 := by
  rfl

theorem Rees_sign6_p3_p2 :
    Rees_sign6 PrimeIndex6.p3 PrimeIndex6.p2 = 1 := by
  rfl

theorem Rees_sign6_p3_p3 :
    Rees_sign6 PrimeIndex6.p3 PrimeIndex6.p3 = 1 := by
  rfl

theorem Rees_sign6_agrees_grade :
    ∀ i j : SupportIndex6,
      Rees_sign6 i j =
        if grade i.toNat j.toNat (6 : ℚ) = ReesGrade.Interior then -1 else 1 := by
  intro i j
  cases i <;> cases j <;>
    norm_num [Rees_sign6, grade, SupportIndex6.toNat, PrimeIndex6.toNat] <;>
    decide

/-- Sum of real coordinates over the frozen X=6 support. -/
noncomputable def E10_realSupportSum (x : E10) : ℝ :=
  (x PrimeIndex6.p2).re + (x PrimeIndex6.p3).re +
    (x PrimeIndex6.p4).re + (x PrimeIndex6.p5).re

/-- Rees-signed real form on the X=6 degree-one carrier.

Since the X=6 sign table has sign `-1` only at `(2,2)` and `+1`
elsewhere, the full finite double sum is equivalently the all-ones
rank-one real support sum minus twice the `(2,2)` contribution.
-/
noncomputable def I_SR_Rees (x y : E10) : ℝ :=
  E10_realSupportSum x * E10_realSupportSum y -
    2 * (x PrimeIndex6.p2).re * (y PrimeIndex6.p2).re

theorem PD_radical_witness_realSupportSum :
    E10_realSupportSum PD_radical_witness =
      Real.log 3 - Real.log 2 := by
  change Real.log 3 + (-(Real.log 2)) + 0 + 0 = Real.log 3 - Real.log 2
  ring

theorem PD_radical_witness_p2_re :
    (PD_radical_witness PrimeIndex6.p2).re = Real.log 3 := by
  rfl

theorem I_SR_Rees_radical_witness_value :
    I_SR_Rees PD_radical_witness PD_radical_witness =
      (Real.log 3 - Real.log 2) * (Real.log 3 - Real.log 2) -
        2 * Real.log 3 * Real.log 3 := by
  rw [I_SR_Rees, PD_radical_witness_realSupportSum,
    PD_radical_witness_p2_re]

theorem I_SR_Rees_radical_negative :
    I_SR_Rees PD_radical_witness PD_radical_witness < 0 := by
  rw [I_SR_Rees_radical_witness_value]
  have h2pos : 0 < Real.log 2 := Real.log_pos (by norm_num)
  have h3pos : 0 < Real.log 3 := Real.log_pos (by norm_num)
  have h23 : Real.log 2 < Real.log 3 :=
    Real.log_lt_log (by norm_num) (by norm_num)
  have hdiffpos : 0 < Real.log 3 - Real.log 2 := sub_pos.mpr h23
  have hdiff_lt_h3 : Real.log 3 - Real.log 2 < Real.log 3 := by
    exact sub_lt_self (Real.log 3) h2pos
  have hdiff_gt_neg : -(Real.log 3) < Real.log 3 - Real.log 2 := by
    linarith
  have hsq_lt : (Real.log 3 - Real.log 2)^2 < (Real.log 3)^2 := by
    exact sq_lt_sq' hdiff_gt_neg hdiff_lt_h3
  have hsqpos : 0 < (Real.log 3)^2 := sq_pos_of_pos h3pos
  have htwo : (Real.log 3)^2 < 2 * (Real.log 3)^2 := by
    linarith
  nlinarith

/-- Candidate physical primitive sector at X=6. -/
noncomputable def P_SR_phys : Submodule ℂ E10 :=
  LinearMap.ker E10_logWeightSumLinear

theorem P_SR_phys_definition :
    P_SR_phys = LinearMap.ker E10_logWeightSumLinear := by
  rfl

theorem radical_witness_is_primitive :
    PD_radical_witness ∈ P_SR_phys := by
  change E10_logWeightSumLinear PD_radical_witness = 0
  exact PD_radical_witness_weight_zero

theorem radical_witness_rees_signed_negative :
    PD_radical_witness ∈ P_SR_phys ∧
      I_SR_Rees PD_radical_witness PD_radical_witness < 0 := by
  exact ⟨radical_witness_is_primitive, I_SR_Rees_radical_negative⟩

/-- A Stage 14D test vector in the logarithmic kernel but away from the `(2,2)` sign slot. -/
noncomputable def partialSignCounterexample : E10 := fun i =>
  match i with
  | PrimeIndex6.p2 => 0
  | PrimeIndex6.p3 => (Real.log 5 : ℂ)
  | PrimeIndex6.p4 => 0
  | PrimeIndex6.p5 => -(Real.log 3 : ℂ)

theorem partialSignCounterexample_is_primitive :
    partialSignCounterexample ∈ P_SR_phys := by
  change E10_logWeightSumLinear partialSignCounterexample = 0
  simp [E10_logWeightSumLinear, E10_logWeightSum, partialSignCounterexample, logWeight6]
  ring

theorem partialSignCounterexample_realSupportSum :
    E10_realSupportSum partialSignCounterexample =
      Real.log 5 - Real.log 3 := by
  change 0 + Real.log 5 + 0 + (-(Real.log 3)) = Real.log 5 - Real.log 3
  ring

theorem partialSignCounterexample_p2_re :
    (partialSignCounterexample PrimeIndex6.p2).re = 0 := by
  rfl

theorem I_SR_Rees_partialSignCounterexample_value :
    I_SR_Rees partialSignCounterexample partialSignCounterexample =
      (Real.log 5 - Real.log 3) * (Real.log 5 - Real.log 3) := by
  rw [I_SR_Rees, partialSignCounterexample_realSupportSum,
    partialSignCounterexample_p2_re]
  ring

theorem I_SR_Rees_partialSignCounterexample_positive :
    0 < I_SR_Rees partialSignCounterexample partialSignCounterexample := by
  rw [I_SR_Rees_partialSignCounterexample_value]
  have h35 : Real.log 3 < Real.log 5 :=
    Real.log_lt_log (by norm_num) (by norm_num)
  have hdiff : 0 < Real.log 5 - Real.log 3 := sub_pos.mpr h35
  nlinarith [sq_pos_of_pos hdiff]

theorem not_partial_sign_theorem :
    ¬ ∀ x ∈ P_SR_phys, I_SR_Rees x x ≤ 0 := by
  intro h
  have hnonpos := h partialSignCounterexample partialSignCounterexample_is_primitive
  linarith [I_SR_Rees_partialSignCounterexample_positive]

theorem stage14_outcome :
    hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0 ∧
    (PD_radical_witness ∈ P_SR_phys ∧
      I_SR_Rees PD_radical_witness PD_radical_witness < 0) ∧
    ¬ (∀ x ∈ P_SR_phys, I_SR_Rees x x ≤ 0) := by
  exact ⟨E11_mul_offDiagonal_observed_zero,
    radical_witness_rees_signed_negative,
    not_partial_sign_theorem⟩

#check I_SR_full_matrix
#check I_SR_full
#check h6
#check E11_mul_h22_h33_observed_zero
#check I_SR_full_matrix_eq_observed_product
#check E11_mul_offDiagonal_observed_zero
#check Rees_sign6
#check Rees_sign6_p2_p2
#check Rees_sign6_p2_p3
#check Rees_sign6_p3_p2
#check Rees_sign6_p3_p3
#check E10_realSupportSum
#check I_SR_Rees
#check PD_radical_witness_realSupportSum
#check PD_radical_witness_p2_re
#check I_SR_Rees_radical_witness_value
#check I_SR_Rees_radical_negative
#check P_SR_phys
#check P_SR_phys_definition
#check radical_witness_is_primitive
#check radical_witness_rees_signed_negative
#check partialSignCounterexample
#check partialSignCounterexample_is_primitive
#check partialSignCounterexample_realSupportSum
#check partialSignCounterexample_p2_re
#check I_SR_Rees_partialSignCounterexample_value
#check I_SR_Rees_partialSignCounterexample_positive
#check not_partial_sign_theorem
#check stage14_outcome

end SR
