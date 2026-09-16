# Cycle 33: Dirichlet inversion of the SR flip series

## Exact setup

Let `a(1)=-1` and `a(n)=d(n)-2` for `n>=2`. Its Dirichlet series is

`A(s)=zeta(s)^2-2*zeta(s)=zeta(s)(zeta(s)-2)`.

The exact Dirichlet inverse `b=A^{-1}` exists formally because `a(1)=-1`.
The first coefficients are

```text
a(n), n=1..15: -1,0,0,1,0,2,0,2,1,2,0,4,0,2,2
b(n), n=1..15: -1,0,0,-1,0,-2,0,-2,-1,-2,0,-4,0,-2,-2
```

Direct convolution verifies

`(a*b)(1)=1` and `(a*b)(n)=0` for `2<=n<=15`.

## Why this does not recover the Euler product

Inverting the flip series produces coefficients for

`1/[zeta(s)(zeta(s)-2)]`,

not `1/zeta(s)`. To obtain the Möbius coefficients `mu(n)`, one would still
need to multiply by the additional factor `zeta(s)-2`, which simply restores
the original information rather than deriving it from SR positivity.

Thus formal Dirichlet inversion does not create a new prime-power operator; it
is an algebraic repackaging of the same scalar series.

## Operator consequence

A lower-triangular convolution operator built from `a` is invertible at the
formal finite level, but its inverse has no demonstrated positivity, common
nuclear limit, or functional-equation symmetry. The inversion also supplies no
new determinant identity beyond the already-known scalar Dirichlet products.

## Verdict

**Dead as an independent SR-to-zeta construction.** The exact inverse exists,
but it does not yield `1/zeta` and does not address P3/P4/P6. The correction in
Cycle 32 therefore cannot be repaired by naive Dirichlet inversion.
