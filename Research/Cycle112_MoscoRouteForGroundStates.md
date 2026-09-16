# Cycle 112 — Form-Convergence Route for the Ground States

## Common-space setup

Let `H=L2_even(R)` and let `q` be the closed global Weil form, assuming it is
lower semibounded and closable. Let `q_(lambda,N)` be the finite forms pulled
into `H` by zero-extension embeddings, with value `+infinity` outside their
finite embedded domains.

## Exact convergence theorem to target

If the finite forms converge to `q` in the Mosco sense,

1. every weakly convergent sequence `u_j -> u` satisfies
   `q(u) <= liminf q_(lambda_j,N_j)(u_j)`;
2. every `u` in the domain of `q` has a recovery sequence `u_j` with
   `u_j -> u` strongly and
   `q_(lambda_j,N_j)(u_j) -> q(u)`;

and if the form-domain embedding has a uniform compactness/tightness bound,
then the associated self-adjoint operators converge in strong resolvent
topology and their isolated finite spectral projections converge.

This is the correct theorem for the minimizing states. It does not require a
uniform gap between the first two finite eigenvalues if one tracks a finite
cluster through Riesz projections.

## What is already supplied

- The common Hilbert space and zero-extension maps are fixed.
- The recovery-sequence half is supplied on the compactly supported smooth
  core by Cycle 111: Fourier projections give the approximants, and the
  arithmetic cutoff is eventually exact on each fixed core vector.

## What remains to prove

- a uniform lower-bound/tightness estimate for the finite Weil forms;
- the weak-limit lower-semicontinuity inequality;
- compactness of bounded form-domain sequences in the common `L2` space;
- identification of the limiting spectral cluster with the Xi-state rather
  than merely an arbitrary zero-energy state.

The shrinking finite gaps show why an isolated-eigenvector perturbation proof
is not viable. Mosco convergence plus spectral projections is the correct
replacement.

## Consequence

If these hypotheses are proved, the finite shifted rank-one operators converge
through the same embeddings in strong resolvent form, and their determinant
problem reduces to the transform of the limiting spectral projection. The
remaining missing mathematics is therefore a global Weil-form compactness and
lower-semicontinuity theorem, not a new finite operator or a new coordinate
map.
