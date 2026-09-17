# Cycle 146 — Positive Definiteness Does Not Imply Real Zeros

The Fourier transform of a positive measure is positive definite, but that
property alone does not force all complex zeros to be real.

Concrete counterexample:

`F(z) = 2 + cos(z)`.

It is the Fourier transform of the positive finite measure
`2*delta_0 + (delta_1 + delta_{-1})/2`, hence is positive definite on the real
axis. But `F(z)=0` has nonreal solutions because `cos(z)=-2`, for example
`z = pi + i arcosh(2)`.

Therefore the positive theta kernel and the resulting positive-definite Xi
transform do not by themselves prove RH. The needed property is stronger:
total positivity, a Laguerre--Pólya limit, a Weil-form positivity theorem, or
an equivalent self-adjoint determinant identity.

This prevents the operator program from silently replacing the RH theorem by
ordinary positive-definiteness.
