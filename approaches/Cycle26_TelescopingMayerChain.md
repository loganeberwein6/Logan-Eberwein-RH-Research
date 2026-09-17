# Cycle 26: telescoping shifted Mayer determinants

## Exact cancellation framework

Let

`D(q)=det(I-L_{q/2})=zeta(q-1)/zeta(q)`.

Then the finite shifted product satisfies the exact identity

`prod_{j=0}^N D(q-j) = zeta(q-N-1)/zeta(q)`.

Thus the unwanted numerator `zeta(q-1)` telescopes, leaving the desired
`1/zeta(q)` multiplied by one endpoint factor. This is the first construction
that algebraically isolates the correct Euler-product determinant rather than
merely perturbing Mayer locally.

## Numerical endpoint test

The endpoint magnitude `|zeta(q-N-1)|` was evaluated for representative points:

```text
q=1.5:             N=0 1.46035, N=3 .0085169, N=5 .0030917, N=10 .0066722
q=2.5:             N=0 2.61238, N=3 .0254852, N=5 .0044410, N=10 .0044160
q=1/2+14.1347i:   N=0 1.22546, N=3 25.6953, N=5 151.962,
                   N=10 19312.7
```

The products themselves matched the telescoped expression to numerical
precision. The endpoint does not converge to a nonzero constant uniformly in
the critical strip; on the critical line it grows rapidly as the real part
becomes increasingly negative.

## Fredholm realization issue

A direct sum of Mayer blocks realizes the product of determinants, but only
with positive block multiplicity. To realize the finite product one needs
blocks at parameters `q,q-1,...,q-N`. That is finite for fixed `N`, but the
limit requires an infinite direct sum. Nuclearity then requires a summability
estimate for all shifted blocks, which fails naively because the shifted
parameters move leftward into the non-contractive region.

Alternatively, one could divide by the endpoint using a reciprocal Fredholm
factor, but a reciprocal determinant is not automatically the determinant of
`I-T` for a nuclear operator. It requires a separately constructed inverse
class or a regularized determinant with controlled gamma/trivial-zero factors.

## P1--P6 status

| Property | Status |
|---|---|
| P1 | algebraically strong: finite products contain exactly `1/zeta(q)` |
| P2 | strong at determinant level, through the Euler product |
| P3 | absent |
| P4 | not yet built; endpoint/gamma factors must be completed symmetrically |
| P5 | yes, every block is Mayer/integer-branch based |
| P6 | finite products yes; infinite telescoping limit currently fails nuclearity |

## Verdict

**PROMISING algebraic framework, not an operator solution.** The obstruction is
precise: cancellation requires an infinite shifted Mayer chain, but the shifts
destroy the common nuclear domain, while the finite endpoint is not harmless.
The next task is to determine whether a completed/functional-equation-normalized
chain can absorb the endpoint into an explicit nonvanishing factor without
losing positivity or nuclearity.
