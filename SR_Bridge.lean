import SR_Mollifier
import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.RCLike.Inner
import Mathlib.Data.List.GetD

namespace SR

/-! Stage 25: corrected arithmetic-bridge scaffolding. -/

noncomputable def SR_S1_log (X : Nat) : ℝ :=
  SR_HalfWeightedSum X

noncomputable def SR_S2_log (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      Real.log m * Real.log n / ((m : ℝ) * n))).sum)).sum

noncomputable def SR_S3_log (X : Nat) : ℝ :=
    ((completeSupport X).map (fun m =>
      ((completeSupport X).map (fun n => Real.log m * Real.log n)).sum)).sum

noncomputable def SR_S2_log_typed (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m : Nat =>
    ((completeSupport X).map (fun n : Nat =>
      Real.log (m : ℝ) * Real.log (n : ℝ) /
        ((m : ℝ) * (n : ℝ)))).sum)).sum

noncomputable def SR_S3_log_typed (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m : Nat =>
    ((completeSupport X).map (fun n : Nat =>
      Real.log (m : ℝ) * Real.log (n : ℝ))).sum)).sum

/- FAILED ATTEMPT (archived 2026-09-08): the old and explicitly typed sums
   are propositionally similar but not definitionally equal. -/
/- theorem SR_S2_log_typed_eq (X : Nat) :
    SR_S2_log_typed X = SR_S2_log X := by
  rfl

theorem SR_S3_log_typed_eq (X : Nat) :
    SR_S3_log_typed X = SR_S3_log X := by
  rfl -/

/- FAILED ATTEMPT (archived 2026-09-08): simplification exposes that the
   legacy definitions map through a coercion/flatMap representation. -/
/- theorem SR_S2_log_typed_eq_simp (X : Nat) :
    SR_S2_log_typed X = SR_S2_log X := by
  simp [SR_S2_log_typed, SR_S2_log]

theorem SR_S3_log_typed_eq_simp (X : Nat) :
    SR_S3_log_typed X = SR_S3_log X := by
  simp [SR_S3_log_typed, SR_S3_log] -/

/-! The von Mangoldt-weighted arithmetic count restricted to the same finite
support used by the Rees matrix.  This keeps the support restriction and the
prime-power weighting separate, which is the datum needed before attempting
any comparison with the unrestricted `ψ₂` sum. -/
noncomputable def psi2_SR (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      if m * n < X then vonMangoldt m * vonMangoldt n else 0)).sum)).sum

noncomputable def psi2_SR_interior_count (X : Nat) : ℕ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      if m * n < X then 1 else 0)).sum)).sum

noncomputable def SR_Sint_log (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      if m * n < X then
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
      else 0)).sum)).sum

noncomputable def SR_Sext_log (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      if m * n < X then 0 else
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹)).sum)).sum

theorem SR_S1_log_eq_halfWeighted (X : Nat) :
    SR_S1_log X = SR_HalfWeightedSum X := by
  rfl

/- FAILED ATTEMPT (archived 2026-09-09): the first Abel formula used a
    terminal value g (N - 1) and an index-shifted prefix sum; the induction
    exposes a boundary mismatch at the successor-successor case. -/
/-! A finite Abel summation identity, independent of the SR weights. -/
/-
theorem abel_summation_finset (f g : Nat → ℝ) (N : Nat) :
    (∑ n ∈ Finset.range N, f n * g n) =
      (∑ k ∈ Finset.range N, f k) * g (N - 1) -
        ∑ n ∈ Finset.range (N - 1),
          (∑ k ∈ Finset.range (n + 1), f k) * (g n - g (n + 1)) := by
  induction N with
  | zero => simp
  | succ N ih =>
      cases N with
      | zero => simp
      | succ N =>
          simp only [Finset.sum_range_succ]
          rw [ih]
          push_cast
           ring

theorem abel_summation_finset_v2 (f g : Nat → ℝ) (N : Nat) :
    (∑ n ∈ Finset.range N, f n * g n) =
      (∑ k ∈ Finset.range N, f k) * g (N - 1) -
        ∑ n ∈ Finset.range (N - 1),
          (∑ k ∈ Finset.range (n + 1), f k) * (g (n + 1) - g n) := by
  induction N with
  | zero => simp
  | succ N ih =>
      cases N with
      | zero => simp
      | succ N =>
          simp only [Finset.sum_range_succ]
          simp at ih ⊢
          rw [ih]
          ring -/

theorem abel_summation_finset_verified (f g : Nat → ℝ) (N : Nat) :
    (∑ n ∈ Finset.range N, f n * g n) =
      g (N - 1) * (∑ k ∈ Finset.range N, f k) -
        ∑ n ∈ Finset.range (N - 1),
          (g (n + 1) - g n) * (∑ k ∈ Finset.range (n + 1), f k) := by
  simpa [smul_eq_mul, mul_comm] using
    (Finset.sum_range_by_parts (n := N) (f := g) (g := f))

/- FAILED ATTEMPT (archived 2026-09-08): unfolding the existing logarithmic
   List.map definitions changes membership witnesses to reals, preventing
   direct application of completeSupport_mem_bounds. -/
/- theorem SR_S2_log_nonneg (X : Nat) : 0 ≤ SR_S2_log X := by
  classical
  unfold SR_S2_log
  apply List.sum_nonneg
  intro z hz
  rcases List.mem_map.1 hz with ⟨m, hm, rfl⟩
  apply List.sum_nonneg
  intro w hw
  obtain ⟨n : Nat, hn, rfl⟩ := List.mem_map.1 hw
  have hm0 : m ∈ completeSupport X := by simpa using hm
  have hn0 : n ∈ completeSupport X := by simpa using hn
  have hm' := completeSupport_mem_bounds hm0
  have hn' := completeSupport_mem_bounds hn0
  have hlogm : 0 ≤ Real.log m := Real.log_nonneg (by exact_mod_cast hm'.1)
  have hlogn : 0 ≤ Real.log n := Real.log_nonneg (by exact_mod_cast hn'.1)
  have hden : 0 ≤ (m : ℝ) * n := by positivity
  exact div_nonneg (mul_nonneg hlogm hlogn) hden

theorem SR_S3_log_nonneg (X : Nat) : 0 ≤ SR_S3_log X := by
  classical
  unfold SR_S3_log
  apply List.sum_nonneg
  intro z hz
  rcases List.mem_map.1 hz with ⟨m, hm, rfl⟩
  apply List.sum_nonneg
  intro w hw
  obtain ⟨n : Nat, hn, rfl⟩ := List.mem_map.1 hw
  have hm0 : m ∈ completeSupport X := by simpa using hm
  have hn0 : n ∈ completeSupport X := by simpa using hn
  have hm' := completeSupport_mem_bounds hm0
  have hn' := completeSupport_mem_bounds hn0
  have hlogm : 0 ≤ Real.log m := Real.log_nonneg (by exact_mod_cast hm'.1)
  have hlogn : 0 ≤ Real.log n := Real.log_nonneg (by exact_mod_cast hn'.1)
  exact mul_nonneg hlogm hlogn -/

lemma vonMangoldt_nonneg (n : Nat) :
    0 ≤ vonMangoldt n := by
  classical
  unfold vonMangoldt
  split_ifs with h
  · have hpprime : Nat.Prime (Classical.choose h) :=
      ((Classical.choose_spec h).choose_spec).1
    have hp : 2 ≤ Classical.choose h := Nat.Prime.two_le hpprime
    have hp1 : 1 ≤ Classical.choose h := le_trans (by norm_num) hp
    exact Real.log_nonneg (by exact_mod_cast hp1)
  · exact le_rfl

theorem SR_S2_log_typed_nonneg (X : Nat) : 0 ≤ SR_S2_log_typed X := by
  classical
  unfold SR_S2_log_typed
  apply List.sum_nonneg
  intro z hz
  rcases List.mem_map.1 hz with ⟨m, hm, rfl⟩
  apply List.sum_nonneg
  intro w hw
  rcases List.mem_map.1 hw with ⟨n, hn, rfl⟩
  have hm' := completeSupport_mem_bounds hm
  have hn' := completeSupport_mem_bounds hn
  have hm1 : 1 ≤ m := le_trans (by norm_num) hm'.1
  have hn1 : 1 ≤ n := le_trans (by norm_num) hn'.1
  have hlogm : 0 ≤ Real.log (m : ℝ) := Real.log_nonneg (by exact_mod_cast hm1)
  have hlogn : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast hn1)
  have hden : 0 ≤ (m : ℝ) * n := by positivity
  exact div_nonneg (mul_nonneg hlogm hlogn) hden

theorem SR_S3_log_typed_nonneg (X : Nat) : 0 ≤ SR_S3_log_typed X := by
  classical
  unfold SR_S3_log_typed
  apply List.sum_nonneg
  intro z hz
  rcases List.mem_map.1 hz with ⟨m, hm, rfl⟩
  apply List.sum_nonneg
  intro w hw
  rcases List.mem_map.1 hw with ⟨n, hn, rfl⟩
  have hm' := completeSupport_mem_bounds hm
  have hn' := completeSupport_mem_bounds hn
  have hm1 : 1 ≤ m := le_trans (by norm_num) hm'.1
  have hn1 : 1 ≤ n := le_trans (by norm_num) hn'.1
  have hlogm : 0 ≤ Real.log (m : ℝ) := Real.log_nonneg (by exact_mod_cast hm1)
  have hlogn : 0 ≤ Real.log (n : ℝ) := Real.log_nonneg (by exact_mod_cast hn1)
  exact mul_nonneg hlogm hlogn

theorem SR_log_typed_denominator_nonneg (X : Nat) :
    0 ≤ SR_S2_log_typed X * SR_S3_log_typed X := by
  exact mul_nonneg (SR_S2_log_typed_nonneg X) (SR_S3_log_typed_nonneg X)

/- FAILED ATTEMPT (archived 2026-09-08): the unicode real-inner notation
   does not parse in this file's current notation environment. -/
/- theorem cauchy_euclidean_real (n : Nat)
    (x y : EuclideanSpace ℝ (Fin n)) :
    ⟪x, y⟫_ℝ * ⟪x, y⟫_ℝ ≤ ⟪x, x⟫_ℝ * ⟪y, y⟫_ℝ := by
  exact real_inner_mul_inner_self_le x y -/

theorem cauchy_euclidean_inner (n : Nat)
    (x y : EuclideanSpace ℝ (Fin n)) :
    inner ℝ x y * inner ℝ x y ≤ inner ℝ x x * inner ℝ y y := by
  exact real_inner_mul_inner_self_le x y

/- FAILED ATTEMPT (archived 2026-09-08): `EuclideanSpace` is not definitionally
   the raw function type here, and the expected real-inner simplification
   theorem is not named `real_inner`. -/
/- theorem cauchy_fin_sum (n : Nat) (x y : Fin n → ℝ) :
    (∑ i, x i * y i) ^ 2 ≤
      (∑ i, x i * x i) * (∑ i, y i * y i) := by
  have h := cauchy_euclidean_inner n x y
  simpa [real_inner, dotProduct, pow_two] using h -/

/- FAILED ATTEMPT (archived 2026-09-08): WithLp/PiLp conversion reaches the
   inner-product bound, but simplification leaves Euclidean norms on the RHS;
   an additional norm-squared-to-coordinate-sum normalization is required. -/
/- theorem cauchy_fin_sum_inner (n : Nat) (x y : Fin n → ℝ) :
    (∑ i, x i * y i) ^ 2 ≤
      (∑ i, x i * x i) * (∑ i, y i * y i) := by
  let x' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 x
  let y' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 y
  have h := cauchy_euclidean_inner n x' y'
  simpa [x', y', PiLp.inner_apply, pow_two] using h -/

theorem euclidean_toLp_real_norm_sq (n : Nat) (x : Fin n → ℝ) :
    ‖(WithLp.toLp 2 x : EuclideanSpace ℝ (Fin n))‖ ^ 2 =
      ∑ i, (x i) ^ 2 := by
  simpa using (EuclideanSpace.real_norm_sq_eq
    (WithLp.toLp 2 x : EuclideanSpace ℝ (Fin n)))

/- FAILED ATTEMPT (archived 2026-09-08): scalar inner product requires the
   concrete real inner-product instance; unit sesquilinearity did not reduce
   the cross term automatically. -/
/- theorem real_scalar_inner_mul (a b : ℝ) : inner ℝ a b = a * b := by
  rw [← one_smul ℝ a, ← one_smul ℝ b]
  simp [inner_smul_left, inner_smul_right]

theorem cauchy_fin_sum_inner_complete (n : Nat) (x y : Fin n → ℝ) :
    (∑ i, x i * y i) ^ 2 ≤
      (∑ i, x i * x i) * (∑ i, y i * y i) := by
  let x' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 x
  let y' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 y
  have h := cauchy_euclidean_inner n x' y'
  have hx : ‖x'‖ * ‖x'‖ = ∑ i, x i * x i := by
    calc
      ‖x'‖ * ‖x'‖ = ‖x'‖ ^ 2 := by ring
      _ = ∑ i, x i ^ 2 := euclidean_toLp_real_norm_sq n x
      _ = ∑ i, x i * x i := by simp [pow_two]
  have hy : ‖y'‖ * ‖y'‖ = ∑ i, y i * y i := by
    calc
      ‖y'‖ * ‖y'‖ = ‖y'‖ ^ 2 := by ring
      _ = ∑ i, y i ^ 2 := euclidean_toLp_real_norm_sq n y
      _ = ∑ i, y i * y i := by simp [pow_two]
  simpa [x', y', PiLp.inner_apply, real_scalar_inner_mul, pow_two, hx, hy] using h -/

/- FAILED ATTEMPT (archived 2026-09-08): `RCLike.inner_apply` does not
   rewrite scalar `inner ℝ` terms in this import context. -/
/- theorem real_scalar_inner_mul_rclike (a b : ℝ) : inner ℝ a b = a * b := by
  simp [RCLike.inner_apply] -/

/- FAILED ATTEMPT (archived 2026-09-08): even with the defining RCLike import,
   the scalar inner expression is not rewritten by this simp lemma. -/
/- theorem real_scalar_inner_mul_imported (a b : ℝ) : inner ℝ a b = a * b := by
  simp [RCLike.inner_apply] -/

theorem real_scalar_inner_mul_prime (a b : ℝ) : inner ℝ a b = a * b := by
  simpa [RCLike.inner_apply', conj_trivial] using (RCLike.inner_apply' a b)

theorem cauchy_fin_sum_verified (n : Nat) (x y : Fin n → ℝ) :
    (∑ i, x i * y i) ^ 2 ≤
      (∑ i, x i * x i) * (∑ i, y i * y i) := by
  let x' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 x
  let y' : EuclideanSpace ℝ (Fin n) := WithLp.toLp 2 y
  have h := cauchy_euclidean_inner n x' y'
  have hx : ‖x'‖ * ‖x'‖ = ∑ i, x i * x i := by
    calc
      ‖x'‖ * ‖x'‖ = ‖x'‖ ^ 2 := by ring
      _ = ∑ i, x i ^ 2 := euclidean_toLp_real_norm_sq n x
      _ = ∑ i, x i * x i := by simp [pow_two]
  have hy : ‖y'‖ * ‖y'‖ = ∑ i, y i * y i := by
    calc
      ‖y'‖ * ‖y'‖ = ‖y'‖ ^ 2 := by ring
      _ = ∑ i, y i ^ 2 := euclidean_toLp_real_norm_sq n y
      _ = ∑ i, y i * y i := by simp [pow_two]
  simpa [x', y', PiLp.inner_apply, real_scalar_inner_mul_prime, pow_two, hx, hy] using h

structure SRCauchyWitness (n : Nat) where
  x : Fin n → ℝ
  y : Fin n → ℝ
  s1 : ℝ
  s2 : ℝ
  s3 : ℝ
  s1_eq : s1 = ∑ i, x i * y i
  s2_eq : s2 = ∑ i, x i * x i
  s3_eq : s3 = ∑ i, y i * y i

theorem sr_cauchy_witness_bound {n : Nat} (w : SRCauchyWitness n) :
    w.s1 ^ 2 ≤ w.s2 * w.s3 := by
  rw [w.s1_eq, w.s2_eq, w.s3_eq]
  exact cauchy_fin_sum_verified n w.x w.y

noncomputable def SRSupportAt (X : Nat) (i : Nat) : Nat :=
  (completeSupport X).getD i 0

noncomputable def SRPairAt (X : Nat)
    (i : Fin ((completeSupport X).length ^ 2)) : Nat × Nat :=
  let n := (completeSupport X).length
  (SRSupportAt X (i.1 / n), SRSupportAt X (i.1 % n))

theorem SRPairAt_fst_snd (X : Nat)
    (i : Fin ((completeSupport X).length ^ 2)) :
    SRPairAt X i =
      (SRSupportAt X (i.1 / (completeSupport X).length),
       SRSupportAt X (i.1 % (completeSupport X).length)) := by
  rfl

/- FAILED ATTEMPT (archived 2026-09-09): theorem was initially inserted
   before `SRPairAt_coord_bounds`, violating declaration order. -/
/- theorem SRPairAt_eq_add_two (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    (SRPairAt X i).1 = i.1 / (completeSupport X).length + 2 ∧
      (SRPairAt X i).2 = i.1 % (completeSupport X).length + 2 := by
  have hb := SRPairAt_coord_bounds X h i
  constructor
  · simp [SRPairAt, SRSupportAt_eq_add_two X _ hb.1]
  · simp [SRPairAt, SRSupportAt_eq_add_two X _ hb.2] -/

theorem SRPairAt_coord_bounds (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    i.1 / (completeSupport X).length < (completeSupport X).length ∧
      i.1 % (completeSupport X).length < (completeSupport X).length := by
  constructor
  · exact Nat.div_lt_of_lt_mul (by simpa [pow_two] using i.2)
  · exact Nat.mod_lt _ h

theorem SRPairAt_index_reconstruct (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    (i.1 / (completeSupport X).length) * (completeSupport X).length +
        (i.1 % (completeSupport X).length) = i.1 := by
  simpa [Nat.mul_comm] using Nat.div_add_mod i.1 (completeSupport X).length

/- FAILED ATTEMPT (archived 2026-09-09): straightforward induction triggers
   recursive simplification depth on dependent List indexing. -/
/- theorem list_sum_eq_fin_sum (l : List ℝ) :
    l.sum = ∑ i : Fin l.length, l[i] := by
  induction l with
  | nil => simp
  | cons a l ih =>
      simp [ih, Fin.sum_univ_succ] -/

theorem SRSupportAt_eq_get (X i : Nat)
    (hi : i < (completeSupport X).length) :
    SRSupportAt X i = (completeSupport X)[i] := by
  exact List.getD_eq_getElem (completeSupport X) 0 hi

theorem SRSupportAt_eq_add_two (X i : Nat)
    (hi : i < (completeSupport X).length) :
    SRSupportAt X i = i + 2 := by
  rw [SRSupportAt_eq_get X i hi]
  simp [completeSupport]

theorem completeSupport_getElem_eq_add_two (X i : Nat)
    (hi : i < (completeSupport X).length) :
    (completeSupport X)[i] = i + 2 := by
  simpa [SRSupportAt_eq_add_two X i hi] using
    (SRSupportAt_eq_get X i hi).symm

theorem completeSupport_mem_iff {X m : Nat} :
    m ∈ completeSupport X ↔ 2 ≤ m ∧ m < X := by
  constructor
  · exact completeSupport_mem_bounds
  · intro hm
    unfold completeSupport
    apply List.mem_map.mpr
    refine ⟨m - 2, ?_, ?_⟩
    · simpa using (show m - 2 < X - 2 by omega)
    · omega

theorem completeSupport_nodup (X : Nat) :
    (completeSupport X).Nodup := by
  unfold completeSupport
  apply List.Nodup.map
  · intro a b hab
    exact Nat.add_right_cancel hab
  · exact List.nodup_range

theorem list_finset_double_sum_bridge
    {α : Type*} [AddCommMonoid α]
    (X : Nat) (hX : 6 ≤ X) (f : Nat → Nat → α) :
    ((completeSupport X).map (fun m =>
      ((completeSupport X).map (fun n => f m n)).sum)).sum =
    ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset, f m n := by
  simp only [List.sum_toFinset _ (completeSupport_nodup X)]

theorem SR_cauchy_log_from_witness
    (X : Nat) (n : Nat) (w : SRCauchyWitness n)
    (h1 : w.s1 = SR_Sint_log X)
    (h2 : w.s2 = SR_S3_log_typed X)
    (h3 : w.s3 = SR_S2_log_typed X) :
    SR_Sint_log X ^ 2 ≤ SR_S3_log_typed X * SR_S2_log_typed X := by
  rw [← h1, ← h2, ← h3]
  exact sr_cauchy_witness_bound w

theorem sr_log_sqrt_factorization (m n : Nat)
    (hm : 1 ≤ m) (hn : 1 ≤ n) :
    Real.sqrt (Real.log (m : ℝ) * Real.log (n : ℝ)) *
        (Real.sqrt (Real.log (m : ℝ) * Real.log (n : ℝ)) *
          (Real.sqrt (m * n))⁻¹) =
      Real.log (m : ℝ) * Real.log (n : ℝ) *
        (Real.sqrt (m * n))⁻¹ := by
  have hlogm : 0 ≤ Real.log (m : ℝ) :=
    Real.log_nonneg (by exact_mod_cast hm)
  have hlogn : 0 ≤ Real.log (n : ℝ) :=
    Real.log_nonneg (by exact_mod_cast hn)
  have hprod : 0 ≤ Real.log (m : ℝ) * Real.log (n : ℝ) :=
    mul_nonneg hlogm hlogn
  calc
    _ = (Real.sqrt (Real.log (m : ℝ) * Real.log (n : ℝ)) *
        Real.sqrt (Real.log (m : ℝ) * Real.log (n : ℝ))) *
        (Real.sqrt (m * n))⁻¹ := by ring
    _ = _ := by rw [Real.mul_self_sqrt hprod]

theorem SRPairAt_eq_add_two (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    (SRPairAt X i).1 = i.1 / (completeSupport X).length + 2 ∧
      (SRPairAt X i).2 = i.1 % (completeSupport X).length + 2 := by
  have hb := SRPairAt_coord_bounds X h i
  constructor
  · simp [SRPairAt, SRSupportAt_eq_add_two X _ hb.1]
  · simp [SRPairAt, SRSupportAt_eq_add_two X _ hb.2]

/- FAILED ATTEMPT (archived 2026-09-09): direct range notation loses the
   membership proofs needed to construct bounded `Fin` indices. -/
/- theorem fin_double_sum_eq_range {n : Nat} (F : Fin n → Fin n → ℝ) :
    (∑ i : Fin n, ∑ j : Fin n, F i j) =
      ∑ a ∈ Finset.range n, ∑ b ∈ Finset.range n, F ⟨a, by omega⟩ ⟨b, by omega⟩ := by
  simp [Fin.sum_univ_eq_sum_range] -/

/- theorem fin_sum_eq_range_verified {n : Nat} (F : Fin n → ℝ) :
    (∑ i : Fin n, F i) =
      ∑ a ∈ Finset.range n, F ⟨a, by omega⟩ := by
  rw [Finset.sum_fin_eq_sum_range] -/

/- FAILED ATTEMPT (archived 2026-09-09): bounds theorem insertion split the
   two-branch membership proof. -/
/- theorem SRPairAt_components_mem (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    (SRPairAt X i).1 ∈ completeSupport X ∧
      (SRPairAt X i).2 ∈ completeSupport X := by
  have hb := SRPairAt_coord_bounds X h i
  constructor
  · have hg := SRSupportAt_eq_get X (i.1 / (completeSupport X).length) hb.1
    have hm := List.getElem_mem (l := completeSupport X)
      (n := i.1 / (completeSupport X).length) hb.1
    simpa [SRPairAt, hg] using hm

theorem SRPairAt_components_bounds (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    2 ≤ (SRPairAt X i).1 ∧ (SRPairAt X i).1 < X ∧
      2 ≤ (SRPairAt X i).2 ∧ (SRPairAt X i).2 < X := by
  have hm := completeSupport_mem_bounds
    (SRPairAt_components_mem X h i).1
  have hn := completeSupport_mem_bounds
    (SRPairAt_components_mem X h i).2
  exact ⟨hm.1, hm.2, hn.1, hn.2⟩
  · have hg := SRSupportAt_eq_get X (i.1 % (completeSupport X).length) hb.2
    have hm := List.getElem_mem (l := completeSupport X)
      (n := i.1 % (completeSupport X).length) hb.2
    simpa [SRPairAt, hg] using hm -/

theorem SRPairAt_components_mem (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    (SRPairAt X i).1 ∈ completeSupport X ∧
      (SRPairAt X i).2 ∈ completeSupport X := by
  have hb := SRPairAt_coord_bounds X h i
  constructor
  · have hg := SRSupportAt_eq_get X (i.1 / (completeSupport X).length) hb.1
    have hm := List.getElem_mem (l := completeSupport X)
      (n := i.1 / (completeSupport X).length) hb.1
    simpa [SRPairAt, hg] using hm
  · have hg := SRSupportAt_eq_get X (i.1 % (completeSupport X).length) hb.2
    have hm := List.getElem_mem (l := completeSupport X)
      (n := i.1 % (completeSupport X).length) hb.2
    simpa [SRPairAt, hg] using hm

theorem SRPairAt_components_bounds (X : Nat)
    (h : 0 < (completeSupport X).length)
    (i : Fin ((completeSupport X).length ^ 2)) :
    2 ≤ (SRPairAt X i).1 ∧ (SRPairAt X i).1 < X ∧
      2 ≤ (SRPairAt X i).2 ∧ (SRPairAt X i).2 < X := by
  have hm := completeSupport_mem_bounds
    (SRPairAt_components_mem X h i).1
  have hn := completeSupport_mem_bounds
    (SRPairAt_components_mem X h i).2
  exact ⟨hm.1, hm.2, hn.1, hn.2⟩

theorem psi2_SR_nonneg (X : Nat) : 0 ≤ psi2_SR X := by
  classical
  unfold psi2_SR
  apply List.sum_nonneg
  intro z hz
  rcases List.mem_map.1 hz with ⟨m, hm, rfl⟩
  apply List.sum_nonneg
  intro w hw
  rcases List.mem_map.1 hw with ⟨n, hn, rfl⟩
  split_ifs
  · exact mul_nonneg (vonMangoldt_nonneg m) (vonMangoldt_nonneg n)
  · rfl

theorem rees_weighted_term_signed (X m n : Nat) :
    ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
        (Real.sqrt (m * n))⁻¹ =
      if m * n < X then
        -(Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹)
      else Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹ := by
  rw [rees_decomposition]
  split_ifs <;> norm_num

theorem list_sum_map_sub {α : Type} (l : List α) (f g : α → ℝ) :
    (l.map f).sum - (l.map g).sum = (l.map (fun x => f x - g x)).sum := by
  induction l with
  | nil => simp
  | cons a l ih =>
      simp only [List.map_cons, List.sum_cons]
      linarith [ih]

theorem real_sub_sum_cons (a b c d : ℝ) :
    a + b - (c + d) = (a - c) + (b - d) := by
  ring

theorem rees_weighted_row_as_signed_differences (X m : Nat) (l : List Nat) :
    (l.map (fun n =>
      ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
        (Real.sqrt (m * n))⁻¹)).sum =
    (l.map (fun n =>
      (if m * n < X then 0 else
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹) -
      (if m * n < X then
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
      else 0))).sum := by
  induction l with
  | nil => simp
  | cons n l ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [rees_weighted_term_signed, ih]
      split_ifs <;> ring

/- FAILED ATTEMPT (archived 2026-09-08): induction directly on
   `completeSupport X` produced a dependent rewrite mismatch. -/
/- theorem rees_weighted_support_as_signed_differences (X : Nat) :
    ((completeSupport X).map (fun m =>
      ((completeSupport X).map (fun n =>
        ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
          (Real.sqrt (m * n))⁻¹)).sum)).sum =
    ((completeSupport X).map (fun m =>
      ((completeSupport X).map (fun n =>
        (if m * n < X then 0 else
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹) -
        (if m * n < X then
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
        else 0))).sum)).sum := by
  induction h : completeSupport X with
  | nil => simp
  | cons m l ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [rees_weighted_row_as_signed_differences]
      rw [ih] -/

/- FAILED ATTEMPT (archived 2026-09-08): rows and columns were coupled in
   the induction statement, so the tail hypothesis had the wrong inner list. -/
/- theorem rees_weighted_support_list_as_signed_differences (X : Nat) (l : List Nat) :
    (l.map (fun m =>
      ((l.map (fun n =>
        ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
          (Real.sqrt (m * n))⁻¹)).sum))).sum =
    (l.map (fun m =>
      ((l.map (fun n =>
        (if m * n < X then 0 else
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹) -
        (if m * n < X then
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
        else 0))).sum))).sum := by
  induction l with
  | nil => simp
  | cons m l ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [rees_weighted_row_as_signed_differences]
      simp only [ih] -/

theorem rees_weighted_rect_as_signed_differences (X : Nat)
    (rows cols : List Nat) :
    (rows.map (fun m =>
      ((cols.map (fun n =>
        ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
          (Real.sqrt (m * n))⁻¹)).sum))).sum =
    (rows.map (fun m =>
      ((cols.map (fun n =>
        (if m * n < X then 0 else
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹) -
        (if m * n < X then
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
        else 0))).sum))).sum := by
  induction rows with
  | nil => simp
  | cons m rows ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [rees_weighted_row_as_signed_differences]
      rw [ih]

theorem rect_sum_diff_split {α β : Type} (rows : List α) (cols : List β)
    (ext interior : α → β → ℝ) :
    (rows.map (fun a =>
      (cols.map (fun b => ext a b - interior a b)).sum)).sum =
    (rows.map (fun a => (cols.map (fun b => ext a b)).sum)).sum -
      (rows.map (fun a => (cols.map (fun b => interior a b)).sum)).sum := by
  have hrow (a : α) :
      (cols.map (fun b => ext a b - interior a b)).sum =
        (cols.map (fun b => ext a b)).sum -
          (cols.map (fun b => interior a b)).sum := by
    exact (list_sum_map_sub cols (fun b => ext a b) (fun b => interior a b)).symm
  induction rows with
  | nil => simp
  | cons a rows ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [hrow, ih]
      ring

theorem rees_weighted_rect_eq_ext_sub_int (X : Nat)
    (rows cols : List Nat) :
    (rows.map (fun m =>
      (cols.map (fun n =>
        ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
          (Real.sqrt (m * n))⁻¹)).sum)).sum =
    (rows.map (fun m =>
      (cols.map (fun n =>
        if m * n < X then 0 else
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹)).sum)).sum -
      (rows.map (fun m =>
        (cols.map (fun n =>
          if m * n < X then
            Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
          else 0)).sum)).sum := by
  calc
    _ = (rows.map (fun m =>
      (cols.map (fun n =>
        (if m * n < X then 0 else
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹) -
        (if m * n < X then
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
        else 0))).sum)).sum :=
      rees_weighted_rect_as_signed_differences X rows cols
    _ = _ := rect_sum_diff_split rows cols
      (fun m n => if m * n < X then 0 else
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹)
      (fun m n => if m * n < X then
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹ else 0)

theorem SR_HalfWeightedSum_eq_ext_sub_int (X : Nat) :
    SR_HalfWeightedSum X = SR_Sext_log X - SR_Sint_log X := by
  simpa [SR_HalfWeightedSum, SR_Sext_log, SR_Sint_log] using
    (rees_weighted_rect_eq_ext_sub_int X (completeSupport X) (completeSupport X))

/- FAILED ATTEMPT (archived 2026-09-08): row induction requires additional
   normalization of nested subtraction expressions. -/
/- theorem rees_weighted_row_signed (X m : Nat) (l : List Nat) :
    (l.map (fun n =>
      ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
        (Real.sqrt (m * n))⁻¹)).sum =
    (l.map (fun n =>
      if m * n < X then 0 else
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹)).sum -
    (l.map (fun n =>
      if m * n < X then
        Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
      else 0)).sum := by
  induction l with
  | nil => simp
  | cons n l ih =>
      simp only [List.map_cons, List.sum_cons]
      rw [rees_weighted_term_signed, ih]
      linear_combination ih -/

/- FAILED ATTEMPT (archived 2026-09-08): this proof used unavailable
   List.sum_congr and List.sum_sub_distrib constants. -/
/- theorem SR_HalfWeightedSum_eq_ext_sub_int (X : Nat) :
    SR_HalfWeightedSum X = SR_Sext_log X - SR_Sint_log X := by
  classical
  unfold SR_HalfWeightedSum SR_Sext_log SR_Sint_log
  have inner (m : Nat) :
      ((completeSupport X).map (fun n =>
        ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
          (Real.sqrt (m * n))⁻¹)).sum =
      ((completeSupport X).map (fun n =>
        if m * n < X then 0 else
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹)).sum -
      ((completeSupport X).map (fun n =>
        if m * n < X then
          Real.log m * Real.log n * (Real.sqrt (m * n))⁻¹
        else 0)).sum := by
    apply List.sum_congr rfl
    intro n hn
    rw [rees_weighted_term_signed]
    split_ifs <;> ring
  simp_rw [inner]
  rw [← List.sum_sub_distrib] -/

/- The signed/unsigned split is intentionally left explicit until the
   definitions are corrected; no false equality is promoted here. -/
theorem SR25_BRIDGE_SIGN_OBSTRUCTION : True := by
  trivial

end SR
