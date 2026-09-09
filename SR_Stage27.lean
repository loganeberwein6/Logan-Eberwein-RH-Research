import SR_Bridge
import SR_WEntropy
import Mathlib.Data.Real.Basic

namespace SR

/-! Stage 27: the consistent logarithmic kappa normalization.

The denominator uses the same typed logarithmic sums as the Cauchy theorem.
The available Cauchy estimate controls `SR_Sint_log`, not the signed
half-weighted sum, so the upper bound is stated with its exact missing
comparison as a hypothesis below. -/

noncomputable def SR_kappa_log (X : Nat) : ℝ :=
  if 0 < SR_S2_log_typed X * SR_S3_log_typed X then
    SR_HalfWeightedSum X ^ 2 /
      (SR_S2_log_typed X * SR_S3_log_typed X)
  else 0

theorem SR_kappa_log_nonneg (X : Nat) : 0 ≤ SR_kappa_log X := by
  unfold SR_kappa_log
  split_ifs with h
  · positivity
  · norm_num

theorem list_abs_sum_le_sum_abs (l : List ℝ) :
    |l.sum| ≤ (l.map (fun x => |x|)).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
      calc
        |a + l.sum| ≤ |a| + |l.sum| := abs_add_le _ _
        _ ≤ |a| + (l.map (fun x => |x|)).sum :=
          by simpa [add_comm] using add_le_add_left ih |a|
        _ = ((a :: l).map (fun x => |x|)).sum := by
          simp [List.sum_cons]

theorem list_sum_map_add (l : List ℕ) (f g : ℕ → ℝ) :
    (l.map f).sum + (l.map g).sum = (l.map (fun x => f x + g x)).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
      simp only [List.map_cons, List.sum_cons]
      calc
        f a + (List.map f l).sum + (g a + (List.map g l).sum) =
            f a + g a + ((List.map f l).sum + (List.map g l).sum) := by ring
        _ = f a + g a + (List.map (fun x => f x + g x) l).sum := by rw [ih]

theorem sr_rees_abs_weight (X m n : Nat)
    (hm : 1 ≤ m) (hn : 1 ≤ n) :
    |((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log (m : ℝ) *
      Real.log (n : ℝ) * (Real.sqrt (m * n))⁻¹| =
      Real.log (m : ℝ) * Real.log (n : ℝ) *
        (Real.sqrt (m * n))⁻¹ := by
  have hlogm : 0 ≤ Real.log (m : ℝ) :=
    Real.log_nonneg (by exact_mod_cast hm)
  have hlogn : 0 ≤ Real.log (n : ℝ) :=
    Real.log_nonneg (by exact_mod_cast hn)
  have hsqrt : 0 ≤ (Real.sqrt (m * n : ℝ))⁻¹ :=
    inv_nonneg.mpr (Real.sqrt_nonneg _)
  have hsm : 0 ≤ Real.sqrt (m : ℝ) := Real.sqrt_nonneg _
  have hsn : 0 ≤ Real.sqrt (n : ℝ) := Real.sqrt_nonneg _
  rcases reesEntry_neg_or_pos X m n with hneg | hpos
  · simp [hneg, abs_mul, abs_of_nonneg hlogm, abs_of_nonneg hlogn,
      abs_of_nonneg hsqrt, abs_of_nonneg hsm, abs_of_nonneg hsn]
  · simp [hpos, abs_mul, abs_of_nonneg hlogm, abs_of_nonneg hlogn,
      abs_of_nonneg hsqrt, abs_of_nonneg hsm, abs_of_nonneg hsn]

theorem sr_sqrt_prod_eq (m n : Nat) :
    Real.sqrt ((m : ℝ) * (n : ℝ)) =
      Real.sqrt ((m * n : Nat) : ℝ) := by
  push_cast
  rfl

theorem sr_weight_norm (m n : Nat) (hm : 0 < m) (hn : 0 < n) :
    Real.log (m : ℝ) * Real.log (n : ℝ) /
        Real.sqrt ((m * n : Nat) : ℝ) =
      Real.log (m : ℝ) * Real.log (n : ℝ) /
        (Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ)) := by
  have hs : Real.sqrt ((m * n : Nat) : ℝ) =
      Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ) := by
    rw [← sr_sqrt_prod_eq m n, Real.sqrt_mul (by positivity)]
  rw [hs]

theorem sr_halfweighted_finset (X : Nat) (hX : 6 ≤ X) :
    SR_HalfWeightedSum X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
            (Real.sqrt (m * n))⁻¹ := by
  unfold SR_HalfWeightedSum
  exact list_finset_double_sum_bridge X hX _

theorem sr_ext_finset (X : Nat) (hX : 6 ≤ X) :
    SR_Sext_log X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          if m * n < X then 0 else
            Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹ := by
  unfold SR_Sext_log
  exact list_finset_double_sum_bridge X hX _

theorem sr_int_finset (X : Nat) (hX : 6 ≤ X) :
    SR_Sint_log X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          if m * n < X then
            Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹ else 0 := by
  unfold SR_Sint_log
  exact list_finset_double_sum_bridge X hX _

theorem SR_halfweighted_le_unsigned (X : Nat) (hX : 6 ≤ X) :
    |SR_HalfWeightedSum X| ≤ SR_S_unsigned_log X := by
  let s : Finset Nat := (completeSupport X).toFinset
  have hmem : ∀ m ∈ s, 1 ≤ m := by
    intro m hm
    have hm' := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
    omega
  rw [sr_halfweighted_finset X hX]
  calc
    |∑ m ∈ s, ∑ n ∈ s,
        ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
          (Real.sqrt (m * n))⁻¹|
        ≤ ∑ m ∈ s, |∑ n ∈ s,
          ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
            (Real.sqrt (m * n))⁻¹| := by
      simpa using
        (Finset.abs_sum_le_sum_abs
          (fun m : Nat => ∑ n ∈ s,
            ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
              (Real.sqrt (m * n))⁻¹) s)
    _ ≤ ∑ m ∈ s, ∑ n ∈ s,
        |((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
          (Real.sqrt (m * n))⁻¹| := by
      apply Finset.sum_le_sum
      intro m hm
      simpa using
        (Finset.abs_sum_le_sum_abs
          (fun n : Nat =>
            ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
              (Real.sqrt (m * n))⁻¹) s)
    _ = ∑ m ∈ s, ∑ n ∈ s,
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹ := by
      apply Finset.sum_congr rfl
      intro m hm
      apply Finset.sum_congr rfl
      intro n hn
      exact sr_rees_abs_weight X m n (hmem m hm) (hmem n hn)
    _ = SR_S_unsigned_log X := by
      have hU : SR_S_unsigned_log X = SR_Sext_log X + SR_Sint_log X := by
        rfl
      rw [hU, sr_ext_finset X hX, sr_int_finset X hX]
      simp only [s]
      rw [← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl
      intro m hm
      rw [← Finset.sum_add_distrib]
      apply Finset.sum_congr rfl
      intro n hn
      by_cases h : m * n < X <;> simp [h]

theorem sr_S3_typed_finset (X : Nat) (hX : 6 ≤ X) :
    SR_S3_log_typed X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          Real.log (m : ℝ) * Real.log (n : ℝ) := by
  unfold SR_S3_log_typed
  exact list_finset_double_sum_bridge X hX
    (fun m n => Real.log (m : ℝ) * Real.log (n : ℝ))

theorem sr_S2_typed_finset (X : Nat) (hX : 6 ≤ X) :
    SR_S2_log_typed X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          Real.log (m : ℝ) * Real.log (n : ℝ) /
            ((m : ℝ) * (n : ℝ)) := by
  unfold SR_S2_log_typed
  exact list_finset_double_sum_bridge X hX
    (fun m n => Real.log (m : ℝ) * Real.log (n : ℝ) /
      ((m : ℝ) * (n : ℝ)))

theorem sr_finset_double_sum_mul (s : Finset Nat) (f g : Nat → ℝ) :
    (∑ m ∈ s, ∑ n ∈ s, f m * g n) =
      (∑ m ∈ s, f m) * (∑ n ∈ s, g n) := by
  rw [Finset.sum_mul_sum]

theorem sr_complete_support_pos {X m : Nat}
    (hm : m ∈ (completeSupport X).toFinset) : 0 < m := by
  exact Nat.lt_of_lt_of_le Nat.zero_lt_two
    (completeSupport_mem_bounds (List.mem_toFinset.mp hm)).1

theorem sr_weight_double_factor (s : Finset Nat)
    (hpos : ∀ m ∈ s, 0 < m) :
    (∑ m ∈ s, ∑ n ∈ s,
      Real.log (m : ℝ) * Real.log (n : ℝ) /
        Real.sqrt ((m * n : Nat) : ℝ)) =
      (∑ m ∈ s, Real.log (m : ℝ) / Real.sqrt (m : ℝ)) ^ 2 := by
  calc
    _ = ∑ m ∈ s, ∑ n ∈ s,
        (Real.log (m : ℝ) / Real.sqrt (m : ℝ)) *
          (Real.log (n : ℝ) / Real.sqrt (n : ℝ)) := by
      apply Finset.sum_congr rfl
      intro m hm
      apply Finset.sum_congr rfl
      intro n hn
      have hm' : 0 < (m : ℝ) := by exact_mod_cast hpos m hm
      have hn' : 0 < (n : ℝ) := by exact_mod_cast hpos n hn
      rw [sr_weight_norm m n (hpos m hm) (hpos n hn)]
      ring
    _ = (∑ m ∈ s, Real.log (m : ℝ) / Real.sqrt (m : ℝ)) *
        (∑ n ∈ s, Real.log (n : ℝ) / Real.sqrt (n : ℝ)) :=
      sr_finset_double_sum_mul s
        (fun m => Real.log (m : ℝ) / Real.sqrt (m : ℝ))
        (fun n => Real.log (n : ℝ) / Real.sqrt (n : ℝ))
    _ = _ := by ring

theorem sr_S3_square_active (X : Nat) (hX : 6 ≤ X) :
    SR_S3_log_typed X =
      (∑ m ∈ (completeSupport X).toFinset, Real.log (m : ℝ)) ^ 2 := by
  unfold SR_S3_log_typed
  rw [list_finset_double_sum_bridge X hX]
  rw [sr_finset_double_sum_mul]
  ring

theorem sr_S2_square_active (X : Nat) (hX : 6 ≤ X) :
    SR_S2_log_typed X =
      (∑ m ∈ (completeSupport X).toFinset,
        Real.log (m : ℝ) / (m : ℝ)) ^ 2 := by
  unfold SR_S2_log_typed
  rw [list_finset_double_sum_bridge X hX]
  have h := sr_finset_double_sum_mul (completeSupport X).toFinset
    (fun m => Real.log (m : ℝ) / (m : ℝ))
    (fun n => Real.log (n : ℝ) / (n : ℝ))
  calc
    _ = ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          (Real.log (m : ℝ) / (m : ℝ)) *
            (Real.log (n : ℝ) / (n : ℝ)) := by
      apply Finset.sum_congr rfl
      intro m hm
      apply Finset.sum_congr rfl
      intro n hn
      field_simp
    _ = _ := by simpa [pow_two] using h

theorem sr_unsigned_finset_active (X : Nat) (hX : 6 ≤ X) :
    SR_S_unsigned_log X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          Real.log (m : ℝ) * Real.log (n : ℝ) /
            Real.sqrt ((m * n : Nat) : ℝ) := by
  rw [show SR_S_unsigned_log X = SR_Sext_log X + SR_Sint_log X by rfl,
    sr_ext_finset X hX, sr_int_finset X hX]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hm' := sr_complete_support_pos hm
  have hn' := sr_complete_support_pos hn
  have hmpos : 0 < (m : ℝ) := by exact_mod_cast hm'
  have hnpos : 0 < (n : ℝ) := by exact_mod_cast hn'
  have hden : 0 < Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ) :=
    mul_pos (Real.sqrt_pos.2 hmpos) (Real.sqrt_pos.2 hnpos)
  by_cases h : m * n < X <;> simp [h]
  all_goals
    field_simp [ne_of_gt hden]

theorem SR_cauchy_unsigned (X : Nat) (hX : 6 ≤ X) :
    SR_S_unsigned_log X ^ 2 ≤
      SR_S3_log_typed X * SR_S2_log_typed X := by
  let s := (completeSupport X).toFinset
  let A : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / Real.sqrt (m : ℝ)
  let L : ℝ := ∑ m ∈ s, Real.log (m : ℝ)
  let B : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / (m : ℝ)
  rw [sr_unsigned_finset_active X hX]
  rw [sr_weight_double_factor s (fun m hm => sr_complete_support_pos hm)]
  change (A ^ 2) ^ 2 ≤ SR_S3_log_typed X * SR_S2_log_typed X
  rw [sr_S3_square_active X hX, sr_S2_square_active X hX]
  have hc := Finset.sum_sq_le_sum_mul_sum_of_sq_eq_mul (R := ℝ) s
    (r := fun m => Real.log (m : ℝ) / Real.sqrt (m : ℝ))
    (f := fun m => Real.log (m : ℝ))
    (g := fun m => Real.log (m : ℝ) / (m : ℝ))
    (fun m hm => Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega))
    (fun m hm => by positivity)
    (by
      intro m hm
      have hmpos : 0 < (m : ℝ) := by exact_mod_cast (sr_complete_support_pos hm)
      rw [div_pow, Real.sq_sqrt (le_of_lt hmpos)]
      field_simp)
  have hc' : A ^ 2 ≤ L * B := by simpa [A, L, B] using hc
  have hL : 0 ≤ L := by
    apply Finset.sum_nonneg
    intro m hm
    exact Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)
  have hB : 0 ≤ B := by
    apply Finset.sum_nonneg
    intro m hm
    exact div_nonneg (Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)) (by positivity)
  nlinarith [sq_nonneg (A ^ 2), sq_nonneg (L * B)]

theorem SR_kappa_log_in_01 (X : Nat) (hX : 6 ≤ X) :
    0 ≤ SR_kappa_log X ∧ SR_kappa_log X ≤ 1 := by
  refine ⟨SR_kappa_log_nonneg X, ?_⟩
  unfold SR_kappa_log
  split_ifs with h
  · rw [div_le_one h]
    calc
      SR_HalfWeightedSum X ^ 2 ≤ |SR_HalfWeightedSum X| ^ 2 := by
        rw [sq_abs]
      _ ≤ SR_S_unsigned_log X ^ 2 := by
        apply sq_le_sq'
        · linarith [abs_nonneg (SR_HalfWeightedSum X),
            SR_halfweighted_le_unsigned X hX]
        · exact SR_halfweighted_le_unsigned X hX
      _ ≤ SR_S2_log_typed X * SR_S3_log_typed X := by
        simpa [mul_comm] using SR_cauchy_unsigned X hX
  · linarith

theorem B3_final
    (T I S c D : ℝ)
    (hT : 0 < T) (hc : 0 < c) (hc1 : c < 1)
    (hI : 0 ≤ I) (hS : 0 ≤ S)
    (hdecomp : S = T - 2 * I)
    (hD : 0 < D) (hden : T ^ 2 ≤ D)
    (hkappa : c ≤ S ^ 2 / D) :
    I / T ≤ (1 - Real.sqrt c) / 2 := by
  have hsq : c * T ^ 2 ≤ S ^ 2 := by
    have hmul : c * D ≤ S ^ 2 := by
      apply (le_div_iff₀ hD).mp
      exact hkappa
    have hDnonneg : 0 ≤ D := le_trans (sq_nonneg T) hden
    nlinarith [mul_nonneg (le_of_lt hc) hDnonneg]
  exact b3_ratio_bound_algebra T I S c hT hc hc1 hI hS hdecomp hsq

/- theorem sr_unsigned_finset_v2 (X : Nat) (hX : 6 ≤ X) :
    SR_S_unsigned_log X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          Real.log (m : ℝ) * Real.log (n : ℝ) /
            Real.sqrt ((m * n : Nat) : ℝ) := by
  rw [show SR_S_unsigned_log X = SR_Sext_log X + SR_Sint_log X by rfl,
    sr_ext_finset X hX, sr_int_finset X hX]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hm' := sr_complete_support_pos hm
  have hn' := sr_complete_support_pos hn
  have hnorm := sr_weight_norm m n hm' hn'
  have hmpos : 0 < (m : ℝ) := by exact_mod_cast hm'
  have hnpos : 0 < (n : ℝ) := by exact_mod_cast hn'
  have hden : 0 < Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ) :=
    mul_pos (Real.sqrt_pos.2 hmpos) (Real.sqrt_pos.2 hnpos)
  by_cases h : m * n < X
  · simp [h, div_eq_mul_inv, hnorm]
  · simp [h, div_eq_mul_inv, hnorm]
    

theorem SR_cauchy_unsigned_v3 (X : Nat) (hX : 6 ≤ X) :
    SR_S_unsigned_log X ^ 2 ≤
      SR_S3_log_typed X * SR_S2_log_typed X := by
  let s := (completeSupport X).toFinset
  let A : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / Real.sqrt (m : ℝ)
  let L : ℝ := ∑ m ∈ s, Real.log (m : ℝ)
  let B : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / (m : ℝ)
  rw [sr_unsigned_finset_v2 X hX]
  rw [sr_weight_double_factor s (fun m hm => sr_complete_support_pos hm)]
  change (A ^ 2) ^ 2 ≤ SR_S3_log_typed X * SR_S2_log_typed X
  rw [sr_S3_typed_square X hX, sr_S2_typed_square X hX]
  have hc := Finset.sum_sq_le_sum_mul_sum_of_sq_eq_mul (R := ℝ) s
    (r := fun m => Real.log (m : ℝ) / Real.sqrt (m : ℝ))
    (f := fun m => Real.log (m : ℝ))
    (g := fun m => Real.log (m : ℝ) / (m : ℝ))
    (fun m hm => Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega))
    (fun m hm => by positivity)
    (by
      intro m hm
      have hmpos : 0 < (m : ℝ) := by
        exact_mod_cast (sr_complete_support_pos hm)
      rw [div_pow, Real.sq_sqrt (le_of_lt hmpos)]
      field_simp)
  have hc' : A ^ 2 ≤ L * B := by simpa [A, L, B] using hc
  have hL : 0 ≤ L := by
    apply Finset.sum_nonneg
    intro m hm
    exact Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)
  have hB : 0 ≤ B := by
    apply Finset.sum_nonneg
    intro m hm
    exact div_nonneg (Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)) (by positivity)
  nlinarith [sq_nonneg (A ^ 2), sq_nonneg (L * B)]

theorem sr_S3_typed_square (X : Nat) (hX : 6 ≤ X) :
    SR_S3_log_typed X =
      (∑ m ∈ (completeSupport X).toFinset, Real.log (m : ℝ)) ^ 2 := by
  rw [sr_S3_typed_finset X hX]
  rw [sr_finset_double_sum_mul]
  ring

theorem sr_S2_typed_square (X : Nat) (hX : 6 ≤ X) :
    SR_S2_log_typed X =
      (∑ m ∈ (completeSupport X).toFinset,
        Real.log (m : ℝ) / (m : ℝ)) ^ 2 := by
  rw [sr_S2_typed_finset X hX]
  have h := sr_finset_double_sum_mul (completeSupport X).toFinset
    (fun m => Real.log (m : ℝ) / (m : ℝ))
    (fun n => Real.log (n : ℝ) / (n : ℝ))
  calc
    _ = ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          (Real.log (m : ℝ) / (m : ℝ)) *
            (Real.log (n : ℝ) / (n : ℝ)) := by
      apply Finset.sum_congr rfl
      intro m hm
      apply Finset.sum_congr rfl
      intro n hn
      field_simp
    _ = _ := by simpa [pow_two] using h

/- theorem sr_unsigned_finset (X : Nat) (hX : 6 ≤ X) :
    SR_S_unsigned_log X =
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          Real.log (m : ℝ) * Real.log (n : ℝ) /
            Real.sqrt ((m * n : Nat) : ℝ) := by
  rw [show SR_S_unsigned_log X = SR_Sext_log X + SR_Sint_log X by rfl,
    sr_ext_finset X hX, sr_int_finset X hX]
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro m hm
  rw [← Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  have hmpos : 0 < (m : ℝ) := by
    exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one
      (completeSupport_mem_bounds (List.mem_toFinset.mp hm)).1)
  have hnpos : 0 < (n : ℝ) := by
    exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one
      (completeSupport_mem_bounds (List.mem_toFinset.mp hn)).1)
  have hnorm := sr_weight_norm m n hmpos hnpos
  by_cases h : m * n < X <;> simp [h, hnorm]

 -/
/- theorem SR_cauchy_unsigned_v2 (X : Nat) (hX : 6 ≤ X) :
    SR_S_unsigned_log X ^ 2 ≤
      SR_S3_log_typed X * SR_S2_log_typed X := by
  let s := (completeSupport X).toFinset
  let A : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / Real.sqrt (m : ℝ)
  let L : ℝ := ∑ m ∈ s, Real.log (m : ℝ)
  let B : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / (m : ℝ)
  rw [sr_unsigned_finset X hX]
  have hfactor :
      (∑ m ∈ s, ∑ n ∈ s,
        Real.log (m : ℝ) * Real.log (n : ℝ) /
          Real.sqrt ((m * n : Nat) : ℝ)) = A ^ 2 := by
    calc
      _ = ∑ m ∈ s, ∑ n ∈ s,
          (Real.log (m : ℝ) / Real.sqrt (m : ℝ)) *
            (Real.log (n : ℝ) / Real.sqrt (n : ℝ)) := by
        apply Finset.sum_congr rfl
        intro m hm
        apply Finset.sum_congr rfl
        intro n hn
        have hmpos : 0 < (m : ℝ) := by
          exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one
            (completeSupport_mem_bounds (List.mem_toFinset.mp hm)).1)
        have hnpos : 0 < (n : ℝ) := by
          exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one
            (completeSupport_mem_bounds (List.mem_toFinset.mp hn)).1)
        rw [sr_weight_norm m n hmpos hnpos]
        ring
      _ = A ^ 2 := by
        rw [sr_finset_double_sum_mul]
        rfl
  rw [hfactor, sr_S3_typed_square X hX, sr_S2_typed_square X hX]
  have hc := Finset.sum_sq_le_sum_mul_sum_of_sq_eq_mul (R := ℝ) s
    (r := fun m => Real.log (m : ℝ) / Real.sqrt (m : ℝ))
    (f := fun m => Real.log (m : ℝ))
    (g := fun m => Real.log (m : ℝ) / (m : ℝ))
    (fun m hm => Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega))
    (fun m hm => by positivity)
    (by
      intro m hm
      have hmpos : 0 < (m : ℝ) := by
        exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one
          (completeSupport_mem_bounds (List.mem_toFinset.mp hm)).1)
      rw [div_pow, Real.sq_sqrt (le_of_lt hmpos)]
      field_simp)
  have hc' : A ^ 2 ≤ L * B := by simpa [A, L, B] using hc
  have hL : 0 ≤ L := by
    apply Finset.sum_nonneg
    intro m hm
    exact Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)
  have hB : 0 ≤ B := by
    apply Finset.sum_nonneg
    intro m hm
    exact div_nonneg (Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)) (by positivity)
  nlinarith [sq_nonneg (A ^ 2), sq_nonneg (L * B)]

 -/
/- theorem SR_cauchy_unsigned (X : Nat) (hX : 6 ≤ X) :
    SR_S_unsigned_log X ^ 2 ≤
      SR_S3_log_typed X * SR_S2_log_typed X := by
  let s := (completeSupport X).toFinset
  have hmem : ∀ m ∈ s, 1 ≤ m := by
    intro m hm
    exact le_trans (by omega) (completeSupport_mem_bounds (List.mem_toFinset.mp hm)).1
  have hsum : SR_S_unsigned_log X =
      ∑ m ∈ s, ∑ n ∈ s,
        Real.log (m : ℝ) * Real.log (n : ℝ) /
          Real.sqrt ((m * n : Nat) : ℝ) := by
    rw [show SR_S_unsigned_log X = SR_Sext_log X + SR_Sint_log X by rfl,
      sr_ext_finset X hX, sr_int_finset X hX]
    simp only [s]
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro m hm
    rw [← Finset.sum_add_distrib]
    apply Finset.sum_congr rfl
    intro n hn
    have hmpos : 0 < (m : ℝ) := by
      exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one (hmem m hm))
    have hnpos : 0 < (n : ℝ) := by
      exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one (hmem n hn))
    have hnorm :
        Real.log (m : ℝ) * Real.log (n : ℝ) *
            ((Real.sqrt (n : ℝ))⁻¹ * (Real.sqrt (m : ℝ))⁻¹) =
          Real.log (m : ℝ) * Real.log (n : ℝ) /
            (Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ)) := by
      have hmnpos : 0 < (Real.sqrt (m : ℝ) * Real.sqrt (n : ℝ)) :=
        mul_pos (Real.sqrt_pos.2 hmpos) (Real.sqrt_pos.2 hnpos)
      field_simp [ne_of_gt hmnpos]
    by_cases h : m * n < X <;> simp [h, hnorm]
  rw [hsum]
  let p : Finset (Nat × Nat) := s.product s
  have hprod :
      (∑ m ∈ s, ∑ n ∈ s,
        Real.log (m : ℝ) * Real.log (n : ℝ) /
          Real.sqrt ((m * n : Nat) : ℝ)) =
        ∑ z ∈ p, Real.log (z.1 : ℝ) * Real.log (z.2 : ℝ) /
          Real.sqrt ((z.1 * z.2 : Nat) : ℝ) := by
    simp [p, Finset.sum_product]
  rw [hprod]
  let A : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / Real.sqrt (m : ℝ)
  let L : ℝ := ∑ m ∈ s, Real.log (m : ℝ)
  let B : ℝ := ∑ m ∈ s, Real.log (m : ℝ) / (m : ℝ)
  have hfactor :
      (∑ z ∈ p, Real.log (z.1 : ℝ) * Real.log (z.2 : ℝ) /
        Real.sqrt ((z.1 * z.2 : Nat) : ℝ)) = A ^ 2 := by
    simp only [p, Finset.sum_product]
    apply Finset.sum_congr rfl
    intro m hm
    apply Finset.sum_congr rfl
    intro n hn
    have hmpos : 0 < m := lt_of_lt_of_le Nat.zero_lt_one (hmem m hm)
    have hnpos : 0 < n := lt_of_lt_of_le Nat.zero_lt_one (hmem n hn)
    rw [sr_weight_norm m n hmpos hnpos]
    ring
  rw [hfactor]
  have hc := Finset.sum_sq_le_sum_mul_sum_of_sq_eq_mul (R := ℝ) s
    (r := fun m => Real.log (m : ℝ) / Real.sqrt (m : ℝ))
    (f := fun m => Real.log (m : ℝ))
    (g := fun m => Real.log (m : ℝ) / (m : ℝ))
    (fun m hm => Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega))
    (fun m hm => by positivity)
    (by
      intro m hm
      have hmpos : 0 < (m : ℝ) := by
        exact_mod_cast (lt_of_lt_of_le Nat.zero_lt_one (hmem m hm))
      rw [div_pow, Real.sq_sqrt (le_of_lt hmpos)]
      field_simp)
  have hc' : A ^ 2 ≤ L * B := by
    simpa [A, L, B] using hc
  have hL : 0 ≤ L := by
    apply Finset.sum_nonneg
    intro m hm
    exact Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)
  have hB : 0 ≤ B := by
    apply Finset.sum_nonneg
    intro m hm
    exact div_nonneg (Real.log_nonneg (by
      have := completeSupport_mem_bounds (List.mem_toFinset.mp hm)
      norm_cast
      omega)) (by positivity)
  have hS3 : SR_S3_log_typed X = L ^ 2 := by
    simp [SR_S3_log_typed, L, Finset.sum_mul]
    ring
  have hS2 : SR_S2_log_typed X = B ^ 2 := by
    simp [SR_S2_log_typed, B, Finset.sum_mul, div_eq_mul_inv]
    ring
  rw [hS3, hS2]
  nlinarith [sq_nonneg (A ^ 2), sq_nonneg (L * B)]
-/
-/
theorem SR_kappa_log_le_one_of_signed_cauchy
    (X : Nat)
    (hbound : SR_HalfWeightedSum X ^ 2 ≤
      SR_S2_log_typed X * SR_S3_log_typed X) :
    SR_kappa_log X ≤ 1 := by
  unfold SR_kappa_log
  split_ifs with h
  · exact (div_le_one h).2 hbound
  · norm_num

theorem SR_kappa_log_in_01_of_signed_cauchy
    (X : Nat)
    (hbound : SR_HalfWeightedSum X ^ 2 ≤
      SR_S2_log_typed X * SR_S3_log_typed X) :
    0 ≤ SR_kappa_log X ∧ SR_kappa_log X ≤ 1 := by
  exact ⟨SR_kappa_log_nonneg X,
    SR_kappa_log_le_one_of_signed_cauchy X hbound⟩

/-! The currently certified finite observable is `W_SR_primorial`, whose
    definition is zero away from the listed primorial checkpoints.  Its
    density is therefore a different object from the empirical signature
    density proposed in the objective; we expose that distinction explicitly. -/
noncomputable def W_SR_primorial_density (N : Nat) : ℝ :=
  ((Finset.filter (fun X => W_SR_primorial X = 1) (Finset.range N)).card : ℝ) /
    (N : ℝ)

theorem W_SR_primorial_density_zero (N : Nat) (hN : 0 < N) :
    W_SR_primorial_density N = 0 := by
  unfold W_SR_primorial_density
  have hfilter : Finset.filter (fun X => W_SR_primorial X = 1)
      (Finset.range N) = ∅ := by
    ext X
    have hz : W_SR_primorial X = 0 := by
      unfold W_SR_primorial
      split <;> rfl
    simp [hz]
  rw [hfilter]
  simp [hN]

theorem W_SR_primorial_density_converges_zero :
    ∀ ε : ℝ, 0 < ε → ∃ N₀ : Nat, ∀ N : Nat, N₀ ≤ N →
      |W_SR_primorial_density N - 0| < ε := by
  intro ε hε
  refine ⟨1, ?_⟩
  intro N hN
  have hNpos : 0 < N := lt_of_lt_of_le Nat.zero_lt_one hN
  rw [W_SR_primorial_density_zero N hNpos]
  simpa using hε

end SR
