# Stage 1 Infrastructure Block

Date: 2026-09-04

## Stage

Stage 1 - Ordered carrier.

Target theorem:

```lean
theorem ordered_carrier_dim_X6 :
  FiniteDimensional.finrank ℂ E20_6 = 16 := by ...
```

and

```lean
theorem q23_ne_q32 : q 2 3 ≠ q 3 2 := by ...
```

## Exact first blocked equation

The first theorem requires real mathlib-backed names for complex scalars and finite dimension:

```lean
FiniteDimensional.finrank ℂ E20_6 = 16
```

In mathlib `v4.29.1`, source inspection shows the concrete finrank definition is:

```lean
Module.finrank
```

with the correct finite-dimensional import path:

```lean
import Mathlib.LinearAlgebra.Dimension.Finrank
```

The requested `FiniteDimensional.finrank` surface can be supplied only as a wrapper over mathlib's real `Module.finrank`, not as a local placeholder.

## What was tried

- Created and verified Stage 0 primitives.
- Added mathlib dependency pinned to `v4.29.1`, matching installed Lean `v4.29.1`.
- Shallow-cloned mathlib at commit `5e932f97dd25535344f80f9dd8da3aab83df0fe6`.
- Fetched transitive dependencies.
- Added exact Git `safe.directory` entries for Lake package checkouts.
- Attempted `lake exe cache get`; cache download reached 100%, but decompression failed due to disk exhaustion.
- Removed generated cache artifacts at `C:\Users\ljoe6\.cache\mathlib` to recover space.
- Probed corrected import:

```lean
import Mathlib.LinearAlgebra.Dimension.Finrank
import Mathlib.Data.Complex.Basic
```

- Interrupted the source build when `C:` dropped below the safe threshold, around `0.19 GB` free.

## Failure invariant extracted

Stage 1 is currently blocked by local machine resources, not by a Lean proof obstacle:

- The required mathlib checkout exists.
- The correct import path has been identified.
- The source build needs more disk and likely constrained jobs.
- Current free disk space is about `0.19 GB`, too low to safely continue compiling mathlib or completing the cache.

Recommended resume command after freeing disk space:

```powershell
lake -Kjobs=1 lean SR_ImportProbe.lean
```

After that succeeds, implement `SR_Carrier.lean` using real mathlib `ℂ`, real vector-space instances, and a wrapper only if needed to expose the requested `FiniteDimensional.finrank` name.
