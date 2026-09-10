# Stage 36 — Cancellation and explicit-formula audit

## Verified formal state

`SR_Stage36.lean` proves the finite product-fiber reorganization
`SR_product_channel_fiber_identity` using `Finset.sum_product` and
`Finset.sum_fiberwise_of_maps_to`. It defines the requested `k=mn` divisor
target and records the remaining normalization as a precisely named
conjectural proposition. It also records formal conjecture wrappers for
explicit-formula growth and logarithmic equidistribution. It certifies
`SR_gram_entry 30 5 7 = 26` by `native_decide`.

## Numerical results

For `beta=0.8, gamma=21.022`, the exact values at `X=30,100,210,500,1000`
are `-19.4700, 29.8622, 1227.8586, 22676.6135, 63591.7390`.
The proposed single-term explicit-formula ratios are respectively unstable;
there is no numerical proof of a fixed coefficient.

For `X=10,30,100`, the largest Gram eigenvalue of `M^T M` is approximately
`48.8486, 667.4494, 8857.7833`, with operator norms `6.9892, 25.8350,
94.1158`. These disprove the suggested `sqrt(X)`-scale heuristic.

## Open status

The finite divisor-fiber identity, Perron/explicit-formula bridge, Weyl-type
logarithmic equidistribution, and RH equivalence remain unproved. The current
formal conjectures are deliberately not mathematical proofs of those claims.

## Divisor-fiber proof boundary

The exact theorem `SR_product_channel_divisor_form` is now proved. It combines
the conditional-to-filtered-product lemma, the weighted-fiber lemma, the exact
Rees sign identity, explicit natural-to-real cast normalization, and
`Real.log_mul`.

The arithmetic coefficient layer now defines `SR_divisorMultiplicity` and
proves `sr36_filtered_const_sum`, identifying each finite product fiber with
its cardinality times the common fiber value. This is the finite analogue of
the divisor-function coefficient appearing in a Dirichlet series.

Local mathlib search found the Riemann-zeta infrastructure in
`Mathlib.NumberTheory.LSeries.RiemannZeta`, including `riemannZeta`, its
continuation and critical-line zero framework. No existing theorem connects
this finite SR divisor sum to that analytic function; that bridge remains a
new theorem rather than an importable fact.

The attempted sign-normalized fiber theorem also showed that an outer `k`
summand must be rewritten explicitly using the filtered-fiber equality
`p.1 * p.2 = k`; Lean will not perform that dependent rewrite automatically.

The initial `sum_mul`/`mul_sum` route failed syntactically. The successful
route explicitly formed the Cartesian product and applied
`sum_fiberwise_of_maps_to`; support bounds proved every product lies in
`range (X^2)`. The remaining `k=mn` target still requires collapsing the
conditional fiber, rewriting the Rees sign as the `k < X` sign, and proving
the real-power and logarithm normalizations. No temporary placeholder remains.

The reusable lemma `sr36_weighted_fiber_sum` now resolves the general weighted
case. It distributes the outer weight, applies
`Finset.sum_fiberwise_of_maps_to`, and rewrites the fiber equality pointwise.
The remaining application-specific work is expanding the nested conditional
sum into a filtered Cartesian-product sum.

The application attempt failed when a constant fiber value was supplied:
Lean correctly produced a fiber-cardinality factor. Replacing it with the
product-dependent summand exposed the required pointwise `k = m*n` rewrite;
that incomplete application was removed, while the generic lemma remains
verified.
