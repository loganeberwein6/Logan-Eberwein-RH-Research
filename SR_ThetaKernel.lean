import Mathlib.Analysis.SpecialFunctions.Trigonometric.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Real.Pi.Bounds
import Mathlib.Algebra.BigOperators.Group.Finset.Basic
import Mathlib.Analysis.SpecialFunctions.Exp
import Mathlib.Analysis.Real.Pi.Bounds

namespace SR

noncomputable def thetaMode (n : ℕ) (t : ℝ) : ℝ :=
  (2 * Real.pi ^ 2 * (n : ℝ) ^ 4 * Real.exp (9 * t / 2) -
    3 * Real.pi * (n : ℝ) ^ 2 * Real.exp (5 * t / 2)) *
    Real.exp (-Real.pi * (n : ℝ) ^ 2 * Real.exp (2 * t))

theorem thetaMode_pos {n : ℕ} {t : ℝ} (hn : 1 ≤ n) (ht : 0 ≤ t) :
    0 < thetaMode n t := by
  unfold thetaMode
  have hpi : 3 < Real.pi := Real.pi_gt_three
  have hnreal : (0 : ℝ) < n := by exact_mod_cast (Nat.zero_lt_of_lt hn)
  have hn2 : (0 : ℝ) < (n : ℝ) ^ 2 := sq_pos_of_pos hnreal
  have hexp2 : 0 < Real.exp (2 * t) := Real.exp_pos _
  have hbr : 0 < 2 * Real.pi * (n : ℝ) ^ 2 * Real.exp (2 * t) - 3 := by
    have hmul : 3 < 2 * Real.pi * (n : ℝ) ^ 2 * Real.exp (2 * t) := by
      have hpi2 : 3 < 2 * Real.pi := by nlinarith
      have hnrealone : (1 : ℝ) ≤ (n : ℝ) := by exact_mod_cast hn
      have hn2ge : (1 : ℝ) ≤ (n : ℝ) ^ 2 := by nlinarith
      have hprod : 2 * Real.pi ≤ 2 * Real.pi * (n : ℝ) ^ 2 := by
        exact (le_mul_of_one_le_right (le_of_lt (by positivity)) hn2ge)
      have hexpge : (1 : ℝ) ≤ Real.exp (2 * t) := by
        have hlin : 0 ≤ 2 * t := by positivity
        nlinarith [Real.add_one_le_exp (2 * t)]
      nlinarith [mul_le_mul_of_nonneg_left hprod (by positivity)]
    exact sub_pos.mpr hmul
  have hfactor : 0 < Real.pi * (n : ℝ) ^ 2 * Real.exp (5 * t / 2) := by
    positivity
  have houter : 0 < Real.exp (-Real.pi * (n : ℝ) ^ 2 * Real.exp (2 * t)) :=
    Real.exp_pos _
  have halgebra :
      2 * Real.pi ^ 2 * (n : ℝ) ^ 4 * Real.exp (9 * t / 2) -
        3 * Real.pi * (n : ℝ) ^ 2 * Real.exp (5 * t / 2) =
      (Real.pi * (n : ℝ) ^ 2 * Real.exp (5 * t / 2)) *
        (2 * Real.pi * (n : ℝ) ^ 2 * Real.exp (2 * t) - 3) := by
    rw [show (9 * t / 2 : ℝ) = 5 * t / 2 + 2 * t by ring]
    rw [Real.exp_add]
    ring
  rw [halgebra]
  positivity

noncomputable def thetaKernelPartial (N : ℕ) (t : ℝ) : ℝ :=
  ∑ n in Finset.range N, thetaMode (n + 1) t

theorem thetaKernelPartial_nonneg (N : ℕ) {t : ℝ} (ht : 0 ≤ t) :
    0 ≤ thetaKernelPartial N t := by
  unfold thetaKernelPartial
  induction N with
  | zero => simp
  | succ N ih =>
      rw [Finset.sum_range_succ]
      exact add_nonneg ih (le_of_lt (thetaMode_pos (by omega) ht))

theorem thetaKernelPartial_succ_pos (N : ℕ) {t : ℝ} (ht : 0 ≤ t) :
    0 < thetaKernelPartial (N + 1) t := by
  unfold thetaKernelPartial
  rw [Finset.sum_range_succ]
  exact add_pos_of_nonneg_of_pos (thetaKernelPartial_nonneg N ht)
    (thetaMode_pos (by omega) ht)

end SR
