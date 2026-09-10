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
# Stage 36 proof-audit update

The finite divisor regrouping is proved in `SR_Stage36.lean`, including the
support-to-`range (X^2)` map, the product-fiber identity, and the exact Rees
sign split. A further attempted interface used a complex finite sum with
`(k : ℂ) ^ (beta - 1/2 + Complex.I * gamma)` and tried to prove that its real
part equals the real cosine divisor sum. After unfolding, the available
Mathlib simplifier did not expose the required real-part formula for complex
powers, so this theorem was removed rather than admitted. This is an API/proof
gap, not evidence for the analytic conjecture.

Additional proof search this cycle tested the more useful exponential
interface
`(k : ℝ)^(beta - 1/2) * Complex.exp ((gamma * Real.log k : ℝ) * I)`.
The actual Lean failures were progressively narrowed: first `HPow ℂ ℝ`
from an incorrectly parsed cast; then an invalid `sum_congr` level because
the outer summand was a product; then an unreduced complex sign conditional;
finally the remaining goal required `Complex.ofReal_log` under a positivity
proof for `k`. The positivity is available from the support witnesses and
the equality `m*n=k`, but was not completed in this cycle. The experiment was
removed, and the source was rebuilt successfully afterward (3336 jobs).

An isolated scalar lemma then reduced the remaining issue further: after
`Complex.mul_re` and `Complex.exp_mul_I`, the target is the real and imaginary
projection of `Complex.cos` and `Complex.sin` on a real argument. The attempted
`rw [← Complex.ofReal_cos, ← Complex.ofReal_sin]` sequence did not match the
elaborated coercions, leaving the same projection goal. That experiment was
also removed; no placeholder was introduced.

The verification command initially failed with `couldn't find value of
ELAN_HOME`; setting `ELAN_HOME=C:\\Users\\ljoe6\\.elan` allowed the complete
`SR_Stage35 SR_Stage36` build to succeed (3337 jobs). Existing unrelated
worktree changes were preserved.

## Reproducible numerical test update

`Research/Stage36_numeric_test.py` now reproduces the prescribed explicit-
formula and Gram tests. The explicit-prediction ratios for the critical-line
model at X=30,100,210,500,1000 are respectively 1.5606, 0.3217, 0.7497,
5.0177, and 0.6264. For the beta=0.8 test against the off-line model they
are 1.2393, -0.1891, 2.2201, 25.1030, and 6.9930. Thus no stable coefficient
is established.

The measured growth exponents from X=100 to X=1000 are:

```
gamma       beta=0.5     beta=0.8
14.1347       1.484        2.163
21.0220       1.750        3.328
25.0109       0.237        0.528
30.4249       0.414          --
32.9351       1.692          --
10.0000       0.417          --
15.0000       1.002          --
20.0000       0.250          --
```

The Gram results are:

```
X=10:  max eig(G)=48.8486, ||M||=6.9892,  ratio ||M||/sqrt(n)=2.4710
X=30:  max eig(G)=667.4494, ||M||=25.8350, ratio ||M||/sqrt(n)=4.8824
X=100: max eig(G)=8857.7833, ||M||=94.1158, ratio ||M||/sqrt(n)=9.5071
```

These finite samples are evidence of oscillation and frequency dependence,
not proof of an explicit-formula asymptotic or RH connection.

## Formal phase projection result

The source now contains `sr36_exp_phase_re`: for every real `x`, the real
part of `exp ((x : Complex) * I)` is `Real.cos x`. The proof expands
`Complex.exp_mul_I`, projects the sum and product with `Complex.add_re` and
`Complex.mul_re`, simplifies the real and imaginary projections of `I` and
the real-cast sine, and closes with `Complex.cos_ofReal_re`. A direct
`lake env lean SR_Stage36.lean` check reached only linter warnings; the
ordinary Lake target could not replace its generated setup artifact because
that artifact remained permission-locked. This verifies the theorem source
but does not yet formalize the full complex divisor-sum explicit formula.

The follow-on theorem `sr36_real_mul_exp_phase_re` is also source-verified:
for real `a,x`, the real part of `a * exp(i x)` is `a*cos x`. Its tactic
sequence expands `Complex.mul_re`, simplifies the real embedding, and uses
`sr36_exp_phase_re`. This is the exact scalar projection needed to lift the
already-proved finite divisor reorganization to a complex exponential sum.

The finite lift is now source-verified by `sr36_complex_product_re`. The
definition sums the real Rees-weighted amplitude times
`exp(i*gamma*(log m + log n))` over the finite support. The first proof
attempt failed with `map_sum` because real-part projection is not expressed
through that generic rewrite. Replacing it with Mathlib's `Complex.re_sum`
at both sum levels, followed by `sr36_real_mul_exp_phase_re`, closed the
theorem. This is a genuine finite complex representation of the product
channel; the analytic ζ/Perron connection remains open.

An additional complex divisor-fiber definition was introduced, but its
reorganization theorem was not retained because the first proof attempt
failed. The exact failures were: reversed orientation of
`sr36_weighted_fiber_sum`, a coercion mismatch between `Complex.ofReal` and
the inferred cast of the sign, and `Finset.sum_product` not matching the
nested binder target. The unproven theorem was removed, leaving the source
compilable; the existing real divisor theorem and complex pair-sum theorem
remain proved.

The isolated theorem `sr36_complex_divisor_fiber_sum` is now proved. It uses
the exact maps-to-range bound for supported products and applies
`sr36_weighted_fiber_sum` with the complex exponential factor as the fiber
weight. This resolves the orientation issue by matching the theorem's
left-hand side exactly. Equality with the complex pair-sum still requires a
separate product-binder normalization step.

The fiber theorem itself is verified by `lake env lean` with exit code 0.
Its proof uses the supported-product range bound and the existing weighted
fiber identity; the parameter `hX` is retained for consistency with the
Stage 36 interfaces but is not needed by this purely finite regrouping.

The coercion boundary is now isolated in `sr36_rees_sign_real_cast`.
After rewriting with `sr36_rees_sign_by_product`, `rfl` failed because
real-to-complex and integer-to-real-to-complex casts are not definitionally
identical. Splitting the threshold cases and using `norm_num` proves both
branches. This supplies the missing pointwise normalization for the final
complex pair-sum theorem.

The final theorem `sr36_complex_divisor_pair_normalization` now compiles.
The successful route uses `Complex.ofReal_mul`, the sign-cast lemma, and the
non-symmetric orientation of `Finset.sum_product`; the earlier `.symm` form
produced the exact reverse equality and failed with a type mismatch.

The direct Lean check passes for the complete finite bridge. Together,
`sr36_complex_divisor_fiber_sum` and
`sr36_complex_divisor_pair_normalization` identify the complex divisor-fiber
sum with the original nested complex product-channel sum. The remaining
gap is analytic rather than finite algebraic: no ζ Dirichlet-series or
Perron identity has yet been proved.

## Analytic-library capability audit

A local search of the available Mathlib sources found special Riemann-zeta
value lemmas and unrelated incidence-algebra/Dedekind-zeta definitions, but
no ready-to-use classical complex Riemann-zeta API, Perron inversion theorem,
or zero-explicit-formula theorem for this construction. Consequently the
finite complex endpoint is formally verified, while the analytic bridge must
be developed as new analysis rather than imported from the current library.

The endpoint theorem `sr36_complex_divisor_re` is now verified. It composes
the fiber regrouping, sign normalization, and complex real-part theorem to
show directly that the real part of the complex divisor-fiber object equals
`SR_channel_product`. This closes the finite algebraic map in one theorem;
the remaining gap begins at the analytic Dirichlet-series identification.
