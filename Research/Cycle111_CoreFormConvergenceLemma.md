# Cycle 111 — Proven Core Form-Convergence Lemma

## Statement

Let `h` be an even `C_c^infty(R)` function supported in `[-A,A]`. Embed it
into the finite logarithmic interval `I_lambda` by zero extension, with
`log(lambda)>A`, and let `P_(lambda,N)h` be its Fourier projection onto modes
`|n|<=N`.

Then, for any path with `lambda -> infinity` and `N -> infinity`,

`Q_(lambda,N)(P_(lambda,N)h) -> Q_Weil(h)`.

## Proof of the cutoff part

The convolution `h^* * h` is supported in `[-2A,2A]`. The prime-power terms
in the Weil form are evaluated at `±log(k)`. Therefore only `k<=exp(2A)` can
contribute. Once

`lambda^2 >= exp(2A)`,

the finite prime sum contains every nonzero contribution and its omitted tail
is exactly zero on `h`.

The archimedean distribution and pole/evaluation terms are distributions on
the Schwartz core. Since `h` is supported strictly inside `I_lambda`, the
finite interval expression agrees with the global expression on `h` once
`log(lambda)>A`; there is no boundary contribution from the zero extension.

## Proof of the Fourier part

Because `h` vanishes in a neighborhood of both interval endpoints, its zero
extension is a smooth periodic function on `I_lambda`. Its Fourier series
converges to `h` in every derivative norm, with errors decaying faster than
any power of `N`. The Weil form terms are continuous on the resulting
Schwartz seminorms, so replacing `h` by `P_(lambda,N)h` changes the form by a
quantity tending to zero.

Combining the exact cutoff statement with the Fourier projection estimate
proves the displayed convergence.

## Scope

This is a genuine common-space convergence result on a dense test-function
core. It proves that the finite arithmetic forms are restrictions of one
independent global Weil form, rather than unrelated fitted matrices.

It does not imply convergence of the lowest eigenvectors. Passing from core
form convergence to ground-state or determinant convergence requires uniform
semiboundedness, compactness/coercivity, and control of the collapsing finite
spectral gaps. Those remain the nonlocal part of the problem.
