# Cycle 75 — Global Weil-Form Specification

## Correct positivity target

The viable positivity object is not a determinant-positive Euler block. It is a quadratic form on an even test-function space. In the standard Weil explicit-formula normalization, for an admissible even function `h`, one has a schematic identity

\[
 Q_\xi(h)=\sum_\rho h\!\left(\frac{\rho-1/2}{i}\right)
 =\text{archimedean term}(h)
 -\sum_{n\ge2}\frac{\Lambda(n)}{\sqrt n}
   \bigl(\widehat h(\log n)+\widehat h(-\log n)\bigr)
 +\text{normalization terms}.
\]

The exact normalization varies with the Fourier convention, but three components are invariant: prime powers through `Lambda(n)`, the gamma/archimedean contribution, and the Fourier transform relating additive test-function space to logarithmic prime data.

Weil's criterion states that positivity of this form on the full admissible test-function space is equivalent to the Riemann hypothesis. Thus it is a valid P3 target, but it is already an RH-equivalent statement rather than an independent proof.

## Why the previous matrix attempts do not realize it

The raw Li sequence is not a moment sequence: the existing size-five Hankel matrix formed from the first Li coefficients has a negative eigenvalue approximately `-0.2964410018`, despite the first ten Li coefficients being positive. Therefore coefficient matching, diagonal Lambda weights, or a Rees Gram matrix cannot substitute for the full test-function transform and archimedean term.

The SR identity `S+S^T=-2I` supplies finite pointwise coercivity in the threshold-index space. No proved map currently sends that space into the Weil test-function space while preserving:

1. the Fourier transform at `log n`;
2. the exact `Lambda(n)` prime-power coefficient;
3. the gamma contribution;
4. the limiting quadratic form; and
5. a nuclear/Fredholm realization.

## Minimal operator theorem still needed

An actual completion would require a Hilbert or nuclear test-function space `H`, finite arithmetic maps `J_X`, and operators `W_X` such that:

\[
 \langle J_X f,W_XJ_X f\rangle \to Q_\xi(f),
\]

with uniform control in the relevant topology, together with a self-adjoint realization or an independently proved positivity theorem. The convergence must include the archimedean and prime-power tails; matching finitely many Lambda coefficients is insufficient.

To connect this to P1/P6, one would additionally need a trace-class parameter family whose determinant or spectral shift function is identified with the completed xi function. The Weil form by itself gives positivity equivalent to RH but not a Fredholm determinant.

## Status

This is a framework specification, not a completed operator. It clarifies the exact surviving class: global, nonseparable, Fourier/explicit-formula constructions. It also proves why the existing local Euler, Rees, diagonal, and raw-Li-moment constructions cannot be patched into it by scalar weighting.

## Verdict

**Open / not solved.** The global Weil form is the correct mathematical target for P3, but constructing it from the finite SR structure with P1, P4, P5, and P6 simultaneously remains unproved.
