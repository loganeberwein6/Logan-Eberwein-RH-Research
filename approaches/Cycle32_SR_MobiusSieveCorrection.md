# Cycle 32: correction of the SR Möbius-sieve claim

## Direct finite test

The SR boundary flip count for composite `n` is `d(n)-2`. The previously
recorded claim that the ordinary Möbius-weighted series

`sum mu(n)(d(n)-2)n^(-s)`

equals `2/zeta(s)` is false as stated.

At `s=2`, the finite sums were:

```text
X=20       0.0946485260771
X=50       0.105050907231
X=100      0.108248930623
X=500      0.106788147109
X=2000     0.106794728728
```

The target `2/zeta(2)` is approximately `1.215854`, so the discrepancy is not
a truncation effect.

The logarithmic derivative ratios `F'_X/F_X` also fail to approach
`-zeta'/zeta`:

```text
s=1.5: X=2000  -2.3061034   target  1.5052354
s=2.0: X=2000   -2.2048430   target  0.5699610
s=2.5: X=2000  -2.0957879   target  0.2887407
```

## Exact Dirichlet-series diagnosis

Using

`sum d(n)n^(-s)=zeta(s)^2`,

`sum 2n^(-s)=2zeta(s)`,

and multiplication by `mu` under Dirichlet convolution gives

`sum mu(n)(d(n)-2)n^(-s) = zeta(s)-2`,

not `2/zeta(s)`. The latter would require a different convolutional sieve,
not pointwise multiplication of coefficients by `mu(n)`.

## Consequence

The SR boundary count remains a genuine prime-sensitive observable: it is zero
at primes and equals `d(n)-2` at composites. But the ordinary Möbius weighting
does not convert it into the reciprocal zeta function, and therefore cannot
yield `-zeta'/zeta` by logarithmic differentiation.

This correction removes one apparently promising bridge between SR positivity
and the Euler product. Any future sieve must specify the exact Dirichlet
convolution and verify its coefficients before being treated as an operator
candidate.

## Status

**The scalar SR-to-`1/zeta` bridge is disproved in this form.** The original
finite SR theorems remain unaffected; only the stronger Möbius-sieve inference
is rejected.
