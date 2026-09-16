import Mathlib.Data.Real.Basic

namespace SR

theorem rayleigh_transfer_probe {g z e c : ℝ}
    (hg : 0 ≤ g) (hz : c * g ≤ z) (he : |e| ≤ c * g) :
    0 ≤ z + e := by
  have hneg : -c * g ≤ e := by
    have h := neg_le_of_abs_le he
    simpa [neg_mul] using h
  have hsum := add_le_add hz hneg
  simpa [add_assoc] using hsum

end SR
