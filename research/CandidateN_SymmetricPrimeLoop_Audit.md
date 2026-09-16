# Cycle 15: symmetric prime-loop operator

## Construction

Double the exact prime diagonal with its functional-equation partner:

\[
 T_s=\operatorname{diag}\bigl((p^{-s})_{p},(p^{-(1-s)})_{p}\bigr).
\]

The finite determinant is

\[
 D_X(s)=\prod_{p\le X}(1-p^{-s})(1-p^{-(1-s)}),
\]

which is exactly invariant under `s -> 1-s`.

## Raw output

```text
X=20:
  det(1.5)=1.628026065440847e+01  det(2.0)=1.018939736691517e+06
  critical abs=[1.57281222861e-04, 66.0005837029, 12.7460075956,
                13.9908489076, 22.6396189120, 17.0049593347]

X=50:
  det(1.5)=-1.066841607114116e+06 det(2.0)=-5.205016287748833e+16
  critical abs=[1.14559134847e-05, 95.0356951693, 27.7522716456,
                33.3026591528, 32.5495359745, 19.4812788110]

X=100:
  det(1.5)=-5.760436210309719e+14 det(2.0)=-1.689457668858778e+35
  critical abs=[9.21581980238e-07, 75.3529623181, 33.0925951770,
                27.9459746347, 33.9161265107, 21.9945877853]
```

The critical entries correspond to `t=0.001, 14.1347, 21.022, 25.0109,
30.4249, 32.9351`.

## Exact convergence obstruction

For `Re(s)>1/2`, the partner eigenvalues satisfy

\[
 |p^{-(1-s)}|=p^{\Re(s)-1},
\]

whose prime sum diverges because `Re(s)-1 > -1/2` throughout the target
region.  In particular, at `s=3/2`, the partner eigenvalues are `p^{1/2}`.
Thus the second block is not compact or trace class, and the finite
determinants cannot converge to a Fredholm determinant.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | yes formally | zeros of both `1/zeta(s)` and `1/zeta(1-s)` occur |
| P2 | yes formally | logarithmic differentiation gives both prime-power series |
| P3 | partial | positive diagonal for real `s` outside the strip, but no RH-relevant coercive form on the critical line |
| P4 | yes | blocks exchange under `s -> 1-s` |
| P5 | yes | prime arithmetic |
| P6 | no | the reflected block is not trace class for `Re(s)>1/2` |

## Verdict

**DEAD.** This is the closest algebraic near-miss so far: it has the Euler
determinant and the functional involution, but the reflected Euler block is
necessarily non-nuclear in the half-plane required by the objective.  A
successful construction must encode the functional equation through a
regularized or completed operator, not by directly adjoining the reflected
prime spectrum.
