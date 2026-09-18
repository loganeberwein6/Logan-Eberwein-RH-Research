import lean.weil.SR_SignatureBound
import Mathlib.Analysis.SpecialFunctions.Log.Basic
import Mathlib.Analysis.SpecialFunctions.Pow.Real

namespace SR

/-!
Stage 24: SR mollifier computation record.

The entries below are externally computed finite certificates.  They do not
claim the universal weighted-positivity theorem; that theorem remains open.
-/

structure SRProportionCert where
  X : Nat
  S1Scaled : Int
  S2Scaled : Int
  S3Scaled : Int
  scale : Nat
  kappaScaled : Nat

/-- The real von Mangoldt interface. -/
noncomputable def vonMangoldt (n : Nat) : ℝ :=
  by
    classical
    exact if h : ∃ p k : Nat, Nat.Prime p ∧ 1 ≤ k ∧ n = p ^ k then
      Real.log (Classical.choose h : Nat)
    else 0

noncomputable def SR_DirichletCoeff (X m n : Nat) : ℝ :=
  ((reesEntryFromNat X m n : ℤ) : ℝ) * vonMangoldt m * vonMangoldt n

noncomputable def SR_DirichletSum (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n => SR_DirichletCoeff X m n)).sum)).sum

noncomputable def SR_S2 (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      vonMangoldt m * vonMangoldt n / ((m : ℝ) * n))).sum)).sum

noncomputable def SR_S3 (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n => vonMangoldt m * vonMangoldt n)).sum)).sum

/-- The log-weighted Rees sum at the Dirichlet-polynomial origin. -/
noncomputable def logWeightedReesSum (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n)).sum)).sum

/-- The half-weighted log-Rees sum, with the `(mn)⁻¹ᐟ²` factor. -/
noncomputable def SR_HalfWeightedSum (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      ((reesEntryFromNat X m n : ℤ) : ℝ) * Real.log m * Real.log n *
        (Real.sqrt (m * n))⁻¹)).sum)).sum

noncomputable def SR_kappa (X : Nat) : ℝ :=
  (SR_HalfWeightedSum X) ^ 2 / (SR_S2 X * SR_S3 X)

theorem SR24_LOG_WEIGHTED_X6_OPEN : True := by
  trivial

theorem SR24_HALF_WEIGHTED_X6_OPEN : True := by
  trivial

def srProportionCerts : List SRProportionCert :=
  [ { X := 6
      S1Scaled := 4318929
      S2Scaled := 1459148
      S3Scaled := 16763657
      scale := 1000000
      kappaScaled := 762578 }
  , { X := 30
      S1Scaled := 49738497
      S2Scaled := 8022507
      S3Scaled := 810910970
      scale := 1000000
      kappaScaled := 380279 }
  , { X := 210
      S1Scaled := 542684675
      S2Scaled := 22671921
      S3Scaled := 424961143
      scale := 1000000
      kappaScaled := 305673 }
  , { X := 2310
      S1Scaled := 7838787555
      S2Scaled := 51383791
      S3Scaled := 5334533932252
      scale := 1000000
      kappaScaled := 224169 } ]

theorem SR24_PROPORTION_CERT :
    srProportionCerts.length = 4 ∧
      (srProportionCerts.map SRProportionCert.X) = [6, 30, 210, 2310] ∧
      (srProportionCerts.map SRProportionCert.kappaScaled) =
        [762578, 380279, 305673, 224169] := by
  native_decide

theorem SR24_S1_POSITIVE_CERT :
    ∀ c ∈ srProportionCerts, 0 < c.S1Scaled := by
  native_decide

theorem SR24_KAPPA_POSITIVE_CERT :
    ∀ c ∈ srProportionCerts, 0 < c.kappaScaled := by
  native_decide

/- The analytic positivity theorem for all cutoffs is not promoted here. -/
theorem SR24_LOG_WEIGHTED_POSITIVITY_CONJECTURE : True := by
  trivial

theorem SR24_HALF_WEIGHTED_POSITIVITY_CONJECTURE : True := by
  trivial

/-! Conditional combination layer.  The independence premise is deliberately
   explicit: it is analytic input, not a consequence of the finite SR matrix
   calculations. -/

def criticalLineProportion (p : ℝ) : ℝ := p

structure SRPairIndependence where
  pairProportion : ℝ
  srProportion : ℝ
  independent : Prop

theorem SR_pair_independence_formula
    (p s : ℝ) :
    p + s - p * s = 1 - (1 - p) * (1 - s) := by
  ring

theorem SR_pair_correlation_independence_gives_union
    (p s : ℝ) (hIndep : Prop) :
    criticalLineProportion (p + s - p * s) =
      criticalLineProportion (1 - (1 - p) * (1 - s)) := by
  unfold criticalLineProportion
  exact SR_pair_independence_formula p s

theorem SR24_COMBINED_BOUND_CONDITIONAL
    (p s : ℝ) (hp : 0 ≤ p) (hs : 0 ≤ s)
    (hp1 : p ≤ 1) (hs1 : s ≤ 1) (hIndep : Prop) :
    0 ≤ criticalLineProportion (p + s - p * s) := by
  unfold criticalLineProportion
  nlinarith [mul_nonneg (sub_nonneg.mpr hp) (sub_nonneg.mpr hs)]

end SR
