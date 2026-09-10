import SR_Stage31
import Mathlib.Analysis.SumIntegralComparisons
import Mathlib.Analysis.SpecialFunctions.Integrals.Basic

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

theorem sr33_sum_rpow_bound_pos (N : Nat) (s : ℝ) (hs : 0 < s) :
    ∑ k ∈ Finset.range N, ((k : ℝ) ^ s) ≤
      (N : ℝ) ^ (s + 1) / (s + 1) := by
  have hmono : MonotoneOn (fun x : ℝ => x ^ s) (Set.Icc 0 N) := by
    intro a ha b hb hab
    exact Real.rpow_le_rpow ha.1 hab hs.le
  have hmono' : MonotoneOn (fun x : ℝ => x ^ s) (Set.Icc 0 (0 + (N : ℝ))) := by
    simpa using hmono
  have hsum := MonotoneOn.sum_le_integral (x₀ := (0 : ℝ)) (a := N) hmono'
  rw [integral_rpow (Or.inl (by linarith : (-1 : ℝ) < s))] at hsum
  rw [Real.zero_rpow (by linarith : 0 < s + 1).ne', sub_zero, zero_add] at hsum
  simpa using hsum

theorem sr33_support_rpow_bound_pos (X : Nat) (hX : 6 ≤ X) (s : ℝ) (hs : 0 < s) :
    ∑ m ∈ (completeSupport X).toFinset, ((m : ℝ) ^ s) ≤
      (X : ℝ) ^ (s + 1) / (s + 1) := by
  have hle : ∑ m ∈ (completeSupport X).toFinset, ((m : ℝ) ^ s) ≤
      ∑ k ∈ Finset.range X, ((k : ℝ) ^ s) := by
    apply Finset.sum_le_sum_of_subset_of_nonneg
    · intro k hk
      simpa [Finset.mem_range] using
        (completeSupport_mem_bounds (by simpa using hk)).2
    · intro k hk hnot
      positivity
  exact hle.trans (sr33_sum_rpow_bound_pos X s hs)

theorem sr33_support_shifted_sum (X : Nat) (s : ℝ) :
    ∑ k ∈ Finset.range (X - 2), (((k + 2 : Nat) : ℝ) ^ s) =
      ∑ m ∈ (completeSupport X).toFinset, ((m : ℝ) ^ s) := by
  apply Finset.sum_nbij' (fun k => k + 2) (fun m => m - 2)
  · intro k hk
    simp only [Finset.mem_range] at hk ⊢
    exact List.mem_toFinset.mpr (by
      unfold completeSupport
      simp only [List.mem_map]
      exact ⟨k, List.mem_range.mpr hk, rfl⟩)
  · intro m hm
    have hbounds := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
    simp only [Finset.mem_range]
    omega
  · intro k hk
    simp
  · intro m hm
    have hbounds := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
    omega
  · intro k hk
    rfl

theorem sr33_shifted_rpow_bound_neg (N : Nat) (s : ℝ)
    (hsneg : -1 < s) (hs : s < 0) :
    ∑ k ∈ Finset.range N, (((k + 2 : Nat) : ℝ) ^ s) ≤
      (N + 1 : ℝ) ^ (s + 1) / (s + 1) := by
  have hanti : AntitoneOn (fun x : ℝ => x ^ s) (Set.Icc 1 (1 + (N : ℝ))) := by
    intro a ha b hb hab
    exact Real.rpow_le_rpow_of_nonpos (by linarith [ha.1]) hab hs.le
  have hanti' : AntitoneOn (fun x : ℝ => x ^ s)
      (Set.Icc 1 (1 + (N : ℝ))) := hanti
  have hsum := AntitoneOn.sum_le_integral (x₀ := (1 : ℝ)) (a := N) hanti'
  rw [integral_rpow (Or.inl hsneg)] at hsum
  rw [Real.one_rpow] at hsum
  have hpos : 0 < (N + 1 : ℝ) ^ (s + 1) := by positivity
  have hden : 0 < s + 1 := by linarith
  have hle : ((N + 1 : ℝ) ^ (s + 1) - 1) / (s + 1) ≤
      (N + 1 : ℝ) ^ (s + 1) / (s + 1) := by
    apply (div_le_div_iff_of_pos_right hden).2
    linarith
  have hsum' :
      ∑ k ∈ Finset.range N, (((k + 2 : Nat) : ℝ) ^ s) ≤
        ((N + 1 : ℝ) ^ (s + 1) - 1) / (s + 1) := by
    calc
      _ = ∑ k ∈ Finset.range N, (1 + ((k : ℝ) + 1)) ^ s := by
        apply Finset.sum_congr rfl
        intro k hk
        congr 1
        norm_num [Nat.cast_add]
        ring_nf
      _ ≤ ((1 + (N : ℝ)) ^ (s + 1) - 1) / (s + 1) := by
        simpa [Nat.cast_add] using hsum
      _ = _ := by congr 2 <;> ring_nf
  exact hsum'.trans hle

theorem SR_ratio_diagonal_bound_pos
    (X : Nat) (hX : 6 ≤ X) (beta : ℝ) (hbeta : 1 / 2 < beta) :
    |∑ m ∈ (completeSupport X).toFinset,
      (reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * beta - 1))| ≤
      (X : ℝ) ^ (2 * beta) / (2 * beta) := by
  have hs : 0 < 2 * beta - 1 := by linarith
  calc
    |∑ m ∈ (completeSupport X).toFinset,
        (reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * beta - 1))| ≤
        ∑ m ∈ (completeSupport X).toFinset,
          |(reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * beta - 1))| :=
      Finset.abs_sum_le_sum_abs _ _
    _ = ∑ m ∈ (completeSupport X).toFinset,
        ((m : ℝ) ^ (2 * beta - 1)) := by
      apply Finset.sum_congr rfl
      intro m hm
      have hre : |(reesEntryFromNat X m m : ℝ)| = 1 := by
        rcases reesEntry_neg_or_pos X m m with h | h <;> simp [h]
      rw [abs_mul, hre, one_mul,
        abs_of_nonneg (Real.rpow_nonneg (by positivity) _)]
    _ ≤ (X : ℝ) ^ ((2 * beta - 1) + 1) / ((2 * beta - 1) + 1) :=
      sr33_support_rpow_bound_pos X hX (2 * beta - 1) hs
    _ = (X : ℝ) ^ (2 * beta) / (2 * beta) := by ring_nf

theorem SR_ratio_diagonal_bound_neg
    (X : Nat) (hX : 6 ≤ X) (beta : ℝ) (hbeta : 0 < beta)
    (hbeta' : beta < 1 / 2) :
    |∑ m ∈ (completeSupport X).toFinset,
      (reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * beta - 1))| ≤
      (X : ℝ) ^ (2 * beta) / (2 * beta) := by
  have hsneg : -1 < 2 * beta - 1 := by linarith
  have hs : 2 * beta - 1 < 0 := by linarith
  have hsum :
      ∑ m ∈ (completeSupport X).toFinset, ((m : ℝ) ^ (2 * beta - 1)) =
        ∑ k ∈ Finset.range (X - 2), (((k + 2 : Nat) : ℝ) ^ (2 * beta - 1)) :=
    sr33_support_shifted_sum X (2 * beta - 1) |>.symm
  calc
    |∑ m ∈ (completeSupport X).toFinset,
        (reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * beta - 1))| ≤
        ∑ m ∈ (completeSupport X).toFinset,
          |(reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * beta - 1))| :=
      Finset.abs_sum_le_sum_abs _ _
    _ = ∑ m ∈ (completeSupport X).toFinset,
        ((m : ℝ) ^ (2 * beta - 1)) := by
      apply Finset.sum_congr rfl
      intro m hm
      have hre : |(reesEntryFromNat X m m : ℝ)| = 1 := by
        rcases reesEntry_neg_or_pos X m m with h | h <;> simp [h]
      rw [abs_mul, hre, one_mul,
        abs_of_nonneg (Real.rpow_nonneg (by positivity) _)]
    _ = ∑ k ∈ Finset.range (X - 2), (((k + 2 : Nat) : ℝ) ^ (2 * beta - 1)) := hsum
    _ ≤ ((X - 1 : Nat) : ℝ) ^ (2 * beta) / (2 * beta) := by
      have hcast : ((X - 2 : Nat) : ℝ) + 1 = (X - 1 : Nat) := by
        rw [Nat.cast_sub (by omega), Nat.cast_sub (by omega)]
        norm_num
        ring
      simpa [hcast] using
        sr33_shifted_rpow_bound_neg (X - 2) (2 * beta - 1) hsneg hs
    _ ≤ (X : ℝ) ^ (2 * beta) / (2 * beta) := by
      apply (div_le_div_iff_of_pos_right (by linarith : 0 < 2 * beta)).2
      have hbase : ((X - 1 : Nat) : ℝ) ≤ (X : ℝ) := by
        rw [Nat.cast_sub (by omega)]
        linarith
      exact Real.rpow_le_rpow (by positivity) hbase (by linarith)

theorem SR_ratio_diagonal_bound
    (X : Nat) (hX : 6 ≤ X) (beta : ℝ) (hb : 0 < beta) :
    |∑ m ∈ (completeSupport X).toFinset,
      (reesEntryFromNat X m m : ℝ) * ((m : ℝ) ^ (2 * beta - 1))| ≤
      (X : ℝ) ^ (2 * beta) / (2 * beta) := by
  by_cases hlt : beta < 1 / 2
  · exact SR_ratio_diagonal_bound_neg X hX beta hb hlt
  · by_cases heq : beta = 1 / 2
    · simpa [heq] using SR_ratio_diagonal_bound_beta_half X hX
    · have hle : 1 / 2 ≤ beta := le_of_not_gt hlt
      exact SR_ratio_diagonal_bound_pos X hX beta (lt_of_le_of_ne hle (Ne.symm heq))

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

Successful positive-exponent sum bound:
  MonotoneOn.sum_le_integral (with x₀ = 0 and a = N)
  rw [integral_rpow (Or.inl ...)]
  rw [Real.zero_rpow ... .ne', sub_zero, zero_add]
  simpa
The theorem `sr33_sum_rpow_bound_pos` now compiles. The initial error was
`Unknown identifier integral_rpow`; importing
`Mathlib.Analysis.SpecialFunctions.Integrals.Basic` fixed it. The next error
was a residual `0 ^ (s+1)`, fixed by the explicit zero-rpow rewrite.

Successful support assembly:
  use `Finset.sum_le_sum_of_subset_of_nonneg` with
  `completeSupport X ⊆ Finset.range X` via `completeSupport_mem_bounds`;
  apply `sr33_sum_rpow_bound_pos X s hs`.
The theorem `sr33_support_rpow_bound_pos` now compiles. An earlier shifted
range comparison failed because its summand was indexed by `k + 2`, so it was
not the same function on the ambient range; the direct support subset fixes
that mismatch.

Successful positive-beta assembly:
  set `s = 2 * beta - 1` and prove `0 < s` by `linarith`;
  apply `Finset.abs_sum_le_sum_abs`;
  rewrite each term with `abs_mul`, the exact entry absolute value, and
  `Real.rpow_nonneg`;
  apply `sr33_support_rpow_bound_pos`;
  close the exponent identity with `ring_nf`.
The theorem `SR_ratio_diagonal_bound_pos` now compiles.

Successful negative-beta assembly:
  set `s = 2 * beta - 1`, derive `-1 < s` and `s < 0` by `linarith`;
  apply the absolute-value reduction;
  reindex the support with `sr33_support_shifted_sum`;
  apply `sr33_shifted_rpow_bound_neg`;
  compare `(X - 1)^(2*beta)` with `X^(2*beta)` using `Real.rpow_le_rpow`.
The theorem `SR_ratio_diagonal_bound_neg` now compiles.

Successful final assembly:
  split on `beta < 1/2`, then on `beta = 1/2`; use the negative, on-line,
  and positive branches respectively. The exact requested theorem
  `SR_ratio_diagonal_bound` now compiles.

Attempt 2 (power-sum induction): the proposed successor step would require
  n^(s+1)/(s+1) + (n+1)^s <= (n+1)^(s+1)/(s+1).
This does not follow from the stated endpoint integral comparison; the
integral of an increasing function bounds the left endpoint in the opposite
direction.  No theorem is promoted from this invalid route.

The analytic target remains intentionally unstated here until a proof without
`sorry`, `axiom`, or an unsound imported theorem is available.
-/

end SR
