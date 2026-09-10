import SR_Stage31
import Mathlib.Analysis.SumIntegralComparisons

namespace SR

theorem SR_ratio_diagonal_bound_beta_half
    (X : Nat) (hX : 6 ≤ X) :
    |∑ m ∈ (completeSupport X).toFinset,
      (reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * (1 / 2 : ℝ) - 1))| ≤
      (X : ℝ) ^ (2 * (1 / 2 : ℝ)) / (2 * (1 / 2 : ℝ)) := by
  norm_num
  calc
    |∑ m ∈ (completeSupport X).toFinset, (reesEntryFromNat X m m : ℝ)| ≤
        ∑ m ∈ (completeSupport X).toFinset, |(reesEntryFromNat X m m : ℝ)| :=
      Finset.abs_sum_le_sum_abs _ _
    _ = (X : ℝ) - 2 := by
      calc
        (∑ m ∈ (completeSupport X).toFinset, |(reesEntryFromNat X m m : ℝ)|) =
            ∑ m ∈ (completeSupport X).toFinset, (1 : ℝ) := by
          apply Finset.sum_congr rfl
          intro m hm
          rcases reesEntry_neg_or_pos X m m with h | h <;> simp [h]
        _ = (X : ℝ) - 2 := by
          have hnd : (completeSupport X).Nodup := by
            unfold completeSupport
            exact List.Nodup.map (fun a b h => Nat.add_right_cancel h) List.nodup_range
          simp only [Finset.sum_const, nsmul_eq_mul, mul_one]
          rw [List.toFinset_card_of_nodup hnd, completeSupport_length]
          rw [Nat.cast_sub (by omega)]
          norm_num
    _ ≤ (X : ℝ) := by norm_num

/-
Stage 33 proof log.

Successful subcase (on-line exponent):
theorem SR_ratio_diagonal_bound_beta_half ...
compiled successfully. The tactic sequence was:
  norm_num
  exact Finset.abs_sum_le_sum_abs _ _
  rcases reesEntry_neg_or_pos X m m with h | h <;> simp [h]
  exact List.Nodup.map (fun a b h => Nat.add_right_cancel h) List.nodup_range
  rw [List.toFinset_card_of_nodup hnd, completeSupport_length]
  rw [Nat.cast_sub (by omega)]
  norm_num
This proves the beta = 1/2 case, with no sorry or axiom.

Attempt 1 (cutoff cardinality):
  simp [SR_sqrt_cutoff_count, completeSupport]
Compiler result:
  unsolved goal
  (List.filter (fun m => decide (m * m < X))
    (List.map (fun k => k + 2) (List.range (X - 2)))).length
    = (X - 1).sqrt - 1
The remaining obligation is the Nat.sqrt/filter equivalence; `simp` does not
derive it automatically.

Attempt 2 (power-sum induction): the proposed successor step would require
  n^(s+1)/(s+1) + (n+1)^s <= (n+1)^(s+1)/(s+1).
This does not follow from the stated endpoint integral comparison; the
integral of an increasing function bounds the left endpoint in the opposite
direction.  No theorem is promoted from this invalid route.

The analytic target remains intentionally unstated here until a proof without
`sorry`, `axiom`, or an unsound imported theorem is available.
-/

end SR
