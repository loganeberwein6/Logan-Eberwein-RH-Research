import SR_LefschetzDiagnosis

namespace SR

/-
Stage 11B--11D: arithmetic Lefschetz classes and Hodge-Riemann sign audit.

The available graded system has `H⁰ → H²` Lefschetz maps represented by the
choice of a nonzero degree-two class.  The nontrivial sign test is not full
Hodge-Riemann: with the current complex `E10` carrier and bilinear
`PD_pairing`, complex phases can make `PD_pairing x x` negative.
-/

/-- Diagonal arithmetic ample candidate: sum of diagonal degree-two classes. -/
noncomputable def omega1 : E20_6 :=
  q 2 2 + q 3 3 + q 4 4 + q 5 5

/-- Log-weighted diagonal arithmetic ample candidate. -/
noncomputable def omega2 : E20_6 :=
  ((Real.log 2 ^ 2 : ℝ) : ℂ) • q 2 2 +
  ((Real.log 3 ^ 2 : ℝ) : ℂ) • q 3 3 +
  ((Real.log 4 ^ 2 : ℝ) : ℂ) • q 4 4 +
  ((Real.log 5 ^ 2 : ℝ) : ℂ) • q 5 5

/-- Full Selberg-kernel arithmetic ample candidate. -/
noncomputable def omega3 : E20_6 :=
  fun ij => ((logWeight6 ij.1 * logWeight6 ij.2 : ℝ) : ℂ)

/-- Lefschetz map from the scalar `H⁰` carrier to `H² = E20_6`. -/
noncomputable def Lefschetz0 (omega : E20_6) : ℂ →ₗ[ℂ] E20_6 where
  toFun c := c • omega
  map_add' := by
    intro a b
    simp [add_smul]
  map_smul' := by
    intro a b
    simp [mul_smul]

theorem omega1_nonzero : omega1 ≠ 0 := by
  intro h
  have hcoord := congrFun h (PrimeIndex6.p2, PrimeIndex6.p2)
  simp [omega1, q, PrimeIndex6.ofNat?, basisValue] at hcoord

theorem omega2_nonzero : omega2 ≠ 0 := by
  intro h
  have hcoord := congrFun h (PrimeIndex6.p2, PrimeIndex6.p2)
  simp [omega2, q, PrimeIndex6.ofNat?, basisValue] at hcoord
  norm_num at hcoord

theorem omega3_nonzero : omega3 ≠ 0 := by
  intro h
  have hcoord := congrFun h (PrimeIndex6.p2, PrimeIndex6.p2)
  have hlog : ((Real.log 2 * Real.log 2 : ℝ) : ℂ) ≠ 0 := by
    exact Complex.ofReal_ne_zero.mpr (mul_ne_zero
      (ne_of_gt (Real.log_pos (by norm_num)))
      (ne_of_gt (Real.log_pos (by norm_num))))
  change ((Real.log 2 * Real.log 2 : ℝ) : ℂ) = 0 at hcoord
  exact hlog hcoord

theorem Lefschetz0_injective_of_nonzero {omega : E20_6}
    (homega : omega ≠ 0) :
    Function.Injective (Lefschetz0 omega) := by
  intro a b h
  by_contra hab
  have hsub : (a - b) • omega = 0 := by
    simpa [Lefschetz0, sub_smul] using sub_eq_zero.mpr h
  have hscalar : a - b = 0 := by
    by_contra hscalar
    exact smul_ne_zero hscalar homega hsub
  exact hab (sub_eq_zero.mp hscalar)

theorem Lefschetz0_omega1_injective :
    Function.Injective (Lefschetz0 omega1) :=
  Lefschetz0_injective_of_nonzero omega1_nonzero

theorem Lefschetz0_omega2_injective :
    Function.Injective (Lefschetz0 omega2) :=
  Lefschetz0_injective_of_nonzero omega2_nonzero

theorem Lefschetz0_omega3_injective :
    Function.Injective (Lefschetz0 omega3) :=
  Lefschetz0_injective_of_nonzero omega3_nonzero

theorem HR_positive_diagonal :
    ∀ m : SupportIndex6,
      0 < PD_pairing (e m.toNat) (dagger_10 (e m.toNat)) := by
  intro m
  rw [dagger_10_basis, PD_pairing_basis]
  exact mul_pos (logWeight6_pos m) (logWeight6_pos m)

/-- A complex phase witness showing the bilinear `PD_pairing x x` is negative. -/
noncomputable def HR_phase_witness : E10 := fun i =>
  match i with
  | PrimeIndex6.p2 => Complex.I
  | _ => 0

theorem HR_phase_witness_weight :
    E10_logWeightSum HR_phase_witness = Complex.I * (Real.log 2 : ℂ) := by
  simp [E10_logWeightSum, HR_phase_witness, logWeight6]

theorem HR_phase_witness_PD_negative :
    PD_pairing HR_phase_witness HR_phase_witness < 0 := by
  rw [PD_pairing, HR_phase_witness_weight]
  simp
  have hpos : 0 < Real.log 2 := Real.log_pos (by norm_num)
  nlinarith

theorem not_PD_positive_semidefinite :
    ¬ (∀ x : E10, 0 ≤ PD_pairing x x) := by
  intro h
  have hnonneg := h HR_phase_witness
  have hneg := HR_phase_witness_PD_negative
  linarith

/--
Stage 11 sign checkpoint: the current complex-bilinear `PD_pairing` cannot be
the positive Hodge-Riemann form on all of complex `E10`.
-/
theorem stage11_sign_conflict :
    (∀ m : SupportIndex6,
      0 < PD_pairing (e m.toNat) (dagger_10 (e m.toNat))) ∧
    ¬ (∀ x : E10, 0 ≤ PD_pairing x x) := by
  exact ⟨HR_positive_diagonal, not_PD_positive_semidefinite⟩

#check omega1
#check omega2
#check omega3
#check Lefschetz0
#check omega1_nonzero
#check omega2_nonzero
#check omega3_nonzero
#check Lefschetz0_omega1_injective
#check Lefschetz0_omega2_injective
#check Lefschetz0_omega3_injective
#check HR_positive_diagonal
#check HR_phase_witness_PD_negative
#check not_PD_positive_semidefinite
#check stage11_sign_conflict

end SR
