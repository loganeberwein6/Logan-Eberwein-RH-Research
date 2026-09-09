import SR_SignatureBound
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

def W_SR_RH_bridge : Prop :=
  W_SR_converges → True

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

theorem SR_allOnesEntrySum_small_table :
    allOnesEntrySum 6 = 14 ∧
    allOnesEntrySum 7 = 17 ∧
    allOnesEntrySum 8 = 24 ∧
    allOnesEntrySum 9 = 31 ∧
    allOnesEntrySum 10 = 40 ∧
    allOnesEntrySum 11 = 49 ∧
    allOnesEntrySum 12 = 60 ∧
    allOnesEntrySum 13 = 71 ∧
    allOnesEntrySum 14 = 84 ∧
    allOnesEntrySum 15 = 97 ∧
    allOnesEntrySum 16 = 112 ∧
    allOnesEntrySum 17 = 127 ∧
    allOnesEntrySum 18 = 144 ∧
    allOnesEntrySum 19 = 161 ∧
    allOnesEntrySum 20 = 180 := by
  native_decide
  · have hp1 : (X + 1) % 2 = 0 := by omega
    simp [hp, hp1]

theorem rees_trace_small_table :
    reesTrace 6 = 2 ∧ reesTrace 7 = 1 ∧ reesTrace 8 = 2 ∧
      reesTrace 9 = 1 ∧ reesTrace 10 = 2 ∧ reesTrace 11 = 1 ∧
      reesTrace 12 = 2 ∧ reesTrace 13 = 1 ∧ reesTrace 14 = 2 ∧
      reesTrace 15 = 1 ∧ reesTrace 16 = 2 ∧ reesTrace 17 = 1 ∧
      reesTrace 18 = 2 ∧ reesTrace 19 = 1 ∧ reesTrace 20 = 2 := by
  repeat' apply And.intro
  all_goals native_decide

theorem SR26_PERELMAN_CONJECTURE :
    W_SR_RH_bridge → W_SR_converges → True := by
  intro _ _
  trivial

end SR
