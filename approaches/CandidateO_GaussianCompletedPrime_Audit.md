# Cycle 16: Gaussian-regularized reflected prime spectrum

## Construction

Introduce Gaussian damping in logarithmic prime coordinates:

\[
 \lambda_p^{(\epsilon)}(s)
 =p^{-s}e^{-\epsilon(\log p)^2},
 \qquad
 \widetilde\lambda_p^{(\epsilon)}(s)
 =p^{-(1-s)}e^{-\epsilon(\log p)^2}.
\]

The doubled determinant is

\[
 D_{X,\epsilon}(s)=
 \prod_{p\le X}
 (1-\lambda_p^{(\epsilon)}(s))
 (1-\widetilde\lambda_p^{(\epsilon)}(s)).
\]

For every fixed epsilon>0, both blocks are absolutely summable for every
complex s, and the construction has formal s <-> 1-s symmetry.

## Raw output

eps=0.5
 X=20:  d1.5=-0.00052804674869  d2=0.000554108986623
  abs at t=[14.1347,21.022,25.0109] = [5.4082081, 3.2563685, 2.4254553]
 X=100: d1.5=-0.000474707178381 d2=0.000294008100438
  abs = [5.4001999, 3.2699556, 2.4367249]

eps=0.1
 X=20:  d1.5=0.0275753503207 d2=14560.84044
  abs = [24.411179, 8.722999, 7.02326]
 X=100: d1.5=-4.06289894798e-8 d2=-1.00847906915e+21
  abs = [24.912903, 11.854972, 9.2352257]

eps=0.02
 X=20:  d1.5=5.48800246746 d2=447175.220543
  abs = [51.702196, 11.804549, 11.765102]
 X=100: d1.5=-3.05089079000e+11 d2=-2.85304314888e+32
  abs = [57.045402, 25.151549, 20.975585]

## Exact regularization tradeoff

For epsilon>0, damping changes every Euler factor from
1-p^{-s} to 1-p^{-s} exp(-epsilon(log p)^2). Therefore the determinant is
not 1/zeta(s) or its completed symmetric version. As epsilon tends to zero,
the reflected block loses absolute summability by the direct-sum theorem, so
the limit is not a trace-class operator limit.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | no | damping changes the Euler factors and zero set |
| P2 | no exact identity | logarithmic differentiation gives damped prime-power weights |
| P3 | partial | diagonal positivity for suitable real parameters, but no RH coercive form |
| P4 | yes formally | the two damped blocks exchange under s -> 1-s |
| P5 | yes | prime arithmetic |
| P6 | yes for fixed epsilon | Gaussian damping gives absolute summability |

## Verdict

**DEAD.** Regularization restores nuclearity only by changing the arithmetic
determinant. Removing the regulator restores the original divergence. This
shows that the missing completion cannot be an arbitrary damping factor; it
must arise from an exact arithmetic/analytic identity that preserves Euler
factors while changing the operator realization.
