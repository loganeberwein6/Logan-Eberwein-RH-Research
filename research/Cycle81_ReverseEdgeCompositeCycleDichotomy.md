# Cycle 81 — Reverse-Edge Composite-Cycle Dichotomy

## Motivation

Cycle 80 showed that forward multiplication shifts are acyclic. To obtain a nontrivial determinant, one might add reverse edges so that multiplication by primes becomes a reversible arithmetic walk.

## Local computation

Take the four states

\[
 n\to pn\to pqn\to qn\to n
\]

with symmetric edge weights `p^{-s/2}` on the `p` edges and `q^{-s/2}` on the `q` edges. At `s=2`, the determinants of `I-A` were:

| `(p,q)` | determinant |
|---|---:|
| (2,3) | 0.29706790123456794 |
| (2,5) | 0.46410000000000007 |
| (3,5) | 0.7028345679012344 |

The determinant contains the closed four-cycle weight

\[
 p^{-s}q^{-s}=(pq)^{-s},
\]

in addition to the individual prime weights. Its precise coefficient depends on the edge orientation and cancellation scheme, but the mixed monomial is present generically.

## Dichotomy

Consider an arithmetic graph whose edges change one prime valuation at a time.

1. If reverse edges are absent, the valuation sum is strictly increasing along every directed path, so the graph is acyclic and the determinant is 1.
2. If reverse edges are present and prime sectors share vertices, two distinct prime moves form a mixed closed cycle. Its trace-log contributes a composite monomial involving `(pq)^{-s}`.
3. If all mixed cycles are removed by separating prime sectors, the graph is a direct sum of independent prime components. It can reproduce local Euler factors but has no global interaction capable of producing a nonseparable `Lambda(n)` trace or a Weil form.

Thus nontrivial closed dynamics, shared arithmetic state, and exact ordinary Euler-product primitive cycles cannot all be obtained by a plain reversible valuation graph.

## Relation to P1–P6

- **P1/P2:** reversible graphs can create traces, but shared prime sectors create the wrong composite primitive cycles.
- **P3:** symmetric reverse edges give mixed-sign or indefinite adjacency forms; no Weil positivity follows.
- **P4:** valuation reversal alone is not the analytic involution `s ↔ 1-s`.
- **P5:** arithmetic origin is exact.
- **P6:** finite graphs are harmless, but an infinite reversible valuation graph requires a new trace-class regularization.

## Verdict

**Class obstruction for plain reversible valuation graphs.** A successful arithmetic operator must encode primitive primes through a more sophisticated quotient/cancellation mechanism than ordinary reverse edges—likely a global automorphic or cohomological construction.
