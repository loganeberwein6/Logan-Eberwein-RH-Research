# Candidate S: rank-one Mayer--SR perturbation

## Definition

Let `L_s` be the nuclear Mayer operator and let `u_X,v_X` be arithmetic
vectors/functionals derived from the SR support. Define

`T_X(s) = L_s + u_X tensor v_X`.

This is the smallest non-similar perturbation that can change the determinant
while retaining an exact determinant formula.

## Exact determinant reduction

Whenever `I-L_s` is invertible, the Fredholm determinant lemma gives

\[
 \det_F(I-T_X(s))
 =\det_F(I-L_s)\left(1-
 \langle v_X,(I-L_s)^{-1}u_X\rangle\right).
\]

Thus the entire new arithmetic content is concentrated in the scalar resolvent
function

\[
 r_X(s)=\langle v_X,(I-L_s)^{-1}u_X\rangle.
\]

To obtain the required determinant, one would have to prove an identity of the
form

\[
 \frac{\zeta(2s)}{\zeta(2s-1)}
 \frac{1}{\zeta(s)}
 =1-r_X(s)
\]

up to a known nonvanishing entire factor, with a convergent limit as
`X -> infinity`. No such identity is currently known for SR-derived vectors.

## P1--P6 status

| Property | Status | Reason |
|---|---|---|
| P1 | possible in principle | rank-one factor can move determinant zeros, but only if the resolvent identity is proved |
| P2 | unproved | SR vectors do not currently produce the von Mangoldt logarithmic derivative |
| P3 | unproved | rank-one perturbation can create or destroy lower bounds |
| P4 | unproved | `u_X,v_X` must satisfy a compatible involution under `s -> 1-s` |
| P5 | possible | vectors can be built from finite arithmetic data |
| P6 | conditional | nuclearity survives finite-rank perturbation, but convergence of the vectors and resolvent factor is missing |

## Required next calculation

Choose an explicit finite SR vector pair, compute the scalar factor
`1-r_X(s)` for `X=20,50,100`, and test its critical-line minima against the
first five zeta ordinates. This is the first post-Mayer class whose determinant
can change without abandoning a Fredholm framework.

## Verdict

**OPEN/PROMISING CLASS, not a solution.** Unlike sign conjugation, this class
can alter P1. The decisive obstruction is now sharply isolated as a scalar
resolvent identity, which must be computed and either discovered or ruled out.

## Arithmetic diagonal control probe

As a control, I used the finite diagonal base `D_X(s)=diag(n^{-s})` and the
normalized SR boundary-flip vector
`u_X(n)=(max(d(n)-2,0))/||max(d(n)-2,0)||`, where `d(n)` is the divisor count.
The determinant-lemma probe `det(I-D_X-u_X u_X^*)` gave:

```text
X=20:  |det(1.5)|=0.00647183, |det(2)|=0.00380483,
       |det(1/2+14.1347i)|=0.10308127
X=50:  |det(1.5)|=0.00188498, |det(2)|=0.00099207,
       |det(1/2+14.1347i)|=0.05817977
X=100: |det(1.5)|=0.00075804, |det(2)|=0.00036138,
       |det(1/2+14.1347i)|=0.01811689
```

Scanning `0 <= t <= 40` finds the smallest values at `t=0` and numerical
underflow near zero, not at the first nontrivial ordinate. This control is not
the Mayer function-space operator, but it shows that an SR flip vector alone
does not generate zeta-zero specificity; the unresolved quantity is genuinely
the Mayer resolvent factor.

## Nyström Mayer-resolvent probe

I then tested the actual Mayer operator rather than the diagonal control. On a
60-point uniform grid on `[0,1]`, each row approximated

`(L_s f)(x)=sum_{n=1}^X (x+n)^(-2s) f(1/(x+n))`

using linear interpolation and quadrature weight `1/60`. The rank-one pair was
the normalized constant vector and the normalized arithmetic sign functional
`h(y)=sum_{n=2}^{X-1} sign(n*floor(1/y)-X)`, with `h(0)=0`. The determinant was
evaluated by the finite-dimensional determinant lemma.

```text
X=20: |det(1.5)|=1.286371276963284
      |det(2)|=1.2887495227936475
      |det(1/2+14.1347i)|=1.2970773423475501
      scan minima: t=0      1.245818
                   t=0.25   1.263156
                   t=39.25  1.268822
                   t=21.00  1.270481
                   t=32.75  1.271262

X=50: |det(1.5)|=1.341074340511415
      |det(2)|=1.3434309563213225
      |det(1/2+14.1347i)| approximately 1.35141
      scan minima: t=0      1.285279
                   t=0.25   1.320820
                   t=39.25  1.321530
                   t=21.00  1.324349
                   t=13.25  1.324530
```

This canonical pair has no distinguished minimum at `14.1347`. It is not a
no-go theorem for every possible pair `(u_X,v_X)`: the pair was deliberately
simple and the discretization is exploratory. It does rule out the immediate
claim that inserting the natural SR sign functional into the Mayer resolvent
automatically exposes the first zeta ordinate.
