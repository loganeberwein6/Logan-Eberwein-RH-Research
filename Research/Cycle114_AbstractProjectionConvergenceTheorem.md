# Cycle 114 — Abstract Projection-Convergence Theorem

## Theorem

Let `H` be a Hilbert space and let `q_j` and `q` be lower-semibounded closed
quadratic forms on `H`, with associated self-adjoint operators `A_j` and `A`.
Assume:

1. `q_j` Mosco-converges to `q`;
2. the form-domain unit balls are uniformly compact in `H`;
3. a finite spectral cluster of `A` is isolated by a contour `Gamma` in the
   resolvent set, and the corresponding finite clusters remain separated from
   `Gamma` for all sufficiently large `j`.

Then the resolvents `(A_j-z)^(-1)` converge strongly to `(A-z)^(-1)` for
`z` off the real axis, and the Riesz projections

`P_j = (2*pi*i)^(-1) integral_Gamma (A_j-z)^(-1) dz`

converge strongly to

`P = (2*pi*i)^(-1) integral_Gamma (A-z)^(-1) dz`.

Uniform compactness upgrades this to norm convergence on finite-rank isolated
clusters.

## Application to the Weil construction

Take `H=L2_even(R)`, `q` the closed global Weil form, and `q_j` the finite
forms pulled back through the zero-extension embeddings. Cycle 111 supplies
the recovery sequence on the compactly supported smooth core. The remaining
arithmetic work is exactly to prove the liminf inequality and uniform form-
domain compactness.

Once those estimates and a cluster contour are available, the theorem gives
convergence of the embedded finite low-energy projections. The rank-one
correction then converges through the same projections provided the Dirichlet
evaluation functional is uniformly bounded on the form domain.

## Proof idea

Mosco convergence gives strong resolvent convergence by the variational
characterization of resolvents as unique minimizers of coercive form
functionals. Uniform compactness prevents spectral mass from escaping to
infinity and gives norm convergence on finite-rank isolated clusters. The
Riesz contour integral transfers resolvent convergence to projection
convergence. The rank-one term is continuous under strong convergence of the
state projection and uniform boundedness of the evaluation functional.

## Status

The abstract map-to-limit theorem is complete. What remains is not another
choice of embedding: it is verification of its arithmetic hypotheses for the
global Weil form, especially the uniform lower bound, liminf inequality,
compactness, and identification of the limiting cluster.
