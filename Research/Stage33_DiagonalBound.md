# Stage 33 — diagonal bound and growth-law audit

## Current status

The requested Lean theorem is open. No false proof was promoted.

The special case `beta = 1/2` is now formally proved in
`SR_Stage33.lean`. It uses the triangle inequality, the existing
`reesEntry_neg_or_pos` lemma, an explicit nodup proof for the support, and
the support cardinality `X - 2`; the resulting bound is `X - 2 ≤ X`.

The general square-root cutoff formula is also now formally proved:

```lean
SR_sqrt_cutoff_count X = Nat.sqrt (X - 1) - 1
```

The proof uses an induction for filtered ranges, `(Nat.le_sqrt).symm`, and
`Nat.sqrt_le_self`.

The positive-exponent power-sum lemma is now formally proved:

```lean
sr33_sum_rpow_bound_pos (N : Nat) (s : ℝ) (hs : 0 < s) :
  ∑ k ∈ Finset.range N, ((k : ℝ) ^ s) ≤
    (N : ℝ) ^ (s + 1) / (s + 1)
```

It uses `MonotoneOn.sum_le_integral` and `integral_rpow`.

The support-level version is also proved for `s > 0`:

```lean
∑ m ∈ (completeSupport X).toFinset, ((m : ℝ) ^ s) ≤
  (X : ℝ) ^ (s + 1) / (s + 1)
```

It follows by treating the support as a subset of `Finset.range X` and
applying the positive power-sum theorem.

## Actual proof attempts

The first cutoff attempt was:

```lean
simp [SR_sqrt_cutoff_count, completeSupport]
```

Lean reduced the goal to a filtered-list cardinality but left the exact goal

```text
(List.filter (fun m => decide (m * m < X))
  (List.map (fun k => k + 2) (List.range (X - 2)))).length
  = (X - 1).sqrt - 1
```

The proposed induction for the power sum was rejected before promotion. Its
successor step needs an endpoint inequality in the wrong direction for an
increasing power function. The correct route must split the exponent at zero
or use a carefully oriented interval-integral comparison.

## Large-X computation

For `beta = 0.8`, `gamma = 21.022`:

| X | D_ratio | D_ratio / X^(2β) | D_product | D_product / X^(2β) |
|---:|---:|---:|---:|---:|
| 10,000 | 1,567,839.317816 | 0.62416807 | -45,155.935893 | -0.01797690 |
| 50,000 | 20,609,808.530689 | 0.62477256 | 433,687.988400 | 0.01314696 |
| 100,000 | 62,486,983.958059 | 0.62486984 | 661,467.283804 | 0.00661467 |

The ratio diagonal is numerically approaching `1/(2*beta) = 0.625`.
The product diagonal is substantially smaller after normalization, but its
sign changes and this is not an equidistribution proof.

## Mathematical corrections

The target assumes only `0 < beta`. Thus `s = 2*beta - 1` may be negative.
The positive-exponent monotone integral argument cannot be used uniformly.
For `s < 0`, the function is decreasing; for `s = 0`, the sum is elementary;
for `s > 0`, it is increasing. A valid Lean proof must handle all three cases.

The Euler–Maclaurin/zeta connection remains a conjectural research note,
not evidence for the Lean inequality.
