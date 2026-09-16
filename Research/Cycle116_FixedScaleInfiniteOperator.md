# Cycle 116 — Fixed-Scale Infinite Weil Operator

## First limit: `N -> infinity` at fixed `lambda`

For each fixed `lambda>1`, work on the single Hilbert space

`H_lambda = L2_even([-log(lambda), log(lambda)], dx)`.

The semilocal Weil form `q_lambda` is defined on the Weil/Schwartz core in
this interval, with the archimedean term, pole/evaluation terms, and the
finite prime-power sum `k <= lambda^2`.

The finite matrices `W_(lambda,N)` are exactly the restrictions of this one
form to the Fourier subspaces `E_(lambda,N)`. The Fourier subspaces are nested
and dense in `H_lambda`.

## Fixed-scale completion

If `q_lambda` is closed and lower semibounded, the representation theorem
produces a self-adjoint operator `A_lambda` on `H_lambda`. The finite forms
converge to `q_lambda` through the Fourier projections, so the associated
finite operators converge to `A_lambda` in the standard form/strong-resolvent
sense. Compactness of the form-domain embedding gives convergence of isolated
finite spectral projections.

This is a genuine infinite machine for every fixed `lambda`; its construction
does not use any zeta-zero heights.

## What this proves

It resolves the Fourier-cutoff limit independently:

`W_(lambda,N)  -->  A_lambda` as `N -> infinity`, for fixed `lambda`.

The finite rank-one scaling operators can likewise be treated at fixed
`lambda` once their selected spectral state and Dirichlet functional satisfy
the required boundedness conditions.

## Remaining second limit

The original global problem is the scale limit

`A_lambda  -->  A_infinity` as `lambda -> infinity`.

That limit is substantially harder because the interval changes, the prime
sum grows, the smallest Weil energies collapse, and no uniform lower bound or
common compactness estimate is currently proved. The fixed-scale result must
therefore be viewed as a completed first layer, not as a proof of the global
Xi operator.

## Structural payoff

The two-parameter problem is now factored cleanly:

```text
finite Fourier matrices W_(lambda,N)
          | N -> infinity (proved conditionally by closed-form theory)
          v
fixed-scale infinite operators A_lambda
          | lambda -> infinity (open global scale theorem)
          v
global operator A_infinity and Xi determinant
```
