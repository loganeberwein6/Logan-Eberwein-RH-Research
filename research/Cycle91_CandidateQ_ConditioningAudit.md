# Cycle 91 — Candidate-Q Conditioning and Continuation Audit

## Test

The finite Candidate-Q Weil matrix was recomputed with the existing high-precision prime, archimedean, and Fourier-kernel terms. The eigenvalue continuation script was run with parity tracking and increasing Fourier cutoff.

## Raw truncation output at lambda=2, even parity

| N | smallest eigenvalue | second eigenvalue | condition number |
|---:|---:|---:|---:|
| 2 | `9.7402e-7` | `1.5972e-3` | `4.0044e5` |
| 4 | `1.6995e-9` | `2.6253e-5` | `1.0655e9` |
| 6 | `2.1431e-11` | `9.5544e-7` | `8.4907e10` |
| 8 | `2.7545e-12` | `3.6063e-7` | `9.0927e11` |
| 10 | `1.9502e-12` | `2.7922e-7` | `1.3378e12` |
| 12 | `1.3760e-12` | `2.7535e-7` | `2.0103e12` |

At `N=8`, continuation from `lambda=2` to `lambda=4` generated additional near-zero branches; the final matrix condition number was `4.9686e15`, and several eigenvector overlaps fell below the precision-escalation threshold.

For fixed small cutoffs the matrices were numerically positive in tested real lambda values:

| lambda | N=3 smallest eigenvalue | largest eigenvalue |
|---:|---:|---:|
| 1.5 | `2.4651e-4` | `1.5607` |
| 2.0 | `2.3955e-8` | `1.7536` |
| 3.0 | `3.2211e-11` | `0.3043` |

This finite positivity is compatible with a Weil-form interpretation, but it becomes numerically singular as the basis grows.

## Interpretation

Candidate Q is not eliminated. It contains the correct structural ingredients—prime-power Lambda terms, archimedean terms, Fourier test functions, and reversal parity. However, the current evidence does not establish:

- a well-conditioned limiting positive operator;
- convergence of eigenvalue branches;
- a determinant or zero theorem;
- a canonical SR-to-Q map;
- nuclear/Fredholm continuation.

The apparent low-mode zero behavior is therefore not yet evidence for zeta zeros; it may be truncation-induced nullspace and conditioning.

## Verdict

**PROMISING STRUCTURE / UNVERIFIED.** Candidate Q remains the only surviving global Weil-form direction, but requires a rigorous quotient/completion or preconditioning theorem before spectral zero claims are meaningful.
