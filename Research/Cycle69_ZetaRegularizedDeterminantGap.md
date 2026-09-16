# Cycle 69 — Zeta-Regularized Determinant Gap

The divisor-complex heat identity gives `H(t)=sum mu(n) exp(-nt)` and, by Mellin transform in `Re(s)>1`, `1/Gamma(s) integral t^(s-1)H(t)dt = 1/zeta(s)`. This is an exact arithmetic supertrace identity, but it is not yet an ordinary parameterized Fredholm determinant.

For a fixed operator, zeta regularization uses `det_zeta A = exp(-Z_A'(0))`, where the spectral-zeta variable is independent of the external Dirichlet parameter. Thus a finite quantity `Z_X(u)=sum_{n<=X} mu(n)n^(-u)` does not automatically yield a determinant function equal to `1/zeta(s)`. A valid operator proof still needs a family `T(s)` and a trace-log expansion `log det(I-T(s))=-sum_k Tr(T(s)^k)/k`, with primitive cycles exactly producing the Euler product.

Finite unsmoothed diagnostics for `Z_X` at zero were:

| X | Z_X(0) | Z'_X(0) | exp(-Z'_X(0)) |
|---:|---:|---:|---:|
| 10 | -1 | 1.2527629685 | 0.285714285714 |
| 50 | -3 | 7.55596755934 | 0.000522979883 |
| 100 | 1 | -10.0174110253 | 22413.3272026 |

The instability is expected from unsmoothed truncation at the regularization point and is not evidence about RH. It demonstrates that naive zeta-regularized finite determinants do not replace the missing parameterized Fredholm construction.

Status: P2/P5 are strongest here; P1 is only a half-plane scalar identity; P3 positivity is absent; P4 completed functional symmetry is absent; P6 is partial because heat damping gives trace-class behavior only in the initial half-plane. The missing theorem must produce an ordinary, parameter-dependent, trace-class family with exact Euler trace-log, positivity/coercivity, and completed symmetry.
