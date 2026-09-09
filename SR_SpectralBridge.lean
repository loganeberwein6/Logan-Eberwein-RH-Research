import SR_SignatureBound
import Mathlib

namespace SR

def quadraticForm {n : Nat} (M : Matrix (Fin n) (Fin n) ℝ)
    (v : Fin n → ℝ) : ℝ :=
  ∑ i : Fin n, ∑ j : Fin n, v i * M i j * v j

def onesVector {n : Nat} : Fin n → ℝ := fun _ => 1

def rayleighQuotient {n : Nat} (M : Matrix (Fin n) (Fin n) ℝ)
    (v : Fin n → ℝ) (hv : v ≠ 0) : ℝ :=
  quadraticForm M v / (∑ i : Fin n, v i * v i)

theorem quadraticForm_ones_not_nonpositive {n : Nat}
    (M : Matrix (Fin n) (Fin n) ℝ)
    (hpos : 0 < quadraticForm M (onesVector : Fin n → ℝ)) :
    ¬ (∀ v : Fin n → ℝ, quadraticForm M v ≤ 0) := by
  intro hnsd
  have hle := hnsd (onesVector : Fin n → ℝ)
  linarith

def reesMatrixReal (X : Nat) : Matrix (Fin (X - 2)) (Fin (X - 2)) ℝ :=
  fun i j =>
    (reesEntryFromNat X
      (i.val + 2)
      (j.val + 2) : ℝ)

def reesQuadraticOnes (X : Nat) : ℝ :=
  quadraticForm (reesMatrixReal X) (onesVector : Fin (X - 2) → ℝ)

theorem reesQuadraticOnes_eq_allOnesEntrySum (X : Nat) :
    reesQuadraticOnes X = (allOnesEntrySum X : ℝ) := by
  simp [reesQuadraticOnes, quadraticForm, reesMatrixReal, onesVector,
    allOnesEntrySum, completeSupport]

theorem rees_quadratic_ones_pos_of_sum_pos (X : Nat) (hX : 6 ≤ X)
    (hident : (allOnesEntrySum X : ℝ) = reesQuadraticOnes X) :
    0 < reesQuadraticOnes X := by
  rw [← hident]
  exact_mod_cast allOnesEntrySum_positive_general X hX

theorem allOnesEntrySum_pos_implies_not_NSD (X : Nat) (hX : 6 ≤ X)
    (hident : (allOnesEntrySum X : ℝ) = reesQuadraticOnes X) :
    ¬ (∀ v : Fin (X - 2) → ℝ, quadraticForm (reesMatrixReal X) v ≤ 0) := by
  apply quadraticForm_ones_not_nonpositive
  exact rees_quadratic_ones_pos_of_sum_pos X hX hident

theorem SR24_SPECTRAL_BRIDGE (X : Nat) (hX : 6 ≤ X) :
    ¬ (∀ v : Fin (X - 2) → ℝ,
      quadraticForm (reesMatrixReal X) v ≤ 0) := by
  apply quadraticForm_ones_not_nonpositive
  rw [reesQuadraticOnes_eq_allOnesEntrySum]
  exact_mod_cast allOnesEntrySum_positive_general X hX

theorem rees_rayleigh_positive (X : Nat) (hX : 6 ≤ X) :
    0 < rayleighQuotient (reesMatrixReal X)
      (onesVector : Fin (X - 2) → ℝ) (by
        intro h
        have := congrFun h ⟨0, by omega⟩
        norm_num at this) := by
  unfold rayleighQuotient
  have hnum : 0 < quadraticForm (reesMatrixReal X)
      (onesVector : Fin (X - 2) → ℝ) := by
    rw [reesQuadraticOnes_eq_allOnesEntrySum]
    exact_mod_cast allOnesEntrySum_positive_general X hX
  have hden : 0 < (∑ i : Fin (X - 2),
      (onesVector : Fin (X - 2) → ℝ) i * onesVector i) := by
    simp [onesVector]
    omega
  exact div_pos hnum hden

end SR
