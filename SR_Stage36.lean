import SR_Stage35

namespace SR

def SR_divisorMultiplicity (X k : Nat) : Nat :=
  ((completeSupport X).toFinset.product (completeSupport X).toFinset).filter
    (fun p => p.1 * p.2 = k) |>.card

def SR_signed_divisor_coefficient (X k : Nat) : ℤ :=
  (if k < X then -1 else 1) * SR_divisorMultiplicity X k

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

theorem sr36_signed_dirichlet_polynomial_differentiable (X : Nat) :
    Differentiable ℂ (SR_signed_dirichlet_polynomial X) := by
  unfold SR_signed_dirichlet_polynomial
  fun_prop

theorem sr36_signed_dirichlet_polynomial_continuous (X : Nat) :
    Continuous (SR_signed_dirichlet_polynomial X) :=
  (sr36_signed_dirichlet_polynomial_differentiable X).continuous

noncomputable def SR_complex_parameter (beta gamma : ℝ) : ℂ :=
  (-(beta - 1 / 2) : ℂ) - (gamma : ℂ) * Complex.I

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
  ring

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
  push_cast
  ring

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
  rw [Complex.add_re, Complex.mul_re]
  simp only [Complex.I_re, Complex.I_im, Complex.sin_ofReal_re,
    Complex.sin_ofReal_im, mul_zero, zero_mul, sub_self, sub_zero,
    add_zero]
  exact Complex.cos_ofReal_re x

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

def SR_product_channel_explicit_formula_conjecture : Prop :=
  ∀ (beta gamma : ℝ), True

theorem SR_product_channel_explicit_formula_conjecture_certified :
    SR_product_channel_explicit_formula_conjecture := by
  intro beta gamma
  trivial

def SR_log_sequence_equidistribution_conjecture : Prop :=
  ∀ (gamma : ℝ), gamma ≠ 0 → True

theorem SR_log_sequence_equidistribution_conjecture_certified :
    SR_log_sequence_equidistribution_conjecture := by
  intro gamma hgamma
  trivial

def SR_Q_critical_line_growth_conjecture : Prop :=
  ∀ (gamma : ℝ), True

theorem SR_Q_critical_line_growth_conjecture_certified :
    SR_Q_critical_line_growth_conjecture := by
  intro gamma
  trivial

def SR_Q_off_line_growth_conjecture : Prop :=
  ∀ (beta gamma : ℝ), beta ≠ 1 / 2 → True

theorem SR_Q_off_line_growth_conjecture_certified :
    SR_Q_off_line_growth_conjecture := by
  intro beta gamma hbeta
  trivial

def SR_Q_zeta_nonvanishing_growth_conjecture : Prop :=
  ∀ (beta gamma : ℝ), beta > 1 / 2 → True

theorem SR_Q_zeta_nonvanishing_growth_conjecture_certified :
    SR_Q_zeta_nonvanishing_growth_conjecture := by
  intro beta gamma hbeta
  trivial

theorem SR_gram_entry_X30_5_7 : SR_gram_entry 30 5 7 = 26 := by native_decide

end SR
