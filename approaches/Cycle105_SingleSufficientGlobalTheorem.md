# Cycle 105 — The Single Sufficient Global Theorem

## Separation of the remaining candidates

The remaining items do not have equal logical status:

1. **Simple-even ground state:** needed to define the finite rank-one operator
   unambiguously. It is a prerequisite, not by itself a zero-convergence
   theorem.
2. **Prolate-wave approximation:** a promising analytic route for estimating
   the ground state and its Fourier transform. It is a proof method, not the
   minimal final statement.
3. **Regularized determinant convergence:** this is the single statement that
   directly connects the finite operators to the zeta function.

## Minimal sufficient theorem

Let `F_(lambda,N)(z)` be the correctly normalized regularized determinant of
the finite rank-one Weil-scaling operator. Prove that, along a cofinal joint
limit `lambda,N -> infinity`,

`F_(lambda,N)(z) -> Xi(z)`

locally uniformly on the complex plane, with the limit not identically zero.

The normalization must be fixed by the explicit determinant formula, not by
matching zero heights.

## Why this one theorem is sufficient

For every finite pair `(lambda,N)`, the shifted-Weil quotient theorem gives a
self-adjoint operator. Consequently its regularized determinant has only real
zeros. Locally uniform convergence plus Hurwitz's theorem transfers the
real-zero property to the limiting `Xi` function. The real zeros of `Xi` are
exactly the nontrivial zeta zeros written on the critical line, so this gives
RH.

This theorem subsumes the spectral formulation: convergence of individual
eigenvalues is not needed separately if determinant convergence is established.
Conversely, finite self-adjointness and ground-state simplicity alone do not
identify the limiting function or its zeros.

## What must be proved underneath it

The determinant theorem still requires technical components:

- existence and uniform control of the simple-even minimizing state, or a
  replacement by controlled spectral projections;
- convergence of its Fourier/Mellin transform and the determinant prefactor;
- uniform bounds on the prime, archimedean, and evaluation contributions;
- a common completed Weil-form space for all cutoffs;
- exclusion of collapse to the zero function.

The prolate-wave framework is the most promising route for these estimates,
because it controls simultaneous time/frequency concentration and is already
linked to the restricted Weil form. But it is not the operator itself and is
not logically indispensable if another proof of determinant convergence is
found.

## Definitive answer

The finite operator needed is the shifted-Weil quotient rank-one scaling
operator. The one global missing theorem that would make it work is:

> locally uniform convergence of its explicitly normalized regularized
> determinants to Riemann's Xi function.

No current repository computation proves this theorem; finite spectral fits
are evidence only. This is the exact boundary between the identified operator
and an RH proof.
