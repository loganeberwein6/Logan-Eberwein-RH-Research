# Candidate SR equivalences (conjectural)

These are research conjectures only; none is Lean-proved.

## C1 — weighted positivity limit

RH is equivalent to the assertion that a suitably normalized von-Mangoldt
SR Dirichlet form has nonnegative limiting quadratic form for every cutoff
and every test polynomial.

Evidence: finite all-ones Rees positivity is proved for every recorded cutoff;
the analytic test-polynomial extension is missing.

## C2 — primorial spectral strand

RH is equivalent to convergence of the distinguished primorial Rees strand to
the critical value 1 from above, together with a uniform bound on all other
normalized strands.

Evidence: finite primorial records at 6, 30, 210, and 2310 show balance and a
decreasing distinguished strand, but no limiting theorem exists.

## C3 — weighted explicit-formula positivity

RH is equivalent to positivity of the explicit-formula transform of the
von-Mangoldt weighted Rees kernel for every compactly supported nonnegative
test function.

Evidence: the kernel is an explicit finite arithmetic object and its
unweighted all-ones form is positive.  The missing step is the SR-to-zeta
explicit-formula identity.

## Stage 26 W-SR equivalence (2026-09-09)

The formal scaffold defines W_SR_converges as normalized signature-bias convergence and W_SR_RH_bridge as the proposed implication from that convergence to asymptotic zero density. The intended equivalence is recorded as the conjectural package: RH ↔ W_SR_converges ∧ W_SR_RH_bridge. Current Lean evidence proves neither direction. The verified content is limited to the finite signature certificates, the W_SR bounds on the certified range, the trace parity formula, and the logarithmic Cauchy bridge. Establishing either implication requires new analytic input connecting Rees spectral data to zeta zero statistics.

## Stage 28 Abel bridge (in progress, 2026-09-09)

The Stage 28 file now verifies the support-restricted `psi2_SR` definitions,
terminal partial-sum identity, monotonicity, nonnegativity, and positivity of
the square-root correction increments. A generic finite-difference telescoping
lemma is also verified by induction. The exact weighted Abel regrouping from
`SR_Sint_log` to `psi2_SR` is still open, so the requested upper/lower bounds,
combined B3 bound, and `T_log` estimate are not yet promoted. The SR-to-zeta
chain therefore remains conjectural beyond the already proved B3 inequality.
## Stage 29 Rees cancellation and growth-law boundary

The finite identity `Q = Q_ext - Q_int` is Lean-verified for the real SR
observable, and the corresponding symmetric matrix/bilinear interfaces are
verified. Numerical data support bounded normalized envelopes for
`Q/X^(3 beta)`, but phase oscillation invalidates a uniform positive lower
bound for all cutoffs. The `X^(3 beta)` asymptotic and its coefficient remain
unproved; any viable theorem must use an envelope, averaged square, or
subsequence statement rather than the original pointwise two-sided bound.
## Stage 30 exact-definition correction

The proposed Conrey exponent `3/2 + (2/5)(beta - 1/2)` is not supported by
the current Lean definition.  Direct enumeration disagrees with the earlier
Stage 29 Q-table at X=6,30,110, so the apparent Conrey connection is
**killed pending identification of the stale numerical normalization**.

The replacement model is structural rather than asymptotic. With

`w_beta,gamma(n) = n^(beta-1/2) cos(gamma log n)` and
`I_X = sum_{mn<X} w(m) w(n)`, the exact implemented observable satisfies

`Q_X = (sum_{2<=n<X} w(n))^2 - 2 I_X`.

This identity explains the observed cancellation and is the correct starting
point for any future asymptotic analysis. No universal power exponent has been
established from the current data.
## Two-Channel Decomposition (Stage 31)

`cos(gamma log m) * cos(gamma log n)` equals one half of the ratio-frequency
term plus one half of the product-frequency term. The decomposition is now
formally proved in `SR_Stage31.lean`.

## Correct Ratio-Channel Diagonal (Stage 32)

The diagonal uses the square-root cutoff `m*m < X`, not the half-wall cutoff
used by `reesTrace`. Its unweighted sign sum is
`(X-2) - 2*(floor(sqrt(X-1))-1)` for the tested support.

## Stage 35 off-diagonal reformulation

The ratio channel has a genuine Gram-type off-diagonal term. The proved
trivial estimate is bounded by the square of the absolute weight sum, but
this does not establish cancellation. At `X=210`, numerical values are
`Q_total=1227.8586`, `Q_diag=3145.2677`, and `Q_offdiag=-1917.4090`.
Euler–Maclaurin control, product-channel control, equidistribution, Weil
identities, and RH implications remain conjectural and unproved.

## Explicit Formula Connection (Stage 36)

The exact numerical test does not validate a universal pointwise formula of
the form `Q_X = C Re(X^(rho+1)/(rho+1))`: ratios vary strongly with `X`.
The structural mechanism remains plausible through the product channel and
its divisor-fiber reorganization, but the equality to a zeta explicit formula
is not proved. Claims that critical-line frequencies force `X^(3/2)` growth,
or that off-line frequencies force `X^(beta+1)` growth, are conjectures only.
