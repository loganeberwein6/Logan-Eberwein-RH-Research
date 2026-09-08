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

## Stage 14 remaining sign data

- Stage 14 proves witness-level Rees sign content:
  - `radical_witness_is_primitive`
  - `I_SR_Rees_radical_negative`
  - `radical_witness_rees_signed_negative`
- Still needed before a full Hodge-Riemann sign theorem:
  - a proof that `I_SR_Rees x x ≤ 0` for every
    `x ∈ P_SR_phys = LinearMap.ker E10_logWeightSumLinear`; or
  - a corrected definition of `P_SR^phys` if the physical primitive sector is
    smaller than the full logarithmic kernel; and
  - an internal SR principle forcing the sign assignment
    `Interior ↦ -1`, `Exit ↦ +1`, rather than importing it as Hodge-index
    motivated external structure.
- Current exact wall:
  - `Rees_sign6_agrees_grade` verifies the signs match the arithmetic grade.
  - `SR14_SIGN_EXTERNAL_MOTIVATION` records that the negative/positive choice
    itself is not yet forced by the prior SR axioms.

## Stage 14D no-go follow-up

Date: 2026-09-06

Lean verified that the current universal partial sign theorem is false:

```lean
not_partial_sign_theorem : ¬ ∀ x ∈ P_SR_phys, I_SR_Rees x x ≤ 0
```

Counterexample:

```lean
partialSignCounterexample := log(5)·e₃ - log(3)·e₅
```

It lies in `P_SR_phys = LinearMap.ker E10_logWeightSumLinear`, but has
strictly positive `I_SR_Rees` square.  Therefore a future full Hodge-Riemann
sign theorem needs additional data, such as a sharper primitive sector than the
whole logarithmic kernel, or a richer signed form than the current compact
X=6 Rees sign table.

## Stage 15 remaining signature/sign-convention data

Date: 2026-09-06

Lean verified the compact formula:

```lean
I_SR_Rees x x =
  E10_realSupportSum x ^ 2 - 2 * (x PrimeIndex6.p2).re ^ 2
```

and the narrowed true-sector characterization:

```lean
P_SR_phys_true x ↔
  x ∈ LinearMap.ker E10_logWeightSumLinear ∧
  E10_realSupportSum x ^ 2 ≤ 2 * (x PrimeIndex6.p2).re ^ 2
```

Lean also verified the exact Rees-bilinear radical criterion:

```lean
M_Rees_form_radical x ↔
  E10_realSupportSum x = 0 ∧ (x PrimeIndex6.p2).re = 0
```

with two named nonzero radical directions `e₃-e₄` and `e₄-e₅`.

Lean further verified the real matrix-kernel certificate:

```lean
M_Rees_real_radical_direction_34 ∈ LinearMap.ker M_Rees.mulVecLin
M_Rees_real_radical_direction_45 ∈ LinearMap.ker M_Rees.mulVecLin
∀ x ∈ LinearMap.ker M_Rees.mulVecLin,
  ∃ a b : ℝ,
    x = a • M_Rees_real_radical_direction_34 +
        b • M_Rees_real_radical_direction_45
∀ a b : ℝ,
  a • M_Rees_real_radical_direction_34 +
      b • M_Rees_real_radical_direction_45 = 0 →
    a = 0 ∧ b = 0
```

Lean then upgraded this certificate to formal rank/nullity statements:

```lean
M_Rees_realKernelEquiv :
  (LinearMap.ker M_Rees.mulVecLin) ≃ₗ[ℝ] (ℝ × ℝ)

M_Rees_real_kernel_finrank :
  Module.finrank ℝ (LinearMap.ker M_Rees.mulVecLin) = 2

M_Rees_rank :
  Matrix.rank M_Rees = 2
```

Lean further packaged the finite signature by explicit coordinates:

```lean
M_Rees_signatureCoord :
  E10R ≃ₗ[ℝ] (ℝ × ℝ × ℝ × ℝ)

M_Rees_signatureCoord_quad :
  M_Rees_quadR x =
    (M_Rees_signatureCoord x).2.2.2 ^ 2 -
      2 * (M_Rees_signatureCoord x).1 ^ 2

M_Rees_signature :
  Matrix.rank M_Rees = 2 ∧
    ∃ pos neg zdim : ℕ,
      pos = 1 ∧ neg = 1 ∧ zdim = 2 ∧
        pos + neg = Matrix.rank M_Rees ∧
        zdim = Module.finrank ℝ (LinearMap.ker M_Rees.mulVecLin)
```

Still needed:

- optionally, if future work needs it, a translation of the direct coordinate
  signature certificate into a mathlib eigenvalue/inertia API theorem;
- a non-tautological, independently arithmetic definition of the physical
  sector if `P_SR_phys_true` is to do more than encode the sign inequality;
- a Selberg/Weil derivation of the sign convention
  `Interior ↦ -1`, `Exit ↦ +1`, or an explicit declaration of that convention
  as additional structure.

## Stage 16 future definitions

Date: 2026-09-06

The compiled Stage 16 core intentionally keeps several ambitious requested
objects as future structure rather than encoding fake proofs:

- A direct finite matrix/inertia certificate for `M_Rees_X30`, replacing the
  current recorded tuple `(pos, neg, zero) = (3,3,4)`; the four displayed
  radical witnesses and nonsingular six-class quotient determinant are now
  verified, and the reduced quotient `pos=3, neg=3` split is recorded by a
  congruence-pivot certificate.  The row-dot action is also proven to factor
  through six class masses.  What remains is packaging these ingredients into
  Mathlib's `Matrix.rank`/kernel-finrank interface.
- The requested asymptotic comparison of the finite `logWeightedInteriorSum`
  values to `X^2/2`.
- A formal fixed-point predicate over a growing family of finite supports and a
  theorem proving or refuting finite fixed points.
- A low-elaboration representation of finite flow transitions.  Attempts to
  package either a whole-kernel rank-one update or a three-cutoff adjacent
  non-fixed theorem directly around dependent matrix/signature functions caused
  repeated capped Lean/Lake stalls on 2026-09-07.  A future repair should try a
  first-order certificate table, e.g. explicit transition records containing
  only Nat-coded source/target IDs and already-proved theorem names, before
  lifting back to dependent cutoff objects.
- A formal de Bruijn-Newman bridge relating SR signature evolution to
  heat-flow motion of Riemann zeros.

## Stage 17 balance theorem repair data

Date: 2026-09-07

The unrestricted Stage 17 target

```lean
∀ X : Rat, X ≥ 6 → pos_count (M_Rees_X X) = neg_count (M_Rees_X X)
```

is false for the raw general Rees sign matrix without further hypotheses.

Compiled counterexample:

- cutoff `X = 7`;
- support `{2,3,5}`;
- matrix `!![-1,-1,1; -1,1,1; 1,1,1]`;
- explicit eigenvalues witnessed in Lean by eigenvector equations:
  `-2`, `1`, and `2`;
- recorded signature summary `(2,1,0)`, so `p ≠ q`.

Definitions or hypotheses needed for a future balance theorem:

- a canonical support-growth law explaining why `{2,3,5}` at `X=7` is not an
  admissible Stage-17 support if the intended theorem is still global;
- or a corrected balance invariant replacing `p-q`;
- or an arithmetic condition on cutoffs/supports that includes the verified
  `X=6` and `X=30` cases but excludes the `X=7` imbalance;
- or a full inertia API formalization that proves exactly when the Rees sign
  matrix has balanced positive and negative counts.

## Stage 18 refined support-condition repair data

Date: 2026-09-07

The Stage 18 candidate repair

```text
balance holds for complete integer supports {2,...,X-1}
```

is false for the current raw Rees sign matrix.

Compiled counterexample:

- cutoff `X = 7`;
- complete integer support `{2,3,4,5,6}`;
- matrix:

```text
[-1 -1  1  1  1]
[-1  1  1  1  1]
[ 1  1  1  1  1]
[ 1  1  1  1  1]
[ 1  1  1  1  1]
```

- recorded signature summary `(2,1,2)`, hence `p ≠ q`.

Definitions or hypotheses now needed:

- a sharper admissibility condition than prime-only versus complete support;
- a classification of which cutoffs/supports produce balanced Rees signature;
- a corrected conserved quantity if `p-q` is not the right invariant;
- a full spectral/inertia theory for the divisor-threshold matrix
  `J - 2D_n`;
- a precise zeta-spectrum conjecture stating the analytic bridge without
  pretending that the finite support condition alone proves it.

## Stage 20 definitions/proofs still needed (2026-09-08)

- A native Lean eigensignature or inertia verifier that computes pos, 
eg, and zero from M_Rees_X, rather than trusting externally recorded certificates.
- A full real matrix version of the boundary theorem using Matrix.det (M - lam • 1) and actual Real.sqrt 2 eigenvalues.
- A proof of the general signature bound for all X≥6, likely via an interlacing/rank-update theorem for the divisor-threshold matrix.
- Formal density statements for balanced even cutoffs and semiprime 2p cutoffs.

## Stage 21 proof ingredients still needed (2026-09-08)

- A proof route replacing the failed parity invariant. The next plausible targets are positive-bias plus an independent upper-bound invariant, or a structural classification of the Rees threshold matrices.
- A proof of 2*N_int < n^2 or a corrected positivity statement if the simple all-ones bias is too weak.
- A Lean-native inertia/eigensignature certificate format that avoids proof-carrying record equality problems.

Stage 21 next proof target sharpened: prove the counting inequality 2*N_int < (X-2)^2 analytically, then connect the positive all-ones quadratic form to pos ≥ neg in the inertia formalism.
