# Cycle 134 — Xi Hankel Moment Obstruction

Tested the alternating centered-Xi Taylor sequence
`Xi(t) = sum (-1)^n b_n t^(2n)` by forming Hankel matrices `(b_(i+j))`.

Although the individual `b_n` are positive in the tested range, the Hankel
matrices are not positive semidefinite:

```text
size 2: minimum eigenvalue -1.418556e-4
size 3: minimum eigenvalue -1.418843e-4
size 4: minimum eigenvalue -1.418843e-4
size 5: minimum eigenvalue -1.418843e-4
size 6: minimum eigenvalue -1.418843e-4
```

Thus the naive Stieltjes-moment interpretation of the centered Xi Taylor
coefficients fails. Jensen hyperbolicity cannot be replaced by simple Hankel
positivity; the correct positive form must use the Weil kernel or a different
transformed coefficient sequence.
