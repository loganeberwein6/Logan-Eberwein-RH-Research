# SR Mathlib Gaps

## Stage 0

- In the freshly created Lean-core project, `Set` notation was unavailable without adding mathlib or another set library import. For Stage 0, `PrimeSet` is represented extensionally as `Nat → Prop`.
- In the freshly created Lean-core project, `Nat.Prime` was unavailable. Stage 0 uses a local predicate `IsPrimeNat`.

## Stage 1

- The Lake file temporarily referenced mathlib `v4.29.1`, but the active
  toolchain is Lean `v4.33.1`, network access is restricted, and
  `.lake/packages/mathlib` is only a stub directory. `lake update` failed
  before creating a usable package manifest. Stage 1 therefore uses a local
  finite-rank interface with the requested surface names.
