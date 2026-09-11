import SR_Stage31
import Mathlib.LinearAlgebra.Matrix.Rank

namespace SR

def SR_quotient_count (X : Nat) : Nat :=
  ((completeSupport X).toFinset.image (fun m => (X - 1) / m)).card

def SR_rees_matrix (X : Nat) : Matrix (Fin (X - 2)) (Fin (X - 2)) ℚ :=
  fun i j => if (i.1 + 2) * (j.1 + 2) < X then -1 else 1

theorem SR_rees_matrix_X7_entries :
    SR_rees_matrix 7 = !![ -1, -1, 1, 1, 1;
                            -1, 1, 1, 1, 1;
                             1, 1, 1, 1, 1;
                             1, 1, 1, 1, 1;
                             1, 1, 1, 1, 1 ] := by
  funext i j
  fin_cases i <;> fin_cases j <;> norm_num [SR_rees_matrix]

theorem SR_quotient_count_X6 : SR_quotient_count 6 = 2 := by
  native_decide

theorem SR_quotient_count_X7 : SR_quotient_count 7 = 3 := by
  native_decide

theorem SR_quotient_count_X10 : SR_quotient_count 10 = 4 := by
  native_decide

theorem SR_quotient_count_X30 : SR_quotient_count 30 = 8 := by
  native_decide

end SR
