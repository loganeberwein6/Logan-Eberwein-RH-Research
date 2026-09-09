import SR_SignatureBound

namespace SR

theorem boundary_eigenvalues_general (X : Nat)
    (hX : 6 ≤ X)
    (hNS : ¬ ∃ k : Nat, k * k = X) :
    let k := Nat.sqrt X
    let bval : Int := if k * (k + 1) < X then -1 else 1
    Matrix.det (boundaryMatrix (bval : Rat)) = -2 := by
  dsimp
  split_ifs with h
  · exact boundary_matrix_det_sqrt2_proxy (-1) (Or.inr rfl)
  · exact boundary_matrix_det_sqrt2_proxy 1 (Or.inl rfl)

theorem boundary_eigenvalues_pm_sqrt2 (X : Nat)
    (hX : 6 ≤ X)
    (hNS : ¬ ∃ k : Nat, k * k = X) :
    let k := Nat.sqrt X
    let bval : Int := if k * (k + 1) < X then -1 else 1
    let M := boundaryMatrix (bval : Rat)
    Matrix.trace M = 0 ∧ Matrix.det M = -2 := by
  dsimp
  split_ifs <;> constructor <;> native_decide

end SR
