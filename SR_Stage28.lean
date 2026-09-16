import SR_Stage27

namespace SR

/-! Stage 28: support-restricted Abel bridge scaffolding. -/

noncomputable def psi_SR (X : Nat) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset, Real.log (m : ℝ)

noncomputable def psi2_SR_28 (X : Nat) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      if m * n < X then Real.log (m : ℝ) * Real.log (n : ℝ) else 0

noncomputable def psi2_SR_partial (X j : Nat) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      if m * n ≤ j then Real.log (m : ℝ) * Real.log (n : ℝ) else 0

theorem stage28_completeSupport_nodup (X : Nat) : (completeSupport X).Nodup := by
  unfold completeSupport
  apply List.Nodup.map (f := fun k : Nat => k + 2)
  · intro a b hab
    exact Nat.add_right_cancel hab
  · exact List.nodup_range

theorem completeSupport_sum_eq_finset_sum (X : Nat) (f : Nat → ℝ) :
    ((completeSupport X).map f).sum =
      (completeSupport X).toFinset.sum f := by
  symm
  exact List.sum_toFinset f (stage28_completeSupport_nodup X)

theorem SR_Sint_log_finset (X : Nat) :
    SR_Sint_log X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          if m * n < X then
            Real.log (m : ℝ) * Real.log (n : ℝ) * (Real.sqrt (m * n))⁻¹
          else 0 := by
  unfold SR_Sint_log
  rw [completeSupport_sum_eq_finset_sum X]
  apply Finset.sum_congr rfl
  intro m hm
  simpa using completeSupport_sum_eq_finset_sum X (fun n =>
    if m * n < X then
      Real.log (m : ℝ) * Real.log (n : ℝ) * (Real.sqrt (m * n))⁻¹
    else 0)

theorem psi_SR_sq_finset (X : Nat) :
    psi_SR X ^ 2 =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          Real.log (m : ℝ) * Real.log (n : ℝ) := by
  unfold psi_SR
  rw [pow_two]
  symm
  exact sr_finset_double_sum_mul (completeSupport X).toFinset
    (fun m => Real.log (m : ℝ)) (fun n => Real.log (n : ℝ))

theorem Sint_log_lower_bound (X : Nat) (hX : 6 ≤ X) :
    psi2_SR_28 X / Real.sqrt (X - 1 : ℝ) ≤ SR_Sint_log X := by
  classical
  rw [SR_Sint_log_finset]
  unfold psi2_SR_28
  rw [Finset.sum_div]
  apply Finset.sum_le_sum
  intro m hm
  rw [Finset.sum_div]
  apply Finset.sum_le_sum
  intro n hn
  by_cases h : m * n < X
  · have hmn : m * n ≤ X - 1 := by omega
    have hs : Real.sqrt ((m * n : Nat) : ℝ) ≤ Real.sqrt ((X - 1 : Nat) : ℝ) := by
      apply Real.sqrt_le_sqrt
      exact_mod_cast hmn
    have hlog : 0 ≤ Real.log (m : ℝ) * Real.log (n : ℝ) := by
      have hm' := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      have hn' := completeSupport_mem_bounds (List.mem_toFinset.mp hn)
      have hm1 : (1 : Nat) ≤ m := by omega
      have hn1 : (1 : Nat) ≤ n := by omega
      exact mul_nonneg (Real.log_nonneg (by exact_mod_cast hm1))
        (Real.log_nonneg (by exact_mod_cast hn1))
    have hm' := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
    have hn' := completeSupport_mem_bounds (List.mem_toFinset.mp hn)
    have hprod : 0 < (m * n : ℝ) := by
      exact_mod_cast (Nat.mul_pos (by omega) (by omega))
    have hs' : Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ) ≤
        Real.sqrt ((X - 1 : Nat) : ℝ) := by
      calc
        Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ) =
            Real.sqrt ((m : ℝ) * (n : ℝ)) := by
              rw [Real.sqrt_mul (by positivity)]
        _ = Real.sqrt ((m * n : Nat) : ℝ) := by
              rw [← sr_sqrt_prod_eq m n]
        _ ≤ Real.sqrt ((X - 1 : Nat) : ℝ) := hs
    have hi := one_div_le_one_div_of_le
      (mul_pos (Real.sqrt_pos.2 (by exact_mod_cast (show 0 < m by omega)))
        (Real.sqrt_pos.2 (by exact_mod_cast (show 0 < n by omega)))) hs'
    have hh := mul_le_mul_of_nonneg_left hi hlog
    simpa [h, div_eq_mul_inv, mul_comm, mul_left_comm, mul_assoc,
      Nat.cast_sub (by omega : 1 ≤ X)] using hh
  · simp [h]
theorem psi2_SR_28_nonneg (X : Nat) : 0 ≤ psi2_SR_28 X := by
  unfold psi2_SR_28
  apply Finset.sum_nonneg
  intro m hm
  apply Finset.sum_nonneg
  intro n hn
  split_ifs
  · positivity
  · simp

theorem psi_SR_nonneg (X : Nat) : 0 ≤ psi_SR X := by
  unfold psi_SR
  apply Finset.sum_nonneg
  intro m hm
  exact Real.log_nonneg (by
    have h := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
    have hm1 : 1 ≤ m := by omega
    exact_mod_cast hm1)

theorem psi2_SR_partial_terminal (X : Nat) :
    psi2_SR_partial X (X - 1) = psi2_SR_28 X := by
  unfold psi2_SR_partial psi2_SR_28
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  by_cases h : m * n < X
  · have h' : m * n ≤ X - 1 := by omega
    simp [h, h']
  · have hx : X ≤ m * n := Nat.le_of_not_gt h
    have hXpos : 0 < X := by
      have hmX := (completeSupport_mem_bounds (List.mem_toFinset.mp hm)).2
      omega
    have h' : ¬ m * n ≤ X - 1 := by
      intro hle
      have hlt : m * n < X := by omega
      exact h hlt
    simp [h, h']

theorem psi2_SR_partial_mono (X j k : Nat) (hjk : j ≤ k) :
    psi2_SR_partial X j ≤ psi2_SR_partial X k := by
  unfold psi2_SR_partial
  apply Finset.sum_le_sum
  intro m hm
  apply Finset.sum_le_sum
  intro n hn
  by_cases hj : m * n ≤ j
  · have hk : m * n ≤ k := le_trans hj hjk
    simp [hj, hk]
  · by_cases hk : m * n ≤ k
    · simp [hj, hk]
      positivity
    · simp [hj, hk]

theorem psi2_SR_partial_le_terminal (X j : Nat) (hj : j ≤ X - 1) :
    psi2_SR_partial X j ≤ psi2_SR_28 X := by
  rw [← psi2_SR_partial_terminal X]
  exact psi2_SR_partial_mono X j (X - 1) hj

theorem psi2_SR_partial_nonneg (X j : Nat) :
    0 ≤ psi2_SR_partial X j := by
  unfold psi2_SR_partial
  apply Finset.sum_nonneg
  intro m hm
  apply Finset.sum_nonneg
  intro n hn
  split_ifs
  · positivity
  · simp

theorem sqrt_recip_diff_nonneg {j : Nat} (hj : 1 ≤ j) :
    0 ≤ 1 / Real.sqrt (j : ℝ) - 1 / Real.sqrt ((j + 1 : Nat) : ℝ) := by
  have hj' : 0 < (j : ℝ) := by exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one hj)
  have hj1' : 0 < ((j + 1 : Nat) : ℝ) := by positivity
  have hs : Real.sqrt (j : ℝ) ≤ Real.sqrt ((j + 1 : Nat) : ℝ) := by
    apply Real.sqrt_le_sqrt
    norm_num
  exact sub_nonneg.mpr (one_div_le_one_div_of_le
    (Real.sqrt_pos.2 hj') hs)

theorem finite_difference_telescopes (f : Nat → ℝ) (a b : Nat) (hab : a ≤ b) :
    ∑ j ∈ Finset.Ico a b, (f j - f (j + 1)) = f a - f b := by
  have hrange : ∀ n : Nat, (∑ j ∈ Finset.range n, (f j - f (j + 1))) = f 0 - f n := by
    intro n
    induction n with
    | zero => simp
    | succ n ih =>
      rw [Finset.sum_range_succ, ih]
      ring
  rw [Finset.sum_Ico_eq_sub _ hab]
  rw [hrange b, hrange a]
  ring
/-
  rw [Finset.sum_Ico_eq_sub _ hab]
  rw [Finset.sum_range_sub, Finset.sum_range_sub]
  simp [Nat.succ_eq_add_one] -/

theorem shifted_difference_telescopes (f : Nat → ℝ) (a b : Nat)
    (ha : 1 ≤ a) (hab : a ≤ b) :
    (∑ j ∈ Finset.Ico a b, (f (j - 1) - f j)) = f (a - 1) - f (b - 1) := by
  have h := finite_difference_telescopes (fun k => f (k - 1)) a b hab
  calc
    (∑ j ∈ Finset.Ico a b, (f (j - 1) - f j)) =
        ∑ j ∈ Finset.Ico a b,
          ((fun k => f (k - 1)) j - (fun k => f (k - 1)) (j + 1)) := by
            apply Finset.sum_congr rfl
            intro j hj
            have hj' : a ≤ j := (Finset.mem_Ico.mp hj).1
            have hj1 : 1 ≤ j := le_trans ha hj'
            simp
    _ = (fun k => f (k - 1)) a - (fun k => f (k - 1)) b := h
    _ = f (a - 1) - f (b - 1) := rfl

theorem psi2_partial_increment_sum (X : Nat) (hX : 6 ≤ X) :
    (∑ j ∈ Finset.Ico 4 (X - 1),
      (psi2_SR_partial X (j - 1) - psi2_SR_partial X j)) =
      psi2_SR_partial X 3 - psi2_SR_partial X (X - 2) := by
  apply shifted_difference_telescopes
  · omega
  · omega

theorem psi2_SR_partial_three_zero (X : Nat) :
    psi2_SR_partial X 3 = 0 := by
  unfold psi2_SR_partial
  apply Finset.sum_eq_zero
  intro m hm
  apply Finset.sum_eq_zero
  intro n hn
  have hm' := sr_complete_support_pos hm
  have hn' := sr_complete_support_pos hn
  have hm2 := (completeSupport_mem_bounds (List.mem_toFinset.mp hm)).1
  have hn2 := (completeSupport_mem_bounds (List.mem_toFinset.mp hn)).1
  have hmn : ¬ m * n ≤ 3 := by nlinarith
  simp [hmn]

theorem abel_summation_range_positive (f g : Nat → ℝ) (N : Nat) :
    (∑ n ∈ Finset.range N, f n * g n) =
      g (N - 1) * (∑ k ∈ Finset.range N, f k) +
        ∑ n ∈ Finset.range (N - 1),
          (g n - g (n + 1)) * (∑ k ∈ Finset.range (n + 1), f k) := by
  rw [abel_summation_finset_verified]
  rw [sub_eq_add_neg, ← Finset.sum_neg_distrib]
  congr 1
  apply Finset.sum_congr rfl
  intro n hn
  ring

def interior_product_fin_index {X m n : Nat} (h : m * n < X) :
    Fin X := ⟨m * n, h⟩

theorem interior_product_mem_range {X m n : Nat} (h : m * n < X) :
    m * n ∈ Finset.range X := by
  simpa using h

theorem pair_support_sum_eq_nested (s : Finset Nat) (F : Nat → Nat → ℝ) :
    (s.product s).sum (fun p => F p.1 p.2) =
      ∑ m ∈ s, ∑ n ∈ s, F m n := by
  exact Finset.sum_product s s (fun p => F p.1 p.2)

def pair_product_fin_index {X m n : Nat} (hm0 : 0 < m)
    (hm : m < X) (hn : n < X) :
    Fin (X * X) :=
  ⟨m * n, by
    calc
      m * n < m * X := Nat.mul_lt_mul_of_pos_left hn hm0
      _ ≤ X * X := Nat.mul_le_mul_right X (Nat.le_of_lt hm)⟩

theorem pair_product_fin_index_val {X m n : Nat} (hm0 : 0 < m)
    (hm : m < X) (hn : n < X) :
    (pair_product_fin_index hm0 hm hn).val = m * n := by
  rfl

def complete_pair_product_index (X : Nat)
    (p : Nat × Nat)
    (hp : p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset) :
    Fin (X * X) :=
  pair_product_fin_index
    (sr_complete_support_pos (Finset.mem_product.mp hp).1)
    (completeSupport_mem_bounds (List.mem_toFinset.mp
      (Finset.mem_product.mp hp).1)).2
    (completeSupport_mem_bounds (List.mem_toFinset.mp
      (Finset.mem_product.mp hp).2)).2

theorem complete_pair_product_index_val (X : Nat) (p : Nat × Nat)
    (hp : p ∈ (completeSupport X).toFinset.product (completeSupport X).toFinset) :
    (complete_pair_product_index X p hp).val = p.1 * p.2 := by
  rfl

def interior_pair_support (X : Nat) : Finset (Nat × Nat) :=
  (completeSupport X).toFinset.product (completeSupport X).toFinset |>.filter
    (fun p => p.1 * p.2 < X)

def interior_pair_index (X : Nat) (p : Nat × Nat) : Fin (X * X + 1) :=
  if h : p.1 * p.2 < X then
    ⟨p.1 * p.2, by
      calc
        p.1 * p.2 < X := h
        _ ≤ X * X + 1 := by
          have hXpos : 0 < X := lt_of_le_of_lt (Nat.zero_le _) h
          nlinarith⟩
  else ⟨0, by omega⟩

theorem interior_pair_index_val (X : Nat) (p : Nat × Nat)
    (hp : p ∈ interior_pair_support X) :
    (interior_pair_index X p).val = p.1 * p.2 := by
  have hprod : p.1 * p.2 < X := (Finset.mem_filter.mp hp).2
  simp [interior_pair_index, hprod]

theorem pair_sum_fiberwise_indexed {ι : Type} {K : Type} [Fintype K]
    [DecidableEq K] (s : Finset ι) (idx : ι → K) (F : ι → ℝ) :
    (∑ j, ∑ p ∈ s with idx p = j, F p) = ∑ p ∈ s, F p := by
  simpa using Finset.sum_fiberwise s idx F

def pair_fiber_sum {ι : Type} {K : Type} [Fintype K]
    [DecidableEq K] (s : Finset ι) (idx : ι → K) (F : ι → ℝ) (j : K) : ℝ :=
  ∑ p ∈ s with idx p = j, F p

theorem pair_fiber_sum_total {ι : Type} {K : Type} [Fintype K]
    [DecidableEq K] (s : Finset ι) (idx : ι → K) (F : ι → ℝ) :
    (∑ j, pair_fiber_sum s idx F j) = ∑ p ∈ s, F p := by
  exact pair_sum_fiberwise_indexed s idx F

/- theorem weighted_pair_fiber_sum {ι : Type} {K : Type} [Fintype K]
    [DecidableEq K] (s : Finset ι) (idx : ι → K)
    (w : K → ℝ) (F : ι → ℝ) :
    (∑ j, w j * pair_fiber_sum s idx F j) =
      ∑ p ∈ s, w (idx p) * F p := by
  classical
  simp only [pair_fiber_sum]
  rw [← Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro j hj
  rw [← Finset.sum_mul]
  ring_nf -/

theorem sum_indicator_eq_filter {ι : Type} (s : Finset ι)
    (P : ι → Prop) [DecidablePred P] (F : ι → ℝ) :
    (∑ x ∈ s, if P x then F x else 0) = ∑ x ∈ s.filter P, F x := by
  symm
  simpa using (Finset.sum_filter (s := s) (f := F) P)

theorem sum_indicator_difference {ι : Type} (s : Finset ι)
    (A B : ι → Prop) [DecidablePred A] [DecidablePred B]
    (hBA : ∀ x, B x → A x) (F : ι → ℝ) :
    (∑ x ∈ s, if A x then F x else 0) -
      (∑ x ∈ s, if B x then F x else 0) =
      ∑ x ∈ s, if A x ∧ ¬ B x then F x else 0 := by
  rw [← Finset.sum_sub_distrib]
  apply Finset.sum_congr rfl
  intro x hx
  by_cases ha : A x
  · by_cases hb : B x
    · simp [ha, hb]
    · simp [ha, hb]
  · by_cases hb : B x
    · exfalso
      exact ha (hBA x hb)
    · simp [ha, hb]

theorem nat_le_indicator_difference {a j : Nat} (ha0 : 1 ≤ a) (h : a ≤ j) :
    (if a ≤ j then (1 : ℝ) else 0) -
      (if a ≤ j - 1 then (1 : ℝ) else 0) =
      if a = j then 1 else 0 := by
  by_cases he : a = j
  · subst j
    have ha : 0 < a := lt_of_lt_of_le Nat.zero_lt_one ha0
    simp [ha]
  · have hlt : a ≤ j - 1 := by omega
    simp [h, hlt, he]

theorem pair_product_filter_increment (s : Finset (Nat × Nat)) (j : Nat)
    (hj : 1 ≤ j)
    (F : Nat × Nat → ℝ) :
    (∑ p ∈ s, if p.1 * p.2 ≤ j then F p else 0) -
      (∑ p ∈ s, if p.1 * p.2 ≤ j - 1 then F p else 0) =
      ∑ p ∈ s, if p.1 * p.2 = j then F p else 0 := by
  rw [sum_indicator_difference s (fun p => p.1 * p.2 ≤ j)
    (fun p => p.1 * p.2 ≤ j - 1) (by intro p hp; omega) F]
  apply Finset.sum_congr rfl
  intro p hp
  by_cases hle : p.1 * p.2 ≤ j
  · by_cases heq : p.1 * p.2 = j
    · have hj0 : j ≠ 0 := by omega
      simp [heq, hj0]
    · have hlt : p.1 * p.2 ≤ j - 1 := by omega
      simp [hle, hlt, heq]
  · simp [hle]
    intro heq
    omega

def pair_partial_sum {ι : Type} (s : Finset ι) (P : ι → Nat → Prop)
    [∀ x j, Decidable (P x j)]
    (F : ι → ℝ) (j : Nat) : ℝ :=
  ∑ x ∈ s, if P x j then F x else 0

def pair_product_coeff (s : Finset (Nat × Nat)) (F : Nat × Nat → ℝ)
    (j : Nat) : ℝ :=
  ∑ p ∈ s, if p.1 * p.2 = j then F p else 0

theorem pair_partial_product_diff (s : Finset (Nat × Nat))
    (F : Nat × Nat → ℝ) (j : Nat) (hj : 1 ≤ j) :
    (∑ p ∈ s, if p.1 * p.2 ≤ j then F p else 0) -
      (∑ p ∈ s, if p.1 * p.2 ≤ j - 1 then F p else 0) =
      pair_product_coeff s F j := by
  exact pair_product_filter_increment s j hj F

theorem psi2_SR_partial_pair_sum (X j : Nat) :
    psi2_SR_partial X j =
      ((completeSupport X).toFinset.product (completeSupport X).toFinset).sum
        (fun p => if p.1 * p.2 ≤ j then
          Real.log (p.1 : ℝ) * Real.log (p.2 : ℝ) else 0) := by
  unfold psi2_SR_partial
  symm
  simpa using pair_support_sum_eq_nested (completeSupport X).toFinset
    (fun m n => if m * n ≤ j then Real.log (m : ℝ) * Real.log (n : ℝ) else 0)

theorem psi2_SR_partial_increment (X j : Nat) (hj : 1 ≤ j) :
    psi2_SR_partial X j - psi2_SR_partial X (j - 1) =
      pair_product_coeff ((completeSupport X).toFinset.product
        (completeSupport X).toFinset)
        (fun p => Real.log (p.1 : ℝ) * Real.log (p.2 : ℝ)) j := by
  rw [psi2_SR_partial_pair_sum, psi2_SR_partial_pair_sum]
  rw [pair_product_filter_increment _ j hj]
  rfl

theorem reciprocal_sqrt_eq_of_product_eq {m n j : Nat} (h : m * n = j) :
    (Real.sqrt ((m * n : Nat) : ℝ))⁻¹ =
      (Real.sqrt (j : ℝ))⁻¹ := by
  rw [h]

/- theorem Sint_log_lower_bound (X : Nat) (hX : 6 ≤ X) :
    psi2_SR_28 X / Real.sqrt (X - 1 : ℝ) ≤ SR_Sint_log X := by
  classical
  unfold psi2_SR_28 SR_Sint_log
  apply Finset.sum_le_sum
  intro m hm
  apply Finset.sum_le_sum
  intro n hn
  by_cases h : m * n < X
  · have hmn : m * n ≤ X - 1 := by omega
    have hs : Real.sqrt ((m * n : Nat) : ℝ) ≤ Real.sqrt ((X - 1 : Nat) : ℝ) := by
      apply Real.sqrt_le_sqrt
      exact_mod_cast hmn
    have hlog : 0 ≤ Real.log (m : ℝ) * Real.log (n : ℝ) := by
      have hm' := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      have hn' := completeSupport_mem_bounds (List.mem_toFinset.mp hn)
      exact mul_nonneg (Real.log_nonneg (by exact_mod_cast hm'.1))
        (Real.log_nonneg (by exact_mod_cast hn'.1))
    have hi := one_div_le_one_div_of_le (Real.sqrt_nonneg _) hs
    have hh := mul_le_mul_of_nonneg_left hi hlog
    simpa [h, div_eq_mul_inv, mul_comm, mul_left_comm, mul_assoc] using hh
  · simp [h] -/

end SR
