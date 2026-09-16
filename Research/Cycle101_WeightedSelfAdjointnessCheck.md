# Cycle 101 — Weighted Self-Adjointness of the Rank-One Operator

## Invariant checked

For the finite Weil matrix `W` and rank-one scaling perturbation `D'`, the
correct self-adjointness condition is not ordinary symmetry of `D'`. It is

\[
 W D'=(D')^T W.
\]

This means that `D'` is self-adjoint in the bilinear form defined by `W`.

## Raw residuals

The maximum absolute residual and a relative residual were computed from the
finite double-precision reproduction:

| lambda | N | max absolute residual | relative residual |
|---:|---:|---:|---:|
| 2 | 2 | `2.7002e-4` | `1.4914e-6` |
| 2 | 4 | `1.0392e-5` | `3.0086e-10` |
| 2 | 6 | `1.1217e-6` | `2.0507e-12` |
| 3 | 4 | `8.7890e-8` | `1.4424e-13` |
| 4 | 4 | `1.3613e-8` | `2.5347e-15` |

The absolute residual is affected by the rapidly ill-conditioned Weil form;
the relative residual decreases sharply in the tested cases.

## Meaning

This verifies the defining algebraic mechanism of the rank-one candidate:
the arithmetic Weil form supplies the inner product, and the selected
inversion-even vector supplies the correction making logarithmic scaling
self-adjoint in that form. The ordinary matrix is not expected to be
self-adjoint in Euclidean coordinates.

## Remaining gap

The check is finite and numerical. A complete result still requires proving:

- the finite weighted identity exactly or with certified error;
- positivity/closability of the limiting Weil form;
- convergence of the selected vectors and rank-one perturbations;
- the regularized determinant identity with completed xi.

## Verdict

**Algebraic mechanism confirmed at finite level.** This is stronger evidence
than eigenvalue matching, but not a global convergence or RH proof.
