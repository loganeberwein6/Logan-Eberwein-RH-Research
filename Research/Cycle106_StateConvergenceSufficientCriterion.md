# Cycle 106 — Minimal State-Convergence Criterion for the Determinant

## Exact reduction

The finite theorem gives

`F_(lambda,N)(z) = -i lambda^(-i z) widehat(xi_(lambda,N))(z)`.

Therefore the determinant-convergence problem is exactly a convergence problem
for the selected Weil ground state, not an independent spectral-fitting
problem.

## Sufficient analytic criterion

Choose the common logarithmic coordinate and the determinant normalization
used in the finite theorem. If the normalized states `h_(lambda,N)` satisfy,
for every `R>0`,

`integral exp(R|x|) |h_(lambda,N)(x)-h(x)| dx -> 0`,

and the same weighted norms are uniformly bounded, then their Fourier/Mellin
transforms converge locally uniformly on the complex disk `|z|<=R`.

Indeed, on that disk the transform difference is bounded by the weighted
`L^1` difference, since `|exp(-i z x)| <= exp(R|x|)`. Applying this after the
explicit `lambda^(-iz)` normalization gives local uniform convergence of the
regularized determinants.

If the limiting transform is the nonzero completed Xi function, Hurwitz then
transfers the real-zero property of the finite self-adjoint determinants to
Xi.

## Definitive smallest target

The genuinely sufficient missing estimate is therefore:

> convergence of the normalized ground states in weighted exponential `L^1`
> (or any stronger common-space topology embedding continuously into all such
> transform functionals), together with identification of the limit as the
> Xi-state.

This is more precise than asking vaguely for “operator convergence” or
“eigenvalue convergence.” It also explains why ordinary `L^2` convergence,
finite eigenvalue matching, and entrywise matrix convergence are insufficient:
none controls the complex Fourier transform uniformly on compact sets.

## Remaining split

- The simple-even theorem selects `xi` and prevents ambiguity.
- A common Weil/prolate estimate may prove the weighted-state convergence.
- The weighted-state convergence plus Xi identification proves determinant
  convergence.

Thus the final missing mathematical object is not another finite operator. It
is a uniform weighted transform estimate for the normalized Weil ground state.
