# Stage 35 — Correct off-diagonal structure

## Formal results

`SR_row_sum_trivial_bound` proves the genuine triangle-inequality row bound.
`SR_off_diagonal_trivial_bound` proves the corresponding square-of-weight-sum
bound. `SR_gram_entry` defines the integer Gram entry, with certified examples
`SR_gram_entry 6 5 5 = 4` and `SR_gram_entry 6 2 5 = 2`.

## Numerical audit

At `X=210`: total `1227.8586`, diagonal `3145.2677`, off-diagonal
`-1917.4090`; normalized values are `0.605490`, `-0.369117`, and `0.236373`.
Near/far splits at cutoffs `30,100,210,500` show both pieces can be large and
change sign, so negligible off-diagonal behavior is not established.

## Status

The Stage 34 pointwise row bound is disproved. The trivial absolute-value
bounds are proved. Stronger cancellation, Euler–Maclaurin, product-channel
asymptotics, equidistribution, Weil identities, and RH consequences remain
open conjectural targets.
