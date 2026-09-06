# SR Definitions Needed

## Stage 0

- Added `IsPrimeNat` locally because `Nat.Prime` was unavailable in the current Lean-core project.

## Stage 1 Watchpoint

- The written Stage 0 requirement says `P_X = {p prime | p < X}`, but the Stage 1 frozen carrier at `X = 6` uses indices `{2,3,4,5}`, including `4`. Stage 1 must resolve whether the ordered carrier basis is indexed by `PrimeSet 6` or by a separate raw support set below the wall.
- Stage 1 needs a mathlib-backed carrier design using real `ℂ` and `FiniteDimensional.finrank`; local placeholder definitions are explicitly not acceptable.
- The environment needs additional free disk space before the corrected mathlib import probe can finish compiling from source.
- Current resolution in the D-drive verified build: `PrimeSet` remains the
  prime-only Stage 0 predicate, while `PrimeIndex6` is the separate frozen
  four-label Stage 1 support `{2,3,4,5}`.  The name `PrimeIndex6` is historical
  and should eventually be renamed to a neutral support name, but the
  mathematical separation is now explicit in the ledgers.
## Stage 4 typing note

- Lean requires any codomain of `E20_6 →ₗ[ℂ] R` to carry a `Module ℂ R` structure.
  The Stage 4 no-commutativity theorem therefore records `[Module ℂ R]` explicitly as part of the alleged realization data, in addition to `[CommRing R]`.

## Stage 5 typing obstruction

- The displayed Stage 5 theorem
  `∀ x y : E10_6, d (x * y) = d x * y + x * d y`
  is not typeable against the verified foundation as of SR.4.1.
- Reason: Stage 2 provides the external bilinear provenance map
  `SR_mul : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6`; it does not install an internal
  multiplication on `E10` or an action of `E10` on `E20_6`.
- This is mathematically aligned with the frozen rule that the Rees wall is
  not an internal dg differential.  Stage 5 should first define a separate
  two-term Rees object and then state the no-Leibniz theorem against an
  explicitly proposed extra internal structure, rather than adding such a
  structure silently.
- Gap 3 audit update: the later requested exact theorem
  `d (SR_mul x y) = SR_mul (d x) y + SR_mul x (d y)` is also not typeable.
  The left side applies `d : E10 →ₗ[ℂ] E20_6` to `SR_mul x y : E20_6`,
  and the right side applies `SR_mul` to `d x, d y : E20_6` where it expects
  `E10`.  Any exact Leibniz replacement must explicitly introduce the missing
  action/differential interface instead of overloading `SR_mul`.

## Stage 6 typing and data notes

- The displayed positivity theorem
  `∀ x : E11, 0 ≤ Γ_obs (x * dagger x)`
  is not currently typeable because the verified foundation has not introduced
  an internal multiplication on `E11`.
- A complex-valued functional `Γ_obs : E11 →ₗ[ℂ] ℂ` also cannot be ordered by
  `≤` as a raw complex value.  The compiled Stage 6 positivity theorem uses
  the real-valued expression `Complex.normSq (Gamma_obs x)`.
- The displayed non-extension theorem mentions `embed_11_to_20`; no such map
  has been justified or defined.  This is intentionally absent because the
  frozen facts forbid any unjustified map `E20 → E11`, and an extension theorem
  must specify a non-circular embedding/restriction interface before Lean can
  state what extension means.
- Current D-drive repair: `E11` is now a separated `ULift` wrapper, so the
  observed GNS functional is no longer accidentally typed on the same raw
  carrier as `E20_6` by definitional equality.
- Gap 2 audit update: the `ULift` firewall is not enough to prove
  non-extension.  A raw coefficient-forgetting bridge
  `embed_E11_E20 : E11 →ₗ[ℂ] E20_6` exists, and the `(2,2)` coordinate
  functional on `E20_6` extends `Gamma_obs` along it.  To prove a genuine
  `GNS_not_on_E20` theorem, the foundation needs an additional non-raw
  consistency predicate specifying which dagger/provenance constraints an
  extension must preserve and why the raw coordinate functional violates them.

## Stage 8 normalization datum

- Stage 8 proves that the five primitive constraints at `X = 5/2` reduce
  `J_{5/2}(q₂₂)` to a nonnegative real value, but do not pin its magnitude.
- The visible primitive data are:
  - `grade(2,2,5/2) = Exit`;
  - `πΣ(q₂₂) = (4, Exit)`;
  - `ratio/cofactor(q₂₂) = (1,1,2)`;
  - the SW same-prime current imposes nonnegativity.
- Missing mathematical datum:
  - a normalization or scale law assigning a definite nonnegative real value
    to the exit product class `(4, Exit)`, equivalently to the visible
    generator `q₂₂`.
- Candidate mentioned in the Stage 8 objective, not yet promoted:
  - `J_{5/2}(q₂₂) = log(2)^2`.
  - This requires adding a logarithmic arithmetic normalization principle;
    it is not forced by the current primitive channels alone.
- D-drive Stage 8 candidate test:
  - `J52_log_candidate_satisfies_stage8` proves that the candidate
    `J_{5/2}(q₂₂) = log(2)^2` satisfies all current Stage 8 constraints.
  - It remains a candidate normalization, not a canonical theorem, because
    `stage8_moduli_not_point` proves the same constraints also admit distinct
    values such as `0` and `1`.

## Stage 9 valuation-domain correction and scale datum

- The literal Stage 9A structure `ArithmeticValuation : Nat → Real` is empty:
  additivity at `0 * p` contradicts strict positivity on primes.
- The verified usable replacement is `PositiveArithmeticValuation`, whose
  domain is `PosNat`.
- With the positive-domain valuation law, Stage 9 proves a positive-scale
  family:
  - `stage9_moduli`
  - residual freedom is the positive real scale `c`.
- With explicit formula compatibility added as a seventh constraint, Lean
  proves:
  - `explicitFormula_pins_scale`
  - the unique scale is `unitScale`, i.e. `c = 1`.
- Therefore the remaining mathematical choice is not an algebraic degree-two
  ambiguity; it is whether the Selberg explicit-formula normalization is
  admitted as external primitive structure.

## Stage 10 relative Poincaré quotient follow-up

- Stage 10 proves that the absolute logarithmic Poincaré pairing on `E10` is
  degenerate:
  - `PD_radical_nontrivial_X6`
  - `PD_not_nondegenerate_X6`
- The implemented relative carrier is:
  - `PD_relative_quotient_X6 := E10 ⧸ LinearMap.ker E10_logWeightSumLinear`
- Definitions still needed for a fuller relative duality package:
  - the induced quotient pairing on `PD_relative_quotient_X6`;
  - a proof that the radical of `PD_pairing` is exactly
    `LinearMap.ker E10_logWeightSumLinear`, not merely that the kernel is
    contained in the radical;
  - a finite-dimensional rank statement for the radical/quotient, if the
    desired comparison is to the previously advertised `(7,7,3)` inertia
    data;
  - a separate formal carrier and pairing for the full relative `H_X` object,
    since the current Stage 10 file only treats the degree-one `E10` pairing.

## Stage 11 Hodge form correction needed

- Stage 11 verifies that the current complex-bilinear `PD_pairing` is not
  positive semidefinite on complex `E10`:
  - `not_PD_positive_semidefinite`
  - `stage11_sign_conflict`
- Missing structure:
  - a real form of `E10` if the intended square is
    `(Σ a_m log m)^2 ≥ 0` for real coefficients only; or
  - a Hermitian/GNS pairing inserting complex conjugation, e.g.
    `Complex.re (star (L x) * L x)`, if the intended carrier remains complex;
  - a full-support GNS observable if the Weil analog is meant to detect every
    degree-one support direction, since current `Gamma_obs` observes only the
    `(2,2)` mixed coordinate;
  - a separately defined signed intersection form `I_SR`, since the current
    `PD_pairing` has positive diagonal basis values while the target physical
    primitive sign is `I_SR(Z₀,Z₀) ≤ 0`.
- The three verified omega candidates (`omega1`, `omega2`, `omega3`) support
  injective `H⁰ → H²` Lefschetz maps, but they do not by themselves select
  the correct Hodge-Riemann sign form.

## Stage 12 signed Hodge bridge needed

- Stage 12 verifies the Hermitian repair:
  - `H_SR_pos_semidef`
  - `H_SR_pos_def_quotient`
- Stage 12 also verifies the naive classical Weil action is not enough:
  - `HR_Weil_zero`
  - `sign_reconciliation_stage12`
- Missing Stage 13 datum:
  - a definition of the signed intersection form `I_SR`;
  - a map or comparison theorem relating `H_SR` to `I_SR`;
  - an SR-specific Weil operator if the Hodge-Riemann condition is meant to
    use `H_SR(x, Cx)` directly;
  - or a proof that the physical primitive sector uses `I_SR`, not the
    positive Hermitian norm form.

## Stage 13 signed intersection data still needed

- Stage 13 verifies that `C_SR`, the degree-one dagger-induced Weil operator,
  is the identity and gives positive Hermitian HR content through `H_SR`.
- Stage 13 also verifies that the current finite GNS/E11 form
  `I_SR x y = Gamma_obs (dagger (embed_E10_E11 x) * embed_E10_E11 y)` is
  not the desired signed physical intersection form.
- Missing structure:
  - a signed SR intersection functional distinct from the singleton
    `(2,2)` observable `Gamma_obs`; or
  - a formal definition of the physical primitive sector `P_SR^phys` that
    excludes the Stage 10 radical witness; or
  - a sign-twisted comparison map between `H_SR` and the intended `I_SR`; or
  - a full-support GNS/trace observable whose radical/sign behavior matches
    the Selberg-Rees physical form.
- Exact obstruction:
  - Current theorem `I_SR_eq_observed_coordinate` proves the finite `I_SR`
    only sees the `e₂` coordinate.
  - Current theorem `I_SR_radical_witness_pos` proves the known radical
    witness has positive `I_SR` square.
