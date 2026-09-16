# Cycle 9: prime-loop / Euler-product operator

## Construction

Take the diagonal operator on `ell^2` indexed by primes,

\[
 T_s e_p=p^{-s}e_p.
\]

Its finite Fredholm determinant is

\[
 D_X(s)=\prod_{p\le X}(1-p^{-s}),
\]

and the limit is `1/zeta(s)` for `Re(s)>1`.

The logarithmic derivative recovers the von Mangoldt weights only after taking
the logarithm and differentiating:

\[
 -\frac{d}{ds}\log D(s)=\sum_{p,k\ge1}(\log p)p^{-ks}
 =\sum_{n\ge2}\Lambda(n)n^{-s}.
\]

Thus this is the exact Euler-product baseline, not a new RH proof mechanism.

## Raw finite determinants

```text
X=20:  det(1.5)=0.4168216955954319  det(2.0)=0.6142335411190185
  critical abs: [0.0125411810792, 8.12407432899, 3.57015512207,
                 3.74043432072, 4.75811085537, 4.12370698944]
X=50:  det(1.5)=0.4019735475452824  det(2.0)=0.6102889977846371
  critical abs: [0.00338465854772, 9.74862529639, 5.26804248707,
                 5.77084561852, 5.70522006363, 4.41376016691]
X=100: det(1.5)=0.3951995710769300  det(2.0)=0.6090337253995167
  critical abs: [0.000959990614661, 8.68060840714, 5.75261637666,
                 5.28639524012, 5.82375536151, 4.68983878031]
```

The entries in each critical-line list correspond to
`t = 0.001, 14.1347, 21.0220, 25.0109, 30.4249, 32.9351`.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | yes in the determinant sense | the infinite determinant is `1/zeta(s)` and vanishes at zeta zeros |
| P2 | yes after log differentiation | prime powers appear with weight `Lambda(p^k)=log p` |
| P3 | no | the construction is diagonal arithmetic data; it supplies no positivity implication for zero locations beyond ordinary positive spectrum |
| P4 | no | `p^{-s}` has no built-in `s -> 1-s` symmetry |
| P5 | yes | primes are intrinsic indices |
| P6 | partial | trace class only for `Re(s)>1`; the determinant has continuation through the zeta quotient, but the operator itself is not trace class on the whole half-plane `Re(s)>1/2` |

## Verdict

**DEAD as a proof of RH, but algebraically exact for P1/P2.**  This cycle
confirms that the Euler product already gives the required determinant and
prime-power weights trivially.  The missing content is precisely a canonical
positivity/functional-equation mechanism that is not circular.  Adding SR
off-diagonal terms changes the determinant, as recorded in the earlier audit;
leaving the operator diagonal leaves P3 and P4 absent.
