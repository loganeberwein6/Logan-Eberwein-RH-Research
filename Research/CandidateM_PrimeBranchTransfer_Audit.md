# Cycle 14: prime-branch transfer operator

## Construction

The minimal prime-indexed transfer model has one state and one branch for
each prime `p <= X`, with branch weight `p^{-s}`.  Its finite operator is the
rank-one scalar

\[
 T_{X,s}f=\left(\sum_{p\le X}p^{-s}\right)f,
\]

so

\[
 \det(I-T_{X,s})=1-\sum_{p\le X}p^{-s}.
\]

This is the exact finite-state reduction of a prime-branch construction.  It
is not the Euler product, which would require a product of independent prime
loops.

## Raw output

```text
X=20: det1.5=0.2354728169134714 det2.0=0.558068812335402
  critical abs=[2.1604490508, 3.37019707515, 2.32166477668,
                2.06220922868, 2.54346236754, 2.44109234143]

X=50: det1.5=0.1993076450264958 det2.0=0.5516299392020786
  critical abs=[3.3531999691, 3.57209431954, 2.76335686246,
                2.50445334070, 2.78875507604, 2.57175283632]

X=100: det1.5=0.1823277475838550 det2.0=0.5495712117362475
  critical abs=[4.53648165567, 3.44849205632, 2.83975197724,
                2.39954076762, 2.76315112397, 2.62905350031]
```

The critical entries correspond to `t=0.001, 14.1347, 21.022, 25.0109,
30.4249, 32.9351`.

## Exact combinatorial failure

The Euler product has logarithm

\[
\log\prod_p(1-p^{-s})^{-1}
 =\sum_{p,k\ge1}\frac{p^{-ks}}k.
\]

A single rank-one prime-branch state instead has

\[
 -\log(1-\sum_pp^{-s})
 =\sum_{k\ge1}\frac1k\left(\sum_pp^{-s}\right)^k,
\]

whose terms mix distinct primes inside each power.  It therefore does not
encode independent prime powers and cannot yield `Lambda(p^k)` correctly.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | no | determinant is `1 - prime sum`, not `1/zeta` |
| P2 | no | powers mix distinct primes rather than producing individual prime powers |
| P3 | trivial finite positivity only | scalar positivity gives no RH-relevant coercive form |
| P4 | no | no completed-zeta symmetry |
| P5 | yes | prime-indexed arithmetic branches |
| P6 | no for the required half-plane | the prime sum has abscissa 1 |

## Verdict

**DEAD.** Prime labels alone are insufficient.  The Euler product requires
independent prime loops, while a transfer-state sum mixes branches.  Adding
the independent loops returns to the prime diagonal operator, which has the
already-documented missing positivity and functional equation.
