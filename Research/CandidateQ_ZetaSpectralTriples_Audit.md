# Cycle 18: Zeta Spectral Triples / Weil-form operator

## External candidate identified

The 2025 paper by Connes, Consani, and Moscovici constructs self-adjoint
operators as rank-one perturbations of the scaling operator on
[lambda^(-1),lambda]. The construction uses restricted Euler products over
primes p <= x=lambda^2, a finite Weil quadratic form, and a truncated
Fourier subspace.

The paper states a regularized determinant identity of the form

\[
 \det_{\rm reg}(D_{\log}^{(\lambda,N)}-z)
 =-i\,\lambda^{-iz}\widehat{\xi}(z),
\]

where widehat-xi is the Fourier transform of the selected eigenvector,
and the operator is self-adjoint under the modified Weil-form inner product.

## Why this is materially different

This is not:

- a Rees diagonal congruence;
- a prime diagonal with a reflected divergent block;
- a Mayer transfer determinant;
- a positive Lambda Gram norm.

It uses a nonseparable Weil quadratic form and obtains self-adjointness from a
rank-one perturbation plus a changed inner product. It is therefore in the
remaining open class identified in Stage 40.

## P1--P6 audit

| property | result | evidence/status |
|---|---|---|
| P1 | promising, unproved globally | the regularized determinant has zeros given by widehat-xi, but convergence of widehat-xi to the Riemann Xi function is still a missing step |
| P2 | promising | the Weil explicit formula contains the non-archimedean terms log(p) and prime powers |
| P3 | promising | the finite Weil quadratic form yields self-adjoint/lower-bounded operators |
| P4 | promising | the construction is built from the Weil form and inversion symmetry, but exact limiting completed-zeta symmetry must be proved |
| P5 | yes | restricted Euler products and finite-prime arithmetic data |
| P6 | partial | each finite/truncated operator is controlled, but the limit and determinant convergence remain open |

## Missing mathematical steps

The source explicitly leaves two central steps open:

1. prove that the smallest eigenvalue of the finite Weil quadratic form is
   simple and that its eigenvector is even;
2. prove that the selected finite eigenvector converges sufficiently to the
   limiting vector so that its Fourier transform converges to Riemann's
   Xi function.

Without those steps, this is not a proof of RH. The source itself states that
establishing the convergence would amount to proving RH.

## Repository relationship

The prior SR work supplies a finite coercive threshold form, but not the Weil
form or the scaling-operator state space. The exact class-level Rees
indefiniteness theorem therefore does not eliminate this candidate. This
candidate is a new external framework, not an SR perturbation.

## Verdict

**PROMISING BUT INCOMPLETE.** This is the first candidate found in the search
that simultaneously addresses arithmetic prime weights, self-adjointness,
functional/inversion symmetry, and regularized spectral determinants without
falling into the previously eliminated classes. It does not yet satisfy all
six properties because determinant convergence and the simple-even
eigenvector theorem are missing.

## Next concrete work

The next repository task is to reproduce the finite Weil-form matrix from the
paper for small lambda,N, verify self-adjointness and the regularized
determinant numerically, and isolate exactly which convergence estimate would
be needed to connect it to Xi.
