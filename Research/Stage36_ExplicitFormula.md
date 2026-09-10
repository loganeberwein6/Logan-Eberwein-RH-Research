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

## Finite Dirichlet-polynomial interface

`SR_Stage36.lean` now defines the signed divisor coefficient
`SR_signed_divisor_coefficient X k` and the finite complex polynomial
`SR_signed_dirichlet_polynomial X s`. Its coefficients are the exact Rees
threshold sign times the proved divisor multiplicity, and its kernel is
`exp(-s * log k)`. This is a concrete finite Dirichlet object; convergence,
continuation, and identification with classical ζ remain unproved.

The parameter map `SR_complex_parameter beta gamma` is now explicit:
`-(beta - 1/2) - gamma*I`. It is marked noncomputable because the complex
field instance used by subtraction/division is noncomputable. The source
check passes after this correction. Proving that evaluation at this
parameter reproduces the product-channel kernel is the next algebraic step
toward a genuine Dirichlet-series connection.

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
# Stage 36 parameter-kernel bridge (verified)

`SR_Stage36.lean` now proves the exact exponent decomposition

`-SR_complex_parameter beta gamma * (x : ℂ) = ((beta - 1 / 2) : ℂ) * (x : ℂ) + ((gamma * x : ℝ) : ℂ) * Complex.I`.

The proof is fully checked by Lean using `unfold SR_complex_parameter`, `push_cast`, and `ring`. This is an algebraic parameterization identity only; it does not prove convergence, a Perron formula, an explicit formula, zero detection, or the RH equivalence.

The source also now proves `sr36_log_product_additive`: on the positive finite support, `Real.log ((m*n : Nat) : ℝ) = Real.log m + Real.log n`. The failed first proof used `Real.log_mul (by positivity) (by positivity)`; Lean could not infer nonzeroness. The repaired proof explicitly derives cast positivity with `exact_mod_cast sr36_support_pos` and supplies `hmpos.ne'` and `hnpos.ne'`.

Using that parameter theorem, `sr36_parameter_product_log_exponent` now exposes the exact complex exponent at a divisor product. This is a finite kernel identity; the support hypotheses are retained as interface context, while the algebra itself is inherited from the general parameter theorem. It still makes no analytic claim.

The follow-on theorem `sr36_parameter_product_kernel_split` is also source-verified. It applies `Complex.exp_add` to split the finite kernel into a real-growth exponential and an oscillatory complex exponential. This is the precise finite analogue needed before comparing the kernel with the existing real-power channel; identifying the real exponential with the chosen real-power notation and passing to an infinite zeta/Perron expression remain separate obligations.

The theorem `sr36_product_rpow_exponential` now closes the finite notation gap: positivity from the support permits `Real.rpow_def_of_pos`, `Complex.ofReal_exp` transfers the real exponential into `ℂ`, and exponent commutativity is normalized by the final congruence/ring step. The first post-rewrite attempt left only the reversed multiplication order; the corrected source check exits successfully (with the existing linter diagnostics).

Finally, `sr36_product_kernel_matches_pair_phase` combines the rpow identity with `sr36_log_product_additive` and proves that the product-index kernel is exactly the pair-index kernel used by `SR_product_channel_complex`. Its checked proof is the two rewrites `sr36_product_rpow_exponential` and `sr36_log_product_additive`; no analytic assumptions are introduced.

## Standard build verification

The authorized command `ELAN_HOME=C:\\Users\\ljoe6\\.elan lake -Kjobs=1 build SR_Stage36` completed successfully on the current source, building `SR_Stage36` in 3336 jobs with exit code 0. The prior generated-setup permission failure did not recur. Linter warnings remain, but there are no compilation errors.

The source now also proves `sr36_signed_coefficient_as_fiber_sum`: each signed divisor coefficient is exactly the integer-valued signed constant summed over its finite product fiber. The first insertion was ordered before `sr36_filtered_const_sum`, producing a declaration-order failure; moving it below that reusable lemma allowed `rw [sr36_filtered_const_sum]` followed by `simp [mul_comm]` to close the theorem. This is a concrete coefficient interface for the finite Dirichlet polynomial, not an infinite-series claim.

Its complex-cast companion `sr36_signed_coefficient_complex_as_fiber_sum` is now verified as well. After rewriting by the integer theorem, `norm_cast` transports the finite fiber sum into `ℂ`, giving the exact coefficient form used by the complex polynomial.

The source now proves `sr36_signed_polynomial_as_fiber_sum`. After unfolding the finite polynomial, `simp_rw [sr36_signed_coefficient_complex_as_fiber_sum]` rewrites every coefficient, exposing the polynomial as an outer finite `k`-sum of signed product fibers multiplied by the Dirichlet kernel. This is an exact finite reorganization; it does not assert convergence or identify the polynomial with classical `ζ`.

An attempted stronger theorem, `sr36_signed_polynomial_as_product_sum`, was removed after two checked failures. `rw [Finset.sum_mul]` did not match the filtered-sum binder; replacing it with `simp only [Finset.sum_filter, Finset.sum_mul]` exposed the remaining issue: the polynomial fiber uses `sign(k)`, while the weighted-fiber target uses `sign(m*n)`, requiring an explicit rewrite from the filter equality before the final application. No incomplete declaration or placeholder remains.

A second attempt supplied that explicit equality rewrite successfully (`rw [← heq, Nat.cast_mul]`). The remaining checked mismatch is now only structural: the target retains `∑ k, ∑ p in fiber, sign(p)*kernel`, while `sr36_weighted_fiber_sum` yields `∑ k, kernel * ∑ p in fiber, sign(p)`. The source was restored to a compiling state; the next proof must use a controlled filtered-sum distribution/associativity lemma rather than broad simplification.

The reusable lemma `sr36_filtered_sum_mul_right` now supplies that controlled step for any commutative semiring. Its checked proof symmetrically unfolds the filter, uses `Finset.mul_sum`, and resolves each conditional summand by cases. This removes the sum-distribution API gap; the polynomial collapse still separately requires matching the remaining outer summand and cast-normalization shapes.

The next assembly attempt used the lemma in reverse under the outer `k`-sum. The local sign rewrite (`rw [← heq, Nat.cast_mul]`) succeeded, but Lean still reported that the filtered inner sum was not a rewrite occurrence. This is a binder/congruence limitation of the direct `rw` route, not a mathematical counterexample. The incomplete theorem was removed and the source restored to a verified state.

The outer-`Finset.sum_congr` architecture resolves that boundary. The completed theorem `sr36_signed_polynomial_as_product_sum` normalizes one fiber at a time, rewrites its sign using the filter equality, applies `sr36_filtered_sum_mul_right` in both directions, and finishes the outer equality with `sr36_weighted_fiber_sum`. The direct source check exits successfully. This is the completed finite polynomial-to-product-sum bridge; infinite convergence and zeta identification remain analytic obligations.

The pointwise theorem `sr36_parameter_kernel_matches_pair_phase` now directly connects the complex parameter kernel to the existing pair-phase kernel. It uses the parameter split, the real-power identity, logarithm additivity, and final cast normalization via `congr 1`, `push_cast`, and `ring`. A first placement of those final tactics accidentally targeted the already-closed preceding theorem and produced `No goals to be solved`; relocating them to the parameter theorem yields a clean source check.

The finite lift `sr36_signed_polynomial_parameter_product_sum` is now verified. It specializes the completed polynomial/product theorem at `SR_complex_parameter beta gamma`, giving an exact signed product-index representation for the parameter evaluation. This is the finite Dirichlet interface needed before taking real parts; it makes no claim about an infinite series or classical zeta.

The aggregate theorem `sr36_signed_polynomial_parameter_re` is now verified. It takes the real part of that parameter evaluation and proves equality with `SR_channel_product` by rewriting to the finite divisor form, normalizing casted product logarithms, applying `sr36_parameter_kernel_matches_pair_phase`, and using `sr36_exp_phase_re`. A direct rewrite of the phase theorem initially failed because Lean distributed complex casts; `convert` plus `push_cast; ring` resolved that elaboration boundary. This closes the finite parameter-to-real-channel map.

The stronger complex theorem `sr36_signed_polynomial_parameter_complex` is now verified. It identifies the entire parameter-evaluated finite Dirichlet polynomial with `SR_product_channel_complex`, not merely its real part. Its summand proof uses `← Nat.cast_mul`, the pointwise parameter-kernel bridge, sign-case normalization, and the previously proved complex divisor-pair normalization.

The current source, including this full complex endpoint, was reverified by `ELAN_HOME=C:\\Users\\ljoe6\\.elan lake -Kjobs=1 build SR_Stage36`: build completed successfully in 3336 jobs with exit code 0. A separate auxiliary numerical invocation produced no output, so no unverified Gram values were added.

## Analytic API re-audit

The local Mathlib source exposes `riemannZeta`, its continuation and critical-line zero framework, and the naive Dirichlet-series identity `riemannZeta_eq_tsum` (under the stated real-part hypothesis). The audit found no Perron inversion theorem and no theorem identifying the SR signed divisor polynomial with `riemannZeta` or a zeta product. Therefore the finite equality proved here is a genuine precursor to, but not an imported proof of, the explicit formula.

The finite edge case `sr36_zero_divisor_coefficient` is now proved: the signed coefficient at `k = 0` vanishes because every supported product is positive. The first extensionality attempt failed when `hp` remained a quotient-wrapped membership proof; adding `rw [Finset.mem_filter] at hp` exposed the product witnesses and allowed `sr36_product_pos` followed by `omega` to close the contradiction. This makes the `log 0` term in the range-based finite polynomial harmless at the coefficient level.

The source now also contains `sr36_signed_polynomial_parameter_re_from_complex`, a dependency-clean proof of the real-part channel identity. It rewrites by the full complex equality and closes with `sr36_complex_product_re`, making explicit that the real theorem is a consequence of the stronger complex endpoint rather than a separate normalization argument.

The formal placeholder layer now names the two remaining growth claims required by the objective: `SR_Q_critical_line_growth_conjecture` and `SR_Q_off_line_growth_conjecture`, each with a corresponding `..._certified` theorem. Their bodies are intentionally `True`, so these declarations certify only the existence of explicit conjecture interfaces; they do not prove the stated analytic growth laws. The existing divisor-reorganization, explicit-formula, and logarithmic-equidistribution wrappers remain similarly marked as conjectural interfaces.

The placeholder layer now also names `SR_Q_zeta_nonvanishing_growth_conjecture` and its certification theorem, representing the proposed implication for parameters with `beta > 1/2`. It is deliberately vacuous (`True`) and therefore records the research claim without asserting a zeta theorem or an RH equivalence.

## Reproducible script execution

The prescribed numerical script was rerun successfully with `C:\\Users\\ljoe6\\AppData\\Local\\Python\\bin\\python.exe Research/Stage36_numeric_test.py` (exit code 0). It reproduced the complete explicit-formula table, mixed critical-line scaling table, zero-frequency growth table, and Gram results: the key ratios remain unstable (`1.5606, 0.3217, 0.7497, 5.0177, 0.6264` for the critical model and `1.2393, -0.1891, 2.2201, 25.1030, 6.9930` for the off-line model). These remain numerical evidence, not proofs.
