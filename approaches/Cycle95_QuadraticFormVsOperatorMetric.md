# Cycle 95 — The Missing Item Is the Function-Space Metric

## Definitive diagnosis

The finite arithmetic Weil construction currently produces a symmetric bilinear form `W` on a finite list of test-function coordinates. It does **not** yet produce an operator, because no Hilbert-space inner product or reference Gram matrix has been specified.

If the coordinates are changed by an invertible matrix `S`, the same bilinear form is represented by

\[
 W\longmapsto S^TWS.
\]

Its ordinary eigenvalues, condition number, and apparent small eigenvalues can change dramatically. Its inertia and positivity do not change. Therefore the collapsing eigenvalues in Cycles 91 and 94 cannot, by themselves, tell us whether a scalar normalization, quotient, or completion is missing.

## Correct operator conversion

Choose a reference inner product with Gram matrix `G>0` on the test-function coordinates. The associated operator is defined by

\[
 W(v,w)=\langle Av,w\rangle_G,
 \qquad\text{equivalently}\qquad
 A=G^{-1}W,
\]

or, in an orthonormalized representation,

\[
 A_G=G^{-1/2}WG^{-1/2}.
\]

The meaningful spectral test is the generalized eigenproblem `Wv=lambda Gv`, not the raw eigenproblem `Wv=lambda v` unless the coordinates are already proven orthonormal.

## What this rules out

- A scalar rescaling of `W` cannot determine the correct operator metric; it only rescales all eigenvalues.
- A finite-dimensional quotient cannot be justified merely from small raw eigenvalues; it may remove legitimate high-frequency test directions.
- Conditioning alone is not evidence of a missing arithmetic constant.
- Positivity is basis-invariant, but numerical eigenvalue size is not.

## The actual missing theorem

The next required object is a canonical arithmetic/test-function Hilbert space and its Gram form `G`, with proofs that:

1. the prime/gamma bilinear form is continuous or closable in that norm;
2. its generalized operator has a well-defined limiting spectrum;
3. the functional involution is unitary or antiunitary in that norm;
4. the Weil positivity statement is preserved;
5. the Fredholm regularization is trace class.

This is a definitive structural answer to the “which missing thing?” question: the finite matrix is not missing a single fitted value; it is missing the reference function-space metric that turns the global form into an operator.

## Status

The arithmetic finite form is built. The canonical `G` is not yet identified. Until it is, raw finite condition numbers cannot distinguish a true compact operator from a bad coordinate representation.
