# Lean targets

1. Prove finite Cauchy–Schwarz for `SR_S1_log`, `SR_S2_log`, `SR_S3_log`.
2. Prove the corrected finite Abel summation identity with explicit indices.
3. Prove the signed decomposition using a common weight family.
4. Define support-restricted `psi2` and compare it to the interior sum.

### Completed 2026-09-08

- `psi2_SR_nonneg`: nonnegativity of the support-restricted von Mangoldt
  double sum.  Next target is a rigorously stated comparison with the
  unrestricted ψ₂, with the support boundary handled explicitly.

- Typed logarithmic denominator nonnegativity is complete.  The next Cauchy
  API target is Mathlib's `inner_le_Lp_mul_Lq_tsum` (or its
  `_of_nonneg`/finite specialization) from `Analysis.MeanInequalities`.

- `SRCauchyWitness` is complete; remaining target is constructing its fields
  from the ordered support pair enumeration.

- `SRPairAt` is complete; next target is proving its range agrees with the
  complete-support ordered pairs when the support length is positive.

- `SRSupportAt_eq_get` is complete; support-value bounds can now be transferred
  from `completeSupport_mem_bounds`.
