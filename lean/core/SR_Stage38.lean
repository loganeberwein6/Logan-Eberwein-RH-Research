import lean.core.SR_Stage31
import Mathlib.LinearAlgebra.Matrix.Rank
import Mathlib.LinearAlgebra.Matrix.Block
import Mathlib.Data.Finset.Sort

namespace SR

open scoped BigOperators

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
    simp
    norm_num
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
  · subst hij
    simp
  · by_cases hji : t j ≤ t i
    · have hlt : t j < t i :=
        lt_of_le_of_ne hji (Ne.symm (fun h => hij (ht.injective h)))
      have h_not : ¬ t i ≤ t j := not_le_of_gt hlt
      simp [hji, h_not, hij]
      norm_num
    · have h_ij : t i ≤ t j := Nat.le_of_lt (Nat.lt_of_not_ge hji)
      simp [hji, h_ij, hij]
      norm_num

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
    have h :
        (SR_signed_threshold_matrix t +
            (SR_signed_threshold_matrix t).transpose) i j =
          ((-2 : ℚ) • (1 : Matrix _ _ ℚ)) i j :=
      congrFun (congrFun (SR_threshold_matrix_sym_add_self n t ht) i) j
    simp only [Matrix.add_apply, Matrix.transpose_apply, Matrix.smul_apply,
      Matrix.one_apply] at h
    by_cases hij : i = j
    · simp [hij] at h ⊢
      linarith
    · simp [hij] at h ⊢
      linarith

  have hQ :
      ∑ i : Fin (n + 1), x i *
          ∑ j, SR_signed_threshold_matrix t i j * x j
        =
      ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
          x i * SR_signed_threshold_matrix t i j * x j := by
    apply Finset.sum_congr rfl
    intro i _
    rw [Finset.mul_sum]
    apply Finset.sum_congr rfl
    intro j _
    ring

  rw [hQ]

  have hswap :
      ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
          x i * SR_signed_threshold_matrix t i j * x j
        =
      ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
          x j * SR_signed_threshold_matrix t j i * x i := by
    rw [Finset.sum_comm]

  have h2Q :
      2 * ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
          x i * SR_signed_threshold_matrix t i j * x j
        =
      -2 * Finset.univ.sum (fun i => x i ^ 2) :=
    calc
      2 * ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * SR_signed_threshold_matrix t i j * x j
        =
          ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * SR_signed_threshold_matrix t i j * x j +
          ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x j * SR_signed_threshold_matrix t j i * x i := by
                linarith [hswap]
      _ =
          ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              (x i * SR_signed_threshold_matrix t i j * x j +
               x j * SR_signed_threshold_matrix t j i * x i) := by
                simp_rw [← Finset.sum_add_distrib]
      _ =
          ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * x j *
                (SR_signed_threshold_matrix t i j +
                 SR_signed_threshold_matrix t j i) := by
                congr 1
                ext i
                congr 1
                ext j
                ring
      _ =
          ∑ i : Fin (n + 1), ∑ j : Fin (n + 1),
              x i * x j * if i = j then (-2 : ℚ) else 0 := by
                simp_rw [hentry]
      _ = -2 * Finset.univ.sum (fun i => x i ^ 2) := by
                simp_rw [mul_ite, mul_zero]
                simp only [Finset.sum_ite_eq, Finset.mem_univ, if_true]
                simp_rw [show ∀ i : Fin (n + 1),
                    x i * x i * (-2 : ℚ) = (-2 : ℚ) * x i ^ 2
                  from fun i => by ring]
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
    have hi := congrFun hx i
    simp only [Matrix.mulVec, Pi.zero_apply] at hi
    exact hi

  have hq := SR_threshold_matrix_quadratic_form n t ht x

  have hzero_q :
      ∑ i : Fin (n + 1), x i *
          ∑ j : Fin (n + 1), SR_signed_threshold_matrix t i j * x j = 0 := by
    apply Finset.sum_eq_zero
    intro i _
    rw [hall i, mul_zero]

  rw [hzero_q] at hq

  have hsquares :
      Finset.univ.sum (fun i => x i ^ 2) = 0 := by
    linarith

  apply funext
  intro i

  have hxi : x i ^ 2 = 0 := by
    have hle :
        x i ^ 2 ≤ Finset.univ.sum (fun j => x j ^ 2) :=
      Finset.single_le_sum
        (fun j _ => sq_nonneg (x j))
        (Finset.mem_univ i)
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
  show
    ∑ j : Fin (n + 1),
        SR_signed_threshold_matrix t i j * (x j - y j) = 0
  calc
    ∑ j : Fin (n + 1),
        SR_signed_threshold_matrix t i j * (x j - y j)
      =
        ∑ j : Fin (n + 1),
          (SR_signed_threshold_matrix t i j * x j -
            SR_signed_threshold_matrix t i j * y j) := by
              congr 1
              ext j
              ring
    _ =
        ∑ j : Fin (n + 1),
            SR_signed_threshold_matrix t i j * x j -
          ∑ j : Fin (n + 1),
            SR_signed_threshold_matrix t i j * y j := by
          rw [Finset.sum_sub_distrib]
    _ = 0 := by
          have heq :
              ∑ j : Fin (n + 1),
                  SR_signed_threshold_matrix t i j * x j =
                ∑ j : Fin (n + 1),
                  SR_signed_threshold_matrix t i j * y j :=
            congrFun hxy i
          linarith

theorem SR_signed_threshold_row_relation {n : Nat}
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t)
    (i : Fin n)
    (j : Fin (n + 1)) :
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
    · have hlt :
          t i.succ < t j :=
        ht (lt_of_le_of_ne hsucc (Ne.symm heq))
      have hprev : ¬t j ≤ t i.castSucc := by
        exact Nat.not_le_of_gt (h2.trans hlt)
      have hne : i.succ ≠ j := fun h => heq h.symm
      simp [SR_signed_threshold_matrix, SR_signed_threshold_base,
        Nat.not_le_of_gt hlt, hprev, hne]

theorem SR_signed_threshold_matrix_det
    {n : Nat}
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) :
    (SR_signed_threshold_matrix t).det =
      (-1 : ℚ) * (-2) ^ n := by
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
    (t : Fin (n + 1) → Nat)
    (ht : StrictMono t) :
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
  simpa using
    (Finset.range_orderEmbOfFin
      (SR_threshold_set X)
      (rfl : (SR_threshold_set X).card = (SR_threshold_set X).card))

noncomputable def SR_threshold_rep (X : Nat) (q : SR_threshold_set X) : Nat :=
  Classical.choose (Finset.mem_image.mp q.property)

theorem SR_threshold_rep_quotient (X : Nat) (q : SR_threshold_set X) :
    (X - 1) / SR_threshold_rep X q = q.1 := by
  exact (Classical.choose_spec (Finset.mem_image.mp q.property)).2

def SR_rees_matrix (X : Nat) :
    Matrix (Fin (X - 2)) (Fin (X - 2)) ℚ :=
  fun i j => if (i.1 + 2) * (j.1 + 2) < X then -1 else 1

theorem SR_rees_matrix_entry_threshold
    (X : Nat)
    (i j : Fin (X - 2)) :
    SR_rees_matrix X i j =
      if j.1 + 2 ≤ (X - 1) / (i.1 + 2) then
        (-1 : ℚ)
      else
        1 := by
  unfold SR_rees_matrix
  by_cases h : (i.1 + 2) * (j.1 + 2) < X
  · have hle : (i.1 + 2) * (j.1 + 2) ≤ X - 1 := by
      omega
    have hq : j.1 + 2 ≤ (X - 1) / (i.1 + 2) := by
      apply (Nat.le_div_iff_mul_le (by omega : 0 < i.1 + 2)).2
      simpa [Nat.mul_comm] using hle
    simp [h, hq]
  · have hle : X ≤ (i.1 + 2) * (j.1 + 2) := by
      omega
    have hq : ¬ j.1 + 2 ≤ (X - 1) / (i.1 + 2) := by
      intro hq
      have hprod :
          (i.1 + 2) * (j.1 + 2) ≤ X - 1 := by
        have hprod' :=
          (Nat.le_div_iff_mul_le (by omega : 0 < i.1 + 2)).1 hq
        simpa [Nat.mul_comm] using hprod'
      omega
    simp [h, hq]

theorem SR_rees_matrix_row_eq_of_quotient_eq
    (X : Nat)
    (i j : Fin (X - 2))
    (h : (X - 1) / (i.1 + 2) = (X - 1) / (j.1 + 2)) :
    SR_rees_matrix X i = SR_rees_matrix X j := by
  funext k
  rw [SR_rees_matrix_entry_threshold,
    SR_rees_matrix_entry_threshold, h]

theorem SR_rees_matrix_quotient_eq_of_row_eq
    (X : Nat)
    (hX : 6 ≤ X)
    (i j : Fin (X - 2))
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
    rw [SR_rees_matrix_entry_threshold,
      SR_rees_matrix_entry_threshold, hk] at hi
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
    rw [SR_rees_matrix_entry_threshold,
      SR_rees_matrix_entry_threshold, hk] at hi
    simp [qi, qj, hgt] at hi
    norm_num at hi

theorem SR_rees_matrix_row_eq_iff_quotient_eq
    (X : Nat)
    (hX : 6 ≤ X)
    (i j : Fin (X - 2)) :
    SR_rees_matrix X i = SR_rees_matrix X j ↔
      (X - 1) / (i.1 + 2) = (X - 1) / (j.1 + 2) := by
  constructor
  · exact SR_rees_matrix_quotient_eq_of_row_eq X hX i j
  · exact SR_rees_matrix_row_eq_of_quotient_eq X i j

theorem SR_rees_matrix_X7_entries :
    SR_rees_matrix 7 =
      !![ -1, -1, 1, 1, 1;
          -1, 1, 1, 1, 1;
           1, 1, 1, 1, 1;
           1, 1, 1, 1, 1;
           1, 1, 1, 1, 1 ] := by
  funext i j
  fin_cases i <;>
    fin_cases j <;>
    norm_num [SR_rees_matrix]

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
    (X q₁ q₂ : Nat)
    (hq : q₁ < q₂)
    (j : Fin (X - 2)) :
    SR_rees_threshold_row X q₂ j -
        SR_rees_threshold_row X q₁ j =
      if q₁ < j.1 + 2 ∧ j.1 + 2 ≤ q₂ then
        (-2 : ℚ)
      else
        0 := by
  by_cases h₁ : j.1 + 2 ≤ q₁
  · have h₂ : j.1 + 2 ≤ q₂ := le_trans h₁ hq.le
    simp [SR_rees_threshold_row, h₁, h₂]
  · by_cases h₂ : j.1 + 2 ≤ q₂
    · have h₁' : q₁ < j.1 + 2 := Nat.lt_of_not_ge h₁
      simp [SR_rees_threshold_row, h₁, h₂, h₁']
      norm_num
    · simp [SR_rees_threshold_row, h₁, h₂]

lemma SR_rees_row_eq_threshold_row
    (X : Nat)
    (hX : 6 ≤ X)
    (m : Fin (X - 2)) :
    (SR_rees_matrix X).row m =
      SR_rees_threshold_row X ((X - 1) / (m.1 + 2)) := by
  funext n
  show
    SR_rees_matrix X m n =
      SR_rees_threshold_row X ((X - 1) / (m.1 + 2)) n
  rw [SR_rees_matrix_entry_threshold]
  rfl

lemma SR_threshold_rep_mem
    (X : Nat)
    (q : SR_threshold_set X) :
    SR_threshold_rep X q ∈ completeSupport X :=
  List.mem_toFinset.mp
    (Classical.choose_spec (Finset.mem_image.mp q.property)).1

lemma SR_threshold_rep_lt
    (X : Nat)
    (q : SR_threshold_set X) :
    SR_threshold_rep X q - 2 < X - 2 := by
  have hm := completeSupport_mem_bounds (SR_threshold_rep_mem X q)
  omega

theorem SR_rees_quotient_rows_linearIndependent
    (X : Nat)
    (hX : 6 ≤ X) :
    LinearIndependent ℚ
      (fun q : SR_threshold_set X =>
        (SR_rees_matrix X).row
          ⟨SR_threshold_rep X q - 2, SR_threshold_rep_lt X q⟩) := by
  rw [Fintype.linearIndependent_iff]
  intro g hg

  have hrow (q : SR_threshold_set X) :
      (SR_rees_matrix X).row
          ⟨SR_threshold_rep X q - 2, SR_threshold_rep_lt X q⟩ =
        SR_rees_threshold_row X q.1 := by
    rw [SR_rees_row_eq_threshold_row X hX]
    have hrep2 : 2 ≤ SR_threshold_rep X q :=
      (completeSupport_mem_bounds (SR_threshold_rep_mem X q)).1
    rw [Nat.sub_add_cancel hrep2, SR_threshold_rep_quotient]

  have hg' :
      ∑ q : SR_threshold_set X,
          g q • SR_rees_threshold_row X q.1 = 0 := by
    simpa [hrow, smul_eq_mul] using hg

  have hEval (j : Fin (X - 2)) :
      ∑ q : SR_threshold_set X,
          g q * SR_rees_threshold_row X q.1 j = 0 := by
    simpa [smul_eq_mul] using congrFun hg' j

  have hq_bounds :
      ∀ q : SR_threshold_set X,
        1 ≤ q.1 ∧ q.1 < X - 1 := by
    intro q
    have hmem : SR_threshold_rep X q ∈ completeSupport X :=
      SR_threshold_rep_mem X q
    have hb := completeSupport_mem_bounds hmem
    rw [← SR_threshold_rep_quotient X q]
    constructor
    · apply
        (Nat.le_div_iff_mul_le
          (by omega : 0 < SR_threshold_rep X q)).2
      omega
    · exact
        Nat.div_lt_self
          (by omega : 0 < X - 1)
          (by omega : 1 < SR_threshold_rep X q)

  have hzero_ge2 :
      ∀ q : SR_threshold_set X,
        2 ≤ q.1 → g q = 0 := by
    intro q hq2

    let ja : Fin (X - 2) :=
      ⟨q.1 - 2, by
        have hqU := (hq_bounds q).2
        omega⟩

    let jb : Fin (X - 2) :=
      ⟨q.1 - 1, by
        have hqU := (hq_bounds q).2
        omega⟩

    have hja : ja.1 + 2 = q.1 := by
      dsimp [ja]
      omega

    have hjb : jb.1 + 2 = q.1 + 1 := by
      dsimp [jb]
      omega

    have hdiff :
        ∑ r : SR_threshold_set X,
            (g r * SR_rees_threshold_row X r.1 ja -
              g r * SR_rees_threshold_row X r.1 jb) = 0 := by
      rw [Finset.sum_sub_distrib, hEval ja, hEval jb]
      simp

    have hterm :
        ∀ r : SR_threshold_set X,
          g r * SR_rees_threshold_row X r.1 ja -
              g r * SR_rees_threshold_row X r.1 jb =
            if r = q then (-2 : ℚ) * g q else 0 := by
      intro r
      by_cases hrq : r = q
      · subst r
        simp [SR_rees_threshold_row, hja, hjb]
        ring
      · have hne : r.1 ≠ q.1 := by
          intro h
          apply hrq
          exact Subtype.ext h
        by_cases hlt : r.1 < q.1
        · have hnotq : ¬ q.1 ≤ r.1 :=
            Nat.not_le_of_gt hlt
          have hnotq1 : ¬ q.1 + 1 ≤ r.1 := by
            omega
          simp only [
            SR_rees_threshold_row,
            hja,
            hjb,
            if_neg hnotq,
            if_neg hnotq1,
            if_neg hrq
          ]
          ring
        · have hgt : q.1 < r.1 := by
            omega
          have hqle : q.1 ≤ r.1 := by
            omega
          have hq1 : q.1 + 1 ≤ r.1 := by
            omega
          simp only [
            SR_rees_threshold_row,
            hja,
            hjb,
            if_pos hqle,
            if_pos hq1,
            if_neg hrq
          ]
          ring

    have hdiff' :
        ∑ r : SR_threshold_set X,
            (if r = q then (-2 : ℚ) * g q else 0) = 0 := by
      calc
        ∑ r : SR_threshold_set X,
            (if r = q then (-2 : ℚ) * g q else 0) =
            ∑ r : SR_threshold_set X,
              (g r * SR_rees_threshold_row X r.1 ja -
                g r * SR_rees_threshold_row X r.1 jb) := by
              apply Finset.sum_congr rfl
              intro r hr
              exact (hterm r).symm
        _ = 0 := hdiff

    have hsingle_sum :
        ∑ r : SR_threshold_set X,
            (if r = q then (-2 : ℚ) * g q else 0) =
          (-2 : ℚ) * g q := by
      simp

    rw [hsingle_sum] at hdiff'
    linarith

  intro q
  by_cases hq2 : 2 ≤ q.1
  · exact hzero_ge2 q hq2
  · have hq1 : q.1 = 1 := by
      have h := (hq_bounds q).1
      omega

    let jt : Fin (X - 2) :=
      ⟨X - 3, by omega⟩

    have hjt : jt.1 + 2 = X - 1 := by
      dsimp [jt]
      omega

    have hentry_top :
        ∀ r : SR_threshold_set X,
          SR_rees_threshold_row X r.1 jt = 1 := by
      intro r
      have hru := (hq_bounds r).2
      have hnot : ¬ X - 1 ≤ r.1 := by
        omega
      simp [SR_rees_threshold_row, hjt, hnot]

    have htotal :
        ∑ r : SR_threshold_set X, g r = 0 := by
      calc
        ∑ r : SR_threshold_set X, g r =
            ∑ r : SR_threshold_set X,
              g r * SR_rees_threshold_row X r.1 jt := by
          apply Finset.sum_congr rfl
          intro r hr
          rw [hentry_top r]
          ring
        _ = 0 := hEval jt

    have hq_unique :
        ∀ r : SR_threshold_set X,
          r ≠ q → 2 ≤ r.1 := by
      intro r hrq
      have hr1 := (hq_bounds r).1
      by_contra h
      have hrq1 : r.1 = 1 := by
        omega
      apply hrq
      exact Subtype.ext (by omega)

    have hsingle :
        ∑ r : SR_threshold_set X, g r = g q := by
      have hrewrite :
          ∑ r : SR_threshold_set X, g r =
            ∑ r : SR_threshold_set X,
              (if r = q then g q else 0) := by
        apply Finset.sum_congr rfl
        intro r hr
        by_cases hrq : r = q
        · simp [hrq]
        · rw [if_neg hrq]
          exact hzero_ge2 r (hq_unique r hrq)
      rw [hrewrite]
      simp

    linarith [htotal, hsingle]

theorem SR_rees_rank_eq_quotient_count
    (X : Nat)
    (hX : 6 ≤ X) :
    (SR_rees_matrix X).rank = SR_quotient_count X := by
  let R : Matrix (SR_threshold_set X) (Fin (X - 2)) ℚ :=
    fun q =>
      (SR_rees_matrix X).row
        ⟨SR_threshold_rep X q - 2, SR_threshold_rep_lt X q⟩

  have hRli : LinearIndependent ℚ R.row := by
    simpa [R] using SR_rees_quotient_rows_linearIndependent X hX

  have hspan_R_le_M :
      Submodule.span ℚ (Set.range R.row) ≤
        Submodule.span ℚ (Set.range (SR_rees_matrix X).row) := by
    refine Submodule.span_le.2 ?_
    rintro v ⟨q, rfl⟩
    exact
      Submodule.subset_span
        ⟨⟨SR_threshold_rep X q - 2,
          SR_threshold_rep_lt X q⟩, rfl⟩

  have hspan_M_le_R :
      Submodule.span ℚ (Set.range (SR_rees_matrix X).row) ≤
        Submodule.span ℚ (Set.range R.row) := by
    refine Submodule.span_le.2 ?_
    rintro v ⟨i, rfl⟩

    have hi_mem : i.1 + 2 ∈ completeSupport X := by
      unfold completeSupport
      apply List.mem_map.mpr
      refine ⟨i.1, ?_, rfl⟩
      simpa using i.isLt

    have hi_mem' :
        i.1 + 2 ∈ (completeSupport X).toFinset := by
      simpa using hi_mem

    let q : SR_threshold_set X :=
      ⟨(X - 1) / (i.1 + 2),
        Finset.mem_image.mpr ⟨i.1 + 2, hi_mem', rfl⟩⟩

    have hrep2 :
        2 ≤ SR_threshold_rep X q :=
      (completeSupport_mem_bounds
        (SR_threshold_rep_mem X q)).1

    have hrows :
        (SR_rees_matrix X).row i =
          (SR_rees_matrix X).row
            ⟨SR_threshold_rep X q - 2,
              SR_threshold_rep_lt X q⟩ := by
      apply
        (SR_rees_matrix_row_eq_iff_quotient_eq
          X hX
          i
          ⟨SR_threshold_rep X q - 2,
            SR_threshold_rep_lt X q⟩).2
      simpa [Nat.sub_add_cancel hrep2] using
        (SR_threshold_rep_quotient X q).symm

    refine Submodule.subset_span ?_
    refine ⟨q, ?_⟩
    exact hrows.symm

  have hrank_le :
      (SR_rees_matrix X).rank ≤ R.rank := by
    rw [Matrix.rank_eq_finrank_span_row (SR_rees_matrix X),
      Matrix.rank_eq_finrank_span_row R]
    exact Submodule.finrank_mono hspan_M_le_R

  have hrank_ge :
      R.rank ≤ (SR_rees_matrix X).rank := by
    rw [Matrix.rank_eq_finrank_span_row R,
      Matrix.rank_eq_finrank_span_row (SR_rees_matrix X)]
    exact Submodule.finrank_mono hspan_R_le_M

  apply Nat.le_antisymm
  · calc
      (SR_rees_matrix X).rank ≤ R.rank := hrank_le
      _ = Fintype.card (SR_threshold_set X) := hRli.rank_matrix
      _ = SR_quotient_count X := by
        simpa using SR_threshold_set_card X
  · calc
      SR_quotient_count X = Fintype.card (SR_threshold_set X) := by
        simpa using (SR_threshold_set_card X).symm
      _ = R.rank := hRli.rank_matrix.symm
      _ ≤ (SR_rees_matrix X).rank := hrank_ge

/-! Full-support audit: this includes the index `1`, unlike `completeSupport`.
The definition is independent of the actual Rees matrix so that the
full-support numerical question is represented exactly in Lean. -/
def SR_full_support_all_ones_sum (X : Nat) : Int :=
  ((List.range (X - 1)).map (fun m =>
    ((List.range (X - 1)).map (fun n =>
      if (m + 1) * (n + 1) < X then (-1 : Int) else 1)).sum)).sum

def SR_full_support_bad_pair_count (X : Nat) : Int :=
  ((List.range (X - 1)).map (fun m =>
    ((List.range (X - 1)).map (fun n =>
      if (m + 1) * (n + 1) < X then (1 : Int) else 0)).sum)).sum

theorem SR_full_support_sum_eq_square_sub_bad_pairs (X : Nat) (hX : 1 ≤ X) :
    SR_full_support_all_ones_sum X =
      ((X - 1) * (X - 1) : Int) -
        2 * SR_full_support_bad_pair_count X := by
  classical
  simp only [SR_full_support_all_ones_sum, SR_full_support_bad_pair_count]
  have hif : ∀ (m n : Nat),
      (if (m + 1) * (n + 1) < X then (-1 : Int) else 1) =
        1 - 2 * (if (m + 1) * (n + 1) < X then (1 : Int) else 0) := by
    intro m n
    by_cases hp : (m + 1) * (n + 1) < X
    · simp [hp]
    · simp [hp]
  simp_rw [hif]
  have sum_affine (l : List Nat) (b : Nat → Int) :
      (l.map (fun n => 1 - 2 * b n)).sum =
        (l.length : Int) - 2 * (l.map b).sum := by
    induction l with
    | nil => simp
    | cons a l ih =>
        simp only [List.map_cons, List.sum_cons, List.length_cons]
        rw [ih]
        norm_num
        ring
  have hinner (m : Nat) :
      ((List.range (X - 1)).map
        (fun n => 1 - 2 * (if (m + 1) * (n + 1) < X then (1 : Int) else 0))).sum =
        ((List.range (X - 1)).length : Int) -
          2 * ((List.range (X - 1)).map
            (fun n => if (m + 1) * (n + 1) < X then (1 : Int) else 0)).sum := by
    exact sum_affine (List.range (X - 1)) (fun n =>
      if (m + 1) * (n + 1) < X then (1 : Int) else 0)
  simp_rw [hinner]
  have outer_affine (l : List Nat) (c : Int) (b : Nat → Int) :
      (l.map (fun m => c - 2 * b m)).sum =
        (l.length : Int) * c - 2 * (l.map b).sum := by
    induction l with
    | nil => simp
    | cons a l ih =>
        simp only [List.map_cons, List.sum_cons, List.length_cons]
        rw [ih]
        rw [Nat.cast_add, Nat.cast_one]
        ring
  have houter := outer_affine (List.range (X - 1))
    ((List.range (X - 1)).length : Int)
    (fun m => ((List.range (X - 1)).map
      (fun n => if (m + 1) * (n + 1) < X then (1 : Int) else 0)).sum)
  rw [houter]
  simp only [List.length_range]
  rw [Nat.cast_sub hX]
  ring

theorem SR_full_support_all_ones_sum_X6 :
    SR_full_support_all_ones_sum 6 = 5 := by
  native_decide

theorem SR_full_support_all_ones_sum_X10 :
    SR_full_support_all_ones_sum 10 = 35 := by
  native_decide

theorem SR_full_support_all_ones_sum_X30 :
    SR_full_support_all_ones_sum 30 = 635 := by
  native_decide

theorem SR_full_support_all_ones_sum_X100 :
    SR_full_support_all_ones_sum 100 = 8855 := by
  native_decide

theorem SR_full_support_all_ones_sum_X210 :
    SR_full_support_all_ones_sum 210 = 41381 := by
  native_decide

theorem SR_full_support_all_ones_sum_X2310 :
    SR_full_support_all_ones_sum 2310 = 5295017 := by
  native_decide

theorem SR_full_support_all_ones_sum_positive_X6_to_X1000 :
    ((List.range 995).all fun k =>
      0 < SR_full_support_all_ones_sum (k + 6)) = true := by
  native_decide

theorem SR_full_support_all_ones_sum_positive_boundary_X6_to_X17 :
    ((List.range 12).all fun k =>
      0 < SR_full_support_all_ones_sum (k + 6)) = true := by
  native_decide

theorem SR_four_mul_sqrt_lt_of_ge_seventeen {N : Nat} (hN : 17 ≤ N) :
    4 * N * N.sqrt < N * N := by
  have hs : N.sqrt * N.sqrt ≤ N := Nat.sqrt_le N
  have hfour : 4 * N.sqrt < N := by
    by_contra h
    have hle : N ≤ 4 * N.sqrt := Nat.le_of_not_gt h
    nlinarith
  nlinarith

/--
No-go result: the abstract strictly-monotone threshold negative-definiteness
theorem (proved for `SR_signed_threshold_matrix`) cannot be transferred
verbatim to the actual `SR_rees_matrix`. The actual X=6 matrix has both
positive and negative quadratic directions: the all-ones vector gives a
strictly positive quadratic form value (14 > 0), so global non-positivity
fails.

This separates the abstract `SR_signed_threshold_matrix` results (which do
hold) from statements about the full `SR_rees_matrix`.
-/
theorem SR_rees_matrix_global_nonpositive_false :
    ¬ (∀ X : Nat, 6 ≤ X →
        ∀ v : Fin (X - 2) → ℚ,
          ∑ i : Fin (X - 2),
            v i * ∑ j : Fin (X - 2),
              SR_rees_matrix X i j * v j ≤ 0) := by
  intro h
  -- Use X = 6, v = fun _ => 1 (the all-ones vector, Fin 4 since X-2=4)
  have h6 := h 6 (by norm_num) (fun _ => (1 : ℚ))
  -- Evaluate: ∑ i : Fin 4, 1 * ∑ j : Fin 4, SR_rees_matrix 6 i j * 1 = 14
  -- We verify this by native_decide on the rational arithmetic
  have hpos : (14 : ℚ) ≤ ∑ i : Fin (6 - 2),
      (1 : ℚ) * ∑ j : Fin (6 - 2), SR_rees_matrix 6 i j * 1 := by
    native_decide
  linarith

end SR
