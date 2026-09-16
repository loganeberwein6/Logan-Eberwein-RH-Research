# Cycle 74 — Paired Functional Euler Blocks

## Construction

For each prime `p`, pair the two exponents `s` and `1-s` in the block

\[
 A_p(s)=\begin{pmatrix}0&p^{-s}\\p^{-(1-s)}&0\end{pmatrix}.
\]

This is the minimal two-channel construction with an explicit `s <-> 1-s` exchange.

## Exact determinant

Since the product of the off-diagonal entries is

\[
 p^{-s}p^{-(1-s)}=p^{-1},
\]

we have

\[
 \det(I-A_p(s))=1-p^{-1}.
\]

The determinant is independent of `s`. Multiplying over primes therefore produces the divergent Euler product `∏_p(1-p^{-1})`, not `1/ζ(s)` or a completed zeta factor. The functional involution has erased the spectral parameter.

## Raw diagnostics

For `p=2,3,5,7,11`, the determinants were respectively

`0.5, 0.666666666667, 0.8, 0.857142857143, 0.909090909091`

at all tested values `s=1.5`, `2`, `0.5+14.1347i`, and `0.5+21.022i`.

The Hermitian eigenvalues were always paired as `(-a,+a)`. On the critical line, for example, they were:

| p | Hermitian eigenvalues |
|---:|---:|
| 2 | ±0.70710678 |
| 3 | ±0.57735027 |
| 5 | ±0.44721360 |
| 7 | ±0.37796447 |
| 11 | ±0.30151134 |

Off the critical line the same mixed inertia persists, with magnitudes changing. Hence no positive quadratic form is obtained from the block itself.

## Structural conclusion

The simplest exact `s ↔ 1-s` pairing forces the local cycle product to depend only on `s+(1-s)=1`. It therefore destroys the parameter dependence needed for the Euler determinant. At the same time, self-adjointization creates a `+/-` spectral pair, so positivity is lost.

More elaborate successful constructions would need a functional involution acting on a global Weil/test-function space rather than pairing each Euler factor directly. The involution and positivity cannot both be supplied by this local two-channel determinant mechanism.

## P1–P6

| Property | Result |
|---|---|
| P1 | Fails: determinant has no nontrivial zeta-zero dependence. |
| P2 | Prime channels are present, but no `Lambda` trace-log emerges. |
| P3 | Fails for the block: exact mixed inertia `(+,-)`. |
| P4 | Holds algebraically. |
| P5 | Holds arithmetically. |
| P6 | Finite blocks are trivial; the infinite product diverges at the relevant boundary. |

## Verdict

**DEAD.** Local functional pairing is too strong: it removes the complex parameter and enforces indefiniteness. The viable route must use global explicit-formula/Weil duality rather than factorwise `s`/`1-s` pairing.
