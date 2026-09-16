# Cycle 136 — Factorial Hankel Positivity Through Size 7

The corrected factorial-moment probe was extended through Hankel size 7.
Minimum eigenvalues were:

```text
size 2: 1.897248e-03
size 3: 2.911128e-05
size 4: 7.470714e-07
size 5: 2.413367e-08
size 6: 9.058278e-10
size 7: 3.856139e-11
```

All tested matrices remain positive semidefinite, but the lower edge shrinks
rapidly. A larger-size attempt initially exceeded the generated moment list;
the probe was corrected to report only the certified size-7 range.

The data supports a positive moment structure with severe conditioning loss,
so any infinite-limit proof needs a renormalized topology or a coercivity
statement on a restricted test space.
