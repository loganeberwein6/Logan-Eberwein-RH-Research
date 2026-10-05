# Known Issues and Corrections

## Mathematical errors in the original paper (RH_Progress_Report.tex)

### 1. Möbius sign error

The paper stated μ(2)log2 > 0 as an example of a positive diagonal entry.
This is wrong: μ(2) = -1, so μ(2)log2 = -log2 < 0.
The corrected paper removes this claim and narrows the theorem appropriately.

### 2. "No PSD realization" theorem is tautological

The theorem states that no everywhere-nonnegative function can equal
a function that takes negative values. This is true but trivial.
It does not exclude compressions, restrictions, or other transformations.
The corrected paper relabels this as an observation.

### 3. W_SR_RH_bridge and → True theorems

Several files (SR_ISR.lean, SR_WEntropy.lean) contain theorems of the form
theorem X : A → True
These compile but prove nothing. They have been removed or relabeled in
the cleanup commit.

### 4. GNS positivity

The theorem labeled "GNS positivity" reduces to |x₂₂|² ≥ 0.
This is not a GNS reconstruction theorem. The name is inflated.
The corrected framing describes it as a coordinate norm positivity lemma.

### 5. L(Λ,s) = -ζ'/ζ is a Mathlib theorem

This result is proved by a one-line application of an existing Mathlib theorem
(ArithmeticFunction.LSeries_vonMangoldt_eq_deriv_riemannZeta_div).
It is not an original project contribution.

## Repository anti-patterns documented

See the paper for full analysis. Key patterns:

- Proxy drift: threshold matrix ≠ Rees matrix
- Semantic inflation: GNS, coercivity, RH bridge terminology
- Compilation as optimization target
- Library result laundering
- Finite-to-analytic slippage with no proved bridge

## October 2026 revision

6. The September report described the program as multi-year; it is a one-year program.
7. The September report said the repository contains 7 Lean files. It contains 16 modules, all declared in `lakefile.lean`.
8. Six statements had no Lean source in this repository but were labeled LEAN-VERIFIED: the von Mangoldt and convolution L-series identities, the finite Mellin kernels, the ratio-channel diagonal bound and the hyperbola reduction. They are now labeled LEAN-ARCHIVE.
9. The September report gave two different commit hashes (`ef2586f` and `9bbaeb4`). The revised report cites the repository and branch; the release tag `academia-v1` marks the version it describes.
10. Four placeholder declarations of type `True` in `lean/weil/SR_Mollifier.lean` (SR24_LOG_WEIGHTED_X6_OPEN, SR24_HALF_WEIGHTED_X6_OPEN, SR24_LOG_WEIGHTED_POSITIVITY_CONJECTURE, SR24_HALF_WEIGHTED_POSITIVITY_CONJECTURE) were replaced by comments; they proved nothing.
11. The acknowledgments section was rewritten as "Authorship and AI tools"; Burnol's note is dated 2000.
