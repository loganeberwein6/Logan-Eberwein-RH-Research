# Literature Audit — Weil Spectral Operators and the Infinite-Limit Problem

## Scope and status discipline

This is a broad web/arXiv audit of the literature directly relevant to the
current Candidate-Q framework. It is not a claim of exhaustive coverage of
every paper or website. Results are classified as exact theorem, numerical
evidence, conjectural framework, or unsupported claim.

## 1. Connes–Consani, *Spectral triples and zeta-cycles* (2023)

Source: https://arxiv.org/abs/2106.01715

### Relevant advance

- Restricts the Weil quadratic form to compact-support windows.
- Uses prolate spheroidal wave functions to construct very small form values.
- Perturbs the circle scaling triple so selected functions lie in the kernel.
- Reproduces low zeta zeros numerically at special interval lengths.
- Establishes the zeta-cycle conceptual relation between the finite spectral
  construction and critical zeros.

### Framework integration

This supplies the prolate branch for our ground-state identification problem.
It does not supply the global `lambda -> infinity` convergence theorem.

## 2. Connes–Consani–Moscovici, *Zeta Spectral Triples* (2025)

Source: https://arxiv.org/abs/2511.22755

### Relevant advance

- Defines the rank-one perturbations of logarithmic scaling on
  `[lambda^-1,lambda]`.
- Uses the finite Weil form, its minimizing vector, and the Dirichlet kernel.
- Gives the finite regularized determinant as an explicit prefactor times the
  Fourier transform of the selected vector.
- States the exact remaining gap: simplicity/evenness and convergence of the
  finite transform to Xi.

### Framework integration

This is the source construction reproduced by `candidate_q_reproduce.py`.
Our shifted-Weil quotient correction is the correct finite metric layer of
this construction. It does not prove the global limit.

## 3. Connes–van Suijlekom, *Quadratic Forms, Real Zeros and Echoes of the
Spectral Action* (2025)

Sources:

- https://arxiv.org/abs/2511.23257
- https://doi.org/10.1007/s00220-025-05493-1

### Relevant advance

Under lower-bounded self-adjointness and a simple isolated even lowest state,
the Fourier transform of that state has only real zeros. The proof extends a
Caratheodory–Fejer/Toeplitz real-zero theorem and uses Hurwitz for limits.

### Framework integration

This formally justifies our finite real-zero mechanism. It changes the proof
plan: we do not need to prove finite zero reality numerically; we need to
verify the theorem's form and isolated-state hypotheses and then prove the
limit to Xi.

## 4. Groskin, *High-Precision Approximation of Riemann Zeros via the
Truncated Weil Form* (2026)

Source: https://arxiv.org/abs/2605.20224

### Relevant advance

- Implements the Connes–van Suijlekom truncated form at many prime cutoffs.
- Reports extremely high-precision agreement for the first ten zeros.
- Gives evidence for convergence across cutoffs and high-order numerical
  conditioning behavior.
- Explicitly states that convergence to the actual Riemann zeros remains open.

### Framework integration

This supersedes our low-precision numerical scans as the high-precision
benchmark. It does not discharge the global convergence obligations.

## 5. Groskin, *A finite Guinand–Weil dictionary and archimedean tail order
for the truncated Weil quadratic form* (2026)

Source: https://arxiv.org/abs/2607.02828

### Relevant advance

This is the most important new finite-level result for our framework:

1. Every real even Galerkin coefficient vector is mapped in closed form to a
   band-limited Guinand–Weil test function.
2. The corresponding finite quadratic value equals the zero-side explicit-form
   sum exactly.
3. The source map factors through an exact finite quotient.
4. The omitted archimedean tail is a positive Cauchy–Stieltjes increment.
5. An explicit tail budget `B_T` gives a two-sided certification rule for
   finite-cutoff positivity/negativity.

### Framework integration

This replaces our weaker informal finite-to-test-function map with an exact
finite dictionary. It also gives the next executable task: implement the
closed-form source map and tail budget, then use interval LDL^T certificates
instead of interpreting deep floating-point eigenvalues.

It does not prove global Weil positivity or the `lambda -> infinity` limit.

## 6. Suzuki, *Weil's quadratic form via the screw function* (2026)

Source: https://arxiv.org/abs/2606.09096

### Relevant advance

- Recasts the distributional Weil form using the continuous screw function.
- Connects Yoshida, Bombieri, Connes–Consani, and CCM frameworks.
- Provides a continuous-variable route for studying the form.
- Formulates a conjectural global limit of self-adjoint nonlocal realizations
  of a first-order operator on expanding intervals.

### Framework integration

This is a second independent global-machine branch. It may be better suited
to the scale limit because it uses one continuous kernel and expanding
intervals, rather than comparing changing Fourier matrices directly. Its
operator-to-zeta limit remains conjectural.

## 7. Kim et al., *A Numerical Realization of Suzuki's Weil-Quadratic-Form
Operator* (2026)

Source: https://arxiv.org/abs/2607.24830

### Relevant advance

- Numerically realizes Suzuki's operator with finite elements and Richardson
  extrapolation.
- Reports archimedean spectral laws and tail behavior.
- Tests an operator form of Weil positivity and real-zero behavior.
- Explicitly states that it does not prove RH and that the results are
  archimedean/universal rather than a complete arithmetic realization.

### Framework integration

Use this as a diagnostic for the screw-function branch and archimedean
compactness estimates. Do not treat its numerical positivity as a global
Weil positivity proof.

## 8. Unverified claimed proof: Zenodo semilocal spectral descent (2026)

Source: https://zenodo.org/records/19546495

The record claims a proof of RH via semilocal spectral descent and says that
compact-support form values stabilize for sufficiently large scale. However,
this is a self-declared preprint record, not an established peer-reviewed
resolution of RH. Its claims must not be imported as proven mathematics. It
is useful only as a proposed argument to audit line by line, especially its
passage from finite spectral reality to global Weil positivity.

## Integrated framework update

The project now has three distinct layers:

```text
Layer 1: exact finite dictionary and tail certification
  coefficient vector -> band-limited test function -> exact zero sum

Layer 2: fixed-scale spectral operator
  truncated Weil form -> shifted quotient -> rank-one scaling operator

Layer 3: global scale limit
  expanding intervals / screw-function or common-space Weil form
  -> Mosco/resolvent/projection convergence
  -> Xi determinant and RH implication
```

## Revised next actions

1. Integrate the exact Groskin coefficient-to-test-function dictionary into
   the repository and compare it entry-by-entry with `candidate_q_reproduce.py`.
2. Implement the explicit archimedean tail budget and interval-arithmetic sign
   certification; stop using raw deep float eigenvalues as positivity evidence.
3. Audit the Suzuki screw-function operator as a parallel common-space model,
   especially its expanding-interval domain and scale parameter.
4. Use the Connes–van Suijlekom theorem as the finite real-zero lemma, with its
   precise lower-bound and simple-isolated hypotheses recorded explicitly.
5. Preserve the global convergence target: prove a common-space Mosco or
   equivalent transform convergence theorem. No cited paper found here proves
   that final step.

## Bottom line

The literature advances our framework in two concrete ways: it supplies an
exact finite coefficient-to-Weil-test-function map with certified tail order,
and it supplies a second screw-function/expanding-interval route for the
global machine. Neither route currently proves the global scale limit to Xi.
