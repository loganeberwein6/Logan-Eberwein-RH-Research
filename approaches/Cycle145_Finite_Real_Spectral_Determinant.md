# Cycle 145 — Finite Real-Spectral Determinant Bridge

Added `SR_SpectralBridge.lean`.

For a finite list of real eigenvalues, Lean proves that the product
`prod_a (z-a)` can vanish only when `z` equals one of those real eigenvalues.
It also proves directly that every such zero has zero imaginary part.

This is the finite algebraic core of the Hilbert--Polya implication. The
unresolved RH work is not this finite fact; it is constructing an infinite
self-adjoint operator whose regularized determinant is the completed xi
function and proving convergence of the finite spectral determinants to it.
