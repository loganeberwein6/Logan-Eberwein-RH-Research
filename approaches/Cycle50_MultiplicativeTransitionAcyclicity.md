# Cycle 50: multiplicative transition acyclicity

## Construction

Consider the natural finite transition operator on integer states

`A_N[n,p*n]=1` for primes `p` with `p*n<=N`, and zero otherwise.

This models multiplication-by-prime transitions without adding diagonal Euler
loops.

## Exact structural fact

Ordering states by integer size makes every nonzero transition strictly move to
a larger state. Hence `A_N` is strictly triangular and nilpotent. Therefore

`det(I-A_N)=1`

for every `N`, regardless of the number of prime transitions.

## Numerical check

```text
N=10: det(I-A)=1.0, spectral radius=0
N=20: det(I-A)=1.0, spectral radius=0
N=50: det(I-A)=1.0, spectral radius=0
```

## Consequence

Prime Euler factors arise only when the state space includes independent
occupation loops (as in the fermionic prime diagonal), not from the raw
multiplicative transition graph. SR-style ordered transitions are likewise
acyclic unless an explicit return/loop mechanism is introduced.

Adding return loops changes the determinant and must be tuned to reproduce
`prod_p(1-p^(-s))`; adding them through a generic SR interaction destroys that
identity. This is the dynamical version of the Euler-versus-SR obstruction.

## Verdict

**Proved structural obstruction for acyclic multiplicative transitions.** A
successful arithmetic transfer operator must combine multiplicative loops and
an ordered/Weil interaction in one integrable dynamical system; a bare
transition matrix cannot do both.
