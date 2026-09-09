import SR_Mollifier
import Mathlib.Analysis.InnerProductSpace.PiL2

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
