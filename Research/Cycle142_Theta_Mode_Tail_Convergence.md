# Cycle 142 — Theta-Mode Tail Convergence

Direct tail evaluation of the corrected positive theta modes shows rapid
Gaussian convergence. The sum of the next ten modes after cutoff `N` was:

```text
 t     N=1          N=2          N=3
 0     9.70e-4      7.96e-10     7.25e-19
.25    9.07e-7      2.71e-17     1.56e-32
.5     4.19e-12     6.22e-30     2.17e-55
1      1.32e-36     2.64e-86     2.25e-156
2      2.74e-292    4.79e-664    5.41e-1185
```

This indicates that summability on `t >= 0` is likely controlled by the
Gaussian factor `exp(-pi*n^2*exp(2t))`, rather than by delicate cancellation.
The difficult remaining passage is uniform control in the Fourier transform
and zero-location theorem, not pointwise convergence of the mode series.
