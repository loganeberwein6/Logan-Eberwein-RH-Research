import SR_Stage31
import Mathlib.LinearAlgebra.Matrix.Rank

namespace SR

def SR_quotient_count (X : Nat) : Nat :=
  ((completeSupport X).toFinset.image (fun m => (X - 1) / m)).card

theorem SR_quotient_count_X6 : SR_quotient_count 6 = 2 := by
  native_decide

theorem SR_quotient_count_X7 : SR_quotient_count 7 = 3 := by
  native_decide

theorem SR_quotient_count_X10 : SR_quotient_count 10 = 4 := by
  native_decide

theorem SR_quotient_count_X30 : SR_quotient_count 30 = 8 := by
  native_decide

end SR
