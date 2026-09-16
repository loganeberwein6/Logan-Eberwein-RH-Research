# Cycle 78 — Nontrivial Z₂ Skew-Product Mayer Extension

## Construction

To avoid the Cycle 77 gauge obstruction, augment each Mayer state by a group label `g in Z/2Z`. An edge with branch state `k=floor(1/x)` and integer branch `n` toggles the label when `kn<X`:

\[
 (L_X^{\mathbb Z_2}f)(x,g)
 =\sum_{n\le X}(x+n)^{-2s}
 f\bigl((x+n)^{-1},g+\tau_X(k,n)\bigr),
\]

where `tau_X(k,n)=1` if `kn<X` and `0` otherwise. This is a genuine state-variable extension, not a diagonal gauge sign.

Under the two characters of `Z/2Z`, the operator decomposes into an untwisted block `L_+` and a signed block `L_-`:

\[
 \det(I-L_X^{\mathbb Z_2})
 =\det(I-L_+)\det(I-L_-).
\]

## Discretization and raw output

Using a 35-point midpoint grid on `[0,1]`, midpoint quadrature, linear nearest-grid image assignment, and branches `1 <= n <= X`:

| X | s | det(I−L₊) | det(I−L₋) | product |
|---:|---:|---:|---:|---:|
| 20 | 1.5 | 0.9893787635 | 1.0093497930 | 0.9986292506 |
| 20 | 2.0 | 0.9945294391 | 1.0052833270 | 0.9997838638 |
| 50 | 1.5 | 0.9893500051 | 1.0101403070 | 0.9993823175 |
| 50 | 2.0 | 0.9945283967 | 1.0054239020 | 0.9999226216 |

Critical-line minima of the twisted factor over `0 <= t <= 40`:

- `X=20`: lowest sampled minimum near `t=22.70`, value `0.951543`.
- `X=50`: lowest sampled minimum near `t=29.90`, value `0.954281`.

The locations do not converge to `14.1347` or `21.0220`.

At `s=1.5`, the ten largest absolute twisted eigenvalues were:

- `X=20`: `0.0108656, 0.0039407, 0.0020443, 0.0020203, 0.0020203, 0.0018004, ...`
- `X=50`: `0.0112097, 0.0036407, 0.0020820, 0.0020249, 0.0020249, 0.0015111, ...`

The finite discretizations are compact, but this does not establish a nuclear limit.

## Structural failure

The skew-product construction does create a nontrivial twisted transfer sector. However, its determinant is only the product of two Mayer-type determinants. The SR cocycle changes periodic-orbit signs in the twisted sector, but no identity turns those signed orbit sums into `-ζ'/ζ` or into the completed xi function. The near-cancellation between the two factors makes the full determinant even less zeta-sensitive.

## P1–P6

| Property | Result |
|---|---|
| P1 | Fails numerically; no stable zeta-zero minima. |
| P2 | Partial: branch signs are arithmetic, but no Lambda trace identity. |
| P3 | No canonical positive quadratic form; character sectors remain transfer operators. |
| P4 | Absent. |
| P5 | Holds for the finite cocycle. |
| P6 | Finite compact discretization only; nuclear limiting theorem absent. |

## Verdict

**DEAD as the minimal state-variable repair.** New labels evade gauge triviality but do not supply the missing completed arithmetic determinant or Weil positivity. A successful extension would require a nonabelian/global arithmetic state space together with a new trace formula, not merely a finite sign group.
