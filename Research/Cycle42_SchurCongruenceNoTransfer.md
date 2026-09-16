# Cycle 42: self-adjoint Schur cancellation has no positivity transfer

## Exact theorem

Let `S` be invertible and self-adjoint, and let `D` be self-adjoint. Define

`K=[[S,B^*],[B, B S^(-1) B^* + D]]`.

Then

`K = [[I,0],[B S^(-1),I]] [[S,0],[0,D]] [[I,S^(-1)B^*],[0,I]]`.

Consequently:

1. `det(K)=det(S)det(D)`;
2. `K` is congruent to `S direct-sum D`;
3. the inertia of `K` is exactly the combined inertia of `S` and `D`.

Thus the only self-adjoint Schur coupling that cancels determinant effects is
an algebraic congruence. It cannot transfer SR coercivity to the Euler/Weil
sector or create new spectral information.

## Numerical check

With

```text
S=[[-2,0],[0,-1]], B=[[1,2]], D=[[3]],
```

the resulting block is

```text
[[-2,  0,  1 ],
 [ 0, -1,  2 ],
 [ 1,  2, -1.5]]
```

and

```text
det(K)=6.0, det(S)det(D)=6.0
eigenvalues(K)=(-3.632257,-1.790378,.922635)
inertia(S direct-sum D)=(-,-,+)
```

The inertia agrees exactly, despite the visible off-diagonal interaction.

## Consequence for the RH construction

To obtain genuinely new positivity, a successful coupling must violate the
Schur-cancellation identity. But then its determinant changes and must be
controlled by a new arithmetic identity. This is the precise version of the
dichotomy observed in Cycles 40--41.

## Verdict

**Proved class-level obstruction.** Self-adjoint determinant-preserving Schur
couplings are congruence-trivial and cannot supply the missing P3 mechanism.
