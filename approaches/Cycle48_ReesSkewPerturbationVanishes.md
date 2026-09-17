# Cycle 48: Rees skew perturbation vanishes identically

## Proposed test

The perturbative idea was to add the skew part of the Rees sign matrix to the
prime diagonal:

`T_eps(s)=D_prime(s)+eps*(M_Rees-M_Rees^T)/2`.

This was intended to preserve the Euler determinant to first order while
introducing SR geometry.

## Exact failure

The Rees sign depends only on the symmetric product `mn`:

`M_Rees(m,n)=sign(mn-X)=M_Rees(n,m)`.

Therefore

`(M_Rees-M_Rees^T)/2=0`

entrywise for every cutoff. The proposed perturbation is identically zero for
all `eps`; the determinant remains exactly the prime-diagonal determinant.

Numerically, for `X=20,50` and `eps=.01,.1,1`, the critical scans were
identical at every precision tested, with minima at zero frequency rather than
at zeta ordinates.

## Consequence

The nonzero skew matrix in earlier threshold experiments came from an ordered
quotient relation (`q_j<=q_i`), not from the original symmetric Rees product
matrix. Importing that skew part requires a new ordered state space and is not
a perturbation of `M_Rees` itself.

## Verdict

**Construction invalid/identically zero.** No determinant or spectral claim
may be inferred from this perturbation. A nontrivial interaction must introduce
an ordered arithmetic state variable explicitly.
