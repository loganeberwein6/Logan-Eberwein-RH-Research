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
## Q oscillation and explicit-formula audit (Stage 36)

For `beta=0.8, gamma=21.022`, direct evaluation gives:

`X=30: Q=-19.4700`, `X=100: Q=29.8622`, `X=210: Q=1227.8586`,
`X=500: Q=22676.6135`, `X=1000: Q=63591.7390`.

The normalized values and explicit-formula prediction ratios do not stabilize.
This supports oscillation but does not prove a zeta explicit-formula identity.

Gram operator norms for `X=10,30,100` are approximately `6.9892, 25.8350,
94.1158`; the ratios to `sqrt(X-2)` are `2.4710, 4.8824, 9.5071`.
The proposed `sqrt(X)` operator-scale heuristic is therefore numerically false.
## Stage 37 clean extraction and coefficient scan (2026-09-10)

### Clean Lean target

`SR_Stage37_Clean.lean` was created without modifying the failing
`SR_Stage36.lean` scratchpad. It is registered in `lakefile.lean` as
`SR_Stage37_Clean` and builds successfully with:

```text
lake -Kjobs=1 build SR_Stage37_Clean
Build completed successfully (3506 jobs).
```

The clean file contains verified declarations for:

- the simple-zero logarithmic-derivative limit;
- the three exponent comparisons;
- the support indicator and eventual support membership;
- the indicator norm and cutoff vanishing;
- the divisor-antidiagonal convolution formula;
- convolution vanishing for `X^2 ≤ k`;
- the corrected singularity interface
  `sr37_clean_SR_dirichlet_contains_log_deriv : True`.

The final interface is intentionally a placeholder: it records the corrected
mechanism (`ζ'/ζ`, not `ζ²`) without asserting an unproved SR-to-zeta identity.

### Exact coefficient experiment at X = 30

The following computation used the current finite definition: `2 ≤ m,n < X`,
with sign `-1` for `mn < X` and `+1` otherwise.

```text
k | SR_coeff | Lambda(k) | d(k) | mu(k) | ratio SR/Lambda
  4 |    -1.00 |     0.693 |    3 |    0 | -1.4426950408889634
  5 |     0.00 |     1.609 |    2 |   -1 | 0.0
  6 |    -2.00 |     0.000 |    4 |    1 | N/A
  7 |     0.00 |     1.946 |    2 |   -1 | 0.0
  8 |    -2.00 |     0.693 |    4 |    0 | -2.8853900817779268
  9 |    -1.00 |     1.099 |    3 |    0 | -0.9102392266268373
 10 |    -2.00 |     0.000 |    4 |    1 | N/A
 11 |     0.00 |     2.398 |    2 |   -1 | 0.0
 12 |    -4.00 |     0.000 |    6 |    0 | N/A
 13 |     0.00 |     2.565 |    2 |   -1 | 0.0
 14 |    -2.00 |     0.000 |    4 |    1 | N/A
 15 |    -2.00 |     0.000 |    4 |    1 | N/A
 16 |    -3.00 |     0.693 |    5 |    0 | -4.328085122666891
 17 |     0.00 |     2.833 |    2 |   -1 | 0.0
 18 |    -4.00 |     0.000 |    6 |    0 | N/A
 19 |     0.00 |     2.944 |    2 |   -1 | 0.0
 20 |    -4.00 |     0.000 |    6 |    0 | N/A
 21 |    -2.00 |     0.000 |    4 |    1 | N/A
 22 |    -2.00 |     0.000 |    4 |    1 | N/A
 23 |     0.00 |     3.135 |    2 |   -1 | 0.0
 24 |    -6.00 |     0.000 |    8 |    0 | N/A
 25 |    -1.00 |     1.609 |    3 |    0 | -0.6213349345596119
 26 |    -2.00 |     0.000 |    4 |    1 | N/A
 27 |    -2.00 |     1.099 |    4 |    0 | -1.8204784532536746
 28 |    -4.00 |     0.000 |    6 |    0 | N/A
 29 |     0.00 |     3.367 |    2 |   -1 | 0.0
 30 |     6.00 |     0.000 |    8 |   -1 | N/A
 31 |     0.00 |     3.434 |    2 |   -1 | 0.0
 32 |     4.00 |     0.693 |    6 |    0 | 5.7707801635558535
 33 |     2.00 |     0.000 |    4 |    1 | N/A
 34 |     2.00 |     0.000 |    4 |    1 | N/A
 35 |     2.00 |     0.000 |    4 |    1 | N/A
 36 |     7.00 |     0.000 |    9 |    0 | N/A
 37 |     0.00 |     3.611 |    2 |   -1 | 0.0
 38 |     2.00 |     0.000 |    4 |    1 | N/A
 39 |     2.00 |     0.000 |    4 |    1 | N/A
 40 |     6.00 |     0.000 |    8 |    0 | N/A
 41 |     0.00 |     3.714 |    2 |   -1 | 0.0
 42 |     6.00 |     0.000 |    8 |   -1 | N/A
 43 |     0.00 |     3.761 |    2 |   -1 | 0.0
 44 |     4.00 |     0.000 |    6 |    0 | N/A
 45 |     4.00 |     0.000 |    6 |    0 | N/A
 46 |     2.00 |     0.000 |    4 |    1 | N/A
 47 |     0.00 |     3.850 |    2 |   -1 | 0.0
 48 |     8.00 |     0.000 |   10 |    0 | N/A
 49 |     1.00 |     1.946 |     3 |    0 | 0.5138983423697507
```

For all `1 ≤ k ≤ 900`:

```text
nonzero coefficients: 285
positive coefficients: 267
negative coefficients: 18
zero coefficients: 615
coefficient range: -6 8
max absolute coefficient: 8
sum coefficients: 692
matches Lambda exactly: False
matches divisor count exactly: False
matches Mobius exactly: False
```

### F(s) identification result

The proposed cutoff-independent candidates are ruled out by the data. More
strongly, the coefficient is intrinsically cutoff-dependent:

```text
c_X(k) = Σ_{m n = k, 2 ≤ m,n < X} sign_X(mn).
```

For `k < X`, every supported factor pair has `mn < X`, so `c_X(k)` is the
negative number of ordered factor pairs with both factors in `[2,X)`. For
`k ≥ X`, exterior pairs contribute with the opposite sign and the set of
available pairs changes with `X`. Therefore no fixed arithmetic function
`f(k)` can represent the full coefficient family without retaining the cutoff
kernel `g(X,k)`.

The corrected conclusion is:

```text
D_SR,X(s) = Σ_k c_X(k) k^(-s)
```

is a finite, cutoff-dependent Dirichlet polynomial. It is not presently of the
form `F(s) · (-ζ'/ζ)(s)` with a cutoff-independent explicit `F`. A valid pole
mechanism would require a new theorem identifying an asymptotic transform of
the family `D_SR,X`, not merely identifying its finite coefficient function.

### Exact coefficient structure extracted from the scan

Define

```text
A_X(k) = #{(m,n) : m n = k and 2 ≤ m,n < X}.
```

Then the finite definition gives

```text
c_X(k) = -A_X(k)  when k < X,
c_X(k) = +A_X(k)  when k ≥ X.
```

For `4 ≤ k < X`, both factors are automatically below `X`, so

```text
A_X(k) = d(k) - 2,
c_X(k) = -(d(k) - 2).
```

The `-2` removes the two trivial ordered factor pairs `(1,k)` and `(k,1)`.
At `k=X`, the coefficient is `d(X)-2`; for `k>X`, the restricted factor
count remains cutoff-dependent.

Independent checks gave:

```text
X=6:  checked 2 values below X, mismatches=[]
X=7:  checked 3 values below X, mismatches=[]
X=10: checked 6 values below X, mismatches=[]
X=30: checked 26 values below X, mismatches=[]
X=50: checked 46 values below X, mismatches=[]

Boundary: c_6(6)=2, c_7(7)=0, c_10(10)=2,
          c_30(30)=6, c_50(50)=4.

For k ≥ X and k < X², all tested coefficients were nonnegative:
X=6:  range 0..2
X=10: range 0..4
X=30: range 0..8
```

This explains the observed pattern without invoking Λ, μ, or a multiplicative
Dirichlet coefficient. Any eventual appearance of `ζ'/ζ` must come from a
nontrivial limiting operation, weighting, or differentiation of the cutoff
family; it is not present in the raw finite coefficient sequence.

### Unweighted cutoff-limit obstruction

The raw SR family has a stronger limiting description in the half-plane of
absolute convergence. Put

```text
S_X(s) = Σ_{2≤m<X} m^(-s),
D_X(s) = Σ_{2≤m,n<X} sign(mn<X) (mn)^(-s).
```

For `Re(s)>1`, each fixed pair `(m,n)` is eventually interior as `X→∞`, and
the summands are dominated by the absolutely summable product
`m^(-Re(s)) n^(-Re(s))`. Dominated convergence therefore gives the formal
analytic limit

```text
lim_{X→∞} D_X(s)
  = - Σ_{m,n≥2} (mn)^(-s)
  = -(ζ(s)-1)^2.
```

This is not a pole-producing logarithmic derivative. It is a square of a
zeta-derived Dirichlet series, and at a zero of ζ it is regular rather than
singular. Thus the unweighted raw cutoff limit cannot realize the proposed
`ζ'/ζ` pole mechanism. A successful SR transform must introduce an additional
operation—such as a logarithmic weight, a derivative with respect to a
parameter, or a different signed kernel—before taking the limit.

Numerical checks agree with the limit in the safer half-plane:

```text
s=3+0.2i, target=-(ζ(s)-1)^2
X=10  error=0.019025976
X=20  error=0.006656938
X=40  error=0.002046380
X=80  error=0.00061228796
X=160 error=0.00017885648
```

At `Re(s)=2` and `1.5`, convergence is visibly slower, as expected from the
weaker tail bounds, but the data are consistent with the same structural
limit. The dominated-convergence argument itself is currently a research
result, not yet a Lean theorem in `SR_Stage37_Clean.lean`.

### Differentiation does not repair the pole mechanism

A natural next idea is to differentiate the limiting transform. But

```text
D_∞(s) = -(ζ(s)-1)^2
```

would give

```text
-D_∞'(s) / D_∞(s) = 2ζ'(s)/(ζ(s)-1),
```

not

```text
ζ'(s)/ζ(s).
```

The denominator is shifted by the omitted `m=1` term, and the factor 2 comes
from the square. Thus ordinary differentiation or logarithmic differentiation
of the raw SR limit still does not create poles at the zeros of ζ. A new
normalization would have to restore the full Dirichlet object, including the
`1` term, and remove the square in a mathematically justified way.

Numerically:

```text
s=3+0.2i:
  2ζ'/(ζ-1) = -1.951337862454005 + 0.08903504359264707i
  ζ'/ζ       = -0.1604414349985608 + 0.03398019168856294i

s=2+0.7i:
  2ζ'/(ζ-1) = -2.251714323838272 + 0.8993186723127633i
  ζ'/ζ       = -0.253048550193579 + 0.3906798672090958i
```

This rules out the simplest “differentiate the raw cutoff limit” repair.

### Augmented-support candidate and its exact boundary

There is one nearby construction that does produce the desired logarithmic
derivative at the level of a limiting Dirichlet object. Add the omitted index
`1` and define the full-support cutoff family

```text
ẐD_X(s) = Σ_{1≤m,n<X} sign(mn<X) (mn)^(-s).
```

For `Re(s)>1`, dominated convergence gives

```text
lim_X ẐD_X(s) = -ζ(s)^2.
```

Where the limiting function is nonzero,

```text
(ẐD_∞)'(s) / ẐD_∞(s) = 2ζ'(s)/ζ(s).
```

Thus the augmented object has the correct formal pole mechanism. This does
not solve the SR problem for two independent reasons:

1. the original SR support starts at `2`, so its limit is
   `-(ζ(s)-1)^2`, not `-ζ(s)^2`;
2. passing from a finite quadratic form to the logarithmic derivative of its
   limiting Dirichlet object is a new nonlinear operation. It is not a
   Perron formula for the original `Q_X`, and no theorem currently connects
   its residues back to the SR signature or quadratic form.

The candidate therefore identifies the missing object more precisely:

```text
an SR-compatible augmented determinant/product whose logarithmic derivative
is exactly the classical ζ'/ζ and whose finite-to-infinite passage is proved.
```

The current clean Lean target records the pole mechanism only as a placeholder;
this augmented-support construction is not yet formalized there.

### Prime-factorization mismatch

The classical source of the pole is more specific than merely taking a
logarithmic derivative. In `Re(s)>1`, the Euler product gives

```text
log ζ(s) = Σ_p Σ_{r≥1} p^(-r s)/r,
-ζ'(s)/ζ(s) = Σ_{p,r≥1} (log p) p^(-r s)
             = Σ_{n≥1} Λ(n) n^(-s).
```

Thus the required operation is an Euler-product logarithm, which converts
divisor multiplication into prime-power weights. The SR coefficient scan has
instead produced truncated ordered-divisor counts `±A_X(k)`. No current SR
theorem supplies the prime-power logarithmic weight `Λ(k)` or an exact
Euler-product factorization of the SR determinant.

This is the sharp algebraic diagnosis of the unknown `F(s)`:

```text
F(s) is not determined by the present raw SR convolution;
the missing map is a prime-factorization/Euler-product transform.
```

The augmented `−ζ²` candidate can recover `ζ'/ζ` only after taking a
logarithm of an analytically identified product. Establishing that product as
an SR object, with the correct prime-power weights and a finite-to-infinite
theorem, is new mathematics rather than a consequence of the existing finite
signature or divisor-fiber results.

## Stage 38 full-support computation — 2026-09-12

The full-support experiment was evaluated for `{1, ..., X-1}` using
`a_full(X) = sum_{m,n=1}^{X-1} (-1 if m*n < X else 1)`.

```text
X=6:    full=5,       original=14,       delta=-9
X=10:   full=35,      original=52,       delta=-17
X=30:   full=635,     original=692,       delta=-57
X=100:  full=8855,    original=9052,      delta=-197
X=210:  full=41381,   original=41798,     delta=-417
X=2310: full=5295017, original=5299634,  delta=-4617
```

The full-support values are positive in every tested case, but smaller than
the original-support values. Explicit full-support threshold matrices at
`X=6, 10, 30` all satisfy `S + Sᵀ = -2 I`. This is finite numerical evidence
only; it does not establish the analytic Perron bridge or RH. The correct
analytic observable still requires von Mangoldt weighting.
