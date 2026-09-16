# Cycle 62: divisor-complex supertrace

## Analytic object

Assign the weight `n^(-s)` to the divisor-poset complex `P_n` and take its
graded Euler index. Since `chi_tilde(P_n)=mu(n)`, the total supertrace is

`M_X(s)=sum_{n<=X} mu(n)n^(-s)`.

In `Re(s)>1`, the infinite limit is exactly

`sum mu(n)n^(-s)=1/zeta(s)`.

## Raw finite convergence

```text
s=1.5, target .382793383999:
 X=20   .371440323284   error .011353061
 X=50   .379869358133   error .002924026
 X=500  .382401429735   error .000391954
 X=2000 .382865431800   error .000072048

s=2, target .607927101854:
 X=20   .605393075374   error .002534027
 X=500  .607909113755   error .000017988
 X=2000 .607928662330   error .000001560

s=.5+14.1347i:
 target 7884.5558+49523.2415i
 X=20   4.3570-.6785i
 X=2000 10.1555-1.4541i
```

The supertrace converges normally in the Euler-product half-plane, but finite
partial sums do not approximate the critical-strip continuation.

## Operator gap

This is a supertrace/Dirichlet-series identity, not a Fredholm determinant.
To obtain an operator, one needs a trace-class complex whose graded trace
reproduces the divisor-poset index and whose determinant or regularized
superdeterminant analytically continues through the critical strip. The
critical-line output demonstrates that finite truncation alone cannot provide
that continuation.

## Verdict

**Exact P2 arithmetic index, partial P1 framework.** The divisor complex
naturally produces `1/zeta` as a supertrace in `Re(s)>1`, but no nuclear,
completed, positive/coercive operator has yet been constructed.
