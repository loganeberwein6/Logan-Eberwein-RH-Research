# SR Completion Audit

Date: 2026-09-05

This audit tracks fidelity of the D-drive Lean foundation against the full
goal objective.  It is intentionally conservative: a compiling theorem is not
treated as full completion unless it matches the mathematical requirement
without hidden extra assumptions.

## Verified build gate

- Project root: `D:\CodexRH`
- Latest full build observed: `lake -Kjobs=1 build`
- Result: success
- Placeholder audit: no Lean-source matches for `sorry`, `admit`, `axiom`, or
  `unsafe`

## Stage status

- Stage 0: verified.
  - `OPair`
  - `IsPrimeNat`
  - `PrimeSet`
  - `grade`
- Stage 1: verified for the frozen four-label support at `X = 6`.
  - `ordered_carrier_dim_X6`
  - `q23_ne_q32`
  - `SupportIndex6`
  - `supportIndex6_card`
  - `ordered_support_pair_card_X6`
  - `E20_X6`
  - The frozen support includes `4`, so it is now Lean-visible as
    `SupportIndex6`, intentionally separated from the prime-only predicate
    `PrimeSet`.
- Stage 2: verified.
  - `SR_mul`
  - `SR_mul_basis`
  - `mul_is_forced`
- Stage 3: verified.
  - `dagger`
  - `dagger_involution`
  - `dagger_diagonal_fixed`
  - `dagger_add`
  - `dagger_smul`
  - `dagger_h_swap`
  - `E11_mul`
  - `E11_mul_coeff`
- Stage 4: verified.
  - `no_commutative_realization`
  - `antisym_dim_X6`
  - `antisymEmbed`
  - `antisymProjection_embed`
  - `antisymEmbed_injective`
  - `antisymSubmodule_X6`
- Stage 5: partially verified with a faithful typed repair.
  - `ReesCone`
  - `rees_not_leibniz`
  - Caveat: the literal displayed Leibniz formula is not typeable unless extra
    internal product/action data is supplied.  The verified theorem negates a
    local attempted internal commutative Leibniz package instead of installing
    forbidden global structure.
- Stage 6: partially verified with a faithful typed repair.
  - `Gamma_obs`
  - `GNS_positive`
  - `GNS_positive_correct`
  - `Gamma_obs_domain_E11`
  - `embed_E11_E20`
  - `Gamma_obs_E20_extension`
  - `GNS_raw_extension_exists`
  - `E11` is now a separated wrapper, so `Gamma_obs` is not accidentally an
    `E20_6` functional by definitional equality.
  - Gap 1 closed: the internal `E11` product is now defined without importing
    `E20_6`, and correct GNS positivity is proved for
    `Gamma_obs (dagger x * x)`.
  - Gap 2 audit result: the requested raw non-extension theorem is false in
    the current model.  Lean verifies a raw bridge `embed_E11_E20` and a
    coordinate functional on `E20_6` extending `Gamma_obs` along that bridge.
    A genuine non-extension theorem therefore needs an additional non-raw
    compatibility predicate.
- Stage 7: verified as the current pre-orientation line model.
  - `orientation_moduli_X52`
  - `orientationFunctional_q22`
  - `orientationFunctional_satisfies_constraints`
  - `dagger_20_X52`
  - `q_X52_grade_interior_zero`
  - `satisfies_enriched_frozen_constraints`
  - `orientationFunctional_enriched_iff_real`
  - `orientationFunctional_not_enriched_I`
  - Gap 4 audit result: the enriched Rees-grade condition is harmless for the
    retained `q₂₂` line, but full dagger compatibility collapses the previous
    `ℂ`-family to the conjugation-fixed locus.  In particular,
    `orientationFunctional Complex.I` does not satisfy the enriched predicate.
    Therefore the requested enriched `ℂ`-family theorem is false in the
    current model.

## Not complete yet

The goal should remain active.  The current library is compiling and useful,
but the full objective still has fidelity gaps around:

- specifying a non-circular interface for the GNS non-extension theorem;
- repairing or replacing the Gap 2 theorem, since the current raw version is
  refuted by `GNS_raw_extension_exists`;
- repairing or replacing the Gap 3 exact Leibniz theorem, since the displayed
  statement is not typeable against `SR_mul : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6`;
- enriching Stage 7 constraints beyond scalar-linearity on the `q₂₂` line
  while preserving the proved `ℂ`-family underdetermination, or accepting the
  Lean-verified collapse to conjugation-fixed parameters.

## Stage 8 gate

Stage 8 was started after the updated frozen state accepted the Gap 2, Gap 3,
and Gap 4 audit results as authoritative.

- Stage 8 outcome: OUTCOME 2 — moduli reduced but not to a point.
- Verified facts:
  - `grade_22_X52_exit : grade 2 2 X52 = ReesGrade.Exit`
  - `piSigma52_q22 : piSigma52 SupportIndex52.p2 SupportIndex52.p2 = (4, ReesGrade.Exit)`
  - `ratioCofactor52_q22 : ratioCofactor52 SupportIndex52.p2 SupportIndex52.p2 = (1, 1, 2)`
  - `stage8_orientation_value_real`
  - `stage8_orientation_value_nonneg`
  - `orientationFunctional_zero_stage8`
  - `orientationFunctional_one_stage8`
  - `orientationFunctional_zero_ne_one`
  - `stage8_moduli_not_point`
- Interpretation:
  - Rees vanishing does not apply to `q₂₂`, because `grade(2,2,5/2) = Exit`.
  - Dagger compatibility forces the value on `q₂₂` to be real.
  - SW positivity forces the real value to be nonnegative.
  - Product provenance and ratio/cofactor classify the unique visible basis
    vector but do not supply a numerical normalization.
  - Residual moduli: nonnegative real magnitude, `ℝ≥0`.
- Missing datum:
  - a normalization or scale law for the exit product class `(4, Exit)`, for
    example a separately justified logarithmic arithmetic normalization.
- Candidate normalization:
  - `J52_log_candidate_satisfies_stage8` verifies that the suggested
    `log(2)^2` value satisfies the full Stage 8 constraint package.
  - This remains a compatible choice, not a forced orientation theorem, because
    `stage8_moduli_not_point` verifies distinct constrained solutions.

## Stage 9 status

Stage 9 has been formalized and verified with one important correction.

- Literal Stage 9A result:
  - `ArithmeticValuation` over all `Nat` is inconsistent.
  - `no_arithmeticValuation_nat` proves there are no such valuations.
  - The requested `valuation_is_log_multiple` theorem is therefore only
    vacuous for that literal structure.
- Corrected valuation surface:
  - `PositiveArithmeticValuation` over `PosNat`.
  - `logPositiveValuation` constructs the intended `c * log` examples.
- Stage 9B:
  - `stage9_moduli` proves an injective family indexed by positive scale.
  - The valuation law reduces the remaining freedom to one positive real
    scale parameter.
- Stage 9C:
  - `ExplicitFormulaCompat` is the singleton `X=5/2` Mangoldt law.
  - `explicitFormula_pins_scale` proves a unique compatible scale, namely
    `unitScale`.
- Stage 9D:
  - `valuation_forces_descent` proves valuation product weights are symmetric
    on the full frozen `X=6` support.
- Interpretation:
  - Without explicit formula compatibility, Stage 9 leaves positive scale
    freedom.
  - With explicit formula compatibility admitted as the seventh constraint,
    `J(q₂₂) = log(2)^2` is pinned in the positive-domain valuation model.

## Stage 10 status

Stage 10 has been formalized and verified as a relative, not absolute,
Poincaré duality step.

- Implemented objects:
  - `logWeight6`
  - `E10_logWeightSum`
  - `E10_logWeightSumLinear`
  - `PD_pairing`
  - `dagger_10`
  - `PD_radical`
  - `PD_relative_quotient_X6`
- Verified positive/basis facts:
  - `logWeight6_pos`
  - `E10_logWeightSum_basis`
  - `PD_pairing_basis`
- Verified compatibility facts:
  - `PD_symmetric`
  - `dagger_10_basis`
  - `PD_dagger_compat`
- Verified no-go facts:
  - `PD_radical_nontrivial_X6`
  - `PD_not_nondegenerate_X6`
- Interpretation:
  - The Stage 10 pairing on `E10` is rank-one in construction because it
    factors through `E10_logWeightSum`.
  - Therefore the originally hoped-for absolute nondegeneracy on `E10` is
    false.
  - The verified relative replacement is quotienting by
    `LinearMap.ker E10_logWeightSumLinear`.
- Remaining work:
  - Define and prove the induced quotient pairing is nondegenerate.
  - Formalize the full relative `H_X` carrier before making exact inertia
    comparisons such as `(7,7,3)`.

## Stage 11 status

Stage 11 has been formalized as a Lefschetz/sign diagnostic checkpoint.

- Stage 11A:
  - `bivariant_pairing` records the `SR_mul`-then-orient construction.
  - `bivariant_pairing_uses_SR_mul` verifies the definition.
  - `Full_pairing` records the naive full `E20_6` pairing induced by the same
    logarithmic scalar.
  - `Full_pairing_symmetric` verifies symmetry.
  - `Full_pairing_radical_nontrivial_X6` verifies that this full pairing is
    still degenerate.
  - `W_pairing` records the Weil/GNS analog using `E10_to_E11_diag`,
    `dagger`, `E11` multiplication, and `Gamma_obs`.
  - `W_pairing_e2_e2` verifies the current GNS observable is nonzero.
  - `W_pairing_radical_nontrivial_X6` verifies this R3 pairing is still
    degenerate because `Gamma_obs` observes only the `(2,2)` coordinate.
- Stage 11B:
  - `omega1`, `omega2`, and `omega3` are implemented.
  - `omega1_nonzero`, `omega2_nonzero`, and `omega3_nonzero` verify all three
    arithmetic ample candidates are nonzero.
  - `Lefschetz0_omega1_injective`, `Lefschetz0_omega2_injective`, and
    `Lefschetz0_omega3_injective` verify the corresponding `H⁰ → H²`
    Lefschetz maps are injective.
- Stage 11C:
  - `HR_positive_diagonal` verifies positive diagonal basis values.
  - The proposed global semidefinite theorem is false on complex `E10`.
- Stage 11D:
  - `HR_phase_witness_PD_negative` exhibits a negative value:
    `x = i·e₂` gives `PD_pairing x x < 0`.
  - `not_PD_positive_semidefinite` refutes the global semidefinite claim.
  - `stage11_sign_conflict` records the combined result.
- Interpretation:
  - Outcome 2 applies: a sign/form conflict is found.
  - The current `PD_pairing` is not the final Hodge-Riemann form on complex
    `E10`.
  - The next stage needs either a real `E10` form, a full-support
    Hermitian/GNS form, or a separately signed `I_SR` pairing before the
    physical primitive inequality can be stated faithfully.

## Stage 12 status

Stage 12 has been formalized and verified as the Hermitian repair of the
Stage 11 sign failure.

- Stage 12A:
  - `H_SR` is implemented as
    `E10_logWeightSumLinear x * star (E10_logWeightSumLinear y)`.
  - `H_SR_basis` verifies the basis formula.
- Stage 12B:
  - `H_SR_hermitian` verifies Hermitian symmetry.
- Stage 12C:
  - `H_SR_self_eq_normSq` identifies the self-pairing real part with
    `Complex.normSq`.
  - `H_SR_pos_semidef` verifies nonnegativity on complex `E10`.
- Stage 12D:
  - `H_SR_pos_def_quotient` verifies strict positivity away from
    `LinearMap.ker E10_logWeightSumLinear`, i.e. the quotient-positive
    content available from the current carrier.
- Stage 12E:
  - `C_Weil` implements the naive classical `i` action.
  - `HR_Weil_zero` verifies this action gives zero real HR pairing on all
    basis classes.
- Stage 12F:
  - `H_SR_real_restriction_of_logWeight_real` verifies that when the
    logarithmic scalar values are real, the real part of `H_SR` recovers
    `PD_pairing`.
  - `E10_logWeightSum_real_of_coeff_real` upgrades this to a coordinatewise
    real restriction: if every coefficient of `x` has zero imaginary part,
    then `E10_logWeightSum x` is fixed by conjugation.
  - `H_SR_real_restriction` verifies that coordinatewise real `x` and `y`
    recover the real `PD_pairing` through `Complex.re (H_SR x y)`.
- Stage 12G:
  - `sign_reconciliation_stage12` packages the verified state:
    Hermitian positivity, quotient positivity, and Weil-zero.
- Interpretation:
  - Outcome 2 applies: the Hermitian form is positive, but the naive Weil
    operator is not the SR Hodge-Riemann operator.
  - `I_SR(Z₀,Z₀) ≤ 0` remains a Stage 13 bridge problem, not a consequence of
    the positive Hermitian norm alone.

## Stage 13 status

Stage 13 has been formalized as an SR Weil/operator and `I_SR` sign audit.

- Stage 13A:
  - `C_SR` is implemented from the degree-one dagger.
  - `C_SR_eq_id` and `C_SR_basis` verify that this operator is identity on
    `E10`.
  - `HR_C_SR_positive` verifies `H_SR(x, C_SR x) ≥ 0`.
  - `HR_C_SR_positive_quotient` verifies strict positivity away from
    `LinearMap.ker E10_logWeightSumLinear`.
- Stage 13B:
  - `embed_E10_E11` reuses the previously verified diagonal embedding
    `E10_to_E11_diag`.
  - `I_SR` is implemented as
    `Gamma_obs (dagger (embed_E10_E11 x) * embed_E10_E11 y)`.
  - `I_SR_eq_observed_coordinate` verifies the exact current formula:
    `I_SR x y = conj(x₂) * y₂`.
  - `I_SR_e2_e2` verifies the observable is nonzero at `e₂`.
- Stage 13C:
  - `I_SR_radical_witness_value` computes the Stage 10 radical witness square
    as `(log 3)^2`.
  - `I_SR_radical_witness_pos` verifies this value is positive.
  - `not_I_SR_nonpos_on_PD_radical` refutes nonpositivity on the full
    `PD_radical`.
- Stage 13D:
  - `RH_adjacent_statement : True` records the analytic target only as an
    explicit placeholder. No RH consequence is proved.
- Interpretation:
  - Outcome 3 applies for the current finite GNS/E11 `I_SR`.
  - The SR Weil operator repaired the Stage 12 Weil-zero issue for the
    positive Hermitian form.
  - The GNS/E11 `I_SR` presently available is a singleton observed positive
    form, not the signed physical intersection form required for
    `I_SR(Z₀,Z₀) ≤ 0`.
  - Stage 14 should construct the missing signed intersection datum or define
    `P_SR^phys` sharply enough that the current positive radical witness is
    outside the physical primitive sector.

## Stage 14 status

Stage 14 has been formalized as the X=6 full-support and Rees-sign audit.

- Stage 14A:
  - `I_SR_full_matrix` and `I_SR_full` are implemented for all X=6 support
    labels.
  - `E11_mul_h22_h33_observed_zero` verifies the compiled named observed
    coefficient value `hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0`.  The more
    literal combined statement with `Gamma_obs (E11_mul ...)` caused
    elaboration blowup and is recorded in `SR_Failures.md`.
  - Conclusion: the current GNS data alone do not create the desired signed
    full-support intersection form.
- Stage 14B:
  - `Rees_sign6` implements the X=6 sign table.
  - `Rees_sign6_agrees_grade` ties the table back to the arithmetic
    interior/exit grade.
  - `I_SR_Rees` implements the compact equivalent Rees-signed real form.
  - `I_SR_Rees_radical_witness_value` computes the exact witness value.
  - `I_SR_Rees_radical_negative` proves that value is negative.
- Stage 14C:
  - `P_SR_phys` is defined as `LinearMap.ker E10_logWeightSumLinear`.
  - `radical_witness_is_primitive` verifies the Stage 10 radical witness lies
    in this candidate physical primitive sector.
  - `radical_witness_rees_signed_negative` packages primitive membership and
    negativity.
- Stage 14D:
  - The proposed universal theorem
    `∀ x ∈ P_SR_phys, I_SR_Rees x x ≤ 0` is false for the current data.
  - `partialSignCounterexample := log(5)e₃ - log(3)e₅` is verified primitive.
  - `I_SR_Rees_partialSignCounterexample_positive` proves its Rees-signed
    square is strictly positive.
  - `not_partial_sign_theorem` records the no-go theorem.
- Fidelity/circularity audit:
  - The Rees grade is independently defined from the arithmetic wall.
  - The sign convention `Interior ↦ -1`, `Exit ↦ +1` is not forced by earlier
    SR axioms; it is an externally motivated Hodge-index sign input.
  - This is recorded as `SR14_SIGN_EXTERNAL_MOTIVATION`, not as a fully
    internal noncircular sign theorem.
- Interpretation:
  - Outcome 3 applies on circularity/fidelity grounds.
  - There is now verified sign content for a primitive witness under the
    Rees-signed form.
  - A general theorem `∀ x ∈ P_SR_phys, I_SR_Rees x x ≤ 0` is Lean-refuted
    for the present candidate primitive sector/form pair and should not be
    claimed.

## Stage 15 status

Stage 15 has been partially formalized as a compiled signature/sector audit.

- Stage 15A:
  - `M_Rees : Matrix SupportIndex6 SupportIndex6 ℝ` records the X=6 Rees
    sign matrix.
  - `M_Rees_apply` and the entry checks verify that the matrix entries are
    exactly the Stage 14 sign table.
  - `I_SR_Rees_bilinear_formula` proves the general bilinear expression.
  - `M_Rees_signature_witnesses` proves the form has a positive direction, a
    negative direction, and a nonzero radical direction.
  - `M_Rees_has_two_named_radical_directions` verifies the explicit radical
    directions `e₃-e₄` and `e₄-e₅`.
  - `M_Rees_form_radical_iff` proves the exact radical criterion:
    `M_Rees_form_radical x ↔ E10_realSupportSum x = 0 ∧
    (x PrimeIndex6.p2).re = 0`.
  - `M_Rees_real_kernel_two_direction_certificate` proves the real matrix
    kernel contains the two displayed directions `e₃-e₄` and `e₄-e₅`, every
    real kernel vector is a real linear combination of them, and the two
    directions have independent coefficients.
  - `M_Rees_realKernelEquiv` identifies the real matrix kernel with `ℝ × ℝ`.
  - `M_Rees_real_kernel_finrank` proves the real matrix kernel has finrank
    `2`.
  - `M_Rees_rank` proves the requested matrix-rank statement:
    `Matrix.rank M_Rees = 2`.
  - `M_Rees_signatureCoord` gives explicit real signature coordinates
    `(p2,p3,p4,total sum)`.
  - `M_Rees_signatureCoord_quad` proves the diagonal form:
    `M_Rees_quadR x = sum^2 - 2*p2^2` in those coordinates.
  - `M_Rees_signature` packages the full finite signature certificate:
    `pos=1`, `neg=1`, `zero=2`, with `pos+neg = Matrix.rank M_Rees` and
    `zero = Module.finrank ℝ (LinearMap.ker M_Rees.mulVecLin)`.
  - This is a direct coordinate certificate, not a mathlib eigenvalue/inertia
    API theorem.
- Stage 15B:
  - `I_SR_Rees_formula` proves the clean square formula:
    `I_SR_Rees x x = E10_realSupportSum x ^ 2 -
    2 * (x PrimeIndex6.p2).re ^ 2`.
  - This confirms the unique negative contribution comes from the single
    interior product `(2,2)` at X=6.
- Stage 15C:
  - `P_SR_phys_true` is defined as the logarithmic kernel intersected with
    the nonpositive Rees cone.
  - `P_SR_phys_true_sign` proves the sign theorem on this narrowed sector.
  - Audit caveat: this sign theorem is tautological because the nonpositive
    condition is part of the sector definition.
- Stage 15D:
  - `radical_witness_in_true_phys` proves the original radical witness is
    retained.
  - `counterexample_not_in_true_phys` proves the Stage 14 positive
    counterexample is excluded.
- Stage 15E:
  - `P_SR_phys_true_arithmetic_char` gives the independent-looking finite
    arithmetic characterization:
    `x ∈ ker(L)` and
    `E10_realSupportSum x ^ 2 ≤ 2 * (x PrimeIndex6.p2).re ^ 2`.
  - The coefficient `2` is arithmetically tied to the unique interior product
    at X=6, modulo the Stage 14 sign convention.
- Stage 15F:
  - No Selberg explicit-formula derivation of the sign convention has been
    formalized.
  - Current verdict: finite signature/sector analysis is verified, but
    `SR.15.SIGN_ARITHMETIC` is not proved.
  - Remaining wall: prove arithmetically that interior Rees products carry
    negative sign, or record that sign as an explicit extra structure.

RH remains open.

## Stage 18 status

Stage 18 has been formalized as a refined support-condition no-go theorem.

- Critical test:
  - The Stage 18 hypothesis was that prime-only support caused the Stage 17
    imbalance, while complete integer support might restore balance.
  - Lean now tests the complete integer support at `X=7`:
    `{2,3,4,5,6}`.
- Verified complete-support matrix:
  - `X7_complete_matrix_explicit` proves
    `M_Rees_X7_complete =
      !![-1,-1,1,1,1;
         -1,1,1,1,1;
          1,1,1,1,1;
          1,1,1,1,1;
          1,1,1,1,1]`.
- Verified structural witnesses:
  - `X7_complete_radical_45`
  - `X7_complete_radical_56`
  - `X7_complete_negative_witness`
  - `X7_complete_positive_witness_a`
  - `X7_complete_positive_witness_b`
- Recorded signature outcome:
  - `M_Rees_signature_X7_complete = (2,1,2)`.
  - `complete_support_X7_balance_fails` proves `p ≠ q`.
  - `SR18_NG_COMPLETE` records the no-go theorem.
  - `SR18_COMPLETE_SUPPORT_HYPOTHESIS_FALSE` records that complete support is
    not enough.
  - `SR18_COMPUTATIONAL_COMPLETE` records the combined state: balance still
    holds at the computed Stage 16 cutoffs `X=6` and `X=30`, but complete
    support fails at `X=7`.

Interpretation:

- The Stage 17 imbalance is not merely a prime-only support pathology.
- Adding composites `4` and `6` at `X=7` adds radical directions but does not
  restore positive/negative balance.
- Therefore the naive Perelman-surgery analogy "add all composites/complete
  support" is insufficient.
- `SR18_CONJ_ZETA_SPECTRUM` and
  `SR18_SURGERY_REQUIRES_MORE_THAN_COMPLETE_SUPPORT` keep the refined analytic
  direction visible without claiming RH or a zeta-spectrum theorem.

What remains after Stage 18:

- identify the actual admissibility condition behind the balanced `X=6` and
  `X=30` examples;
- replace raw `p-q` balance with a corrected invariant if necessary;
- prove a full inertia theorem for complete-support divisor matrices if the
  recorded signatures are to be upgraded beyond finite certificates;
- supply the analytic zeta-spectrum bridge.

RH remains open.

## Stage 17 status

Stage 17 has been formalized as a balance/no-go audit rather than as the
unrestricted conservation theorem.

- Stage 17A:
  - `M_Rees_general` defines a general finite Rees sign matrix from a rational
    cutoff and a finite support map.
  - `M_Rees_general_entry_symm` proves the matrix entries are symmetric,
    using commutativity of multiplication.
- Stage 17B:
  - `signature_table` repackages the Stage 16 computed signatures:
    `X=5/2 : (1,0,0)`, `X=6 : (1,1,2)`, and `X=30 : (3,3,4)`.
  - `balance_at_computed_X` proves the computed balance facts
    `p(6)=q(6)` and `p(30)=q(30)`.
- Stage 17C/D:
  - The unrestricted target `p(X)=q(X)` for every `X ≥ 6` fails for the raw
    Rees matrix.
  - `BalanceSupport7` uses the finite support `{2,3,5}` at cutoff `X=7`.
  - `M_Rees_X7_counterexample_entries` verifies the matrix
    `!![-1,-1,1; -1,1,1; 1,1,1]`.
  - `M_Rees_X7_neg_eigen`, `M_Rees_X7_pos_one_eigen`, and
    `M_Rees_X7_pos_two_eigen` verify explicit eigenvector equations with
    eigenvalues `-2`, `1`, and `2`.
  - `M_Rees_signature_X7_counterexample` records the resulting signature
    summary `(2,1,0)`.
  - `balance_fails_at_X7_counterexample` proves `p ≠ q` for that summary.
  - `SR17_NG_BALANCE` records the no-go theorem.
  - `SR17_COMPUTATIONAL` records the final Stage 17 computational state:
    balance holds at the computed `X=6` and `X=30` cutoffs, but not
    universally for the unrestricted raw-matrix formulation.

Interpretation:

- The Stage 16 balance pattern is real for the computed cutoffs.
- The raw structural symmetry `M(m,n)=M(n,m)` is not enough to force
  signature balance.
- Therefore Stage 17 does not close the tautological physical-sector problem,
  does not derive the sign convention, and does not provide a general
  W-entropy conservation law.
- A future balance theorem needs an additional arithmetic support-growth
  condition, a different invariant, or a narrower cutoff regime excluding the
  `X=7`, `{2,3,5}` counterexample.

RH remains open.

## Stage 16 status

Stage 16 has been formalized as a compiled finite arithmetic-flow certificate
layer in `SR_Flow.lean`, exposed through the `SR_Flow` lake target.  The
earlier uncompiled draft was archived as `SR_Flow_draft_20260906.lean`.

- Stage 16A:
  - `M_Rees_X` defines the cutoff-dependent Rees sign matrix over `ℝ` from the
    primitive grade: `Interior ↦ -1`, `Exit ↦ +1`.
  - Explicit support labels are present for `X = 5/2`, `X = 6`, and `X = 30`.
  - The recorded signature table is:
    - `X = 5/2`: `(1,0,0)`
    - `X = 6`: `(1,1,2)`, matching the Stage 15 frozen result
    - `X = 30`: `(3,3,4)` as a finite certificate target.
  - `X30_four_radical_witnesses` verifies four explicit row-kernel witnesses
    for the X=30 matrix, supporting the recorded `zero=4` sector.  The theorem
    does not yet prove maximality of the kernel or the positive/negative split.
  - `X30_reducedMatrixInt_det` verifies determinant `-2048` for the six-class
    quotient model, giving a compiled nonsingularity certificate for the
    radical quotient used by the recorded X=30 signature.
  - `X30_reducedInertiaCertificate` records the reduced quotient inertia split
    `pos=3, neg=3` from the congruence-pivot certificate
    `[-1, 2, -2, 32]` plus final determinant block `-16`.
  - `dot30_eq_classMass_formula` proves that the full X=30 row-dot action
    factors through six class masses, supplying the current formal bridge from
    the 10-coordinate matrix to the six-class quotient model.
  - `X30_signature_reduction_certificate` packages the recorded X=30 signature
    tuple with the current radical, quotient, determinant, and reduced-inertia
    evidence.
- Stage 16B:
  - `interiorProductCount` now computes the ordered interior-product count by
    explicit finite support-list enumeration:
    `N_int(5/2)=0`, `N_int(6)=1`, and `N_int(30)=17`.
  - `q_monotone_hypothesis` verifies negative-count monotonicity for the three
    recorded cutoffs: `0 ≤ 1 ≤ 3`.
  - `signatureIndexNumerator` and `signatureIndexDenominator` define the
    finite signature-index bookkeeping.
  - `logWeightedInteriorSum` is now the finite `Real.log` support-list sum.
    `logWeightedInteriorSum_X52_recorded_value` verifies `S(5/2)=0`, and
    `logWeightedInteriorSum_X6_value` verifies `S(6)=log(2)^2`.
    `logWeightedInteriorSum_X30_value` expands `S(30)` to the 17 ordered
    interior-product log terms.
  - `XSquaredHalfBenchmark_X52`, `XSquaredHalfBenchmark_X6`, and
    `XSquaredHalfBenchmark_X30` compute the comparison benchmarks
    `X²/2 = 25/8, 18, 450` at the three cutoffs.  The
    `logWeightedComparison_*_records` package each finite `S(X)` value with
    its benchmark.  The asymptotic comparison remains future work.
- Stage 16C:
  - `SR_flow_entry_update` proves the pointwise crossing values `+1` and `-1`.
  - `SR_flow_entry_update_minus_two` proves the exact pointwise `-2` update:
    when an entry crosses `Exit → Interior`, its sign changes by `-2`.
  - `FlowEntryUpdateRecord` and `q22_X52_to_X6_updateRecord` record the
    concrete `q₂₂` crossing from `X=5/2` to `X=6` as first-order data:
    old sign `+1`, new sign `-1`, delta `-2`.  The theorem
    `q22_X52_to_X6_updateRecord_matches_kernel` verifies that the record
    matches the actual `M_Rees_X` entries.
  - 2026-09-07 audit note: two attempts to promote this to a whole-kernel
    rank-one update theorem were archived in `SR_Failures.md` after repeated
    capped build stalls.  The verified Stage 16C result is therefore the
    scalar entry update, not yet the full matrix/rank-one theorem requested in
    the ideal Stage 16 specification.
- Stage 16D:
  - `SR_dBN_conjecture_statement` records the de Bruijn-Newman correspondence
    as stated/open.  No theorem connects SR signatures to Riemann-zero counts.
  - `SRdBNBridgeScaffold` now names the four Lean-visible pieces of the
    conjectural bridge: interior products as near terms, sign flip as heat
    localization, signature tracking of zero counts, and the still-open limit
    argument.  `SRdBN_conjectural_bridge_recorded` packages those recorded
    claims without promoting them to a proof of the correspondence.
- Stage 16E:
  - `flow_produces_negative_eigenvalues` verifies that the finite flow goes from
    `(1,0,0)` at `X = 5/2` to a tuple with `neg = 1` at `X = 6`.
  - `SR16_SIGN_FROM_FLOW` is therefore a partial sign-origin result: negative
    signature content appears along the arithmetic flow.  It does not yet prove
    the sign convention from Selberg/Weil analysis.
- Stage 16F:
  - `SR_flow_fixed_point_proxy` defines the finite proxy.
  - `X52_not_fixed_against_X6` and `X6_not_fixed_against_X30` show the two
    computed transitions are not fixed under that proxy.
  - `FlowTransitionRecord`, `transition_X52_X6`, and `transition_X6_X30`
    encode the same two transitions as low-elaboration first-order records.
    `computed_transition_records_not_fixed` proves both recorded transitions
    fail the fixed-point proxy without dependent cutoff wrappers.
  - `SR_flow_fixed_point` now states the requested fixed-point shape relative
    to a signature oracle `Rat → SignatureSummary`.  `computedSignatureOracle`
    supplies the three Stage 16 cutoff signatures, and
    `computed_oracle_has_no_fixed_initial_cutoffs` proves the two initial
    computed cutoffs are not fixed under that oracle.
  - `SR16_FIXED_POINT_OPEN` records the universal finite fixed-point theorem as
    future work.
- Stage 16G:
  - `stage16_synthesis` packages the compiled finite-flow facts and open
    checkpoints.

Open and precisely located after Stage 16:

1. Full Selberg/Weil derivation of `Interior ↦ -1`, `Exit ↦ +1`.
2. Direct X=30 matrix rank/inertia theorem packaging the existing class-mass
   factorization, four radical witnesses, reduced determinant, and reduced
   `3/3` split into Mathlib's `Matrix.rank`/kernel-finrank interface.
3. Asymptotic comparison of the finite logarithmic sums to `X^2/2`.
4. The `X → ∞` limit argument.
5. The SR/de Bruijn-Newman correspondence connecting signature evolution to
   actual zero counts.

Distance from RH proof:

The project now has a dynamic finite-flow scaffold, but RH would still require
an analytic bridge from SR signature evolution to zeta-zero locations and a
limit theorem.  No RH consequence has been proved.

## Stage 20 completion audit (2026-09-08)

Status: partial but compiled certificate success.

Completed and Lean-verified:

- File SR_SignatureBound.lean exists and target build passes.
- Complete-support signatures for X=6..200 are recorded in knownSigs and each carries a proof of pos = neg ∨ pos = neg + 1.
- The certificate list has length 195, starts at X=6, and ends at X=200.
- Rees coordinate decomposition is proved as ees_decomposition.
- Transition formula is verified for n=1..8 as 	ransition_formula_verified.
- Boundary determinant/characteristic-equation scaffold is proved as oundary_eigenvalues_sqrt2 over Rat.

Too weak / still open:

- The general theorem for all X≥6 is not proved; it is represented only by SR20_CONJ_SIGNATURE_BOUND : True.
- The boundary theorem is not a full real Matrix.det (M - λ • 1) theorem; it is a rational scalar characteristic-equation certificate.
- Density claims are not proved; SR20_DENSITY_SCAFFOLD is only an explicit placeholder.
- The Lean certificate verifies the recorded signatures, not the eigenspectrum computation that produced them.

RH remains open.

Stage 20 correction: oundary_matrix_det_sqrt2_proxy now proves the exact rational Matrix.det determinant statement for !![-1,b;b,1] with b=±1. Remaining weakness: not yet the full real shifted characteristic determinant Matrix.det (M - lam • 1).

## Stage 21 completion audit (2026-09-08)

Status: not complete as a proof of the all-X signature bound theorem.

What was achieved:

- The first requested proof route, parity, was tested and refuted. X=8 is a compiled counterexample to p-q ≡ X-2 mod 2.
- The Stage 20 X=6..200 certificate was strengthened into separate lower/upper bound checks.
- The hereditary computation was recorded as an external certificate for X=6..100, with the corrected total of 4,845 one-deletion principal submatrices.
- The computational search was extended to X=6..500 with zero bound violations.

What remains open:

- A genuine proof of pos-neg ∈ {0,1} for all X≥6.
- A formal Lean eigensignature computation from matrices rather than recorded certificates.
- A proof of the positive-bias/N_int inequality strong enough to imply pos ≥ neg.
- A proof of the upper bound pos ≤ neg+1 from interlacing, rank updates, or a structural matrix invariant.

RH remains open.

Stage 21 positive-bias audit: computational evidence supports the all-ones positive-bias inequality through X=1000, but this is not yet a general Lean proof of N_int_less_half or of the spectral lower bound.

Stage 21 proof-seed audit: the first analytic ingredients for the positive-bias proof now compile, but they do not yet prove the full N_int_less_half count or the spectral signature bound.

Stage 21 late probe: X=210 (next primorial after 30) supports the balance pattern with signature (13,13,182). X=35, a non-primorial cutoff between 30 and 210, breaks balance with signature (5,4,24). This strengthens the evidence that special cutoffs, not arbitrary complete supports, drive exact p=q balance.

Stage 21 computational bound extension: the signature-bound certificate has been extended externally from X=500 to X=1000 and promoted as a finite Lean record. This is still not the all-X theorem, but it broadens the audited evidence substantially.

Stage 22 upper-bound status: `SR22_UPPER_BOUND_CERT_X6_TO_500` is Lean-checked by `native_decide`. The all-X upper-bound theorem `pos ≤ neg + 1` is not proved; `SR22_UPPER_BOUND_OPEN` records this explicitly.

## Stage 23 paper outline

### Arithmetic Signature Bounds for Selberg-Rees Rees Matrices and Connections to the Riemann Hypothesis

**Abstract.** We introduce the symmetric ±1 matrices `M_Rees_X` indexed by a cutoff `X`, prove the positive-bias inequality `pos(M_Rees_X) ≥ neg(M_Rees_X)` for every `X ≥ 6`, and record a Lean-verified finite certificate for the complementary bound through `X = 500`. The transition law `k_n = n² + 3n - 1` and boundary determinant `-2` are formalized. Density data are recorded as computational evidence, not as an asymptotic theorem.

1. Introduction and motivation: RH and arithmetic Hodge structures.
2. The SR Rees matrix family and ordered support.
3. Decomposition `M = J - 2A`.
4. Positive Bias Theorem.
5. Signature-bound conjecture and finite certificate.
6. Arithmetic flow and transition formula.
7. Density certificates.
8. Conjectural connection to ζ and Conrey-type mollifier bounds.
9. Open problems.

### Stage 23 density record

For `X = 6,...,500`, the computed certificate records 128 balanced even cutoffs out of 248 (`128/248 ≈ 0.5161`) and 22 balanced cutoffs among 52 cutoffs of the form `2p` with `p` prime (`22/52 ≈ 0.4231`). These finite ratios do not establish an asymptotic density. The comparison with Conrey's classical `2/5 = 0.400` lower bound is therefore explicitly conjectural; a proof would require an asymptotic analysis of the Rees signature statistic and an independent theorem relating it to zero-density or mollifier estimates for ζ.

### Stage 23 conjectures

- The balanced `2p` density converges to `2/5` (or a nearby limit) as the cutoff grows.
- The stranded eigenvalue along transition cutoffs converges to `1` from above.
- These spectral-density statements have a precise, but currently unproved, relationship with the proportion of ζ zeros on the critical line.

## Spectral bridge status

The generic Rayleigh implication is Lean-verified, and the finite `Fin`-sum/list-support identity is now also proved. Consequently `SR24_SPECTRAL_BRIDGE` unconditionally proves that the concrete Rees quadratic form is not negative semidefinite for every `X ≥ 6`. This establishes existence of a positive direction, but does not by itself prove `pos ≥ neg`.

The finite signature-bound certificate is extended to X=6..1000 with zero recorded violations. This remains a certificate, not a proof of the universal upper bound.

The boundary proxy has been generalized to non-square cutoffs: the induced ±1 block has trace zero and determinant −2, hence characteristic relation `λ² = 2`.

The all-ones Rayleigh quotient is now formally positive for every `X ≥ 6`. This proves a positive spectral direction, but does not establish the inertia comparison `pos ≥ neg`.

Primorial balance records at X=6, 30, 210, and 2310 are now collected under the explicit Lean certificate `SR_PRIMORIAL_BALANCE_CERT`; no universal primorial balance theorem is claimed.

## Continuous-loop queue status

Problems 1, 3, 4, 5, and 6 are now Lean-proved or explicitly certified at their stated scopes. Problem 2's analytic all-X upper bound remains open; its prescribed finite fallback certificate is verified through X=1000. The signature theorem for arbitrary X therefore remains conjectural.
