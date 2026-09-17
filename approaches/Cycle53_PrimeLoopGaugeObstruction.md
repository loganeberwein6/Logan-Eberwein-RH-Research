# Cycle 53: gauge obstruction for determinant-preserving prime-loop signs

## Exact two-edge calculation

For a two-state prime loop

`K_p=[[0,a_p],[b_p,0]]`,

one has

`det(I-K_p)=1-a_p b_p`.

To preserve the Euler factor `1-p^(-s)`, it is necessary and sufficient that
`a_p b_p=p^(-s)`. Write `a_p=p^(-s/2)u_p` and
`b_p=p^(-s/2)u_p^(-1)`. Then

`K_p = D_p K_p^0 D_p^(-1)`,

with `D_p=diag(u_p,1)` and `K_p^0` the standard symmetric loop.

Thus every determinant-preserving sign, phase, or scalar redistribution on a
two-edge prime loop is a gauge similarity.

## Numerical check

For `p=2,3,5` and `u_p in {1,-1,i,-i}`, the determinant error was zero to
machine precision and the eigenvalues remained exactly
`+p^(-s/2),-p^(-s/2)`.

## Consequence

SR signs can be placed on individual loop edges only by changing the product
of edge weights. If the product is preserved, the modification is spectrally
and determinantly trivial. If the product changes, the Euler factor changes
from `1-p^(-s)` to a different factor such as `1+p^(-s)`.

## Verdict

**All determinant-preserving two-edge prime-loop sign couplings are gauge
trivial.** A nontrivial SR/Euler interaction must involve multi-prime loops or
an enlarged arithmetic state space, not edgewise signs on independent prime
blocks.
