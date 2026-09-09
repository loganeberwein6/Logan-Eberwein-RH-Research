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
