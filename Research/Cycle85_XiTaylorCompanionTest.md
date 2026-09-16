# Cycle 85 — Completed-Xi Taylor Companion Test

## Construction

Let

\[
 \xi(s)=\frac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s),
\]

and expand around the symmetry center:

\[
 \xi(1/2+z)=\sum_{k=0}^{N}c_kz^k+O(z^{N+1}).
\]

The companion matrix of the truncated polynomial is a finite operator whose eigenvalues are the polynomial roots. This is an arithmetic construction in the weak sense that the coefficients come from zeta, gamma, and the completed functional equation.

## Raw diagnostics

High-precision derivatives were used to compute coefficients and standard polynomial root extraction was applied.

| degree N | positive-imaginary roots with `|Re z|<2` | maximum `|Re(root)|` |
|---:|---|---:|
| 8 | none | 7.11586 |
| 12 | 10.77165, 10.77165 | 10.66795 |

The first expected ordinate is `14.1347`; the degree-12 roots are not close, and the polynomial has large off-axis roots.

## Structural failure

Truncated Taylor companions approximate the zero set of a local polynomial, not the global zero set of `xi`. Increasing degree changes the companion dimension and its spectrum without a trace-class operator convergence theorem. Companion matrices are generally nonnormal and non-self-adjoint, so their roots do not provide a positive Hilbert–Pólya spectrum. The construction also uses the completed zeta function directly, so it does not derive the zeros from an independent integer operator.

## P1–P6

| Property | Result |
|---|---|
| P1 | Finite polynomial roots encode approximate xi zeros only locally and unstably. |
| P2 | Coefficients inherit arithmetic indirectly; no Lambda trace-log. |
| P3 | Fails: companion matrices are nonnormal and no positivity is established. |
| P4 | Xi symmetry is built into the expansion center, but not into a positive operator involution. |
| P5 | Weak/formal only: xi is supplied as input. |
| P6 | No verified nuclear convergence of companion matrices. |

## Verdict

**DEAD as an independent operator construction.** Taylor companions repack the completed xi function and do not construct its spectrum from arithmetic dynamics.
