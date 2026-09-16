import Mathlib.Analysis.Normed.Field.Basic

namespace SR

/-- A quantitative zero-free margin survives a sufficiently small uniform error. -/
theorem nonzero_transfer_of_margin {α : Type*} [NormedRing α]
    {F G : α} {δ : ℝ}
    (hδ : 0 < δ) (hmargin : δ ≤ ‖F‖) (herr : ‖G - F‖ < δ) :
    G ≠ 0 := by
  intro hG
  subst hG
  have hnorm : ‖F‖ < δ := by
    simpa [norm_neg] using herr
  exact (not_lt_of_ge hmargin) hnorm

/-- Pointwise form used on a common completed function space. -/
theorem uniform_zero_free_transfer {ι : Type*} {α : Type*} [NormedRing α]
    {F G : ι → α} {δ : ℝ}
    (hδ : 0 < δ) (hmargin : ∀ x, δ ≤ ‖F x‖)
    (herr : ∀ x, ‖G x - F x‖ < δ) :
    ∀ x, G x ≠ 0 := by
  intro x
  exact nonzero_transfer_of_margin hδ (hmargin x) (herr x)

end SR
