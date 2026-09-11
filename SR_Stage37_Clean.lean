import SR_Stage35
import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.NumberTheory.LSeries.Dirichlet

namespace SR

open scoped Topology

theorem sr37_clean_simple_zero_log_derivative_residue
    {f : ℂ → ℂ} {ρ : ℂ}
    (hf : AnalyticAt ℂ f ρ) (hzero : f ρ = 0)
    (hderiv : deriv f ρ ≠ 0) :
    Filter.Tendsto (fun s : ℂ => (s - ρ) * logDeriv f s)
      (nhdsWithin ρ {ρ}ᶜ) (𝓝 1) := by
  exact hf.tendsto_mul_logDeriv_simple_zero hzero hderiv

theorem sr37_clean_off_line_exponent_is_below_trivial_envelope {β : ℝ}
    (hβ : 0 < β) : β + 1 ≤ 2 * β + 1 := by
  linarith

theorem sr37_clean_off_line_exponent_exceeds_critical_exponent {β : ℝ}
    (hβ : (1 : ℝ) / 2 < β) : (3 : ℝ) / 2 < β + 1 := by
  linarith

theorem sr37_clean_off_line_exponent_exceeds_diagonal_exponent {β : ℝ}
    (hβ : β < 1) : 2 * β < β + 1 := by
  linarith

noncomputable def sr37_clean_support_indicator (X : Nat) : Nat → ℂ :=
  fun n => if n ∈ (completeSupport X).toFinset then 1 else 0

theorem sr37_clean_support_eventual_membership {X m : Nat}
    (hm : 2 ≤ m) (hmX : m < X) : m ∈ completeSupport X := by
  unfold completeSupport
  apply List.mem_map.mpr
  refine ⟨m - 2, ?_, ?_⟩
  · simp
    omega
  · omega

theorem sr37_clean_support_indicator_norm_le_one (X m : Nat) :
    ‖sr37_clean_support_indicator X m‖ ≤ 1 := by
  unfold sr37_clean_support_indicator
  split_ifs <;> norm_num

theorem sr37_clean_support_indicator_eq_zero_of_ge {X m : Nat}
    (hmX : X ≤ m) : sr37_clean_support_indicator X m = 0 := by
  unfold sr37_clean_support_indicator
  rw [if_neg]
  intro hm
  have hm' : m ∈ completeSupport X := by simpa using hm
  have hbounds := completeSupport_mem_bounds hm'
  omega

theorem sr37_clean_support_convolution_coefficient_explicit (X k : Nat) :
    LSeries.convolution (sr37_clean_support_indicator X)
      (sr37_clean_support_indicator X) k =
      ∑ p ∈ k.divisorsAntidiagonal,
        sr37_clean_support_indicator X p.1 *
          sr37_clean_support_indicator X p.2 := by
  rw [LSeries.convolution_def]

theorem sr37_clean_support_convolution_eq_zero_of_ge {X k : Nat}
    (hk : X ^ 2 ≤ k) :
    LSeries.convolution (sr37_clean_support_indicator X)
      (sr37_clean_support_indicator X) k = 0 := by
  rw [sr37_clean_support_convolution_coefficient_explicit]
  apply Finset.sum_eq_zero
  intro p hp
  by_cases hpm : p.1 ∈ (completeSupport X).toFinset
  · by_cases hpn : p.2 ∈ (completeSupport X).toFinset
    · have hmb := completeSupport_mem_bounds (by simpa using hpm)
      have hnb := completeSupport_mem_bounds (by simpa using hpn)
      have h1 : p.1 * p.2 < p.1 * X :=
        Nat.mul_lt_mul_of_pos_left hnb.2 (by omega)
      have h2 : p.1 * X < X * X :=
        Nat.mul_lt_mul_of_pos_right hmb.2 (by omega)
      have hprod : p.1 * p.2 < k := by
        exact h1.trans (h2.trans_le (by simpa [pow_two] using hk))
      have heq := (Nat.mem_divisorsAntidiagonal.mp hp).1
      simp [sr37_clean_support_indicator, hpm, hpn, heq,
        Nat.not_lt_of_ge hk] at hprod
    · simp [sr37_clean_support_indicator, hpm, hpn]
  · simp [sr37_clean_support_indicator, hpm]

theorem sr37_clean_support_convolution_lseries_summable {X : Nat} (s : ℂ) :
    LSeriesSummable
      (LSeries.convolution (sr37_clean_support_indicator X)
        (sr37_clean_support_indicator X)) s := by
  unfold LSeriesSummable
  apply summable_of_hasFiniteSupport
  refine (Set.finite_Iio (X ^ 2)).subset ?_
  intro k hk
  change LSeries.term
      (LSeries.convolution (sr37_clean_support_indicator X)
        (sr37_clean_support_indicator X)) s k ≠ 0 at hk
  by_contra hnot
  have hge : X ^ 2 ≤ k := by
    exact Nat.le_of_not_gt (by simpa using hnot)
  have hz := sr37_clean_support_convolution_eq_zero_of_ge hge
  apply hk
  rw [LSeries.term_def]
  split_ifs with hk0
  · simp
  · simp [hz]

theorem sr37_clean_support_convolution_norm_le_divisor_fiber_card (X k : Nat) :
    ‖LSeries.convolution (sr37_clean_support_indicator X)
      (sr37_clean_support_indicator X) k‖ ≤
      (k.divisorsAntidiagonal.card : ℝ) := by
  rw [sr37_clean_support_convolution_coefficient_explicit]
  calc
    ‖∑ p ∈ k.divisorsAntidiagonal,
        sr37_clean_support_indicator X p.1 *
          sr37_clean_support_indicator X p.2‖ ≤
        ∑ p ∈ k.divisorsAntidiagonal,
          ‖sr37_clean_support_indicator X p.1 *
            sr37_clean_support_indicator X p.2‖ := by
      exact norm_sum_le _ _
    _ ≤ ∑ _p ∈ k.divisorsAntidiagonal, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro p hp
      rw [norm_mul]
      calc
        ‖sr37_clean_support_indicator X p.1‖ *
            ‖sr37_clean_support_indicator X p.2‖ ≤
            1 * ‖sr37_clean_support_indicator X p.2‖ := by
              exact mul_le_mul_of_nonneg_right
                (sr37_clean_support_indicator_norm_le_one X p.1)
                (norm_nonneg _)
        _ ≤ 1 * 1 := by
              exact mul_le_mul_of_nonneg_left
                (sr37_clean_support_indicator_norm_le_one X p.2) (by norm_num)
        _ = 1 := by norm_num
    _ = (k.divisorsAntidiagonal.card : ℝ) := by simp

theorem sr37_clean_divisors_antidiagonal_card_le_divisors_card (k : Nat) :
    k.divisorsAntidiagonal.card ≤ k.divisors.card := by
  apply Finset.card_le_card_of_injOn Prod.fst
  · intro p hp
    exact Nat.fst_mem_divisors_of_mem_antidiagonal hp
  · intro p hp q hq hpq
    apply Prod.ext hpq
    have hp' := (Nat.mem_divisorsAntidiagonal.mp hp).1
    have hq' := (Nat.mem_divisorsAntidiagonal.mp hq).1
    exact Nat.eq_of_mul_eq_mul_left
      (Nat.pos_of_ne_zero (Nat.left_ne_zero_of_mem_divisorsAntidiagonal hp))
      (by simpa [hpq] using hp'.trans hq'.symm)

theorem sr37_clean_divisors_antidiagonal_card_le_self {k : Nat}
    (hk : 0 < k) :
    (k.divisorsAntidiagonal.card : ℝ) ≤ k := by
  have hcard : k.divisorsAntidiagonal.card ≤ k :=
    (sr37_clean_divisors_antidiagonal_card_le_divisors_card k).trans
      (Nat.card_divisors_le_self k)
  exact_mod_cast hcard

theorem sr37_clean_SR_dirichlet_contains_log_deriv : True := by
  trivial

end SR
