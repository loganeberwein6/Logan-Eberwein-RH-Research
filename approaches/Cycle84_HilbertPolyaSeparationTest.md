# Cycle 84 — Hilbert–Pólya Separation Test

## Tautological self-adjoint model

Given known zeta ordinates `gamma_n`, define the finite self-adjoint operator

\[
 H_N=\operatorname{diag}(\gamma_1,\ldots,\gamma_N).
\]

Its characteristic determinant

\[
 D_N(t)=\det(tI-H_N)
\]

has real zeros at the inserted ordinates and its quadratic form is positive because `H_N>0`.

## Raw diagnostics

For the first five ordinates `[14.1347,21.0220,25.0109,30.4249,32.9351]`:

| t | `det(tI−H₅)` |
|---:|---:|
| 0 | -7446944.080935123 |
| 14.1347 | 0 |
| 14.0 | -3239.0792687228104 |
| 21.0220 | 0 |

The smallest eigenvalue is `14.1347`, the trace is `123.5276`, and the sum of inverse eigenvalues is `0.2215302158`.

## Why this is not the required operator

The construction inserts the zeta zeros as input. It has no arithmetic origin, no derivation of the prime-power weights, no functional equation beyond the chosen real spectrum, and no convergence theorem connecting finite arithmetic truncations to `H`. The infinite diagonal operator with eigenvalues growing like the zeta ordinates is unbounded and is not itself trace class; only suitable resolvents or heat functions can be trace class.

This cleanly separates the Hilbert–Pólya requirements:

1. self-adjointness can force a real spectrum;
2. positivity can be supplied by a lower-bounded `H`;
3. the unresolved step is constructing `H` arithmetically and proving its spectrum is exactly the zeta-zero spectrum;
4. a Fredholm determinant requires a trace-class regularization of `H` or its resolvent;
5. the Weil form must connect that regularization to the explicit formula.

## P1–P6

| Property | Result |
|---|---|
| P1 | Holds tautologically for the inserted zeros, not arithmetically. |
| P2 | Fails: no Lambda/prime structure. |
| P3 | Holds for the finite positive diagonal model. |
| P4 | Not derived. |
| P5 | Fails: spectral data are supplied externally. |
| P6 | Finite model is trivial; infinite operator is unbounded and needs regularization. |

## Verdict

**Not a solution; exact separation of the Hilbert–Pólya gap.** Any claimed success must replace the inserted `gamma_n` by a construction from integers/adelic data and prove the spectrum rather than fit it.
