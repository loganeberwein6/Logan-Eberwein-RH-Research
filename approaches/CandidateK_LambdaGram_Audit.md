# Cycle 12: positive von-Mangoldt Gram operator

## Construction

Let

\[
 u_s(n)=\Lambda(n)n^{-s/2},\qquad T_s=u_su_s^*.
\]

For a finite support `2 <= n < X`, this is a positive semidefinite rank-one
operator.  Its determinant is exactly the matrix determinant lemma:

\[
 \det(I-T_{X,s})=1-\lVert u_s\rVert^2
 =1-\sum_{2\le n<X}\Lambda(n)^2n^{-\Re(s)}.
\]

The imaginary part of `s` cancels because the operator uses `u_su_s^*`.

## Raw output

```text
X=20:
  s=1.5: -0.488948863880
  s=2.0:  0.372340151727
  critical line: -11.0528512123 at every tested t

X=50:
  s=1.5: -0.968662902173
  s=2.0:  0.288066235137
  critical line: -27.3194007717 at every tested t

X=100:
  s=1.5: -1.275307577660
  s=2.0:  0.251176773975
  critical line: -49.0298033849 at every tested t
```

The critical-line values are identical for `t=0.001, 14.1347, 21.0220,
25.0109, 30.4249, 32.9351`.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | no | the determinant is a scalar Dirichlet polynomial in `Re(s)` and has no frequency-dependent zeta zeros |
| P2 | partial | Lambda is present, but as a square norm rather than a prime-power trace/orbit mechanism |
| P3 | yes at finite X | `T_X` is positive semidefinite |
| P4 | no | taking `u_su_s^*` removes the imaginary phase and supplies no `s -> 1-s` symmetry |
| P5 | yes | integer/von-Mangoldt arithmetic |
| P6 | no on the required half-plane | `sum Lambda(n)^2 n^{-sigma}` has abscissa of convergence `sigma=1`, so the natural trace-class domain is `Re(s)>1` |

## Verdict

**DEAD.**  This is the cleanest positive Lambda-weighted construction, and
its failure is exact: positivity obtained by taking a Gram norm erases the
frequency variable needed to see zeta zeros.  Reintroducing phases without
the adjoint destroys the positive-semidefinite form and returns to the
indefinite class.
