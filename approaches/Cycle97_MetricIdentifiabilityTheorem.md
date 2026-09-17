# Cycle 97 — Metric Identifiability Theorem

## Statement

Given a finite symmetric arithmetic form `W`, finite numerical data cannot
uniquely determine the operator metric. For every positive-definite matrix
`G`, the same form defines a different generalized operator through

\[
 Wv=\lambda Gv.
\]

Changing `G` changes the generalized eigenvalues while leaving the arithmetic
entries of `W` unchanged. There are infinitely many such `G`, including
ordinary `L2`, weighted Sobolev, Mellin-type, and scale-dependent metrics.

## Proof idea

For any positive-definite `G`, the congruent matrix

\[
 G^{-1/2}WG^{-1/2}
\]

is the self-adjoint operator associated with the form in the `G`-metric. If
`G` is replaced by another positive matrix `G'`, the resulting operator and
its spectrum generally change. Finite positivity of `W` survives the change,
but spectral locations do not.

Thus no finite collection of eigenvalue fits can identify the correct `G`.
Any desired finite spectrum can be altered by an admissible positive metric,
without changing the prime/gamma form itself.

## Consequence for the missing-item question

The metric cannot be “found” by trial-and-error while retaining mathematical
uniqueness. It must be forced by an independent structural principle, such as:

- a canonical Mellin/Plancherel measure;
- a representation of the idele or adele class group;
- a closed Weil form with a uniquely specified domain;
- a trace formula that fixes the normalization;
- or a self-adjoint extension theorem with a unique boundary condition.

The ordinary common-L2 probe failed, but that does not select one remaining
metric. It only rules out that particular choice.

## Definitive conclusion

The exact missing requirement is not merely “some normalization.” It is a
**canonical, independently derived scale-invariant Hilbert-space metric and
domain**. Without a theorem selecting that metric, the operator is
underdetermined and no amount of finite trial-and-error can identify the RH
operator uniquely.

This is not a computational failure; it is an identifiability obstruction.
