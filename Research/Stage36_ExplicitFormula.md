# Stage 36 — Cancellation and explicit-formula audit

## Verified formal state

`SR_Stage36.lean` defines the product-channel divisor-fiber target,
records the divisor reorganization as a precisely named conjectural
proposition, and records formal conjecture wrappers for explicit-formula
growth and logarithmic equidistribution. It also certifies
`SR_gram_entry 30 5 7 = 26` by `native_decide`.

## Numerical results

For `beta=0.8, gamma=21.022`, the exact values at `X=30,100,210,500,1000`
are `-19.4700, 29.8622, 1227.8586, 22676.6135, 63591.7390`.
The proposed single-term explicit-formula ratios are respectively unstable;
there is no numerical proof of a fixed coefficient.

For `X=10,30,100`, the largest Gram eigenvalue of `M^T M` is approximately
`48.8486, 667.4494, 8857.7833`, with operator norms `6.9892, 25.8350,
94.1158`. These disprove the suggested `sqrt(X)`-scale heuristic.

## Open status

The finite divisor-fiber identity, Perron/explicit-formula bridge, Weyl-type
logarithmic equidistribution, and RH equivalence remain unproved. The current
formal conjectures are deliberately not mathematical proofs of those claims.
