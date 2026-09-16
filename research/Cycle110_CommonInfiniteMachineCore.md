# Cycle 110 — Independent Infinite Machine and Finite Embeddings

## Infinite machine

Use the fixed ambient space of even Schwartz functions on the logarithmic
line,

`S_even(R) = {h in S(R) : h(x)=h(-x)}`,

with ambient Hilbert norm inherited from `L2(R)`. Define the global Weil form
on this core by the archimedean term, the two pole/evaluation terms, and the
full prime-power sum weighted by `Lambda(n)`. No zeta-zero height occurs in
this definition.

If this form is closable and semibounded, its closure defines the independent
infinite machine through the representation theorem for closed forms.

## Finite-to-infinite map

For `lambda>1`, write `I_lambda=[-log(lambda),log(lambda)]`. A finite Fourier
mode on `I_lambda` is mapped into the ambient space by zero extension outside
`I_lambda`. Let `J_(lambda,N)` denote this isometric embedding of the finite
Fourier subspace, and let `P_(lambda,N)` be the corresponding orthogonal
projection in the ambient space.

The finite Weil matrix is then the coordinate representation of the global
form restricted to `J_(lambda,N)`, with the explicit cutoff of its prime
distribution and the finite boundary/evaluation prescription.

## Core convergence result

For any fixed even compactly supported smooth test function `h`, choose
`lambda` large enough that its support lies strictly inside `I_lambda`.
Then:

1. zero extension introduces no boundary discontinuity;
2. the Fourier projections `P_(lambda,N)h` converge to `h` in every Schwartz
   seminorm as `N` tends to infinity;
3. the prime-power contribution is eventually exact, because the convolution
   `h^* * h` has compact support, so only finitely many `log(n)` can contribute;
4. the archimedean and evaluation terms converge by continuity of their
   distributions on the Schwartz core.

Consequently, along any path with `lambda -> infinity` and `N -> infinity`
fast enough for the Fourier projection error to vanish,

`Q_(lambda,N)(P_(lambda,N)h) -> Q_Weil(h)`

for every fixed compactly supported even smooth `h`.

This establishes the common ambient map and form convergence on a dense core;
it is stronger than comparing matrices in unrelated coordinates.

## What this does and does not prove

It constructs the only natural independent infinite candidate: the closed
global Weil-form operator, if closability and semiboundedness are proved. It
also proves the local/core version of finite-form convergence.

It does not yet prove that the finite minimizing vectors converge to a vector
of this core, nor that the global form is positive. Those are precisely the
nonlocal spectral estimates needed for determinant convergence to Xi. The
finite-to-infinite map is therefore established on test functions, while the
ground-state map remains the decisive open step.
