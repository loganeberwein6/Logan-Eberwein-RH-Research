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
