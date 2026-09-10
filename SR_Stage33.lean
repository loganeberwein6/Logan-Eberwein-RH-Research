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

private lemma sr33_range_filter_lt_card (n m : Nat) :
    ((List.range n).filter (fun k => k < m)).length = min m n := by
  induction n with
  | zero => simp
  | succ n ih =>
      rw [List.range_succ, List.filter_append, List.length_append, ih]
      by_cases h : n < m
      · simp [h]; omega
      · simp [show ¬ n < m from h]; omega

theorem SR_sqrt_cutoff_formula (X : Nat) (hX : 6 ≤ X) :
    SR_sqrt_cutoff_count X = Nat.sqrt (X - 1) - 1 := by
  simp only [SR_sqrt_cutoff_count, completeSupport, List.filter_map, List.length_map]
  have hsqrt : 2 ≤ Nat.sqrt (X - 1) := by
    apply (Nat.le_sqrt).2
    omega
  have hfilt :
      (List.range (X - 2)).filter ((fun m => decide (m * m < X)) ∘ (· + 2)) =
        (List.range (X - 2)).filter (fun k => decide (k < Nat.sqrt (X - 1) - 1)) := by
    apply List.filter_congr
    intro k _
    simp only [Function.comp]
    have hiff : (k + 2) * (k + 2) < X ↔ k < Nat.sqrt (X - 1) - 1 := by
      have hsq : (k + 2) * (k + 2) ≤ X - 1 ↔ k + 2 ≤ Nat.sqrt (X - 1) :=
        (Nat.le_sqrt).symm
      rw [show (k + 2) * (k + 2) < X ↔ (k + 2) * (k + 2) ≤ X - 1 by omega]
      rw [hsq]
      omega
    simp only [hiff]
  rw [hfilt, sr33_range_filter_lt_card]
  apply Nat.min_eq_left
  have hroot : Nat.sqrt (X - 1) ≤ X - 1 := Nat.sqrt_le_self _
  omega

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

Successful cutoff proof:
  normalize `completeSupport` to a mapped range;
  prove `sr33_range_filter_lt_card` by induction on the range length;
  use `Nat.le_sqrt` (in the reverse orientation) after converting `< X` to
  `≤ X - 1`; finish the range bound with `Nat.sqrt_le_self` and `omega`.
The theorem `SR_sqrt_cutoff_formula` now compiles.

Attempt 2 (power-sum induction): the proposed successor step would require
  n^(s+1)/(s+1) + (n+1)^s <= (n+1)^(s+1)/(s+1).
This does not follow from the stated endpoint integral comparison; the
integral of an increasing function bounds the left endpoint in the opposite
direction.  No theorem is promoted from this invalid route.

The analytic target remains intentionally unstated here until a proof without
`sorry`, `axiom`, or an unsound imported theorem is available.
-/

end SR
