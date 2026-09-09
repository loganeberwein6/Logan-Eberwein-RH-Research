# Nightly log

- Stage 25 continuation: read the revised overnight objective.
- Confirmed the sign obstruction and weight mismatch.
- Searched local Mathlib for finite Cauchy–Schwarz lemmas; no direct theorem
  under the proposed names was found.
- Began the common-weight definition branch.
- Computed diagonal `L_SR( s, X )` values for X=30,210,2310.
- Recorded the zero-factor obstruction at s=0.
- Computed eigenvalue gaps for X=50,100,200.
- Observed a separated top eigenvalue and non-GUE spacing.
- Computed exact traces Tr(M), Tr(M^2), Tr(M^3) at X=6,30,210.
- Recorded that Tr(M^2) equals the squared support dimension.
- Added three explicit conjectural SR/RH equivalence candidates.
- Added killed-approach records DEAD-01 through DEAD-05.
- Added the definition-space comparison for logarithmic and von-Mangoldt weights.
- Added external-connection notes for divisor sums, explicit formulas, and traces.

2026-09-08 — Added `psi2_SR` and `psi2_SR_interior_count` to `SR_Bridge.lean`.
After correcting nested `List.map` membership and declaration order, the
nonnegativity theorem `psi2_SR_nonneg` compiled.  This advances Branch 2.1;
no unsupported ψ₂ comparison was promoted.

2026-09-08 — Added interior/exterior literal-log half-weighted sums and
compiled the exact pointwise signed-term theorem `rees_weighted_term_signed`.

2026-09-08 — Proved `list_sum_map_sub` by induction; this is the local
finite-sum algebra needed to lift the signed-term identity globally.

2026-09-08 — Verified the reusable normalization lemma `real_sub_sum_cons`.

2026-09-08 — Compiled `rees_weighted_row_as_signed_differences`, a stable
row-level lift of the pointwise sign identity.

2026-09-08 — Compiled the independent rows/columns rectangular lift
`rees_weighted_rect_as_signed_differences`; dependent-support induction was
archived as a failed formulation.

2026-09-08 — Compiled `rect_sum_diff_split` and the full rectangular theorem
`rees_weighted_rect_eq_ext_sub_int`.

2026-09-08 — Specialized the decomposition to complete support as
`SR_HalfWeightedSum_eq_ext_sub_int`; all named definitions unfold cleanly.

2026-09-08 — Added explicitly typed logarithmic helper sums and proved their
nonnegativity; the legacy definitions remain separate because equality is not
definitionally reducible.

2026-09-08 — Proved nonnegativity of the typed Cauchy denominator product.

2026-09-08 — Compiled `cauchy_euclidean_inner` using the underlying `inner ℝ`
constant; this bypasses the unavailable Unicode real-inner notation.

2026-09-08 — Proved `euclidean_toLp_real_norm_sq`, converting a WithLp finite
vector norm square to its coordinate square sum.

2026-09-08 — Located `RCLike.inner_apply'` and compiled
`cauchy_fin_sum_verified`, completing the finite-function Cauchy bridge.

2026-09-08 — Added `SRCauchyWitness` and its bound theorem, separating the
finite Cauchy proof from the remaining SR index-enumeration construction.

2026-09-08 — Added total support and ordered-pair index maps `SRSupportAt` and
`SRPairAt`; definitions compile for all X.

2026-09-08 — Proved `SRPairAt_coord_bounds` using Nat division and remainder
lemmas.

2026-09-08 — Imported `Mathlib.Data.List.GetD` and proved
`SRSupportAt_eq_get` for bounded support coordinates.

2026-09-08 — Proved `SRPairAt_components_mem`, showing both indexed pair
components lie in complete support.

2026-09-09 — Repaired and Lean-verified `SRPairAt_components_bounds`; each
ordered support-pair coordinate is now certified in [2, X).

2026-09-09 — Attempted finite Abel summation. Two natural terminal/prefix
 formulations exposed an index-boundary mismatch; both attempts were archived
 and the bridge remains compiling.

2026-09-09 — Replaced the failed induction with Mathlib's
`Finset.sum_range_by_parts`; `abel_summation_finset_verified` compiled.

2026-09-09 — Marked the finite Abel API ready for transport to SR support
indices; the remaining work is the `SRPairAt` range-enumeration bridge.

2026-09-09 — Proved `SRPairAt_index_reconstruct` using `Nat.div_add_mod`;
quotient/remainder reconstruction is now available for the support index map.

2026-09-09 — Proved explicit support-value formulas for `SRSupportAt` and
`SRPairAt`; coordinates are quotient/remainder indices plus 2.

2026-09-09 — A direct `Fin`-to-range double-sum rewrite was attempted and
archived because range binders erase the bounded-index proofs.

2026-09-09 — The standard `sum_fin_eq_sum_range` API was tested; its proof-
dependent `if` normal form confirms that the transport should remain in `Fin`
coordinates rather than forcing raw range notation.

2026-09-09 — Direct List-to-Fin sum induction hit dependent-index recursion
depth; archived and marked for replacement by a library equivalence.

2026-09-09 — Verified `completeSupport_getElem_eq_add_two`, strengthening the
support coordinate formula without dependent sum conversion.

2026-09-09 — Proved `completeSupport_mem_iff`, giving an exact interval
characterization of the complete integer support.

2026-09-09 — Closed Stage 26A: `list_finset_double_sum_bridge` compiled via
`List.sum_toFinset` and `completeSupport_nodup`.

2026-09-09 — Added and compiled `SR_WEntropy.lean`; the finite W-bias
observable is certified directly from the existing signature certificates.

2026-09-09 — Closed the algebraic part of Stage 26B with
`SR_cauchy_log_from_witness`; only witness construction remains.

2026-09-09 — Proved `sr_log_sqrt_factorization`, the pointwise square-root
factorization of the SR interior summand.

2026-09-09 — Closed the Stage 26C algebra with `b3_ratio_bound_algebra`;
the Lean proof exposed the necessary nonnegative-sign hypothesis on `S`.

2026-09-09 — Added the canonical `SRCauchyWitness.ofFunctions` constructor;
the remaining SR construction is isolated to coordinate/sum identities.
