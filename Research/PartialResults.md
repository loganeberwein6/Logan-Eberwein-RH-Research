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
