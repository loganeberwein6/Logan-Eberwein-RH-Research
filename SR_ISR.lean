import SR_HermitianForm
import SR_GNS

namespace SR

/-
Stage 13: SR Weil operator and the first `I_SR` audit.

The Stage 12 audit showed that the naive classical operator `x ↦ i • x`
does not supply the SR Hodge-Riemann sign.  The intrinsic degree-one dagger
is trivial, so the SR Weil candidate induced by dagger is the identity on
`E10`.

The finite `I_SR` form below is the current GNS/E11 construction:
`I_SR(x,y) = Gamma_obs (dagger (embed_E10_E11 x) * embed_E10_E11 y)`.
Because the existing observable `Gamma_obs` only reads the `(2,2)` entry,
the form sees only the `e₂` coordinate.  This produces a real sign conflict
on the Stage 10 radical witness.
-/

/-- SR Weil operator on degree one, induced by the degree-one dagger. -/
noncomputable def C_SR : E10 →ₗ[ℂ] E10 where
  toFun := dagger_10
  map_add' := by
    intro x y
    rfl
  map_smul' := by
    intro a x
    rfl

theorem C_SR_eq_id :
    C_SR = LinearMap.id := by
  ext x i
  rfl

theorem C_SR_apply (x : E10) :
    C_SR x = x := by
  rfl

theorem C_SR_basis (i : SupportIndex6) :
    C_SR (e i.toNat) = e i.toNat := by
  rfl

theorem HR_C_SR_positive :
    ∀ x : E10,
      0 ≤ Complex.re (H_SR x (C_SR x)) := by
  intro x
  change 0 ≤ Complex.re (H_SR x x)
  exact H_SR_pos_semidef x

theorem HR_C_SR_positive_quotient :
    ∀ x : E10,
      x ∉ LinearMap.ker E10_logWeightSumLinear →
        0 < Complex.re (H_SR x (C_SR x)) := by
  intro x hx
  change 0 < Complex.re (H_SR x x)
  exact H_SR_pos_def_quotient x hx

/--
Diagonal embedding from degree one into the separated `(1,1)` carrier.

This reuses the Stage 11 diagonal bridge, rather than introducing a second
definition with the same intended meaning.
-/
noncomputable def embed_E10_E11 : E10 →ₗ[ℂ] E11 :=
  E10_to_E11_diag

theorem embed_E10_E11_coeff_diag (x : E10) (i : SupportIndex6) :
    (embed_E10_E11 x).coeff (i, i) = x i := by
  simp [embed_E10_E11, E10_to_E11_diag, E11.coeff]

/-- The finite GNS/E11 Selberg-Rees quadratic pairing currently available. -/
noncomputable def I_SR (x y : E10) : ℂ :=
  Gamma_obs (dagger (embed_E10_E11 x) * embed_E10_E11 y)

theorem I_SR_eq_observed_coordinate (x y : E10) :
    I_SR x y = star (x PrimeIndex6.p2) * y PrimeIndex6.p2 := by
  rw [I_SR]
  change (dagger (embed_E10_E11 x) * embed_E10_E11 y).coeff
    (PrimeIndex6.p2, PrimeIndex6.p2) =
      star (x PrimeIndex6.p2) * y PrimeIndex6.p2
  rw [E11_mul_coeff]
  change star ((embed_E10_E11 x).coeff (PrimeIndex6.p2, PrimeIndex6.p2)) *
      (embed_E10_E11 y).coeff (PrimeIndex6.p2, PrimeIndex6.p2) =
    star (x PrimeIndex6.p2) * y PrimeIndex6.p2
  rw [embed_E10_E11_coeff_diag x PrimeIndex6.p2,
    embed_E10_E11_coeff_diag y PrimeIndex6.p2]

theorem I_SR_basis (i j : SupportIndex6) :
    I_SR (e i.toNat) (e j.toNat) =
      Gamma_obs (dagger (embed_E10_E11 (e i.toNat)) *
        embed_E10_E11 (e j.toNat)) := by
  rfl

theorem I_SR_basis_value (i j : SupportIndex6) :
    I_SR (e i.toNat) (e j.toNat) =
      star ((e i.toNat) PrimeIndex6.p2) * (e j.toNat) PrimeIndex6.p2 := by
  exact I_SR_eq_observed_coordinate (e i.toNat) (e j.toNat)

theorem I_SR_e2_e2 :
    I_SR (e 2) (e 2) = 1 := by
  rw [I_SR_eq_observed_coordinate]
  norm_num [e, PrimeIndex6.ofNat?, Pi.single, Function.update]

theorem I_SR_radical_witness_value :
    I_SR PD_radical_witness PD_radical_witness =
      (Real.log 3 : ℂ) * (Real.log 3 : ℂ) := by
  rw [I_SR_eq_observed_coordinate]
  simp [PD_radical_witness]

theorem I_SR_radical_witness_re :
    Complex.re (I_SR PD_radical_witness PD_radical_witness) =
      Real.log 3 * Real.log 3 := by
  rw [I_SR_radical_witness_value]
  simp [Complex.ofReal_re]

theorem I_SR_radical_witness_pos :
    0 < Complex.re (I_SR PD_radical_witness PD_radical_witness) := by
  rw [I_SR_radical_witness_re]
  nlinarith [Real.log_pos (by norm_num : (1 : ℝ) < 3)]

/--
Stage 13 sign audit: the current GNS/E11 `I_SR` is positive on the known
Stage 10 radical witness, so the requested nonpositive physical-sector sign
does not follow from the present finite data.
-/
theorem I_SR_sign_wrong_on_radical_witness :
    PD_radical PD_radical_witness ∧
      0 < Complex.re (I_SR PD_radical_witness PD_radical_witness) := by
  exact ⟨PD_radical_witness_in_radical, I_SR_radical_witness_pos⟩

theorem not_I_SR_nonpos_on_PD_radical :
    ¬ ∀ x : E10,
      PD_radical x → Complex.re (I_SR x x) ≤ 0 := by
  intro h
  have hnonpos := h PD_radical_witness PD_radical_witness_in_radical
  exact not_le_of_gt I_SR_radical_witness_pos hnonpos

/-
The former `SR_RH_ADJACENT_CONJECTURE : True` declaration was removed.
It was only a placeholder for the missing analytic bridge from the finite
signed observable to a zeta-zero statement and proved no mathematical claim.
-/

theorem stage13_outcome :
    (∀ x : E10, 0 ≤ Complex.re (H_SR x (C_SR x))) ∧
    (∀ x : E10,
      x ∉ LinearMap.ker E10_logWeightSumLinear →
        0 < Complex.re (H_SR x (C_SR x))) ∧
    (PD_radical PD_radical_witness ∧
      0 < Complex.re (I_SR PD_radical_witness PD_radical_witness)) ∧
    ¬ ∀ x : E10, PD_radical x → Complex.re (I_SR x x) ≤ 0 := by
  exact ⟨HR_C_SR_positive, HR_C_SR_positive_quotient,
    I_SR_sign_wrong_on_radical_witness, not_I_SR_nonpos_on_PD_radical⟩

#check C_SR
#check C_SR_eq_id
#check C_SR_basis
#check HR_C_SR_positive
#check HR_C_SR_positive_quotient
#check embed_E10_E11
#check I_SR
#check I_SR_eq_observed_coordinate
#check I_SR_basis
#check I_SR_e2_e2
#check I_SR_radical_witness_value
#check I_SR_radical_witness_pos
#check I_SR_sign_wrong_on_radical_witness
#check not_I_SR_nonpos_on_PD_radical
#check stage13_outcome

end SR
