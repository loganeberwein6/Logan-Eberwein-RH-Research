# Stage 28 failure log

## Finset Abel telescoping

The support-restricted definitions, terminal partial-sum identity, monotonicity,
and correction-term positivity all compile. The remaining theorem requires a
finite Abel identity over `Finset.Ico`:

`∑ j ∈ Ico a b, (f j - f (j+1)) = f a - f b`.

The attempted proof using `Finset.sum_Ico_eq_sub` leaves a difference of two
`Finset.range` sums. The direct `simp`/induction attempt does not normalize the
successor-indexed summand, so the Abel bridge is not yet promoted. No weakened
identity was substituted.

## Finite difference helper

The generic telescoping lemma was subsequently proved in `SR_Stage28.lean` by
induction on the range length, followed by `Finset.sum_Ico_eq_sub`. This removes
the original indexing obstruction. The weighted regrouping from ordered pairs
to the coefficient function `c(j)` remains open.

## Lower-bound attempt

The direct termwise proof reached a representation mismatch: `psi2_SR_28` is
a nested `Finset` sum divided by a scalar, while `SR_Sint_log` is currently a
nested `List.map` sum. `Finset.sum_le_sum` therefore cannot apply until the
existing list/finset normalization lemma is instantiated. The attempted proof
is archived as a comment in `SR_Stage28.lean`.

## Product-fiber increment (current blocker)

The missing finite-filter lemma must convert the difference of the two
`≤`-filtered pair sums into the `=`-filtered fiber sum. This is the exact
remaining obligation for specializing Abel summation to `psi2_SR_partial`.

## Lower-bound resolution

The list/finset normalization was supplied by
`completeSupport_sum_eq_finset_sum`, using `List.sum_toFinset` and injectivity
of the support map. The requested lower bound is now verified as
`Sint_log_lower_bound`; the earlier failed attempt remains archived above.

## Product-fiber regrouping

Mathlib exposes `Finset.sum_fiberwise`, which is the appropriate theorem for
grouping ordered pairs by `m * n`. Its finite-index requirement is a `Fintype`,
so the product fibers must first be represented over `Fin X` rather than raw
`Nat`; the required bounded-product coercion and endpoint proof are not yet
implemented.
## All-ones identity type obstruction (revised Stage 28)

The exact target using `Fin (X - 2)` does not close by direct rewriting because
`list_double_sum_eq_fin_double_sum` indexes by `Fin (completeSupport X).length`.
Although `completeSupport_length X` proves these cardinalities equal, Lean does
not identify the two finite index types definitionally inside the nested sums.
The verified replacement is `SR_allones_quadratic_eq_real_entry_sum_length`,
which uses the support-list length directly.  A further transport equivalence
is required to state the equality against `(allOnesEntrySum X : ℝ)` with the
requested `Fin (X - 2)` indexing.

## X=6 witness attempt

The candidate vector `![1, 1, 0, 0]` did not close by `norm_num` after finite
sum expansion; the residual goal reduced to `False`. The exact coordinate
order/sign convention must be checked before promoting a negative witness.
## Numerical off-line-zero witness check

For `v(m) = m^(beta-1/2) * cos(gamma * log m)` on complete supports,
the proposed coercivity witness is not uniformly negative. Computed values
of `vᵀ M_Rees v` were positive for all tested `(beta,gamma)` at `X=6`,
mixed at `X=30` (negative for `gamma=21.02`, positive for `gamma=14.13`),
and positive for all tested pairs at `X=210`. A different weighting or
kernel is required before formalizing an off-line-zero direction.
## Expanded cosine-power scan

Using gamma values `14.1347, 21.0220, 25.0109, 30.4249, 32.9351`,
the direct vector `m^(beta-0.5) cos(gamma log m)` gives mixed signs.
At `X=30`, gamma 21.0220, 25.0109, and 30.4249 are negative across
the tested beta values, while gamma 14.1347 and 32.9351 are positive.
At `X=42` and `X=66` several tested values are negative, but gamma 25.01
is positive. At `X=110`, all tested values are positive. This supports
finite negative directions but not a uniform off-line-zero criterion.
