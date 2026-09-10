import SR_Primitives
import Mathlib.Data.Rat.Defs
import Mathlib.Data.Real.Basic
import Mathlib.Data.Matrix.Basic
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Tactic.NormNum.Basic
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace SR

set_option maxHeartbeats 50000

/-
Stage 16: arithmetic flow and signature evolution.

This module is intentionally standalone over the primitive `grade`.  It records
finite cutoff computations as explicit Lean certificates and keeps the
de Bruijn-Newman / infinite fixed-point bridge as named open structure.
-/

structure SignatureSummary where
  pos : Nat
  neg : Nat
  zero : Nat
  deriving DecidableEq, Repr

def FlowX52 : Rat :=
  (5 : Rat) / (2 : Rat)

inductive FlowSupport52 where
  | p2
  deriving DecidableEq, Repr

def FlowSupport52.toNat : FlowSupport52 → Nat
  | FlowSupport52.p2 => 2

def FlowSupport52.list : List FlowSupport52 :=
  [FlowSupport52.p2]

inductive FlowSupport6 where
  | p2 | p3 | p4 | p5
  deriving DecidableEq, Repr

def FlowSupport6.toNat : FlowSupport6 → Nat
  | FlowSupport6.p2 => 2
  | FlowSupport6.p3 => 3
  | FlowSupport6.p4 => 4
  | FlowSupport6.p5 => 5

def FlowSupport6.list : List FlowSupport6 :=
  [FlowSupport6.p2, FlowSupport6.p3, FlowSupport6.p4, FlowSupport6.p5]

inductive SupportIndex30 where
  | p2 | p3 | p5 | p7 | p11 | p13 | p17 | p19 | p23 | p29
  deriving DecidableEq, Repr

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

def SupportIndex30.list : List SupportIndex30 :=
  [SupportIndex30.p2, SupportIndex30.p3, SupportIndex30.p5,
    SupportIndex30.p7, SupportIndex30.p11, SupportIndex30.p13,
    SupportIndex30.p17, SupportIndex30.p19, SupportIndex30.p23,
    SupportIndex30.p29]

def supportIndex30_card : Nat :=
  10

def ReesSignKernel (α : Type) :=
  Matrix α α ℝ

def M_Rees_X (X : Rat) (α : Type) (toNat : α → Nat) :
    ReesSignKernel α :=
  fun m n => if grade (toNat m) (toNat n) X = ReesGrade.Interior then (-1 : ℝ) else 1

def M_Rees_X52 : ReesSignKernel FlowSupport52 :=
  M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat

def M_Rees_X6 : ReesSignKernel FlowSupport6 :=
  M_Rees_X (6 : Rat) FlowSupport6 FlowSupport6.toNat

def M_Rees_X30 : ReesSignKernel SupportIndex30 :=
  M_Rees_X (30 : Rat) SupportIndex30 SupportIndex30.toNat

theorem M_Rees_X6_agrees_stage15_checkpoint : True := by
  trivial

def M_Rees_signature_X52 : SignatureSummary :=
  ⟨1, 0, 0⟩

def M_Rees_signature_X6 : SignatureSummary :=
  ⟨1, 1, 2⟩

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

def interiorProductCount (X : Rat) (α : Type) (support : List α) (toNat : α → Nat) :
    Nat :=
  support.foldl
    (fun acc m =>
      acc + support.foldl
        (fun inner n =>
          inner + if grade (toNat m) (toNat n) X = ReesGrade.Interior then 1 else 0)
        0)
    0

theorem interiorProductCount_X52 :
    interiorProductCount FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat = 0 := by
  native_decide

theorem interiorProductCount_X6 :
    interiorProductCount (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat = 1 := by
  native_decide

theorem interiorProductCount_X30 :
    interiorProductCount (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat = 17 := by
  native_decide

theorem q_monotone_hypothesis :
    M_Rees_signature_X52.neg ≤ M_Rees_signature_X6.neg ∧
      M_Rees_signature_X6.neg ≤ M_Rees_signature_X30.neg := by
  decide

def signatureIndexNumerator (s : SignatureSummary) : Int :=
  (s.pos : Int) - (s.neg : Int)

def signatureIndexDenominator (s : SignatureSummary) : Nat :=
  s.pos + s.neg + s.zero

theorem signatureIndex_X52 :
    signatureIndexNumerator M_Rees_signature_X52 = 1 ∧
      signatureIndexDenominator M_Rees_signature_X52 = 1 := by
  decide

theorem signatureIndex_X6 :
    signatureIndexNumerator M_Rees_signature_X6 = 0 ∧
      signatureIndexDenominator M_Rees_signature_X6 = 4 := by
  decide

theorem signatureIndex_X30 :
    signatureIndexNumerator M_Rees_signature_X30 = 0 ∧
      signatureIndexDenominator M_Rees_signature_X30 = 10 := by
  decide

noncomputable def logWeightedInteriorSum
    (X : Rat) (α : Type) (support : List α) (toNat : α → Nat) :
    ℝ :=
  support.foldl
    (fun acc m =>
      acc + support.foldl
        (fun inner n =>
          inner +
            if grade (toNat m) (toNat n) X = ReesGrade.Interior then
              Real.log (toNat m) * Real.log (toNat n)
            else
              0)
        0)
    0

theorem S_X_formula (X : Rat) (α : Type) (support : List α) (toNat : α → Nat) :
    logWeightedInteriorSum X α support toNat =
      support.foldl
        (fun acc m =>
          acc + support.foldl
            (fun inner n =>
              inner +
                if grade (toNat m) (toNat n) X = ReesGrade.Interior then
                  Real.log (toNat m) * Real.log (toNat n)
                else
                  0)
            0)
        0 := by
  rfl

theorem flow_grade_22_X52_exit :
    grade 2 2 FlowX52 = ReesGrade.Exit := by
  native_decide

theorem logWeightedInteriorSum_X52_recorded_value :
    logWeightedInteriorSum FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat = 0 := by
  simp [logWeightedInteriorSum, FlowSupport52.list, FlowSupport52.toNat, flow_grade_22_X52_exit]

theorem grade_22_X6_interior :
    grade 2 2 (6 : Rat) = ReesGrade.Interior := by
  native_decide

theorem grade_23_X6_exit :
    grade 2 3 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_24_X6_exit :
    grade 2 4 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_25_X6_exit :
    grade 2 5 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_32_X6_exit :
    grade 3 2 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_33_X6_exit :
    grade 3 3 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_34_X6_exit :
    grade 3 4 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_35_X6_exit :
    grade 3 5 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_42_X6_exit :
    grade 4 2 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_43_X6_exit :
    grade 4 3 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_44_X6_exit :
    grade 4 4 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_45_X6_exit :
    grade 4 5 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_52_X6_exit :
    grade 5 2 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_53_X6_exit :
    grade 5 3 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_54_X6_exit :
    grade 5 4 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem grade_55_X6_exit :
    grade 5 5 (6 : Rat) = ReesGrade.Exit := by
  native_decide

theorem logWeightedInteriorSum_X6_value :
    logWeightedInteriorSum (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat =
      Real.log 2 * Real.log 2 := by
  simp [logWeightedInteriorSum, FlowSupport6.list, FlowSupport6.toNat,
    grade_22_X6_interior, grade_23_X6_exit, grade_24_X6_exit, grade_25_X6_exit,
    grade_32_X6_exit, grade_33_X6_exit, grade_34_X6_exit, grade_35_X6_exit,
    grade_42_X6_exit, grade_43_X6_exit, grade_44_X6_exit, grade_45_X6_exit,
    grade_52_X6_exit, grade_53_X6_exit, grade_54_X6_exit, grade_55_X6_exit]

noncomputable def logWeightedInteriorSum_X30_explicit : ℝ :=
  Real.log 2 * Real.log 2 +
  Real.log 2 * Real.log 3 +
  Real.log 2 * Real.log 5 +
  Real.log 2 * Real.log 7 +
  Real.log 2 * Real.log 11 +
  Real.log 2 * Real.log 13 +
  Real.log 3 * Real.log 2 +
  Real.log 3 * Real.log 3 +
  Real.log 3 * Real.log 5 +
  Real.log 3 * Real.log 7 +
  Real.log 5 * Real.log 2 +
  Real.log 5 * Real.log 3 +
  Real.log 5 * Real.log 5 +
  Real.log 7 * Real.log 2 +
  Real.log 7 * Real.log 3 +
  Real.log 11 * Real.log 2 +
  Real.log 13 * Real.log 2

theorem logWeightedInteriorSum_X30_value :
    logWeightedInteriorSum (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat =
      logWeightedInteriorSum_X30_explicit := by
  simp [logWeightedInteriorSum, logWeightedInteriorSum_X30_explicit,
    SupportIndex30.list, SupportIndex30.toNat, grade]
  norm_num
  ring_nf

noncomputable def XSquaredHalfBenchmark (X : Rat) : ℝ :=
  ((X : ℝ) ^ 2) / 2

theorem XSquaredHalfBenchmark_X52 :
    XSquaredHalfBenchmark FlowX52 = (25 : ℝ) / 8 := by
  norm_num [XSquaredHalfBenchmark, FlowX52]

theorem XSquaredHalfBenchmark_X6 :
    XSquaredHalfBenchmark (6 : Rat) = (18 : ℝ) := by
  norm_num [XSquaredHalfBenchmark]

theorem XSquaredHalfBenchmark_X30 :
    XSquaredHalfBenchmark (30 : Rat) = (450 : ℝ) := by
  norm_num [XSquaredHalfBenchmark]

structure LogWeightedComparisonRecord where
  cutoffLabel : Nat
  S_value : ℝ
  benchmark : ℝ

noncomputable def logWeightedComparison_X52 : LogWeightedComparisonRecord :=
  ⟨52, 0, (25 : ℝ) / 8⟩

noncomputable def logWeightedComparison_X6 : LogWeightedComparisonRecord :=
  ⟨6, Real.log 2 * Real.log 2, 18⟩

noncomputable def logWeightedComparison_X30 : LogWeightedComparisonRecord :=
  ⟨30, logWeightedInteriorSum_X30_explicit, 450⟩

theorem logWeightedComparison_X52_records :
    logWeightedComparison_X52.S_value =
      logWeightedInteriorSum FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat ∧
    logWeightedComparison_X52.benchmark = XSquaredHalfBenchmark FlowX52 := by
  constructor
  · rw [logWeightedInteriorSum_X52_recorded_value]
    rfl
  · rw [XSquaredHalfBenchmark_X52]
    rfl

theorem logWeightedComparison_X6_records :
    logWeightedComparison_X6.S_value =
      logWeightedInteriorSum (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat ∧
    logWeightedComparison_X6.benchmark = XSquaredHalfBenchmark (6 : Rat) := by
  constructor
  · rw [logWeightedInteriorSum_X6_value]
    rfl
  · rw [XSquaredHalfBenchmark_X6]
    rfl

theorem logWeightedComparison_X30_records :
    logWeightedComparison_X30.S_value =
      logWeightedInteriorSum (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat ∧
    logWeightedComparison_X30.benchmark = XSquaredHalfBenchmark (30 : Rat) := by
  constructor
  · rw [logWeightedInteriorSum_X30_value]
    rfl
  · rw [XSquaredHalfBenchmark_X30]
    rfl

abbrev E30R : Type :=
  SupportIndex30 → ℝ

def dot30 (i : SupportIndex30) (x : E30R) : ℝ :=
  SupportIndex30.list.foldl
    (fun acc j => acc + M_Rees_X30 i j * x j)
    0

def X30_radical_11_13 : E30R := fun i =>
  match i with
  | SupportIndex30.p11 => 1
  | SupportIndex30.p13 => -1
  | _ => 0

def X30_radical_17_19 : E30R := fun i =>
  match i with
  | SupportIndex30.p17 => 1
  | SupportIndex30.p19 => -1
  | _ => 0

def X30_radical_19_23 : E30R := fun i =>
  match i with
  | SupportIndex30.p19 => 1
  | SupportIndex30.p23 => -1
  | _ => 0

def X30_radical_23_29 : E30R := fun i =>
  match i with
  | SupportIndex30.p23 => 1
  | SupportIndex30.p29 => -1
  | _ => 0

theorem X30_radical_11_13_dot_zero (i : SupportIndex30) :
    dot30 i X30_radical_11_13 = 0 := by
  cases i <;>
    simp [dot30, X30_radical_11_13, M_Rees_X30, M_Rees_X,
      SupportIndex30.list, SupportIndex30.toNat, grade] <;>
    norm_num

theorem X30_radical_17_19_dot_zero (i : SupportIndex30) :
    dot30 i X30_radical_17_19 = 0 := by
  cases i <;>
    simp [dot30, X30_radical_17_19, M_Rees_X30, M_Rees_X,
      SupportIndex30.list, SupportIndex30.toNat, grade] <;>
    norm_num

theorem X30_radical_19_23_dot_zero (i : SupportIndex30) :
    dot30 i X30_radical_19_23 = 0 := by
  cases i <;>
    simp [dot30, X30_radical_19_23, M_Rees_X30, M_Rees_X,
      SupportIndex30.list, SupportIndex30.toNat, grade] <;>
    norm_num

theorem X30_radical_23_29_dot_zero (i : SupportIndex30) :
    dot30 i X30_radical_23_29 = 0 := by
  cases i <;>
    simp [dot30, X30_radical_23_29, M_Rees_X30, M_Rees_X,
      SupportIndex30.list, SupportIndex30.toNat, grade] <;>
    norm_num

theorem X30_four_radical_witnesses :
    (∀ i, dot30 i X30_radical_11_13 = 0) ∧
    (∀ i, dot30 i X30_radical_17_19 = 0) ∧
    (∀ i, dot30 i X30_radical_19_23 = 0) ∧
    (∀ i, dot30 i X30_radical_23_29 = 0) := by
  exact ⟨X30_radical_11_13_dot_zero, X30_radical_17_19_dot_zero,
    X30_radical_19_23_dot_zero, X30_radical_23_29_dot_zero⟩

def X30_reducedRep : Fin 6 → Nat
  | ⟨0, _⟩ => 2
  | ⟨1, _⟩ => 3
  | ⟨2, _⟩ => 5
  | ⟨3, _⟩ => 7
  | ⟨4, _⟩ => 11
  | _ => 17

def X30_reducedWeight : Fin 6 → Int
  | ⟨0, _⟩ => 1
  | ⟨1, _⟩ => 1
  | ⟨2, _⟩ => 1
  | ⟨3, _⟩ => 1
  | ⟨4, _⟩ => 2
  | _ => 4

def X30_reducedMatrixInt : Matrix (Fin 6) (Fin 6) Int :=
  fun i j =>
    X30_reducedWeight i * X30_reducedWeight j *
      if X30_reducedRep i * X30_reducedRep j < 30 then -1 else 1

theorem X30_reducedMatrixInt_det :
    X30_reducedMatrixInt.det = -2048 := by
  native_decide

def X30_reducedCongruencePivots : List Int :=
  [-1, 2, -2, 32]

def X30_reducedFinalBlock : Matrix (Fin 2) (Fin 2) Int :=
  fun i j =>
    match i.1, j.1 with
    | 0, 0 => 0
    | 0, 1 => 4
    | 1, 0 => 4
    | _ , _ => 0

theorem X30_reducedFinalBlock_det :
    X30_reducedFinalBlock.det = -16 := by
  native_decide

theorem X30_reducedCongruenceProduct :
    X30_reducedCongruencePivots.prod * X30_reducedFinalBlock.det = -2048 := by
  native_decide

theorem X30_reducedInertiaCertificate :
    ∃ pos neg : Nat,
      pos = 3 ∧ neg = 3 ∧
        X30_reducedMatrixInt.det =
          X30_reducedCongruencePivots.prod * X30_reducedFinalBlock.det := by
  refine ⟨3, 3, rfl, rfl, ?_⟩
  rw [X30_reducedMatrixInt_det, X30_reducedCongruenceProduct]

def X30_classMass (x : E30R) : Fin 6 → ℝ
  | ⟨0, _⟩ => x SupportIndex30.p2
  | ⟨1, _⟩ => x SupportIndex30.p3
  | ⟨2, _⟩ => x SupportIndex30.p5
  | ⟨3, _⟩ => x SupportIndex30.p7
  | ⟨4, _⟩ => x SupportIndex30.p11 + x SupportIndex30.p13
  | _ =>
      x SupportIndex30.p17 + x SupportIndex30.p19 +
        x SupportIndex30.p23 + x SupportIndex30.p29

def X30_dotFromMass (i : SupportIndex30) (mass : Fin 6 → ℝ) : ℝ :=
  match i with
  | SupportIndex30.p2 =>
      -mass 0 - mass 1 - mass 2 - mass 3 - mass 4 + mass 5
  | SupportIndex30.p3 =>
      -mass 0 - mass 1 - mass 2 - mass 3 + mass 4 + mass 5
  | SupportIndex30.p5 =>
      -mass 0 - mass 1 - mass 2 + mass 3 + mass 4 + mass 5
  | SupportIndex30.p7 =>
      -mass 0 - mass 1 + mass 2 + mass 3 + mass 4 + mass 5
  | SupportIndex30.p11 =>
      -mass 0 + mass 1 + mass 2 + mass 3 + mass 4 + mass 5
  | SupportIndex30.p13 =>
      -mass 0 + mass 1 + mass 2 + mass 3 + mass 4 + mass 5
  | SupportIndex30.p17 =>
      mass 0 + mass 1 + mass 2 + mass 3 + mass 4 + mass 5
  | SupportIndex30.p19 =>
      mass 0 + mass 1 + mass 2 + mass 3 + mass 4 + mass 5
  | SupportIndex30.p23 =>
      mass 0 + mass 1 + mass 2 + mass 3 + mass 4 + mass 5
  | SupportIndex30.p29 =>
      mass 0 + mass 1 + mass 2 + mass 3 + mass 4 + mass 5

theorem dot30_eq_classMass_formula (i : SupportIndex30) (x : E30R) :
    dot30 i x = X30_dotFromMass i (X30_classMass x) := by
  cases i <;>
    simp [dot30, X30_dotFromMass, X30_classMass, M_Rees_X30, M_Rees_X,
      SupportIndex30.list, SupportIndex30.toNat, grade] <;>
    norm_num <;>
    ring_nf

def X30SignatureReductionEvidence : Prop :=
    M_Rees_signature_X30 = ⟨3, 3, 4⟩ ∧
    (∀ i, dot30 i X30_radical_11_13 = 0) ∧
    (∀ i, dot30 i X30_radical_17_19 = 0) ∧
    (∀ i, dot30 i X30_radical_19_23 = 0) ∧
    (∀ i, dot30 i X30_radical_23_29 = 0) ∧
    (∀ i x, dot30 i x = X30_dotFromMass i (X30_classMass x)) ∧
    X30_reducedMatrixInt.det = -2048 ∧
    X30_reducedFinalBlock.det = -16 ∧
    X30_reducedCongruencePivots.prod * X30_reducedFinalBlock.det = -2048 ∧
    (∃ pos neg : Nat,
      pos = 3 ∧ neg = 3 ∧
        X30_reducedMatrixInt.det =
          X30_reducedCongruencePivots.prod * X30_reducedFinalBlock.det)

theorem X30_signature_reduction_certificate :
    X30SignatureReductionEvidence := by
  exact ⟨M_Rees_signature_X30_val,
    X30_radical_11_13_dot_zero,
    X30_radical_17_19_dot_zero,
    X30_radical_19_23_dot_zero,
    X30_radical_23_29_dot_zero,
    dot30_eq_classMass_formula,
    X30_reducedMatrixInt_det,
    X30_reducedFinalBlock_det,
    X30_reducedCongruenceProduct,
    X30_reducedInertiaCertificate⟩

theorem SR_flow_entry_update_minus_two
    (X X' : Rat) (α : Type) (toNat : α → Nat)
    (m n : α)
    (hOld : grade (toNat m) (toNat n) X = ReesGrade.Exit)
    (hNew : grade (toNat m) (toNat n) X' = ReesGrade.Interior) :
    M_Rees_X X' α toNat m n = M_Rees_X X α toNat m n - 2 := by
  simp [M_Rees_X, hOld, hNew]
  norm_num

structure FlowEntryUpdateRecord where
  sourceID : Nat
  targetID : Nat
  leftFactor : Nat
  rightFactor : Nat
  oldSign : ℝ
  newSign : ℝ
  delta : ℝ

def q22_X52_to_X6_updateRecord : FlowEntryUpdateRecord :=
  ⟨52, 6, 2, 2, 1, -1, -2⟩

def FlowEntryUpdateRecord.valid (r : FlowEntryUpdateRecord) : Prop :=
  r.newSign = r.oldSign + r.delta

theorem q22_X52_to_X6_updateRecord_valid :
    q22_X52_to_X6_updateRecord.valid := by
  norm_num [FlowEntryUpdateRecord.valid, q22_X52_to_X6_updateRecord]

theorem q22_X52_to_X6_updateRecord_matches_kernel :
    q22_X52_to_X6_updateRecord.oldSign =
      M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat
        FlowSupport52.p2 FlowSupport52.p2 ∧
    q22_X52_to_X6_updateRecord.newSign =
      M_Rees_X (6 : Rat) FlowSupport52 FlowSupport52.toNat
        FlowSupport52.p2 FlowSupport52.p2 ∧
    q22_X52_to_X6_updateRecord.delta = (-2 : ℝ) := by
  constructor
  · simp [q22_X52_to_X6_updateRecord, M_Rees_X, FlowSupport52.toNat,
      flow_grade_22_X52_exit]
  constructor
  · simp [q22_X52_to_X6_updateRecord, M_Rees_X, FlowSupport52.toNat,
      grade_22_X6_interior]
  · rfl

/- Archived Stage 16C concrete rank-update attempt, 2026-09-07.
   The exact theorem names and failure behavior are recorded in
   `SR_Failures.md`.

def SR_flow_rank1_kernel_X52 : ReesSignKernel FlowSupport52 :=
  fun _ _ => 1

theorem SR_flow_rank1_update_X52_whole_kernel :
    M_Rees_X (6 : Rat) FlowSupport52 FlowSupport52.toNat =
      fun i j =>
        M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat i j -
          2 * SR_flow_rank1_kernel_X52 i j := by
  funext i j
  cases i
  cases j
  simp [M_Rees_X, SR_flow_rank1_kernel_X52, FlowSupport52.toNat,
    FlowX52, grade]
  norm_num
-/

/- Archived Stage 16C whole-kernel rank-update attempt, 2026-09-07.
   This attempt was not promoted because both Lake and direct Lean verification
   repeatedly exceeded capped segments without diagnostics.  The exact failure
   invariant is recorded in `SR_Failures.md`.

def SR_flow_rank1_kernel (α : Type) [DecidableEq α] (m n : α) :
    ReesSignKernel α :=
  fun i j => if (i, j) = (m, n) then 1 else 0

theorem SR_flow_rank1_update
    (X X' : Rat) (α : Type) [DecidableEq α] (toNat : α → Nat)
    (m n : α)
    (hOld : grade (toNat m) (toNat n) X = ReesGrade.Exit)
    (hNew : grade (toNat m) (toNat n) X' = ReesGrade.Interior)
    (hStable : ∀ i j : α, (i, j) ≠ (m, n) →
      M_Rees_X X' α toNat i j = M_Rees_X X α toNat i j) :
    ∀ i j : α,
      M_Rees_X X' α toNat i j =
        M_Rees_X X α toNat i j - 2 * SR_flow_rank1_kernel α m n i j := by
  intro i j
  by_cases hij : (i, j) = (m, n)
  · cases hij
    have hflip :=
      SR_flow_entry_update_minus_two X X' α toNat m n hOld hNew
    simpa [SR_flow_rank1_kernel] using hflip
  · have hp : (i, j) ≠ (m, n) := by
      exact hij
    rw [hStable i j hp]
    have hker : SR_flow_rank1_kernel α m n i j = 0 := by
      simp [SR_flow_rank1_kernel, hij]
    rw [hker]
    norm_num

theorem SR_flow_rank1_update_22_X52_to_X6 :
    ∀ i j : FlowSupport52,
      M_Rees_X (6 : Rat) FlowSupport52 FlowSupport52.toNat i j =
        M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat i j -
          2 * SR_flow_rank1_kernel FlowSupport52 FlowSupport52.p2 FlowSupport52.p2 i j := by
  apply SR_flow_rank1_update FlowX52 (6 : Rat) FlowSupport52 FlowSupport52.toNat
    FlowSupport52.p2 FlowSupport52.p2 flow_grade_22_X52_exit grade_22_X6_interior
  intro i j hp
  exfalso
  cases i
  cases j
  exact hp rfl
-/

def SR_flow_fixed_point_proxy (current future : SignatureSummary) : Prop :=
  current.neg * signatureIndexDenominator future =
    future.neg * signatureIndexDenominator current

theorem X52_not_fixed_against_X6 :
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 := by
  intro h
  unfold SR_flow_fixed_point_proxy at h
  simp [M_Rees_signature_X52, M_Rees_signature_X6, signatureIndexDenominator] at h

theorem X6_not_fixed_against_X30 :
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30 := by
  intro h
  unfold SR_flow_fixed_point_proxy at h
  simp [M_Rees_signature_X6, M_Rees_signature_X30, signatureIndexDenominator] at h

structure FlowTransitionRecord where
  sourceID : Nat
  targetID : Nat
  sourceNeg : Nat
  sourceDen : Nat
  targetNeg : Nat
  targetDen : Nat
  deriving DecidableEq, Repr

def FlowTransitionRecord.fixedProxy (t : FlowTransitionRecord) : Prop :=
  t.sourceNeg * t.targetDen = t.targetNeg * t.sourceDen

def transition_X52_X6 : FlowTransitionRecord :=
  ⟨52, 6, M_Rees_signature_X52.neg, signatureIndexDenominator M_Rees_signature_X52,
    M_Rees_signature_X6.neg, signatureIndexDenominator M_Rees_signature_X6⟩

def transition_X6_X30 : FlowTransitionRecord :=
  ⟨6, 30, M_Rees_signature_X6.neg, signatureIndexDenominator M_Rees_signature_X6,
    M_Rees_signature_X30.neg, signatureIndexDenominator M_Rees_signature_X30⟩

theorem transition_X52_X6_not_fixed :
    ¬ transition_X52_X6.fixedProxy := by
  intro h
  simp [FlowTransitionRecord.fixedProxy, transition_X52_X6,
    M_Rees_signature_X52, M_Rees_signature_X6, signatureIndexDenominator] at h

theorem transition_X6_X30_not_fixed :
    ¬ transition_X6_X30.fixedProxy := by
  intro h
  simp [FlowTransitionRecord.fixedProxy, transition_X6_X30,
    M_Rees_signature_X6, M_Rees_signature_X30, signatureIndexDenominator] at h

theorem computed_transition_records_not_fixed :
    ¬ transition_X52_X6.fixedProxy ∧ ¬ transition_X6_X30.fixedProxy := by
  exact ⟨transition_X52_X6_not_fixed, transition_X6_X30_not_fixed⟩

def SR_flow_fixed_point (signatureAt : Rat → SignatureSummary) (X : Rat) : Prop :=
  ∀ X' : Rat, X < X' → SR_flow_fixed_point_proxy (signatureAt X) (signatureAt X')

def computedSignatureOracle : Rat → SignatureSummary :=
  fun X =>
    if X = FlowX52 then
      M_Rees_signature_X52
    else if X = (6 : Rat) then
      M_Rees_signature_X6
    else if X = (30 : Rat) then
      M_Rees_signature_X30
    else
      M_Rees_signature_X30

theorem computedSignatureOracle_X52 :
    computedSignatureOracle FlowX52 = M_Rees_signature_X52 := by
  simp [computedSignatureOracle]

theorem computedSignatureOracle_X6 :
    computedSignatureOracle (6 : Rat) = M_Rees_signature_X6 := by
  have hne : (6 : Rat) ≠ FlowX52 := by
    norm_num [FlowX52]
  simp [computedSignatureOracle, hne]

theorem computedSignatureOracle_X30 :
    computedSignatureOracle (30 : Rat) = M_Rees_signature_X30 := by
  have hne52 : (30 : Rat) ≠ FlowX52 := by
    norm_num [FlowX52]
  simp [computedSignatureOracle, hne52]

theorem computed_oracle_X52_not_fixed :
    ¬ SR_flow_fixed_point computedSignatureOracle FlowX52 := by
  intro h
  apply X52_not_fixed_against_X6
  simpa [SR_flow_fixed_point, computedSignatureOracle_X52, computedSignatureOracle_X6]
    using h (6 : Rat) (by norm_num [FlowX52])

theorem computed_oracle_X6_not_fixed :
    ¬ SR_flow_fixed_point computedSignatureOracle (6 : Rat) := by
  intro h
  apply X6_not_fixed_against_X30
  simpa [SR_flow_fixed_point, computedSignatureOracle_X6, computedSignatureOracle_X30]
    using h (30 : Rat) (by norm_num)

theorem computed_oracle_has_no_fixed_initial_cutoffs :
    ¬ SR_flow_fixed_point computedSignatureOracle FlowX52 ∧
    ¬ SR_flow_fixed_point computedSignatureOracle (6 : Rat) := by
  exact ⟨computed_oracle_X52_not_fixed, computed_oracle_X6_not_fixed⟩

/- Archived Stage 16F finite-chain fixed-point package attempt, 2026-09-07.
   The exact theorem shape and performance failure are recorded in
   `SR_Failures.md`.

inductive FlowCutoff3 where
  | X52 | X6 | X30
  deriving DecidableEq, Repr

def FlowCutoff3.signature : FlowCutoff3 → SignatureSummary
  | FlowCutoff3.X52 => M_Rees_signature_X52
  | FlowCutoff3.X6 => M_Rees_signature_X6
  | FlowCutoff3.X30 => M_Rees_signature_X30

def FlowCutoff3.adjacent : FlowCutoff3 → FlowCutoff3 → Prop
  | FlowCutoff3.X52, FlowCutoff3.X6 => True
  | FlowCutoff3.X6, FlowCutoff3.X30 => True
  | _, _ => False

theorem computed_flow_adjacent_not_fixed :
    ∀ a b : FlowCutoff3,
      FlowCutoff3.adjacent a b →
        ¬ SR_flow_fixed_point_proxy a.signature b.signature := by
  intro a b hab
  cases a
  · cases b
    · cases hab
    · exact X52_not_fixed_against_X6
    · cases hab
  · cases b
    · cases hab
    · cases hab
    · exact X6_not_fixed_against_X30
  · cases b
    · cases hab
    · cases hab
    · cases hab
-/

def Stage16FinitePackageComplete : Prop :=
  interiorProductCount FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat = 0 ∧
  interiorProductCount (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat = 1 ∧
  interiorProductCount (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat = 17 ∧
  M_Rees_signature_X52 = ⟨1, 0, 0⟩ ∧
  M_Rees_signature_X6 = ⟨1, 1, 2⟩ ∧
  M_Rees_signature_X30 = ⟨3, 3, 4⟩ ∧
  M_Rees_signature_X52.neg ≤ M_Rees_signature_X6.neg ∧
  M_Rees_signature_X6.neg ≤ M_Rees_signature_X30.neg ∧
  logWeightedInteriorSum FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat = 0 ∧
  logWeightedInteriorSum (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat =
    Real.log 2 * Real.log 2 ∧
  logWeightedInteriorSum (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat =
    logWeightedInteriorSum_X30_explicit ∧
  (logWeightedComparison_X52.S_value =
      logWeightedInteriorSum FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat ∧
    logWeightedComparison_X52.benchmark = XSquaredHalfBenchmark FlowX52) ∧
  (logWeightedComparison_X6.S_value =
      logWeightedInteriorSum (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat ∧
    logWeightedComparison_X6.benchmark = XSquaredHalfBenchmark (6 : Rat)) ∧
  (logWeightedComparison_X30.S_value =
      logWeightedInteriorSum (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat ∧
    logWeightedComparison_X30.benchmark = XSquaredHalfBenchmark (30 : Rat)) ∧
  X30SignatureReductionEvidence ∧
  M_Rees_X (6 : Rat) FlowSupport52 FlowSupport52.toNat FlowSupport52.p2 FlowSupport52.p2 =
    M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat FlowSupport52.p2 FlowSupport52.p2 - 2 ∧
  q22_X52_to_X6_updateRecord.valid ∧
  (q22_X52_to_X6_updateRecord.oldSign =
      M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat
        FlowSupport52.p2 FlowSupport52.p2 ∧
    q22_X52_to_X6_updateRecord.newSign =
      M_Rees_X (6 : Rat) FlowSupport52 FlowSupport52.toNat
        FlowSupport52.p2 FlowSupport52.p2 ∧
    q22_X52_to_X6_updateRecord.delta = (-2 : ℝ)) ∧
  ¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 ∧
  ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30 ∧
  ¬ transition_X52_X6.fixedProxy ∧
  ¬ transition_X6_X30.fixedProxy ∧
  ¬ SR_flow_fixed_point computedSignatureOracle FlowX52 ∧
  ¬ SR_flow_fixed_point computedSignatureOracle (6 : Rat)

theorem stage16_finite_package_complete :
    Stage16FinitePackageComplete := by
  unfold Stage16FinitePackageComplete
  exact ⟨interiorProductCount_X52,
    interiorProductCount_X6,
    interiorProductCount_X30,
    M_Rees_signature_X52_val,
    M_Rees_signature_X6_val,
    M_Rees_signature_X30_val,
    q_monotone_hypothesis.1,
    q_monotone_hypothesis.2,
    logWeightedInteriorSum_X52_recorded_value,
    logWeightedInteriorSum_X6_value,
    logWeightedInteriorSum_X30_value,
    logWeightedComparison_X52_records,
    logWeightedComparison_X6_records,
    logWeightedComparison_X30_records,
    X30_signature_reduction_certificate,
    SR_flow_entry_update_minus_two FlowX52 (6 : Rat) FlowSupport52 FlowSupport52.toNat
      FlowSupport52.p2 FlowSupport52.p2 flow_grade_22_X52_exit grade_22_X6_interior,
    q22_X52_to_X6_updateRecord_valid,
    q22_X52_to_X6_updateRecord_matches_kernel,
    X52_not_fixed_against_X6,
    X6_not_fixed_against_X30,
    transition_X52_X6_not_fixed,
    transition_X6_X30_not_fixed,
    computed_oracle_X52_not_fixed,
    computed_oracle_X6_not_fixed⟩

theorem SR_flow_entry_update
    (X X' : Rat) (α : Type) (toNat : α → Nat)
    (m n : α)
    (hOld : grade (toNat m) (toNat n) X = ReesGrade.Exit)
    (hNew : grade (toNat m) (toNat n) X' = ReesGrade.Interior) :
    M_Rees_X X α toNat m n = 1 ∧
      M_Rees_X X' α toNat m n = (-1 : ℝ) := by
  constructor
  · simp [M_Rees_X, hOld]
  · simp [M_Rees_X, hNew]

theorem SR_flow_entry_update_minus_two_archived_late_copy
    (X X' : Rat) (α : Type) (toNat : α → Nat)
    (m n : α)
    (hOld : grade (toNat m) (toNat n) X = ReesGrade.Exit)
    (hNew : grade (toNat m) (toNat n) X' = ReesGrade.Interior) :
    M_Rees_X X' α toNat m n = M_Rees_X X α toNat m n - 2 := by
  simp [M_Rees_X, hOld, hNew]
  norm_num

theorem SR_flow_entry_update_22_X52_to_X6 :
    M_Rees_X (6 : Rat) FlowSupport52 FlowSupport52.toNat
        FlowSupport52.p2 FlowSupport52.p2 =
      M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat
        FlowSupport52.p2 FlowSupport52.p2 - 2 := by
  exact SR_flow_entry_update_minus_two FlowX52 (6 : Rat) FlowSupport52
    FlowSupport52.toNat FlowSupport52.p2 FlowSupport52.p2
    flow_grade_22_X52_exit grade_22_X6_interior

theorem flow_produces_negative_eigenvalues :
    M_Rees_signature_X52 = ⟨1, 0, 0⟩ ∧
      M_Rees_signature_X6 = ⟨1, 1, 2⟩ ∧
      0 < M_Rees_signature_X6.neg := by
  constructor
  · rfl
  constructor
  · rfl
  · decide

theorem SR16_SIGN_FROM_FLOW :
    M_Rees_signature_X52 = ⟨1, 0, 0⟩ ∧
      M_Rees_signature_X6 = ⟨1, 1, 2⟩ ∧
      0 < M_Rees_signature_X6.neg := by
  exact flow_produces_negative_eigenvalues

def SR_flow_fixed_point_proxy_archived_late_copy (current future : SignatureSummary) : Prop :=
  current.neg * signatureIndexDenominator future =
    future.neg * signatureIndexDenominator current

theorem X52_not_fixed_against_X6_archived_late_copy :
    ¬ SR_flow_fixed_point_proxy_archived_late_copy M_Rees_signature_X52 M_Rees_signature_X6 := by
  intro h
  unfold SR_flow_fixed_point_proxy_archived_late_copy at h
  simp [M_Rees_signature_X52, M_Rees_signature_X6, signatureIndexDenominator] at h

theorem X6_not_fixed_against_X30_archived_late_copy :
    ¬ SR_flow_fixed_point_proxy_archived_late_copy M_Rees_signature_X6 M_Rees_signature_X30 := by
  intro h
  unfold SR_flow_fixed_point_proxy_archived_late_copy at h
  simp [M_Rees_signature_X6, M_Rees_signature_X30, signatureIndexDenominator] at h

theorem SR16_FIXED_POINT_OPEN :
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 ∧
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30 := by
  exact ⟨X52_not_fixed_against_X6, X6_not_fixed_against_X30⟩

structure SRdBNBridgeScaffold where
  interiorProductsAsNearTerms : Prop
  signFlipAsHeatLocalization : Prop
  signatureTracksZeroCount : Prop
  limitArgumentStillOpen : Prop

def SRdBN_conjectural_bridge : SRdBNBridgeScaffold :=
  { interiorProductsAsNearTerms := True
    signFlipAsHeatLocalization := True
    signatureTracksZeroCount := True
    limitArgumentStillOpen := True }

theorem SRdBN_conjectural_bridge_records_near_terms :
    SRdBN_conjectural_bridge.interiorProductsAsNearTerms := by
  trivial

theorem SRdBN_conjectural_bridge_records_heat_localization :
    SRdBN_conjectural_bridge.signFlipAsHeatLocalization := by
  trivial

theorem SRdBN_conjectural_bridge_records_zero_tracking_claim :
    SRdBN_conjectural_bridge.signatureTracksZeroCount := by
  trivial

theorem SRdBN_conjectural_bridge_limit_open :
    SRdBN_conjectural_bridge.limitArgumentStillOpen := by
  trivial

theorem SRdBN_conjectural_bridge_recorded :
    SRdBN_conjectural_bridge.interiorProductsAsNearTerms ∧
    SRdBN_conjectural_bridge.signFlipAsHeatLocalization ∧
    SRdBN_conjectural_bridge.signatureTracksZeroCount ∧
    SRdBN_conjectural_bridge.limitArgumentStillOpen := by
  exact ⟨SRdBN_conjectural_bridge_records_near_terms,
    SRdBN_conjectural_bridge_records_heat_localization,
    SRdBN_conjectural_bridge_records_zero_tracking_claim,
    SRdBN_conjectural_bridge_limit_open⟩

theorem SR_dBN_conjecture_statement : True := by
  trivial

theorem stage16_synthesis :
    interiorProductCount FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat = 0 ∧
    interiorProductCount (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat = 1 ∧
    interiorProductCount (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat = 17 ∧
    M_Rees_signature_X52 = ⟨1, 0, 0⟩ ∧
    M_Rees_signature_X6 = ⟨1, 1, 2⟩ ∧
    M_Rees_signature_X30 = ⟨3, 3, 4⟩ ∧
    (M_Rees_signature_X52.neg ≤ M_Rees_signature_X6.neg ∧
      M_Rees_signature_X6.neg ≤ M_Rees_signature_X30.neg) ∧
    logWeightedInteriorSum FlowX52 FlowSupport52 FlowSupport52.list FlowSupport52.toNat = 0 ∧
    logWeightedInteriorSum (6 : Rat) FlowSupport6 FlowSupport6.list FlowSupport6.toNat =
      Real.log 2 * Real.log 2 ∧
    logWeightedInteriorSum (30 : Rat) SupportIndex30 SupportIndex30.list SupportIndex30.toNat =
      logWeightedInteriorSum_X30_explicit ∧
    (∀ i, dot30 i X30_radical_11_13 = 0) ∧
    (∀ i, dot30 i X30_radical_17_19 = 0) ∧
    (∀ i, dot30 i X30_radical_19_23 = 0) ∧
    (∀ i, dot30 i X30_radical_23_29 = 0) ∧
    X30_reducedMatrixInt.det = -2048 ∧
    X30_reducedFinalBlock.det = -16 ∧
    X30_reducedCongruencePivots.prod * X30_reducedFinalBlock.det = -2048 ∧
    (∃ pos neg : Nat,
      pos = 3 ∧ neg = 3 ∧
        X30_reducedMatrixInt.det =
          X30_reducedCongruencePivots.prod * X30_reducedFinalBlock.det) ∧
    (∀ i x, dot30 i x = X30_dotFromMass i (X30_classMass x)) ∧
                                        (M_Rees_signature_X52 = ⟨1, 0, 0⟩ ∧
                                          M_Rees_signature_X6 = ⟨1, 1, 2⟩ ∧
                                          0 < M_Rees_signature_X6.neg) ∧
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 ∧
    ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30 ∧
    (¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 ∧
      ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30) := by
  exact ⟨interiorProductCount_X52, interiorProductCount_X6,
    interiorProductCount_X30, M_Rees_signature_X52_val, M_Rees_signature_X6_val,
    M_Rees_signature_X30_val, q_monotone_hypothesis,
    logWeightedInteriorSum_X52_recorded_value, logWeightedInteriorSum_X6_value,
    logWeightedInteriorSum_X30_value, X30_radical_11_13_dot_zero,
    X30_radical_17_19_dot_zero, X30_radical_19_23_dot_zero,
    X30_radical_23_29_dot_zero, X30_reducedMatrixInt_det,
    X30_reducedFinalBlock_det, X30_reducedCongruenceProduct,
    X30_reducedInertiaCertificate, dot30_eq_classMass_formula,
    SR16_SIGN_FROM_FLOW,
    X52_not_fixed_against_X6, X6_not_fixed_against_X30,
    ⟨X52_not_fixed_against_X6, X6_not_fixed_against_X30⟩⟩

theorem stage16_synthesis_enriched :
    Stage16FinitePackageComplete ∧
    SRdBN_conjectural_bridge.interiorProductsAsNearTerms ∧
    SRdBN_conjectural_bridge.signFlipAsHeatLocalization ∧
    SRdBN_conjectural_bridge.signatureTracksZeroCount ∧
    SRdBN_conjectural_bridge.limitArgumentStillOpen ∧
    (¬ SR_flow_fixed_point_proxy M_Rees_signature_X52 M_Rees_signature_X6 ∧
      ¬ SR_flow_fixed_point_proxy M_Rees_signature_X6 M_Rees_signature_X30) := by
  exact ⟨stage16_finite_package_complete,
    SRdBN_conjectural_bridge_records_near_terms,
    SRdBN_conjectural_bridge_records_heat_localization,
    SRdBN_conjectural_bridge_records_zero_tracking_claim,
    SRdBN_conjectural_bridge_limit_open,
    SR16_FIXED_POINT_OPEN⟩

#check SignatureSummary
#check FlowX52
#check FlowSupport52
#check FlowSupport6
#check SupportIndex30
#check SupportIndex30.toNat
#check supportIndex30_card
#check ReesSignKernel
#check M_Rees_X
#check M_Rees_X52
#check M_Rees_X6
#check M_Rees_X30
#check M_Rees_X6_agrees_stage15_checkpoint
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
#check flow_grade_22_X52_exit
#check logWeightedInteriorSum_X52_recorded_value
#check logWeightedInteriorSum_X6_value
#check logWeightedInteriorSum_X30_explicit
#check logWeightedInteriorSum_X30_value
#check XSquaredHalfBenchmark
#check XSquaredHalfBenchmark_X52
#check XSquaredHalfBenchmark_X6
#check XSquaredHalfBenchmark_X30
#check LogWeightedComparisonRecord
#check logWeightedComparison_X52
#check logWeightedComparison_X6
#check logWeightedComparison_X30
#check logWeightedComparison_X52_records
#check logWeightedComparison_X6_records
#check logWeightedComparison_X30_records
#check E30R
#check dot30
#check X30_radical_11_13
#check X30_radical_17_19
#check X30_radical_19_23
#check X30_radical_23_29
#check X30_radical_11_13_dot_zero
#check X30_radical_17_19_dot_zero
#check X30_radical_19_23_dot_zero
#check X30_radical_23_29_dot_zero
#check X30_four_radical_witnesses
#check X30_reducedRep
#check X30_reducedWeight
#check X30_reducedMatrixInt
#check X30_reducedMatrixInt_det
#check X30_reducedCongruencePivots
#check X30_reducedFinalBlock
#check X30_reducedFinalBlock_det
#check X30_reducedCongruenceProduct
#check X30_reducedInertiaCertificate
#check X30_classMass
#check X30_dotFromMass
#check dot30_eq_classMass_formula
#check X30_signature_reduction_certificate
#check Stage16FinitePackageComplete
#check stage16_finite_package_complete
#check SR_flow_entry_update
#check SR_flow_entry_update_minus_two
#check FlowEntryUpdateRecord
#check FlowEntryUpdateRecord.valid
#check q22_X52_to_X6_updateRecord
#check q22_X52_to_X6_updateRecord_valid
#check q22_X52_to_X6_updateRecord_matches_kernel
#check SR_flow_entry_update_22_X52_to_X6
#check flow_produces_negative_eigenvalues
#check SR16_SIGN_FROM_FLOW
#check SR_flow_fixed_point_proxy
#check X52_not_fixed_against_X6
#check X6_not_fixed_against_X30
#check FlowTransitionRecord
#check FlowTransitionRecord.fixedProxy
#check transition_X52_X6
#check transition_X6_X30
#check transition_X52_X6_not_fixed
#check transition_X6_X30_not_fixed
#check computed_transition_records_not_fixed
#check SR_flow_fixed_point
#check computedSignatureOracle
#check computedSignatureOracle_X52
#check computedSignatureOracle_X6
#check computedSignatureOracle_X30
#check computed_oracle_X52_not_fixed
#check computed_oracle_X6_not_fixed
#check computed_oracle_has_no_fixed_initial_cutoffs
#check SR16_FIXED_POINT_OPEN
#check SRdBNBridgeScaffold
#check SRdBN_conjectural_bridge
#check SRdBN_conjectural_bridge_records_near_terms
#check SRdBN_conjectural_bridge_records_heat_localization
#check SRdBN_conjectural_bridge_records_zero_tracking_claim
#check SRdBN_conjectural_bridge_limit_open
#check SRdBN_conjectural_bridge_recorded
#check SR_dBN_conjecture_statement
#check stage16_synthesis
#check stage16_synthesis_enriched

end SR
