# Cycle 129 — Centered Xi Polynomial Probe

Added `centered_xi_polynomial.py`.

The centered function `xi(1/2+z)` has exactly zero odd Taylor coefficients
numerically at 80-digit precision, confirming the functional-equation
symmetry in the centered coordinate.

The degree-12 even Taylor truncation, written as a polynomial in `y=z^2`, has
complex roots rather than all negative real roots. This finite Taylor
truncation therefore does not provide a hyperbolic/Jensen certificate.

This is a useful failure: evenness alone does not produce a self-adjoint
spectral approximation. A successful finite spectral scheme needs a positivity-
preserving approximation (for example an appropriate Jensen/Weil form), not a
naive Taylor truncation.
