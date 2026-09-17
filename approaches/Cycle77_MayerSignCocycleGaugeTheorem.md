# Cycle 77 — Mayer Sign-Cocycle Gauge Theorem

## Setup

Represent a finite transfer discretization by a directed strongly connected graph with edge weights `w_{ij}(s)`. Modify the Mayer weights by nonzero signs `sigma_{ij}`:

\[
 w'_{ij}(s)=\sigma_{ij}w_{ij}(s),\qquad \sigma_{ij}\in\{\pm1\}.
\]

The Fredholm trace-log depends on closed orbit products

\[
 \prod_{e\in C}\sigma_e
\]

for every directed cycle `C`.

## Theorem

If the modified transfer has the same sign product on every directed cycle, then there are vertex signs `u_i in {+-1}` such that

\[
 \sigma_{ij}=u_i u_j^{-1}.
\]

Consequently `W'=U W U^{-1}` for the diagonal sign matrix `U=diag(u_i)`, so all determinants and spectra are unchanged.

## Proof

Choose a base vertex `v_0` and define `u_i` as the sign product along any path from `v_0` to `i`. If two paths are chosen, their concatenation with a fixed return path forms a closed walk. Equality of all closed-cycle products makes the two definitions agree. For an edge `i -> j`, the path to `j` may be taken as the path to `i` followed by that edge, giving `u_j=u_i sigma_{ij}` and hence `sigma_{ij}=u_i u_j^{-1}`. The conjugacy statement follows entrywise.

## Consequence for Mayer–SR

The Mayer determinant is produced by periodic-orbit products. Therefore an SR sign insertion can preserve the Mayer Euler determinant only if it is a gauge coboundary, in which case it is spectrally invisible. A sign insertion with a nontrivial cycle product changes the trace-log and therefore changes the determinant; the Cycle 22 branchwise hybrid does exactly this and loses the Mayer arithmetic identity.

This is the graph/cohomology form of the earlier gauge obstruction. It rules out every determinant-preserving sign cocycle, not just separable phases or a particular discretization.

## P1–P6 impact

- P1/P2/P6 of Mayer can be retained only by gauge-trivial signs, which add no SR information.
- Nontrivial signs can potentially alter the determinant, but then no exact Mayer Euler identity survives automatically.
- P3 cannot be transferred by a gauge similarity because spectral and inertia data are preserved.
- P4 remains absent unless separately imposed.

## Verdict

**Class obstruction.** A successful Mayer–SR hybrid cannot be a sign-only periodic-orbit-preserving deformation. It needs new state variables or a new non-coboundary arithmetic interaction, together with a fresh determinant theorem.
