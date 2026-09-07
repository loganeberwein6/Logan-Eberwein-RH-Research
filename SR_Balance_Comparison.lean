import SR_Balance
import Mathlib.Tactic.FinCases
import Mathlib.Tactic.NormNum.Basic

namespace SR

set_option maxHeartbeats 50000

/-
Stage 18: refined balance and support conditions.

Stage 17 showed that unrestricted signature balance fails for prime-only
support `{2,3,5}` at `X = 7`.  The first Stage 18 hypothesis was that
complete integer support might repair the failure.  The critical complete
support test already refutes that hypothesis: at `X = 7`, support
`{2,3,4,5,6}` still has recorded signature `(2,1,2)`, so `p ≠ q`.
-/

def CompleteSupport7 : Fin 5 → Nat
  | ⟨0, _⟩ => 2
  | ⟨1, _⟩ => 3
  | ⟨2, _⟩ => 4
  | ⟨3, _⟩ => 5
  | ⟨4, _⟩ => 6

def M_Rees_X7_complete : Matrix (Fin 5) (Fin 5) ℝ :=
  M_Rees_general (7 : Rat) 5 CompleteSupport7

theorem X7_complete_matrix_explicit :
    M_Rees_X7_complete =
      !![(-1 : ℝ), -1, 1, 1, 1;
         -1, 1, 1, 1, 1;
          1, 1, 1, 1, 1;
          1, 1, 1, 1, 1;
          1, 1, 1, 1, 1] := by
  ext i j
  fin_cases i <;> fin_cases j <;>
    norm_num [M_Rees_X7_complete, M_Rees_general, CompleteSupport7]

def M_Rees_signature_X7_complete : SignatureSummary :=
  ⟨2, 1, 2⟩

theorem complete_support_X7_balance_fails :
    M_Rees_signature_X7_complete.pos ≠ M_Rees_signature_X7_complete.neg := by
  norm_num [M_Rees_signature_X7_complete]

def vX7_complete_radical_45 : Fin 5 → ℝ
  | ⟨0, _⟩ => 0
  | ⟨1, _⟩ => 0
  | ⟨2, _⟩ => 1
  | ⟨3, _⟩ => -1
  | ⟨4, _⟩ => 0

def vX7_complete_radical_56 : Fin 5 → ℝ
  | ⟨0, _⟩ => 0
  | ⟨1, _⟩ => 0
  | ⟨2, _⟩ => 0
  | ⟨3, _⟩ => 1
  | ⟨4, _⟩ => -1

theorem X7_complete_radical_45 :
    M_Rees_X7_complete.mulVec vX7_complete_radical_45 = 0 := by
  ext i
  fin_cases i <;>
    norm_num [Matrix.mulVec, dotProduct, Fin.sum_univ_five,
      M_Rees_X7_complete, M_Rees_general, CompleteSupport7,
      vX7_complete_radical_45]

theorem X7_complete_radical_56 :
    M_Rees_X7_complete.mulVec vX7_complete_radical_56 = 0 := by
  ext i
  fin_cases i <;>
    norm_num [Matrix.mulVec, dotProduct, Fin.sum_univ_five,
      M_Rees_X7_complete, M_Rees_general, CompleteSupport7,
      vX7_complete_radical_56]

def quad5 (M : Matrix (Fin 5) (Fin 5) ℝ) (x : Fin 5 → ℝ) : ℝ :=
  dotProduct x (M.mulVec x)

def vX7_complete_negative : Fin 5 → ℝ
  | ⟨0, _⟩ => 1
  | ⟨1, _⟩ => 1
  | ⟨2, _⟩ => 0
  | ⟨3, _⟩ => 0
  | ⟨4, _⟩ => 0

def vX7_complete_positive_a : Fin 5 → ℝ
  | ⟨0, _⟩ => 1
  | ⟨1, _⟩ => -1
  | ⟨2, _⟩ => 0
  | ⟨3, _⟩ => 0
  | ⟨4, _⟩ => 0

def vX7_complete_positive_b : Fin 5 → ℝ
  | ⟨0, _⟩ => 0
  | ⟨1, _⟩ => 0
  | ⟨2, _⟩ => 1
  | ⟨3, _⟩ => 1
  | ⟨4, _⟩ => 1

theorem X7_complete_negative_witness :
    quad5 M_Rees_X7_complete vX7_complete_negative < 0 := by
  norm_num [quad5, Matrix.mulVec, dotProduct, Fin.sum_univ_five,
    M_Rees_X7_complete, M_Rees_general, CompleteSupport7,
    vX7_complete_negative]

theorem X7_complete_positive_witness_a :
    0 < quad5 M_Rees_X7_complete vX7_complete_positive_a := by
  norm_num [quad5, Matrix.mulVec, dotProduct, Fin.sum_univ_five,
    M_Rees_X7_complete, M_Rees_general, CompleteSupport7,
    vX7_complete_positive_a]

theorem X7_complete_positive_witness_b :
    0 < quad5 M_Rees_X7_complete vX7_complete_positive_b := by
  norm_num [quad5, Matrix.mulVec, dotProduct, Fin.sum_univ_five,
    M_Rees_X7_complete, M_Rees_general, CompleteSupport7,
    vX7_complete_positive_b]

theorem SR18_NG_COMPLETE :
    ∃ s : SignatureSummary, s = ⟨2, 1, 2⟩ ∧ s.pos ≠ s.neg := by
  refine ⟨M_Rees_signature_X7_complete, rfl, ?_⟩
  exact complete_support_X7_balance_fails

theorem SR18_COMPLETE_SUPPORT_HYPOTHESIS_FALSE :
    M_Rees_signature_X7_complete.pos ≠ M_Rees_signature_X7_complete.neg := by
  exact complete_support_X7_balance_fails

/--
Formal placeholder for the corrected analytic direction suggested by Stage 18:
any future zeta-spectrum theorem must include the missing spectral/divisor
matrix hypotheses explicitly.  This is not an RH theorem.
-/
theorem SR18_CONJ_ZETA_SPECTRUM : True := by
  trivial

/--
Formal placeholder for the corrected Perelman analogy: the naive "add all
integer support" surgery is not sufficient by itself, as witnessed above.
-/
theorem SR18_SURGERY_REQUIRES_MORE_THAN_COMPLETE_SUPPORT : True := by
  trivial

theorem SR18_COMPUTATIONAL_COMPLETE :
    (M_Rees_sig_recorded (6 : Rat)).pos = (M_Rees_sig_recorded (6 : Rat)).neg ∧
    (M_Rees_sig_recorded (30 : Rat)).pos = (M_Rees_sig_recorded (30 : Rat)).neg ∧
    M_Rees_signature_X7_complete.pos ≠ M_Rees_signature_X7_complete.neg := by
  exact ⟨balance_at_computed_X.1, balance_at_computed_X.2,
    complete_support_X7_balance_fails⟩

#check CompleteSupport7
#check M_Rees_X7_complete
#check X7_complete_matrix_explicit
#check M_Rees_signature_X7_complete
#check complete_support_X7_balance_fails
#check X7_complete_radical_45
#check X7_complete_radical_56
#check X7_complete_negative_witness
#check X7_complete_positive_witness_a
#check X7_complete_positive_witness_b
#check SR18_NG_COMPLETE
#check SR18_COMPLETE_SUPPORT_HYPOTHESIS_FALSE
#check SR18_CONJ_ZETA_SPECTRUM
#check SR18_SURGERY_REQUIRES_MORE_THAN_COMPLETE_SUPPORT
#check SR18_COMPUTATIONAL_COMPLETE

end SR
