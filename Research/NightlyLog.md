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
