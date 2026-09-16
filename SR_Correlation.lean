import Mathlib.Data.Real.Basic
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Algebra.Order.BigOperators.Group.Finset

namespace SR

noncomputable def correlationEnergy {n : ℕ}
    (sample : Fin n → ℝ) (left right : Fin n → ℝ) (t : ℝ) : ℝ :=
  ∑ i : Fin n, (t - 2 * sample i) ^ 2 * left i * right i

theorem correlationEnergy_nonneg {n : ℕ}
    (sample : Fin n → ℝ) (left right : Fin n → ℝ) (t : ℝ)
    (hleft : ∀ i, 0 ≤ left i) (hright : ∀ i, 0 ≤ right i) :
    0 ≤ correlationEnergy sample left right t := by
  unfold correlationEnergy
  apply Finset.sum_nonneg
  intro i hi
  exact mul_nonneg (mul_nonneg (sq_nonneg _) (hleft i)) (hright i)

end SR
