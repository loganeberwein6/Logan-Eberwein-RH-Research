# Cycle 36: exact SR coercivity versus determinant zeros

## Theorem

Let `S` be the distinct-threshold SR matrix, ordered by its threshold values,
with `S[i,j]=-1` when the `j` threshold is at most the `i` threshold and `+1`
otherwise. Then

`S+S^T=-2I`.

If `S v=lambda v` for a complex eigenvector `v`, then

`2 Re(lambda)||v||^2 = v^*(S+S^T)v = -2||v||^2`,

so every eigenvalue satisfies `Re(lambda)=-1`. In particular, `lambda=1` is
impossible and

`det(I-S) != 0`.

This is an exact finite-dimensional obstruction: the same operator cannot have
the SR coercivity identity and a Fredholm determinant zero at a zeta zero.

## Numerical verification

```text
X=6:  dimension 2,  symmetry error 0, Re(lambda)=-1, det(I-S)=5
X=10: dimension 4,  symmetry error 0, Re(lambda)=-1, det(I-S)=41
X=20: dimension 6,  symmetry error 0, Re(lambda)=-1, det(I-S)=365
X=50: dimension 12, symmetry error 0, Re(lambda)=-1, det(I-S)=265721
```

The determinant values are not near zero and grow rapidly with the threshold
dimension.

## Scope

This does not rule out using SR as a separate positive/coercive form coupled to
an indefinite determinant pencil. It does rule out the most direct proposal:
declaring the exact SR threshold matrix itself to be the RH operator. Any
successful combination must break at least one of the following identifications:

1. the determinant operator equals the exact SR matrix;
2. the coercivity identity is imposed on that same operator;
3. the determinant zeros are obtained from `det(I-S)`.

## Verdict

**Proved class-level obstruction.** Exact SR coercivity is incompatible with
P1 when imposed on the same operator. This formalizes why earlier attempts that
tried to preserve `S+S^T=-2I` while moving the determinant toward zeta zeros
failed.
