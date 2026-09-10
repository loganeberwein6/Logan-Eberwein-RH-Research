import SR_Stage30_Bound
import SR_WEntropy

namespace SR

theorem cos_mul_cos (A B : ℝ) :
    Real.cos A * Real.cos B =
      (Real.cos (A - B) + Real.cos (A + B)) / 2 := by
  rw [Real.cos_sub, Real.cos_add]
  ring

noncomputable def SR_channel_ratio (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      (reesEntryFromNat X m n : ℝ) *
        ((m : ℝ) * n) ^ (beta - 1 / 2) *
        Real.cos (gamma * (Real.log m - Real.log n))

noncomputable def SR_channel_product (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      (reesEntryFromNat X m n : ℝ) *
        ((m : ℝ) * n) ^ (beta - 1 / 2) *
        Real.cos (gamma * (Real.log m + Real.log n))

theorem SR_two_channel_decomposition
    (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) :
    stage30_weil_form X beta gamma =
      (1 / 2 : ℝ) * SR_channel_ratio X beta gamma +
        (1 / 2 : ℝ) * SR_channel_product X beta gamma := by
  unfold stage30_weil_form SR_channel_ratio SR_channel_product
  rw [Finset.mul_sum, Finset.mul_sum]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  rw [Finset.mul_sum, Finset.mul_sum]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  unfold stage30_weil_term
  have hmul : 0 ≤ (m : ℝ) := by positivity
  have hmul' : 0 ≤ (n : ℝ) := by positivity
  have hpow :
      ((m : ℝ) * n) ^ (beta - 1 / 2) =
        (m : ℝ) ^ (beta - 1 / 2) * (n : ℝ) ^ (beta - 1 / 2) := by
    rw [Real.mul_rpow hmul hmul']
  rw [hpow]
  have hcos := cos_mul_cos (gamma * Real.log m) (gamma * Real.log n)
  rw [← mul_sub, ← mul_add] at hcos
  calc
    (m : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log m) *
        (reesEntryFromNat X m n : ℝ) * (n : ℝ) ^ (beta - 1 / 2) *
        Real.cos (gamma * Real.log n) =
      (reesEntryFromNat X m n : ℝ) *
        ((m : ℝ) ^ (beta - 1 / 2) * (n : ℝ) ^ (beta - 1 / 2)) *
        (Real.cos (gamma * Real.log m) * Real.cos (gamma * Real.log n)) := by ring
    _ = (reesEntryFromNat X m n : ℝ) *
        ((m : ℝ) ^ (beta - 1 / 2) * (n : ℝ) ^ (beta - 1 / 2)) *
        ((Real.cos (gamma * (Real.log m - Real.log n)) +
          Real.cos (gamma * (Real.log m + Real.log n))) / 2) := by rw [hcos]
    _ = 1 / 2 * ((reesEntryFromNat X m n : ℝ) *
          ((m : ℝ) ^ (beta - 1 / 2) * (n : ℝ) ^ (beta - 1 / 2)) *
          Real.cos (gamma * (Real.log m - Real.log n))) +
        1 / 2 * ((reesEntryFromNat X m n : ℝ) *
          ((m : ℝ) ^ (beta - 1 / 2) * (n : ℝ) ^ (beta - 1 / 2)) *
          Real.cos (gamma * (Real.log m + Real.log n))) := by ring

def SR_sqrt_cutoff_count (X : Nat) : Nat :=
  ((completeSupport X).filter (fun m => m * m < X)).length

def SR_diagonal_sign_sum (X : Nat) : Int :=
  ((completeSupport X).map (fun m =>
    if m * m < X then (-1 : Int) else 1)).sum

theorem SR_diagonal_X6 : SR_diagonal_sign_sum 6 = 2 := by native_decide

theorem SR_diagonal_X30 : SR_diagonal_sign_sum 30 = 20 := by native_decide

theorem SR_diagonal_X100 : SR_diagonal_sign_sum 100 = 82 := by native_decide

theorem SR_diagonal_ne_trace_X30 :
    SR_diagonal_sign_sum 30 ≠ reesTrace 30 := by native_decide

end SR
