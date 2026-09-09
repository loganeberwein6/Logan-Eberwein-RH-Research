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

- `SRPairAt_components_mem` is complete; the next construction can use the
  existing support bounds on both coordinates.

- `SRPairAt_components_bounds` is complete and compiled. It transfers
  `completeSupport_mem_bounds` to both coordinates of every indexed pair.

- Finite Abel summation remains open: the first two formulations fail at the
  successor-successor boundary and are archived in `SR_Bridge.lean`.

- `abel_summation_finset_verified` is complete using Mathlib's
  `Finset.sum_range_by_parts`; the earlier formulations remain archived.

- The Abel identity is now available for any finite index range. The next
  step is transporting it through `SRPairAt` to the complete-support pair
  enumeration; that transport is still open.

- `SRPairAt_index_reconstruct` is complete. The remaining enumeration proof
  must connect the reconstructed quotient/remainder coordinates to list values.
