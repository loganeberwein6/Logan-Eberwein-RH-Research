# Cycle 137 — Xi Kernel Formula Audit and Correction

An initial probe incorrectly evaluated the one-sided theta-series expression
at negative arguments. That produced a spurious value near `-1.68229` at
`|u|=4`. The primary representation is evaluated on `t >= 0` and extended
evenly; direct negative substitution is not the stable formula.

After the correction, the sampled even kernel is positive at all tested points,
including `|t|=2,4,6,8`. This removes the earlier pointwise-negativity claim,
but does not prove global kernel positivity or RH. The analytic formula and
its domain must be respected in any formalization.
