# Stage 25 revised B3 bridge — first obstruction

The revised specification defines

```text
S_int   = Σ_{mn<X} Λ(m)Λ(n)/sqrt(mn)
S_ext   = Σ_{mn≥X} Λ(m)Λ(n)/sqrt(mn)
S_total = S_int + S_ext.
```

But the Stage 24 signed mollifier is

```text
SR_HalfWeightedSum = S_ext - S_int,
```

because `reesEntryFromNat X m n = -1` on the interior and `+1` on the
exterior.  Hence the requested equation

```text
SR_S_total X = SR_HalfWeightedSum X
```

is false in general.  The first failed equation is therefore the proposed
`SR_S_total_eq_S1_def`, before the Cauchy–Schwarz or square-root argument.

The corrected identity must be either

```text
SR_HalfWeightedSum X = SR_S_ext X - SR_S_int X
```

or the signed total must be renamed and defined as that difference.  The
positivity assumptions in the revised main theorem also need to be adjusted
accordingly; positivity of `S_int + S_ext` does not imply positivity of the
signed Rees sum.

## Second obstruction: incompatible weights

The revised target defines `SR_S_unsigned` and the signed half-weighted sum
using literal factors `Real.log m * Real.log n`, while the existing Stage 24
definitions of `SR_S2` and `SR_S3` use `vonMangoldt m * vonMangoldt n`.

Therefore the proposed Cauchy–Schwarz statement

```text
SR_S_unsigned^2 ≤ SR_S2 * SR_S3
```

does not apply to the current objects: its left side is a logarithmic-weight
sum, whereas its right side is a von-Mangoldt-weight sum.  On complete integer
support these are not equal because composite prime powers and non-prime-power
integers are present.

The vectors must first be made consistent—either replace every logarithmic
weight by `vonMangoldt`, or define `S2` and `S3` with the literal logarithmic
weights—before a Cauchy–Schwarz lemma can be stated soundly.
