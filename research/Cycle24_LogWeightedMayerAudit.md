# Cycle 24: logarithmically weighted Mayer branches

## Motivation

The missing P2 mechanism is the von Mangoldt weight. The most direct Mayer
experiment is therefore

`(L_X^log(s)f)(x)=sum_{n=1}^X log(n)(x+n)^(-2s)f(1/(x+n))`.

At a superficial level this looks promising because `log(n)` is the desired
prime-power logarithm. The decisive question is whether the trace of the
operator or its trace powers become `-zeta'/zeta`.

## Raw Nyström output

An 80-point midpoint/linear-interpolation discretization at `s=1.5` gave:

```text
X=20:  trace(L)       0.001585844186587085
       sum log(n)n^-3 0.19393965368700516
       ratio           0.008176998135442912
       tr(L^2)         3.3772748108638467e-06
       tr(L^3)         6.021402766171633e-09
       |det(I-L)|      0.9984137246329743

X=50:  trace(L)       0.0016271184865734147
       sum log(n)n^-3 0.19725934324566632
       ratio           0.008248625691443195
       tr(L^2)         3.565919816638513e-06
       tr(L^3)         6.527709994190819e-09
       |det(I-L)|      0.9983724223180168

X=100: trace(L)       0.0016347852359916521
       sum log(n)n^-3 0.1978732762821567
       ratio           0.008261778784420267
       tr(L^2)         3.6026475229642766e-06
       tr(L^3)         6.627358396504276e-09
       |det(I-L)|      0.9983647497091224
```

## Structural diagnosis

The Mayer trace is not the one-step branch sum. Its trace is a sum over fixed
points of all inverse-branch compositions. Consequently, putting `log(n)` on
each branch produces orbit weights

`log(n_1)+...+log(n_k)=log(n_1...n_k)`,

but the fixed-point Jacobian and continued-fraction denominator remain. This
does not turn the trace into the Dirichlet series

`sum Lambda(m)m^(-s)=-zeta'(s)/zeta(s)`.

The numerical trace is about 0.8% of the naive Dirichlet sum and stabilizes at
that scale as `X` grows. Higher traces are also tiny, so the resulting
Fredholm determinant remains close to 1 and shows no reason to have zeta zeros.

## P1--P6

| Property | Status |
|---|---|
| P1 | fails in this finite test; determinant remains near 1 |
| P2 | fails; branch logs become continued-fraction orbit logs, not Lambda coefficients |
| P3 | unproved and log weights are nonnegative but not a coercivity argument |
| P4 | absent |
| P5 | yes |
| P6 | plausible for fixed bounded truncation, but the unbounded log weight needs a theorem |

## Verdict

**DEAD as a direct branch-log insertion.** This is a sharper obstruction than
the bounded-sign test: even the correct-looking local factor `log(n)` does not
produce the desired arithmetic trace because Mayer's periodic-orbit geometry
intervenes. The required construction must align the periodic-orbit product
with integer prime powers, or explicitly add a derivative/parameter direction
whose determinant derivative is `-zeta'/zeta`.
