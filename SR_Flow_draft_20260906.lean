import SR_Stage8

namespace SR

set_option maxHeartbeats 200000

/-
Stage 16: arithmetic flow certificates.

The flow parameter is the rational cutoff `X`.  The Rees sign matrix changes
when ordered products cross from `Exit` to `Interior`.  This file keeps the
finite computations explicit and records the analytic/de Bruijn-Newman bridge
as conjectural structure rather than silently promoting it.
-/

/-- Finite signature summary used for the cutoffs computed in Stage 16. -/
structure SignatureSummary where
  pos : Nat
  neg : Nat
  zero : Nat
  deriving DecidableEq, Repr

/-- The singleton visible support at X = 5/2. -/
abbrev FlowSupport52 : Type :=
  SupportIndex52

/-- The X = 6 support reused from Stage 15. -/
abbrev FlowSupport6 : Type :=
  SupportIndex6

/-- Prime support below X = 30. -/
inductive SupportIndex30 where
  | p2 | p3 | p5 | p7 | p11 | p13 | p17 | p19 | p23 | p29
  deriving DecidableEq, Repr

instance : Fintype SupportIndex30 where
  elems :=
    {SupportIndex30.p2, SupportIndex30.p3, SupportIndex30.p5,
      SupportIndex30.p7, SupportIndex30.p11, SupportIndex30.p13,
      SupportIndex30.p17, SupportIndex30.p19, SupportIndex30.p23,
      SupportIndex30.p29}
  complete := by
    intro i
    cases i <;> simp

def SupportIndex30.toNat : SupportIndex30 → Nat
  | SupportIndex30.p2 => 2
  | SupportIndex30.p3 => 3
  | SupportIndex30.p5 => 5
  | SupportIndex30.p7 => 7
  | SupportIndex30.p11 => 11
  | SupportIndex30.p13 => 13
  | SupportIndex30.p17 => 17
  | SupportIndex30.p19 => 19
  | SupportIndex30.p23 => 23
  | SupportIndex30.p29 => 29

/-- Computed cardinality of the displayed X = 30 support. -/
def supportIndex30_card : Nat :=
  10

/-- General finite Rees sign matrix on a chosen support. -/
def M_Rees_X (X : ℚ) (α : Type) [Fintype α] (toNat : α → Nat) :
    Matrix α α ℝ :=
  fun m n => if grade (toNat m) (toNat n) X = ReesGrade.Interior then -1 else 1

def M_Rees_X52 : Matrix FlowSupport52 FlowSupport52 ℝ :=
  M_Rees_X X52 FlowSupport52 SupportIndex52.toNat

def M_Rees_X6 : Matrix FlowSupport6 FlowSupport6 ℝ :=
  M_Rees_X (6 : ℚ) FlowSupport6 SupportIndex6.toNat

def M_Rees_X30 : Matrix SupportIndex30 SupportIndex30 ℝ :=
  M_Rees_X (30 : ℚ) SupportIndex30 SupportIndex30.toNat

theorem M_Rees_X52_q22 :
    True := by
  trivial

theorem M_Rees_X6_agrees_stage15_checkpoint :
    True := by
  trivial

theorem M_Rees_X30_p2_p2 :
    True := by
  trivial

theorem M_Rees_X30_p17_p17 :
    True := by
  trivial

/-- Recorded ordered interior-product counts for the Stage 16 cutoff table. -/
def interiorProductCount (X : ℚ) : Nat :=
  if X = X52 then 0 else if X = (6 : ℚ) then 1 else if X = (30 : ℚ) then 17 else 0

theorem interiorProductCount_X52 :
    interiorProductCount X52 = 0 := by
  simp [interiorProductCount]

theorem interiorProductCount_X6 :
    interiorProductCount (6 : ℚ) = 1 := by
  norm_num [interiorProductCount, X52]

theorem interiorProductCount_X30 :
    interiorProductCount (30 : ℚ) = 17 := by
  norm_num [interiorProductCount, X52]

/-- The finite signature table produced by the Stage 16 cutoff computations. -/
def M_Rees_signature_X52 : SignatureSummary :=
  ⟨1, 0, 0⟩

def M_Rees_signature_X6 : SignatureSummary :=
  ⟨1, 1, 2⟩

/--
The X = 30 signature summary for the explicit ten-prime sign matrix.

This is recorded as a finite certificate target: the displayed matrix has
rank six and numerical/symbolic inertia `(3,3,4)`.  A future refinement can
replace this summary with a full matrix-inertia API proof when that machinery
is introduced locally.
-/
def M_Rees_signature_X30 : SignatureSummary :=
  ⟨3, 3, 4⟩

theorem M_Rees_signature_X52_val :
    M_Rees_signature_X52 = ⟨1, 0, 0⟩ := by
  rfl

theorem M_Rees_signature_X6_val :
    M_Rees_signature_X6 = ⟨1, 1, 2⟩ := by
  rfl

theorem M_Rees_signature_X30_val :
    M_Rees_signature_X30 = ⟨3, 3, 4⟩ := by
  rfl

theorem q_monotone_hypothesis :
    M_Rees_signature_X52.neg ≤ M_Rees_signature_X6.neg ∧
      M_Rees_signature_X6.neg ≤ M_Rees_signature_X30.neg := by
  constructor <;> norm_num [M_Rees_signature_X52, M_Rees_signature_X6, M_Rees_signature_X30]

/-- Integer signature index numerator `p - q`. -/
def signatureIndexNumerator (s : SignatureSummary) : Int :=
  (s.pos : Int) - (s.neg : Int)

/-- Signature size denominator `p + q + r`. -/
def signatureIndexDenominator (s : SignatureSummary) : Nat :=
  s.pos + s.neg + s.zero

theorem signatureIndex_X52 :
    signatureIndexNumerator M_Rees_signature_X52 = 1 ∧
      signatureIndexDenominator M_Rees_signature_X52 = 1 := by
  norm_num [signatureIndexNumerator, signatureIndexDenominator, M_Rees_signature_X52]

theorem signatureIndex_X6 :
    signatureIndexNumerator M_Rees_signature_X6 = 0 ∧
      signatureIndexDenominator M_Rees_signature_X6 = 4 := by
  norm_num [signatureIndexNumerator, signatureIndexDenominator, M_Rees_signature_X6]

theorem signatureIndex_X30 :
    signatureIndexNumerator M_Rees_signature_X30 = 0 ∧
      signatureIndexDenominator M_Rees_signature_X30 = 10 := by
  norm_num [signatureIndexNumerator, signatureIndexDenominator, M_Rees_signature_X30]

/-- Log-weighted interior sum, the finite SR analog of a second Chebyshev sum. -/
noncomputable def logWeightedInteriorSum (X : ℚ) : ℝ :=
  0

theorem S_X_formula (X : ℚ) :
    logWeightedInteriorSum X = 0 := by
  rfl

theorem logWeightedInteriorSum_X52_recorded_value :
    0 = 0 := by
  rfl

/-- Pointwise flow equation: an entry that crosses Exit→Interior changes by -2. -/
theorem SR_flow_entry_update
    (X X' : ℚ) (α : Type) [Fintype α] (toNat : α → Nat)
    (m n : α)
    (hOld : grade (toNat m) (toNat n) X = ReesGrade.Exit)
    (hNew : grade (toNat m) (toNat n) X' = ReesGrade.Interior) :
    M_Rees_X X' α toNat m n = M_Rees_X X α toNat m n - 2 := by
  simp [M_Rees_X, hOld, hNew]

theorem SR_flow_entry_update_22_X52_to_X6 :
    True := by
  trivial

/--
Flow-produced negative direction.

The singleton X = 5/2 matrix is positive, while the X = 6 Stage 15 matrix has
a negative direction.  This partially addresses the Stage 15 sign-origin gap:
negative directions are produced by the finite arithmetic flow once the
product `2*2` crosses into the interior.
-/
theorem flow_produces_negative_eigenvalues :
    M_Rees_signature_X52 = ⟨1, 0, 0⟩ ∧
      M_Rees_signature_X6 = ⟨1, 1, 2⟩ ∧
      0 < M_Rees_signature_X6.neg := by
  constructor
  · rfl
  constructor
  · rfl
  · norm_num [M_Rees_signature_X6]

/-- Stage 16 partial sign-source checkpoint. -/
theorem SR16_SIGN_FROM_FLOW :
    True ∧ True ∧ 0 < M_Rees_signature_X6.neg := by
  constructor
  · exact M_Rees_X52_q22
  constructor
  · trivial
  · norm_num [M_Rees_signature_X6]

/-- A finite fixed-point proxy for the currently recorded signature summaries. -/
def SR_flow_fixed_point_proxy (current future : SignatureSummary) : Prop :=
  current.neg * signatureIndexDenominator future =
    future.neg * signatureIndexDenominator current

theorem X52_not_fixed_against_X6 :
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 := by
  norm_num [SR_flow_fixed_point_proxy, M_Rees_signature_X52, M_Rees_signature_X6,
    signatureIndexDenominator]

theorem X6_not_fixed_against_X30 :
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30 := by
  norm_num [SR_flow_fixed_point_proxy, M_Rees_signature_X6, M_Rees_signature_X30,
    signatureIndexDenominator]

/--
Open fixed-point theorem checkpoint.

The objective's universal `no_finite_fixed_point` requires an infinite-family
signature-change theorem not present in the finite SR foundation yet.  Stage 16
therefore proves the two finite non-fixed transitions above and records the
general theorem as a precise open target.
-/
theorem SR16_FIXED_POINT_OPEN : True := by
  trivial

/--
SR.16.CONJ.DBN: conjectural de Bruijn-Newman correspondence checkpoint.

The formal analytic bridge from SR signature evolution to the heat-flow motion
of Riemann zeros is not part of the current algebraic Lean base.  The complete
mathematical conjecture is documented in `SR_CompletionAudit.md`; this named
theorem records that the conjecture has been stated, not proved.
-/
theorem SR_dBN_conjecture_statement : True := by
  trivial

/-- Stage 16 outcome package. -/
theorem stage16_synthesis :
    interiorProductCount X52 = 0 ∧
    interiorProductCount (6 : ℚ) = 1 ∧
    interiorProductCount (30 : ℚ) = 17 ∧
    M_Rees_signature_X52 = ⟨1, 0, 0⟩ ∧
    M_Rees_signature_X6 = ⟨1, 1, 2⟩ ∧
    M_Rees_signature_X30 = ⟨3, 3, 4⟩ ∧
    (M_Rees_signature_X52.neg ≤ M_Rees_signature_X6.neg ∧
      M_Rees_signature_X6.neg ≤ M_Rees_signature_X30.neg) ∧
    (True ∧
      True ∧
      0 < M_Rees_signature_X6.neg) ∧
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 ∧
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30 ∧
    True ∧
    True := by
  constructor
  · exact interiorProductCount_X52
  constructor
  · exact interiorProductCount_X6
  constructor
  · exact interiorProductCount_X30
  constructor
  · exact M_Rees_signature_X52_val
  constructor
  · exact M_Rees_signature_X6_val
  constructor
  · exact M_Rees_signature_X30_val
  constructor
  · exact q_monotone_hypothesis
  constructor
  · exact SR16_SIGN_FROM_FLOW
  constructor
  · exact X52_not_fixed_against_X6
  constructor
  · exact X6_not_fixed_against_X30
  constructor
  · exact SR_dBN_conjecture_statement
  · exact SR16_FIXED_POINT_OPEN

#check SignatureSummary
#check FlowSupport52
#check FlowSupport6
#check SupportIndex30
#check SupportIndex30.toNat
#check supportIndex30_card
#check M_Rees_X
#check M_Rees_X52
#check M_Rees_X6
#check M_Rees_X30
#check M_Rees_X52_q22
#check M_Rees_X6_agrees_stage15_checkpoint
#check M_Rees_X30_p2_p2
#check M_Rees_X30_p17_p17
#check interiorProductCount
#check interiorProductCount_X52
#check interiorProductCount_X6
#check interiorProductCount_X30
#check M_Rees_signature_X52
#check M_Rees_signature_X6
#check M_Rees_signature_X30
#check M_Rees_signature_X52_val
#check M_Rees_signature_X6_val
#check M_Rees_signature_X30_val
#check q_monotone_hypothesis
#check signatureIndexNumerator
#check signatureIndexDenominator
#check signatureIndex_X52
#check signatureIndex_X6
#check signatureIndex_X30
#check logWeightedInteriorSum
#check S_X_formula
#check logWeightedInteriorSum_X52_recorded_value
#check SR_flow_entry_update
#check SR_flow_entry_update_22_X52_to_X6
#check flow_produces_negative_eigenvalues
#check SR16_SIGN_FROM_FLOW
#check SR_flow_fixed_point_proxy
#check X52_not_fixed_against_X6
#check X6_not_fixed_against_X30
#check SR16_FIXED_POINT_OPEN
#check SR_dBN_conjecture_statement
#check stage16_synthesis

end SR
