import SR_Stage35
import Mathlib.Analysis.Complex.CauchyIntegral
import Mathlib.Analysis.Calculus.LogDeriv
import Mathlib.Analysis.MellinTransform
import Mathlib.Analysis.MellinInversion
import Mathlib.NumberTheory.LSeries.MellinEqDirichlet
import Mathlib.NumberTheory.LSeries.Dirichlet

namespace SR

theorem sr37_simple_zero_log_derivative_residue
    {f : ℂ → ℂ} {ρ : ℂ}
    (hf : AnalyticAt ℂ f ρ) (hzero : f ρ = 0)
    (hderiv : deriv f ρ ≠ 0) :
    Filter.Tendsto (fun s : ℂ => (s - ρ) * logDeriv f s)
      (nhdsWithin ρ ({ρ} : Set ℂ)ᶜ) (nhds 1) :=
  hf.tendsto_mul_logDeriv_simple_zero hzero hderiv

theorem sr37_vonMangoldt_lseries_is_negative_zeta_log_derivative
    {s : ℂ} (hs : 1 < s.re) :
    LSeries (fun n => (ArithmeticFunction.vonMangoldt n : ℂ)) s =
      - deriv riemannZeta s / riemannZeta s :=
  ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div hs

theorem sr37_lseries_of_dirichlet_convolution_eq_product
    {f g : ℕ → ℂ} {s : ℂ}
    (hf : LSeriesSummable f s) (hg : LSeriesSummable g s) :
    LSeries (LSeries.convolution f g) s = LSeries f s * LSeries g s := by
  exact LSeries_convolution' hf hg

noncomputable def sr37_support_indicator (X : Nat) : Nat → ℂ :=
  fun n => if n ∈ (completeSupport X).toFinset then 1 else 0

theorem sr37_support_eventual_membership {X m : Nat}
    (hm : 2 ≤ m) (hmX : m < X) : m ∈ completeSupport X := by
  unfold completeSupport
  apply List.mem_map.mpr
  refine ⟨m - 2, ?_, ?_⟩
  · simp
    omega
  · omega

theorem sr37_support_indicator_tendsto_one {m : Nat} (hm : 2 ≤ m) :
    Filter.Tendsto (fun X : Nat => sr37_support_indicator X m)
      Filter.atTop (nhds 1) := by
  refine Filter.Tendsto.congr' ?_ tendsto_const_nhds
  filter_upwards [Filter.eventually_gt_atTop m] with X hX
  simp only [sr37_support_indicator, List.mem_toFinset,
             sr37_support_eventual_membership hm hX, if_true]

theorem sr37_support_pair_indicator_tendsto_one {m n : Nat}
    (hm : 2 ≤ m) (hn : 2 ≤ n) :
    Filter.Tendsto
      (fun X : Nat => sr37_support_indicator X m * sr37_support_indicator X n)
      Filter.atTop (nhds (1 : ℂ)) := by
  simpa using (sr37_support_indicator_tendsto_one hm).mul
    (sr37_support_indicator_tendsto_one hn)

theorem sr37_support_indicator_norm_le_one (X m : Nat) :
    ‖sr37_support_indicator X m‖ ≤ 1 := by
  unfold sr37_support_indicator
  split_ifs <;> norm_num

theorem sr37_support_indicator_eq_zero_of_ge {X m : Nat}
    (hmX : X ≤ m) : sr37_support_indicator X m = 0 := by
  unfold sr37_support_indicator
  rw [if_neg]
  intro hm
  have hbounds := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
  omega

theorem sr37_support_pair_indicator_norm_le_one (X m n : Nat) :
    ‖sr37_support_indicator X m * sr37_support_indicator X n‖ ≤ 1 := by
  rw [norm_mul]
  exact mul_le_one₀ (sr37_support_indicator_norm_le_one X m) (norm_nonneg _)
    (sr37_support_indicator_norm_le_one X n)

theorem sr37_support_convolution_coefficient_explicit (X k : Nat) :
    LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X) k =
      ∑ p ∈ k.divisorsAntidiagonal,
        sr37_support_indicator X p.1 * sr37_support_indicator X p.2 := by
  rw [LSeries.convolution_def]

theorem sr37_support_convolution_eq_zero_of_ge {X k : Nat}
    (hk : X ^ 2 ≤ k) :
    LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X) k = 0 := by
  rw [sr37_support_convolution_coefficient_explicit]
  apply Finset.sum_eq_zero
  intro p hp
  by_cases hpm : p.1 ∈ (completeSupport X).toFinset
  · by_cases hpn : p.2 ∈ (completeSupport X).toFinset
    · have hmb := completeSupport_mem_bounds (List.mem_toFinset.mp hpm)
      have hnb := completeSupport_mem_bounds (List.mem_toFinset.mp hpn)
      have h1 : p.1 * p.2 < p.1 * X :=
        Nat.mul_lt_mul_of_pos_left hnb.2 (by omega)
      have h2 : p.1 * X < X * X :=
        Nat.mul_lt_mul_of_pos_right hmb.2 (by omega)
      have hprod : p.1 * p.2 < k := by
        exact h1.trans (h2.trans_le (by simpa [pow_two] using hk))
      have heq := (Nat.mem_divisorsAntidiagonal.mp hp).1
      simp [sr37_support_indicator, hpm, hpn, heq, Nat.not_lt_of_ge hk] at hprod
    · simp [sr37_support_indicator, hpm, hpn]
  · simp [sr37_support_indicator, hpm]

theorem sr37_support_convolution_lseries_summable {X : Nat} (s : ℂ) :
    LSeriesSummable
      (LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X)) s := by
  unfold LSeriesSummable
  apply summable_of_hasFiniteSupport
  refine (Set.finite_Iio (X ^ 2)).subset ?_
  intro k hk
  change LSeries.term
      (LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X)) s k ≠ 0 at hk
  by_contra hnot
  apply hk
  have hge : X ^ 2 ≤ k := by
    simp only [Set.mem_Iio, not_lt] at hnot; exact hnot
  have hz := sr37_support_convolution_eq_zero_of_ge hge
  rw [LSeries.term_def]
  split_ifs with hk0
  · simp
  · simp [hz]

theorem sr37_support_convolution_lseries_eq_finite_sum {X : Nat} (s : ℂ) :
    LSeries
        (LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X)) s =
      ∑ k ∈ Finset.range (X ^ 2),
        LSeries.term
          (LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X)) s k := by
  rw [LSeries]
  rw [tsum_eq_sum (s := Finset.range (X ^ 2))]
  intro k hk
  have hge : X ^ 2 ≤ k := Nat.le_of_not_gt (by simpa using hk)
  simp [LSeries.term_def, sr37_support_convolution_eq_zero_of_ge hge]

theorem sr37_support_convolution_norm_le_divisor_fiber_card (X k : Nat) :
    ‖LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X) k‖ ≤
      (k.divisorsAntidiagonal.card : ℝ) := by
  rw [sr37_support_convolution_coefficient_explicit]
  calc
    ‖∑ p ∈ k.divisorsAntidiagonal,
        sr37_support_indicator X p.1 * sr37_support_indicator X p.2‖ ≤
        ∑ p ∈ k.divisorsAntidiagonal,
          ‖sr37_support_indicator X p.1 * sr37_support_indicator X p.2‖ := by
      exact norm_sum_le _ _
    _ ≤ ∑ _p ∈ k.divisorsAntidiagonal, (1 : ℝ) := by
      apply Finset.sum_le_sum
      intro p hp
      exact sr37_support_pair_indicator_norm_le_one X p.1 p.2
    _ = (k.divisorsAntidiagonal.card : ℝ) := by simp

theorem sr37_divisors_antidiagonal_card_le_divisors_card (k : Nat) :
    k.divisorsAntidiagonal.card ≤ k.divisors.card := by
  apply Finset.card_le_card_of_injOn Prod.fst
  · intro p hp
    exact Nat.fst_mem_divisors_of_mem_antidiagonal hp
  · intro p hp q hq hpq
    apply Prod.ext hpq
    have hp' := (Nat.mem_divisorsAntidiagonal.mp hp).1
    have hq' := (Nat.mem_divisorsAntidiagonal.mp hq).1
    apply Nat.eq_of_mul_eq_mul_left
      (Nat.pos_of_ne_zero (Nat.left_ne_zero_of_mem_divisorsAntidiagonal hp))
    calc
      p.1 * p.2 = k := hp'
      _ = q.1 * q.2 := hq'.symm
      _ = p.1 * q.2 := by rw [hpq]

theorem sr37_divisors_antidiagonal_card_le_self {k : Nat} (hk : 0 < k) :
    (k.divisorsAntidiagonal.card : ℝ) ≤ k := by
  have hcard : k.divisorsAntidiagonal.card ≤ k :=
    (sr37_divisors_antidiagonal_card_le_divisors_card k).trans
      (Nat.card_divisors_le_self k)
  exact_mod_cast hcard

theorem sr37_support_convolution_summable {X : Nat} {s : ℂ}
    (hs : 2 < s.re) :
    LSeriesSummable
      (LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X)) s := by
  apply LSeriesSummable_of_le_const_mul_rpow hs
  refine ⟨1, ?_⟩
  intro k hk
  calc
    ‖LSeries.convolution (sr37_support_indicator X) (sr37_support_indicator X) k‖ ≤
        (k.divisorsAntidiagonal.card : ℝ) :=
      sr37_support_convolution_norm_le_divisor_fiber_card X k
    _ ≤ (k : ℝ) := sr37_divisors_antidiagonal_card_le_self (Nat.pos_iff_ne_zero.mpr hk)
    _ = (1 : ℝ) * (k : ℝ) ^ ((2 : ℝ) - 1) := by norm_num

theorem sr37_unrestricted_pair_convolution_lseries_eq_zeta_sq
    {s : ℂ} (hs : 1 < s.re) :
    LSeries (LSeries.convolution (fun _ : Nat => (1 : ℂ))
      (fun _ : Nat => (1 : ℂ))) s = riemannZeta s * riemannZeta s := by
  have h1 : LSeriesSummable (fun _ : Nat => (1 : ℂ)) s := LSeriesSummable_one_iff.mpr hs
  have h := LSeries_convolution' h1 h1
  rw [h]
  congr 1 <;> exact LSeries_one_eq_riemannZeta hs

theorem sr36_mellin_inversion (σ : ℝ) (f : ℝ → ℂ) {x : ℝ} (hx : 0 < x)
    (hf : MellinConvergent f σ)
    (hFf : Complex.VerticalIntegrable (mellin f) σ)
    (hfx : ContinuousAt f x) :
    mellinInv σ (mellin f) x = f x :=
  mellinInv_mellin_eq σ f hx hf hFf hfx

theorem sr36_unit_interval_hasMellin {s : ℂ} (hs : 0 < s.re) :
    HasMellin (Set.indicator (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ)) s (1 / s) :=
  hasMellin_one_Ioc hs

theorem sr36_mellin_scale (f : ℝ → ℂ) (s : ℂ) {a : ℝ} (ha : 0 < a) :
    mellin (fun t => f (a * t)) s = (a : ℂ) ^ (-s) • mellin f s :=
  mellin_comp_mul_left f s ha

theorem sr36_scaled_unit_interval_hasMellin (k : Nat) {s : ℂ}
    (hk : 0 < k) (hs : 0 < s.re) :
    HasMellin
      (fun t : ℝ => Set.indicator (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ)
        ((1 / k : ℝ) * t)) s
      ((1 / k : ℂ) ^ (-s) • (1 / s)) := by
  have hbase := sr36_unit_interval_hasMellin hs
  refine ⟨(MellinConvergent.comp_mul_left (f := Set.indicator
    (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ)) (s := s)
      (by
        have hk' : 0 < (k : ℝ) := by exact_mod_cast hk
        exact one_div_pos.mpr hk')).mpr hbase.1, ?_⟩
  have hscale := sr36_mellin_scale
    (Set.indicator (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ)) s
    (a := (1 / k : ℝ)) (by
      have hk' : 0 < (k : ℝ) := by exact_mod_cast hk
      exact one_div_pos.mpr hk')
  rw [hscale]
  convert congrArg (fun z : ℂ => (1 / k : ℂ) ^ (-s) • z) hbase.2 using 1 <;>
    norm_num [div_eq_mul_inv]

theorem sr36_scaled_coefficient_hasMellin (k : Nat) {s : ℂ}
    (hk : 0 < k) (hs : 0 < s.re) (c : ℂ) :
    HasMellin
      (fun t : ℝ => c • Set.indicator (Set.Ioc 0 1)
        (fun _ : ℝ => 1 : ℝ → ℂ) ((1 / k : ℝ) * t)) s
      (c • ((1 / k : ℂ) ^ (-s) • (1 / s))) := by
  have hscaled := sr36_scaled_unit_interval_hasMellin k hk hs
  have hweighted := hasMellin_const_smul hscaled.1 c
  rw [hscaled.2] at hweighted
  exact hweighted

theorem sr36_powered_interval_hasMellin (a s : ℂ)
    (hs : 0 < (s + a).re) :
    HasMellin
      (Set.indicator (Set.Ioc 0 1) (fun t : ℝ => (t : ℂ) ^ a)) s
      (1 / (s + a)) :=
  hasMellin_cpow_Ioc a hs

theorem sr36_smoothed_interval_hasMellin {s : ℂ} (hs : 0 < s.re) :
    HasMellin
      (fun t : ℝ => Set.indicator (Set.Ioc 0 1)
        (fun _ : ℝ => 1 : ℝ → ℂ) t -
        Set.indicator (Set.Ioc 0 1) (fun x : ℝ => (x : ℂ) ^ (1 : ℂ)) t) s
      (1 / s - 1 / (s + 1)) := by
  have h1 := sr36_unit_interval_hasMellin hs
  have h2 := sr36_powered_interval_hasMellin 1 s (by rw [Complex.add_re, Complex.one_re]; linarith)
  have hsub := hasMellin_sub h1.1 h2.1
  refine ⟨hsub.1, ?_⟩
  rw [hsub.2, h1.2, h2.2]

theorem sr36_second_difference_interval_hasMellin {s : ℂ} (hs : 0 < s.re) :
    HasMellin
      (fun t : ℝ =>
        Set.indicator (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ) t +
        (-2 : ℂ) • Set.indicator (Set.Ioc 0 1)
          (fun x : ℝ => (x : ℂ) ^ (1 : ℂ)) t +
        Set.indicator (Set.Ioc 0 1)
          (fun x : ℝ => (x : ℂ) ^ (2 : ℂ)) t) s
      (1 / s + (-2 : ℂ) • (1 / (s + 1)) + 1 / (s + 2)) := by
  have h0 := sr36_unit_interval_hasMellin hs
  have h1 := sr36_powered_interval_hasMellin 1 s (by rw [Complex.add_re, Complex.one_re]; linarith)
  have h2 := sr36_powered_interval_hasMellin 2 s (by rw [Complex.add_re]; norm_num; linarith)
  have h1' := hasMellin_const_smul h1.1 (-2 : ℂ)
  have h01 := hasMellin_add h0.1 h1'.1
  have h012 := hasMellin_add h01.1 h2.1
  refine ⟨h012.1, ?_⟩
  rw [h012.2, h01.2, h1'.2, h0.2, h1.2, h2.2]

theorem sr36_second_difference_interval_transform_denominator {s : ℂ}
    (hs : 0 < s.re) :
    1 / s + (-2 : ℂ) • (1 / (s + 1)) + 1 / (s + 2) =
      2 / (s * (s + 1) * (s + 2)) := by
  have hs0 : s ≠ 0 := by
    intro h
    rw [h] at hs
    norm_num at hs
  have hs1 : s + 1 ≠ 0 := by
    intro h
    have hr := congrArg Complex.re h
    norm_num at hr
    linarith
  have hs2 : s + 2 ≠ 0 := by
    intro h
    have hr := congrArg Complex.re h
    norm_num at hr
    linarith
  simp only [smul_eq_mul]
  field_simp [hs0, hs1, hs2]
  ring

/- Stage 37 obstruction audit: the currently proved trivial envelope cannot
   contradict a hypothetical off-line contribution of order X^(β+1). -/
theorem sr37_off_line_exponent_is_below_trivial_envelope {β : ℝ}
    (hβ : 0 < β) : β + 1 ≤ 2 * β + 1 := by
  linarith

theorem sr37_off_line_exponent_exceeds_critical_exponent {β : ℝ}
    (hβ : (1 : ℝ) / 2 < β) : (3 : ℝ) / 2 < β + 1 := by
  linarith

theorem sr37_off_line_exponent_exceeds_diagonal_exponent {β : ℝ}
    (hβ : β < 1) : 2 * β < β + 1 := by
  linarith

theorem sr36_smoothed_interval_transform_denominator {s : ℂ} (hs : 0 < s.re) :
    1 / s - 1 / (s + 1) = 1 / (s * (s + 1)) := by
  have hs0 : s ≠ 0 := by
    intro h
    rw [h] at hs
    norm_num at hs
  have hs1 : s + 1 ≠ 0 := by
    intro h
    have hr := congrArg Complex.re h
    norm_num at hr
    linarith
  field_simp [hs0, hs1]
  ring

theorem sr36_hasMellin_add {f g : ℝ → ℂ} {s : ℂ}
    (hf : HasMellin f s (mellin f s))
    (hg : HasMellin g s (mellin g s)) :
    HasMellin (fun t => f t + g t) s (mellin f s + mellin g s) := by
  exact hasMellin_add hf.1 hg.1

theorem sr36_hasSum_mellin_dirichlet {ι : Type} [Countable ι]
    {a : ι → ℂ} {p : ι → ℝ} {F : ℝ → ℂ} {s : ℂ}
    (hp : ∀ i, a i = 0 ∨ 0 < p i) (hs : 0 < s.re)
    (hF : ∀ t ∈ Set.Ioi 0,
      HasSum (fun i => a i * Real.exp (-p i * t)) (F t))
    (h_sum : Summable (fun i => ‖a i‖ / (p i) ^ s.re)) :
    HasSum (fun i => Complex.Gamma s * a i / (p i) ^ s)
      (mellin F s) :=
  hasSum_mellin hp hs hF h_sum

theorem sr36_hasSum_of_finset_support {ι : Type}
    (u : Finset ι) (f : ι → ℂ) (hzero : ∀ i ∉ u, f i = 0) :
    HasSum f (∑ i ∈ u, f i) := by
  simpa using hasSum_sum_of_ne_finset_zero hzero

theorem sr36_finite_dirichlet_mellin {ι : Type} [Countable ι]
    (u : Finset ι) (a : ι → ℂ) (p : ι → ℝ) {s : ℂ}
    (hzero : ∀ i ∉ u, a i = 0) (hpos : ∀ i ∈ u, 0 < p i)
    (hs : 0 < s.re) :
    HasSum (fun i => Complex.Gamma s * a i / (p i) ^ s)
      (mellin (fun t => ∑ i ∈ u, a i * Real.exp (-p i * t)) s) := by
  apply sr36_hasSum_mellin_dirichlet (a := a) (p := p)
  · intro i
    by_cases hi : i ∈ u
    · exact Or.inr (hpos i hi)
    · exact Or.inl (hzero i hi)
  · exact hs
  · intro t ht
    apply sr36_hasSum_of_finset_support u
    intro i hi
    simp [hzero i hi]
  · have hfin : HasSum (fun i => ‖a i‖ / (p i) ^ s.re)
        (∑ i ∈ u, ‖a i‖ / (p i) ^ s.re) :=
      hasSum_sum_of_ne_finset_zero (s := u) (f := fun i => ‖a i‖ / (p i) ^ s.re) (by
        intro i hi
        simp [hzero i hi])
    exact hfin.summable

theorem sr36_zero_hasMellin (s : ℂ) :
    HasMellin (fun _ : ℝ => (0 : ℂ)) s 0 := by
  constructor
  · simp [MellinConvergent]
  · simp [mellin]

theorem sr36_hasMellin_finset_sum {ι : Type} (u : Finset ι)
    (f : ι → ℝ → ℂ) (s : ℂ)
    (h : ∀ i ∈ u, HasMellin (f i) s (mellin (f i) s)) :
    HasMellin (fun t => ∑ i ∈ u, f i t) s
      (∑ i ∈ u, mellin (f i) s) := by
  classical
  induction u using Finset.induction_on with
  | empty =>
      simpa using sr36_zero_hasMellin s
  | @insert i u hi ih =>
      have hi' := h i (Finset.mem_insert_self i u)
      have hu' : ∀ j ∈ u, HasMellin (f j) s (mellin (f j) s) := by
        intro j hj
        exact h j (Finset.mem_insert_of_mem hj)
      have hsum := ih hu'
      have hadd := hasMellin_add hi'.1 hsum.1
      rw [hsum.2] at hadd
      simpa [Finset.sum_insert, hi] using hadd

def SR_divisorMultiplicity (X k : Nat) : Nat :=
  ((completeSupport X).toFinset.product (completeSupport X).toFinset).filter
    (fun p => p.1 * p.2 = k) |>.card

def SR_signed_divisor_coefficient (X k : Nat) : ℤ :=
  (if k < X then -1 else 1) * SR_divisorMultiplicity X k

theorem sr36_signed_step_hasMellin (X : Nat) {s : ℂ} (hs : 0 < s.re) :
    HasMellin
      (fun t : ℝ => ∑ k ∈ Finset.Icc 1 (X ^ 2),
        (SR_signed_divisor_coefficient X k : ℂ) •
          Set.indicator (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ)
            ((1 / k : ℝ) * t)) s
      (∑ k ∈ Finset.Icc 1 (X ^ 2),
        (SR_signed_divisor_coefficient X k : ℂ) •
          ((1 / k : ℂ) ^ (-s) • (1 / s))) := by
  let f : Nat → ℝ → ℂ := fun k t =>
    (SR_signed_divisor_coefficient X k : ℂ) •
      Set.indicator (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ)
        ((1 / k : ℝ) * t)
  have hsum := sr36_hasMellin_finset_sum (u := Finset.Icc 1 (X ^ 2)) f s (by
    intro k hk
    have hkpos : 0 < k := by
      have := (Finset.mem_Icc.mp hk).1
      omega
    have hterm := sr36_scaled_coefficient_hasMellin k hkpos hs
      (SR_signed_divisor_coefficient X k : ℂ)
    exact ⟨hterm.1, by simp [f, hterm.2]⟩
  )
  have hvals :
      (∑ k ∈ Finset.Icc 1 (X ^ 2), mellin (f k) s) =
        ∑ k ∈ Finset.Icc 1 (X ^ 2),
          (SR_signed_divisor_coefficient X k : ℂ) •
            ((1 / k : ℂ) ^ (-s) • (1 / s)) := by
    apply Finset.sum_congr rfl
    intro k hk
    have hkpos : 0 < k := by
      have := (Finset.mem_Icc.mp hk).1
      omega
    have hterm := sr36_scaled_coefficient_hasMellin k hkpos hs
      (SR_signed_divisor_coefficient X k : ℂ)
    simpa [f] using hterm.2
  rw [hvals] at hsum
  simpa [f, smul_assoc] using hsum

theorem sr36_signed_step_hasMellin_scalar_form (X : Nat) {s : ℂ} (hs : 0 < s.re) :
    HasMellin
      (fun t : ℝ => ∑ k ∈ Finset.Icc 1 (X ^ 2),
        (SR_signed_divisor_coefficient X k : ℂ) •
          Set.indicator (Set.Ioc 0 1) (fun _ : ℝ => 1 : ℝ → ℂ)
            ((1 / k : ℝ) * t)) s
      (∑ k ∈ Finset.Icc 1 (X ^ 2),
        (SR_signed_divisor_coefficient X k : ℂ) *
          ((1 / k : ℂ) ^ (-s) * (1 / s))) := by
  have h := sr36_signed_step_hasMellin X hs
  refine ⟨h.1, ?_⟩
  rw [h.2]
  apply Finset.sum_congr rfl
  intro k hk
  simp only [smul_eq_mul]

theorem sr36_completeSupport_nodup (X : Nat) :
    (completeSupport X).Nodup := by
  unfold completeSupport
  apply List.Nodup.map
  · intro a b hab
    dsimp at hab
    omega
  · exact List.nodup_range

theorem sr36_completeSupport_sum_toFinset
    {M : Type} [AddCommMonoid M] (X : Nat) (f : Nat → M) :
    ((completeSupport X).map f).sum =
      ∑ m ∈ (completeSupport X).toFinset, f m := by
  rw [List.sum_toFinset f (sr36_completeSupport_nodup X)]

theorem sr36_completeSupport_int_sum_cast (X : Nat) (f : Nat → ℤ) :
    (((completeSupport X).map f).sum : ℝ) =
      ∑ m ∈ (completeSupport X).toFinset, (f m : ℝ) := by
  rw [sr36_completeSupport_sum_toFinset X f]
  norm_cast

noncomputable def SR_signed_dirichlet_polynomial (X : Nat) (s : ℂ) : ℂ :=
  ∑ k ∈ Finset.range (X ^ 2),
    (SR_signed_divisor_coefficient X k : ℂ) *
      Complex.exp (-s * (Real.log k : ℂ))

noncomputable def SR_signed_dirichlet_polynomial_deriv (X : Nat) (s : ℂ) : ℂ :=
  ∑ k ∈ Finset.range (X ^ 2),
    (SR_signed_divisor_coefficient X k : ℂ) *
      (-(Real.log k : ℂ) * Complex.exp (-s * (Real.log k : ℂ)))

noncomputable def SR_signed_dirichlet_polynomial_second_deriv (X : Nat) (s : ℂ) : ℂ :=
  ∑ k ∈ Finset.range (X ^ 2),
    (SR_signed_divisor_coefficient X k : ℂ) *
      ((Real.log k : ℂ) * (Real.log k : ℂ) *
        Complex.exp (-s * (Real.log k : ℂ)))

noncomputable def SR_signed_dirichlet_polynomial_third_deriv (X : Nat) (s : ℂ) : ℂ :=
  ∑ k ∈ Finset.range (X ^ 2),
    (SR_signed_divisor_coefficient X k : ℂ) *
      (-(Real.log k : ℂ) * (Real.log k : ℂ) * (Real.log k : ℂ) *
        Complex.exp (-s * (Real.log k : ℂ)))

theorem sr36_signed_dirichlet_polynomial_hasDerivAt (X : Nat) (s : ℂ) :
    HasDerivAt (SR_signed_dirichlet_polynomial X)
      (SR_signed_dirichlet_polynomial_deriv X s) s := by
  unfold SR_signed_dirichlet_polynomial SR_signed_dirichlet_polynomial_deriv
  apply HasDerivAt.fun_sum
  intro k hk
  let c : ℂ := (Real.log k : ℂ)
  let a : ℂ := (SR_signed_divisor_coefficient X k : ℂ)
  have hlin : HasDerivAt (fun y : ℂ => -y * c) (-c) s := by
    simpa using (hasDerivAt_id s).neg.mul_const c
  have hexp : HasDerivAt (fun y : ℂ => Complex.exp (-y * c))
      (Complex.exp (-s * c) * (-c)) s := by
    simpa using (Complex.hasDerivAt_exp (-s * c)).comp s hlin
  have hterm := hexp.const_mul a
  convert hterm using 1 <;> dsimp [a, c] <;> ring

theorem sr36_signed_dirichlet_polynomial_deriv_eq_deriv (X : Nat) (s : ℂ) :
    deriv (SR_signed_dirichlet_polynomial X) s =
      SR_signed_dirichlet_polynomial_deriv X s :=
  (sr36_signed_dirichlet_polynomial_hasDerivAt X s).deriv

theorem sr36_signed_dirichlet_polynomial_hasSecondDerivAt (X : Nat) (s : ℂ) :
    HasDerivAt (SR_signed_dirichlet_polynomial_deriv X)
      (SR_signed_dirichlet_polynomial_second_deriv X s) s := by
  unfold SR_signed_dirichlet_polynomial_deriv
    SR_signed_dirichlet_polynomial_second_deriv
  apply HasDerivAt.fun_sum
  intro k hk
  let c : ℂ := (Real.log k : ℂ)
  let a : ℂ := (SR_signed_divisor_coefficient X k : ℂ)
  have hlin : HasDerivAt (fun y : ℂ => -y * c) (-c) s := by
    simpa using (hasDerivAt_id s).neg.mul_const c
  have hexp : HasDerivAt (fun y : ℂ => Complex.exp (-y * c))
      (Complex.exp (-s * c) * (-c)) s := by
    simpa using (Complex.hasDerivAt_exp (-s * c)).comp s hlin
  have hinner := hexp.const_mul (-c)
  have hterm := hinner.const_mul a
  convert hterm using 1 <;> dsimp [a, c] <;> ring

theorem sr36_signed_dirichlet_polynomial_hasThirdDerivAt (X : Nat) (s : ℂ) :
    HasDerivAt (SR_signed_dirichlet_polynomial_second_deriv X)
      (SR_signed_dirichlet_polynomial_third_deriv X s) s := by
  unfold SR_signed_dirichlet_polynomial_second_deriv
    SR_signed_dirichlet_polynomial_third_deriv
  apply HasDerivAt.fun_sum
  intro k hk
  let c : ℂ := (Real.log k : ℂ)
  let a : ℂ := (SR_signed_divisor_coefficient X k : ℂ)
  have hlin : HasDerivAt (fun y : ℂ => -y * c) (-c) s := by
    simpa using (hasDerivAt_id s).neg.mul_const c
  have hexp : HasDerivAt (fun y : ℂ => Complex.exp (-y * c))
      (Complex.exp (-s * c) * (-c)) s := by
    simpa using (Complex.hasDerivAt_exp (-s * c)).comp s hlin
  have hinner := hexp.const_mul (c * c)
  have hterm := hinner.const_mul a
  convert hterm using 1 <;> dsimp [a, c] <;> ring

theorem sr36_signed_dirichlet_polynomial_deriv_differentiable (X : Nat) :
    Differentiable ℂ (SR_signed_dirichlet_polynomial_deriv X) := by
  unfold SR_signed_dirichlet_polynomial_deriv
  fun_prop

theorem sr36_signed_dirichlet_polynomial_deriv_continuous (X : Nat) :
    Continuous (SR_signed_dirichlet_polynomial_deriv X) :=
  (sr36_signed_dirichlet_polynomial_deriv_differentiable X).continuous

theorem sr36_signed_dirichlet_polynomial_deriv_analytic (X : Nat) :
    AnalyticOnNhd ℂ (SR_signed_dirichlet_polynomial_deriv X) Set.univ := by
  exact Complex.analyticOnNhd_univ_iff_differentiable.mpr
    (sr36_signed_dirichlet_polynomial_deriv_differentiable X)

theorem sr36_signed_dirichlet_polynomial_differentiable (X : Nat) :
    Differentiable ℂ (SR_signed_dirichlet_polynomial X) := by
  unfold SR_signed_dirichlet_polynomial
  fun_prop

theorem sr36_signed_dirichlet_polynomial_continuous (X : Nat) :
    Continuous (SR_signed_dirichlet_polynomial X) :=
  (sr36_signed_dirichlet_polynomial_differentiable X).continuous

theorem sr36_signed_dirichlet_polynomial_analytic (X : Nat) :
    AnalyticOnNhd ℂ (SR_signed_dirichlet_polynomial X) Set.univ := by
  exact Complex.analyticOnNhd_univ_iff_differentiable.mpr
    (sr36_signed_dirichlet_polynomial_differentiable X)

noncomputable def SR_complex_parameter (beta gamma : ℝ) : ℂ :=
  (-(beta - 1 / 2) : ℂ) - (gamma : ℂ) * Complex.I

theorem sr36_signed_dirichlet_polynomial_parameter_deriv (X : Nat)
    (beta gamma : ℝ) :
    deriv (SR_signed_dirichlet_polynomial X)
        (SR_complex_parameter beta gamma) =
      SR_signed_dirichlet_polynomial_deriv X (SR_complex_parameter beta gamma) := by
  exact sr36_signed_dirichlet_polynomial_deriv_eq_deriv X
    (SR_complex_parameter beta gamma)

theorem sr36_parameter_exponent (beta gamma x : ℝ) :
    -SR_complex_parameter beta gamma * (x : ℂ) =
      ((beta - 1 / 2) : ℂ) * (x : ℂ) +
        ((gamma * x : ℝ) : ℂ) * Complex.I := by
  unfold SR_complex_parameter
  push_cast
  ring

theorem sr36_filtered_const_sum
    {α M : Type} [AddCommMonoid M]
    (s : Finset α) (p : α → Prop) [DecidablePred p] (a : M) :
    (∑ x ∈ s with p x, a) = (s.filter p).card • a := by
  simp [Finset.sum_filter, Finset.sum_const]

theorem sr36_signed_coefficient_as_fiber_sum (X k : Nat) :
    SR_signed_divisor_coefficient X k =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
        with p.1 * p.2 = k,
        (if k < X then (-1 : ℤ) else 1) := by
  unfold SR_signed_divisor_coefficient SR_divisorMultiplicity
  rw [sr36_filtered_const_sum]
  simp [mul_comm]

theorem sr36_signed_coefficient_complex_as_fiber_sum (X k : Nat) :
    (SR_signed_divisor_coefficient X k : ℂ) =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
        with p.1 * p.2 = k,
        (if k < X then (-1 : ℂ) else 1) := by
  rw [sr36_signed_coefficient_as_fiber_sum]
  norm_cast

theorem sr36_signed_polynomial_as_fiber_sum (X : Nat) (s : ℂ) :
    SR_signed_dirichlet_polynomial X s =
      ∑ k ∈ Finset.range (X ^ 2),
        (∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
          with p.1 * p.2 = k,
          (if k < X then (-1 : ℂ) else 1)) *
          Complex.exp (-s * (Real.log k : ℂ)) := by
  unfold SR_signed_dirichlet_polynomial
  simp_rw [sr36_signed_coefficient_complex_as_fiber_sum]


theorem sr36_nested_eq_filtered_product
    {α β γ M : Type} [AddCommMonoid M] [DecidableEq γ]
    (s : Finset α) (t : Finset β) (g : α × β → γ) (k : γ) (a : M) :
    (∑ x ∈ s, ∑ y ∈ t, if g (x, y) = k then a else 0) =
      ∑ p ∈ s.product t with g p = k, a := by
  calc
    (∑ x ∈ s, ∑ y ∈ t, if g (x, y) = k then a else 0) =
        ∑ p ∈ s.product t, if g p = k then a else 0 := by
          simpa using (Finset.sum_product s t
            (fun p : α × β => if g p = k then a else 0)).symm
    _ = ∑ p ∈ s.product t with g p = k, a := by
          simp only [Finset.sum_filter]


theorem sr36_weighted_fiber_sum
    {ι κ M : Type} [CommSemiring M] [DecidableEq κ]
    {s : Finset ι} {t : Finset κ} {g : ι → κ}
    (hmap : ∀ i ∈ s, g i ∈ t) (w : κ → M) (f : ι → M) :
    (∑ k ∈ t, w k * ∑ i ∈ s with g i = k, f i) =
      ∑ i ∈ s, w (g i) * f i := by
  classical
  simp_rw [Finset.mul_sum]
  convert Finset.sum_fiberwise_of_maps_to hmap
    (fun i => w (g i) * f i) using 1
  apply Finset.sum_congr rfl
  intro j hj
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mem_filter] at hi
  rw [hi.2]

theorem sr36_filtered_sum_mul_right
    {α M : Type} [CommSemiring M]
    (s : Finset α) (p : α → Prop) [DecidablePred p]
    (f : α → M) (a : M) :
    (∑ x ∈ s with p x, f x * a) =
      a * ∑ x ∈ s with p x, f x := by
  simp only [Finset.sum_filter]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases h : p x <;> simp [h, mul_comm]

theorem sr36_signed_polynomial_as_product_sum (X : Nat) (s : ℂ) :
    SR_signed_dirichlet_polynomial X s =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        (if p.1 * p.2 < X then (-1 : ℂ) else 1) *
          Complex.exp (-s * (Real.log (p.1 * p.2) : ℂ)) := by
  classical
  have hmap : ∀ p ∈ (completeSupport X).toFinset.product
      (completeSupport X).toFinset, p.1 * p.2 ∈ Finset.range (X ^ 2) := by
    intro p hp
    rcases Finset.mem_product.mp hp with ⟨hpm, hpn⟩
    have hpm' : p.1 ∈ completeSupport X := by simpa using hpm
    have hpn' : p.2 ∈ completeSupport X := by simpa using hpn
    have hmb := completeSupport_mem_bounds hpm'
    have hnb := completeSupport_mem_bounds hpn'
    have h1 : p.1 * p.2 < p.1 * X :=
      Nat.mul_lt_mul_of_pos_left hnb.2 (by omega)
    have h2 : p.1 * X < X * X :=
      Nat.mul_lt_mul_of_pos_right hmb.2 (by omega)
    exact Finset.mem_range.mpr (h1.trans (by simpa [pow_two] using h2))
  have hsign (k : Nat) :
      (∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
        with p.1 * p.2 = k, (if k < X then (-1 : ℂ) else 1)) =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
        with p.1 * p.2 = k, (if p.1 * p.2 < X then (-1 : ℂ) else 1) := by
    apply Finset.sum_congr rfl
    intro p hp
    rw [Finset.mem_filter] at hp
    rw [← hp.2]
  rw [sr36_signed_polynomial_as_fiber_sum]
  calc
    (∑ k ∈ Finset.range (X ^ 2),
        (∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
          with p.1 * p.2 = k, (if k < X then (-1 : ℂ) else 1)) *
          Complex.exp (-s * (Real.log k : ℂ))) =
      ∑ k ∈ Finset.range (X ^ 2),
        Complex.exp (-s * (Real.log k : ℂ)) *
          (∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
            with p.1 * p.2 = k, (if p.1 * p.2 < X then (-1 : ℂ) else 1)) := by
      apply Finset.sum_congr rfl
      intro k hk
      rw [← sr36_filtered_sum_mul_right]
      rw [hsign]
      rw [sr36_filtered_sum_mul_right]
      exact mul_comm _ _
    _ = ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        Complex.exp (-s * (Real.log (p.1 * p.2) : ℂ)) *
          (if p.1 * p.2 < X then (-1 : ℂ) else 1) := by
      simpa using (sr36_weighted_fiber_sum hmap
        (fun k : Nat => Complex.exp (-s * (Real.log k : ℂ)))
        (fun p : Nat × Nat => if p.1 * p.2 < X then (-1 : ℂ) else 1))
    _ = ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        (if p.1 * p.2 < X then (-1 : ℂ) else 1) *
          Complex.exp (-s * (Real.log (p.1 * p.2) : ℂ)) := by
      apply Finset.sum_congr rfl
      intro p hp
      exact mul_comm _ _

theorem sr36_rees_sign_by_product (X m n : Nat) :
    reesEntryFromNat X m n = if m * n < X then -1 else 1 := by
  rw [rees_decomposition]
  split_ifs <;> simp_all

theorem sr36_product_weight_normalization
    (m n : Nat) (hm : 0 < m) (hn : 0 < n) (beta gamma : ℝ) :
    ((m : ℝ) * n) ^ (beta - 1 / 2) *
        Real.cos (gamma * Real.log ((m : ℝ) * n)) =
      (m : ℝ) ^ (beta - 1 / 2) * (n : ℝ) ^ (beta - 1 / 2) *
        Real.cos (gamma * (Real.log m + Real.log n)) := by
  rw [Real.mul_rpow (by positivity) (by positivity)]
  rw [Real.log_mul (by positivity) (by positivity)]

noncomputable def SR_product_channel_as_divisor_sum
    (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ k ∈ Finset.range (X ^ 2),
    (if k < X then (-1 : ℝ) else 1) *
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          if m * n = k then
            (k : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log k)
          else 0

noncomputable def SR_product_channel_fiber_sum
    (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ k ∈ Finset.range (X ^ 2),
    ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
      with p.1 * p.2 = k,
      (reesEntryFromNat X p.1 p.2 : ℝ) *
        ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
        Real.cos (gamma * (Real.log p.1 + Real.log p.2))

theorem SR_product_channel_divisor_as_product_sum
    (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) :
    SR_product_channel_as_divisor_sum X beta gamma =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        (if p.1 * p.2 < X then (-1 : ℝ) else 1) *
          ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
          Real.cos (gamma * Real.log ((p.1 : ℝ) * p.2)) := by
  classical
  unfold SR_product_channel_as_divisor_sum
  have hmap : ∀ p ∈ (completeSupport X).toFinset.product
      (completeSupport X).toFinset, p.1 * p.2 ∈ Finset.range (X ^ 2) := by
    intro p hp
    rcases Finset.mem_product.mp hp with ⟨hpm, hpn⟩
    have hpm' : p.1 ∈ completeSupport X := by simpa using hpm
    have hpn' : p.2 ∈ completeSupport X := by simpa using hpn
    have hmb := completeSupport_mem_bounds hpm'
    have hnb := completeSupport_mem_bounds hpn'
    have h1 : p.1 * p.2 < p.1 * X :=
      Nat.mul_lt_mul_of_pos_left hnb.2 (by omega)
    have h2 : p.1 * X < X * X :=
      Nat.mul_lt_mul_of_pos_right hmb.2 (by omega)
    exact Finset.mem_range.mpr (h1.trans (by simpa [pow_two] using h2))
  have hinner (k : Nat) :
      (∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          if m * n = k then
            (k : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log k)
          else 0) =
        ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
          with p.1 * p.2 = k,
          ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
            Real.cos (gamma * Real.log ((p.1 : ℝ) * p.2)) := by
    calc
      _ = ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
          with p.1 * p.2 = k,
          (k : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log k) := by
        simpa using sr36_nested_eq_filtered_product
          (completeSupport X).toFinset (completeSupport X).toFinset
          (fun p : Nat × Nat => p.1 * p.2) k
          ((k : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log k))
      _ = ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
          with p.1 * p.2 = k,
          ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
            Real.cos (gamma * Real.log ((p.1 : ℝ) * p.2)) := by
        apply Finset.sum_congr rfl
        intro p hp
        have heq := (Finset.mem_filter.mp hp).2
        rw [← heq]
        rw [Nat.cast_mul]
  simp_rw [hinner]
  simpa [mul_assoc] using (sr36_weighted_fiber_sum hmap
    (fun k : Nat => (if k < X then (-1 : ℝ) else 1))
    (fun p : Nat × Nat =>
      ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
        Real.cos (gamma * Real.log ((p.1 : ℝ) * p.2))))

theorem SR_product_channel_divisor_form
    (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) :
    SR_channel_product X beta gamma =
      SR_product_channel_as_divisor_sum X beta gamma := by
  rw [SR_product_channel_divisor_as_product_sum X hX beta gamma]
  unfold SR_channel_product
  have hprod :
      (∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          (reesEntryFromNat X m n : ℝ) *
            ((m : ℝ) * n) ^ (beta - 1 / 2) *
            Real.cos (gamma * (Real.log m + Real.log n))) =
        ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
          (reesEntryFromNat X p.1 p.2 : ℝ) *
            ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
            Real.cos (gamma * (Real.log p.1 + Real.log p.2)) := by
    simpa using (Finset.sum_product (completeSupport X).toFinset
      (completeSupport X).toFinset (fun p : Nat × Nat =>
        (reesEntryFromNat X p.1 p.2 : ℝ) *
          ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
          Real.cos (gamma * (Real.log p.1 + Real.log p.2)))).symm
  rw [hprod]
  apply Finset.sum_congr rfl
  intro p hp
  have hpm : p.1 ∈ completeSupport X := by
    simpa using (Finset.mem_product.mp hp).1
  have hpn : p.2 ∈ completeSupport X := by
    simpa using (Finset.mem_product.mp hp).2
  have hmb := completeSupport_mem_bounds (by simpa using hpm)
  have hnb := completeSupport_mem_bounds (by simpa using hpn)
  rw [sr36_rees_sign_by_product]
  split_ifs with h
  · norm_num
    have hp1 : (p.1 : ℝ) ≠ 0 := by exact_mod_cast (show p.1 ≠ 0 by omega)
    have hp2 : (p.2 : ℝ) ≠ 0 := by exact_mod_cast (show p.2 ≠ 0 by omega)
    rw [Real.log_mul hp1 hp2]
    exact Or.inl rfl
  · norm_num
    have hp1 : (p.1 : ℝ) ≠ 0 := by exact_mod_cast (show p.1 ≠ 0 by omega)
    have hp2 : (p.2 : ℝ) ≠ 0 := by exact_mod_cast (show p.2 ≠ 0 by omega)
    rw [Real.log_mul hp1 hp2]
    exact Or.inl rfl

theorem SR_product_channel_fiber_identity
    (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) :
    SR_product_channel_fiber_sum X beta gamma =
      SR_channel_product X beta gamma := by
  classical
  unfold SR_product_channel_fiber_sum SR_channel_product
  have hprod :
      (∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          (reesEntryFromNat X m n : ℝ) *
            ((m : ℝ) * n) ^ (beta - 1 / 2) *
            Real.cos (gamma * (Real.log m + Real.log n))) =
        ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
          (reesEntryFromNat X p.1 p.2 : ℝ) *
            ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
            Real.cos (gamma * (Real.log p.1 + Real.log p.2)) := by
    simpa using (Finset.sum_product (completeSupport X).toFinset
      (completeSupport X).toFinset (fun p : Nat × Nat =>
        (reesEntryFromNat X p.1 p.2 : ℝ) *
          ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
          Real.cos (gamma * (Real.log p.1 + Real.log p.2)))).symm
  rw [hprod]
  refine Finset.sum_fiberwise_of_maps_to ?_ (fun p : Nat × Nat =>
    (reesEntryFromNat X p.1 p.2 : ℝ) *
      ((p.1 : ℝ) * p.2) ^ (beta - 1 / 2) *
      Real.cos (gamma * (Real.log p.1 + Real.log p.2)))
  intro p hp
  rcases (Finset.mem_product.mp hp) with ⟨hpm, hpn⟩
  have hpm' : p.1 ∈ completeSupport X := by simpa using hpm
  have hpn' : p.2 ∈ completeSupport X := by simpa using hpn
  have hmb := completeSupport_mem_bounds hpm'
  have hnb := completeSupport_mem_bounds hpn'
  have hm := hmb.2
  have hn := hnb.2
  have h1 : p.1 * p.2 < p.1 * X :=
    Nat.mul_lt_mul_of_pos_left hn (by omega)
  have h2 : p.1 * X < X * X :=
    Nat.mul_lt_mul_of_pos_right hm (by omega)
  exact Finset.mem_range.mpr (h1.trans (by simpa [pow_two] using h2))

theorem sr36_support_pos {X m : Nat} (hm : m ∈ completeSupport X) :
    0 < m := by
  have hbounds := completeSupport_mem_bounds hm
  omega

theorem sr36_product_pos {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X) :
    0 < m * n := by
  exact Nat.mul_pos (sr36_support_pos hm) (sr36_support_pos hn)

theorem sr36_zero_divisor_coefficient (X : Nat) :
    SR_signed_divisor_coefficient X 0 = 0 := by
  unfold SR_signed_divisor_coefficient SR_divisorMultiplicity
  have hempty :
      ((completeSupport X).toFinset.product (completeSupport X).toFinset).filter
          (fun p => p.1 * p.2 = 0) = ∅ := by
    ext p
    constructor
    · intro hp
      rw [Finset.mem_filter] at hp
      rcases Finset.mem_product.mp hp.1 with ⟨hpm, hpn⟩
      have hpos := sr36_product_pos (X := X) (m := p.1) (n := p.2)
        (by simpa using hpm) (by simpa using hpn)
      omega
    · intro hp
      simp at hp
  rw [hempty]
  simp

theorem sr36_signed_polynomial_zero_term_removed (X : Nat) (s : ℂ) :
    SR_signed_dirichlet_polynomial X s =
      ∑ k ∈ Finset.range (X ^ 2),
        if k = 0 then 0 else
          (SR_signed_divisor_coefficient X k : ℂ) *
            Complex.exp (-s * (Real.log k : ℂ)) := by
  unfold SR_signed_dirichlet_polynomial
  apply Finset.sum_congr rfl
  intro k hk
  by_cases hzero : k = 0
  · subst k
    simp [sr36_zero_divisor_coefficient]
  · simp [hzero]

theorem sr36_zeta_dirichlet_series {s : ℂ} (hs : 1 < s.re) :
    LSeriesHasSum (fun n => (ArithmeticFunction.zeta n : ℂ)) s (riemannZeta s) :=
  ArithmeticFunction.LSeriesHasSum_zeta hs

theorem sr36_zeta_partial_sums_tendsto {s : ℂ} (hs : 1 < s.re) :
    Filter.Tendsto
      (fun N : ℕ => ∑ n ∈ Finset.range N, LSeries.term (fun n => (ArithmeticFunction.zeta n : ℂ)) s n)
      Filter.atTop (nhds (riemannZeta s)) := by
  exact (sr36_zeta_dirichlet_series hs).tendsto_sum_nat

theorem sr36_signed_polynomial_as_LSeries_sum (X : Nat) (s : ℂ) :
    SR_signed_dirichlet_polynomial X s =
      ∑ k ∈ Finset.range (X ^ 2),
        LSeries.term (fun k => (SR_signed_divisor_coefficient X k : ℂ)) s k := by
  unfold SR_signed_dirichlet_polynomial
  apply Finset.sum_congr rfl
  intro k hk
  by_cases hzero : k = 0
  · subst k
    simp [sr36_zero_divisor_coefficient]
  · rw [LSeries.term_def₀ (by simp [sr36_zero_divisor_coefficient])]
    congr 1
    rw [show (k : ℂ) = ((k : ℝ) : ℂ) from by norm_cast]
    rw [Complex.cpow_def_of_ne_zero (by exact_mod_cast hzero)]
    rw [Complex.ofReal_log (by positivity)]
    ring_nf

theorem sr36_small_divisor_coefficient (X k : Nat) (hk : k < 4) :
    SR_signed_divisor_coefficient X k = 0 := by
  unfold SR_signed_divisor_coefficient SR_divisorMultiplicity
  have hempty :
      ((completeSupport X).toFinset.product (completeSupport X).toFinset).filter
          (fun p => p.1 * p.2 = k) = ∅ := by
    ext p
    constructor
    · intro hp
      rw [Finset.mem_filter] at hp
      rcases Finset.mem_product.mp hp.1 with ⟨hpm, hpn⟩
      have hmb := completeSupport_mem_bounds (by simpa using hpm)
      have hnb := completeSupport_mem_bounds (by simpa using hpn)
      have hprod : 2 * 2 ≤ p.1 * p.2 := Nat.mul_le_mul hmb.1 hnb.1
      omega
    · intro hp
      simp at hp
  rw [hempty]
  simp

theorem sr36_signed_polynomial_range_four (X : Nat) (s : ℂ) :
    SR_signed_dirichlet_polynomial X s =
      ∑ k ∈ Finset.range (X ^ 2),
        if 4 ≤ k then
          (SR_signed_divisor_coefficient X k : ℂ) *
            Complex.exp (-s * (Real.log k : ℂ))
        else 0 := by
  unfold SR_signed_dirichlet_polynomial
  apply Finset.sum_congr rfl
  intro k hk
  by_cases h : 4 ≤ k
  · simp [h]
  · have hsmall : k < 4 := by omega
    rw [sr36_small_divisor_coefficient X k hsmall]
    simp [h]

theorem sr36_log_product_additive {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X) :
    Real.log ((m * n : Nat) : ℝ) = Real.log m + Real.log n := by
  have hmpos : 0 < (m : ℝ) := by exact_mod_cast sr36_support_pos hm
  have hnpos : 0 < (n : ℝ) := by exact_mod_cast sr36_support_pos hn
  rw [Nat.cast_mul, Real.log_mul hmpos.ne' hnpos.ne']

theorem sr36_parameter_product_log_exponent {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X)
    (beta gamma : ℝ) :
    -SR_complex_parameter beta gamma *
        (Real.log ((m * n : Nat) : ℝ) : ℂ) =
      ((beta - 1 / 2) * Real.log ((m * n : Nat) : ℝ) : ℂ) +
        ((gamma * Real.log ((m * n : Nat) : ℝ) : ℝ) : ℂ) * Complex.I := by
  exact sr36_parameter_exponent beta gamma (Real.log ((m * n : Nat) : ℝ))

theorem sr36_parameter_product_kernel_split {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X)
    (beta gamma : ℝ) :
    Complex.exp (-SR_complex_parameter beta gamma *
        (Real.log ((m * n : Nat) : ℝ) : ℂ)) =
      Complex.exp (((beta - 1 / 2) * Real.log ((m * n : Nat) : ℝ) : ℂ)) *
        Complex.exp (((gamma * Real.log ((m * n : Nat) : ℝ) : ℝ) : ℂ) * Complex.I) := by
  rw [sr36_parameter_product_log_exponent hm hn beta gamma, Complex.exp_add]

theorem sr36_product_rpow_exponential {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X)
    (beta : ℝ) :
    Complex.ofReal (((m * n : Nat) : ℝ) ^ (beta - 1 / 2)) =
      Complex.exp (((beta - 1 / 2) *
        Real.log ((m * n : Nat) : ℝ) : ℝ) : ℂ) := by
  have hpos : 0 < ((m * n : Nat) : ℝ) := by
    exact_mod_cast sr36_product_pos hm hn
  rw [Real.rpow_def_of_pos hpos]
  rw [Complex.ofReal_exp]
  congr 1
  ring_nf

theorem sr36_product_kernel_matches_pair_phase {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X)
    (beta gamma : ℝ) :
    Complex.ofReal (((m * n : Nat) : ℝ) ^ (beta - 1 / 2)) *
        Complex.exp (((gamma * (Real.log m + Real.log n) : ℝ) : ℂ) * Complex.I) =
      Complex.exp (((beta - 1 / 2) * Real.log ((m * n : Nat) : ℝ) : ℝ) : ℂ) *
        Complex.exp (((gamma * Real.log ((m * n : Nat) : ℝ) : ℝ) : ℂ) * Complex.I) := by
  rw [sr36_product_rpow_exponential hm hn beta]
  rw [sr36_log_product_additive hm hn]

theorem sr36_parameter_kernel_matches_pair_phase {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X)
    (beta gamma : ℝ) :
    Complex.exp (-SR_complex_parameter beta gamma *
        (Real.log ((m * n : Nat) : ℝ) : ℂ)) =
      Complex.ofReal (((m * n : Nat) : ℝ) ^ (beta - 1 / 2)) *
        Complex.exp (((gamma * (Real.log m + Real.log n) : ℝ) : ℂ) * Complex.I) := by
  rw [sr36_parameter_product_kernel_split hm hn]
  rw [sr36_product_rpow_exponential hm hn beta]
  rw [sr36_log_product_additive hm hn]
  congr 1
  norm_num [Complex.ofReal_mul, Complex.ofReal_sub, Complex.ofReal_div] <;> ring_nf

theorem sr36_signed_polynomial_parameter_product_sum
    (X : Nat) (beta gamma : ℝ) :
    SR_signed_dirichlet_polynomial X (SR_complex_parameter beta gamma) =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        (if p.1 * p.2 < X then (-1 : ℂ) else 1) *
          Complex.exp (-SR_complex_parameter beta gamma *
            (Real.log (p.1 * p.2) : ℂ)) := by
  exact sr36_signed_polynomial_as_product_sum X
    (SR_complex_parameter beta gamma)

theorem sr36_exp_phase_re (x : ℝ) :
    (Complex.exp (((x : ℂ) * Complex.I))).re = Real.cos x := by
  rw [Complex.exp_mul_I]
  simpa using Complex.cos_ofReal_re x

theorem sr36_real_mul_exp_phase_re (a x : ℝ) :
    (Complex.ofReal a * Complex.exp (((x : ℂ) * Complex.I))).re =
      a * Real.cos x := by
  rw [Complex.mul_re]
  simp only [Complex.ofReal_re, Complex.ofReal_im, zero_mul, sub_zero]
  rw [sr36_exp_phase_re]

theorem sr36_signed_polynomial_parameter_re
    (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) :
    (SR_signed_dirichlet_polynomial X (SR_complex_parameter beta gamma)).re =
      SR_channel_product X beta gamma := by
  rw [sr36_signed_polynomial_parameter_product_sum]
  rw [Complex.re_sum]
  rw [SR_product_channel_divisor_form X hX beta gamma]
  rw [SR_product_channel_divisor_as_product_sum X hX beta gamma]
  apply Finset.sum_congr rfl
  intro p hp
  have hpm : p.1 ∈ completeSupport X := by
    simpa using (Finset.mem_product.mp hp).1
  have hpn : p.2 ∈ completeSupport X := by
    simpa using (Finset.mem_product.mp hp).2
  rw [← Nat.cast_mul]
  rw [sr36_parameter_kernel_matches_pair_phase hpm hpn beta gamma]
  split_ifs <;> norm_num
  all_goals
    left
    have hphase := sr36_exp_phase_re
      (gamma * (Real.log p.1 + Real.log p.2))
    convert hphase using 1
    · push_cast
      ring
    · rw [← Nat.cast_mul]
      rw [sr36_log_product_additive hpm hpn]

noncomputable def SR_product_channel_complex (X : Nat) (beta gamma : ℝ) : ℂ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      Complex.ofReal ((reesEntryFromNat X m n : ℝ) *
        (((m : ℝ) * n) ^ (beta - 1 / 2))) *
        Complex.exp (((gamma * (Real.log m + Real.log n) : ℝ) : ℂ) * Complex.I)

theorem sr36_complex_product_re (X : Nat) (beta gamma : ℝ) :
    (SR_product_channel_complex X beta gamma).re =
      SR_channel_product X beta gamma := by
  unfold SR_product_channel_complex SR_channel_product
  rw [Complex.re_sum]
  apply Finset.sum_congr rfl
  intro m hm
  rw [Complex.re_sum]
  apply Finset.sum_congr rfl
  intro n hn
  rw [sr36_real_mul_exp_phase_re]

noncomputable def SR_product_channel_complex_divisor
    (X : Nat) (beta gamma : ℝ) : ℂ :=
  ∑ k ∈ Finset.range (X ^ 2),
    Complex.ofReal (if k < X then (-1 : ℝ) else 1) *
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset
        with p.1 * p.2 = k,
        Complex.ofReal (((p.1 : ℝ) * p.2) ^ (beta - 1 / 2)) *
          Complex.exp (((gamma * (Real.log p.1 + Real.log p.2) : ℝ) : ℂ) * Complex.I)

theorem sr36_complex_divisor_fiber_sum
    (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) :
    SR_product_channel_complex_divisor X beta gamma =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        Complex.ofReal (if p.1 * p.2 < X then (-1 : ℝ) else 1) *
          (Complex.ofReal (((p.1 : ℝ) * p.2) ^ (beta - 1 / 2)) *
            Complex.exp (((gamma * (Real.log p.1 + Real.log p.2) : ℝ) : ℂ) * Complex.I)) := by
  classical
  unfold SR_product_channel_complex_divisor
  have hmap : ∀ p ∈ (completeSupport X).toFinset.product
      (completeSupport X).toFinset, p.1 * p.2 ∈ Finset.range (X ^ 2) := by
    intro p hp
    rcases Finset.mem_product.mp hp with ⟨hpm, hpn⟩
    have hpm' : p.1 ∈ completeSupport X := by simpa using hpm
    have hpn' : p.2 ∈ completeSupport X := by simpa using hpn
    have hmb := completeSupport_mem_bounds hpm'
    have hnb := completeSupport_mem_bounds hpn'
    have h1 : p.1 * p.2 < p.1 * X := Nat.mul_lt_mul_of_pos_left hnb.2 (by omega)
    have h2 : p.1 * X < X * X := Nat.mul_lt_mul_of_pos_right hmb.2 (by omega)
    exact Finset.mem_range.mpr (h1.trans (by simpa [pow_two] using h2))
  calc
    _ = ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        Complex.ofReal (if p.1 * p.2 < X then (-1 : ℝ) else 1) *
          (Complex.ofReal (((p.1 : ℝ) * p.2) ^ (beta - 1 / 2)) *
            Complex.exp (((gamma * (Real.log p.1 + Real.log p.2) : ℝ) : ℂ) * Complex.I)) := by
      simpa using (sr36_weighted_fiber_sum hmap
        (fun k : Nat => Complex.ofReal (if k < X then (-1 : ℝ) else 1))
        (fun p : Nat × Nat =>
          Complex.ofReal (((p.1 : ℝ) * p.2) ^ (beta - 1 / 2)) *
            Complex.exp (((gamma * (Real.log p.1 + Real.log p.2) : ℝ) : ℂ) * Complex.I)))

theorem sr36_rees_sign_real_cast (X m n : Nat) :
    Complex.ofReal (if m * n < X then (-1 : ℝ) else 1) =
      Complex.ofReal (reesEntryFromNat X m n : ℝ) := by
  rw [sr36_rees_sign_by_product]
  split_ifs <;> norm_num

theorem sr36_complex_divisor_pair_normalization
    (X : Nat) (beta gamma : ℝ) :
    (∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
      Complex.ofReal (if p.1 * p.2 < X then (-1 : ℝ) else 1) *
        (Complex.ofReal (((p.1 : ℝ) * p.2) ^ (beta - 1 / 2)) *
          Complex.exp (((gamma * (Real.log p.1 + Real.log p.2) : ℝ) : ℂ) * Complex.I))) =
    SR_product_channel_complex X beta gamma := by
  unfold SR_product_channel_complex
  simpa only [sr36_rees_sign_real_cast, Complex.ofReal_mul, mul_assoc] using
      (Finset.sum_product (completeSupport X).toFinset
      (completeSupport X).toFinset (fun p : Nat × Nat =>
        Complex.ofReal (reesEntryFromNat X p.1 p.2 : ℝ) *
          (Complex.ofReal (((p.1 : ℝ) * p.2) ^ (beta - 1 / 2)) *
            Complex.exp (((gamma * (Real.log p.1 + Real.log p.2) : ℝ) : ℂ) * Complex.I))))

theorem sr36_signed_polynomial_parameter_complex
    (X : Nat) (beta gamma : ℝ) :
    SR_signed_dirichlet_polynomial X (SR_complex_parameter beta gamma) =
      SR_product_channel_complex X beta gamma := by
  rw [sr36_signed_polynomial_parameter_product_sum]
  calc
    (∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        (if p.1 * p.2 < X then (-1 : ℂ) else 1) *
          Complex.exp (-SR_complex_parameter beta gamma *
            (Real.log (p.1 * p.2) : ℂ))) =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        (if p.1 * p.2 < X then (-1 : ℝ) else 1) *
          (Complex.ofReal (((p.1 : ℝ) * p.2) ^ (beta - 1 / 2)) *
            Complex.exp (((gamma * (Real.log p.1 + Real.log p.2) : ℝ) : ℂ) * Complex.I)) := by
      apply Finset.sum_congr rfl
      intro p hp
      have hpm : p.1 ∈ completeSupport X := by simpa using (Finset.mem_product.mp hp).1
      have hpn : p.2 ∈ completeSupport X := by simpa using (Finset.mem_product.mp hp).2
      rw [← Nat.cast_mul, sr36_parameter_kernel_matches_pair_phase hpm hpn beta gamma]
      split_ifs <;> norm_num
    _ = SR_product_channel_complex X beta gamma :=
      sr36_complex_divisor_pair_normalization X beta gamma

theorem sr36_signed_polynomial_parameter_re_from_complex
    (X : Nat) (beta gamma : ℝ) :
    (SR_signed_dirichlet_polynomial X (SR_complex_parameter beta gamma)).re =
      SR_channel_product X beta gamma := by
  rw [sr36_signed_polynomial_parameter_complex]
  exact sr36_complex_product_re X beta gamma

theorem sr36_signed_polynomial_at_neutral_parameter (X : Nat) :
    SR_signed_dirichlet_polynomial X (SR_complex_parameter (1 / 2) 0) =
      ∑ k ∈ Finset.range (X ^ 2), (SR_signed_divisor_coefficient X k : ℂ) := by
  simp [SR_signed_dirichlet_polynomial, SR_complex_parameter]

theorem sr36_signed_polynomial_at_zero (X : Nat) :
    SR_signed_dirichlet_polynomial X 0 =
      ∑ k ∈ Finset.range (X ^ 2), (SR_signed_divisor_coefficient X k : ℂ) := by
  simp [SR_signed_dirichlet_polynomial]

theorem sr36_signed_polynomial_deriv_at_zero (X : Nat) :
    deriv (SR_signed_dirichlet_polynomial X) 0 =
      ∑ k ∈ Finset.range (X ^ 2),
        (SR_signed_divisor_coefficient X k : ℂ) *
          (-(Real.log k : ℂ)) := by
  rw [sr36_signed_dirichlet_polynomial_deriv_eq_deriv]
  simp [SR_signed_dirichlet_polynomial_deriv]

theorem sr36_signed_polynomial_second_deriv_at_zero (X : Nat) :
    deriv (SR_signed_dirichlet_polynomial_deriv X) 0 =
      ∑ k ∈ Finset.range (X ^ 2),
        (SR_signed_divisor_coefficient X k : ℂ) *
          ((Real.log k : ℂ) * (Real.log k : ℂ)) := by
  rw [(sr36_signed_dirichlet_polynomial_hasSecondDerivAt X 0).deriv]
  simp [SR_signed_dirichlet_polynomial_second_deriv]

theorem sr36_signed_polynomial_third_deriv_at_zero (X : Nat) :
    deriv (SR_signed_dirichlet_polynomial_second_deriv X) 0 =
      ∑ k ∈ Finset.range (X ^ 2),
        (SR_signed_divisor_coefficient X k : ℂ) *
          (-(Real.log k : ℂ) * (Real.log k : ℂ) * (Real.log k : ℂ)) := by
  rw [(sr36_signed_dirichlet_polynomial_hasThirdDerivAt X 0).deriv]
  simp [SR_signed_dirichlet_polynomial_third_deriv]

theorem sr36_signed_polynomial_at_neutral_parameter_re (X : Nat) :
    (SR_signed_dirichlet_polynomial X (SR_complex_parameter (1 / 2) 0)).re =
      ∑ k ∈ Finset.range (X ^ 2), (SR_signed_divisor_coefficient X k : ℝ) := by
  rw [sr36_signed_polynomial_at_neutral_parameter]
  simp

theorem sr36_channel_product_at_neutral_parameter (X : Nat) :
    SR_channel_product X (1 / 2) 0 =
      ∑ k ∈ Finset.range (X ^ 2), (SR_signed_divisor_coefficient X k : ℝ) := by
  rw [← sr36_signed_polynomial_at_neutral_parameter_re]
  exact (sr36_signed_polynomial_parameter_re_from_complex X (1 / 2) 0).symm

theorem sr36_signed_coefficient_sum_as_product_sign (X : Nat) :
    ∑ k ∈ Finset.range (X ^ 2), (SR_signed_divisor_coefficient X k : ℝ) =
      ∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
        (if p.1 * p.2 < X then (-1 : ℝ) else 1) := by
  rw [← sr36_channel_product_at_neutral_parameter]
  unfold SR_channel_product
  simp [sr36_rees_sign_by_product, Finset.sum_product]

theorem sr36_product_sign_sum_nested (X : Nat) :
    (∑ p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset,
      (if p.1 * p.2 < X then (-1 : ℝ) else 1)) =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          (if m * n < X then (-1 : ℝ) else 1) := by
  simpa using (Finset.sum_product
    (completeSupport X).toFinset (completeSupport X).toFinset
    (fun p : Nat × Nat => if p.1 * p.2 < X then (-1 : ℝ) else 1))

theorem sr36_signed_coefficient_sum_eq_allOnes (X : Nat) :
    ∑ k ∈ Finset.range (X ^ 2), (SR_signed_divisor_coefficient X k : ℝ) =
      allOnesEntrySum X := by
  rw [sr36_signed_coefficient_sum_as_product_sign]
  unfold allOnesEntrySum
  rw [sr36_completeSupport_int_sum_cast X]
  rw [sr36_product_sign_sum_nested]
  apply Finset.sum_congr rfl
  intro m hm
  rw [sr36_completeSupport_int_sum_cast X]
  norm_cast

theorem sr36_signed_coefficient_sum_X210_certified :
    ∑ k ∈ Finset.range (210 ^ 2), (SR_signed_divisor_coefficient 210 k : ℝ) = 41798 := by
  rw [sr36_signed_coefficient_sum_eq_allOnes, allOnesEntrySum_X210]
  norm_num

theorem sr36_divisorMultiplicity_X6_4 : SR_divisorMultiplicity 6 4 = 1 := by
  native_decide

theorem sr36_signed_coefficient_sum_X6 :
    ∑ k ∈ Finset.range (6 ^ 2), SR_signed_divisor_coefficient 6 k = 14 := by
  native_decide

theorem sr36_signed_coefficient_sum_matches_allOnes_X6 :
    ∑ k ∈ Finset.range (6 ^ 2), SR_signed_divisor_coefficient 6 k =
      allOnesEntrySum 6 := by
  rw [sr36_signed_coefficient_sum_X6, allOnesEntrySum_X6]

theorem sr36_signed_coefficient_sum_X35 :
    ∑ k ∈ Finset.range (35 ^ 2), SR_signed_divisor_coefficient 35 k = 969 := by
  native_decide

theorem sr36_signed_coefficient_sum_matches_allOnes_X35 :
    ∑ k ∈ Finset.range (35 ^ 2), SR_signed_divisor_coefficient 35 k =
      allOnesEntrySum 35 := by
  rw [sr36_signed_coefficient_sum_X35, allOnesEntrySum_X35]

theorem sr36_channel_product_neutral_X6 :
    SR_channel_product 6 (1 / 2) 0 = 14 := by
  rw [sr36_channel_product_at_neutral_parameter]
  norm_cast

theorem sr36_complex_divisor_re (X : Nat) (hX : 6 ≤ X) (beta gamma : ℝ) :
    (SR_product_channel_complex_divisor X beta gamma).re =
      SR_channel_product X beta gamma := by
  rw [sr36_complex_divisor_fiber_sum X hX beta gamma,
    sr36_complex_divisor_pair_normalization X beta gamma]
  exact sr36_complex_product_re X beta gamma

def SR_product_channel_divisor_reorganization_conjecture : Prop :=
  ∀ (X : Nat), 6 ≤ X → ∀ (beta gamma : ℝ),
    SR_channel_product X beta gamma =
      SR_product_channel_as_divisor_sum X beta gamma

theorem SR_product_channel_divisor_reorganization_conjecture_certified :
    SR_product_channel_divisor_reorganization_conjecture := by
  intro X hX beta gamma
  exact SR_product_channel_divisor_form X hX beta gamma

theorem SR_gram_entry_X30_5_7 : SR_gram_entry 30 5 7 = 26 := by native_decide

theorem sr37_signed_coefficient_not_vonMangoldt_X6_4 :
    (SR_signed_divisor_coefficient 6 4 : ℝ) ≠
      ArithmeticFunction.vonMangoldt 4 := by
  have hc : SR_signed_divisor_coefficient 6 4 = -1 := by
    native_decide
  rw [hc, ArithmeticFunction.vonMangoldt_apply]
  have h4 : IsPrimePow 4 := by native_decide
  have hm4 : Nat.minFac 4 = 2 := by native_decide
  rw [if_pos h4, hm4]
  intro hEq
  have hlog : 0 < Real.log (2 : ℝ) := by
    exact Real.log_pos (by norm_num)
  norm_num at hEq
  linarith [hEq, hlog]

/--
The unrestricted SR signed coefficient: the negation of the count of ordered
pairs (m, n) with m ≥ 2, n ≥ 2, and m * n = k. For k < X, this equals
SR_signed_divisor_coefficient X k because the support condition is automatically
satisfied.
-/
def SR_coeff_unrestricted (k : Nat) : ℤ :=
  -(((k.divisorsAntidiagonal).filter (fun p => 2 ≤ p.1 ∧ 2 ≤ p.2)).card : ℤ)

theorem SR_coeff_unrestricted_zero : SR_coeff_unrestricted 0 = 0 := by
  native_decide

theorem SR_coeff_unrestricted_one : SR_coeff_unrestricted 1 = 0 := by
  native_decide

/--
Coefficient stabilization: for k ≥ 2 and k < X, the SR signed divisor
coefficient at (X, k) equals the unrestricted coefficient SR_coeff_unrestricted k.

Key: if m ≥ 2, n ≥ 2, and m * n = k with k < X, then m ≤ k < X and n ≤ k < X,
so (m, n) ∈ completeSupport X × completeSupport X.
The count in SR_divisorMultiplicity X k therefore equals the unrestricted count,
and since k < X the sign factor is -1.
-/
theorem sr36_coefficient_stabilization (X k : Nat) (hk2 : 2 ≤ k) (hkX : k < X) :
    SR_signed_divisor_coefficient X k = SR_coeff_unrestricted k := by
  unfold SR_signed_divisor_coefficient SR_divisorMultiplicity SR_coeff_unrestricted
  simp only [if_pos hkX, neg_one_mul]
  congr 1
  norm_cast
  apply Finset.card_bij (fun p _ => p)
  · intro p hp
    rcases p with ⟨m, n⟩
    have hpfilter := Finset.mem_filter.mp hp
    have hprod := Finset.mem_product.mp hpfilter.1
    have hm_mem : m ∈ completeSupport X := by
      simpa using hprod.1
    have hn_mem : n ∈ completeSupport X := by
      simpa using hprod.2
    have hmbounds := completeSupport_mem_bounds hm_mem
    have hnbounds := completeSupport_mem_bounds hn_mem
    apply Finset.mem_filter.mpr
    refine ⟨?_, ?_⟩
    · exact Nat.mem_divisorsAntidiagonal.mpr ⟨hpfilter.2, by omega⟩
    · exact ⟨hmbounds.1, hnbounds.1⟩
  · intro p _ q _ h
    exact h
  · intro p hp
    rcases p with ⟨m, n⟩
    have hpfilter := Finset.mem_filter.mp hp
    have hd := Nat.mem_divisorsAntidiagonal.mp hpfilter.1
    have hmn_eq : m * n = k := hd.1
    have hm2 : 2 ≤ m := hpfilter.2.1
    have hn2 : 2 ≤ n := hpfilter.2.2
    have hmpos : 0 < m := by omega
    have hnpos : 0 < n := by omega
    have hmlt : m < X := by
      have hm_le_k : m ≤ k := by
        rw [← hmn_eq]
        exact Nat.le_mul_of_pos_right m hnpos
      omega
    have hnlt : n < X := by
      have hn_le_k : n ≤ k := by
        rw [← hmn_eq]
        exact Nat.le_mul_of_pos_left n hmpos
      omega
    have hsource : (m, n) ∈
        ((completeSupport X).toFinset.product (completeSupport X).toFinset).filter
          (fun p => p.1 * p.2 = k) := by
      apply Finset.mem_filter.mpr
      refine ⟨?_, hmn_eq⟩
      apply Finset.mem_product.mpr
      exact ⟨by simpa using sr37_support_eventual_membership hm2 hmlt,
        by simpa using sr37_support_eventual_membership hn2 hnlt⟩
    exact ⟨(m, n), hsource, rfl⟩

/-!
## Open conjecture: Dirichlet-series identity for SR_coeff_unrestricted

The unrestricted SR coefficient series is (formally) the negation of the
Dirichlet convolution of the indicator u(n) = if n ≥ 2 then 1 else 0 with
itself. That is, A(s) = -(ζ(s) - 1)² for Re(s) > 1.

OPEN (no formal proof): The proof requires verifying that the L-series of
u(n) = (n ≥ 2 ? 1 : 0) equals ζ(s) - 1 using the Mathlib API for
LSeriesSummable and LSeries.convolution, then applying LSeries_convolution' to
get the product, then using LSeries_one_eq_riemannZeta. These steps are
individually available in Mathlib but the combination requires careful handling
of the k=0 term.

DISPROVED AS RH ROUTE: The limit -(ζ(s)-1)² is holomorphic for Re(s) > 1 and
has no poles at nontrivial zeta zeros. It cannot directly encode zero locations.
Any nontrivial use for RH would require analytic continuation and a separate
comparison with (log ζ)'(s) or the explicit formula — neither of which is
formalized here.

TARGETS PENDING FORMAL PROOF:
  sr36_coefficient_lseries_eq_zeta_minus_one_sq:
    LSeries (SR_coeff_unrestricted) s = -(riemannZeta s - 1)^2  [Re(s) > 1]
  sr36_signed_poly_tendsto_pair_sum:
    Filter.Tendsto (fun X => SR_signed_dirichlet_polynomial X s) atTop
      (nhds (-(∑' pairs with m,n≥2, exp(-s*log(mn)))))
  sr36_tsum_ge2_eq_zeta_sub_one:
    ∑' m≥2, exp(-s*log m) = ζ(s) - 1
  sr36_signed_poly_limit_eq_zeta_sq:
    Filter.Tendsto (fun X => SR_signed_dirichlet_polynomial X s)
      atTop (nhds (-(riemannZeta s - 1)^2))
-/

end SR
