import SR_Bridge
import SR_WEntropy
import Mathlib.Data.Real.Basic

namespace SR

/-! Stage 27: the consistent logarithmic kappa normalization.

The denominator uses the same typed logarithmic sums as the Cauchy theorem.
The available Cauchy estimate controls `SR_Sint_log`, not the signed
half-weighted sum, so the upper bound is stated with its exact missing
comparison as a hypothesis below. -/

noncomputable def SR_kappa_log (X : Nat) : ℝ :=
  if 0 < SR_S2_log_typed X * SR_S3_log_typed X then
    SR_HalfWeightedSum X ^ 2 /
      (SR_S2_log_typed X * SR_S3_log_typed X)
  else 0

theorem SR_kappa_log_nonneg (X : Nat) : 0 ≤ SR_kappa_log X := by
  unfold SR_kappa_log
  split_ifs with h
  · positivity
  · norm_num

theorem SR_kappa_log_le_one_of_signed_cauchy
    (X : Nat)
    (hbound : SR_HalfWeightedSum X ^ 2 ≤
      SR_S2_log_typed X * SR_S3_log_typed X) :
    SR_kappa_log X ≤ 1 := by
  unfold SR_kappa_log
  split_ifs with h
  · exact (div_le_one h).2 hbound
  · norm_num

theorem SR_kappa_log_in_01_of_signed_cauchy
    (X : Nat)
    (hbound : SR_HalfWeightedSum X ^ 2 ≤
      SR_S2_log_typed X * SR_S3_log_typed X) :
    0 ≤ SR_kappa_log X ∧ SR_kappa_log X ≤ 1 := by
  exact ⟨SR_kappa_log_nonneg X,
    SR_kappa_log_le_one_of_signed_cauchy X hbound⟩

end SR
