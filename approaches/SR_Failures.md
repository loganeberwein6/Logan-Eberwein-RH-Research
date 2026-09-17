# SR Failure Ledger

## Stage 0

### Attempt 1 - Syntax / missing object

Target: `lake build SR_Primitives`

Raw error excerpt:

```text
error: SR_Primitives.lean:14:34: unexpected token '}'; expected '=>'
error: SR_Primitives.lean:13:25: Function expected at
  Set
but this term has type
  ?m.1

Hint: The identifier `Set` is unknown, and Lean's `autoImplicit` option causes an unknown identifier to be treated as an implicitly bound variable with an unknown type.
```

Resolution: represent the prime set as the predicate `Nat → Prop`, avoiding the unavailable `Set` notation in the minimal Lean-core Stage 0 project.

### Attempt 2 - Missing Lean object

Target: `lake build SR_Primitives`

Raw error excerpt:

```text
error: SR_Primitives.lean:14:11: Unknown constant `Nat.Prime`
```

Resolution: add local predicate `IsPrimeNat` and define `PrimeSet` in terms of it.

## Subagent Contamination

`lean_api_scout` exceeded its read-only instruction and generated Stage 1-3 files plus Lake target changes. These files compiled against local placeholder definitions, not mathlib's `ℂ` or `FiniteDimensional.finrank`. They were copied to `archive/subagent_unverified_2026-09-04/` and removed from the active knowledge-bank import chain.

## Stage 1

### Dependency setup attempt 1 - Lake/git fetch stalled

Target: `lake update mathlib`

Observation: Lake's default clone created a partial `.lake/packages/mathlib/.git` with a large temporary pack file, then stopped making observable progress. The partial clone was archived at `archive/partial_mathlib_2026-09-04_2/`.

### Dependency setup attempt 2 - Shallow exact-tag clone succeeded, Lake update failed

Target: `git clone --depth 1 --branch v4.29.1 https://github.com/leanprover-community/mathlib4.git .lake\packages\mathlib`

Result: checkout succeeded at commit `5e932f97dd25535344f80f9dd8da3aab83df0fe6`.

Follow-up target: `lake -v update mathlib`

Raw error excerpt:

```text
trace: C:\Users\ljoe6\CodexRH\.lake\packages\mathlib> git fetch --tags --force origin
fatal: unable to access 'https://github.com/leanprover-community/mathlib4.git/': Failed to connect to github.com port 443 after 66 ms: Could not connect to server
error: external command 'git' exited with code 128
```

Resolution in progress: root `lake-manifest.json` was repaired to point at the exact existing mathlib checkout so Lake can be tested without another metadata fetch.

### Dependency setup attempt 3 - Cache partially downloaded, disk full during decompression

Target: `lake exe cache get`

Raw error excerpt:

```text
Downloaded: 8232 file(s) [attempted 8232/8232 = 100%]
There is not enough space on the disk. (os error 112)
Decompressed 3554 file(s)
4678 decompression(s) failed
```

Resolution in progress: remove generated cache artifacts to recover disk space, then probe only the Stage 1 imports.

### Stage 1 import probe attempt 1 - Missing mathlib module path

Target: `lake -R build SR_ImportProbe`

Raw error excerpt:

```text
error: no such file or directory
  file: C:\Users\ljoe6\CodexRH\.lake\packages\mathlib\Mathlib\LinearAlgebra\FiniteDimensional.lean
error: SR_ImportProbe.lean: bad import 'Mathlib.LinearAlgebra.FiniteDimensional'
```

Resolution: source search showed the correct v4.29.1 path is `Mathlib.LinearAlgebra.FiniteDimensional.Basic`.

### Stage 1 import probe attempt 2 - Interrupted to preserve disk

Target: `lake build SR_ImportProbe`

Result: the corrected import began compiling the required mathlib chain and reached approximately `1233/1548` build tasks. The process was interrupted deliberately when free space on `C:` dropped to about `0.20 GB`, to avoid another disk-full failure.

Failure invariant: Stage 1's honest mathlib-backed theorem is currently infrastructure-limited by local disk capacity. The workspace has a valid mathlib checkout and many compiled artifacts, but there is not enough free space to finish the required import build or hold a full mathlib cache.

### Stage 1 import probe attempt 3 - Resource failure under lighter import

Target: `lake lean SR_ImportProbe.lean`

Probe imports:

```lean
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.Data.Complex.Basic
```

Result: the lighter import avoided the bad module path and continued compiling mathlib from source, but the parallel build failed with process/resource errors while `C:` had less than `0.20 GB` free.

Raw error excerpts:

```text
libc++abi: terminating due to uncaught exception of type lean::exception: failed to create thread
libc++abi: terminating due to uncaught exception of type std::bad_alloc: std::bad_alloc
```

Resolution needed: free disk space and rerun with constrained parallelism, for example `lake -Kjobs=1 lean SR_ImportProbe.lean`, or use a complete precompiled cache on a volume with enough space.

### Stage 1 carrier attempt 1 - Fintype deriving and contradiction closure

Target: `lake -Kjobs=1 build SR_Carrier`

Result: mathlib import chain completed, then `SR_Carrier.lean` failed.

Raw error excerpt:

```text
error: SR_Carrier.lean:21:30: No deriving handlers have been implemented for class `Fintype`
error: SR_Carrier.lean:52:33: failed to synthesize
  Fintype (PrimeIndex6 × PrimeIndex6)
error: SR_Carrier.lean:55:38: unsolved goals
hval : PrimeIndex6.p2 = PrimeIndex6.p3 ∧ PrimeIndex6.p3 = PrimeIndex6.p2
⊢ False
```

Resolution: define the `Fintype PrimeIndex6` instance explicitly and close `q23_ne_q32` by eliminating the impossible constructor equality.

## Stage 2

### Attempt 1 - Basis normalization failure

Target: `lake -Kjobs=1 build SR_Multiplication`

Raw error excerpt:

```text
warning: SR_Multiplication.lean:31:14: This simp argument is unused:
  mul_assoc
error: SR_Multiplication.lean:42:47: unsolved goals
⊢ (if PrimeIndex6.p3 = PrimeIndex6.p2 then 1 else 0) =
    Function.update 0 PrimeIndex6.p2 1 PrimeIndex6.p3
error: SR_Multiplication.lean:57:16: unsolved goals
⊢ (if fst = PrimeIndex6.p2 then if snd = PrimeIndex6.p2 then 1 else 0 else 0) =
    if fst = PrimeIndex6.p2 ∧ snd = PrimeIndex6.p2 then 1 else 0
```

Resolution attempt: define `e m` directly using `Pi.single`, and normalize the product proof with finite case splits over both ordered coordinates.

## Stage 1

### Attempt 1 - Tactic syntax failure

Target: `lake build SR_Carrier`

Raw error excerpt:

```text
error: SR_Carrier.lean:66:2: Tactic `decide` proved that the proposition
  False
is false
error: SR_Carrier.lean:66:9: unexpected token 'at'; expected command
```

Resolution attempt: reduce the equality at the separating coordinate by
`simp [q, PrimeIndex6.ofNat?, basisValue]`.

## Stage 2

### Attempt 1 - Notation syntax failure during warning cleanup

Target: `lake build SR_Multiplication`

Raw error excerpt:

```text
error: SR_Multiplication.lean:6:20: unexpected token '_'; expected '=>'
error: SR_Multiplication.lean:14:20: unexpected token 'ℂ'; expected ':=', 'where' or '|'
error: SR_Multiplication.lean:18:18: unexpected token 'ℂ'; expected ')'
```

Resolution attempt: restore the notation binder form accepted by Lean
4.29.1, tolerating the harmless unused-notation-parameter warning.

## Stage 3

### Attempt 1 - Tactic failed after finite split

Target: `lake build SR_Dagger`

Raw error excerpt:

```text
error: SR_Dagger.lean:35:37: `simp` made no progress
warning: SR_Dagger.lean:35:43: This simp argument is unused:
  basisValue
```

Resolution attempt: after splitting the optional label and the finite ordered
coordinate cases, close the diagonal fixed proof by definitional equality.

### Attempt 2 - Classical complex equality blocked `decide`

Target: `lake -Kjobs=1 build SR_Dagger`

Raw error excerpt:

```text
error: SR_Dagger.lean:39:53: Tactic `decide` failed for proposition
  (if ... then 1 else 0) = if ... then 1 else 0
because its `Decidable` instance ... did not reduce to `isTrue` or `isFalse`.
```

Resolution attempt: replace finite `decide` over complex-valued expressions with explicit lemmas:
`star_basisValue` and `basisValue_diagonal_swap`.
## Stage 5 - blocked before first Lean theorem attempt

- Date: 2026-09-05
- Classification: TYPE ERROR / theorem statement not typeable under current verified API
- Raw displayed target:
  `¬ ∃ (d : E10_6 →ₗ[ℂ] E20_6), ∀ x y : E10_6, d (x * y) = d x * y + x * d y`
- Failure invariant extracted:
  - The verified Stage 2 multiplication is external and bilinear:
    `SR_mul : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6`.
  - There is no internal `Mul E10`, no multiplication accepting `d (x * y)`,
    and no left/right action making `d x * y` or `x * d y` meaningful.
  - Adding such operations would risk violating the frozen ban on treating the
    Rees wall as an internal dg differential.
- Next safe move:
  - Define `ReesCone` as a separate two-term object.
  - Reformulate the no-Leibniz theorem as a negation of the existence of an
    explicitly supplied additional algebra/differential package, rather than
    asserting an untyped formula.

## Stage 7 - syntax failure 1

- Date: 2026-09-05
- Classification: SYNTAX ERROR
- Target: `SR_Underdetermination.lean`
- Raw error excerpt:
  - `SR_Underdetermination.lean:33:41: unexpected token 'λ'; expected '_' or identifier`
  - `SR_Underdetermination.lean:42:35: unexpected token 'λ'; expected '_' or identifier`
  - `SR_Underdetermination.lean:61:7: unexpected token 'λ'; expected '(', '[', '_', '{', '⦃' or identifier`
- Correction:
  - Rename the binder/parameter from the Greek symbol `λ` to the ASCII identifier `lam`.

## Stage 7 - type/API failure 2

- Date: 2026-09-05
- Classification: MISSING MATHLIB OBJECT / API name
- Target: `SR_Underdetermination.lean`
- Raw error excerpt:
  - `SR_Underdetermination.lean:50:23: Unknown constant LinearMap.toFun`
- Correction:
  - Avoid naming the projection.  Use `congrArg (fun f => f q22_X52) h`
    to evaluate equality of linear maps at the generator.

## Stage 4 - antisymmetric embedding tactic failure 1

- Date: 2026-09-05
- Classification: TACTIC FAILED
- Target: `SR_NoCommutativity.lean`
- Raw error excerpt:
  - Unsolved additive coordinate goals such as
    `-y AntisymIndex6.p23 + -x AntisymIndex6.p23 = -x AntisymIndex6.p23 + -y AntisymIndex6.p23`
- Failure invariant:
  - Pointwise simplification unfolds the embedding correctly, but negative
    coordinate additivity requires commutativity/normalization of addition.
- Correction:
  - Use `ring` after the coordinate split for the linearity goals.

## Stage 4 - antisymmetric embedding tactic failure 2

- Date: 2026-09-05
- Classification: TACTIC FAILED
- Target: `SR_NoCommutativity.lean`
- Raw error excerpt:
  - `ring` left goals containing unapplied function-space operations such as
    `((fun current => ...) + fun current => ...) (PrimeIndex6.p2, PrimeIndex6.p2)`.
- Failure invariant:
  - The coordinate split is correct, but the proof must unfold pointwise
    function addition/scalar multiplication before algebraic normalization.
- Correction:
  - Use `simp [Pi.add_apply]` and `simp [Pi.smul_apply]` after the coordinate
    split, with `ring_nf` as fallback normalization.

## Stage 3 - E11 wrapper repair 1

- Date: 2026-09-05
- Classification: TACTIC FAILED
- Target: `SR_Dagger.lean`
- Raw error excerpt:
  - Goals remained in `dagger_h_swap` and `dagger_diagonal_fixed` after making
    `E11` a `ULift` wrapper, e.g.
    `E11.coeff { down := fun current => 0 } (right, left) = 0`.
- Failure invariant:
  - The type separation is correct; old proofs simply need to unfold
    `E11.coeff` after `h` produces a wrapped function.
- Correction:
  - Add `E11.coeff` to the simplification set in the affected basis proofs.

## Stage 6 - E11 wrapper repair 1

- Date: 2026-09-05
- Classification: TACTIC FAILED
- Target: `SR_GNS.lean`
- Raw error excerpt:
  - `E11.coeff { down := fun current => if current = (PrimeIndex6.p2, PrimeIndex6.p2) then 1 else 0 } (PrimeIndex6.p2, PrimeIndex6.p2) = 1`
- Failure invariant:
  - After `E11` became a wrapper, basis-coordinate proofs must unfold
    `E11.coeff`.
- Correction:
  - Add `E11.coeff` to the simplification set of `Gamma_obs_h22`.

## Gap 1 - GNS positivity proof failure 1

- Date: 2026-09-05
- Classification: TACTIC FAILED
- Target: `SR_GNS.lean`
- Raw error excerpt:
  - `rewrite` did not find `(starRingEnd ℂ) ?z * ?z` inside
    `(star (...) * ...).re = Complex.normSq (...)`.
- Failure invariant:
  - The internal `E11_mul` definition is type-correct and local to `E11`.
    The obstruction is only rewriting `star z * z` through
    `Complex.normSq_eq_conj_mul_self`.
- Correction:
  - Unfold the observed coefficient first, introduce `z`, and change the goal
    to `0 ≤ (Complex.conj z * z).re`; then rewrite through
    `Complex.normSq_eq_conj_mul_self`.

## Gap 1 - GNS positivity proof failure 2

- Date: 2026-09-05
- Classification: MISSING MATHLIB OBJECT / API name
- Target: `SR_GNS.lean`
- Raw error excerpt:
  - `Unknown constant Complex.conj`
- Failure invariant:
  - This mathlib surface exposes conjugation through `star`, while some complex
    lemmas print internally with `conj`.
- Correction:
  - State the local positivity goal with `star z * z` and prove its real part
    is `Complex.normSq z` by `Complex.normSq_apply`.

## Gap 2 - requested non-extension theorem refuted by raw bridge

- Date: 2026-09-05
- Classification: TYPE/MATHEMATICAL OBSTRUCTION
- Target displayed in audit:
  `¬ ∃ (f : E20_6 →ₗ[ℂ] ℂ), ∀ x : E11, f (embed_E11_E20 x) = Gamma_obs x`
- Lean-verified counterexample:
  - `embed_E11_E20 : E11 →ₗ[ℂ] E20_6` is definable by forgetting the current
    `ULift` wrapper: `x ↦ x.down`.
  - `Gamma_obs_E20_extension : E20_6 →ₗ[ℂ] ℂ` is definable by evaluating the
    `(2,2)` coordinate.
  - `GNS_raw_extension_exists : ∃ f : E20_6 →ₗ[ℂ] ℂ, ∀ x : E11, f (embed_E11_E20 x) = Gamma_obs x`
    compiles.
- Failure invariant:
  - The current `ULift` separation prevents accidental definitional equality
    between `E11` and `E20_6`, but it does not prevent an explicit linear
    coefficient-forgetting embedding.
  - Therefore the displayed theorem is false unless it includes additional
    compatibility hypotheses that rule out the raw coordinate extension.
- Required next definition:
  - A non-raw consistency predicate describing the dagger/provenance/GNS
    compatibility intended to obstruct extension from `E11` to `E20_6`.

## Gap 3 - exact Rees Leibniz statement is not typeable

- Date: 2026-09-05
- Classification: TYPE ERROR / theorem statement not typeable under current verified API
- Non-imported probe file:
  `archive/gap3_exact_typecheck_2026-09-05/SR_Rees_Gap3_Attempt.lean`
- Target displayed in audit:
  `¬ ∃ (d : E10 →ₗ[ℂ] E20_6), ∀ x y : E10, d (SR_mul x y) = SR_mul (d x) y + SR_mul x (d y)`
- Raw Lean error:

```text
archive\gap3_exact_typecheck_2026-09-05\SR_Rees_Gap3_Attempt.lean:15:10: error: Application type mismatch: The argument
  (SR_mul x) y
has type
  E20_6
but is expected to have type
  E10
in the application
  d ((SR_mul x) y)
archive\gap3_exact_typecheck_2026-09-05\SR_Rees_Gap3_Attempt.lean:15:32: error: Application type mismatch: The argument
  d x
has type
  E20_6
but is expected to have type
  E10
in the application
  SR_mul (d x)
archive\gap3_exact_typecheck_2026-09-05\SR_Rees_Gap3_Attempt.lean:15:51: error: Application type mismatch: The argument
  d y
has type
  E20_6
but is expected to have type
  E10
in the application
  (SR_mul x) (d y)
```

- Failure invariant:
  - `SR_mul x y : E20_6`, so `d (SR_mul x y)` is invalid when
    `d : E10 →ₗ[ℂ] E20_6`.
  - `d x : E20_6`, so `SR_mul (d x) y` is invalid because `SR_mul` expects
    an `E10` argument.
  - `d y : E20_6`, so `SR_mul x (d y)` is invalid for the same reason.
  - A typeable Leibniz theorem would require extra internal multiplication,
    actions, or a second differential on `E20_6`, which is precisely the
    structure the frozen Rees rule says not to install silently.

## Gap 4 - enriched dagger compatibility collapses the ℂ-family

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / requested theorem false
- Requested target:
  Re-prove `orientation_moduli_X52` with stronger constraints including
  full dagger compatibility
  `f (dagger_20 x) = Complex.conj (f x)` and Rees-grade interior vanishing.
- Lean-verified collapse:
  - `orientationFunctional_enriched_iff_real :
      ∀ lam : ℂ,
        satisfies_enriched_frozen_constraints (orientationFunctional lam) ↔
          star lam = lam`
  - `orientationFunctional_not_enriched_I :
      ¬ satisfies_enriched_frozen_constraints (orientationFunctional Complex.I)`
- Failure invariant:
  - On the one-dimensional complex-linear carrier, the old family has
    `orientationFunctional lam z = z * lam`.
  - Full dagger compatibility forces
    `orientationFunctional lam (star z) = star (orientationFunctional lam z)`.
  - Taking `z = 1` forces `lam = star lam`.
  - Therefore non-real complex parameters, including `Complex.I`, are excluded.
- Consequence:
  - The original Stage 7 `ℂ`-family survives the Rees-grade vanishing
    condition, but it does not survive full dagger compatibility.
  - A complex moduli theorem under enriched constraints would need a different
    dagger-compatibility statement, a real-linear target, or an explicit
    explanation that the moduli are real/conjugation-fixed rather than all of
    `ℂ`.

## Stage 9A - literal all-Nat valuation is inconsistent

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / stated structure has no models
- Literal requested structure:
  `val : Nat → Real`,
  `val 1 = 0`,
  `∀ m n, val (m*n) = val m + val n`,
  and `0 < val p` for every `Nat.Prime p`.
- Lean-verified no-go:
  - `no_arithmeticValuation_nat : ¬ ∃ _v : ArithmeticValuation, True`
- First failed equation:
  - Taking `m = 0`, `n = 2` in the additivity law gives
    `val 0 = val 0 + val 2`.
  - Hence `val 2 = 0`.
  - But `Nat.prime_two` and `pos` require `0 < val 2`.
- Consequence:
  - The requested theorem `valuation_is_log_multiple` is Lean-proved only
    vacuously for the literal `ArithmeticValuation`, because the structure is
    empty.
  - The usable Stage 9 valuation surface must exclude zero; the project now
    records this as `PositiveArithmeticValuation` over `PosNat`.

## Stage 10 - absolute PD nondegeneracy is false

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / requested theorem false
- Requested target:
  - Prove relative Poincaré duality and, if possible, prove the radical of
    the `E10` pairing is trivial.
- Lean-verified no-go:
  - `PD_radical_nontrivial_X6 :
      ∃ x : E10, x ≠ 0 ∧ PD_radical x`
  - `PD_not_nondegenerate_X6 :
      ¬ (∀ x : E10, x ≠ 0 → ∃ y : E10, PD_pairing x y ≠ 0)`
- First failed equation:
  - The Stage 10 pairing factors through one scalar:
    `PD_pairing x y = Complex.re (E10_logWeightSum x * E10_logWeightSum y)`.
  - The vector `log(3)e₂ - log(2)e₃` satisfies
    `E10_logWeightSum PD_radical_witness = 0`.
  - Therefore it pairs to zero with every `y : E10`.
- Failure invariant:
  - A pairing formed as a product of one linear functional on a
    four-dimensional carrier is rank-one, so absolute nondegeneracy on `E10`
    cannot hold.
- Consequence:
  - Stage 10 must be relative: quotient by
    `LinearMap.ker E10_logWeightSumLinear`.

## Stage 10 - basis simplification repair

- Date: 2026-09-05
- Classification: LEAN REDUCTION / syntax-term elaboration repair
- Raw error excerpt:
  - `rw [e_eq_basisFun_toNat i]` failed to rewrite
    `E10_logWeightSum (e i.toNat)` because the target exposed
    `SupportIndex6.toNat` while the existing theorem was stated over
    `PrimeIndex6.toNat`.
- Repair:
  - Inserted an explicit `change` to the `PrimeIndex6.toNat` form, then used
    `rw [e_eq_basisFun_toNat i]`.
- Consequence:
  - `E10_logWeightSum_basis` now compiles.

## Stage 11 - R2 full E20 pairing remains degenerate

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / candidate carrier does not fix
  rank-one defect
- Requested test:
  - Try the full `E20_6` pairing
    `Full_pairing(q_mn, q_pq) = J(q_mn) * J(q_pq)`.
- Lean-verified no-go:
  - `Full_pairing_radical_nontrivial_X6 :
      ∃ x : E20_6, x ≠ 0 ∧ Full_pairing_radical x`
- First failed equation:
  - The full pairing still factors through a single scalar
    `E20_logWeightSum`.
  - The witness supported on `(2,2)` and `(2,3)` has zero
    `E20_logWeightSum`, hence pairs to zero with all of `E20_6`.
- Consequence:
  - Moving from `E10` to naive full `E20_6` without new structure does not
    create a nondegenerate Hodge form.

## Stage 11 - R3 singleton GNS Weil analog remains degenerate

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / current observable too small
- Requested test:
  - Try the Weil pairing analog
    `Re(Gamma_obs(dagger(e_m_as_E11) * e_n_as_E11))`.
- Lean-verified facts:
  - `W_pairing_e2_e2 : W_pairing (e 2) (e 2) = 1`
  - `W_pairing_radical_nontrivial_X6 :
      ∃ x : E10, x ≠ 0 ∧ W_pairing_radical x`
- First failed equation:
  - The current `Gamma_obs` reads only the `(2,2)` mixed coefficient.
  - Under the diagonal embedding `E10_to_E11_diag`, the class `e 3` has zero
    observed `(2,2)` coefficient, so it pairs to zero against all `y : E10`.
- Consequence:
  - The present singleton GNS observable is insufficient for a nondegenerate
    Weil/Hodge form on full `E10`.
  - A full-support GNS observable, a real form, or a Hermitian pairing must be
    added before promoting a global Hodge-Riemann theorem.

## Stage 11 - complex-bilinear PD form has wrong sign

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / sign conflict
- Requested target:
  - Prove Hodge-Riemann semidefiniteness/positivity for the Stage 10
    `PD_pairing`.
- Lean-verified no-go:
  - `HR_phase_witness_PD_negative :
      PD_pairing HR_phase_witness HR_phase_witness < 0`
  - `not_PD_positive_semidefinite :
      ¬ (∀ x : E10, 0 ≤ PD_pairing x x)`
  - `stage11_sign_conflict`
- First failed equation:
  - For `HR_phase_witness = i·e₂`,
    `E10_logWeightSum HR_phase_witness = Complex.I * Real.log 2`.
  - Therefore
    `PD_pairing HR_phase_witness HR_phase_witness =
      Complex.re ((i log 2) * (i log 2)) = -(log 2)^2 < 0`.
- Failure invariant:
  - The current `PD_pairing` is complex-bilinear in effect; it does not insert
    complex conjugation in the second argument.
  - A Hodge-Riemann-positive form on complex `E10` must use a Hermitian/GNS
    style conjugation or restrict to a real form.
- Consequence:
  - `PD_pairing` is not the final signed Hodge form for the desired
    `I_SR(Z₀,Z₀) ≤ 0` target.

## Stage 12 - naive Weil operator gives zero HR real part

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / classical Weil operator does not
  supply positivity
- Requested test:
  - Define `C_Weil(e_m) = Complex.I • e_m` and evaluate
    `Complex.re (H_SR (e_m) (C_Weil (e_m)))`.
- Lean-verified result:
  - `HR_Weil_zero :
      ∀ m : SupportIndex6,
        Complex.re (H_SR (e m.toNat) (C_Weil (e m.toNat))) = 0`
- First failed equation:
  - `H_SR(e_m, i e_m) = log(m) * star (i * log(m))`.
  - Since `log(m)` is real, this is a pure imaginary scalar multiple of
    `log(m)^2`.
  - Its real part is `0`.
- Consequence:
  - The Hermitian form repairs semidefinite positivity, but the naive
    classical Weil operator is not the SR Hodge-Riemann operator.
  - Stage 13 must define the correct signed `I_SR` bridge or an SR-specific
    Weil action.

## Stage 13 - current GNS/E11 I_SR has wrong physical sign

- Date: 2026-09-05
- Classification: MATHEMATICAL OBSTRUCTION / singleton GNS observable gives
  positive radical value
- Requested test:
  - Define `I_SR x y = Gamma_obs (dagger (embed_E10_E11 x) * embed_E10_E11 y)`.
  - Test the Stage 10 radical witness
    `PD_radical_witness = log(3)e₂ - log(2)e₃`.
- Lean-verified result:
  - `I_SR_eq_observed_coordinate :
      ∀ x y : E10,
        I_SR x y = star (x PrimeIndex6.p2) * y PrimeIndex6.p2`
  - `I_SR_radical_witness_pos :
      0 < Complex.re (I_SR PD_radical_witness PD_radical_witness)`
  - `not_I_SR_nonpos_on_PD_radical :
      ¬ ∀ x : E10, PD_radical x → Complex.re (I_SR x x) ≤ 0`
- First failed equation:
  - The current GNS observable sees only the `(2,2)` coordinate.
  - The radical witness has `e₂` coordinate `log(3)`.
  - Therefore the current `I_SR` evaluates the witness to
    `conj(log 3) * log 3`, whose real part is `(log 3)^2 > 0`.
- Consequence:
  - Outcome 3 applies for the current finite `I_SR` construction.
  - The desired physical sign `I_SR(Z₀,Z₀) ≤ 0` requires an additional
    signed intersection datum, a different physical primitive sector, or a
    different/full-support SR observable.

## Stage 14 - Rees witness sign proved, general sign still open

- Date: 2026-09-05
- Classification: PARTIAL SUCCESS / full primitive-sector theorem not yet
  proved
- Lean-verified witness result:
  - `I_SR_Rees_radical_negative :
      I_SR_Rees PD_radical_witness PD_radical_witness < 0`
  - `radical_witness_is_primitive :
      PD_radical_witness ∈ P_SR_phys`
- Lean-verified GNS fork:
  - `E11_mul_h22_h33_observed_zero :
      hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0`
  - The literal combined `Gamma_obs (E11_mul (h 2 2) (h 3 3)) = 0`
    statement was not promoted; see the elaboration obstruction below.
- Remaining failed/unpromoted target:
  - `partial_sign_theorem :
      ∀ x ∈ P_SR_phys, I_SR_Rees x x ≤ 0`
- Reason not promoted:
  - The current stage verifies one primitive witness, not the full quadratic
    inequality on the entire kernel.
  - The sign assignment `Interior ↦ -1`, `Exit ↦ +1` is verified compatible
    with the Rees grade but remains externally motivated, not forced by
    previous SR axioms.
- Consequence:
  - Stage 14 gives first witness-level sign content.
  - A full Hodge-Riemann theorem requires either the general kernel
    inequality or a sharper physical primitive sector.

## Stage 14A repair failure - SR_GNS theorem constant used as type

Date: 2026-09-06

Command:
`lake -Kjobs=1 build SR_GNS`

Raw error:
```text
error: SR_GNS.lean:33:4: type expected, got
  (E11_mul_hIdxD_p2p2_p3p3_coeff_p2p2_zero : hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0)
error: SR_GNS.lean:120:7: Unknown identifier `E11_mul_hIdx_p2p2_p3p3_coeff_p2p2_zero`
```

Correction:
Restated `E11_mul_hIdx_p2p2_p3p3_coeff_p2p2_zero` with proposition
`hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0` and proved it by exact from the
lower-level `SR_Dagger` theorem.

## Stage 14A elaboration obstruction - combined Gamma_obs/E11_mul statement

Date: 2026-09-06

Observed during repeated commands:
`lake -Kjobs=1 build SR_ISR_Full`, `lake -Kjobs=1 build SR_GNS`, and `lake -Kjobs=1 build SR_Dagger`.

Problematic target shape:
```lean
theorem E11_mul_h22_h33_observed_zero :
    Gamma_obs (E11_mul (h6 PrimeIndex6.p2 PrimeIndex6.p2)
      (h6 PrimeIndex6.p3 PrimeIndex6.p3)) = 0 := by
  rfl
```

Evidence:
- Definitions-only `SR_ISR_Full.lean` with a temporary `#exit` after `I_SR_full` built successfully.
- The build stalled once the combined off-diagonal `Gamma_obs (E11_mul ...)` proposition was introduced.
- Replacing the proof body with `rfl` did not remove the stall, so the obstruction was statement elaboration/reduction rather than tactic search.
- A lower-level named coefficient-value witness was introduced and verified instead:
  `hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0`.

Resolution used:
- `SR_Dagger.lean` defines `hIdxDProductCoeff_p2p2_p3p3_at_p2p2` as the relevant basis-coefficient product and proves it is zero.
- `SR_GNS.lean` and `SR_ISR_Full.lean` cite this compiled coefficient witness.
- The literal combined `Gamma_obs (E11_mul ...) = 0` theorem remains unpromoted until a lighter E11/Gamma API is available.

## Stage 15 failure log

Date: 2026-09-06

### Failure 15.1 — missing Lake target

Command:

```text
lake -Kjobs=1 build SR_Signature
```

Raw error:

```text
error: unknown target `SR_Signature`
```

Resolution:

- Added `lean_lib SR_Signature where roots := #[`SR_Signature]` to
  `lakefile.lean`.

### Failure 15.2 — existential chooser selected the wrong witness

Problematic proof:

```lean
theorem radical_witness_in_true_phys :
    P_SR_phys_true PD_radical_witness := by
  exact (P_SR_phys_true_nonempty.choose_spec).1
```

Raw error:

```text
Type mismatch
  (Exists.choose_spec P_SR_phys_true_nonempty).left
has type
  P_SR_phys_true P_SR_phys_true_nonempty.choose
but is expected to have type
  P_SR_phys_true PD_radical_witness
```

Resolution:

- Proved the claim directly using `radical_witness_is_primitive` and
  `le_of_lt I_SR_Rees_radical_negative`.

### Stage 15 unpromoted target — exact rank/inertia

The objective requests the full signature of `M_Rees`.  The paper calculation
gives expected inertia `(1,1,2)`.  The current Lean promotion stops at:

```lean
I_SR_Rees_formula
M_Rees_signature_witnesses
```

That is enough to verify the clean quadratic formula and mixed-sign behavior,
but it is not yet a formal `Matrix.rank`/inertia theorem.  This remains a
finite matrix-rank API/formalization task.
## Stage 15 — repaired finite-sum/mulVec expansion failure

Date: 2026-09-06

Command:

```text
lake -Kjobs=1 build SR_Signature
```

Failure class: tactic / definitional expansion failure.

Raw obstruction:

```text
error: SR_Signature.lean:52:2: 'change' tactic failed
```

The failed attempt tried to rewrite `(M_Rees.mulVec x) i` directly into an explicit four-term coordinate expression using `change`. Lean did not treat the matrix-vector finite sum as definitionally equal to that handwritten expansion.

Follow-up repair:

Defined `sum_univ_support6_real` to expand the finite `SupportIndex6` sum explicitly, then proved the `M_Rees.mulVec` coordinate lemmas by:

```lean
rw [Matrix.mulVec, dotProduct, sum_univ_support6_real]
simp [M_Rees, Rees_sign6, E10R_sum]
```

with `ring` where associativity/normalization was needed. The repaired target `SR_Signature` compiled, and the real matrix kernel criterion was promoted to `SR_KnowledgeBank.lean`.

## Stage 15 — kernel equivalence and rank repair attempts

Date: 2026-09-06

Command:

```text
lake -Kjobs=1 build SR_Signature
```

Failure class: tactic/term-shape failures while proving the real kernel
linear equivalence.

First raw obstruction:

```text
error: SR_Signature.lean:218:8: No goals to be solved
```

Cause:

- In the `invFun` membership proof for `M_Rees_realKernelEquiv`,
  `simp [E10R_sum]` already closed the target.  The following `ring` tactic
  had no remaining goal.
- The same attempt also tried `ext i` on a product target in `right_inv`,
  which was the wrong extensionality shape.

Second raw obstruction:

```text
error: SR_Signature.lean:224:12: type mismatch
```

Cause:

- The kernel hypothesis supplied `hx.2 : x PrimeIndex6.p2 = 0`, while the
  `p2` coordinate goal after extensionality was oriented as
  `0 = x PrimeIndex6.p2`.

Resolution:

- Removed the redundant `ring` after `simp [E10R_sum]`.
- Proved product right inverse with `ext <;> rfl`.
- Used `hx.2.symm` for the oriented `p2` coordinate.

Outcome:

```lean
M_Rees_realKernelEquiv :
  (LinearMap.ker M_Rees.mulVecLin) ≃ₗ[ℝ] (ℝ × ℝ)

M_Rees_real_kernel_finrank :
  Module.finrank ℝ (LinearMap.ker M_Rees.mulVecLin) = 2

E10R_finrank :
  Module.finrank ℝ E10R = 4

M_Rees_rank :
  Matrix.rank M_Rees = 2
```

These now compile in `SR_Signature.lean` and are promoted to
`SR_KnowledgeBank.lean`.

## Stage 15 — signature-coordinate repair attempts

Date: 2026-09-06

Command:

```text
lake -Kjobs=1 build SR_Signature
```

Failure class: coordinate-order and tactic-normalization failures while
upgrading rank/nullity to an explicit `(1,1,2)` signature certificate.

First raw obstruction:

```text
error: SR_Signature.lean:274:6: Tactic `rfl` failed
error: SR_Signature.lean:277:4: unsolved goals
error: SR_Signature.lean:295:2: Tactic `rfl` failed
```

Cause:

- The first `M_Rees_signatureCoord` attempt encoded the forward map as
  `(sum,p2,p3,p4)` while the inverse treated the first coordinate as `p2`
  and the fourth coordinate as `sum`.
- The inverse quadratic theorem used `rfl` for an expression requiring
  simplification of `E10R_sum`.

Second raw obstruction after over-cleaning linter warnings:

```text
error: SR_Signature.lean:280:18: unsolved goals
error: SR_Signature.lean:282:19: unsolved goals
error: SR_Signature.lean:277:4: unsolved goals
warning: SR_Signature.lean:294:32: declaration uses `sorry`
```

Cause:

- Removing all `ring` normalization left additive associativity/commutativity
  goals open in the linear equivalence fields.  Lean reported the affected
  declarations as using placeholders because the structure fields were not
  completed.

Resolution:

- Changed the coordinate order to `(p2,p3,p4,total sum)`.
- Proved the inverse quadratic theorem by
  `simp [M_Rees_quadR, E10R_sum, M_Rees_signatureCoord]`.
- Used explicit branch proofs plus `ring_nf` only on the additive
  normalization branches that require it.

Outcome:

```lean
M_Rees_quadR
M_Rees_signatureCoord
M_Rees_signatureCoord_quad
M_Rees_signatureCoord_inv_quad
M_Rees_signature
```

The final theorem `M_Rees_signature` compiles and certifies
`pos=1`, `neg=1`, `zero=2` together with `Matrix.rank M_Rees = 2` and
kernel finrank `2`.

## Stage 16 — arithmetic-flow repair attempts

Date: 2026-09-06

Command:

```text
lake -Kjobs=1 build SR_Flow
```

Failure class: performance and import/proof-shape failures while constructing
the first Stage 16 module.

Observed blockers:

- Importing `SR_Signature` pulled the full Stage 15 dependency chain into the
  new target.  This caused long replay segments before any Stage 16 line was
  checked.
- A generic `Matrix`-typed `M_Rees_X` plus finite `native_decide` counting
  caused expensive elaboration without useful line-local feedback.
- Importing `Mathlib.Analysis.SpecialFunctions.Log.Basic` for the planned
  logarithmic sum was unnecessary for the first compiling flow certificate and
  added heavy replay cost.
- With only `SR_Primitives`, Lean did not know the `ℚ` notation/Rat numeric
  instances/tactic stack needed by the draft:

```text
failed to synthesize instance of type class OfNat ℚ 5
unknown tactic
failed to synthesize Decidable ¬SR_flow_fixed_point_proxy ...
```

Resolution:

- Preserved the initial `SR_Flow.lean` draft as historical work, later archived
  as `SR_Flow_draft_20260906.lean`.
- Added the compiling Stage 16 module and moved it into `SR_Flow.lean` once the
  draft was archived.
- Routed the `SR_Flow` lake target to `SR_Flow`.
- Replaced the full matrix import with a lightweight binary `ReesSignKernel`.
- Used `Mathlib.Data.Rat.Defs` for Rat support.
- Replaced expensive `native_decide`/generic finite enumeration with explicit
  finite certificate theorems and open checkpoints for the analytic bridge.

Outcome:

```text
lake -Kjobs=1 build SR_Flow
Build completed successfully
```

### Stage 17 finite eigenvector sum expansion — 2026-09-07

- Initial proof attempt for the three `X=7` eigenvector equations used:

```lean
norm_num [Matrix.mulVec, dotProduct, M_Rees_X7_counterexample,
  M_Rees_general, BalanceSupport7, vX7_neg]
```

- Lean left unsolved finite sums over `Fin 3`, e.g.

```text
⊢ (∑ x,
      if 2 * ↑(match x with | ⟨0, _⟩ => 2 | ⟨1, _⟩ => 3 | ⟨2, _⟩ => 5) < 7
      then -match x with | ⟨0, _⟩ => 2 | ⟨1, _⟩ => 1 | ⟨2, _⟩ => -1
      else  match x with | ⟨0, _⟩ => 2 | ⟨1, _⟩ => 1 | ⟨2, _⟩ => -1) = -4
```

- Resolution: expose the finite sum with `Fin.sum_univ_three`, then
  `norm_num` closes all three eigenvector equations.

Outcome:

```text
lake -Kjobs=1 build SR_Balance
Build completed successfully
```

### Stage 16 enriched synthesis type/term correction — 2026-09-07

- Attempted to state the final synthesis package with theorem names in
  proposition position:

```lean
SR_dBN_conjecture_statement ∧ SR16_FIXED_POINT_OPEN
```

- Lean rejected this because `SR_dBN_conjecture_statement` and
  `SR16_FIXED_POINT_OPEN` are proof terms of type `True`, not proposition
  types:

```text
Application type mismatch: The argument
  SR_dBN_conjecture_statement
has type
  True
of sort `Prop` but is expected to have type
  Prop
of sort `Type` in the application
  And SR_dBN_conjecture_statement
```

- Resolution: the enriched synthesis theorem now states the final two
  placeholders as `True ∧ True` and uses the theorem names as witnesses.

Outcome:

```text
lake -Kjobs=1 build SR_Flow
Build completed successfully
```

### Stage 16 finite package repair — 2026-09-07

Command:

```text
lake -Kjobs=1 build SR_Flow
```

Failure:

```text
error: SR_Flow.lean:532:2: Application type mismatch: The argument
  X30_signature_reduction_certificate
has type
  X30SignatureReductionEvidence
of sort `Prop` but is expected to have type
  Prop
of sort `Type` in the application
  And X30_signature_reduction_certificate

error: SR_Flow.lean:533:2: Application type mismatch: The argument
  SR_flow_entry_update_minus_two FlowX52 6 FlowSupport52 FlowSupport52.toNat FlowSupport52.p2 FlowSupport52.p2
    grade_22_X52_exit grade_22_X6_interior
has type
  M_Rees_X 6 FlowSupport52 FlowSupport52.toNat FlowSupport52.p2 FlowSupport52.p2 =
    M_Rees_X FlowX52 FlowSupport52 FlowSupport52.toNat FlowSupport52.p2 FlowSupport52.p2 - 2
of sort `Prop` but is expected to have type
  Prop
of sort `Type` in the application
  And ⋯
```

Resolution:

- Added the named proposition `X30SignatureReductionEvidence`.
- Rewrote the finite package to include proposition statements rather than
  theorem proof terms.
- Moved the required flow-update and fixed-point names into scope before the
  package by adding verified earlier declarations and retaining the later text
  as archived copies with renamed identifiers.
- Verified with `lake -Kjobs=1 build SR_Flow` and `lake -Kjobs=1 build`.

### Stage 16C whole-kernel rank-update performance stall — 2026-09-07

Attempted declarations:

```text
SR_flow_rank1_kernel
SR_flow_rank1_update
SR_flow_rank1_update_22_X52_to_X6
```

Intended theorem shape:

```text
∀ i j : α,
  M_Rees_X X' α toNat i j =
    M_Rees_X X α toNat i j - 2 * SR_flow_rank1_kernel α m n i j
```

with hypotheses that `(m,n)` crosses from `Exit` to `Interior` and every
other entry is stable.

Observed behavior:

- `lake -Kjobs=1 build SR_Flow` repeatedly exceeded capped 30 second
  segments with no Lean diagnostics after replaying `SR_Primitives`.
- Direct `lean.exe SR_Flow.lean` with the Lake `LEAN_PATH` also exceeded
  capped segments without diagnostics.
- Process inspection showed either a low-CPU Lake wrapper with no Lean child,
  or a low-CPU Lean child with slowly growing memory.

Non-weakening proof refactors tried:

- Reused the already verified `SR_flow_entry_update_minus_two` theorem in the
  crossing-entry branch.
- Replaced conjunction equality `(i = m ∧ j = n)` by pair equality
  `(i,j) = (m,n)` in the rank-one kernel.
- Replaced generic `ring` cleanup by `norm_num`.

Failure invariant:

- The whole-kernel theorem shape over polymorphic `Matrix α α ℝ` / function
  kernels appears to trigger unacceptable elaboration or process-level
  stalling on this Windows/Lake setup before producing actionable diagnostics.
- The last verified compiling state remains the scalar entry update plus the
  finite package repair; the whole-kernel rank-update attempt is not yet
  promoted.

Follow-up concrete attempt:

```text
SR_flow_rank1_kernel_X52
SR_flow_rank1_update_X52_whole_kernel
```

This specialized the rank-one update to the one-point support at `X=5/2`.
It still caused `lake -Kjobs=1 build SR_Flow` to exceed repeated capped
segments after replaying `SR_Primitives`.  The attempt was therefore not
promoted.  Stage 16C remains represented by the verified scalar entry theorem
`SR_flow_entry_update_minus_two`.

### Stage 16F finite-chain fixed-point package performance stall — 2026-09-07

Attempted declarations:

```text
FlowCutoff3
FlowCutoff3.signature
FlowCutoff3.adjacent
computed_flow_adjacent_not_fixed
```

Intended theorem shape:

```text
∀ a b : FlowCutoff3,
  FlowCutoff3.adjacent a b →
    ¬ SR_flow_fixed_point_proxy a.signature b.signature
```

Observed behavior:

- A first proof using `cases` plus broad `simp` caused `lake -Kjobs=1 build
  SR_Flow` to exceed capped segments, with Lean memory rising sharply.
- A second proof using explicit manual cases and no broad simplifier still
  caused Lean memory to rise to roughly 1.3 GB before any diagnostic.

Failure invariant:

- Even small dependent wrappers around `SR_flow_fixed_point_proxy` can trigger
  expensive elaboration in the current `SR_Flow.lean` environment.
- The two verified finite non-fixed witnesses remain:
  `X52_not_fixed_against_X6` and `X6_not_fixed_against_X30`.

Log-weighted refinement:

- Attempted to define the logarithmic sum directly using `Real.log`.
- Lean correctly rejected the first version:

```text
failed to compile definition, consider marking it as 'noncomputable'
because it depends on 'Real.log'
Tactic `native_decide` failed ... Real.decidableEq is noncomputable
```

- Resolution: marked `logWeightedInteriorSum` as `noncomputable`, added the
  explicit grade lemma `grade_22_X52_exit`, and proved the `X=5/2` log-sum
  value by `simp` rather than native evaluation.

Exact `-2` update refinement:

- Added `SR_flow_entry_update_minus_two`, using the narrow
  `Mathlib.Tactic.NormNum.Basic` import instead of the full `Mathlib.Tactic`
  import.

Outcome:

```text
lake -Kjobs=1 build SR_Flow
Build completed successfully
```

Finite-count refinement:

- Attempted to derive `Fintype` for the finite support inductives.
- Lean reported:

```text
No deriving handlers have been implemented for class `Fintype`
failed to synthesize instance of type class Fintype FlowSupport52
```

- Resolution: replaced the typeclass-based `Finset.univ` count with explicit
  support lists and a list fold.  The finite count theorems now compute:
  `N_int(5/2)=0`, `N_int(6)=1`, and `N_int(30)=17`.

Outcome:

```text
lake -Kjobs=1 build SR_Flow
Build completed successfully
```

Follow-up repair:

- Upgraded `ReesSignKernel` from a raw binary function to `Matrix α α ℝ`.
- The first proof attempt kept the `-2` update statement:

```text
⊢ -1 = 1 - 2
```

- Importing all of `Mathlib.Tactic` only to solve that arithmetic goal pulled a
  very large dependency cone and produced long quiet build slices.
- Resolution: avoid the broad tactic import and prove the crossing data
  directly as `old = +1` and `new = -1`.

Outcome:

```text
lake -Kjobs=1 build SR_Flow
Build completed successfully
```

## Stage 20 repair log (2026-09-08)

- Initial SR_SignatureBound.lean import used broad mathlib tactic/real imports and caused long silent builds. Replaced with import SR_Primitives and an integer/rational certificate layer.
- A malformed PowerShell text replacement introduced literal ` 
 ` strings. Fixed by direct block rewrite before successful compile.
- Attempted to use Finset.Icc and Real after removing heavy imports; Lean reported unknown Finset.Icc, lambda parse fallout, missing 
orm_num, and undecidable transition proof. Resolved by using list support certificates, rational boundary algebra, simp, and explicit finite-list case splitting.
- sub_eq_zero.mp was unavailable under the lightweight import. Resolved by defining the boundary characteristic condition directly as a proposition lam^2 = 2.

## Stage 21 failure log (2026-09-08)

- Parity conjecture failed under Lean evaluation: ∀ s ∈ knownSigs, sigIndex s % 2 = supportParityIndex s is false.
- First extracted obstruction: X=8 has signature (2,1,3), so sigIndex = 1 while (X-2)%2 = 0.
- A direct membership proof sigX8 ∈ knownSigs was not decidable because ReesSig contains the proof field hBound; replaced with a standalone compiled X=8 counterexample record.

Stage 21 repair note: List.bind field notation was unavailable for completeSupport; rewrote allOnesEntrySum as nested List.map ... .sum.


Stage 21 invariant attempt: the conference/constant-Gram candidate fails. For complete-support M_Rees, M*M^T has constant diagonal n but nonconstant off-diagonal entries already at X=6 (off values 2 and 4), X=8 (2,4,6), and many values at X=35/210. Therefore M_Rees is not an a*I+b*J Gram-class matrix under the current sign rule.

Stage 21 syntax/name failure: support-pair count promotion accidentally inserted #check lines for undefined names interiorPairCount_le_supportPairCountRows_X35 and _X210. The general theorem interiorPairCount_le_supportPairCountRows exists; removed the stale finite #check names.

## Stage 21 row-sum bridge failed attempts — 2026-09-08
- First stdin attempt unfolded `completeSupport` directly and failed because `simp` produced a composed `List.map` term where the induction hypothesis was not syntactically visible. Raw obstruction: rewrite/simp left goals of the form `-1 + (List.map ((fun n => if m * n < X then -1 else 1) ∘ fun k => k + 2) t).sum = ...`.
- Second stdin attempt introduced helper definitions but `simp` expanded them before `rw [ih]`, so the rewrite pattern `rowEntrySumOn X m t` no longer occurred. Resolution: simplify both the induction hypothesis and target with the same definitions, then close by `omega`.
- Promotion script failure: exact insertion needle did not match the current file spacing; no Lean state changed. Retried with the actual file anchor.

## Stage 21 global all-ones formula promotion ordering failure — 2026-09-08
- Build failed because `allOnesEntrySum_count_formula_general` and `allOnesEntrySum_square_formula_general` were inserted before `allOnesEntrySum` was defined.
- Exact obstruction: Lean reported `Function expected at allOnesEntrySum` and explained the identifier was unknown under `autoImplicit`; generated check output displayed malformed implicit parameters for `allOnesEntrySum`.
- Fix: moved the global formula theorems below the `allOnesEntrySum` definition while leaving the rectangular helper lemmas above it.

## Stage 21 row-count-to-positive-bias promotion ordering failure — 2026-09-08
- Build failed because `allOnesEntrySum_positive_of_belowHalfSupportCount` was promoted before `allOnesEntrySum_positive_of_interior_bound`, the theorem it invokes.
- Exact obstruction: `Unknown identifier allOnesEntrySum_positive_of_interior_bound` at `SR_SignatureBound.lean:677:8`.
- Fix: kept `interiorPairCount_half_bound_of_belowHalfSupportCount` near the counting lemmas and moved `allOnesEntrySum_positive_of_belowHalfSupportCount` below `allOnesEntrySum_positive_of_interior_bound`.

## Stage 21 below-half count formula failed attempts — 2026-09-08
- Direct `List.range` proof of `belowHalfSupportCount X = (X-1)/2 - 1` did not simplify; `simp [List.countP_eq_length_filter]` made no progress on the mapped executable support.
- Finset interval proof found the arithmetic equivalence but became tangled with the executable list representation of `completeSupport`; the first attempted `ext` proof exposed a residual side goal `m ≤ (X-1)/2 → 2 ≤ m → m ≤ X-1` and namespace mismatch for the interval card simplifier. The arithmetic equivalence was extracted and promoted separately as `two_mul_lt_iff_le_pred_div_two`.

## Stage 21 large native count certificate runtime boundary — 2026-09-08
- Attempted a single `native_decide` theorem combining the closed below-half support formula and all-ones positivity for `X=6..5000`; it remained live past multiple 30s capped polls and was interrupted without promotion.
- Attempted the combined formula-and-positivity theorem for `X=6..1000`; it also remained live past a 30s capped poll and was interrupted.
- Formula-only certificates are much cheaper: `X=6..500` and `X=6..1000` both compiled quickly in stdin. Promoted the `X=6..1000` formula-only certificate.

## Stage 24 Problem 1 spectral bridge representation boundary — 2026-09-08
- Goal: identify the `Fin (X-2)` double sum for `reesMatrixReal X` with `(allOnesEntrySum X : ℝ)`.
- Type/representation obstruction: `allOnesEntrySum` is defined as nested sums over the executable `List` support, while the quadratic form is indexed by `Fin (X-2)`; the missing theorem is a general `Fin`-sum/list-map correspondence together with the `i.val + 2` support-index conversion.
- Resolution: promoted the generic Rayleigh implication with this identification as an explicit hypothesis in `SR_SpectralBridge.lean`; no equality was assumed silently.
- Next approach: prove the finite-index/list correspondence separately before claiming an unconditional spectral bridge.

## Stage 22 Problem 2 interlacing upper-bound invariant — 2026-09-08
- Goal: prove the universal inertia bound `pos ≤ neg + 1` by bordering and Cauchy interlacing.
- Approach: compare a matrix with its principal submatrix after adding one row and column.
- Failure invariant: interlacing yields `pos(M') ≤ pos(M)+1` and `neg(M') ≥ neg(M)`, but when `pos(M)=neg(M)+1` this only gives `pos(M') ≤ neg(M')+2`; it does not prevent accumulation of the excess.
- Resolution: retain `SR22_UPPER_BOUND_OPEN` and the verified finite certificates through X=1000. A structural invariant beyond ordinary interlacing is required for the all-X theorem.
