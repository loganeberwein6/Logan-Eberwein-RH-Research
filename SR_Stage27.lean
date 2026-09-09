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

theorem list_abs_sum_le_sum_abs (l : List ℝ) :
    |l.sum| ≤ (l.map (fun x => |x|)).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
      calc
        |a + l.sum| ≤ |a| + |l.sum| := abs_add_le _ _
        _ ≤ |a| + (l.map (fun x => |x|)).sum :=
          by simpa [add_comm] using add_le_add_left ih |a|
        _ = ((a :: l).map (fun x => |x|)).sum := by
          simp [List.sum_cons]

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

/-! The currently certified finite observable is `W_SR_primorial`, whose
    definition is zero away from the listed primorial checkpoints.  Its
    density is therefore a different object from the empirical signature
    density proposed in the objective; we expose that distinction explicitly. -/
noncomputable def W_SR_primorial_density (N : Nat) : ℝ :=
  ((Finset.filter (fun X => W_SR_primorial X = 1) (Finset.range N)).card : ℝ) /
    (N : ℝ)

theorem W_SR_primorial_density_zero (N : Nat) (hN : 0 < N) :
    W_SR_primorial_density N = 0 := by
  unfold W_SR_primorial_density
  have hfilter : Finset.filter (fun X => W_SR_primorial X = 1)
      (Finset.range N) = ∅ := by
    ext X
    have hz : W_SR_primorial X = 0 := by
      unfold W_SR_primorial
      split <;> rfl
    simp [hz]
  rw [hfilter]
  simp [hN]

theorem W_SR_primorial_density_converges_zero :
    ∀ ε : ℝ, 0 < ε → ∃ N₀ : Nat, ∀ N : Nat, N₀ ≤ N →
      |W_SR_primorial_density N - 0| < ε := by
  intro ε hε
  refine ⟨1, ?_⟩
  intro N hN
  have hNpos : 0 < N := lt_of_lt_of_le Nat.zero_lt_one hN
  rw [W_SR_primorial_density_zero N hNpos]
  simpa using hε

end SR
