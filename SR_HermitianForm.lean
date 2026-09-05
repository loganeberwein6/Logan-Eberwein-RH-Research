import SR_Lefschetz

namespace SR

/-
Stage 12: Hermitian Hodge form.

Stage 11 showed that the complex-bilinear `PD_pairing` is not positive
semidefinite on complex `E10`.  The Hermitian repair is to use
`L(x) * star (L(y))`, where `L = E10_logWeightSumLinear`.
-/

/-- The Stage 12 Hermitian SR Hodge form on `E10`. -/
noncomputable def H_SR (x y : E10) : ℂ :=
  E10_logWeightSumLinear x * star (E10_logWeightSumLinear y)

theorem H_SR_eq_logWeight (x y : E10) :
    H_SR x y = E10_logWeightSum x * star (E10_logWeightSum y) := by
  rfl

theorem H_SR_basis (i j : SupportIndex6) :
    H_SR (e i.toNat) (e j.toNat) =
      (logWeight6 i : ℂ) * star (logWeight6 j : ℂ) := by
  rw [H_SR]
  change E10_logWeightSum (e i.toNat) * star (E10_logWeightSum (e j.toNat)) =
    (logWeight6 i : ℂ) * star (logWeight6 j : ℂ)
  rw [E10_logWeightSum_basis i, E10_logWeightSum_basis j]

theorem H_SR_hermitian :
    ∀ x y : E10, H_SR x y = star (H_SR y x) := by
  intro x y
  simp [H_SR, mul_comm]

theorem H_SR_self_eq_normSq (x : E10) :
    Complex.re (H_SR x x) = Complex.normSq (E10_logWeightSumLinear x) := by
  simp [H_SR, Complex.normSq_apply]

theorem H_SR_pos_semidef :
    ∀ x : E10, 0 ≤ Complex.re (H_SR x x) := by
  intro x
  rw [H_SR_self_eq_normSq]
  exact Complex.normSq_nonneg (E10_logWeightSumLinear x)

theorem H_SR_pos_def_quotient :
    ∀ x : E10,
      x ∉ LinearMap.ker E10_logWeightSumLinear →
        0 < Complex.re (H_SR x x) := by
  intro x hx
  rw [H_SR_self_eq_normSq]
  apply Complex.normSq_pos.mpr
  exact hx

/-- Naive classical Weil operator on the degree-one complex carrier. -/
noncomputable def C_Weil : E10 →ₗ[ℂ] E10 where
  toFun x := Complex.I • x
  map_add' := by
    intro x y
    simp [smul_add]
  map_smul' := by
    intro a x
    ext i
    simp [Pi.smul_apply, mul_left_comm]

theorem C_Weil_basis (i : SupportIndex6) :
    C_Weil (e i.toNat) = Complex.I • e i.toNat := by
  rfl

theorem E10_logWeightSumLinear_C_Weil (x : E10) :
    E10_logWeightSumLinear (C_Weil x) =
      Complex.I * E10_logWeightSumLinear x := by
  simp [C_Weil]

theorem HR_Weil_zero :
    ∀ m : SupportIndex6,
      Complex.re (H_SR (e m.toNat) (C_Weil (e m.toNat))) = 0 := by
  intro m
  rw [H_SR, E10_logWeightSumLinear_C_Weil]
  change Complex.re (E10_logWeightSum (e m.toNat) *
    star (Complex.I * E10_logWeightSum (e m.toNat))) = 0
  rw [E10_logWeightSum_basis m]
  simp

/--
The real-restriction compatibility that follows from the logarithmic scalar
being real.  This is the precise scalar condition needed for the stronger
coordinatewise-real statement mentioned in the Stage 12 brief.
-/
theorem H_SR_real_restriction_of_logWeight_real (x y : E10)
    (_hx : star (E10_logWeightSum x) = E10_logWeightSum x)
    (hy : star (E10_logWeightSum y) = E10_logWeightSum y) :
    Complex.re (H_SR x y) = PD_pairing x y := by
  change Complex.re (E10_logWeightSum x * star (E10_logWeightSum y)) =
    PD_pairing x y
  rw [hy]
  rfl

theorem E10_logWeightSum_real_of_coeff_real (x : E10)
    (hx : ∀ m : SupportIndex6, Complex.im (x m) = 0) :
    star (E10_logWeightSum x) = E10_logWeightSum x := by
  apply Complex.ext
  · simp
  · simp [E10_logWeightSum, hx]

/--
Coordinatewise-real restriction of the Hermitian form: on real degree-one
vectors, the real part of `H_SR` recovers the Stage 10 Poincaré pairing.
-/
theorem H_SR_real_restriction (x y : E10)
    (hx : ∀ m : SupportIndex6, Complex.im (x m) = 0)
    (hy : ∀ m : SupportIndex6, Complex.im (y m) = 0) :
    Complex.re (H_SR x y) = PD_pairing x y := by
  exact H_SR_real_restriction_of_logWeight_real x y
    (E10_logWeightSum_real_of_coeff_real x hx)
    (E10_logWeightSum_real_of_coeff_real y hy)

/--
Stage 12 sign reconciliation checkpoint.

The Hermitian form is semidefinite on complex `E10` and positive away from
the logarithmic kernel.  The naive classical Weil operator contributes a
purely imaginary factor on basis classes, so its real HR test is zero.
The signed `I_SR` form remains a separate object for the next stage.
-/
theorem sign_reconciliation_stage12 :
    (∀ x : E10, 0 ≤ Complex.re (H_SR x x)) ∧
    (∀ x : E10, x ∉ LinearMap.ker E10_logWeightSumLinear →
      0 < Complex.re (H_SR x x)) ∧
    (∀ m : SupportIndex6,
      Complex.re (H_SR (e m.toNat) (C_Weil (e m.toNat))) = 0) := by
  exact ⟨H_SR_pos_semidef, H_SR_pos_def_quotient, HR_Weil_zero⟩

#check H_SR
#check H_SR_basis
#check H_SR_hermitian
#check H_SR_pos_semidef
#check H_SR_pos_def_quotient
#check C_Weil
#check C_Weil_basis
#check HR_Weil_zero
#check H_SR_real_restriction_of_logWeight_real
#check E10_logWeightSum_real_of_coeff_real
#check H_SR_real_restriction
#check sign_reconciliation_stage12

end SR
