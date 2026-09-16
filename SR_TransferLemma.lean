import Mathlib.Data.Real.Basic

namespace SR

/-- A reference form with a controlled additive error remains nonnegative. -/
theorem rayleigh_transfer {g z e c : ℝ}
    (hg : 0 ≤ g) (hz : c * g ≤ z) (he : |e| ≤ c * g) :
    0 ≤ z + e := by
  have hneg : -c * g ≤ e := by
    have h := neg_le_of_abs_le he
    simpa [neg_mul] using h
  have hsum := add_le_add hz hneg
  simpa [add_assoc] using hsum

/--
Uniform transfer interface.  This packages the exact certificate needed for a
completed-form argument: a nonnegative reference form `G`, a lower bound for
the target form `Z`, and an error `E` dominated by the same reference scale.
The conclusion is pointwise positivity of `Z + E`; no finite-dimensional
assumption is hidden in the statement.
-/
theorem uniform_form_transfer {V : Type} {G Z E : V → ℝ} {c : ℝ}
    (hG : ∀ v, 0 ≤ G v)
    (hZ : ∀ v, c * G v ≤ Z v)
    (hE : ∀ v, |E v| ≤ c * G v) :
    ∀ v, 0 ≤ Z v + E v := by
  intro v
  exact rayleigh_transfer (hG v) (hZ v) (hE v)

end SR
