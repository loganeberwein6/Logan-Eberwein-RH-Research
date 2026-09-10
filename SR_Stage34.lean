import SR_Stage33

namespace SR

noncomputable def SR_row_sum (X m : Nat) (beta : ℝ) : ℝ :=
  ∑ n ∈ (completeSupport X).toFinset,
    (reesEntryFromNat X m n : ℝ) * ((n : ℝ) ^ (beta - 1 / 2))

def SR_row_sum_half_int (X m : Nat) : Int :=
  ∑ n ∈ (completeSupport X).toFinset, reesEntryFromNat X m n

/-
FULL PROOF ATTEMPT — the proposed row bound is false.

At X = 6 and m = 5, every support n ∈ {2,3,4,5} satisfies 5*n ≥ 6,
so every Rees entry is +1. At beta = 1/2 every power is 1, hence the row
sum is 4. The proposed right side is 2*sqrt(6/5), which is strictly less
than 4. The exact Lean disproof is attempted below.
-/

theorem SR_row_sum_half_counterexample :
    SR_row_sum_half_int 6 5 = 4 := by
  native_decide

end SR
