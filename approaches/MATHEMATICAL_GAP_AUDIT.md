# Mathematical Gap Audit

Audit date: 2026-09-11
Auditor: read-only inspection of all active .lean files and research documents.
RH is open. No claim of proof is made or supported.

---

## Executive verdict

**Buildable:** The project is reported to build (no `sorry` or `admit` found in any active .lean file). All proofs use `decide`, `native_decide`, `norm_num`, `ring`, `linarith`, `simp`, or genuine Lean tactic proofs. There is no `sorry`, `admit`, `axiom`, `opaque`, or `unsafe` in any active source file.

**Gap-free:** No. The project is a finite combinatorial/algebraic study of a particular matrix (the "Rees sign matrix") attached to a cutoff parameter X. It has no proved connection to the Riemann Hypothesis, zeta zeros, L-functions (except definitional imports of Mathlib's zeta/L-series API in SR_Stage36, used only for formal definitions), or any analytic statement. The entire analytic bridge to RH is explicitly recorded as open.

**RH proved:** Emphatically no. The relevant bridge propositions (`W_SR_converges → True`, `SRdBN_conjectural_bridge_limit_open`, `SR_growth_law_conjecture`, `SR_growth_upper_envelope_conjecture`, `SR_growth_coercivity`) are either `True`, definitional propositions with no proof, or explicitly labelled conjectures. None are proved.

**First fatal gap:** The entire analytic-to-RH bridge does not exist. The project produces correct finite combinatorial theorems about matrices indexed by natural numbers below a cutoff X, but there is no proved theorem connecting any of these objects to zeta zeros, the Riemann zeta function, or any classical analytic result bearing on RH. This gap is total, not incremental.

**Hidden workarounds:** Several open propositions are wrapped as `True` or `Prop` definitions that compile trivially. These are honestly named as open checkpoints, not disguised proofs. No `sorry` is used to hide anything.

---

## 1. Fatal / central gaps

### GAP-F1: No proved connection to Riemann zeta or RH

**File:** SR_WEntropy.lean, SR_Flow.lean, SR_Bridge.lean  
**Declaration:** `W_SR_RH_bridge : Prop := W_SR_converges → True`  
**Actual statement:** This is the tautology `P → True`, which is always true and has no mathematical content. It does NOT state that W_SR_converges implies RH. It trivially compiles as `intro _ _; trivial`.  
**Intended statement:** The project intends this to eventually encode: if the W-bias observable converges to zero, then RH holds. This is not proved and is not statable in the current Lean base without a formal connection between the Rees matrix and zeta zeros.  
**Classification:** CONJECTURAL / MISSING  
**Why a gap:** The RH bridge has no Lean formalization. The proposition `W_SR_RH_bridge` literally says "if W_SR_converges then True," which is a tautology, not a bridge.  
**What is needed to close:** A theorem connecting `SR_rees_matrix X` (or its spectral properties) to the zeros of the Riemann zeta function, or a Selberg explicit-formula theorem in Lean.

### GAP-F2: No proved analytic asymptotic for SR_weil_form_real

**File:** SR_Stage29.lean  
**Declarations:**  
- `SR_growth_law_conjecture : Prop`  
- `SR_growth_upper_envelope_conjecture : Prop`  
- `SR_growth_coercivity : Prop`  
**Actual statement:** These are Prop definitions asserting asymptotic bounds on `|SR_weil_form_real X beta gamma|`. They are not proved; they are merely types of propositions.  
**Classification:** CONJECTURAL / MISSING  
**Why a gap:** The project records (Research/Stage29_SolutionMap.md, Research/KilledApproaches.md) that multiple approaches to bounding `Q_X = SR_weil_form_real X beta gamma` asymptotically have been killed. No proved asymptotic theorem exists.  
**What is needed to close:** An Abel summation lemma with an explicit remainder for the finite weighted convolution, plus a cancellation estimate showing the leading `O(X^(2 beta+1))` terms cancel to leave `O(X^(3 beta + epsilon))`.

### GAP-F3: Sign convention for Interior -> -1 not derived from first principles

**File:** SR_Signature.lean  
**Declarations:**  
- `SR15_REDUCTION_AUDIT_OPEN : True := by trivial`  
- `SR15_SIGN_ARITHMETIC_OPEN : True := by trivial`  
**Actual statement:** Both are literally `True`. They are named checkpoints recording that the Selberg/Weil derivation of the sign convention `Interior -> -1, Exit -> +1` is not formalized.  
**Classification:** MISSING  
**Why a gap:** All signature theorems in `SR_Signature.lean` and `SR_Flow.lean` are proved conditional on the sign table `Rees_sign6`, which assigns -1 to the interior product `(2,2)` at X=6. This assignment is not derived from any Selberg explicit formula or Weil correspondence theorem inside Lean. It is externally Hodge-index motivated.  
**What is needed to close:** A formal Lean proof that the Selberg explicit formula or a Weil-type correspondence forces the sign `Interior -> -1`.

### GAP-F4: dBN (de Bruijn-Newman) bridge is explicitly conjectural

**File:** SR_Flow.lean  
**Declaration:** `SRdBNBridgeScaffold` (structure), `SRdBN_conjectural_bridge_limit_open : True`  
**Actual statement:** The bridge scaffold is a structure whose fields are propositions that compile as `trivial`. The limit theorem field `SRdBN_conjectural_bridge_limit_open` is `True`.  
**Classification:** CONJECTURAL / MISSING  
**Why a gap:** The de Bruijn-Newman argument requires showing that as X -> infinity, the signature of the Rees matrix stabilizes or evolves in a way that tracks zeta zeros. This is not proved. The "bridge" is a Lean-visible data structure with no mathematical content.  
**What is needed to close:** A theorem relating the large-X limit of `M_Rees_signature_X` to zero-free regions of the Riemann zeta function.

### GAP-F5: SR_quotient_count is a counting function, not a rank formula for general X

**File:** SR_Stage38.lean  
**Declaration:** `SR_rees_rank_eq_quotient_count (X : Nat) (hX : 6 ≤ X) : (SR_rees_matrix X).rank = SR_quotient_count X`  
**Actual statement:** This IS proved (no sorry). It shows the rank of the (X-2) x (X-2) rational matrix `SR_rees_matrix X` (entries ±1 based on whether `(i+2)*(j+2) < X`) equals the number of distinct floor-division quotients `{(X-1)/m : 2 <= m < X}`.  
**Classification:** PROVED (finite certificate)  
**Mathematical note:** This is a correct theorem about a combinatorial matrix. It does NOT connect to the Riemann Hypothesis or zeta zeros. The "quotient count" is a divisor-function type quantity, not the number of nontrivial zeros of zeta below height T.

---

## 2. Hidden formal holes and workarounds

### H-1: Tautological `True` checkpoints used as open-problem placeholders

These named `theorem`s compile but carry zero mathematical content:

| Declaration | File | Line | Content |
|---|---|---|---|
| `SR15_REDUCTION_AUDIT_OPEN` | SR_Signature.lean | ~562 | `True` |
| `SR15_SIGN_ARITHMETIC_OPEN` | SR_Signature.lean | ~575 | `True` |
| `SR14_SIGN_EXTERNAL_MOTIVATION` | (SR_ISR_Full) | — | `True` |
| `SRdBN_conjectural_bridge_limit_open` | SR_Flow.lean | — | `True` |
| `SR26_PERELMAN_CONJECTURE_RECORD` | SR_WEntropy.lean | ~108 | `W_SR_RH_bridge → W_SR_converges → True` |
| `W_SR_RH_bridge` | SR_WEntropy.lean | ~41 | `W_SR_converges → True` (tautology) |

These are honest about being open, but they should not be cited as "verified" mathematical content.

### H-2: `native_decide` used for finite computations

`native_decide` is used extensively (at least 50+ instances across SR_Flow.lean, SR_SignatureBound.lean, SR_Stage29.lean, SR_Stage31.lean, SR_Stage36.lean, SR_Stage38.lean, SR_WEntropy.lean, etc.). This is technically sound: `native_decide` runs the kernel evaluator on decidable propositions. However:

- Each `native_decide` proof is valid ONLY for the exact finite statement it checks.
- It provides NO information about general X or asymptotic behavior.
- Examples: `SR_diagonal_X6 : SR_diagonal_sign_sum 6 = 2`, `SR_quotient_count_X6 : SR_quotient_count 6 = 2`, `W_SR_primorial_zero : W_SR_primorial 6 = 0 ∧ ...`

### H-3: `W_SR_converges` is a Prop that is never proved

**File:** SR_WEntropy.lean  
**Declaration:** `W_SR_converges : Prop := ∀ ε > 0, ∃ X₀, ∀ X ≥ X₀, |W_SR_primorial X| < ε`  
The function `W_SR_primorial` is hard-coded to return 0 for X in {6, 30, 210, 2310} and 0 for all other X. Therefore `W_SR_converges` IS trivially true for this definition (the observable is identically zero). But this makes the observable useless: a constant-zero function converges to zero trivially, and this says nothing about the Riemann Hypothesis.

### H-4: `SR_growth_law_conjecture` and related conjectures are never proved

**File:** SR_Stage29.lean  
These are stated as `def ... : Prop := ...` — they are types without inhabitants, i.e., statements without proofs. They appear in the ledger but no theorem proves them.

---

## 3. False or misleading claims

### M-1: `W_SR_RH_bridge` is a tautology, not a bridge

**Declaration:** `def W_SR_RH_bridge : Prop := W_SR_converges → True`  
**Why misleading:** The name suggests a mathematical connection from W-observable convergence to RH. The actual Lean definition is `W_SR_converges → True`, which is a tautology: it is true regardless of whether `W_SR_converges` holds, and regardless of whether RH is true.

### M-2: `SR_growth_cert_0_8_consistent` does not validate a growth law

**File:** SR_Stage29.lean  
**Declaration:** `theorem SR_growth_cert_0_8_consistent : sr_growth_cert_0_8.exponent_estimate = 3 * sr_growth_cert_0_8.beta := by native_decide`  
**Why misleading:** This only verifies that the manually entered field `exponent_estimate = 2.4` equals `3 * 0.8 = 2.4`. It does not prove that `SR_weil_form_real X 0.8 21.022` actually grows like `X^2.4`. The ledger (Research/KilledApproaches.md) explicitly records that the normalized values `Q_X/X^(3 beta)` decrease toward zero at larger X, undermining the asymptotic claim.

### M-3: `X30_reducedInertiaCertificate` is a weak signature certificate

**File:** SR_Flow.lean  
**Declaration:** `theorem X30_reducedInertiaCertificate : ∃ pos neg : Nat, pos = 3 ∧ neg = 3 ∧ X30_reducedMatrixInt.det = X30_reducedCongruencePivots.prod * X30_reducedFinalBlock.det`  
**Why limited:** This packages some exact integer calculations but does NOT formally prove that the Sylvester inertia of the X=30 Rees matrix is (3, 3, 4) via Sylvester's law. It records a determinant factorization as an inertia certificate, but the connection from determinant signs of congruence pivots to Sylvester inertia is not formally proved in Lean (it relies on the mathematical fact that Gaussian elimination pivot signs determine inertia, which is not stated as a proved Lean theorem here).

### M-4: The signed Dirichlet polynomial (SR_Stage36) is not connected to zeta zeros

**File:** SR_Stage36.lean  
The file imports `Mathlib.NumberTheory.LSeries.MellinEqDirichlet`, `LSeries.Dirichlet`, etc., and defines `SR_signed_dirichlet_polynomial X`. The file proves formal differentiation properties of this polynomial. However, there is no proved theorem connecting the zeros of `SR_signed_dirichlet_polynomial X` (as X → ∞) to the zeros of the Riemann zeta function. The analytic connection is not established.

---

## 4. Finite-vs-general mismatches

### FG-1: All signature computations are at fixed finite cutoffs

The signature results (X=6: (1,1,2), X=30: (3,3,4)) are proved by `native_decide` or explicit matrix computations at specific values. There is no proved theorem of the form "for all X ≥ 6, the signature of `M_Rees_X` satisfies [property]." The flow sequence 0≤1≤3 for negative counts at X=5/2, 6, 30 is recorded but not extended to general X.

### FG-2: `SR_rees_rank_eq_quotient_count` holds for all X ≥ 6 (proved)

This is a genuine general theorem (proved in SR_Stage38.lean without `native_decide`). The rank of the (X-2)×(X-2) matrix with entries `(-1 if (i+2)(j+2)<X else 1)` equals `|{(X-1)/m : 2 ≤ m < X}|`. This is the one general algebraic result of substance.

### FG-3: `SR_threshold_matrix_quadratic_form` is purely algebraic at finite n

The quadratic form theorem `∑ x_i (∑ M_{ij} x_j) = -∑ x_i^2` for `SR_signed_threshold_matrix` is proved for general `n` and general strictly monotone `t`. This shows the form is negative definite. However, the connection from `SR_signed_threshold_matrix` to `SR_rees_matrix` is explicitly noted as NOT established for general X (only for specific cases).

---

## 5. Analytic gaps

### AG-1: No asymptotic estimate proved

The core analytic gap is: no theorem of the form `|Q_X(beta, gamma)| = O(X^f(beta))` is proved for any `f`. The project has finite bounds (trivial absolute value bound via triangle inequality, proved in SR_Stage30_Bound.lean) but no asymptotic result.

### AG-2: Abel summation framework present but not connected to Q_X bounds

`SR_Bridge.lean` proves a verified Abel summation identity (`abel_summation_finset_verified`) and a Cauchy-Schwarz inequality in finite dimension. These are genuine proved lemmas. However, they are not connected to an asymptotic estimate for `SR_weil_form_real X beta gamma`. The bridge between the finite identity and any analytic conclusion is not formalized.

### AG-3: No uniform error term for the divisor summatory function

The approach via `SR_A_weighted` (weighted divisor summatory function) and `SR_product_fibre_weight` sets up the combinatorial framework for Abel summation, but no estimate of the form `SR_A_weighted X beta gamma T = main_term + error` is proved.

### AG-4: L-series framework imported but not used analytically

SR_Stage36 imports `Mathlib.NumberTheory.LSeries.MellinEqDirichlet`. The theorems proved using this import (`sr37_vonMangoldt_lseries_is_negative_zeta_log_derivative`, `sr37_lseries_of_dirichlet_convolution_eq_product`) are correct applications of Mathlib's analytic number theory API. However, these theorems are about abstract L-series, not about `SR_weil_form_real` or `SR_rees_matrix`. No theorem connects the SR matrix eigenvalues or quadratic form to any L-series.

### AG-5: Von Mangoldt weights used in definitions but not in asymptotic proofs

`SR_Bridge.lean` defines `psi2_SR X` using `vonMangoldt` weights. The project records (Research/FailureInvariants.md) that the B3 implication with psi2 weights fails numerically at X=6. No analytic theorem using von Mangoldt weights is proved.

---

## 6. Spectral gaps

### SG-1: No eigenvalue of any SR matrix is computed or bounded

The project studies the Rees sign matrix `SR_rees_matrix X` and proves its rank. No eigenvalue, spectral gap, or spectral bound is proved for any version of the SR matrix.

### SG-2: Negative definiteness of `SR_signed_threshold_matrix` is proved

The theorem `SR_threshold_matrix_quadratic_form` shows `∑ x_i (M x)_i = -∑ x_i^2`, implying the form is negative definite for the abstract threshold matrix with strictly monotone index. This is a genuine algebraic result. Its eigenvalues are all in (-∞, 0).

### SG-3: No connection between `SR_signed_threshold_matrix` and `SR_rees_matrix` for general X

The Stage 38 abstract results (`SR_threshold_matrix_quadratic_form`, `SR_signed_threshold_matrix_det`) apply to `SR_signed_threshold_matrix t` for any strictly monotone `t`. The connection to `SR_rees_matrix X` (which is a threshold matrix for the specific sequence `t m = (X-1)/(m+2)`) is noted but the "threshold" sequence here is NOT strictly monotone in general (multiple m values can give the same quotient). Stage 38 establishes the abstract theory; SR_Stage38 lines 447-860 show `SR_rees_matrix` is parameterized by distinct quotients (hence the rank theorem), but the direct application of `SR_signed_threshold_matrix` results to `SR_rees_matrix` is not proved as a general theorem.

---

## 7. Algebra/Hodge/Rees gaps

### AHR-1: No proved Hodge-Riemann theorem for the SR carrier

The project attempts a Hodge-index approach via `H_SR` and `PD_pairing`. What is proved:
- `H_SR` is Hermitian and positive semidefinite on `E10`.
- The signature of `M_Rees` at X=6 is (1,1,2).
- There exist positive and negative directions.
- The GNS functional `Gamma_obs` is positive on `E11`.

What is NOT proved:
- Any Hodge-Riemann bilinear relation in the classical sense.
- Any version of the Lefschetz decomposition theorem for the SR carrier.
- Any statement connecting the signature of the SR bilinear form to zeros of an L-function.

### AHR-2: The GNS functional collapses to one coordinate

`Gamma_obs x = x.coeff (PrimeIndex6.p2, PrimeIndex6.p2)` — it reads only the `(2,2)` diagonal entry. This was verified to kill the radical witness positively (`I_SR_radical_witness_pos > 0`), which is why the Rees-signed version `I_SR_Rees` was introduced instead. The GNS approach failed (Stage 13 outcome: `not_I_SR_nonpos_on_PD_radical`).

### AHR-3: `rees_not_leibniz` proves only non-existence of a commutative Leibniz package

This theorem is correctly proved, but its mathematical content is narrow: it shows there is no internal commutative product on `E10` compatible with the ordered pair structure. This does not obstruct the program in any useful way (the program does not need an internal commutative product).

---

## 8. Flow/dBN/infinite-limit gaps

### FDB-1: The "flow" in SR_Flow.lean is a finite arithmetic sequence

The "flow" is the sequence of signatures at cutoffs X = 5/2, 6, 30. There is no analytic flow (no differential equation, no heat equation, no de Bruijn-Newman parameter lambda). The name "flow" refers to the discrete evolution of the signature as X increases.

### FDB-2: The dBN scaffold has zero mathematical content

The structure `SRdBNBridgeScaffold` has fields that are all `True`:
- `near_terms : True`  
- `heat_localization : True`  
- `zero_tracking : True`  
- `limit_open : True`

These compile trivially. The dBN bridge does not exist.

### FDB-3: No infinite limit is taken in any theorem

Every proved theorem in the project is about finite X. There is no proved statement about `X → ∞`, no `Filter.atTop` limit theorem proved for the SR form (the indicator convergence theorem `sr37_support_indicator_tendsto_one` in SR_Stage36 is about finite-support indicator functions converging to 1, not about the SR quadratic form).

### FDB-4: `SR_flow_derivative` is a discrete difference, not an analytic derivative

`SR_flow_derivative (X : Nat) (hX : 6 ≤ X) : reesTrace (X + 1) - reesTrace X = if X % 2 = 0 then -1 else 1` — this is a proved fact about the arithmetic sequence `reesTrace X = 2 if X even, 1 if X odd (for X ≥ 6)`. It has no analytic interpretation.

---

## 9. Dependency graph / first fatal gap

The logical chain of the project is:

```
SR_Primitives (grade, IsPrimeNat)
  -> SR_Carrier (E20_6, q, e)
  -> SR_Multiplication (SR_mul)
  -> SR_Dagger (dagger, E11)
  -> SR_GNS (Gamma_obs)
  -> SR_ISR / SR_ISR_Full (I_SR, I_SR_Rees, Rees_sign6)
  -> SR_Signature (M_Rees rank/signature, P_SR_phys_true)
  -> SR_Flow (M_Rees_X, signatures at X=5/2,6,30, dBN scaffold [TRUE])
  -> SR_Bridge (Cauchy-Schwarz, Abel, S_int/S_ext decomposition)
  -> SR_Stage29 (SR_weil_form_real, growth conjectures [UNPROVED])
  -> SR_Stage31-38 (channel decomposition, rank=quotient_count, threshold matrices)
  -> SR_WEntropy (W_SR_RH_bridge = P → True [TAUTOLOGY])
```

**First fatal gap:** The gap from SR_Flow to any analytic content. The dBN bridge (SR_Flow lines 16D) is `True`. There is no path from the proved finite theorems to any statement about zeta zeros, RH, or even the behavior of the SR form as X → ∞.

The **first non-trivial unresolved mathematical gap** is at SR_Stage29: no asymptotic bound of any kind is proved for `SR_weil_form_real X beta gamma`. Everything downstream (SR_Stage31–38) is finite combinatorics that does not require an asymptotic bound.

---

## 10. File-by-file status

| File | Build status (reported) | Mathematical status | Holes | Downstream importance |
|---|---|---|---|---|
| SR_Primitives.lean | OK | PROVED: grade, IsPrimeNat definitions | None | Foundation for everything |
| SR_Carrier.lean | OK | PROVED: E20_6 dim=16, q23≠q32 | `decide` (sound) | Foundation |
| SR_Multiplication.lean | OK | PROVED: SR_mul uniqueness | None known | Carrier multiplication |
| SR_Dagger.lean | OK | PROVED: dagger involution, E11 product | None known | GNS construction |
| SR_GNS.lean | OK | PROVED: Gamma_obs positive, domain firewall | `trivial` (Sound, trivial) | GNS positivity |
| SR_Rees.lean | OK | PROVED: rees_not_leibniz | None | Structural no-go |
| SR_Signature.lean | OK | PROVED: M_Rees rank=2, signature (1,1,2), true physical sector | Two `True` open checkpoints (sign convention open) | Core algebraic result |
| SR_Flow.lean | OK | PROVED: finite signatures at 3 cutoffs, arithmetic flow derivative | `native_decide` (sound for finite claims); `True` for dBN bridge | Finite signature sequence |
| SR_Bridge.lean | OK | PROVED: Cauchy-Schwarz, Abel summation identity, S_int+S_ext split | None | Finite analytic infrastructure |
| SR_WEntropy.lean | OK | PROVED: W_SR_primorial=0 (trivially), reesTrace formula | W_SR_RH_bridge is tautology | RH bridge placeholder (no content) |
| SR_Stage29.lean | OK | PROVED: finite product-fibre identities, growth certs (consistent field) | Growth conjectures unproved | Asymptotic program (unfinished) |
| SR_Stage31.lean | OK | PROVED: two-channel decomposition, diagonal sign sums (native_decide) | `native_decide` | Channel splitting |
| SR_Stage33.lean | OK | PROVED: beta=1/2 diagonal count formula | `decide` | Diagonal structure |
| SR_Stage34.lean | OK | PROVED: row sum bound | `native_decide` | Off-diagonal bounds |
| SR_Stage35.lean | OK | PROVED: Gram entries at X=6 | `native_decide` | Gram matrix computation |
| SR_Stage36.lean | OK | PROVED: signed Dirichlet polynomial derivatives, rank=quotient_count via explicit formula | `native_decide` | Key algebraic theorem |
| SR_Stage37_Clean.lean | OK | PROVED: formal L-series/Dirichlet convolution theorems (from Mathlib) | None | L-series framework import |
| SR_Stage38.lean | OK | PROVED: SR_rees_rank_eq_quotient_count (general X≥6), threshold matrix algebra, negative definiteness of signed threshold matrix | `native_decide` (small cases) | Strongest general algebraic result |
| SR_SignatureBound.lean | OK | PROVED: signature bound computations for X in [6,200] | `native_decide` (many) | Finite signature survey |
| SR_Density.lean | OK | PROVED: density count formulas | `native_decide` | Density arithmetic |
| SR_ISR_Full.lean | OK | PROVED: I_SR_Rees, Rees_sign6, sign table | `decide` | Rees form definition |
| SR_Boundary.lean | OK | PROVED: boundary support computation | `native_decide` | Support structure |
| SR_Mollifier.lean | OK | PROVED: mollifier weight computations | `native_decide` | Mollifier arithmetic |
| Check.lean | (Not in lakefile) | Unknown | — | Not registered |
| SR_Stage28.lean | (Not verified in this audit) | Unknown | — | Intermediate stage |
| SR_Flow_draft_20260906.lean | (Not in lakefile) | Draft | — | Archived draft |

**Files in lakefile but not audited in detail:** SR_KnowledgeBank, SR_Underdetermination, SR_Stage8, SR_Valuation, SR_Stage9, SR_PoincareDuality, SR_LefschetzDiagnosis, SR_Lefschetz, SR_HermitianForm, SR_ISR, SR_Balance, SR_Balance_Comparison, SR_Primorial, SR_UpperBound, SR_SpectralBridge, SR_WeilForm, SR_Stage28, SR_Stage30_Bound, SR_Stage30, SR_NoCommutativity.

**Files NOT in lakefile:** Check.lean, SR_Flow_draft_20260906.lean, SR_Stage28.lean (present as file but in lakefile — actually it IS in lakefile per the read above), SR_B3_Failures.md (documentation only).

---

## 11. Audit statistics

- Active .lean files examined in detail: ~25
- `sorry` found: 0
- `admit` found: 0
- `axiom` (user-defined) found: 0
- `opaque` found: 0
- `unsafe` found: 0
- `native_decide` instances: ~60+
- `decide` instances: ~20+
- Named `True` open-checkpoint theorems: ~6
- Definitional tautologies (P → True): 2 (W_SR_RH_bridge, SR26_PERELMAN_CONJECTURE_RECORD)
- Proved general theorems (for all X ≥ 6): 2-3 (SR_rees_rank_eq_quotient_count, SR_threshold_matrix_quadratic_form, reesTrace formula)
- Proved finite certificate theorems (at specific X values): many (~100+)
- Proved analytic theorems connecting SR to RH: 0
- Proved asymptotic theorems: 0
- Open conjectures as uninstantiated Prop definitions: 4 (SR_growth_law_conjecture, SR_growth_upper_envelope_conjecture, SR_growth_coercivity, W_SR_converges [trivially true for the constant-zero definition])
