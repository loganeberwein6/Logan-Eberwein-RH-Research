# Impossibility theorem: Rees-congruence class

## Class

Fix `X >= 6` and let `R_X` be the real symmetric Rees sign matrix on
`{2,...,X-1}`:

\[
 R_X(m,n)=\begin{cases}-1&mn<X,\\+1&mn\ge X.\end{cases}
\]

Consider every weighted operator of the form

\[
 T_X(s)=c_X(s)D_X(s)R_XD_X(s),
\]

where `c_X(s)>0` and `D_X(s)` is a real diagonal matrix with nonzero entries.
This includes all separable row/column weightings
`w_m(s)R_X(m,n)w_n(s)` used by the SR, log-weighted, Lambda-weighted,
and Rees--GCD congruence proposals.

## Theorem

Every member of this class is indefinite for every `X >= 6`.  Hence no member
can satisfy a positive-semidefinite version of P3 at any such truncation.

## Proof

For `X=6`, the principal submatrix on indices `(2,3)` is

\[
 \begin{pmatrix}-1&+1\\+1&+1\end{pmatrix},
\]

whose determinant is `-2`.

For `X>=7`, the principal submatrix on `(2,3)` is

\[
 \begin{pmatrix}-1&-1\\-1&+1\end{pmatrix},
\]

whose determinant is again `-2`.

After diagonal congruence, the same principal minor becomes

\[
 -2\,c_X(s)^2d_2(s)^2d_3(s)^2<0.
\]

A real symmetric matrix with a negative principal `2 x 2` determinant has one
positive and one negative direction on that coordinate plane. Therefore
`T_X(s)` is indefinite. This argument does not depend on the size of `X`, the
weight formula, or asymptotic estimates.

## Consequences

1. No nonzero separable weighting of the SR sign matrix can satisfy positivity.
2. Inserting `Lambda`, `log`, powers of `n`, GCD weights, or phase magnitudes
   cannot repair P3 while remaining in this class.
3. Allowing a zero diagonal weight can remove the displayed obstruction only by
   deleting an arithmetic coordinate; if all coordinates needed for P2 remain,
   the same argument applies to any two retained coordinates with nonzero
   weights.
4. A successful operator must leave the Rees-congruence class: it needs a
   genuinely nonseparable interaction, a different positive kernel, or a
   different quadratic form whose positivity is not positivity of `R_X` after
   diagonal congruence.

## Computational confirmation

The unweighted spectra were also computed:

```text
X=6:   min=-1.64575131106 max=3.64575131106 negative_count=1
X=10:  min=-3.40843154002 max=6.98917724973 negative_count=2
X=20:  min=-5.93569938251 max=16.3294802993 negative_count=3
X=50:  min=-12.252178454 max=45.0970013103 negative_count=6
X=100: min=-19.731533723 max=94.1157972983 negative_count=8
```

This theorem is a genuine class-level elimination, not merely a failed fit.
It does not rule out operators that use nonseparable arithmetic dynamics,
such as a new transfer operator with a different positive form.
