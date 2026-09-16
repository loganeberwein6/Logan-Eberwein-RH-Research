# Stage 25 — B3 arithmetic bridge failure

## First failed equation

The requested implication

```text
SR_kappa X > c  →  psi2(X) / X^2 > (1-c)/2
```

is false for the current Stage 24 definitions.

At `X = 6`, the recorded mollifier computation gives

```text
SR_kappa 6 ≈ 0.7625775751.
```

The only ordered interior pair with `m*n < 6` and nonzero von Mangoldt
weights is `(2,2)`, so

```text
psi2 6 = log(2)^2,
psi2 6 / 6^2 ≈ 0.0133459171.
```

Choose `c = 3/4`.  Then `0 < c < 1` and the recorded value satisfies
`SR_kappa 6 > c`, but

```text
(1-c)/2 = 1/8 = 0.125,
```

which is strictly larger than `psi2 6 / 6^2`.

## Failure invariant

The definition

```text
kappa = S1^2 / (S2*S3)
```

does not by itself imply a lower bound on the *unweighted* interior sum
`psi2`.  A missing comparison theorem is required, and the stated B3
inequality has the wrong direction/normalization for the finite data.

The correct next target is therefore a repaired bridge with an additional
normalization or a weighted `psi2` quantity, not `B3_arithmetic_bridge` as
currently stated.

## Approach 2 failure: Cauchy–Schwarz direction

Let

```text
A_int = Σ_{mn<X} Λ(m)Λ(n)/sqrt(mn)
S2_int = Σ_{mn<X} Λ(m)Λ(n)/(mn)
psi2   = Σ_{mn<X} Λ(m)Λ(n).
```

Cauchy–Schwarz gives

```text
A_int^2 ≤ S2_int * psi2.
```

This is an upper bound on `A_int` in terms of `psi2`; it does not give the
lower bound on `psi2` required by B3.  Since `S1 = A_ext - A_int`, a lower
bound on `S1` would additionally require an upper bound on `A_int` and a
lower bound on `A_ext`, neither of which follows from the current SR axioms.

Failure invariant: Approach 2 has the wrong inequality orientation for the
claimed bridge.  A missing lower bound for the exterior weighted sum (or a
different weighted target) is required before Cauchy–Schwarz can be useful.

## Approach 3 failure: trace data do not determine `psi2`

The identity `Tr(M_Rees * W) = S1` only records the weighted signed sum.
The unweighted interior quantity `psi2` depends on the support of the
von-Mangoldt weights below the wall.  Neither the all-ones Rayleigh witness
nor `Tr(M_Rees^2)` contains those weights: for a ±1 Rees matrix,
`Tr(M_Rees^2)` is determined only by the matrix dimension.  Consequently
the proposed trace route loses the arithmetic information needed to recover
`psi2`.

Failure invariant: a new weighted trace identity involving the von Mangoldt
diagonal is required; the existing Rees trace and quadratic-form facts are
insufficient.
