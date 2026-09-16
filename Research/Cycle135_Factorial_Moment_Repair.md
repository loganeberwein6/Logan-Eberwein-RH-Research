# Cycle 135 — Factorial Moment Repair

The previous Hankel obstruction used raw Taylor coefficients and failed. The
correct Fourier-moment normalization is

`c_n = (2n)! b_n`, where `Xi(t) = sum (-1)^n b_n t^(2n)`.

Using `c_n`, the Hankel matrices become numerically positive semidefinite:

```text
size 2: minimum eigenvalue 1.897248e-03
size 3: minimum eigenvalue 2.911128e-05
size 4: minimum eigenvalue 7.470714e-07
size 5: minimum eigenvalue 2.413367e-08
size 6: minimum eigenvalue 9.058278e-10
```

This identifies a real normalization error in the earlier moment attempt.
The factorial-scaled sequence is compatible with moments of the positive
Fourier kernel in the Riemann Xi representation. The shrinking eigenvalues
also show the next analytic issue: finite positivity may approach a singular
limit, so uniform coercivity still requires proof.

This positive moment scaffold is not an RH proof; it supplies a more faithful
candidate metric than the raw Taylor Hankel matrix.
