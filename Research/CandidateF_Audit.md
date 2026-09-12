# Candidate F cycle — adelic comparison

For positive integers, the adelic norm satisfies (|n|_A=1/n). Therefore

```text
|mn|_A < |X|_A  iff  mn > X,
```

so the adelic sign matrix is exactly the negative of the Rees sign matrix:

```text
T_adelic,X = -M_Rees,X.
```

## Raw output

```text
X=6: all_ones=-14.0 min_eig=-3.645751 max_eig=1.645751
  first_5_eigs=[-3.645751  0.        0.        1.645751]
X=10: all_ones=-52.0 min_eig=-6.989177 max_eig=3.408432
  first_5_eigs=[-6.989177 -1.522279 -0.       -0.       -0.      ]
X=30: all_ones=-692.0 min_eig=-25.835042 max_eig=8.245000
  first_5_eigs=[-25.835042  -4.640331  -2.732215  -1.655402  -0.      ]
X=100: all_ones=-9052.0 min_eig=-94.115797 max_eig=19.731534
  first_5_eigs=[-94.115797 -11.433999  -6.555102  -4.580075 -3.410458]
```

## Verdict

**DEAD.** Negating the Rees matrix reverses every eigenvalue and changes the
all-ones quadratic value from positive to negative. It does not create Euler
factors, functional-equation symmetry, nuclear convergence, or a zeta-zero
determinant. The adelic comparison is therefore algebraically equivalent to
the already-tested Rees operator with the sign reversed.
