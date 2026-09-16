# Cycle 83 — Superdeterminant Doubling Obstruction

## Question

Can the graded divisor-complex ratio

\[
 \operatorname{sdet}(A_+\oplus A_-)=\frac{\det A_+}{\det A_-}
\]

be replaced by an ordinary positive determinant on a doubled Hilbert space?

## Direct positive doubling fails

The ordinary block determinant of a positive direct sum is

\[
 \det(A_+\oplus A_-)=\det A_+\det A_-,
\]

which has the wrong inverse dependence on the odd sector. Adding a self-adjoint coupling gives a block matrix

\[
 M=\begin{pmatrix}A_+&C\\C^*&A_-\end{pmatrix},
\]

whose Schur complement is

\[
 \det M=\det(A_-)det(A_+-CA_-^{-1}C^*).
\]

The inverse `A_-^{-1}` is exactly the missing superdeterminant ingredient. It introduces poles when the odd sector has zero modes and does not yield `det(A_+)/det(A_-)` as an ordinary positive determinant. If `A_+` and `A_-` are positive, the direct block determinant remains positive and has product-type, not ratio-type, divisor structure.

## Scalar diagnostic

For positive scalars `a,b` and real coupling `c`,

\[
 \det\begin{pmatrix}a&c\\c&b\end{pmatrix}=ab-c^2.
\]

The tested values were:

| `(a,b)` | `c` | block determinant | ratio `a/b` | block eigenvalues |
|---|---:|---:|---:|---|
| (2,3) | 0 | 6 | 0.6667 | 2,3 |
| (2,3) | 1 | 5 | 0.6667 | 1.3820,3.6180 |
| (3,2) | 0 | 6 | 1.5 | 2,3 |
| (3,2) | 1 | 5 | 1.5 | 1.3820,3.6180 |
| (5,7) | 0 | 35 | 0.7143 | 5,7 |
| (5,7) | 1 | 34 | 0.7143 | 4.5858,7.4142 |

Coupling preserves positivity but cannot turn a product into a ratio.

## Consequence

The divisor-complex superdeterminant cannot be converted into an ordinary positive determinant by finite bosonic doubling. Any exact conversion must use an inverse/Schur-complement sector, a non-positive indefinite pencil, or a genuine fermionic/supergeometric formalism. Each option leaves the ordinary positive Fredholm target and therefore does not solve P3.

## Verdict

**Class obstruction.** Graded cohomological cancellation and ordinary positive determinant positivity cannot be combined by finite block doubling. The missing SR-to-Weil construction must use a global Weil quadratic form rather than trying to hide the grading inside a positive determinant.
