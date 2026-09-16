# Structural Reason Hypothesis — Why Critical-Line Failure Has Not Occurred

## Epistemic status

The Riemann hypothesis is open. It is not established that RH is “barely true” in a theorem-level sense. Large values of zeta-related observables, small zero gaps, and severe conditioning in finite models can make the problem look close to failure without corresponding to a zero off the critical line. The distinction between near-extremal behavior and an actual counterexample must be preserved.

## Central structural hypothesis

The strongest common pattern in the completed work is that the critical line is probably enforced by a **global self-duality plus positivity mechanism**, not by a local Euler factor or a finite sign matrix.

The proposed architecture is:

1. **Arithmetic layer:** prime powers enter through the exact coefficient `Lambda(n)`.
2. **Duality layer:** the completed functional equation identifies the two sides of `s <-> 1-s`.
3. **Geometric/cohomological layer:** Möbius and Lambda signs arise as a graded trace, explaining cancellation but not ordinary positivity.
4. **Weil layer:** Fourier transform and the archimedean gamma term combine with the prime terms into a global quadratic form.
5. **Spectral layer:** a self-adjoint or definitizable realization turns positivity of that global form into spectral support on `Re(s)=1/2`.

In this picture, near-counterexamples are not accidents: they are the finite-dimensional shadows of a form that is almost degenerate along certain high-frequency directions. Exact self-duality prevents the degeneracy from crossing into a genuine off-line zero.

This is a research hypothesis, not a theorem.

## Evidence supporting the hypothesis

- Local Euler blocks encode arithmetic but have no positivity or functional symmetry.
- Direct Rees forms have finite coercivity in selected directions but mixed inertia globally.
- Divisor complexes produce the exact Möbius/Lambda signs only through supertraces.
- The completed Weil form is the first framework that naturally contains primes, gamma factors, Fourier duality, and an RH-equivalent positivity statement.
- Candidate Q contains those ingredients and shows finite positivity, but its high-cutoff matrices become nearly singular and no convergence theorem exists.
- Every attempt to combine local Euler determinants with direct symmetric SR coupling either changes the Euler determinant or destroys positivity.

## What “barely true” should mean mathematically

The phrase should be replaced by measurable quantities such as:

- the smallest eigenvalue of a correctly normalized finite Weil form;
- the condition number and spectral gap of its truncations;
- the distance of zeros of a completed finite determinant from the symmetry line;
- normalized zero gaps and extreme values of `1/xi` away from exact zeros;
- the size of the tail error in the explicit formula.

A finite model becoming nearly singular is evidence for a possible structural boundary, but it is not evidence that RH is nearly false unless the model is proven to converge in a topology controlling zero locations.

## Required discovery

The “deep reason” sought by the project should be a theorem of the following shape:

> There exists a canonical arithmetic test-function space and a self-dual quadratic/spectral form whose finite truncations converge uniformly enough that positivity (or definitizability) is equivalent to all nontrivial zeros lying on the fixed line.

The theorem must identify, rather than assume:

- the space;
- the self-dual involution;
- the prime-power trace formula;
- the archimedean term;
- the positivity domain;
- the convergence and zero-continuity estimates.

## Current bottleneck

The project has separately realized fragments of this architecture, but not the single map joining them:

\[
\text{finite SR/divisor data}
\longrightarrow
\text{global Weil test-function space}
\longrightarrow
\text{self-adjoint spectral object}.
\]

The first arrow must preserve the exact Lambda coefficients and the second must preserve positivity and analytic continuation. Scalar trace matching is insufficient; the map must preserve the full quadratic form and its tail estimates.

## Next research invariant

For every proposed construction, the primary question is now:

> What exact symmetry prevents a negative direction of the global Weil form from becoming an off-line zero?

If a candidate cannot answer that question algebraically and analytically, numerical proximity to known zeros is not enough to keep it alive.

