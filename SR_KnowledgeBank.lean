import SR_Primitives
import SR_Carrier
import SR_Multiplication
import SR_Dagger
import SR_NoCommutativity
import SR_Rees
import SR_GNS
import SR_Underdetermination
import SR_Stage8
import SR_Valuation
import SR_Stage9
import SR_PoincareDuality
import SR_LefschetzDiagnosis
import SR_Lefschetz
import SR_HermitianForm
import SR_ISR
import SR_ISR_Full

namespace SR

set_option maxHeartbeats 200000

/-
Verified foundation results for the Selberg-Rees arithmetic Hodge program.
Nothing enters this file unless the corresponding Lean target compiles.
-/

/- SR.0.1: Primitive ordered pair carrier indices. -/
#check OPair

/- SR.0.2: Local primality predicate for natural-number indices. -/
#check IsPrimeNat

/- SR.0.3: Prime index predicate below a rational cutoff. -/
#check PrimeSet

/- SR.0.4: Rees grade for ordered products relative to a wall. -/
#check grade

/- SR.1.1: The ordered degree-two carrier at X = 6 has dimension 16. -/
#check ordered_carrier_dim_X6

/- SR.1.2: Ordered basis vectors q_23 and q_32 are distinct. -/
#check q23_ne_q32

/- SR.1.3: Neutral frozen support name for X = 6. -/
#check SupportIndex6

/- SR.1.4: The X = 6 support has four labels. -/
#check supportIndex6_card

/- SR.1.5: Ordered pairs of the X = 6 support have cardinality 16. -/
#check ordered_support_pair_card_X6

/- SR.1.6: Neutral alias for the ordered degree-two frozen carrier at X = 6. -/
#check E20_X6

/- SR.2.1: Ordered multiplication is forced by product provenance. -/
#check mul_is_forced

/- SR.3.1: Dagger is an involution on the ordered (1,1) carrier. -/
#check dagger_involution

/- SR.3.2: Diagonal ordered basis vectors are fixed by dagger. -/
#check dagger_diagonal_fixed

/- SR.3.3: Dagger preserves addition. -/
#check dagger_add

/- SR.3.4: Dagger conjugates complex scalar multiplication. -/
#check dagger_smul

/- SR.3.5: Dagger swaps ordered basis labels. -/
#check dagger_h_swap

/- SR.3.6: Internal pointwise product on E11. -/
#check E11_mul

/- SR.3.7: Coordinate rule for the internal E11 product. -/
#check E11_mul_coeff

/- SR.4.1: No injective realization can identify all ordered reversals. -/
#check no_commutative_realization

/- SR.4.2: The antisymmetric sector at X = 6 has dimension 6. -/
#check antisym_dim_X6

/- SR.4.3: The six antisymmetric directions embed into E20_6. -/
#check antisymEmbed

/- SR.4.4: Strict-coordinate projection is a left inverse to the embedding. -/
#check antisymProjection_embed

/- SR.4.5: The antisymmetric embedding is injective. -/
#check antisymEmbed_injective

/- SR.4.6: The antisymmetric sector as an actual submodule of E20_6. -/
#check antisymSubmodule_X6

/- SR.5.1: The Rees wall is a separate two-term cone object. -/
#check ReesCone

/- SR.5.2: No internal commutative Leibniz package preserves ordered provenance. -/
#check rees_not_leibniz

/- SR.6.1: Observed GNS functional is defined only on E11. -/
#check Gamma_obs

/- SR.6.2: The observed GNS functional is positive in real norm-square. -/
#check GNS_positive

/- GAP.1 / SR.6.4: Correct GNS positivity for Gamma_obs(dagger x * x). -/
#check GNS_positive_correct

/- SR.6.3: The observed GNS functional is typed on the separated E11 carrier. -/
#check Gamma_obs_domain_E11

/- GAP.2 / SR.6.5: Raw coefficient-forgetting bridge from E11 to E20_6. -/
#check embed_E11_E20

/- GAP.2 / SR.6.6: Raw E20_6 coordinate extension matching Gamma_obs. -/
#check Gamma_obs_E20_extension

/- GAP.2 / SR.6.7: The raw extension agrees with Gamma_obs on embedded E11. -/
#check Gamma_obs_E20_extension_extends

/- GAP.2 / SR.6.8: Audit counterexample to the displayed non-extension theorem. -/
#check GNS_raw_extension_exists

/- SR.7.1: The X = 5/2 pre-orientation carrier is the q₂₂ line. -/
#check E20_X52

/- SR.7.2: The parameter is exactly the value on q₂₂. -/
#check orientationFunctional_q22

/- SR.7.3: Each orientation functional satisfies the current frozen constraints. -/
#check orientationFunctional_satisfies_constraints

/- GAP.4 / SR.7.5: Dagger on the X = 5/2 pre-orientation carrier. -/
#check dagger_20_X52

/- GAP.4 / SR.7.6: Visible ordered basis coefficient at X = 5/2. -/
#check q_X52

/- GAP.4 / SR.7.7: Interior-grade visible basis directions vanish. -/
#check q_X52_grade_interior_zero

/- GAP.4 / SR.7.8: Enriched frozen constraints for X = 5/2. -/
#check satisfies_enriched_frozen_constraints

/- GAP.4 / SR.7.9: Enriched constraints collapse orientationFunctional to real parameters. -/
#check orientationFunctional_enriched_iff_real

/- GAP.4 / SR.7.10: The imaginary parameter does not satisfy enriched constraints. -/
#check orientationFunctional_not_enriched_I

/- SR.7.4: Orientation choices at X = 5/2 form an injective ℂ-family. -/
#check orientation_moduli_X52

/- SR.8.1: The visible X = 5/2 support is the singleton {2}. -/
#check SupportIndex52

/- SR.8.2: The visible singleton-support q-basis map. -/
#check q52

/- SR.8.3: Product/Rees-grade channel at X = 5/2. -/
#check piSigma52

/- SR.8.4: Ratio/cofactor channel at X = 5/2. -/
#check ratioCofactor52

/- SR.8.5: SW same-prime current at X = 5/2. -/
#check SWCurrent52

/- SR.8.6: q₂₂ has Exit grade at X = 5/2. -/
#check grade_22_X52_exit

/- SR.8.7: πΣ(q₂₂) = (4, Exit). -/
#check piSigma52_q22

/- SR.8.8: ratio/cofactor(q₂₂) = (1, 1, 2). -/
#check ratioCofactor52_q22

/- SR.8.9: q₂₂ carries the visible SW current. -/
#check SWCurrent52_q22

/- SR.8.10: The full Stage 8 constraint package. -/
#check satisfies_stage8_constraints

/- SR.8.11: Stage 8 constraints force the old family's value real. -/
#check stage8_orientation_value_real

/- SR.8.12: Stage 8 constraints force the old family's value nonnegative. -/
#check stage8_orientation_value_nonneg

/- SR.8.13: The zero orientation satisfies all Stage 8 constraints. -/
#check orientationFunctional_zero_stage8

/- SR.8.14: The unit orientation satisfies all Stage 8 constraints. -/
#check orientationFunctional_one_stage8

/- SR.8.15: The zero and unit orientations are distinct. -/
#check orientationFunctional_zero_ne_one

/- SR.8.16: Stage 8 constraints do not pin a unique orientation. -/
#check stage8_moduli_not_point

/- SR.8.17: Stage 8 still needs a normalization datum. -/
#check Stage8_missing_datum

/- SR.8.18: Candidate logarithmic normalization value log(2)^2. -/
#check J52_log_candidate_value

/- SR.8.19: Candidate logarithmically normalized functional. -/
#check J52_log_candidate

/- SR.8.20: The log(2)^2 candidate is dagger-real. -/
#check J52_log_candidate_value_real

/- SR.8.21: The log(2)^2 candidate is nonnegative. -/
#check J52_log_candidate_value_nonneg

/- SR.8.22: The log(2)^2 candidate satisfies all Stage 8 constraints. -/
#check J52_log_candidate_satisfies_stage8

/- SR.8.23: The candidate sends q₂₂ to log(2)^2. -/
#check J52_log_candidate_q22

/- SR.9A.1: Literal all-Nat arithmetic valuation structure. -/
#check ArithmeticValuation

/- SR.9A.NG.1: No literal all-Nat arithmetic valuation exists. -/
#check no_arithmeticValuation_nat

/- SR.9A.2: The requested log-multiple theorem is vacuous for all-Nat valuations. -/
#check valuation_is_log_multiple

/- SR.9A.3: Corrected positive natural domain. -/
#check PosNat

/- SR.9A.4: Corrected positive-domain arithmetic valuation. -/
#check PositiveArithmeticValuation

/- SR.9A.5: Positive scale parameter. -/
#check PositiveScale

/- SR.9A.6: Logarithmic positive-domain valuation family. -/
#check logPositiveValuation

/- SR.9B.1: Stage 9 constraints at X = 5/2. -/
#check satisfies_stage9_constraints

/- SR.9B.2: Stage 9 positive-scale value. -/
#check stage9ScaleValue

/- SR.9B.3: Stage 9 positive-scale family. -/
#check stage9Family

/- SR.9B.4: Stage 9 family satisfies valuation law. -/
#check stage9Family_valuation_law

/- SR.9B.5: Stage 9 family is injective in scale. -/
#check stage9Family_injective

/- SR.9B.6: Stage 9 moduli are positive scale parameters. -/
#check stage9_moduli

/- SR.9B.7: Stage 9 scale value is strictly positive. -/
#check stage9ScaleValue_re_pos

/- SR.9C.1: Unit scale. -/
#check unitScale

/- SR.9C.2: Explicit formula compatibility at X = 5/2. -/
#check ExplicitFormulaCompat

/- SR.9C.3: Unit scale satisfies Stage 9 constraints. -/
#check unitScale_candidate_satisfies_stage9

/- SR.9C.4: Unit scale satisfies explicit formula compatibility. -/
#check unitScale_candidate_explicitFormula

/- SR.9.MAIN: Explicit formula compatibility pins the Stage 9 scale. -/
#check explicitFormula_pins_scale

/- SR.9D.1: Positive natural map for the X = 6 frozen support. -/
#check SupportIndex6.toPosNat

/- SR.9.DESCENT: Valuation product weights force symmetric descent scalars. -/
#check valuation_forces_descent

/- SR.10.1: Logarithmic weight on the X = 6 support. -/
#check logWeight6

/- SR.10.2: Logarithmic weighted-sum functional on E10. -/
#check E10_logWeightSum

/- SR.10.3: Linear form underlying the Stage 10 relative quotient. -/
#check E10_logWeightSumLinear

/- SR.10.4: Stage 10 Poincaré pairing on E10. -/
#check PD_pairing

/- SR.10.5: Logarithmic weights are positive on the X = 6 support. -/
#check logWeight6_pos

/- SR.10.6: Basis evaluation of the logarithmic weighted sum. -/
#check E10_logWeightSum_basis

/- SR.10.7: Basis matrix of the Stage 10 pairing is log(m) log(n). -/
#check PD_pairing_basis

/- SR.10.8: Stage 10 pairing is symmetric. -/
#check PD_symmetric

/- SR.10.9: Degree-one dagger is trivial on E10. -/
#check dagger_10

/- SR.10.10: Stage 10 pairing is compatible with dagger_10. -/
#check PD_dagger_compat

/- SR.10.11: Radical predicate for the Stage 10 pairing. -/
#check PD_radical

/- SR.10.12: Concrete logarithmic radical witness. -/
#check PD_radical_witness

/- SR.10.13: The radical witness has zero logarithmic weighted sum. -/
#check PD_radical_witness_weight_zero

/- SR.10.14: The radical witness lies in the Stage 10 radical. -/
#check PD_radical_witness_in_radical

/- SR.10.15: The radical witness is nonzero. -/
#check PD_radical_witness_ne_zero

/- SR.10.NG.1: The absolute X = 6 pairing has nontrivial radical. -/
#check PD_radical_nontrivial_X6

/- SR.10.NG.2: Absolute nondegeneracy on E10 is false. -/
#check PD_not_nondegenerate_X6

/- SR.10.16: Relative quotient carrier by the logarithmic weighted-sum kernel. -/
#check PD_relative_quotient_X6

/- SR.10.REL: Stage 10 requires the relative quotient. -/
#check PD_relative_requires_quotient_X6

/- SR.11A.1: Ordered degree-two logarithmic product weight. -/
#check e20LogWeight6

/- SR.11A.2: Logarithmic orientation scalar on E20_6. -/
#check E20_logWeightSum

/- SR.11A.R1: Bivariant pairing is the SR_mul-then-orient form. -/
#check bivariant_pairing_uses_SR_mul

/- SR.11A.3: Naive full E20 pairing from the same scalar. -/
#check Full_pairing

/- SR.11A.4: Naive full E20 pairing is symmetric. -/
#check Full_pairing_symmetric

/- SR.11A.NG.1: Naive full E20 pairing still has nontrivial radical. -/
#check Full_pairing_radical_nontrivial_X6

/- SR.11A.R3.1: Diagonal embedding from E10 to E11 for the Weil/GNS test. -/
#check E10_to_E11_diag

/- SR.11A.R3.2: Current Weil/GNS analog on E10. -/
#check W_pairing

/- SR.11A.R3.3: The current Weil/GNS analog sees e₂. -/
#check W_pairing_e2_e2

/- SR.11A.R3.NG: Current singleton-observed Weil/GNS analog is degenerate. -/
#check W_pairing_radical_nontrivial_X6

/- SR.11B.1: Diagonal ample candidate. -/
#check omega1

/- SR.11B.2: Log-weighted diagonal ample candidate. -/
#check omega2

/- SR.11B.3: Full Selberg-kernel ample candidate. -/
#check omega3

/- SR.11B.4: Lefschetz map from H0 to E20_6. -/
#check Lefschetz0

/- SR.11B.5: Diagonal ample candidate is nonzero. -/
#check omega1_nonzero

/- SR.11B.6: Log-weighted diagonal ample candidate is nonzero. -/
#check omega2_nonzero

/- SR.11B.7: Full Selberg-kernel ample candidate is nonzero. -/
#check omega3_nonzero

/- SR.11.HL.1: Lefschetz map for omega1 is injective. -/
#check Lefschetz0_omega1_injective

/- SR.11.HL.2: Lefschetz map for omega2 is injective. -/
#check Lefschetz0_omega2_injective

/- SR.11.HL.3: Lefschetz map for omega3 is injective. -/
#check Lefschetz0_omega3_injective

/- SR.11.HR_DIAGONAL: Diagonal degree-one classes are HR-positive. -/
#check HR_positive_diagonal

/- SR.11.SIGN_WITNESS: A complex phase makes PD_pairing negative. -/
#check HR_phase_witness_PD_negative

/- SR.11.SIGN_NG: PD_pairing is not positive semidefinite on complex E10. -/
#check not_PD_positive_semidefinite

/- SR.11.SIGN_CONFLICT: Diagonal positivity coexists with global sign failure. -/
#check stage11_sign_conflict

/- SR.12A.1: Hermitian SR Hodge form on E10. -/
#check H_SR

/- SR.12A.2: Hermitian form basis evaluation. -/
#check H_SR_basis

/- SR.12B.1: Hermitian symmetry. -/
#check H_SR_hermitian

/- SR.12C.1: Hermitian form is positive semidefinite on complex E10. -/
#check H_SR_pos_semidef

/- SR.12D.1: Hermitian form is positive away from the logarithmic kernel. -/
#check H_SR_pos_def_quotient

/- SR.12E.1: Naive classical Weil operator on E10. -/
#check C_Weil

/- SR.12E.2: Naive Weil operator on basis classes. -/
#check C_Weil_basis

/- SR.12.WEIL_ZERO: Naive Weil operator gives zero real HR test on basis. -/
#check HR_Weil_zero

/- SR.12F.1: Real scalar restriction recovers the PD pairing on real parts. -/
#check H_SR_real_restriction_of_logWeight_real

/- SR.12F.2: Coordinatewise real vectors have real logarithmic scalar. -/
#check E10_logWeightSum_real_of_coeff_real

/- SR.12F.3: Coordinatewise real restriction recovers PD pairing on real parts. -/
#check H_SR_real_restriction

/- SR.12.RECONCILE: Hermitian positivity plus Weil-zero checkpoint. -/
#check sign_reconciliation_stage12

/- SR.13A.1: SR Weil operator induced by dagger on E10. -/
#check C_SR

/- SR.13A.2: The SR Weil operator is identity on degree one. -/
#check C_SR_eq_id

/- SR.13.WEIL_SR: H_SR is positive against C_SR. -/
#check HR_C_SR_positive

/- SR.13.WEIL_SR_QUOTIENT: H_SR is strictly positive against C_SR off the logarithmic kernel. -/
#check HR_C_SR_positive_quotient

/- SR.13B.1: Diagonal E10 to E11 embedding used by I_SR. -/
#check embed_E10_E11

/- SR.13B.2: Finite GNS/E11 Selberg-Rees pairing. -/
#check I_SR

/- SR.13B.3: Current I_SR observes only the e2 coordinate. -/
#check I_SR_eq_observed_coordinate

/- SR.13B.4: I_SR basis statement through the diagonal embedding. -/
#check I_SR_basis

/- SR.13B.5: I_SR(e2,e2)=1. -/
#check I_SR_e2_e2

/- SR.13C.1: Exact value on the Stage 10 radical witness. -/
#check I_SR_radical_witness_value

/- SR.13.SIGN_WRONG: The Stage 10 radical witness has positive I_SR value. -/
#check I_SR_sign_wrong_on_radical_witness

/- SR.13.SIGN_NG: I_SR is not nonpositive on the full PD radical. -/
#check not_I_SR_nonpos_on_PD_radical

/- SR.13D.1: RH-adjacent placeholder; analytic bridge not yet formalized. -/
#check RH_adjacent_statement

/- SR.13.OUTCOME: SR Weil positivity plus current I_SR sign conflict. -/
#check stage13_outcome

/- SR.14A.1: Full-support GNS/E11 matrix coefficient at X=6. -/
#check I_SR_full_matrix

/- SR.14A.2: Full-support GNS/E11 form over all X=6 support labels. -/
#check I_SR_full

/- SR.14A.FORK: Current E11/Gamma observable kills the h22*h33 off-diagonal term. -/
#check E11_mul_h22_h33_observed_zero

/- SR.14A.3: Matrix coefficient reduces to observed product at (2,2). -/
#check I_SR_full_matrix_eq_observed_product

/- SR.14B.1: Rees sign table at X=6. -/
#check Rees_sign6

/- SR.14B.2: Rees sign table agrees with the grade definition. -/
#check Rees_sign6_agrees_grade

/- SR.14B.3: Real support sum used in the compact Rees-signed form. -/
#check E10_realSupportSum

/- SR.14B.4: Rees-signed real form at X=6. -/
#check I_SR_Rees

/- SR.14.SIGN_WITNESS_VALUE: Exact Rees-signed value on the radical witness. -/
#check I_SR_Rees_radical_witness_value

/- SR.14.SIGN_WITNESS_NEG: Rees-signed radical witness is negative. -/
#check I_SR_Rees_radical_negative

/- SR.14C.1: Candidate physical primitive sector at X=6. -/
#check P_SR_phys

/- SR.14C.2: Physical primitive sector is the logarithmic kernel. -/
#check P_SR_phys_definition

/- SR.14C.3: Stage 10 radical witness is primitive. -/
#check radical_witness_is_primitive

/- SR.14D.1: Counterexample vector to the universal primitive-sector nonpositive claim. -/
#check partialSignCounterexample

/- SR.14D.2: The counterexample vector lies in the candidate physical primitive sector. -/
#check partialSignCounterexample_is_primitive

/- SR.14D.3: Rees-signed value on the counterexample is explicit. -/
#check I_SR_Rees_partialSignCounterexample_value

/- SR.14D.4: The counterexample has positive Rees-signed square. -/
#check I_SR_Rees_partialSignCounterexample_positive

/- SR.14D.NOGO: Universal nonpositive sign theorem fails for current P_SR_phys. -/
#check not_partial_sign_theorem

/- SR.14.SIGN_EXTERNAL_MOTIVATION: Rees sign convention is external Hodge-index motivation. -/
#check SR14_SIGN_EXTERNAL_MOTIVATION

/- SR.14.OUTCOME: Off-diagonal GNS collapse plus Rees-signed negative witness. -/
#check stage14_outcome

end SR
