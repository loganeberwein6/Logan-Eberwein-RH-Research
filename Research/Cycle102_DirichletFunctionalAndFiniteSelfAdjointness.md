# Cycle 102 — Dirichlet Functional Identified; Exactness Not Established

## Question resolved

The Candidate-Q specification writes the rank-one correction as

`D' = D - |D xi><delta_N|`.

In the truncated Fourier basis indexed by `n=-N,...,N`, evaluation at the
identity (the Dirichlet-kernel functional) has coordinate vector

`delta_N = (1,1,...,1)`.

Therefore the reproduction code's `eta = ones(2*N+1)` is not a fitted choice
for this functional. Normalizing `xi` by `eta^T xi = 1` is the corresponding
finite normalization.

## Exact finite check

For the implemented Weil matrix `W`, the relevant weighted symmetry residual
was evaluated as

`W D' - (D')^T W`.

Representative infinity-norm residuals were:

```text
lambda  N    residual
2       2    6.750443e-04
2       4    4.676264e-05
2       6    7.291381e-06
3       4    3.955085e-07
4       4    6.139648e-08
```

These values are numerically small compared with the norm of the unscaled
Weil matrix and decrease strongly with cutoff/scale. However, the direct
commutator identity needed to make the finite symmetry exact does not vanish.
For example, the residual in the candidate identity

`W D - D W = mu (xi eta^T - eta xi^T)`

is order one in the same tests. Thus the current finite formulas establish an
asymptotic-looking cancellation, not an exact finite self-adjointness theorem.

## Consequence for the operator search

One missing ingredient is now identified precisely:

> the global operator must use the evaluation functional at the identity as
> its rank-one dual vector, but the finite Weil form must be defined or
> completed so that the corresponding rank-one cancellation is exact in the
> limiting Hilbert/Weil space.

The finite matrix currently omits or approximates whatever boundary/domain
terms make that identity exact. Changing the dual vector to an arbitrary
fitted vector is not the right repair. The next proof target is an exact
domain-level Green/Weil identity, followed by a cutoff estimate showing that
the finite residual tends to zero in the operator topology needed for the
determinant.

## Status

- Identified: the correct dual functional is the Dirichlet/evaluation
  functional, represented by the all-ones Fourier vector.
- Supported: the rank-one correction is structurally tied to that functional;
  finite spectra show the previously recorded zero-height matches.
- Not proved: exact finite weighted self-adjointness, a common limiting space,
  determinant convergence, or RH.
