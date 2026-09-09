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
