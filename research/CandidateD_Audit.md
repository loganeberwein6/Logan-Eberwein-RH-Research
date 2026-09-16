# Candidate D cycle — Eisenstein-Hecke scalar model

## Explicit model

Because the objective does not specify a canonical finite coefficient matrix,
the audit used the diagonal Eisenstein scalar model

\[
\lambda_n(s)=\sum_{d\mid n}d^{s-1},
\qquad
\det(I-H_X(s))=\prod_{2\le n\le X}(1-\lambda_n(s)n^{-s}).
\]

The trivial (n=1) factor was omitted because it would make the determinant
identically zero.

## Raw output

```text
X=20: det(1.5)=(0.0007729209051773998+0j) det(2.0)=(0.005582202524580439+0j)
  minima: [(0.0, 0.0), (0.005, 0.0), (0.01, 0.0), (0.015, 0.0), (0.02, 0.0)]
  at zeta gammas: [(14.1347, 1.5365823623604704), (21.022, 0.9361017623469998), (25.0109, 1.3745410804419431), (30.4249, 1.2563889934468682), (32.9351, 1.406844402463051)
X=50: det(1.5)=(8.474398435080301e-05+0j) det(2.0)=(0.00123786595022343+0j)
  minima: [(0.0, 0.0), (0.005, 0.0), (0.01, 0.0), (0.015, 0.0), (0.02, 0.0)]
  at zeta gammas: [(14.1347, 1.688647215080301), (21.022, 0.8836626237658805), (25.0109, 1.5609395032920341), (30.4249, 1.321707137547164), (32.9351, 1.2234318775471644)]
```

## Verdict

**DEAD.** The finite determinant has a persistent zero at (gamma=0), not at
the nontrivial zeta ordinates. The diagonal scalar model also has no SR
coercivity and no functional-equation symmetry. Adding a non-diagonal SR
interaction would require a new Hecke-compatible construction; it is not
present in this model.

## Structural reason the scalar reduction is unavoidable here

On the one-dimensional Eisenstein eigenspace, every Hecke operator acts by its
scalar eigenvalue. Consequently a finite truncation of that eigenspace is
diagonal and its determinant is a product of scalar local factors. A genuine
matrix-valued Hecke model would require choosing a nontrivial automorphic
representation or a space of cusp forms; that changes the arithmetic object
and is not specified by the SR construction. Therefore the present candidate
cannot obtain SR positivity by an internal Hecke interaction without leaving
the candidate class.
