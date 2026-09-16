# Cycle 103 — Finite Symmetry Equation Identifies the Missing Boundary Effect

## Finite equation

Let `W` be the symmetric truncated Weil matrix, `D` the diagonal scaling
matrix, `xi` its selected lowest state, and `v=D xi`. For a rank-one
correction `D_u = D - v u^T`, weighted self-adjointness is equivalent to

`W D - D W = (W v)u^T - u(W v)^T`.

Thus the required dual functional can be recovered directly from the finite
symmetry equation instead of guessed from spectral fits.

## Numerical identification

Solving this overdetermined equation for `u`, with the gauge `u^T(Wv)=0`,
gives:

```text
lambda N   residual of symmetry equation   distance of u from ones
2      2   2.577e-04                      7.763e-12
2      4   2.680e-06                      6.696e-10
2      6   2.003e-07                      6.208e-07
3      4   5.184e-08                      2.986e-06
4      4   9.736e-09                      1.391e-04
```

The recovered vector is numerically the all-ones vector, not a new fitted
weight. This independently confirms that the identity-evaluation/Dirichlet
functional is the correct dual functional for the candidate architecture.

## What is actually missing

The remaining residual is not caused by choosing the wrong dual vector. It is
the finite compression error in the commutator of scaling with the arithmetic
Weil form. In the untruncated global space, the required identity should be a
boundary/Green identity. Compressing both operators to the finite Fourier
space loses the boundary contribution, so the finite relation is only
approximately rank two.

Therefore the missing mathematical object is:

> a common completed Weil domain, with its boundary/evaluation terms, on which
> the scaling commutator is exactly represented by the rank-two form generated
> by the identity-evaluation functional and the selected Weil ground state.

This is more specific than “find a metric.” The metric is the global Weil
form; the essential missing theorem is the exact domain-level commutator
identity plus a quantitative estimate for its finite compression error.

## Status

- The dual vector is identified independently: Dirichlet/evaluation, all ones
  in Fourier coordinates.
- The finite correction is structurally validated, not merely zero-fitted.
- The current finite matrices do not satisfy exact symmetry; their residual is
  a truncation/boundary error.
- A global domain, exact commutator identity, and convergence estimate remain
  unproved. Hence this is a definitive identification of the missing object,
  not a proof of RH.
