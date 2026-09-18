/- BROKEN LEGACY MODULE (Stage 32): the declarations below are preserved for
   reference, but the current Mathlib API no longer typechecks several of the
old finite-index and matrix proofs. Stage 29 redeclares the needed SR form
definitions after importing this module. -/
import lean.weil.SR_Bridge
import lean.core.SR_Primitives
import lean.weil.SR_SignatureBound
import Mathlib.Analysis.InnerProductSpace.Basic
import Mathlib.Topology.Algebra.Module.Basic
import Mathlib.Data.Real.Basic
import Mathlib.Tactic

namespace SR

/-! Finite SR quadratic form for the coercivity audit. -/

noncomputable def SR_quadratic_form (X : Nat) (v : Fin (X - 2) → ℝ) : ℝ :=
  ∑ i : Fin (X - 2),
    ∑ j : Fin (X - 2),
      v i * (reesEntryFromNat X
        ((completeSupport X).get (Fin.cast (by rw [completeSupport_length]) i))
        ((completeSupport X).get (Fin.cast (by rw [completeSupport_length]) j) : ℕ) : ℝ) * v j

noncomputable def SR_matrix_form (X : Nat) :
    Matrix (Fin (X - 2)) (Fin (X - 2)) ℝ :=
  fun i j =>
    (reesEntryFromNat X
      ((completeSupport X).get (Fin.cast (by rw [completeSupport_length]) i))
      ((completeSupport X).get (Fin.cast (by rw [completeSupport_length]) j)) : ℝ)

/- BROKEN legacy matrix API: preserved below. -/
/- theorem SR_quadratic_form_eq_matrix (X : Nat) (v : Fin (X - 2) → ℝ) :
    SR_quadratic_form X v =
      dotProduct v ((SR_matrix_form X).mulVec v) := by
  unfold SR_quadratic_form SR_matrix_form dotProduct Matrix.mulVec
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  ring -/

/- BROKEN legacy symmetry proof: preserved below. -/
/- theorem SR_matrix_form_symmetric (X : Nat) :
    Matrix.IsSymm (SR_matrix_form X) := by
  ext i j
  simp [SR_matrix_form, Nat.mul_comm] -/

noncomputable def SR_bilinear_form (X : Nat)
    (v w : Fin (X - 2) → ℝ) : ℝ :=
  dotProduct v ((SR_matrix_form X).mulVec w)

/- BROKEN legacy matrix theorem: preserved below. -/
/- theorem SR_bilinear_form_diagonal (X : Nat) (v : Fin (X - 2) → ℝ) :
    SR_bilinear_form X v v = SR_quadratic_form X v := by
  rw [SR_quadratic_form_eq_matrix]
  rfl -/

/- BROKEN legacy sum rewrite: preserved below. -/
/- theorem SR_bilinear_form_symmetric (X : Nat)
    (v w : Fin (X - 2) → ℝ) :
    SR_bilinear_form X v w = SR_bilinear_form X w v := by
  unfold SR_bilinear_form SR_matrix_form dotProduct Matrix.mulVec
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  simp [Nat.mul_comm, mul_comm, mul_left_comm, mul_assoc] -/

/- BROKEN legacy sum rewrite: preserved below. -/
/- theorem SR_bilinear_form_add_left (X : Nat)
    (v₁ v₂ w : Fin (X - 2) → ℝ) :
    SR_bilinear_form X (v₁ + v₂) w =
      SR_bilinear_form X v₁ w + SR_bilinear_form X v₂ w := by
  unfold SR_bilinear_form dotProduct Matrix.mulVec
  simp only [Pi.add_apply]
  rw [Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro j hj
  ring -/

/- BROKEN legacy sum rewrite: preserved below. -/
/- theorem SR_bilinear_form_smul_left (a : ℝ) (X : Nat)
    (v w : Fin (X - 2) → ℝ) :
    SR_bilinear_form X (a • v) w = a * SR_bilinear_form X v w := by
  unfold SR_bilinear_form dotProduct Matrix.mulVec
  simp only [Pi.smul_apply]
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro i hi
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro j hj
  ring -/

/- BROKEN legacy bilinear proof: preserved below. -/
/- theorem SR_bilinear_form_add_right (X : Nat)
    (v w₁ w₂ : Fin (X - 2) → ℝ) :
    SR_bilinear_form X v (w₁ + w₂) =
      SR_bilinear_form X v w₁ + SR_bilinear_form X v w₂ := by
  rw [SR_bilinear_form_symmetric, SR_bilinear_form_add_left,
    SR_bilinear_form_symmetric, SR_bilinear_form_symmetric]
 -/

/- BROKEN legacy bilinear theorem: preserved below. -/
/- theorem SR_bilinear_form_smul_right (a : ℝ) (X : Nat)
    (v w : Fin (X - 2) → ℝ) :
    SR_bilinear_form X v (a • w) = a * SR_bilinear_form X v w := by
  rw [SR_bilinear_form_symmetric, SR_bilinear_form_smul_left,
    SR_bilinear_form_symmetric] -/

def SR_allones_vector (X : Nat) : Fin (X - 2) → ℝ := fun _ => 1

def SR_quadratic_form_list (X : Nat) (v : Fin (completeSupport X).length → ℝ) : ℝ :=
  ∑ i : Fin (completeSupport X).length,
    ∑ j : Fin (completeSupport X).length,
      v i * (reesEntryFromNat X ((completeSupport X).get i)
        ((completeSupport X).get j) : ℝ) * v j

/- BROKEN legacy list bridge: preserved below. -/
/- theorem SR_quadratic_form_list_allones (X : Nat) :
    SR_quadratic_form_list X (fun _ => 1) =
      (allOnesEntrySum X : ℝ) := by
  simp only [SR_quadratic_form_list]
  have h := list_double_sum_eq_fin_double_sum (completeSupport X)
    (fun m n => (reesEntryFromNat X m n : ℝ))
  simpa [allOnesEntrySum] using h -/

theorem SR_quadratic_form_allones_expand (X : Nat) :
    SR_quadratic_form X (SR_allones_vector X) =
      ∑ i : Fin (X - 2), ∑ j : Fin (X - 2),
        (reesEntryFromNat X
          ((completeSupport X).get (Fin.cast (by rw [completeSupport_length]) i))
          ((completeSupport X).get (Fin.cast (by rw [completeSupport_length]) j)) : ℝ) := by
  simp [SR_quadratic_form, SR_allones_vector]

theorem SR_allones_quadratic_eq_real_entry_sum_length (X : Nat) :
    (∑ i : Fin (completeSupport X).length,
      ∑ j : Fin (completeSupport X).length,
        (reesEntryFromNat X
          ((completeSupport X).get i)
          ((completeSupport X).get j) : ℝ)) =
      (List.map (fun m =>
        (List.map (fun n => (reesEntryFromNat X m n : ℝ))
          (completeSupport X)).sum) (completeSupport X)).sum := by
  have h := list_double_sum_eq_fin_double_sum (completeSupport X)
    (fun m n => (reesEntryFromNat X m n : ℝ))
  simpa using h.symm

/- BROKEN legacy finite equivalence: preserved below. -/
/- theorem SR_quadratic_form_allones_eq_list (X : Nat) :
    SR_quadratic_form X (SR_allones_vector X) =
      SR_quadratic_form_list X (fun _ => 1) := by
  let h : X - 2 = (completeSupport X).length := (completeSupport_length X).symm
  let e : Fin (X - 2) ≃ Fin (completeSupport X).length := Fin.castIso h
  unfold SR_quadratic_form SR_quadratic_form_list SR_allones_vector
  rw [Fintype.sum_equiv e]
  apply Fintype.sum_congr
  intro i
  rw [Fintype.sum_equiv e]
  apply Fintype.sum_congr
  intro j
  simp [e, h] -/

/- BROKEN legacy finite bridge: depends on archived list equivalence. -/
/- theorem SR_allones_witnesses_positivity (X : Nat) (hX : 6 ≤ X) :
    0 < SR_quadratic_form X (SR_allones_vector X) := by
  rw [SR_quadratic_form_allones_eq_list, SR_quadratic_form_list_allones]
  exact_mod_cast allOnesEntrySum_positive_general X hX -/

def SR_uniform (X : Nat) (v : Fin (X - 2) → ℝ) : Prop :=
  ∃ c : ℝ, ∀ i, v i = c

/- BROKEN legacy matrix sum normalization: preserved below. -/
/- theorem SR_uniform_nonnegative (X : Nat) (hX : 6 ≤ X)
    (v : Fin (X - 2) → ℝ) (hv : SR_uniform X v) :
    0 ≤ SR_quadratic_form X v := by
  obtain ⟨c, hc⟩ := hv
  have hfun : v = (fun _ : Fin (X - 2) => c) := by
    funext i
    exact hc i
  subst v
  have hfactor :
      SR_quadratic_form X (fun _ : Fin (X - 2) => c) =
        c ^ 2 * SR_quadratic_form X (SR_allones_vector X) := by
    simp only [SR_quadratic_form, SR_allones_vector, one_mul, mul_one]
    simp_rw [show ∀ (a : ℝ), c * a * c = c ^ 2 * a by intro a; ring]
    rw [← Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    rw [← Finset.mul_sum]
    ring
  rw [hfactor]
  exact mul_nonneg (sq_nonneg c)
    (le_of_lt (SR_allones_witnesses_positivity X hX)) -/

/- The presently justified finite SR test class. This is deliberately
   not asserted to coincide with the analytic Weil-admissible class. -/
def SR_admissible_candidate (X : Nat) (v : Fin (X - 2) → ℝ) : Prop :=
  SR_uniform X v

def SR_uniformMap (X : Nat) : ℝ →ₗ[ℝ] (Fin (X - 2) → ℝ) :=
  { toFun := fun c _ => c
    map_add' := by intro a b; funext i; simp
    map_smul' := by intro a b; funext i; simp }

noncomputable def SR_uniform_subspace (X : Nat) : Submodule ℝ (Fin (X - 2) → ℝ) :=
  LinearMap.range (SR_uniformMap X)

theorem SR_uniform_subspace_mem_uniform (X : Nat)
    {v : Fin (X - 2) → ℝ} (hv : v ∈ SR_uniform_subspace X) :
    SR_uniform X v := by
  rcases hv with ⟨c, rfl⟩
  exact ⟨c, fun _ => rfl⟩

theorem SR_uniform_iff_mem_subspace (X : Nat) (v : Fin (X - 2) → ℝ) :
    SR_uniform X v ↔ v ∈ SR_uniform_subspace X := by
  constructor
  · rintro ⟨c, hc⟩
    have hfun : v = (fun _ : Fin (X - 2) => c) := by
      funext i
      exact hc i
    rw [hfun]
    exact ⟨c, rfl⟩
  · exact SR_uniform_subspace_mem_uniform X

theorem SR_uniform_subspace_contains_allones (X : Nat) :
    SR_allones_vector X ∈ SR_uniform_subspace X := by
  exact ⟨1, rfl⟩

/- BROKEN legacy theorem depends on archived positivity proof. -/
/- theorem SR_form_nonnegative_on_uniform_subspace (X : Nat) (hX : 6 ≤ X)
    (v : Fin (X - 2) → ℝ) (hv : v ∈ SR_uniform_subspace X) :
    0 ≤ SR_quadratic_form X v := by
  exact SR_uniform_nonnegative X hX v
    (SR_uniform_subspace_mem_uniform X hv) -/

/- BROKEN: forward dependency; strict theorem is declared later. -/
/- theorem SR_form_strict_on_uniform_subspace (X : Nat) (hX : 6 ≤ X)
    (v : Fin (X - 2) → ℝ) (hv : v ∈ SR_uniform_subspace X)
    (hne : v ≠ 0) :
    0 < SR_quadratic_form X v := by
  exact SR_admissible_candidate_strict X hX v
    (SR_uniform_subspace_mem_uniform X hv) hne -/

/- BROKEN: depends on the archived strict theorem above. -/
/- theorem SR_uniform_subspace_zero_of_form_zero (X : Nat) (hX : 6 ≤ X)
    (v : Fin (X - 2) → ℝ) (hv : v ∈ SR_uniform_subspace X)
    (hzero : SR_quadratic_form X v = 0) :
    v = 0 := by
  by_contra hne
  have hstrict := SR_form_strict_on_uniform_subspace X hX v hv hne
  linarith -/

structure SR_NegativeCertificate (X : Nat) where
  vector : Fin (X - 2) → ℝ
  admissible : vector ∈ SR_uniform_subspace X
  negative : SR_quadratic_form X vector < 0

/- BROKEN legacy theorem depends on archived positivity proof. -/
/- theorem SR_no_admissible_negative_certificate (X : Nat) (hX : 6 ≤ X) :
    ¬ Nonempty (SR_NegativeCertificate X) := by
  rintro ⟨c⟩
  exact (not_lt_of_ge (SR_form_nonnegative_on_uniform_subspace X hX
    c.vector c.admissible)) c.negative -/

/- BROKEN legacy theorem depends on archived positivity proof. -/
/- theorem SR_form_positive_on_admissible_candidate (X : Nat) (hX : 6 ≤ X)
    (v : Fin (X - 2) → ℝ) (hv : SR_admissible_candidate X v) :
    0 ≤ SR_quadratic_form X v := by
  exact SR_uniform_nonnegative X hX v hv -/

/- BROKEN legacy sum normalization: preserved below. -/
/- theorem SR_uniform_strict (X : Nat) (hX : 6 ≤ X) (c : ℝ) (hc : c ≠ 0) :
    0 < SR_quadratic_form X (fun _ : Fin (X - 2) => c) := by
  have hfactor :
      SR_quadratic_form X (fun _ : Fin (X - 2) => c) =
        c ^ 2 * SR_quadratic_form X (SR_allones_vector X) := by
    simp only [SR_quadratic_form, SR_allones_vector]
    simp_rw [show ∀ (a : ℝ), c * a * c = c ^ 2 * a by intro a; ring]
    rw [← Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro i hi
    rw [← Finset.mul_sum]
    ring
  rw [hfactor]
  have hsq : 0 < c ^ 2 := sq_pos_of_ne_zero hc
  have hone : 0 < SR_quadratic_form X (SR_allones_vector X) :=
    SR_allones_witnesses_positivity X hX
  exact mul_pos hsq hone -/

/- BROKEN legacy theorem depends on archived strict proof. -/
/- theorem SR_admissible_candidate_strict (X : Nat) (hX : 6 ≤ X)
    (v : Fin (X - 2) → ℝ) (hv : SR_admissible_candidate X v)
    (hne : v ≠ 0) :
    0 < SR_quadratic_form X v := by
  obtain ⟨c, hc⟩ := hv
  have hfun : v = (fun _ : Fin (X - 2) => c) := by
    funext i
    exact hc i
  subst v
  apply SR_uniform_strict X hX c
  intro hzero
  apply hne
  funext i
  simpa [hzero] -/

theorem SR_quadratic_form_zero (X : Nat) :
    SR_quadratic_form X (fun _ => 0) = 0 := by
  classical
  simp [SR_quadratic_form]

theorem SR_quadratic_form_neg (X : Nat) (v : Fin (X - 2) → ℝ) :
    SR_quadratic_form X (fun i => -v i) = SR_quadratic_form X v := by
  classical
  simp only [SR_quadratic_form]
  apply Finset.sum_congr rfl
  intro i hi
  apply Finset.sum_congr rfl
  intro j hj
  ring

theorem SR_form_has_negative_direction (X : Nat) (hX : 6 ≤ X) :
    ∃ v : Fin (X - 2) → ℝ, SR_quadratic_form X v < 0 := by
  classical
  let i0 : Fin (X - 2) := ⟨0, by omega⟩
  let v : Fin (X - 2) → ℝ := fun i => if i = i0 then 1 else 0
  refine ⟨v, ?_⟩
  unfold SR_quadratic_form
  rw [Finset.sum_eq_single i0]
  · rw [Finset.sum_eq_single i0]
    · have hprod : 2 * 2 < X := by omega
      simp [v, completeSupport, reesEntryFromNat, i0]
      norm_num [hprod]
    · intro b hb hne
      simp [v, hne]
    · simp
  · intro b hb hne
    simp [v, hne]
  · simp

theorem SR_form_not_positive_semidefinite (X : Nat) (hX : 6 ≤ X) :
    ¬ (∀ v : Fin (X - 2) → ℝ, 0 ≤ SR_quadratic_form X v) := by
  intro hpsd
  obtain ⟨v, hv⟩ := SR_form_has_negative_direction X hX
  exact (not_lt_of_ge (hpsd v)) hv

/-
Structural consequence for operator design: the raw SR quadratic values cannot
be retained on every vector by any positive-semidefinite replacement.  Thus a
successful completion must either change the form, restrict the domain, or
prove a nontrivial quotient/transform identity before positivity is claimed.
-/
theorem SR_no_psd_realization_preserving_raw_form (X : Nat) (hX : 6 ≤ X)
    (P : (Fin (X - 2) → ℝ) → ℝ)
    (hP : ∀ v, 0 ≤ P v)
    (hEq : ∀ v, P v = SR_quadratic_form X v) : False := by
  obtain ⟨v, hv⟩ := SR_form_has_negative_direction X hX
  have hPv : 0 ≤ P v := hP v
  rw [hEq v] at hPv
  exact (not_lt_of_ge hPv) hv

theorem SR_global_coercivity_false :
    ¬ (∀ X : Nat, 6 ≤ X → ∀ v : Fin (X - 2) → ℝ,
      0 ≤ SR_quadratic_form X v) := by
  intro h
  exact SR_form_not_positive_semidefinite 6 (by omega) (h 6 (by omega))

theorem SR_form_is_indefinite_of_positive (X : Nat) (hX : 6 ≤ X)
    (hpos : ∃ v : Fin (X - 2) → ℝ, 0 < SR_quadratic_form X v) :
    (∃ v : Fin (X - 2) → ℝ, 0 < SR_quadratic_form X v) ∧
      (∃ v : Fin (X - 2) → ℝ, SR_quadratic_form X v < 0) := by
  exact ⟨hpos, SR_form_has_negative_direction X hX⟩


theorem SR_X6_negative_basis_witness :
    SR_quadratic_form 6 (fun i : Fin 4 => if i = 0 then 1 else 0) < 0 := by
  norm_num [SR_quadratic_form, completeSupport, reesEntryFromNat,
    Fin.sum_univ_succ]

theorem SR_allones_quadratic_X6 :
    SR_quadratic_form 6 (SR_allones_vector 6) = 14 := by
  norm_num [SR_quadratic_form, SR_allones_vector, completeSupport,
    reesEntryFromNat, Fin.sum_univ_succ]

theorem SR_X6_indefinite :
    (∃ v : Fin 4 → ℝ, 0 < SR_quadratic_form 6 v) ∧
      (∃ v : Fin 4 → ℝ, SR_quadratic_form 6 v < 0) := by
  constructor
  · refine ⟨SR_allones_vector 6, ?_⟩
    rw [SR_allones_quadratic_X6]
    norm_num
  · exact ⟨(fun i : Fin 4 => if i = 0 then 1 else 0),
      SR_X6_negative_basis_witness⟩

def SR_uniform_X6 (v : Fin 4 → ℝ) : Prop :=
  ∃ c : ℝ, ∀ i, v i = c

theorem SR_uniform_X6_formula (c : ℝ) :
    SR_quadratic_form 6 (fun _ : Fin 4 => c) = 14 * c ^ 2 := by
  simp only [SR_quadratic_form]
  norm_num [completeSupport, reesEntryFromNat, Fin.sum_univ_succ]
  ring

theorem SR_uniform_X6_positive (v : Fin 4 → ℝ) (hv : SR_uniform_X6 v) :
    0 ≤ SR_quadratic_form 6 v := by
  obtain ⟨c, hc⟩ := hv
  have hfun : v = (fun _ : Fin 4 => c) := by
    funext i
    exact hc i
  subst v
  rw [SR_uniform_X6_formula]
  nlinarith [sq_nonneg c]

theorem SR_uniform_X6_strict (c : ℝ) (hc : c ≠ 0) :
    0 < SR_quadratic_form 6 (fun _ : Fin 4 => c) := by
  rw [SR_uniform_X6_formula]
  have hsq : 0 < c ^ 2 := sq_pos_of_ne_zero hc
  nlinarith

/- The concrete X=6 witness is retained as an open computational target:
the vector notation reduces the goal to `False` under the current
normalization, so an explicit index-by-index witness proof is still needed. -/

end SR
/- End archived legacy module. -/
/- End nested legacy comment. -/
/- close -/
/- close -/
/- close -/
/- close -/
/- close -/
