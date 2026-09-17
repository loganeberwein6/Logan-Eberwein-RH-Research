# Cycle 28: completed Mayer-chain target

## Scalar target

Define the completed zeta function

`xi(s)=1/2*s*(s-1)*pi^(-s/2)*Gamma(s/2)*zeta(s)`.

It satisfies `xi(1-s)=xi(s)`, so the ideal scalar determinant is

`F(s)=1/xi(s)`.

It has zeros exactly at the nontrivial zeta zeros (with multiplicity), and the
functional symmetry is exact. The normalized telescoping Mayer chain from
Cycle 27 supplies `1/zeta(s)`. The missing scalar multiplier is therefore

`A(s)=pi^(s/2)/(Gamma(s/2)) * 2/(s*(s-1))`,

so that `A(s)/zeta(s)=1/xi(s)`.

## Numerical symmetry check

Using 40-digit arithmetic:

```text
s=.3+4i:       |1/xi(s)-1/xi(1-s)| = 7.04e-17
s=.5+14.1347i: |1/xi(s)-1/xi(1-s)| = 6.25e-35
s=.7+9i:       |...| = 6.89e-41
s=1.5+2i:      |...| = 2.87e-42
```

The large value `|1/xi(1/2+14.1347i)|≈2.8765e7` reflects the fact that the
first zero was entered only approximately; it is not evidence against the
divisor identity.

## Operator interpretation

At the scalar level this completes P1 and P4:

1. the chain gives the Euler-product factor `1/zeta(s)`;
2. the archimedean block supplies `A(s)`;
3. the product is the symmetric completed determinant `1/xi(s)`.

But this is not yet an RH proof. The following are still missing:

- an explicit nuclear operator whose Fredholm determinant is exactly `A(s)`;
- a common Banach/Hilbert space for the infinite shifted Mayer chain;
- a positivity or coercivity theorem implying zero-free behavior off the line;
- a proof that the combined determinant has the required analytic continuation.

In particular, scalar multiplication by `A(s)` is not equivalent to adding an
operator block unless the block's determinant and trace-class estimates are
constructed. A formal scalar completion cannot be counted as P3 or P6.

## P1--P6 status

| Property | Status |
|---|---|
| P1 | achieved at scalar target level: `1/xi(s)` has the right divisor |
| P2 | achieved at scalar Euler-product level, inherited from `1/zeta(s)` |
| P3 | missing completely |
| P4 | achieved by the completed scalar function |
| P5 | partial: Mayer chain is arithmetic, archimedean factor is analytic |
| P6 | partial: scalar continuation known, operator realization absent |

## Verdict

**Strongest current framework, but not an operator.** The search has now
isolated the exact remaining gap: realize the archimedean completion and the
telescoping chain as one nuclear, positive/symmetric operator. Any claimed
solution that merely writes `1/xi(s)` has skipped precisely that operator
construction.
