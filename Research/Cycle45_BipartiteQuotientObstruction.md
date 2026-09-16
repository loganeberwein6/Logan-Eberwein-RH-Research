# Cycle 45: bipartite quotient lift

## Construction

The quotient core is naturally a relation between threshold rows and support
columns. Its symmetric bipartite lift is

`H_X = [[0,R_X],[R_X^T,0]]`.

For every real matrix `R`, the nonzero eigenvalues of `H_X` are
`+sigma_i(R)` and `-sigma_i(R)`, where `sigma_i` are the singular values of
`R`. Hence the lift can never be negative definite or positive definite unless
`R=0`.

## Numerical output

```text
X=10: H eigenvalue range [-2.613126, 2.613126], pair error <2e-15
X=20: range [-3.863703, 3.863703], pair error <2e-15
X=50: range [-7.661298, 7.661298], pair error <3e-15
```

The exact `+/-` pairing is a linear-algebra identity, not a numerical accident.

## Consequence

Adding a bipartite copy restores a natural row/column factorization but loses
the SR negative coercivity. Diagonal weights or congruences cannot remove the
paired signs without changing the operator class. Thus neither canonical
representative compression nor its symmetric bipartite lift transfers the
abstract threshold P3 form.

## Verdict

**Class-level obstruction for the natural bipartite repair.** The remaining
candidate must identify row and column spaces through a nontrivial arithmetic
involution or use a Weil quadratic form that is not the symmetric bipartite
lift.
