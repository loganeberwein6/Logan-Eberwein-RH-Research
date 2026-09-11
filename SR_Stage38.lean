import SR_Stage31
import Mathlib.LinearAlgebra.Matrix.Rank

namespace SR

def SR_quotient_count (X : Nat) : Nat :=
  ((completeSupport X).toFinset.image (fun m => (X - 1) / m)).card

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

theorem SR_quotient_count_X6 : SR_quotient_count 6 = 2 := by
  native_decide

theorem SR_quotient_count_X7 : SR_quotient_count 7 = 3 := by
  native_decide

theorem SR_quotient_count_X10 : SR_quotient_count 10 = 4 := by
  native_decide

theorem SR_quotient_count_X30 : SR_quotient_count 30 = 8 := by
  native_decide

end SR
