# Cycle 90 — Low-Rank Positivity-Repair Obstruction

## Candidate repair

Consider a positive semidefinite correction

\[
 M_X\longmapsto M_X+U_XU_X^*.
\]

This models a finite-rank archimedean/Weil correction while preserving the original SR form on the orthogonal complement.

## Inertia bound

If a Hermitian matrix `M` has `nu_-(M)` negative eigenvalues, then any positive semidefinite update of rank `r` with `M+UU^* >= 0` must satisfy

\[
 r\ge \nu_-(M).
\]

Indeed, the negative spectral subspace has dimension `nu_-`; a rank-`r` positive update has a kernel of codimension at most `r`, so if `r<nu_-` some negative direction remains untouched.

## Raw SR counts

| X | negative index `nu_-` | positive index | zero index |
|---:|---:|---:|---:|
| 20 | 3 | 3 | 12 |
| 30 | 4 | 4 | 20 |
| 50 | 6 | 6 | 36 |
| 75 | 7 | 8 | 58 |
| 100 | 8 | 9 | 81 |
| 150 | 11 | 11 | 126 |
| 200 | 13 | 13 | 172 |
| 300 | 16 | 16 | 266 |
| 400 | 18 | 19 | 361 |

The required correction rank is unbounded in the tested range. Therefore no fixed-rank archimedean sector can repair SR positivity as `X -> infinity`.

## Consequence

A successful Weil correction must act on an increasing-dimensional portion of the SR space and must be a genuinely global operator, not a finite-rank patch. Such a correction will generally alter the trace, determinant, and arithmetic coefficients; it cannot be treated as a harmless local adjustment.

## P1–P6

| Property | Result |
|---|---|
| P1 | Low-rank updates do not create the missing zeta determinant. |
| P2 | No Lambda mechanism is supplied. |
| P3 | Fixed-rank positive repair ruled out by inertia. |
| P4 | No symmetry supplied. |
| P5 | Update is not canonically arithmetic. |
| P6 | Uniform finite-rank convergence impossible. |

## Verdict

**Class obstruction for bounded-rank positivity repairs.** Any successful global Weil form must replace, not merely patch, the raw SR quadratic form on an unbounded-dimensional subspace.
