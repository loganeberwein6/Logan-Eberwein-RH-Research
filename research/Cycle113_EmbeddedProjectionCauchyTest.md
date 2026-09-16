# Cycle 113 — Embedded Low-Energy Projection Test

For fixed `lambda=2`, finite even-sector eigenvectors at increasing Fourier
cutoffs were embedded into the common coordinate space by zero-padding. For a
cluster of the first `k` eigenvectors, the orthogonal projection `P_(N,k)` was
formed and compared with the previous cutoff after embedding.

Representative operator-norm differences:

```text
cluster k=1:  N 4->6  2.63e-2, 6->8 5.25e-3, 8->10 3.72e-4,
              10->12 1.70e-4, 12->16 2.24e-4, 20->24 6.2e-5

cluster k=2:  N 4->6  3.99e-2, 6->8 4.84e-3, 8->10 1.72e-3,
              10->12 3.92e-4, 12->16 1.08e-3, 20->24 5.07e-4
```

The decreases are nonmonotone at larger cutoffs because the Weil matrices are
near singular and double precision loses digits. Nevertheless, projection
differences are substantially more coherent than raw eigenvector comparisons.

## Consequence

The correct convergence statement should bound embedded Riesz projections (or
their quadratic-form spectral subspaces), not individual minimizing vectors.
An analytic proof must replace these diagnostics with a uniform projection
estimate derived from Mosco convergence, compactness, and a contour or cluster
separation argument.

This test supports the common-space construction but does not prove the
required uniform estimate.
