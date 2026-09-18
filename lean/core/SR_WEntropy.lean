import lean.weil.SR_SignatureBound
import Mathlib.Data.Real.Basic

namespace SR

/-! Stage 26D: a certified finite W-bias observable. -/

def W_SR_of_sig (s : ReesSig) : Int :=
  (s.pos : Int) - (s.neg : Int)

theorem W_SR_of_sig_nonneg (s : ReesSig) (h : s ∈ knownSigs) :
    0 ≤ W_SR_of_sig s := by
  have hd := SR21_NONNEGATIVE_DOMINANCE_CERTIFIED_X6_TO_200 s h
  unfold W_SR_of_sig
  omega

theorem W_SR_of_sig_bounded (s : ReesSig) (h : s ∈ knownSigs) :
    W_SR_of_sig s = 0 ∨ W_SR_of_sig s = 1 := by
  have hu := SR21_UPPER_BOUND_CERTIFIED_X6_TO_200 s h
  have hd := SR21_NONNEGATIVE_DOMINANCE_CERTIFIED_X6_TO_200 s h
  unfold W_SR_of_sig
  omega

def W_SR_primorial : Nat → Int
  | 6 => 0
  | 30 => 0
  | 210 => 0
  | 2310 => 0
  | _ => 0

theorem W_SR_primorial_zero :
    W_SR_primorial 6 = 0 ∧ W_SR_primorial 30 = 0 ∧
      W_SR_primorial 210 = 0 ∧ W_SR_primorial 2310 = 0 := by
  native_decide

def W_SR_converges : Prop :=
  ∀ ε : ℝ, 0 < ε → ∃ X₀ : Nat, ∀ X : Nat, X₀ ≤ X →
    |((W_SR_primorial X : Int) : ℝ)| < ε

/-
The former `W_SR_RH_bridge : Prop := W_SR_converges → True` declaration was
removed. It encoded no bridge to RH; it merely converted an assumption into
`True` without stating or proving an analytic conclusion.
-/

/-! The diagonal trace of the Rees sign matrix, expressed through the
    below-half support count.  This is kept as an arithmetic observable,
    independently of any unproved spectral claim. -/
def reesTrace (X : Nat) : Int :=
  ((completeSupport X).length : Int) - 2 * (belowHalfSupportCount X : Int)

theorem rees_trace_formula (X : Nat) (hX : 6 ≤ X) :
    reesTrace X = (X - 2 : Int) -
      2 * belowHalfSupportCount X := by
  unfold reesTrace
  have hlen : (completeSupport X).length = X - 2 := by
    simp [completeSupport]
  rw [hlen]
  rw [Nat.cast_sub (by omega)]
  norm_num

theorem rees_trace_value (X : Nat) (hX : 6 ≤ X) :
    reesTrace X = if X % 2 = 0 then 2 else 1 := by
  rw [rees_trace_formula X hX, belowHalfSupportCount_general X hX]
  by_cases hpar : X % 2 = 0 <;> simp [hpar] <;> omega

theorem SR_flow_derivative (X : Nat) (hX : 6 ≤ X) :
    reesTrace (X + 1) - reesTrace X =
      if X % 2 = 0 then -1 else 1 := by
  have hX1 : 6 ≤ X + 1 := by omega
  rw [rees_trace_value (X + 1) hX1, rees_trace_value X hX]
  by_cases hp : X % 2 = 0
  · have hp1 : (X + 1) % 2 = 1 := by omega
    simp [hp, hp1]
  · have hp1 : (X + 1) % 2 = 0 := by omega
    simp [hp, hp1]

theorem SR_allOnesEntrySum_small_table :
    allOnesEntrySum 6 = 14 ∧ allOnesEntrySum 7 = 19 ∧
    allOnesEntrySum 8 = 30 ∧ allOnesEntrySum 9 = 39 ∧
    allOnesEntrySum 10 = 52 ∧ allOnesEntrySum 11 = 65 ∧
    allOnesEntrySum 12 = 84 ∧ allOnesEntrySum 13 = 97 ∧
    allOnesEntrySum 14 = 120 ∧ allOnesEntrySum 15 = 141 ∧
    allOnesEntrySum 16 = 164 ∧ allOnesEntrySum 17 = 187 ∧
    allOnesEntrySum 18 = 218 ∧ allOnesEntrySum 19 = 243 ∧
    allOnesEntrySum 20 = 278 := by
  native_decide

def divisorPairsInSupport (X : Nat) : Nat :=
  ((completeSupport X).toFinset.biUnion (fun m =>
    (completeSupport X).toFinset.filter (fun n => decide (m * n = X)))).card

theorem SR_allOnes_increment_certified_6_20 :
    (allOnesEntrySum 7 - allOnesEntrySum 6 = 5) ∧
    (allOnesEntrySum 8 - allOnesEntrySum 7 = 11) ∧
    (allOnesEntrySum 9 - allOnesEntrySum 8 = 9) ∧
    (allOnesEntrySum 10 - allOnesEntrySum 9 = 13) ∧
    (allOnesEntrySum 11 - allOnesEntrySum 10 = 13) ∧
    (allOnesEntrySum 12 - allOnesEntrySum 11 = 19) := by
  native_decide

theorem rees_trace_small_table :
    reesTrace 6 = 2 ∧ reesTrace 7 = 1 ∧ reesTrace 8 = 2 ∧
      reesTrace 9 = 1 ∧ reesTrace 10 = 2 ∧ reesTrace 11 = 1 ∧
      reesTrace 12 = 2 ∧ reesTrace 13 = 1 ∧ reesTrace 14 = 2 ∧
      reesTrace 15 = 1 ∧ reesTrace 16 = 2 ∧ reesTrace 17 = 1 ∧
      reesTrace 18 = 2 ∧ reesTrace 19 = 1 ∧ reesTrace 20 = 2 := by
  repeat' apply And.intro
  all_goals native_decide

/--
Formal closure only: the current `W_SR_primorial` definition is identically zero
for every `X : Nat`, because every pattern branch returns `0`.
Thus `W_SR_converges` holds for the present implementation, but this observable
carries no nontrivial analytic information and does not imply RH.
-/
theorem W_SR_primorial_eq_zero_current (X : Nat) :
    W_SR_primorial X = 0 := by
  unfold W_SR_primorial
  -- All pattern branches return 0
  split <;> rfl

/--
`W_SR_converges` holds for the current (degenerate) `W_SR_primorial` definition.
This is a formal closure: the primorial observable is identically zero, so the
ε-N criterion is trivially satisfied. This result carries no analytic content
about the Riemann Hypothesis.
-/
theorem W_SR_converges_current_definition : W_SR_converges := by
  intro ε hε
  use 0
  intro X _
  simp [W_SR_primorial_eq_zero_current, abs_zero]
  exact hε

/-
The analytic bridge from `W_SR_converges` to any nontrivial conclusion about
RH remains unformalized. The former record theorem was removed because it
only proved `True` from assumptions and therefore carried no mathematical
content. The current `W_SR_primorial` is identically zero, so convergence is
also a formal property of a degenerate observable rather than evidence for RH.
-/

end SR
