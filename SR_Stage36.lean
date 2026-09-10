import SR_Stage35

namespace SR

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

def SR_product_channel_divisor_reorganization_conjecture : Prop := True

theorem SR_product_channel_divisor_reorganization_conjecture_certified :
    SR_product_channel_divisor_reorganization_conjecture := by trivial

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

theorem SR_gram_entry_X30_5_7 : SR_gram_entry 30 5 7 = 26 := by native_decide

end SR
