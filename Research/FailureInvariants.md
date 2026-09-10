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

Directly rewriting a `Fin n` double sum as nested `Finset.range` sums is not
syntactically harmless: range binders hide membership proofs, so constructing
`Fin` coordinates requires an explicit bounded-index map. The attempted
shortcut is archived in `SR_Bridge.lean`.

Even `Finset.sum_fin_eq_sum_range` leaves an `if h : i < n`/proof-dependent
index expression. A clean transport should use a dedicated equivalence or
retain `Fin` sums until the final arithmetic specialization.

A direct induction for `List.sum = ∑ i : Fin length, l[i]` hits recursive
simplification-depth limits on dependent indexing. This is archived; use an
existing List/Fin equivalence or a nondependent `getD` representation.

2026-09-09 — The List-to-Fin sum bridge is available as Fin.sum_univ_fun_getElem; direct rw leaves proof-dependent index terms, but simpa using the symmetric theorem resolves proof irrelevance.
## Stage 29 growth-law lower-bound invariant

The proposed two-sided conjecture requires
`C * X^(3 beta - epsilon) ≤ |Q_X|` for every sufficiently large `X`
with the same positive `C`. The computed normalized values oscillate and
the unnormalized form changes sign; a cosine-phase model necessarily has
arbitrarily small amplitudes near its zeros. Therefore this lower bound is
too strong as stated. A viable formulation must use an upper envelope,
limsup/liminf on subsequences, or an averaged absolute square rather than
a pointwise positive lower bound for all `X`.
## 2026-09-09 — SR_WeilForm source rebuild obstruction

The first source-level failure when rebuilding Stage 29 is `Unknown constant Matrix.dotProduct` in `SR_WeilForm.lean`. Subsequent failures include missing `Fin.castIso`, invalid finite-index transports, and unresolved local theorem references. The cached `.olean` had masked this draft-source incompatibility. The invariant is that the current untracked SR_WeilForm draft targets an older Mathlib API and must be reconstructed as a compatibility module before source-clean builds can resume.

## 2026-09-09 — Stage 29 target build artifact lock

The new finite product-fibre aggregation theorem type-checks with a direct
source invocation (`lake env lean -R . SR_Stage29.lean`).  The authoritative
Lake target cannot currently emit its generated Mathlib artifact:
`failed to write ... .lake/packages/mathlib/.lake/build/lib/lean/Mathlib/Tactic/Linter/DirectoryDependency.olean`.
This is a generated-artifact permission/lock failure, not a Lean source
failure.  No source deletion or overwrite was attempted.
| Goal | First failed line | Missing input |
|---|---|---|
| Verify `Q_X_bound_trivial` in `SR_Stage29.lean` | `import SR_WeilForm` never emitted `SR_WeilForm.olean` during repeated `lake -Kjobs=1 build SR_WeilForm.lean` runs. | Isolate `SR_WeilForm` from the broad `SR_Bridge`/umbrella-mathlib import graph, or complete the cold dependency build; no Lean theorem error was reached. |
| Goal | First failed line | Missing input |
|---|---|---|
| Validate Stage 30 Conrey exponent | Exact enumeration of `SR_weil_form_real` disagrees with the Stage 29 baseline already at X=6. | Identify which prior implementation or normalization produced the stale Q-table before fitting any asymptotic exponent. |
