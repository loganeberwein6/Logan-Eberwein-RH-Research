# Diagonal SR L-function probe

For prime support the proposed diagonal product is

```text
L_SR(s,X) = product_{p < sqrt(X)} (1+p^(-s))
             * product_{sqrt(X) <= p < X} (1-p^(-s)).
```

Numerical values (direct floating-point evaluation):

| X | s=0 | s=1/2 | s=1 | s=2 |
|---:|---:|---:|---:|---:|
| 30 | 0 | 0.4602949823 | 1.421525008 | 1.382025122 |
| 210 | 0 | 0.06469876641 | 1.745429935 | 1.471445362 |
| 2310 | 0 | 0.00008773033314 | 2.293943841 | 1.508152469 |

At `s=0`, every exterior prime contributes a zero factor, so the product is
identically zero for these cutoffs.  This makes `s=0` uninformative.

For comparison, the analytically continued zeta values are

```text
zeta(0)   = -0.5
zeta(1/2) = -1.4603545088...
zeta(2)   = 1.6449340668...
```

The SR product is positive at `s=1/2` and `s=1`, unlike zeta at `1/2`; no
direct functional relation is evident from these finite products.  The
values at `s=1` and `s=2` grow slowly across the tested primorial cutoffs.
