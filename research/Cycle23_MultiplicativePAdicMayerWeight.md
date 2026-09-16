# Cycle 23: multiplicative 2-adic Mayer weight

## Construction

To preserve branch multiplicativity, I tested the Mayer operator with the
branch weight

`a(n)=(-1)^(v_2(n))`.

This is arithmetic, bounded, and completely multiplicative on the powers of
2 while leaving odd factors unchanged. The discretization was the same
60-point midpoint/linear-interpolation Nyström scheme used in Cycle 22.

## Raw numerical output

```text
X=20
 |det(I-T(1.5))|                  0.9978264470420778
 |det(I-T(2))|                    0.9987171573838515
 |det(I-T(1/2+14.1347i))|         1.010495809187442
 minima: (12.75,.97464764), (13.00,.97624054),
         (26.50,.97785747), (26.75,.98046625), (0,.98322770)
 top eigenvalue magnitudes: .00369731, .00158005, .00064202,
   .00062080, .00053407, .00053407, .00050622, .00050622

X=50
 |det(I-T(1.5))|                  0.9978226019905819
 |det(I-T(2))|                    0.9987170220709285
 |det(I-T(1/2+14.1347i))|         1.0088188327739531
 minima: (13.00,.97568011), (12.75,.97746830),
         (26.50,.97795145), (34.00,.97932649), (0,.97939338)
 top eigenvalue magnitudes: .00370618, .00158782, .00064595,
   .00062273, .00053510, .00053510, .00050710, .00050710
```

## Exact arithmetic diagnosis

The one-branch Dirichlet series is explicit. For `q=2s`,

`sum_{n>=1} a(n)n^(-q) = zeta(q)(1-2^(-q))/(1+2^(-q))`.

Thus the weight changes the arithmetic Euler factor at `2`; it does not
produce `1/zeta(s)` or the von Mangoldt logarithmic derivative. The repeated
critical-line minima near `12.75--13.00` are therefore a finite numerical
feature of this modified transfer operator, not evidence for the first zeta
ordinate `14.1347`. They also do not converge to it between `X=20` and `50`.

## P1--P6

| Property | Status |
|---|---|
| P1 | fails: no zero-specific determinant identity |
| P2 | fails: weight changes one Euler factor, not Lambda prime-power logs |
| P3 | unproved |
| P4 | not supplied |
| P5 | yes |
| P6 | finite discretization only; Mayer nuclearity may persist for bounded weights |

## Verdict

**DEAD as a one-branch multiplicative weight.** The experiment is useful because
it separates two ideas: arithmetic multiplicativity can be added without
destroying numerical compactness, but a bounded multiplicative weight merely
replaces the Euler factor. To obtain `-zeta'/zeta`, the operator needs an
intrinsic logarithmic/prime-power mechanism, not just a bounded p-adic sign.
