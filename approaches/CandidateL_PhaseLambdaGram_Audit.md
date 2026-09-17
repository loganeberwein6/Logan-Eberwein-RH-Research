# Cycle 13: phase-preserving Lambda Gram variant

## Construction

Replace the Hermitian Gram operator from Cycle 12 by the complex-symmetric
rank-one operator

\[
 T_s=u_su_s^{\mathsf T},\qquad u_s(n)=\Lambda(n)n^{-s/2}.
\]

The matrix determinant lemma gives

\[
 D_X(s)=\det(I-T_s)
 =1-\sum_{2\le n<X}\Lambda(n)^2n^{-s}.
\]

Unlike `u_su_s^*`, this preserves the frequency `Im(s)`, but it is not a
positive-semidefinite operator.

## Raw output

```text
X=20:
  det(1.5)=-0.48894886387958936  det(2.0)=0.3723401517267836
  t=0.001: 7.32092052081   t=14.1347: 7.32092052081
  t=21.022: 4.83792056121  t=25.0109: 4.56044171353
  t=30.4249: 6.12635436575 t=32.9351: 6.17410044552

X=50:
  det(1.5)=-0.9686629021730824  det(2.0)=0.28806623513679974
  t=0.001: 27.3193974345  t=14.1347: 10.7619180375
  t=21.022: 8.55719092008 t=25.0109: 9.44181369766
  t=30.4249: 8.37617889272 t=32.9351: 7.09138726747

X=100:
  det(1.5)=-1.2753075776624505  det(2.0)=0.2511767739749575
  t=0.001: 49.0297917741 t=14.1347: 8.58475980723
  t=21.022: 9.65180920665 t=25.0109: 7.87093119337
  t=30.4249: 8.12792175405 t=32.9351: 7.97229558894
```

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | no | the determinant is a finite `Lambda^2` Dirichlet polynomial, not `1/zeta` or a known completed-zeta factor |
| P2 | partial | Lambda appears, but squared and without prime-power orbit structure |
| P3 | no | transpose rather than adjoint makes the operator complex symmetric, not positive |
| P4 | no | no completed-zeta functional-equation involution |
| P5 | yes | integer arithmetic |
| P6 | partial | finite truncations are entire, but the infinite series has abscissa 1 and no continuation supplied by the operator |

## Verdict

**DEAD.**  Preserving frequency by replacing the adjoint with a transpose
restores spectral variation but loses positivity and produces only a
`Lambda^2` Dirichlet series.  The numerical minima do not converge to the
first zeta ordinates as `X` increases.
