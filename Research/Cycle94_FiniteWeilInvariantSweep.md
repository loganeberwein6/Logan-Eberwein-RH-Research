# Cycle 94 — Finite Arithmetic Weil Invariant Sweep

## Construction status

The operator implementation from Cycle 93 was retained without fitting any
zero ordinates. An invariant sweep tested scales `1.2, 1.5, 2, 2.5, 3` and
Fourier cutoffs `1, 2, 3`.

## Raw output

```text
scale  cutoff  asymmetry  minimum eigenvalue  maximum eigenvalue
1.2       1       0        0.14293257         1.3490947
1.2       2       0        0.13484777         1.9101654
1.2       3       0        0.13245894         2.2674553
1.5       1       0        0.001171486        0.34629778
1.5       2       0        0.00032184732      0.99703176
1.5       3       0        0.00024650758      1.5607072
2.0       1       0        3.5678612e-5       0.21557431
2.0       2       0        9.7402155e-7       0.39003236
2.0       3       0        2.3954985e-8       1.7536325
2.5       1       0        7.3029097e-6       0.11925347
2.5       2       0        3.2687724e-8       0.20573208
2.5       3       0        1.8266058e-10      0.31278672
3.0       1       0        1.7084421e-6       0.12368487
3.0       2       0        4.9209222e-9       0.21019835
3.0       3       0        3.2211019e-11      0.30431814
```

## Interpretation

The matrix is exactly symmetric in the computed representation, and every
finite sample in the sweep is positive. However, the smallest eigenvalue
collapses rapidly as scale and cutoff increase. This confirms finite
positivity but gives no uniform coercivity or convergence theorem.

## Verdict

**Construction invariant passed; limiting operator still unproved.** The next
technical requirement is a normalization or completion theorem that explains
the collapsing small eigenvalues without fitting the zero spectrum.
