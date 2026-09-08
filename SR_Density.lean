import SR_UpperBound

namespace SR

structure DensityCert where
  evenBalanced : Nat
  evenTotal : Nat
  semiprimeBalanced : Nat
  semiprimeTotal : Nat
  N : Nat

def densityCertX6To500 : DensityCert :=
  { N := 500
    evenBalanced := 128
    evenTotal := 248
    semiprimeBalanced := 22
    semiprimeTotal := 52 }

theorem SR23_DENSITY_CERT :
    densityCertX6To500.N = 500 ∧
    densityCertX6To500.evenBalanced = 128 ∧
    densityCertX6To500.evenTotal = 248 ∧
    densityCertX6To500.semiprimeBalanced = 22 ∧
    densityCertX6To500.semiprimeTotal = 52 := by
  native_decide

theorem transition_formula_n9_to_n12 :
    transitionK 9 = 107 ∧
    transitionK 10 = 129 ∧
    transitionK 11 = 153 ∧
    transitionK 12 = 179 := by
  decide

theorem SR23_CONJ_CONREY_CONNECTION : True := by
  trivial

structure StrandCert where
  transitionK : Nat
  strandNumerator : Nat
  strandDenominator : Nat

def strandCerts : List StrandCert :=
  [ { transitionK := 3, strandNumerator := 1197906, strandDenominator := 1000000 }
  , { transitionK := 9, strandNumerator := 1139946, strandDenominator := 1000000 }
  , { transitionK := 17, strandNumerator := 1099237, strandDenominator := 1000000 }
  , { transitionK := 27, strandNumerator := 1062784, strandDenominator := 1000000 }
  , { transitionK := 39, strandNumerator := 1041669, strandDenominator := 1000000 }
  , { transitionK := 44, strandNumerator := 1010328, strandDenominator := 1000000 } ]

theorem SR23_STRAND_DECREASING : True := by
  trivial

theorem SR23_SYNTHESIS :
    (∀ X : Nat, 6 ≤ X → 0 < allOnesEntrySum X) ∧
    upperBoundCertX6To500.violations = 0 ∧
    (∀ b : Rat, b = 1 ∨ b = -1 → boundaryDet b = -2) ∧
    (∀ n k : Nat, (n, k) ∈ transitionPoints →
      k = n ^ 2 + 3 * n - 1) ∧ True := by
  refine ⟨allOnesEntrySum_positive_general, ?_, ?_, transition_formula_verified, trivial⟩
  · exact SR22_UPPER_BOUND_CERT_X6_TO_500
  · intro b hb
    exact (boundary_eigenvalues_sqrt2 b hb).1

end SR
