# Cycle 7: continuous Mayer/Gauss transfer operator

## Definition

Use the canonical Mayer operator

\[
 (L_s f)(x)=\sum_{n\ge1}(x+n)^{-2s}f((x+n)^{-1}).
\]

For the standard analytic-function space, Mayer's Fredholm determinant identity
is

\[
 \det(I-L_s)=\frac{\zeta(2s-1)}{\zeta(2s)}.
\]

This is the continuous Gauss-map lift, without an arbitrary SR sign factor.

## Raw determinant values

```text
s=1.5: det=1.368432777620206
s=2.0: det=1.110626535326148
```

On the critical line, using the exact identity:

```text
t=0.001:  |det|=0.0009999983550710742
t=14.1347: |det|=2.121135249870226
t=21.022:  |det|=2.586795397273555
t=25.0109: |det|=2.821562817368093
t=30.4249: |det|=3.112000394626134
t=32.9351: |det|=3.237833833360162
```

At `t=0` the denominator has the pole `zeta(1)`, and the determinant has
limit zero.  The first five nontrivial zeta ordinates are not zeros or local
minima of this determinant.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 poles/zeros at zeta zeros | partial | the quotient has zeta-related poles and zeros, but not the nontrivial zeros in the required determinant location |
| P2 Lambda weights | partial | the Selberg--Mayer trace expansion is arithmetic, but yields the quotient's orbit weights, not `-zeta'/zeta` directly |
| P3 positivity | no | the transfer operator is not a positive coercive SR quadratic form |
| P4 functional equation | no | `zeta(2s-1)/zeta(2s)` is not invariant under `s -> 1-s` |
| P5 arithmetic origin | yes | Gauss branches are indexed by integers |
| P6 convergence/analytic continuation | yes | the operator is nuclear on the standard analytic space and has a Fredholm determinant |

## Verdict

**DEAD for the stated six-property target.**  This cycle isolates the precise
role of the continuous Gauss dynamics: it supplies nuclearity and an exact
determinant, but the determinant is the ratio
`zeta(2s-1)/zeta(2s)`, not `1/zeta(s)` or a function whose zeros track the
nontrivial zeta zeros.  Multiplying by an SR sign cannot be assessed as a
canonical perturbation because the literal Mayer--SR kernel is undefined on
part of the domain.

The remaining gap is therefore not the absence of a Gauss-map operator.  It is
the missing arithmetic deformation that changes the Mayer orbit determinant
to a zeta logarithmic derivative while preserving nuclearity, functional
symmetry, and a positivity mechanism.

## Literal SR insertion has a domain contradiction

The proposed factor `Rees(floor(x),n)` cannot be an intrinsic factor of the
standard Mayer map on a single natural domain. If the Mayer operator acts on
`x in [0,1]`, then `floor(x)=0` everywhere and the Rees support is never the
intended integer support `{2,...}`. If one instead takes `x>=1` so that
`floor(x)` carries arithmetic information, every image
`1/(x+n)` lies in `(0,1/2]`, leaving the domain on the next iterate. A
piecewise extension or a choice of return map is therefore required, and each
choice defines a different operator. This is a structural construction gap,
not a numerical tuning issue.
