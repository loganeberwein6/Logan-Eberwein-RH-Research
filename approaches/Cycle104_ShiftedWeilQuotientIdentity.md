# Cycle 104 — Correct Finite Operator Metric and Exact Quotient Symmetry

## Correction to Cycles 102–103

The earlier residual test used the raw Weil matrix `W` as the metric on all of
`E_N`. That is not the theorem's metric. The finite construction uses

`G_N = W_N - epsilon_N I`

on the quotient `E'_N = E_N / C xi_N`, where `epsilon_N` is the smallest
eigenvalue of `W_N` and `xi_N` is its minimizing vector.

The rank-one operator is

`D'_N = D_N - |D_N xi_N><delta_N|`,

with `delta_N` the Dirichlet/evaluation functional, represented by the
all-ones vector in Fourier coordinates and normalized by `delta_N(xi_N)=1`.

## Recomputed identity

For the implemented matrices, the residual of

`G_N D'_N - (D'_N)^T G_N`

was:

```text
lambda N   residual in full coordinates   residual on xi-perpendicular quotient
2      2   2.549e-13                     1.486e-13
2      4   1.504e-11                     8.284e-12
2      6   8.363e-10                     3.163e-10
3      4   4.507e-10                     2.858e-10
4      4   5.435e-09                     3.370e-09
```

The residual is at numerical quadrature/conditioning scale, unlike the
order-one residual obtained with the raw `W`. Also `G_N xi_N` is numerically
zero, as required for the quotient form.

## Definitive structural conclusion

The missing finite object was identified:

1. the Weil quadratic form `W_N`;
2. its ground-state shift by the smallest eigenvalue `epsilon_N`;
3. the quotient by the ground state `xi_N`;
4. the identity-evaluation/Dirichlet dual functional;
5. logarithmic scaling corrected by the resulting rank-one term.

The previous apparent failure was a metric mismatch, not evidence that a new
boundary operator was needed. The exact finite self-adjointness mechanism is
already present after the ground-state shift and quotient.

## What remains genuinely open

The finite operator is now specified and its self-adjointness mechanism is
verified. The unresolved part is the global limit: proving simplicity/evenness
of the ground state for all parameters, convergence of the selected states or
regularized determinants to `Xi`, and the joint `lambda,N` spectral limit.
Those are the remaining RH-level statements; they are not missing choices of
finite metric or rank-one vector.
