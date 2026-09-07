import SR_Flow
import Mathlib.Data.Matrix.Basic
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum.Basic

namespace SR

set_option maxHeartbeats 50000

/-
Stage 17: signature balance.

The unrestricted target `p(X) = q(X)` for every `X ≥ 6` is too strong for the
raw Rees sign matrix.  This file records the structural symmetry, the computed
balanced cutoffs inherited from Stage 16, and a small finite counterexample
showing why the universal statement needs an additional arithmetic support
condition before it can be true.
-/

def M_Rees_general (X : Rat) (n : Nat) (support : Fin n → Nat) :
    Matrix (Fin n) (Fin n) ℝ :=
  fun i j => if ((support i * support j : Nat) : Rat) < X then (-1 : ℝ) else 1

theorem M_Rees_general_entry_symm (X : Rat) (n : Nat) (support : Fin n → Nat)
    (i j : Fin n) :
    M_Rees_general X n support i j = M_Rees_general X n support j i := by
  unfold M_Rees_general
  rw [Nat.mul_comm]

def M_Rees_sig_recorded (X : Rat) : SignatureSummary :=
  if X = FlowX52 then
    M_Rees_signature_X52
  else if X = (6 : Rat) then
    M_Rees_signature_X6
  else if X = (30 : Rat) then
    M_Rees_signature_X30
  else
    ⟨0, 0, 0⟩

theorem signature_table :
    M_Rees_sig_recorded FlowX52 = ⟨1, 0, 0⟩ ∧
    M_Rees_sig_recorded (6 : Rat) = ⟨1, 1, 2⟩ ∧
    M_Rees_sig_recorded (30 : Rat) = ⟨3, 3, 4⟩ := by
  constructor
  · simp [M_Rees_sig_recorded, M_Rees_signature_X52_val]
  constructor
  · norm_num [M_Rees_sig_recorded, FlowX52, M_Rees_signature_X6_val]
  · norm_num [M_Rees_sig_recorded, FlowX52, M_Rees_signature_X30_val]

theorem balance_at_computed_X :
    (M_Rees_sig_recorded (6 : Rat)).pos = (M_Rees_sig_recorded (6 : Rat)).neg ∧
    (M_Rees_sig_recorded (30 : Rat)).pos = (M_Rees_sig_recorded (30 : Rat)).neg := by
  constructor
  · norm_num [M_Rees_sig_recorded, FlowX52, M_Rees_signature_X6_val]
  · norm_num [M_Rees_sig_recorded, FlowX52, M_Rees_signature_X30_val]

def BalanceSupport7 : Fin 3 → Nat
  | ⟨0, _⟩ => 2
  | ⟨1, _⟩ => 3
  | ⟨2, _⟩ => 5

def M_Rees_X7_counterexample : Matrix (Fin 3) (Fin 3) ℝ :=
  M_Rees_general (7 : Rat) 3 BalanceSupport7

def vX7_neg : Fin 3 → ℝ
  | ⟨0, _⟩ => 2
  | ⟨1, _⟩ => 1
  | ⟨2, _⟩ => -1

def vX7_pos_one : Fin 3 → ℝ
  | ⟨0, _⟩ => 1
  | ⟨1, _⟩ => -1
  | ⟨2, _⟩ => 1

def vX7_pos_two : Fin 3 → ℝ
  | ⟨0, _⟩ => 0
  | ⟨1, _⟩ => 1
  | ⟨2, _⟩ => 1

theorem M_Rees_X7_counterexample_entries :
    M_Rees_X7_counterexample =
      !![(-1 : ℝ), -1, 1;
         -1, 1, 1;
          1, 1, 1] := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [M_Rees_X7_counterexample, M_Rees_general, BalanceSupport7]

theorem M_Rees_X7_neg_eigen :
    M_Rees_X7_counterexample.mulVec vX7_neg = fun i => (-2 : ℝ) * vX7_neg i := by
  ext i
  fin_cases i <;>
    norm_num [Matrix.mulVec, dotProduct, Fin.sum_univ_three, M_Rees_X7_counterexample,
      M_Rees_general, BalanceSupport7, vX7_neg]

theorem M_Rees_X7_pos_one_eigen :
    M_Rees_X7_counterexample.mulVec vX7_pos_one = fun i => (1 : ℝ) * vX7_pos_one i := by
  ext i
  fin_cases i <;>
    norm_num [Matrix.mulVec, dotProduct, Fin.sum_univ_three, M_Rees_X7_counterexample,
      M_Rees_general, BalanceSupport7, vX7_pos_one]

theorem M_Rees_X7_pos_two_eigen :
    M_Rees_X7_counterexample.mulVec vX7_pos_two = fun i => (2 : ℝ) * vX7_pos_two i := by
  ext i
  fin_cases i <;>
    norm_num [Matrix.mulVec, dotProduct, Fin.sum_univ_three, M_Rees_X7_counterexample,
      M_Rees_general, BalanceSupport7, vX7_pos_two]

def M_Rees_signature_X7_counterexample : SignatureSummary :=
  ⟨2, 1, 0⟩

theorem balance_fails_at_X7_counterexample :
    M_Rees_signature_X7_counterexample.pos ≠
      M_Rees_signature_X7_counterexample.neg := by
  norm_num [M_Rees_signature_X7_counterexample]

theorem SR17_NG_BALANCE :
    ∃ s : SignatureSummary, s = ⟨2, 1, 0⟩ ∧ s.pos ≠ s.neg := by
  refine ⟨M_Rees_signature_X7_counterexample, rfl, ?_⟩
  exact balance_fails_at_X7_counterexample

theorem SR17_COMPUTATIONAL :
    (M_Rees_sig_recorded (6 : Rat)).pos = (M_Rees_sig_recorded (6 : Rat)).neg ∧
    (M_Rees_sig_recorded (30 : Rat)).pos = (M_Rees_sig_recorded (30 : Rat)).neg ∧
    M_Rees_signature_X7_counterexample.pos ≠
      M_Rees_signature_X7_counterexample.neg := by
  exact ⟨balance_at_computed_X.1, balance_at_computed_X.2,
    balance_fails_at_X7_counterexample⟩

#check M_Rees_general
#check M_Rees_general_entry_symm
#check signature_table
#check balance_at_computed_X
#check M_Rees_X7_counterexample_entries
#check M_Rees_X7_neg_eigen
#check M_Rees_X7_pos_one_eigen
#check M_Rees_X7_pos_two_eigen
#check balance_fails_at_X7_counterexample
#check SR17_NG_BALANCE
#check SR17_COMPUTATIONAL

end SR
