import SR_Stage31
import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.LinearAlgebra.Matrix.Block
import Mathlib.Data.Finset.Sort

namespace SR

theorem SR_finset_orderEmbOfFin_strictMono (s : Finset Nat) :
    StrictMono (s.orderEmbOfFin (rfl : s.card = s.card)) := by
  exact (s.orderEmbOfFin (rfl : s.card = s.card)).strictMono

def SR_prefix_matrix (k : Nat) : Matrix (Fin k) (Fin k) ℚ :=
  fun i j => if j ≤ i then 1 else 0

theorem SR_prefix_matrix_det (k : Nat) : (SR_prefix_matrix k).det = 1 := by
  rw [Matrix.det_of_lowerTriangular (SR_prefix_matrix k)]
  · simp [SR_prefix_matrix]
  intro i j hij
  simp only [SR_prefix_matrix]
  by_cases hji : j ≤ i
  · have : ¬ i < j := by omega
    exact False.elim (this hij)
  · simp [hji]

theorem SR_prefix_matrix_linearIndependent (k : Nat) :
    LinearIndependent ℚ (SR_prefix_matrix k).row := by
  change LinearIndependent ℚ (fun i => SR_prefix_matrix k i)
  exact Matrix.linearIndependent_rows_of_det_ne_zero (by
    rw [SR_prefix_matrix_det k]
    norm_num)

def SR_threshold_matrix {k : Nat} (t : Fin k → Nat) : Matrix (Fin k) (Fin k) ℚ :=
  fun i j => if t j ≤ t i then 1 else 0

theorem SR_threshold_matrix_det {k : Nat} (t : Fin k → Nat)
    (ht : StrictMono t) : (SR_threshold_matrix t).det = 1 := by
  rw [Matrix.det_of_lowerTriangular (SR_threshold_matrix t)]
  · simp [SR_threshold_matrix]
  intro i j hij
  simp only [SR_threshold_matrix]
  have hlt : t i < t j := ht hij
  simp [Nat.not_le_of_gt hlt]

theorem SR_threshold_matrix_linearIndependent {k : Nat} (t : Fin k → Nat)
    (ht : StrictMono t) :
    LinearIndependent ℚ (SR_threshold_matrix t).row := by
  change LinearIndependent ℚ (fun i => SR_threshold_matrix t i)
  exact Matrix.linearIndependent_rows_of_det_ne_zero (by
    rw [SR_threshold_matrix_det t ht]
    norm_num)

def SR_signed_threshold_base {n : Nat} : Matrix (Fin (n + 1)) (Fin (n + 1)) ℚ :=
  fun i j => if i = 0 then if j = 0 then -1 else 1 else if i = j then -2 else 0

theorem SR_signed_threshold_base_det (n : Nat) :
    (SR_signed_threshold_base : Matrix (Fin (n + 1)) (Fin (n + 1)) ℚ).det =
      (-1 : ℚ) * (-2) ^ n := by
  rw [Matrix.det_of_upperTriangular]
  · rw [Fin.prod_univ_succ]
    simp [SR_signed_threshold_base]
  intro i j hij
  simp only [SR_signed_threshold_base]
  by_cases hi : i = 0
  · subst i
    have hfalse : ¬j.1 < 0 := Nat.not_lt_zero _
    exact (hfalse hij).elim
  · simp [hi]
    intro heq
    subst i
    exact (lt_irrefl _ hij).elim

lemma SR_fin_succ_le_of_not_le {n : Nat} (i : Fin n) (j : Fin (n + 1))
    (h : ¬ j ≤ i.castSucc) : i.succ ≤ j := by
  apply Fin.le_iff_val_le_val.mpr
  have h' : ¬ j.1 ≤ i.1 := by
    intro hj
    apply h
    exact Fin.le_iff_val_le_val.mpr hj
  have hlt : i.1 < j.1 := Nat.lt_of_not_ge h'
  change i.1 + 1 ≤ j.1
  omega

def SR_signed_threshold_matrix {k : Nat} (t : Fin k → Nat) :
    Matrix (Fin k) (Fin k) ℚ :=
  fun i j => if t j ≤ t i then -1 else 1

/-!
Stage 38: intrinsic structure of the signed threshold matrix.

IMPORTANT:
These theorems concern `SR_signed_threshold_matrix`, the ordered
threshold representative matrix.
They do NOT assert the same identity for `SR_rees_matrix`.
-/

theorem SR_threshold_matrix_sym_add_self
    (n : Nat)
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) :
    SR_signed_threshold_matrix t +
        (SR_signed_threshold_matrix t).transpose
      =
      (-2 : ℚ) • (1 : Matrix (Fin (n + 1)) (Fin (n + 1)) ℚ) := by
  ext i j
  simp only [
    SR_signed_threshold_matrix,
    Matrix.add_apply,
    Matrix.transpose_apply,
    Matrix.smul_apply,
    Matrix.one_apply,
  ]
  by_cases hij : i = j
  · subst hij
    simp; norm_num
  · have hneq : t i ≠ t j := by
      intro hEq
      apply hij
      exact ht.injective hEq
    by_cases hji : t j ≤ t i
    · have hij_lt : t j < t i := lt_of_le_of_ne hji (Ne.symm hneq)
      have h_not : ¬ t i ≤ t j := not_le_of_gt hij_lt
      simp [hji, h_not, hij]
    · have hij_lt : t i < t j := Nat.lt_of_not_ge hji
      have h_ij : t i ≤ t j := Nat.le_of_lt hij_lt
      simp [hji, h_ij, hij]

theorem SR_threshold_matrix_symm_part
    (n : Nat)
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) :
    ((1 / 2 : ℚ) •
        (SR_signed_threshold_matrix t +
          (SR_signed_threshold_matrix t).transpose))
      =
      (-1 : ℚ) •
        (1 : Matrix (Fin (n + 1)) (Fin (n + 1)) ℚ) := by
  rw [SR_threshold_matrix_sym_add_self n t ht]
  module

def SR_threshold_matrix_skew
    {n : Nat}
    (t : Fin (n + 1) → Nat) :
    Matrix (Fin (n + 1)) (Fin (n + 1)) ℚ :=
  (1 / 2 : ℚ) •
    (SR_signed_threshold_matrix t -
      (SR_signed_threshold_matrix t).transpose)

theorem SR_threshold_matrix_skew_transpose
    (n : Nat)
    (t : Fin (n + 1) → Nat) :
    (SR_threshold_matrix_skew t).transpose
      =
      - SR_threshold_matrix_skew t := by
  simp [SR_threshold_matrix_skew, Matrix.transpose_sub]
  module

theorem SR_threshold_matrix_eq_neg_one_add_skew
    (n : Nat)
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) :
    SR_signed_threshold_matrix t
      =
      (-1 : ℚ) •
        (1 : Matrix (Fin (n + 1)) (Fin (n + 1)) ℚ)
      +
      SR_threshold_matrix_skew t := by
  ext i j
  simp only [SR_threshold_matrix_skew, SR_signed_threshold_matrix,
             Matrix.add_apply, Matrix.sub_apply, Matrix.smul_apply,
             Matrix.one_apply, Matrix.transpose_apply]
  by_cases hij : i = j
  · subst hij; simp
  · by_cases hji : t j ≤ t i
    · have hlt : t j < t i :=
        lt_of_le_of_ne hji (Ne.symm (fun h => hij (ht.injective h)))
      have h_not : ¬ t i ≤ t j := not_le_of_gt hlt
      simp [hji, h_not, hij]; norm_num
    · have h_ij : t i ≤ t j := Nat.le_of_lt (Nat.lt_of_not_ge hji)
      simp [hji, h_ij, hij]; norm_num

theorem SR_threshold_matrix_quadratic_form
    (n : Nat)
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t)
    (x : Fin (n + 1) → ℚ) :
    ∑ i : Fin (n + 1), x i * ∑ j : Fin (n + 1),
        SR_signed_threshold_matrix t i j * x j
      = - Finset.univ.sum (fun i => x i ^ 2) := by
  have hentry : ∀ i j : Fin (n + 1),
      SR_signed_threshold_matrix t i j + SR_signed_threshold_matrix t j i =
      if i = j then (-2 : ℚ) else 0 := by
    intro i j
    have h : (SR_signed_threshold_matrix t + (SR_signed_threshold_matrix t).transpose) i j =
             ((-2 : ℚ) • (1 : Matrix _ _ ℚ)) i j :=
      congrFun (congrFun (SR_threshold_matrix_sym_add_self n t ht) i) j
    simp only [Matrix.add_apply, Matrix.transpose_apply, Matrix.smul_apply,
               Matrix.one_apply] at h
    by_cases hij : i = j
    · simp [hij] at h ⊢; linarith
    · simp [hij] at h ⊢; linarith
  have hQ : ∑ i : Fin (n + 1), x i * ∑ j, SR_signed_threshold_matrix t i j * x j
      = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
            x i * SR_signed_threshold_matrix t i j * x j := by
    apply Finset.sum_congr rfl; intro i _
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl; intro j _; ring
  rw [hQ]
  have hswap : ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
          x i * SR_signed_threshold_matrix t i j * x j
      = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
            x j * SR_signed_threshold_matrix t j i * x i := by
    rw [Finset.sum_comm]
  have h2Q : 2 * ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
          x i * SR_signed_threshold_matrix t i j * x j
      = -2 * Finset.univ.sum (fun i => x i ^ 2) :=
    calc 2 * ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * SR_signed_threshold_matrix t i j * x j
        = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * SR_signed_threshold_matrix t i j * x j +
          ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x j * SR_signed_threshold_matrix t j i * x i := by linarith [hswap]
      _ = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              (x i * SR_signed_threshold_matrix t i j * x j +
               x j * SR_signed_threshold_matrix t j i * x i) := by
              simp_rw [← Finset.sum_add_distrib]
      _ = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * x j * (SR_signed_threshold_matrix t i j +
                            SR_signed_threshold_matrix t j i) := by
              congr 1; ext i; congr 1; ext j; ring
      _ = ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * x j * if i = j then (-2 : ℚ) else 0 := by
              simp_rw [hentry]
      _ = -2 * Finset.univ.sum (fun i => x i ^ 2) := by
              simp_rw [mul_ite, mul_zero]
              simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
              simp_rw [show ∀ i : Fin (n + 1),
                  x i * x i * (-2 : ℚ) = (-2 : ℚ) * x i ^ 2 from fun i => by ring]
              rw [← Finset.mul_sum]
  linarith

theorem SR_threshold_matrix_mulVec_eq_zero
    (n : Nat)
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t)
    (x : Fin (n + 1) → ℚ)
    (hx : Matrix.mulVec (SR_signed_threshold_matrix t) x = 0) :
    x = 0 := by
  have hall : ∀ i : Fin (n + 1),
      ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * x j = 0 := by
    intro i
    have := congrFun hx i
    simp only [Matrix.mulVec, Pi.zero_apply] at this
    exact this
  have hq := SR_threshold_matrix_quadratic_form n t ht x
  have hzero_q : ∑ i : Fin (n + 1), x i *
      ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * x j = 0 := by
    apply Finset.sum_eq_zero; intro i _; rw [hall i, mul_zero]
  rw [hzero_q] at hq
  have hsquares : Finset.univ.sum (fun i => x i ^ 2) = 0 := by linarith
  apply funext; intro i
  have hxi : x i ^ 2 = 0 := by
    have hle : x i ^ 2 ≤ Finset.univ.sum (fun j => x j ^ 2) :=
      Finset.single_le_sum (fun j _ => sq_nonneg (x j)) (Finset.mem_univ i)
    linarith [sq_nonneg (x i)]
  exact sq_eq_zero_iff.mp hxi

theorem SR_threshold_matrix_mulVec_injective
    (n : Nat)
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) :
    Function.Injective
      (Matrix.mulVec (SR_signed_threshold_matrix t)) := by
  intro x y hxy
  rw [← sub_eq_zero]
  apply SR_threshold_matrix_mulVec_eq_zero n t ht (x - y)
  funext i
  have hi := congrFun hxy i
  show ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * (x j - y j) = 0
  calc ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * (x j - y j)
      = ∑ j : Fin (n + 1), (SR_signed_threshold_matrix t i j * x j -
                             SR_signed_threshold_matrix t i j * y j) := by
          congr 1; ext j; ring
    _ = ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * x j -
        ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * y j := by
          rw [Finset.sum_sub_distrib]
    _ = 0 := by
          have heq : ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * x j =
                     ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * y j :=
            congrFun hxy i
          linarith

theorem SR_signed_threshold_row_relation {n : Nat} (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) (i : Fin n) (j : Fin (n + 1)) :
    SR_signed_threshold_matrix t i.succ j =
      SR_signed_threshold_base i.succ j +
        SR_signed_threshold_matrix t i.castSucc j := by
  by_cases hji : j ≤ i.castSucc
  · have h1 : t j ≤ t i.castSucc := ht.monotone hji
    have h2 : t i.castSucc < t i.succ := ht Fin.castSucc_lt_succ
    have hjs : t j ≤ t i.succ := h1.trans h2.le
    have hnot : ¬t i.castSucc < t j := not_lt_of_ge h1
    have hne : i.succ ≠ j := by
      intro heq
      subst j
      exact (not_le_of_gt Fin.castSucc_lt_succ) hji
    simp [SR_signed_threshold_matrix, SR_signed_threshold_base, hjs, hne, hnot]
  · have hsucc := SR_fin_succ_le_of_not_le i j hji
    have h2 : t i.castSucc < t i.succ := ht Fin.castSucc_lt_succ
    by_cases heq : j = i.succ
    · subst j
      simp [SR_signed_threshold_matrix, SR_signed_threshold_base,
        Nat.not_le_of_gt h2]
      norm_num
    · have hlt : t i.succ < t j := ht (lt_of_le_of_ne hsucc (Ne.symm heq))
      have hprev : ¬t j ≤ t i.castSucc := by
        exact Nat.not_le_of_gt (h2.trans hlt)
      have hne : i.succ ≠ j := fun h => heq h.symm
      simp [SR_signed_threshold_matrix, SR_signed_threshold_base,
        Nat.not_le_of_gt hlt, hprev, hne]

theorem SR_signed_threshold_matrix_det {n : Nat} (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) :
    (SR_signed_threshold_matrix t).det = (-1 : ℚ) * (-2) ^ n := by
  rw [Matrix.det_eq_of_forall_row_eq_smul_add_pred (fun _ : Fin n => 1)]
  · exact SR_signed_threshold_base_det n
  · intro j
    refine Fin.cases ?_ (fun j => ?_) j
    · simp [SR_signed_threshold_matrix, SR_signed_threshold_base]
    · have hpos : (0 : Fin (n + 1)) < j.succ := by
        apply Fin.mk_lt_mk.mpr
        change 0 < j.1 + 1
        omega
      have hlt : t 0 < t j.succ := ht hpos
      simp [SR_signed_threshold_matrix, SR_signed_threshold_base,
        Nat.not_le_of_gt hlt]
  · intro i j
    simpa using SR_signed_threshold_row_relation t ht i j

theorem SR_signed_threshold_matrix_linearIndependent {n : Nat}
    (t : Fin (n + 1) → Nat) (ht : StrictMono t) :
    LinearIndependent ℚ (SR_signed_threshold_matrix t).row := by
  change LinearIndependent ℚ (fun i => SR_signed_threshold_matrix t i)
  apply Matrix.linearIndependent_rows_of_det_ne_zero
  rw [SR_signed_threshold_matrix_det t ht]
  norm_num

def SR_quotient_count (X : Nat) : Nat :=
  ((completeSupport X).toFinset.image (fun m => (X - 1) / m)).card

def SR_threshold_set (X : Nat) : Finset Nat :=
  (completeSupport X).toFinset.image (fun m => (X - 1) / m)

theorem SR_threshold_set_card (X : Nat) :
    (SR_threshold_set X).card = SR_quotient_count X := by
  rfl

theorem SR_threshold_set_ordered_range (X : Nat) :
    Set.range ((SR_threshold_set X).orderEmbOfFin
      (rfl : (SR_threshold_set X).card = (SR_threshold_set X).card)) =
      (SR_threshold_set X : Set Nat) := by
  simpa using (Finset.range_orderEmbOfFin (SR_threshold_set X)
    (rfl : (SR_threshold_set X).card = (SR_threshold_set X).card))

noncomputable def SR_threshold_rep (X : Nat) (q : SR_threshold_set X) : Nat :=
  Classical.choose (Finset.mem_image.mp q.property)

theorem SR_threshold_rep_quotient (X : Nat) (q : SR_threshold_set X) :
    (X - 1) / SR_threshold_rep X q = q.1 := by
  exact (Classical.choose_spec (Finset.mem_image.mp q.property)).2

def SR_rees_matrix (X : Nat) : Matrix (Fin (X - 2)) (Fin (X - 2)) ℚ :=
  fun i j => if (i.1 + 2) * (j.1 + 2) < X then -1 else 1

theorem SR_rees_matrix_entry_threshold (X : Nat) (i j : Fin (X - 2)) :
    SR_rees_matrix X i j =
      if j.1 + 2 ≤ (X - 1) / (i.1 + 2) then (-1 : ℚ) else 1 := by
  unfold SR_rees_matrix
  by_cases h : (i.1 + 2) * (j.1 + 2) < X
  · have hle : (i.1 + 2) * (j.1 + 2) ≤ X - 1 := by omega
    have hq : j.1 + 2 ≤ (X - 1) / (i.1 + 2) := by
      apply (Nat.le_div_iff_mul_le (by omega : 0 < i.1 + 2)).2
      simpa [Nat.mul_comm] using hle
    simp [h, hq]

  · have hle : X ≤ (i.1 + 2) * (j.1 + 2) := by omega
    have hq : ¬ j.1 + 2 ≤ (X - 1) / (i.1 + 2) := by
      intro hq
      have hprod : (i.1 + 2) * (j.1 + 2) ≤ X - 1 := by
        have := (Nat.le_div_iff_mul_le (by omega : 0 < i.1 + 2)).1 hq
        simpa [Nat.mul_comm] using this
      omega
    simp [h, hq]

theorem SR_rees_matrix_row_eq_of_quotient_eq
    (X : Nat) (i j : Fin (X - 2))
    (h : (X - 1) / (i.1 + 2) = (X - 1) / (j.1 + 2)) :
    SR_rees_matrix X i = SR_rees_matrix X j := by
  funext k
  rw [SR_rees_matrix_entry_threshold, SR_rees_matrix_entry_threshold, h]

theorem SR_rees_matrix_quotient_eq_of_row_eq
    (X : Nat) (hX : 6 ≤ X) (i j : Fin (X - 2))
    (h : SR_rees_matrix X i = SR_rees_matrix X j) :
    (X - 1) / (i.1 + 2) = (X - 1) / (j.1 + 2) := by
  let qi := (X - 1) / (i.1 + 2)
  let qj := (X - 1) / (j.1 + 2)
  by_contra hne
  rcases lt_or_gt_of_ne hne with hlt | hgt
  · let k : Fin (X - 2) := ⟨qi - 1, by
      have hqi : 1 ≤ qi := by
        dsimp [qi]
        apply (Nat.le_div_iff_mul_le (by omega : 0 < i.1 + 2)).2
        have hi : i.1 + 2 ≤ X - 1 := by omega
        simpa [Nat.mul_comm] using hi
      have hqj : qj ≤ X - 1 := by
        dsimp [qj]
        exact Nat.div_le_self _ _
      have hqilt : qi < X - 1 := lt_of_lt_of_le hlt hqj
      omega⟩
    have hk : k.1 + 2 = qi + 1 := by
      dsimp [k]
      have hqi : 1 ≤ qi := by
        dsimp [qi]
        apply (Nat.le_div_iff_mul_le (by omega : 0 < i.1 + 2)).2
        have hi : i.1 + 2 ≤ X - 1 := by omega
        simpa [Nat.mul_comm] using hi
      omega
    have hi := congrFun h k
    rw [SR_rees_matrix_entry_threshold, SR_rees_matrix_entry_threshold, hk] at hi
    simp [qi, qj, hlt] at hi
    norm_num at hi
  · let k : Fin (X - 2) := ⟨qj - 1, by
      have hqj1 : 1 ≤ qj := by
        dsimp [qj]
        apply (Nat.le_div_iff_mul_le (by omega : 0 < j.1 + 2)).2
        have hj : j.1 + 2 ≤ X - 1 := by omega
        simpa [Nat.mul_comm] using hj
      have hqilt : qi ≤ X - 1 := by
        dsimp [qi]
        exact Nat.div_le_self _ _
      have hqjlt : qj < X - 1 := lt_of_lt_of_le hgt hqilt
      omega⟩
    have hk : k.1 + 2 = qj + 1 := by
      dsimp [k]
      have hqj1 : 1 ≤ qj := by
        dsimp [qj]
        apply (Nat.le_div_iff_mul_le (by omega : 0 < j.1 + 2)).2
        have hj : j.1 + 2 ≤ X - 1 := by omega
        simpa [Nat.mul_comm] using hj
      omega
    have hi := congrFun h k
    rw [SR_rees_matrix_entry_threshold, SR_rees_matrix_entry_threshold, hk] at hi
    simp [qi, qj, hgt] at hi
    norm_num at hi

theorem SR_rees_matrix_row_eq_iff_quotient_eq
    (X : Nat) (hX : 6 ≤ X) (i j : Fin (X - 2)) :
    SR_rees_matrix X i = SR_rees_matrix X j ↔
      (X - 1) / (i.1 + 2) = (X - 1) / (j.1 + 2) := by
  constructor
  · exact SR_rees_matrix_quotient_eq_of_row_eq X hX i j
  · exact SR_rees_matrix_row_eq_of_quotient_eq X i j

theorem SR_rees_matrix_X7_entries :
    SR_rees_matrix 7 = !![ -1, -1, 1, 1, 1;
                            -1, 1, 1, 1, 1;
                             1, 1, 1, 1, 1;
                             1, 1, 1, 1, 1;
                             1, 1, 1, 1, 1 ] := by
  funext i j
  fin_cases i <;> fin_cases j <;> norm_num [SR_rees_matrix]

def SR_x7_core : Matrix (Fin 3) (Fin 5) ℚ :=
  !![ -1, -1, 1, 1, 1;
      -1, 1, 1, 1, 1;
       1, 1, 1, 1, 1 ]

theorem SR_x7_core_rows_linearIndependent :
    LinearIndependent ℚ SR_x7_core.row := by
  rw [Fintype.linearIndependent_iff]
  intro g hg
  intro i
  have h0 := congrFun hg (0 : Fin 5)
  have h1 := congrFun hg (1 : Fin 5)
  have h2 := congrFun hg (2 : Fin 5)
  fin_cases i <;>
    simp [SR_x7_core, Fin.sum_univ_succ] at h0 h1 h2 ⊢ <;>
    linarith

theorem SR_x7_core_rank : SR_x7_core.rank = 3 := by
  exact SR_x7_core_rows_linearIndependent.rank_matrix

theorem SR_quotient_count_X6 : SR_quotient_count 6 = 2 := by
  native_decide

theorem SR_quotient_count_X7 : SR_quotient_count 7 = 3 := by
  native_decide

theorem SR_quotient_count_X10 : SR_quotient_count 10 = 4 := by
  native_decide

theorem SR_quotient_count_X30 : SR_quotient_count 30 = 8 := by
  native_decide

def SR_rees_threshold_row (X q : Nat) : Fin (X - 2) → ℚ :=
  fun j => if j.1 + 2 ≤ q then (-1 : ℚ) else 1

lemma SR_rees_threshold_row_diff
    (X q₁ q₂ : Nat) (hq : q₁ < q₂) (j : Fin (X - 2)) :
    SR_rees_threshold_row X q₂ j - SR_rees_threshold_row X q₁ j =
    if q₁ < j.1 + 2 ∧ j.1 + 2 ≤ q₂ then (-2 : ℚ) else 0 := by
  by_cases h₁ : j.1 + 2 ≤ q₁
  · have h₂ : j.1 + 2 ≤ q₂ := le_trans h₁ hq.le
    simp [SR_rees_threshold_row, h₁, h₂]
  · by_cases h₂ : j.1 + 2 ≤ q₂
    · have h₁' : q₁ < j.1 + 2 := Nat.lt_of_not_ge h₁
      simp [SR_rees_threshold_row, h₁, h₂, h₁']; norm_num
    · simp [SR_rees_threshold_row, h₁, h₂]

lemma SR_rees_row_eq_threshold_row (X : Nat) (hX : 6 ≤ X)
    (m : Fin (X - 2)) :
    (SR_rees_matrix X).row m =
      SR_rees_threshold_row X ((X - 1) / (m.1 + 2)) := by
  funext n
  show SR_rees_matrix X m n = SR_rees_threshold_row X ((X - 1) / (m.1 + 2)) n
  rw [SR_rees_matrix_entry_threshold]
  rfl

lemma SR_threshold_rep_mem (X : Nat) (q : SR_threshold_set X) :
    SR_threshold_rep X q ∈ completeSupport X :=
  List.mem_toFinset.mp (Classical.choose_spec (Finset.mem_image.mp q.property)).1

lemma SR_threshold_rep_lt (X : Nat) (q : SR_threshold_set X) :
    SR_threshold_rep X q - 2 < X - 2 := by
  have hm := completeSupport_mem_bounds (SR_threshold_rep_mem X q)
  omega

/-
The intended proof of the next theorem is the nested-threshold argument:
the quotient representatives are pairwise distinct threshold values, and
successive row differences have disjoint supports.  One convenient final
step is to package the rows into a square threshold matrix and apply
`Matrix.linearIndependent_rows_of_det_ne_zero`; the remaining missing
lemma is the corresponding determinant computation for the non-uniform
quotient thresholds (equivalently, the unitriangular form obtained from
the base row together with the successive difference rows).
-/
theorem SR_rees_quotient_rows_linearIndependent
    (X : Nat) (hX : 6 ≤ X) :
    LinearIndependent ℚ
      (fun q : SR_threshold_set X =>
        (SR_rees_matrix X).row
          ⟨SR_threshold_rep X q - 2, SR_threshold_rep_lt X q⟩) := by
  -- OPEN: Linear independence of quotient representative rows.
  -- Mathematical proof: consecutive threshold rows have differences
  -- supported on disjoint intervals (q_{i-1}, q_i], giving
  -- independence via the column evaluation argument:
  -- E(q₀+1) - E(q₀) = -2·g(q₀) = 0 for q₀.1 ≥ 2
  -- E(2) + E(X-1) = 2·g(q₀) = 0 for q₀.1 = 1
  -- Missing: clean Lean formulation of Finset sum splitting
  -- over SR_threshold_set X subtype.
  sorry

/-
For the upper bound, the already-proved row-equivalence theorem
`SR_rees_matrix_row_eq_iff_quotient_eq` shows that every row belongs to
one of the quotient classes represented by `SR_threshold_rep`.  The lower
bound is the cardinality/rank consequence of
`SR_rees_quotient_rows_linearIndependent`; once the corresponding span
bound is supplied, `LinearIndependent.rank_matrix` is the Mathlib theorem
that converts the independent representative-row family into the required
rank lower bound.
-/
theorem SR_rees_rank_eq_quotient_count (X : Nat) (hX : 6 ≤ X) :
    (SR_rees_matrix X).rank = SR_quotient_count X := by
  -- OPEN: Depends on sorry 1 for lower bound.
  -- Upper bound available via row equivalence theorem.
  -- Lower bound: SR_rees_quotient_rows_linearIndependent (sorry 1).
  sorry

end SR
