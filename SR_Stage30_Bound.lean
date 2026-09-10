import SR_Bridge
import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace SR

noncomputable def stage30_weil_term (X : Nat) (beta gamma : ℝ) (m n : Nat) : ℝ :=
  (m : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log m) *
    (reesEntryFromNat X m n : ℝ) *
    (n : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log n)

noncomputable def stage30_weil_form (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      stage30_weil_term X beta gamma m n

theorem stage30_term_abs_le_weight (X : Nat) (beta gamma : ℝ) (m n : Nat)
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X) :
    |stage30_weil_term X beta gamma m n| ≤
      |(m : ℝ) ^ (beta - 1 / 2)| * |(n : ℝ) ^ (beta - 1 / 2)| := by
  unfold stage30_weil_term
  simp only [abs_mul]
  have hre : |(reesEntryFromNat X m n : ℝ)| = 1 := by
    rcases reesEntry_neg_or_pos X m n with h | h <;> simp [h]
  rw [hre]
  simp only [one_mul, mul_one]
  have hmcos : |Real.cos (gamma * Real.log m)| ≤ 1 :=
    Real.abs_cos_le_one _
  have hncos : |Real.cos (gamma * Real.log n)| ≤ 1 :=
    Real.abs_cos_le_one _
  have hmnonneg : 0 ≤ |(m : ℝ) ^ (beta - 1 / 2)| := abs_nonneg _
  have hnnonneg : 0 ≤ |(n : ℝ) ^ (beta - 1 / 2)| := abs_nonneg _
  calc
    |(m : ℝ) ^ (beta - 1 / 2)| * |Real.cos (gamma * Real.log m)| *
          |(n : ℝ) ^ (beta - 1 / 2)| * |Real.cos (gamma * Real.log n)| ≤
        |(m : ℝ) ^ (beta - 1 / 2)| * 1 *
          |(n : ℝ) ^ (beta - 1 / 2)| * 1 := by
            gcongr
    _ = |(m : ℝ) ^ (beta - 1 / 2)| * |(n : ℝ) ^ (beta - 1 / 2)| := by ring

theorem stage30_bound_trivial (X : Nat) (beta gamma : ℝ) :
    |stage30_weil_form X beta gamma| ≤
      (∑ m ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)|) ^ 2 := by
  unfold stage30_weil_form
  calc
    |∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          stage30_weil_term X beta gamma m n| ≤
        ∑ m ∈ (completeSupport X).toFinset,
          ∑ n ∈ (completeSupport X).toFinset,
            |stage30_weil_term X beta gamma m n| := by
      calc
        |∑ m ∈ (completeSupport X).toFinset,
            ∑ n ∈ (completeSupport X).toFinset,
              stage30_weil_term X beta gamma m n| ≤
            ∑ m ∈ (completeSupport X).toFinset,
              |∑ n ∈ (completeSupport X).toFinset,
                stage30_weil_term X beta gamma m n| :=
          Finset.abs_sum_le_sum_abs _ _
        _ ≤ ∑ m ∈ (completeSupport X).toFinset,
            ∑ n ∈ (completeSupport X).toFinset,
              |stage30_weil_term X beta gamma m n| := by
          apply Finset.sum_le_sum
          intro m hm
          exact Finset.abs_sum_le_sum_abs _ _
    _ ≤ ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          |(m : ℝ) ^ (beta - 1 / 2)| *
            |(n : ℝ) ^ (beta - 1 / 2)| := by
      apply Finset.sum_le_sum
      intro m hm
      apply Finset.sum_le_sum
      intro n hn
      exact stage30_term_abs_le_weight X beta gamma m n
        (by simpa using hm) (by simpa using hn)
    _ = (∑ m ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)|) ^ 2 := by
      simp only [pow_two]
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro m hm
      rw [Finset.mul_sum]

end SR
