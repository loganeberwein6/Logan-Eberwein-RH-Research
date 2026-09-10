# Stage 34 — off-diagonal bound audit

## Result

The requested row bound is false and therefore cannot be used to prove the
requested off-diagonal estimate.

The proposed claim was

```text
|RowSum_m| ≤ (X / m)^beta / beta
```

For `m = X - 1`, every support index `n ≥ 2` satisfies `m*n ≥ X`, so the row
has no negative entries. It is a positive power sum of size roughly
`X^(beta + 1/2)`, while the proposed right side is approximately `1/beta`.

## Exact numerical counterexamples

| X | m | beta | row sum | proposed bound | ratio |
|---:|---:|---:|---:|---:|---:|
| 6 | 5 | .5 | 4.000000 | 2.190890 | 1.826 |
| 100 | 99 | .8 | 302.952931 | 1.260091 | 240.421 |
| 1000 | 999 | .8 | 6104.951934 | 1.251001 | 4880.054 |

The first case has its row value encoded as
`SR_row_sum_half_counterexample` in `SR_Stage34.lean` and is checked by Lean
without `sorry`, `admit`, `axiom`, or `unsafe`. The real right side is the
elementary value `2*sqrt(6/5) = 2.190890...`, which is less than the certified
row value `4`.

## Consequences

The proposed row-sum proof of

```text
|Q_ratio_offdiag| ≤ 2 X^(beta + 1/2) / beta
```

fails at its key premise. The diagonal bound remains proved, but it does not
control arbitrary row sums. A valid off-diagonal theorem needs cancellation,
row restrictions, or a different norm estimate.

The finite-range growth-law conjecture is therefore still open; the claimed
`O(X^(beta + 1/2))` off-diagonal estimate is not established.
