# Failure invariants

- `S_int + S_ext` is unsigned; the Rees half-weighted sum is `S_ext-S_int`.
- Literal logarithmic weights and von-Mangoldt weights differ on complete
  integer support.
- The proposed B3 implication fails numerically at X=6, c=3/4.
- Cauchy–Schwarz bounds the interior weighted sum in the wrong direction for
  the original psi2 lower bound.
- The proposed Abel summation formula has an index error: at `N=1` its
  right-hand side is `f 0 * g 1`, not `f 0 * g 0`.
# Failure invariant — global signed-sum lift

2026-09-08 — The attempted global signed decomposition used guessed names
`List.sum_congr` and `List.sum_sub_distrib`; this mathlib version has neither
constant. The pointwise identity `rees_weighted_term_signed` compiles, but
the finite-sum lift must use list induction or an available finite-sum API.

The first row-induction formulation also leaves subtraction associativity
goals after rewriting the induction hypothesis; the pointwise identity remains
the stable boundary theorem.

The attempted `SR_S2_log_nonneg`/`SR_S3_log_nonneg` proofs reveal a coercion
obstruction: `List.mem_map` witnesses become `ℝ` after unfolding the nested
logarithmic maps, while `completeSupport_mem_bounds` requires Nat membership.

Explicit Nat-indexed helper sums compile, but are not definitionally equal to
the legacy sums; a separate extensional equality proof is required.

The simplifier confirms the mismatch is structural: legacy definitions use a
coercion/`List.flatMap` representation, so equality requires a dedicated
map/flatMap theorem rather than `rfl` or plain `simp`.

The local theorem `real_inner_mul_inner_self_le` is available, but its
unicode `⟪x,y⟫_ℝ` notation does not parse in `SR_Bridge.lean`; a future
specialization must use the underlying `inner` constant or import notation
explicitly.

The attempted raw-function specialization also fails because
`EuclideanSpace ℝ (Fin n)` is not definitionally a plain `Fin n → ℝ` here,
and the expected real-inner simplification identifier is unavailable.

`WithLp.toLp` plus `PiLp.inner_apply` reaches Cauchy, but the RHS simplifies
to Euclidean norm products rather than coordinate square sums; a separate
norm-squared normalization lemma is needed.

The norm bridge compiles, but the scalar identity `inner ℝ a b = a*b` is not
definitional and does not close by unit sesquilinearity alone.

`RCLike.inner_apply` is present in other mathlib contexts but does not rewrite
scalar `inner ℝ` terms under the current imports.

Importing `Mathlib.Analysis.RCLike.Inner` explicitly does not change this
behavior in `SR_Bridge.lean`; the scalar identity remains unresolved.

Resolution: the usable theorem is the apostrophe variant `RCLike.inner_apply'`,
applied explicitly as a proof term; this closes the scalar normalization.

The indexed-pair bounds theorem must be placed after the complete membership
theorem; inserting it inside that theorem splits its second constructor branch
and produces a misleading parser/type failure. The malformed attempt is
archived in `SR_Bridge.lean`.

The first two finite Abel-summation statements are archived: induction reaches
the successor-successor case with a boundary/index mismatch. A correct Abel
identity needs a separately normalized prefix-sum formulation before Lean
induction can close it.
