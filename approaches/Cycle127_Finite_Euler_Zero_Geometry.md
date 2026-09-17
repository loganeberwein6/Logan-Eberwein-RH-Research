# Cycle 127 — Finite Euler Determinants Have the Wrong Zero Geometry

For one prime, the finite Euler factor is

`(1 - p^(-s))^(-1)`.

Its determinant zero condition is `p^(-s) = 1`, hence

`s = 2*pi*i*k / log(p)`

for integers `k`. These zeros lie on the imaginary axis (`Re(s)=0`), not on
the critical line (`Re(s)=1/2`). A finite product over primes preserves this
zero geometry. The archimedean gamma factor has no zeros, and the elementary
completion factor only contributes the trivial zeros at 0 and 1.

Therefore a finite Euler determinant, even when positive and exactly
arithmetic, cannot itself be the Hilbert--Polya operator whose spectrum is the
nontrivial zeta zeros. The shift to the critical line must come from the
analytic completion/regularization and its boundary conditions, not from
finite Euler factors alone.

This is a structural exclusion of a tempting shortcut, not a proof against a
completed determinant construction.
