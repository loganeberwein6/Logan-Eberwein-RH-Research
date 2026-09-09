# SR definition repair log

## Current mismatch

`SR_HalfWeightedSum` used literal `log(m) log(n)`, while `SR_S2` and
`SR_S3` used von Mangoldt weights. Cauchy–Schwarz cannot mix these.

## Option A — logarithmic branch

Define all three quantities from `w(m,n) = log(m) log(n)` with the same
square-root and reciprocal-product factors. This is the smallest branch on
which a direct finite Cauchy–Schwarz proof can be stated.

## Option B — von-Mangoldt branch

Replace the unsigned and signed weighted sums by
`w(m,n) = Lambda(m) Lambda(n)`. This preserves the intended arithmetic
meaning and makes the Cauchy step compatible with `S2` and `S3`.

Current priority: formalize Option A as a clean finite inequality, then
compare its ratio with the Option B certificates.
