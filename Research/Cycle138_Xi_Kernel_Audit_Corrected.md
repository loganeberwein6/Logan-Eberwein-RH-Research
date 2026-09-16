# Cycle 138 — Xi Kernel Audit Corrected

The previous kernel-negativity result was corrected after checking the primary
Fourier representation. The theta-series formula is evaluated for nonnegative
`t` and then extended evenly; direct evaluation of the raw exponential series
at negative `t` is not valid numerically.

With the even extension, the sampled values are positive at `|t|=0,2,4,6,8`.
The earlier negative value was a probe error, not a mathematical obstruction.

The primary reference states the even Fourier kernel and its theta-derivative
formula: Yaoming Shi, *On the zeros of Riemann Xi function*, arXiv:1706.08868.

This reopens pointwise-kernel positivity as a viable subproblem, while leaving
the global real-zero theorem and RH unresolved.
