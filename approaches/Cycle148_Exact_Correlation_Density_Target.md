# Cycle 148 — Exact Correlation-Density RH Target

The literature audit sharpens the total-positivity target. For the even
Riemann Xi Fourier kernel `Phi`, define

`Phi_(2,y)(t) = cosh(y*t) * integral (t-2s)^2 Phi(t-s) Phi(s) ds`.

Dimitrov--Xu state that RH is equivalent to the translates of `Phi_(2,y)`
being dense in `L^1(R)` for every `y` with `0 < |y| < 1/2` (arXiv:1606.05011,
Theorem 1.1). They derive this through Wronskians, Laguerre--Polya theory, and
Wiener's Tauberian theorem.

This is now the exact analytic target for the operator program:

1. define the completed theta kernel rigorously;
2. construct its correlation kernel and prove the required integrability;
3. prove translate density, or an equivalent nonvanishing Fourier criterion;
4. invoke the Laguerre--Polya equivalence to obtain real Xi zeros.

The finite mode positivity already established supplies only the first local
ingredient; it does not establish the density statement.
