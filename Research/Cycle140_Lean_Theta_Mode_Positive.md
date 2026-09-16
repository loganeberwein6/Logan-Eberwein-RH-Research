# Cycle 140 — Lean-Proved Theta-Mode Positivity

Added and registered `SR_ThetaKernel.lean`.

Lean now proves `thetaMode_pos`: for every natural mode `n >= 1` and every
real `t >= 0`, the corrected theta-mode factor is strictly positive. The proof
factors the mode as

`pi*n^2*exp(5t/2) * (2*pi*n^2*exp(2t)-3) * exp(-pi*n^2*exp(2t))`

and uses `3 < pi`, `n^2 >= 1`, and `exp(2t) >= 1`.

The target builds successfully under Lean 4.29.1. This upgrades the previous
sampled positivity observation to a universal per-mode theorem. It does not
yet prove positivity of the infinite summed kernel's transform or RH.
