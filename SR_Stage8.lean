import SR_Underdetermination
import Mathlib.Analysis.SpecialFunctions.Log.Basic

namespace SR

/-
Stage 8: canonical `J_{5/2}` construction attempt.

At `X = 5/2`, the visible support is the singleton `{2}`.  The only visible
ordered degree-two basis vector is therefore `q₂₂`.
-/

/-- The visible support at `X = 5/2`, namely `{2}`. -/
inductive SupportIndex52 where
  | p2
  deriving DecidableEq, Repr

instance : Fintype SupportIndex52 where
  elems := {SupportIndex52.p2}
  complete := by
    intro x
    cases x
    simp

/-- Convert the singleton `X = 5/2` support label to its natural label. -/
def SupportIndex52.toNat : SupportIndex52 → Nat
  | SupportIndex52.p2 => 2

/-- The visible ordered basis vector for singleton support labels. -/
def q52 (i j : SupportIndex52) : E20_X52 :=
  q_X52 i.toNat j.toNat

/-- Product/Rees-grade channel `πΣ(q_mn) = (m*n, grade m n X52)`. -/
def piSigma52 (i j : SupportIndex52) : Nat × ReesGrade :=
  (i.toNat * j.toNat, grade i.toNat j.toNat X52)

/-- Ratio/cofactor channel `(m/g, n/g, g)`, with `g = gcd(m,n)`. -/
def ratioCofactor52 (i j : SupportIndex52) : Nat × Nat × Nat :=
  let g := Nat.gcd i.toNat j.toNat
  (i.toNat / g, j.toNat / g, g)

/--
The SW current visible at `X = 5/2`: same-prime diagonal indicator.

The support itself is the singleton prime support `{2}`, so the same-prime
test reduces to equality of support labels.
-/
def SWCurrent52 (i j : SupportIndex52) : Prop :=
  i = j

theorem grade_22_X52_exit :
    grade 2 2 X52 = ReesGrade.Exit := by
  norm_num [grade, X52]

theorem piSigma52_q22 :
    piSigma52 SupportIndex52.p2 SupportIndex52.p2 = (4, ReesGrade.Exit) := by
  norm_num [piSigma52, SupportIndex52.toNat, grade_22_X52_exit]

theorem ratioCofactor52_q22 :
    ratioCofactor52 SupportIndex52.p2 SupportIndex52.p2 = (1, 1, 2) := by
  norm_num [ratioCofactor52, SupportIndex52.toNat]

theorem SWCurrent52_q22 :
    SWCurrent52 SupportIndex52.p2 SupportIndex52.p2 := by
  rfl

/--
Full Stage 8 constraint package at `X = 5/2`.

The product and ratio/cofactor constraints say that visible basis values are
compatible with the corresponding primitive channels.  Since the support is a
singleton, these channels classify the only visible basis vector but do not
normalize its magnitude.
-/
def satisfies_stage8_constraints (f : E20_X52 →ₗ[ℂ] ℂ) : Prop :=
  satisfies_enriched_frozen_constraints f ∧
    (∀ i j k l : SupportIndex52,
      piSigma52 i j = piSigma52 k l → f (q52 i j) = f (q52 k l)) ∧
    (∀ i j k l : SupportIndex52,
      ratioCofactor52 i j = ratioCofactor52 k l → f (q52 i j) = f (q52 k l)) ∧
    (∀ i : SupportIndex52, SWCurrent52 i i → 0 ≤ Complex.re (f (q52 i i)))

theorem q52_p2p2 :
    q52 SupportIndex52.p2 SupportIndex52.p2 = q22_X52 := by
  simp [q52, q_X52, SupportIndex52.toNat]

theorem orientationFunctional_stage8_of_enriched_nonneg (lam : ℂ)
    (henriched : satisfies_enriched_frozen_constraints (orientationFunctional lam))
    (hnonneg : 0 ≤ Complex.re lam) :
    satisfies_stage8_constraints (orientationFunctional lam) := by
  refine ⟨henriched, ?_, ?_, ?_⟩
  · intro i j k l _h
    cases i
    cases j
    cases k
    cases l
    rfl
  · intro i j k l _h
    cases i
    cases j
    cases k
    cases l
    rfl
  · intro i _hsw
    cases i
    rw [q52_p2p2, orientationFunctional_q22]
    exact hnonneg

theorem stage8_orientation_value_real (lam : ℂ)
    (h : satisfies_stage8_constraints (orientationFunctional lam)) :
    star lam = lam := by
  exact (orientationFunctional_enriched_iff_real lam).mp h.1

theorem stage8_orientation_value_nonneg (lam : ℂ)
    (h : satisfies_stage8_constraints (orientationFunctional lam)) :
    0 ≤ Complex.re lam := by
  have hsw := h.2.2.2 SupportIndex52.p2 SWCurrent52_q22
  have hq : orientationFunctional lam (q52 SupportIndex52.p2 SupportIndex52.p2) = lam := by
    rw [q52_p2p2]
    exact orientationFunctional_q22 lam
  simpa [hq] using hsw

theorem orientationFunctional_zero_stage8 :
    satisfies_stage8_constraints (orientationFunctional 0) := by
  apply orientationFunctional_stage8_of_enriched_nonneg
  · exact (orientationFunctional_enriched_iff_real 0).mpr (by norm_num)
  · norm_num

theorem orientationFunctional_one_stage8 :
    satisfies_stage8_constraints (orientationFunctional 1) := by
  apply orientationFunctional_stage8_of_enriched_nonneg
  · exact (orientationFunctional_enriched_iff_real 1).mpr (by norm_num)
  · norm_num

theorem orientationFunctional_zero_ne_one :
    orientationFunctional 0 ≠ orientationFunctional 1 := by
  intro h
  have hq := congrArg (fun f => f q22_X52) h
  norm_num [orientationFunctional_q22] at hq

/--
Stage 8 outcome: the five primitive constraints reduce the old complex
pre-orientation freedom to nonnegative real magnitude, but do not pin a
unique canonical value.  The two witnesses `0` and `1` both satisfy all
Stage 8 constraints and are distinct.
-/
theorem stage8_moduli_not_point :
    ∃ f g : E20_X52 →ₗ[ℂ] ℂ,
      satisfies_stage8_constraints f ∧
      satisfies_stage8_constraints g ∧
      f ≠ g := by
  exact ⟨orientationFunctional 0, orientationFunctional 1,
    orientationFunctional_zero_stage8,
    orientationFunctional_one_stage8,
    orientationFunctional_zero_ne_one⟩

/-- The datum still missing after Stage 8 is a normalization of `f(q₂₂)`. -/
def Stage8_missing_datum : Prop :=
  ∃ value : ℝ, 0 ≤ value

/--
Candidate arithmetic normalization value mentioned after Stage 8.

This is deliberately a candidate, not a forced theorem: Stage 8 proves that a
normalization datum is missing.
-/
noncomputable def J52_log_candidate_value : ℂ :=
  ((Real.log 2) ^ 2 : ℝ)

/-- Candidate normalized functional with `J(q₂₂) = log(2)^2`. -/
noncomputable def J52_log_candidate : E20_X52 →ₗ[ℂ] ℂ :=
  orientationFunctional J52_log_candidate_value

theorem J52_log_candidate_value_real :
    star J52_log_candidate_value = J52_log_candidate_value := by
  simp [J52_log_candidate_value]

theorem J52_log_candidate_value_nonneg :
    0 ≤ Complex.re J52_log_candidate_value := by
  change 0 ≤ (↑((Real.log 2) ^ 2) : ℂ).re
  rw [Complex.ofReal_re]
  exact sq_nonneg (Real.log 2)

/--
The logarithmic arithmetic normalization candidate satisfies all five Stage 8
constraints, but remains an added normalization choice rather than a value
forced by the primitive channels.
-/
theorem J52_log_candidate_satisfies_stage8 :
    satisfies_stage8_constraints J52_log_candidate := by
  unfold J52_log_candidate
  apply orientationFunctional_stage8_of_enriched_nonneg
  · exact (orientationFunctional_enriched_iff_real J52_log_candidate_value).mpr
      J52_log_candidate_value_real
  · exact J52_log_candidate_value_nonneg

theorem J52_log_candidate_q22 :
    J52_log_candidate q22_X52 = J52_log_candidate_value := by
  exact orientationFunctional_q22 J52_log_candidate_value

#check SupportIndex52
#check q52
#check piSigma52
#check ratioCofactor52
#check SWCurrent52
#check grade_22_X52_exit
#check piSigma52_q22
#check ratioCofactor52_q22
#check SWCurrent52_q22
#check satisfies_stage8_constraints
#check orientationFunctional_stage8_of_enriched_nonneg
#check stage8_orientation_value_real
#check stage8_orientation_value_nonneg
#check orientationFunctional_zero_stage8
#check orientationFunctional_one_stage8
#check orientationFunctional_zero_ne_one
#check stage8_moduli_not_point
#check Stage8_missing_datum
#check J52_log_candidate_value
#check J52_log_candidate
#check J52_log_candidate_value_real
#check J52_log_candidate_value_nonneg
#check J52_log_candidate_satisfies_stage8
#check J52_log_candidate_q22

end SR
