# Cycle 82 — Divisor Cohomology and the Superdeterminant Obstruction

## Arithmetic mechanism

For the proper-divisor order complex of an integer `n`, the reduced Euler characteristic is `mu(n)`. In the squarefree case with `r=omega(n)` distinct prime factors, the expected reduced homology is concentrated in degree `r-2`, so its parity supplies the sign `(-1)^(r-1)=mu(n)`. For nonsquarefree `n`, the complex is contractible and the reduced Euler characteristic is zero.

Raw Möbius values for `2 <= n <= 15` were:

```text
n:       2  3  4  5  6  7  8  9 10 11 12 13 14 15
mu(n):  -1 -1  0 -1  1 -1  0  0  1 -1  0  1  1  1
```

Thus divisor cohomology is a genuine source of the signed Möbius coefficients, and divisor convolution with `log` gives the Lambda coefficients.

## Why ordinary positivity does not inherit the sign

Let `Delta_+` and `Delta_-` be positive even- and odd-degree Laplacians of a finite graded complex. Their ordinary determinants satisfy

\[
 \det(\Delta_+)>0,\qquad \det(\Delta_-)>0.
\]

The graded object is the superdeterminant

\[
 \operatorname{sdet}(\Delta)=\frac{\det(\Delta_+)}{\det(\Delta_-)},
\]

or, at the heat level, the supertrace

\[
 \operatorname{str}(e^{-t\Delta})
 =\operatorname{Tr}(e^{-t\Delta_+})-\operatorname{Tr}(e^{-t\Delta_-}).
\]

The cancellation and Möbius signs live in this grading. A positive ordinary determinant or ordinary trace sees the two sectors separately and cannot reproduce the signed Euler characteristic without retaining the grading. The elementary positive ratios `2/3`, `3/2`, and `5/7` illustrate that a superdeterminant of positive blocks is a positive ratio; it is not a positive operator whose trace carries the alternating cohomological signs.

## Consequence for the operator goal

The divisor-complex framework can supply P2/P5 through a graded supertrace:

\[
 \sum_n\mu(n)n^{-s}=1/\zeta(s),
 \qquad
 \sum_n\Lambda(n)n^{-s}=-\zeta'(s)/\zeta(s)
\]

in the initial half-plane. But converting that supertrace into an ordinary Fredholm determinant while preserving positivity would require a new theorem that removes the grading without removing the arithmetic signs. No such conversion is available; naively adding ghost/odd sectors merely gives a superdeterminant, and replacing it by an ordinary determinant loses the cancellation.

## P1–P6

| Property | Result |
|---|---|
| P1 | Scalar supertrace has `1/zeta`, but no ordinary determinant zero encoding. |
| P2 | Exact at graded divisor-complex level. |
| P3 | Ordinary positivity conflicts with the required grading; Weil positivity remains unconstructed. |
| P4 | Not supplied by divisor grading. |
| P5 | Strong: divisor topology produces `mu` and `Lambda`. |
| P6 | Heat damping gives an initial-half-plane trace framework, not a continued ordinary Fredholm family. |

## Verdict

**Class obstruction for direct divisor-complex conversion.** Cohomological cancellation explains the arithmetic coefficients but intrinsically produces a supertrace/superdeterminant. It does not by itself yield the ordinary positive operator required by the six-property target.
