# Cycle 130 — Jensen Polynomial Xi Test

Added `jensen_xi_probe.py` for the real entire function
`Xi(t) = xi(1/2 + i t)`.

At 35-digit precision, the computed odd Taylor coefficients vanish, and the
degree-2 and degree-4 Jensen polynomials tested here have entirely real roots.

This is the correct kind of finite positivity/hyperbolicity diagnostic for a
critical-line formulation, unlike the naive polynomial in `z^2`. It remains a
finite necessary-condition test only: proving hyperbolicity for every Jensen
polynomial, or proving the corresponding Laguerre--Pólya limit, would still be
the global RH-level theorem.
