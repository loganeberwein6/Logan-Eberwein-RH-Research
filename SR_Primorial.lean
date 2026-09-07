import Mathlib.Tactic.NormNum.Basic

namespace SR

/-
Stage 19: primorial balance conjecture.

The large complete-support computations are recorded as finite certificates,
not as native Lean eigenspectrum computations.  This keeps the Lean layer honest:
the conjecture is stated as an open scaffold, while checked numerical outcomes
are promoted only as explicit recorded data.
-/

def firstPrimesForPrimorial : List Nat :=
  [2, 3, 5, 7, 11]

def primorialValues : List Nat :=
  [1, 2, 6, 30, 210, 2310]

def primorial (n : Nat) : Nat :=
  primorialValues.getD n 0

theorem primorial_seq :
    primorial 1 = 2 ∧
    primorial 2 = 6 ∧
    primorial 3 = 30 ∧
    primorial 4 = 210 ∧
    primorial 5 = 2310 := by
  decide

/--
Open conjectural scaffold: complete-support Rees signatures appear balanced at
primorial cutoffs.  This is not proved here and is not an RH theorem.
-/
theorem SR19_CONJ_PRIMORIAL_BALANCE : True := by
  trivial

structure RecordedCompleteSignature where
  cutoff : Nat
  supportSize : Nat
  pos : Nat
  neg : Nat
  zero : Nat
  deriving DecidableEq, Repr

def RecordedCompleteSignature.balanced (s : RecordedCompleteSignature) : Prop :=
  s.pos = s.neg

def completeSig6 : RecordedCompleteSignature :=
  ⟨6, 4, 1, 1, 2⟩

def completeSig30 : RecordedCompleteSignature :=
  ⟨30, 28, 3, 3, 22⟩

def completeSig210 : RecordedCompleteSignature :=
  ⟨210, 208, 13, 13, 182⟩

def completeSig2310 : RecordedCompleteSignature :=
  ⟨2310, 2308, 47, 47, 2214⟩

theorem completeSig6_balanced : completeSig6.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig6]

theorem completeSig30_balanced : completeSig30.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig30]

theorem completeSig210_balanced : completeSig210.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig210]

theorem completeSig2310_balanced : completeSig2310.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig2310]

theorem SR19_COMPUTATIONAL_X2310 :
    completeSig2310.cutoff = 2310 ∧
    completeSig2310.supportSize = 2308 ∧
    completeSig2310.pos = 47 ∧
    completeSig2310.neg = 47 ∧
    completeSig2310.zero = 2214 ∧
    completeSig2310.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig2310]

theorem SR19_PRIMORIAL_EVIDENCE :
    completeSig6.balanced ∧
    completeSig30.balanced ∧
    completeSig210.balanced ∧
    completeSig2310.balanced := by
  exact ⟨completeSig6_balanced, completeSig30_balanced,
    completeSig210_balanced, completeSig2310_balanced⟩

def completeSig35 : RecordedCompleteSignature :=
  ⟨35, 33, 5, 4, 24⟩

def completeSig42 : RecordedCompleteSignature :=
  ⟨42, 40, 5, 5, 30⟩

def completeSig70 : RecordedCompleteSignature :=
  ⟨70, 68, 7, 7, 54⟩

theorem completeSig35_imbalanced : ¬ completeSig35.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig35]

theorem completeSig42_balanced : completeSig42.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig42]

theorem completeSig70_balanced : completeSig70.balanced := by
  norm_num [RecordedCompleteSignature.balanced, completeSig70]

theorem SR19_NONPRIMORIAL_IMBALANCE_FALSE :
    completeSig42.balanced ∧ completeSig70.balanced := by
  exact ⟨completeSig42_balanced, completeSig70_balanced⟩

theorem SR19_COMPLETE_SUPPORT_MIXED_NONPRIMORIALS :
    ¬ completeSig35.balanced ∧
    completeSig42.balanced ∧
    completeSig70.balanced := by
  exact ⟨completeSig35_imbalanced, completeSig42_balanced,
    completeSig70_balanced⟩

def activeDimension (s : RecordedCompleteSignature) : Nat :=
  s.pos + s.neg

theorem active_dimension_primorial_records :
    activeDimension completeSig6 = 2 ∧
    activeDimension completeSig30 = 6 ∧
    activeDimension completeSig210 = 26 ∧
    activeDimension completeSig2310 = 94 := by
  norm_num [activeDimension, completeSig6, completeSig30, completeSig210,
    completeSig2310]

/--
Open analytic scaffold: the intended zeta-spectrum/RH bridge should explain
the primorial balance records and the mixed non-primorial behavior.  This is a
named conjectural target only.
-/
theorem SR19_CONJ_ZETA_PRIMORIAL_SPECTRUM : True := by
  trivial

/--
Open asymptotic scaffold for the Stage 16 log-weighted sum along primorials.
No limit theorem or RH implication is proved here.
-/
theorem SR19_CONJ_S_PRIMORIAL_CONVERGES : True := by
  trivial

theorem SR19_SYNTHESIS :
    True ∧
    completeSig2310.balanced ∧
    completeSig42.balanced ∧
    completeSig70.balanced ∧
    ¬ completeSig35.balanced ∧
    True ∧
    True := by
  exact ⟨SR19_CONJ_PRIMORIAL_BALANCE,
    completeSig2310_balanced,
    completeSig42_balanced,
    completeSig70_balanced,
    completeSig35_imbalanced,
    SR19_CONJ_ZETA_PRIMORIAL_SPECTRUM,
    SR19_CONJ_S_PRIMORIAL_CONVERGES⟩

#check primorial
#check primorial_seq
#check SR19_CONJ_PRIMORIAL_BALANCE
#check RecordedCompleteSignature
#check completeSig2310
#check SR19_COMPUTATIONAL_X2310
#check SR19_PRIMORIAL_EVIDENCE
#check completeSig35_imbalanced
#check completeSig42_balanced
#check completeSig70_balanced
#check SR19_NONPRIMORIAL_IMBALANCE_FALSE
#check SR19_COMPLETE_SUPPORT_MIXED_NONPRIMORIALS
#check active_dimension_primorial_records
#check SR19_CONJ_ZETA_PRIMORIAL_SPECTRUM
#check SR19_CONJ_S_PRIMORIAL_CONVERGES
#check SR19_SYNTHESIS

end SR
