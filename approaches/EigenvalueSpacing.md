# Rees eigenvalue spacing probe

For the symmetric complete-support matrix `M_Rees_X`, eigenvalues were
computed with a real symmetric eigensolver and gaps were normalized by the
mean gap.

| X | dimension | min eigenvalue | max eigenvalue | mean gap | normalized gap min | normalized gap max |
|---:|---:|---:|---:|---:|---:|---:|
| 50 | 48 | -12.2522 | 45.0970 | 1.2202 | ~0 | 31.3059 |
| 100 | 98 | -19.7315 | 94.1158 | 1.1737 | ~0 | 70.4464 |
| 200 | 198 | -31.0323 | 193.0347 | 1.1374 | ~0 | 153.3981 |

The spectra have a very large separated top eigenvalue and many near-zero
gaps.  This is not GUE-like level repulsion, whose normalized gaps are
typically concentrated near the Wigner-surmise scale rather than exhibiting
an increasing outlier gap.  The observation is consistent with the rank-one
all-ones component in `M = J - 2A`, not with random-matrix universality.

No RH implication is inferred from this finite spacing comparison.
