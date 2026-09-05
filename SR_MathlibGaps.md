# SR Mathlib Gaps

## Stage 0

- In the freshly created Lean-core project, `Set` notation was unavailable without adding mathlib or another set library import. For Stage 0, `PrimeSet` is represented extensionally as `Nat → Prop`.
- In the freshly created Lean-core project, `Nat.Prime` was unavailable. Stage 0 uses a local predicate `IsPrimeNat`.

## Stage 1

- Mathlib is required for the requested symbols `ℂ` and `FiniteDimensional.finrank`.
- A shallow checkout of mathlib `v4.29.1` exists locally at `.lake/packages/mathlib`, commit `5e932f97dd25535344f80f9dd8da3aab83df0fe6`.
- Lake metadata fetches from GitHub are currently unreliable/refused, so the root manifest was repaired manually to reference the local checkout.
- Mathlib cache download reached 100%, but decompression was partial due to disk-full errors: 3554 files decompressed, 4678 failed. The generated cache directory was removed to recover space.
- Correct finite-dimensional import for mathlib `v4.29.1` is `Mathlib.LinearAlgebra.FiniteDimensional.Basic`, not `Mathlib.LinearAlgebra.FiniteDimensional`.
- Corrected import probe reached approximately `1233/1548` build tasks before being interrupted at about `0.20 GB` free disk space.
- A lighter probe using `Mathlib.LinearAlgebra.Dimension.Finrank` also required source compilation and failed under low disk/memory/thread resources. Next retry should constrain Lake jobs after freeing disk space.

## Stage 1

- The Lake file temporarily referenced mathlib `v4.29.1`, but the active
  toolchain is Lean `v4.33.1`, network access is restricted, and
  `.lake/packages/mathlib` is only a stub directory. `lake update` failed
  before creating a usable package manifest. Stage 1 therefore uses a local
  finite-rank interface with the requested surface names.
