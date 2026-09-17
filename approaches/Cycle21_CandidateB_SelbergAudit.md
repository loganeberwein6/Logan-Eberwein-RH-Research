# Cycle 21: finite Selberg-zeta analogue

## Definition

\[
 Z_X(s)=\prod_{p\le X}\prod_{k=0}^{\lfloor\log_pX\rfloor}
 \left(1-p^{-(s+k)}\right).
\]

Equivalently, each prime contributes a finite string of Euler factors. As
`X` increases, every fixed prime-power factor eventually appears, so the
limit in its half-plane of absolute convergence is the ordinary Euler product
`1/zeta(s)`.

## Raw values

```text
X=20:  Z_X(1.5)=0.2594910363   Z_X(2)=0.4513022459
X=50:  Z_X(1.5)=0.2442851999   Z_X(2)=0.4420825806
X=100: Z_X(1.5)=0.2382143937   Z_X(2)=0.4388335463
```

At the first zeta ordinate,

```text
|Z_20(1/2+14.1347i)| = 20.7827
|Z_50(1/2+14.1347i)| = 26.5336
|Z_100(1/2+14.1347i)| = 23.9912
```

There is no dip at the zeta zero. The finite product has unrelated periodic
zeros, for example the `p=2,k=0` factor vanishes at
`s = 2*pi*i*j/log(2)`, including a zero at approximately `28.53i`, not at
`14.1347i`.

## P1--P6 audit

| Property | Status | Reason |
|---|---|---|
| P1 | fail for RH zeros | its zeros are explicit Euler-factor lattices, not zeta zeros |
| P2 | yes algebraically | logarithmic derivative recovers prime-power weights in the infinite Euler product |
| P3 | not applicable | no canonical positive quadratic form is supplied |
| P4 | partial/fail | the Euler product has no completed-zeta `s <-> 1-s` symmetry by itself |
| P5 | yes | finite prime arithmetic construction |
| P6 | partial | converges to `1/zeta(s)` only in its ordinary half-plane; this is not analytic continuation through the critical strip |

## Verdict

**DEAD for the requested operator.** This is an exact arithmetic model of
`1/zeta` in `Re(s)>1`, but it is circular for RH and its finite zeros do not
track the nontrivial zeta zeros. Adding SR interactions would have to preserve
the exact Euler product; previous tests show that generic off-diagonal
interactions destroy it.
