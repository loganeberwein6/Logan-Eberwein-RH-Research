# Partial results

- `SR_Bridge.lean` now contains the consistent logarithmic definitions
  `SR_S1_log`, `SR_S2_log`, and `SR_S3_log`.
- `vonMangoldt_nonneg` is Lean-verified in the bridge scaffold.
- The original B3 and the first revised B3 equations are not valid without
  the sign and weight repairs recorded in the failure files.

## 2026-09-08 — support-restricted ψ₂ object

`SR_Bridge.lean` now defines `psi2_SR X`, the finite complete-support
von Mangoldt double sum restricted by `m*n < X`, together with the natural
interior-pair count `psi2_SR_interior_count X`.  Lean verifies
`psi2_SR_nonneg X` by unfolding the two finite sums and using
`vonMangoldt_nonneg` termwise.  This is a typed bridge object; no comparison
with unrestricted ψ₂ or partial summation has been asserted yet.

The bridge also defines `SR_Sint_log` and `SR_Sext_log`, and Lean verifies
`rees_weighted_term_signed`: each half-weighted Rees summand is exactly the
negative interior term or positive exterior term.

The auxiliary theorem `list_sum_map_sub` is now proved by direct list
induction, providing the algebraic replacement for unavailable guessed List
subtraction lemmas.

Also verified `real_sub_sum_cons`, the four-term additive normalization needed
to separate head and tail contributions in the remaining row induction.

The row-level theorem `rees_weighted_row_as_signed_differences` now compiles:
the signed Rees row equals the sum of pointwise exterior-minus-interior terms.

The rectangular lift `rees_weighted_rect_as_signed_differences` also compiles,
proving the result for arbitrary independent row and column lists.

`rect_sum_diff_split` and `rees_weighted_rect_eq_ext_sub_int` now convert that
pointwise form into the exact exterior-total minus interior-total expression.

The specialization `SR_HalfWeightedSum_eq_ext_sub_int` now compiles for the
actual complete support and named SR definitions.

Explicitly typed helper sums `SR_S2_log_typed` and `SR_S3_log_typed` now have
Lean-verified nonnegativity theorems, using Nat support bounds before coercion.

Their product nonnegativity is recorded as `SR_log_typed_denominator_nonneg`.

The finite Euclidean Cauchy theorem is now exposed without notation issues as
`cauchy_euclidean_inner`, stated directly with `inner ℝ`.

The missing norm bridge is now verified as `euclidean_toLp_real_norm_sq`.

The full finite-coordinate Cauchy theorem is now verified as
`cauchy_fin_sum_verified`; scalar inner terms are normalized using
`RCLike.inner_apply'`.

`SRCauchyWitness` and `sr_cauchy_witness_bound` package the exact contract for
instantiating the theorem with an ordered-pair enumeration.

`SRSupportAt` and `SRPairAt` now provide a total finite index-to-ordered-pair
map for complete support, including the empty-support edge case.

`SRPairAt_coord_bounds` is verified for positive support length, proving both
quotient and remainder coordinates stay below the support length.

`SRSupportAt_eq_get` now proves bounded `getD` access agrees with ordinary
List indexing, using the dedicated `Mathlib.Data.List.GetD` API.

`SRPairAt_components_mem` now transfers this to both coordinates of every
positive-length ordered-pair index.

`SRPairAt_components_bounds` is now verified: every indexed pair component
inherits the complete-support bounds `2 ≤ coordinate < X`.

`abel_summation_finset_verified` is now Lean-verified via Mathlib's
`Finset.sum_range_by_parts`; it gives the finite Abel identity with the
correct terminal and prefix indices.

`SRPairAt_index_reconstruct` is verified: quotient and remainder recover the
original ordered-pair index, providing the arithmetic core of enumeration.

`SRSupportAt_eq_add_two` and `SRPairAt_eq_add_two` are verified, identifying
the indexed support values as quotient/remainder coordinates shifted by 2.

`completeSupport_getElem_eq_add_two` is also verified, giving the same formula
directly for ordinary bounded List indexing.

`completeSupport_mem_iff` is verified: support membership is exactly the
interval condition `2 ≤ m ∧ m < X`.

Stage 26A is complete: `list_finset_double_sum_bridge` converts nested
List-based support sums to nested `toFinset` sums using `List.sum_toFinset`.
