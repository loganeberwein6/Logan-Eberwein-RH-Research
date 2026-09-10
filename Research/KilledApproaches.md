# Killed approaches

## DEAD-01: Original B3 with `psi2(X)/X^2`

The statement is numerically false at `X=6`, `c=3/4`.

## DEAD-02: Mixed log/von-Mangoldt Cauchy–Schwarz

The proposed left and right sides use different weight vectors.

## DEAD-03: Standalone SR mollifier

Recorded `kappa_SR` decreases from approximately `0.7626` at `X=6` to
`0.2242` at `X=2310`; no uniform 75% consequence follows.

## DEAD-04: Direct scalar mollifier interpretation

The finite Rees kernel is a two-variable matrix object, not automatically a
scalar analytic mollifier with the required zero-density interpretation.

## DEAD-05: Weyl `pos(J-2A) ≤ 1`

The interior matrix `A_X` is not positive semidefinite for all cutoffs, so the
proposed Weyl shortcut does not apply universally.
The earlier planning note claiming `N_int(30)=60` is inconsistent with the current definition `2 ≤ m,n < X` and `m*n < X`; direct enumeration gives `N_int(30)=46`. Any asymptotic inference based on the value 60 is discarded.
## Stage 30 Conrey exponent and stale numerical baseline

The proposed Conrey exponent is not supported by recomputation from the
current Lean definition.  More fundamentally, the earlier Stage 29 Q-table
does not reproduce by direct finite enumeration at X=6,30,110.  Any growth
claim based on that table is suspended until the implementation discrepancy
is identified.

## Conrey 2/5 exponent as SR growth law — KILLED (Stage 31)

The proposed exponent `3/2 + (2/5)(beta-1/2)` is numerically refuted for
the exact implementation. The earlier computation used `cos(gamma log(mn))`,
while Lean uses `cos(gamma log m) * cos(gamma log n)`, which splits into ratio
and product channels. At beta=0.8, gamma=21.022, the observed total slope is
2.850 rather than the predicted 1.620.

## Diagonal equals reesTrace — KILLED (Stage 31)

`reesTrace` uses the cutoff `2m < X`, while the ratio-channel diagonal uses
`m*m < X`. They differ: at X=30 the diagonal sign sum is 20 while
`reesTrace 30 = 2`.
