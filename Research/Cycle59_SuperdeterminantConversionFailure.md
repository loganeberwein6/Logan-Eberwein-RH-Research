# Cycle 59: superdeterminant conversion test

## Candidate

Let the bosonic sector contain two prime loops and a mixed coupling:

`B=[[a,u],[v,b]]`.

The naive fermionic ghost sector contains only the mixed two-cycle:

`F=[[0,u],[v,0]]`.

The proposed graded determinant is `det(I-B)/det(I-F)`.

## Raw checks

```text
(a,b,u,v)=(.2,.3,.1,.2):
  boson=.54, ghost=.98, ratio=.5510204, prime target=.56

(a,b,u,v)=(.4,.25,.2,-.1):
  boson=.47, ghost=1.02, ratio=.4607843, prime target=.45
```

The naive ghost does not cancel the mixed cycle: the bosonic correction is
`uv` multiplied by complementary loop factors, whereas the ghost removes
`uv` directly.

An exact ghost would require a factor depending on
`uv/((1-a)(1-b))`, which is already a tuned Schur-complement normalization and
not an independent arithmetic sector.

## P1--P6 assessment

| Property | Status |
|---|---|
| P1/P2 | can be arranged formally through a graded Euler product |
| P3 | not ordinary positivity; ghost sector has indefinite metric |
| P4 | can be imposed by pairing `s` and `1-s` sectors |
| P5 | possible in principle |
| P6 | requires two separately nuclear graded sectors |
| ordinary Fredholm requirement | not met by a superdeterminant ratio |

## Verdict

**The naive supersymmetric cancellation fails.** Exact cancellation would need
a dynamically defined ghost sector whose weights include complementary loop
resolvents. That is equivalent to constructing the missing integrable identity,
not a free solution. The superdeterminant route remains a framework, not a
constructed operator.
