# External mathematical connections

- The finite signed kernel resembles a truncated divisor-hyperbola operator.
- The von-Mangoldt weighted sums are naturally related to the explicit formula
  for the second Chebyshev convolution.
- The trace `Tr(M^3)` counts signed arithmetic triangles, suggesting a path
  toward higher correlation sums rather than a direct zeta zero count.
- The diagonal prime product has Euler-factor form, but its finite cutoff
  product does not presently match zeta or an L-function by a proved identity.
- A genuine SR-to-zeta bridge would require an explicit-formula theorem for
  the weighted Rees kernel; none is currently available in the project.

2026-09-08 — Local mathlib search identified the applicable Hölder/Cauchy
family: `inner_le_Lp_mul_Lq_tsum`,
`summable_and_inner_le_Lp_mul_Lq_tsum_of_nonneg`, and finite-set
`rpow_sum_le_const_mul_sum_rpow_of_nonneg`.  The typed SR sums are prepared
for this API; no Cauchy theorem is claimed until the index and weight maps are
matched exactly.
