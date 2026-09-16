# Cycle 19: projection-level continuation of Candidate Q

## Motivation

The isolated lowest eigenvalue develops gaps at or below floating-point
resolution. Individual eigenvectors therefore are not a reliable state
variable. The correct replacement is the Riesz projection onto a low-energy
cluster, transported between logarithmic intervals by analytic (L^2) mode
overlaps.

## Computation

For (N=8), even parity, `lambda=2,2.25,...,4`, the singular values of the
transported old cluster against the new cluster were evaluated. The smallest
singular value is the cosine of the largest principal angle.

```text
cluster dimension k=1: minimum 0.1186, mean 0.6642
cluster dimension k=2: minimum 0.4881, mean 0.6633
cluster dimension k=3: minimum 0.2882, mean 0.5746
```

The two-dimensional projection is more coherent than the isolated bottom
branch. This is consistent with an eigenvalue cluster, but not proof of a
limiting projection.

## Required theorem for this route

For a proposed rank `k`, one must prove a contour `Gamma` separating the
cluster from the remainder uniformly in the truncation parameters and show

\[
 \|P_{N,\lambda}-P\|\to0,
 \qquad
 P_{N,\lambda}=\frac{1}{2\pi i}\oint_\Gamma
 (z-W_{N,\lambda})^{-1}\,dz.
\]

Only after this resolvent convergence can the selected rank-one state,
regularized scaling operator, and determinant be passed to the limit.

## Verdict

**Useful structural refinement, not success.** Projection tracking removes the
false requirement that a single eigenvector remain isolated, but no uniform
contour, resolvent bound, or determinant convergence has yet been proved.
