# SR Failure Invariants

No failure invariants recorded yet.

## Stage 1

- Honest Stage 1 verification requires mathlib-backed `ℂ` and finite-dimensional rank. Local stand-ins for these names are not acceptable.
- In mathlib `v4.29.1`, the finite-rank constant is `Module.finrank`; the originally suggested import `Mathlib.LinearAlgebra.FiniteDimensional` is not a valid file path.
- Current obstruction is infrastructure: the machine has about `0.19 GB` free on `C:`, and source compilation of the required mathlib chain fails or becomes unsafe under that constraint.
