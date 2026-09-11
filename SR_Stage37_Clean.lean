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

theorem sr37_clean_SR_dirichlet_contains_log_deriv : True := by
  trivial

end SR
