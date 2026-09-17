# Cycle 89 — Scalar Archimedean-Shift Obstruction

## Candidate repair

Try to repair the mixed SR form by adding a scalar diagonal term:

\[
 M_X^{(\alpha)}=M_X+\alpha_X I.
\]

Positive semidefiniteness requires `alpha_X >= -lambda_min(M_X)`.

## Raw output

| X | `lambda_min(M_X)` | minimum required shift | shift / sqrt(X) |
|---:|---:|---:|---:|
| 20 | -5.93569938 | 5.93569938 | 1.32726273 |
| 30 | -8.24500018 | 8.24500018 | 1.50532420 |
| 50 | -12.25217845 | 12.25217845 | 1.73271969 |
| 75 | -16.14738366 | 16.14738366 | 1.86453926 |
| 100 | -19.73153372 | 19.73153372 | 1.97315337 |
| 150 | -25.65264859 | 25.65264859 | 2.09452999 |
| 200 | -31.03229471 | 31.03229471 | 2.19431460 |
| 300 | -40.02541556 | 40.02541556 | 2.31086844 |

The required correction is unbounded and grows at least on the observed square-root scale. A fixed bounded archimedean diagonal term cannot make the finite SR forms uniformly positive.

## Structural implication

Adding `alpha_X I` also shifts every trace and determinant factor. It is not a harmless Weil/gamma correction: it changes the entire spectral measure and has no identified prime-power or functional-equation normalization. A successful archimedean contribution must be a non-scalar global kernel whose size and cancellation are controlled together with the prime terms.

## P1–P6

| Property | Result |
|---|---|
| P1 | Scalar shifting does not create zeta-zero determinant factors. |
| P2 | Adds no Lambda structure. |
| P3 | Can repair each finite matrix only with an X-dependent, unbounded shift. |
| P4 | No functional involution. |
| P5 | Scalar shift is not derived from SR arithmetic. |
| P6 | No uniform limiting positive form follows. |

## Verdict

**Dead as a bounded archimedean repair.** The missing Weil positivity cannot be obtained by adding a uniform scalar diagonal correction to the SR matrix.
