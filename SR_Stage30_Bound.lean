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

theorem stage30_term_abs_le_weight (X : Nat) (beta gamma : ℝ) (m n : Nat) :
    |stage30_weil_term X beta gamma m n| ≤
      |(m : ℝ) ^ (beta - 1 / 2)| * |(n : ℝ) ^ (beta - 1 / 2)| := by
  unfold stage30_weil_term
  simp only [abs_mul]
  have hre : |(reesEntryFromNat X m n : ℝ)| = 1 := by
    rcases reesEntry_neg_or_pos X m n with h | h <;> simp [h]
  rw [hre]
  simp only [mul_one]
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
    _ = (∑ m ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)|) ^ 2 := by
      simp only [pow_two]
      rw [Finset.sum_mul]
      apply Finset.sum_congr rfl
      intro m hm
      rw [Finset.mul_sum]

/--
Coarse finite upper bound for beta ≤ 1/2. For each m in completeSupport X we
have m ≥ 2, so (m : ℝ) ≥ 1 and therefore |(m : ℝ)^(beta - 1/2)| ≤ 1 when
beta - 1/2 ≤ 0. Summing over the finset gives sum ≤ card, and squaring gives
the card^2 bound.

NOTE: This does NOT close the asymptotic cancellation gap (GAP-F2). It gives a
finite bound uniform in the sign, not a cancellation-sensitive estimate as
X → ∞.
-/
theorem stage30_beta_le_half_abs_le_card_square
    (X : Nat) (beta gamma : ℝ)
    (hbeta : beta ≤ 1 / 2) :
    |stage30_weil_form X beta gamma| ≤
      ((completeSupport X).toFinset.card : ℝ) ^ 2 := by
  have hbound := stage30_bound_trivial X beta gamma
  -- Each summand |(m : ℝ)^(beta - 1/2)| ≤ 1
  have hterm_le_one : ∀ m ∈ (completeSupport X).toFinset,
      |(m : ℝ) ^ (beta - 1 / 2)| ≤ 1 := by
    intro m hm
    have hmem : m ∈ completeSupport X := List.mem_toFinset.mp hm
    have hbounds := completeSupport_mem_bounds hmem
    have hm2 : (2 : ℝ) ≤ (m : ℝ) := by exact_mod_cast hbounds.1
    have hm1 : (1 : ℝ) ≤ (m : ℝ) := by linarith
    have hm_pos : (0 : ℝ) < (m : ℝ) := by linarith
    have hexp : beta - 1 / 2 ≤ 0 := by linarith
    have hrpow_pos : 0 < (m : ℝ) ^ (beta - 1 / 2) :=
      Real.rpow_pos_of_pos hm_pos _
    rw [abs_of_pos hrpow_pos]
    calc (m : ℝ) ^ (beta - 1 / 2)
        ≤ (m : ℝ) ^ (0 : ℝ) := by
          apply Real.rpow_le_rpow_of_exponent_le hm1
          exact hexp
      _ = 1 := Real.rpow_zero _
  -- Sum ≤ card
  have hsum_le_card :
      ∑ m ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)| ≤
        ((completeSupport X).toFinset.card : ℝ) := by
    calc ∑ m ∈ (completeSupport X).toFinset,
            |(m : ℝ) ^ (beta - 1 / 2)|
        ≤ ∑ _m ∈ (completeSupport X).toFinset, (1 : ℝ) := by
          apply Finset.sum_le_sum
          intro m hm
          exact hterm_le_one m hm
      _ = ((completeSupport X).toFinset.card : ℝ) := by
          simp
  -- Square of sum ≤ card^2
  have hsum_nonneg :
      0 ≤ ∑ m ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)| :=
    Finset.sum_nonneg (fun m _ => abs_nonneg _)
  have hcard_nonneg : (0 : ℝ) ≤ (completeSupport X).toFinset.card :=
    Nat.cast_nonneg _
  calc |stage30_weil_form X beta gamma|
      ≤ (∑ m ∈ (completeSupport X).toFinset,
          |(m : ℝ) ^ (beta - 1 / 2)|) ^ 2 := hbound
    _ ≤ ((completeSupport X).toFinset.card : ℝ) ^ 2 := by
        apply sq_le_sq'
        · linarith [hsum_nonneg, hcard_nonneg]
        · exact hsum_le_card

end SR
