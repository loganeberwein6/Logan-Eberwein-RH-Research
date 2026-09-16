# Cycle 86 — Positive Heat-Trace Möbius Obstruction

## Arithmetic target

The divisor-complex construction has the heat supertrace

\[
 H_\mu(t)=\sum_{n\ge1}\mu(n)e^{-nt}.
\]

Its first coefficients are

\[
 1,-1,-1,0,-1,1,-1,0,0,1,\ldots
\]

for `n=1,2,3,...`.

## Theorem

No positive self-adjoint operator with discrete spectrum contained in the positive integers can have ordinary heat trace `H_mu(t)`.

Indeed, if `A` is positive with integer spectrum and multiplicities `m_n>=0`, then

\[
 \operatorname{Tr}(e^{-tA})=\sum_{n\ge1}m_ne^{-nt},
\]

and uniqueness of Laplace transforms forces `m_n=mu(n)`. But `m_2=-1`, `m_3=-1`, and `m_5=-1`, contradicting nonnegative multiplicity.

The same conclusion holds for any positive spectral measure whose Laplace transform has a discrete expansion at the integer rates: signed Möbius coefficients require a graded/signed observable.

## Numerical illustration

The partial signed sum `e^-t - e^-2t - e^-3t - e^-5t + e^-6t` was positive at the sample points `t=.1,.5,1,2`, with values approximately `1.43346,.54387,.28907,.11954`; positivity of the scalar sum does not change the coefficient obstruction. A positive scalar function is not enough—positive spectral multiplicities are the relevant constraint.

## Consequence

The divisor heat identity cannot be the ordinary heat trace of the desired positive operator. It is intrinsically a supertrace or a signed trace. Therefore a successful P3 realization must either:

1. use a different positive Weil quadratic form whose explicit-formula prime terms are not themselves a positive heat trace;
2. retain a graded/super structure and explain how RH positivity acts on it; or
3. find a non-integer spectrum whose positive spectral measure reproduces the same function, together with a proof of its arithmetic origin.

Simply replacing the supertrace by an ordinary trace is mathematically impossible in the integer-spectrum class.

## P1–P6 impact

| Property | Result |
|---|---|
| P1 | Möbius heat trace gives scalar `1/zeta` only in its initial half-plane. |
| P2/P5 | Exact arithmetic coefficients. |
| P3 | Direct positive heat realization ruled out. |
| P4 | Not supplied. |
| P6 | Heat damping is available, but only as a signed/graded trace. |

## Verdict

**Class obstruction.** Any positive operator satisfying the six-property target must not realize the Möbius heat trace as its ordinary heat trace. The positivity mechanism must be global Weil positivity rather than coefficientwise spectral positivity.
