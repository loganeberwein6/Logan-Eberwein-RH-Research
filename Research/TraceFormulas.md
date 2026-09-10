# Rees trace formulas

Exact integer matrix computations for the complete-support Rees matrices give:

| X | dimension | Tr(M) | Tr(M^2) | Tr(M^3) |
|---:|---:|---:|---:|---:|
| 6 | 4 | 2 | 16 | 44 |
| 30 | 28 | 20 | 784 | 16760 |
| 210 | 208 | 182 | 43264 | 8332652 |

The identity `Tr(M^2) = (X-2)^2` holds because the matrix is symmetric and
every entry is ±1.  `Tr(M)` counts diagonal signs and equals

```text
(X-2) - 2 * #{m in [2,X): m^2 < X}.
```

`Tr(M^3)` counts signed arithmetic triangles
`M(m,n) M(n,p) M(p,m)`.  It is not equal to the all-ones entry sum, which is
a different contraction `Tr(M J)`.

The trace data alone do not expose von Mangoldt weights; a weighted diagonal
or weighted all-ones contraction is needed for a direct `psi2` connection.

## Stage 26 trace update (2026-09-09)
The certified trace observable reesTrace X = (X-2) - 2*belowHalfSupportCount X satisfies reesTrace X = 2 for even X and 1 for odd X, for all X ≥ 6. The explicit X=6..20 table was Lean-verified.
## Stage 29 phase fit

For `gamma = 21.022` and `X = [30,42,66,80,110,150,210,300,500]`,
least-squares fitting of `Q_X / X^(3 beta)` to `A cos(gamma log X + phi)`
gave:

| beta | amplitude | phase | phase/pi |
|---:|---:|---:|---:|
| 0.5 | 0.05434821 | 1.32206500 | 0.42082636 |
| 0.6 | 0.02660567 | 1.31881852 | 0.41979297 |
| 0.7 | 0.01345457 | 1.32867222 | 0.42292950 |
| 0.8 | 0.00699287 | 1.35170173 | 0.43026002 |
| 0.9 | 0.00371805 | 1.38765446 | 0.44170413 |

The fitted phase is approximately stable while the amplitude decreases
with beta. This is empirical only; no asymptotic theorem is asserted.
## Explicit-formula phase correction test

For the prediction `X^(3 beta) * Re(X^(i gamma)/(beta+1+i gamma))`,
the measured/predicted ratios were:

```text
beta=0.8: -0.1883, -0.1632, -0.1217, -0.1698  (X=30,110,210,500)
beta=0.6: -0.8683, -0.5578, -0.4719, -0.6674
beta=0.5: -1.7927, -1.0883, -0.9958, -1.4056
```

The ratio is not constant across beta, so this single explicit-formula
term is not the complete coefficient or phase law.
## Phase decomposition invariant

The Lean theorem `SR_log_cos_product_split` proves that each SR summand
contains both frequencies `gamma(log m + log n)` and
`gamma(log m - log n)`. Hence a single series in `(m n)^(beta-1/2+i gamma)`
cannot represent the real SR form; the difference-frequency component must
be retained in any exact asymptotic formula.
2026-09-09 — Re-tested the naive explicit-formula coefficient X^(3β)·Re[X^(iγ)/(β+1+iγ)]. Ratios vary substantially across X (β=.8: −.324, −.182, .011, −.160 for X=30,110,210,500), so this coefficient alone is not the exact SR phase law. The sum/difference phase channels remain necessary.

2026-09-09 — Two-frequency least-squares fit of Q/X^(3β) against cos(γ log X), sin(γ log X), cos(2γ log X), sin(2γ log X), and a constant gives residual norms 0.0169, 0.0081, 0.0039, 0.0018, 0.0008 for β=.5,.6,.7,.8,.9. The decreasing residual supports a finite phase-channel model, but does not establish an asymptotic theorem.
2026-09-09 — Computed the normalized square-weight envelope `(Σ_{2≤m<X} m^(β−1/2))² / X^(2β+1)`: for β=.5 it approaches 1 (0.871, 0.964, 0.981, 0.992 at X=30,110,210,500); for β=.8 it approaches ≈0.59. This confirms the unconditional square envelope has leading scale X^(2β+1), so any X^(3β) law must come from cancellation.
| `N_int(X)`, `N_int/X`, `N_int/(X log X)`, `N_int/X^(3/2)` | X=30: 46, 1.533333, 0.450822, 0.279947; X=100: 276, 2.760000, 0.599326, 0.276000; X=210: 733, 3.490476, 0.652778, 0.240865; X=500: 2181, 4.362000, 0.701895, 0.195075; X=1000: 5056, 5.056000, 0.731931, 0.159885; X=2310: 13615, 5.893939, 0.761 - exact 0.760999, 0.122631 | The ratio to `X log X` increases over this finite range, while `N_int/X^(3/2)` decreases. | No asymptotic conclusion; finite data only. |
## Stage 30 exact-definition audit

The Stage 30 pseudocode was recomputed from the Lean definition
`SR_weil_form_real`, namely weights
`m^(beta-1/2) cos(gamma log m)` and `n^(beta-1/2) cos(gamma log n)` with
the Rees sign `+1` for `m*n >= X` and `-1` otherwise.  Direct enumeration
gives, for `(beta,gamma)=(0.8,21.022)`,
`Q(6)=10.600956`, `Q(30)=-19.469985`, and `Q(110)=612.406629`.
These disagree with the earlier Stage 29 table (`2.556842`, `49.286536`,
`646.722121`), so that table is not evidence for the current Lean form.

Using the exact definition and the `O(X log X)` interior split, the
two-point exponents from `X=1000` to `X=10000` are:

| gamma | beta | Q(1000) | Q(10000) | observed exponent | Conrey prediction |
|---:|---:|---:|---:|---:|---:|
| 21.022 | 0.5 | 717.931313 | 186378.154151 | 2.414312 | 1.500000 |
| 21.022 | 0.6 | 3474.729276 | 1152162.054696 | 2.520593 | 1.540000 |
| 21.022 | 0.7 | 15188.421635 | 7185316.641419 | 2.674933 | 1.580000 |
| 21.022 | 0.8 | 63591.739042 | 44972922.716686 | 2.849550 | 1.620000 |
| 21.022 | 0.9 | 260886.152699 | 281894241.510647 | 3.033635 | 1.660000 |
| 14.134 | 0.5 | 600.450290 | 498988.517166 | 2.919613 | 1.500000 |
| 14.134 | 0.6 | 2210.257569 | 3116925.006924 | 3.149283 | 1.540000 |
| 14.134 | 0.8 | 34151.115496 | 123420250.243447 | 3.557982 | 1.620000 |

Conclusion: the proposed `3/2 + (2/5)(beta-1/2)` law is refuted for the
current exact SR definition at these cutoffs.  The discrepancy must be
resolved before any Conrey interpretation is formalized.

### Stage 30 diagonal/off-diagonal audit

The objective's sample `Q_fast` uses `cos(gamma*log(m*n))`, which is not the
implemented SR term. The exact term is
`cos(gamma*log(m)) * cos(gamma*log(n))`. Repeating the requested split with
the exact product and `|log(m/n)| < 0.1`, at beta `0.8`, gamma `21.022`, gives:

| X | diagonal | off-diagonal | total | diagonal / X^1.3 |
|---:|---:|---:|---:|---:|
| 100 | 2139.012355 | -2109.150112 | 29.862242 | 5.372956 |
| 500 | 168657.892304 | -145981.278800 | 22676.613504 | 52.281214 |
| 1000 | 1018657.620342 | -955065.881300 | 63591.739042 | 128.241396 |

The totals agree with the exact SR definition and show strong cancellation
between the two regions. The product-of-cosines correction is therefore an
independent reason not to infer an analytic growth law from the objective's
sample pseudocode.
## Two-Channel Data (Stage 31)

For beta=0.8 and gamma=21.022, the exact corrected computation gives:

| X | total | ratio | product |
|---:|---:|---:|---:|
| 30 | -19.470 | -2.734 | -16.736 |
| 100 | 29.862 | 151.286 | -121.424 |
| 500 | 22676.614 | 11999.991 | 10676.622 |
| 1000 | 63591.739 | 70509.094 | -6917.355 |
| 5000 | 15637.127 | 4668602.265 | -4652965.138 |

At X=5000, the total is only about 0.00335 times the larger channel,
showing severe cancellation. Finite-range slopes from X=1000 to X=10000
for beta=0.5, 0.7, 0.9 are respectively total (2.414, 2.675, 3.034),
ratio (2.022, 2.407, 2.802), and product (2.305, 3.044, 3.702).

These are numerical slopes, not asymptotic theorems.

## Correct Diagonal Sign Sum

The diagonal cutoff is `m*m < X`. The unweighted sign sum is
`D(X) = (X-2) - 2*(floor(sqrt(X-1))-1)`; values are D(6)=2, D(30)=20,
D(100)=82, D(210)=182, and D(1000)=938. This differs from `reesTrace`.
