# SR Verified Ledger

## Stage 0 - Primitives

- Stable IDs: SR.0.1, SR.0.2, SR.0.3, SR.0.4
- Theorem/definition statements:
  - `OPair : Type := Nat × Nat`
  - `IsPrimeNat (p : Nat) : Prop := 2 ≤ p ∧ ∀ a b : Nat, a * b = p → a = 1 ∨ b = 1`
  - `PrimeSet (X : Rat) : Nat → Prop := fun p => IsPrimeNat p ∧ (p : Rat) < X`
  - `grade (m n : Nat) (X : Rat) : ReesGrade`
- Proof strategy used: definitions plus `#check` audit.
- Mathlib lemmas used: none; Lean core suffices for Stage 0.
- Date: 2026-09-04

## Stage 1 - Ordered Carrier

- Stable IDs: SR.1.1, SR.1.2
- Theorem statements:
  - `ordered_carrier_dim_X6 : FiniteDimensional.finrank ℂ E20_6 = 16`
  - `q23_ne_q32 : q 2 3 ≠ q 3 2`
- Proof strategy used:
  - `E20_6` is represented as functions on the ordered index type
    `PrimeIndex6 × PrimeIndex6`, preserving all 16 ordered coordinates.
  - `ordered_carrier_dim_X6` closes by `rfl` against the local Stage 1
    `HasFinrank` instance.
  - `q23_ne_q32` evaluates both basis vectors at the ordered coordinate
    `(2,3)` and reduces the contradiction by `simp`.
- Mathlib lemmas used: none; mathlib is not locally available in this
  restricted workspace.
- Date: 2026-09-04

## Stage 2 - Multiplication

- Stable ID: SR.2.1
- Theorem statement:
  - `mul_is_forced : ∀ (f : E10 →ₗ[ℂ] E10 →ₗ[ℂ] E20_6), (∀ m n, f (e m) (e n) = q m n) -> f = SR_mul`
- Proof strategy used:
  - In the bootstrap layer, `E10` is the raw label carrier `Nat`, and
    `e m` is definitionally `m`.
  - Function extensionality reduces equality of multiplications to equality
    at arbitrary ordered labels `m n`.
  - The provenance hypothesis closes the resulting goal directly.
- Mathlib lemmas used: none; Lean core `funext` suffices.
- Date: 2026-09-04
