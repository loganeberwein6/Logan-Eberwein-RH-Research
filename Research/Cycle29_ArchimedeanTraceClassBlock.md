# Cycle 29: trace-class realization of the archimedean factor

## Construction

The completed-chain multiplier is

`A(s)=2*pi^(s/2)/(s*(s-1)*Gamma(s/2))`.

Put `z=s/2`. The Weierstrass product gives

`1/Gamma(z)=z exp(gamma*z) prod_{n>=1}(1+z/n) exp(-z/n)`.

Each product factor can be represented as a diagonal Fredholm block with

`lambda_n(s)=1-(1+z/n)exp(-z/n)`.

Since `lambda_n(s)=O_s(n^-2)`, the diagonal block is trace class for every
fixed `s`. The finite-rank scalar factors `z`, `exp(gamma*z)`, `pi^(s/2)`,
`1/s`, and `1/(s-1)` can be represented by separate one-dimensional blocks
away from their poles. Their product determinant is exactly `A(s)`.

## Numerical convergence check

Using the first `N` Weierstrass factors:

```text
s=1.5,       |A_N-A|: N=10 .13605861, N=100 .014354858, N=1000 .001443362
s=.5+14.1347i,         N=10 521.94134, N=100 126.25893, N=1000 14.157597
s=2.5+3i,               N=10 .33523233, N=100 .036750309, N=1000 .003710972
```

The slow `O(1/N)` convergence is consistent with the unpaired Weierstrass
product; canonical higher-order grouping can improve numerical convergence,
but is not needed for trace-class convergence.

## What this resolves

The gamma/archimedean multiplier need not remain an unexplained scalar: it has
a direct trace-class diagonal realization. Combining this block formally with
the normalized telescoping Mayer chain gives a determinant equal to `1/xi(s)`.

## What remains unresolved

This block is not positive or coercive on the critical line. Its eigenvalues
are complex and depend meromorphically on `s`; the finite-rank factors also
carry the poles at `s=0,1`. Thus it supplies P6 for the archimedean factor but
does not supply P3. It also does not fix the common-space/nuclearity problem
for the infinite shifted Mayer chain.

## P1--P6 update

| Property | Status |
|---|---|
| P1 | completed determinant target can be represented formally |
| P2 | inherited from the Mayer telescoping chain |
| P3 | still absent |
| P4 | scalar completed symmetry, not an operator involution |
| P5 | archimedean block is analytic rather than integer-arithmetic |
| P6 | archimedean block is trace class; full chain remains unresolved |

## Verdict

**Archimedean gap reduced, not closed.** The remaining central problem is now
the positivity-compatible realization of the arithmetic chain, not the mere
existence of a Fredholm block for the gamma factor.
