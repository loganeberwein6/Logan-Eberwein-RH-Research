# Cycle 88 — Exact SR Quadratic-Form Decomposition and Inertia

## Exact decomposition

On the support `S_X={2,...,X-1}`, let `J` be the all-ones matrix and let

\[
 B_X(m,n)=1_{mn<X}.
\]

The Rees sign matrix satisfies the exact identity

\[
 M_X=J-2B_X,
\]

and therefore, for every real vector `v`,

\[
 v^TM_Xv=\left(\sum_{m<X}v_m\right)^2
 -2\sum_{mn<X}v_mv_n.
\]

This is the finite SR quadratic form underlying the cosine/frequency tests.

## Raw inertia diagnostics

Eigenvalue counts `(positive, negative, zero)` were:

| X | dimension | inertia | minimum eigenvalue | maximum eigenvalue |
|---:|---:|---:|---:|---:|
| 6 | 4 | (1,1,2) | -1.645751 | 3.645751 |
| 8 | 6 | (2,1,3) | -2.512976 | 5.315070 |
| 10 | 8 | (2,2,4) | -3.408432 | 6.989177 |
| 20 | 18 | (3,3,12) | -5.935699 | 16.329480 |
| 30 | 28 | (4,4,20) | -8.245000 | 25.835042 |
| 50 | 48 | (6,6,36) | -12.252178 | 45.097001 |
| 100 | 98 | (9,8,81) | -19.731534 | 94.115797 |

The nullity is already dominant at the tested sizes, but the nonzero spectrum remains mixed. Thus the positive all-ones entry sum does not imply positive semidefiniteness of the full matrix.

## Consequence for the Weil target

The SR quadratic form can be used as an indefinite kernel or as one ingredient in a Weil-type form, but it cannot itself be the positive quadratic form required by P3. Any repair by real congruence preserves this inertia (the earlier Sylvester obstruction), and any diagonal sign/gauge repair preserves the spectrum. A successful construction must add a genuinely new global archimedean/prime contribution and prove positivity of the combined form.

## P1–P6

| Property | Result |
|---|---|
| P1 | No determinant zero encoding established. |
| P2 | Threshold form has no intrinsic Lambda trace. |
| P3 | Direct positivity ruled out by mixed inertia. |
| P4 | No functional involution. |
| P5 | Exact finite integer origin. |
| P6 | Finite matrices only; no limiting nuclear form. |

## Verdict

**Class obstruction for the raw SR quadratic form.** Its finite positivity of selected vectors, including the all-ones vector, cannot be upgraded to global positive semidefiniteness.
