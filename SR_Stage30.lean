import SR_Stage30_Bound

namespace SR

noncomputable def stage30_unsigned_weight (beta gamma : ℝ) (m n : Nat) : ℝ :=
  (m : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log m) *
    (n : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log n)

noncomputable def stage30_unsigned_total (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      stage30_unsigned_weight beta gamma m n

noncomputable def stage30_unsigned_interior (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      if m * n < X then stage30_unsigned_weight beta gamma m n else 0

theorem stage30_form_eq_total_minus_two_interior (X : Nat) (beta gamma : ℝ) :
    stage30_weil_form X beta gamma =
      stage30_unsigned_total X beta gamma -
        2 * stage30_unsigned_interior X beta gamma := by
  unfold stage30_weil_form stage30_unsigned_total stage30_unsigned_interior
  rw [Finset.mul_sum]
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  have hdist :
      2 * (∑ n ∈ (completeSupport X).toFinset,
        if m * n < X then stage30_unsigned_weight beta gamma m n else 0) =
      ∑ n ∈ (completeSupport X).toFinset,
        2 * (if m * n < X then stage30_unsigned_weight beta gamma m n else 0) := by
    rw [Finset.mul_sum]
  rw [hdist]
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  by_cases h : m * n < X
  · simp [stage30_weil_term, stage30_unsigned_weight, rees_decomposition, h] <;> ring
  · simp [stage30_weil_term, stage30_unsigned_weight, rees_decomposition, h]

theorem stage30_trivial_bound (X : Nat) (beta gamma : ℝ) :
    |stage30_weil_form X beta gamma| ≤
      (∑ m ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)|) ^ 2 :=
  stage30_bound_trivial X beta gamma

end SR
