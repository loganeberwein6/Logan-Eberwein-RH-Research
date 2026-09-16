# Cycle 93 — Finite Arithmetic Weil Operator Built

## Artifact

Implemented:

`Research/finite_arithmetic_weil_operator.py`

The matrix uses only:

- arithmetic factorization to compute `Lambda(k)`;
- logarithmic prime-power locations `log(k)`;
- Fourier test functions on a symmetric interval;
- `pi`, Euler's constant, and `log(4*pi)` from the standard archimedean normalization;
- the finite Fourier cutoff and scale interval.

No zeta-zero heights and no fitted numerical constants are used.

## Construction in plain terms

Each matrix entry combines three fixed ingredients:

1. a boundary term from the finite test interval;
2. a prime-power sum weighted by `Lambda(k)`;
3. an archimedean gamma-factor integral.

The result is a finite real symmetric matrix acting on Fourier-mode coefficient vectors.

## Raw output

```text
scale= 1.5 cutoff= 2
  dimension= 5
  min_eigenvalue= 0.0003218473192618901
  max_eigenvalue= 0.997031758577138
  condition_proxy= 3097.84080496207

scale= 2.0 cutoff= 2
  dimension= 5
  min_eigenvalue= 9.740215549831897e-7
  max_eigenvalue= 0.3900323580537683
  condition_proxy= 400435.0376624876

scale= 2.0 cutoff= 4
  dimension= 9
  min_eigenvalue= 1.699535649045168e-9
  max_eigenvalue= 1.810935873500498
  condition_proxy= 1065547447.926683
```

## Status

The finite samples are positive and symmetric, but the condition number worsens dramatically with cutoff. This is consistent with the earlier Candidate-Q audit and means that positivity alone is not evidence of a convergent operator. The next required tests are symmetry verification, cutoff convergence, scale stability, and comparison against held-out zero data only after the arithmetic-only baseline is fixed.

## P1–P6

| Property | Status |
|---|---|
| P1 | Not established; no determinant/zero theorem. |
| P2 | Built in directly through Lambda prime-power weights. |
| P3 | Finite numerical positivity observed, no general proof. |
| P4 | Fourier interval is symmetric; completed operator involution not proved. |
| P5 | Yes at finite level; all inputs are arithmetic or canonical analytic normalizations. |
| P6 | Not established; conditioning worsens with cutoff. |

## Verdict

**Built / promising but incomplete.** This is the first finite operator artifact in the current branch assembled solely from the prescribed structural rules without fitting zero heights.
