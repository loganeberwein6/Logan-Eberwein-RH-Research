import SR_Stage34

namespace SR

noncomputable def SR_row_sum_cos (X m : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ n ∈ (completeSupport X).toFinset,
    (reesEntryFromNat X m n : ℝ) * ((n : ℝ) ^ (beta - 1 / 2)) *
      Real.cos (gamma * (Real.log m - Real.log n))

theorem SR_row_sum_trivial_bound
    (X m : Nat) (hX : 6 ≤ X) (hm : m ∈ completeSupport X)
    (beta gamma : ℝ) (hb : 0 < beta) :
    |SR_row_sum_cos X m beta gamma| ≤
      ∑ n ∈ (completeSupport X).toFinset, ((n : ℝ) ^ (beta - 1 / 2)) := by
  unfold SR_row_sum_cos
  apply le_trans (Finset.abs_sum_le_sum_abs _ _)
  apply Finset.sum_le_sum
  intro n hn
  rw [abs_mul, abs_mul]
  have hre : |(reesEntryFromNat X m n : ℝ)| = 1 := by
    rcases reesEntry_neg_or_pos X m n with h | h <;> simp [h]
  rw [hre]
  rw [abs_of_nonneg (Real.rpow_nonneg (by positivity) _)]
  calc
    1 * ((n : ℝ) ^ (beta - 1 / 2)) *
        |Real.cos (gamma * (Real.log m - Real.log n))| ≤
        1 * ((n : ℝ) ^ (beta - 1 / 2)) * 1 := by
      gcongr
      exact Real.abs_cos_le_one _
    _ = ((n : ℝ) ^ (beta - 1 / 2)) := by ring

noncomputable def SR_offdiag_sum (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      if m ≠ n then
        (reesEntryFromNat X m n : ℝ) * (((m : ℝ) * n) ^ (beta - 1 / 2)) *
          Real.cos (gamma * (Real.log m - Real.log n))
      else 0

theorem SR_off_diagonal_trivial_bound
    (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) (hb : 0 < beta) :
    |SR_offdiag_sum X beta gamma| ≤
      (∑ m ∈ (completeSupport X).toFinset, ((m : ℝ) ^ (beta - 1 / 2))) ^ 2 := by
  unfold SR_offdiag_sum
  apply le_trans (Finset.abs_sum_le_sum_abs _ _)
  calc
    (∑ m ∈ (completeSupport X).toFinset,
        |∑ n ∈ (completeSupport X).toFinset,
          if m ≠ n then
            (reesEntryFromNat X m n : ℝ) * (((m : ℝ) * n) ^ (beta - 1 / 2)) *
              Real.cos (gamma * (Real.log m - Real.log n))
          else 0|) ≤
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          |if m ≠ n then
              (reesEntryFromNat X m n : ℝ) * (((m : ℝ) * n) ^ (beta - 1 / 2)) *
                Real.cos (gamma * (Real.log m - Real.log n))
            else 0| := by
      apply Finset.sum_le_sum
      intro m hm
      exact Finset.abs_sum_le_sum_abs _ _
    _ ≤
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          ((m : ℝ) ^ (beta - 1 / 2)) * ((n : ℝ) ^ (beta - 1 / 2)) := by
      apply Finset.sum_le_sum
      intro m hm
      apply Finset.sum_le_sum
      intro n hn
      split_ifs with hmn
      · rw [abs_mul, abs_mul]
        have hre : |(reesEntryFromNat X m n : ℝ)| = 1 := by
          rcases reesEntry_neg_or_pos X m n with h | h <;> simp [h]
        rw [hre]
        rw [Real.mul_rpow (by positivity) (by positivity)]
        rw [abs_of_nonneg (mul_nonneg (Real.rpow_nonneg (by positivity) _)
          (Real.rpow_nonneg (by positivity) _))]
        calc
          1 * (((m : ℝ) ^ (beta - 1 / 2)) *
              ((n : ℝ) ^ (beta - 1 / 2))) *
              |Real.cos (gamma * (Real.log m - Real.log n))| ≤
            1 * (((m : ℝ) ^ (beta - 1 / 2)) *
              ((n : ℝ) ^ (beta - 1 / 2))) * 1 := by
                gcongr
                exact Real.abs_cos_le_one _
          _ = ((m : ℝ) ^ (beta - 1 / 2)) *
              ((n : ℝ) ^ (beta - 1 / 2)) := by ring
      · simp
        positivity
    _ = (∑ m ∈ (completeSupport X).toFinset, ((m : ℝ) ^ (beta - 1 / 2))) ^ 2 := by
      rw [pow_two]
      rw [Finset.sum_comm]
      rw [Finset.mul_sum]
      apply Finset.sum_congr rfl
      intro n hn
      rw [Finset.sum_mul]

def SR_gram_entry (X m n : Nat) : Int :=
  ∑ k ∈ (completeSupport X).toFinset,
    reesEntryFromNat X k m * reesEntryFromNat X k n

theorem SR_gram_entry_X6_5_5 : SR_gram_entry 6 5 5 = 4 := by native_decide
theorem SR_gram_entry_X6_2_5 : SR_gram_entry 6 2 5 = 2 := by native_decide

end SR
