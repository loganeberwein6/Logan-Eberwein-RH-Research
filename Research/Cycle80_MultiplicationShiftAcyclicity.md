# Cycle 80 — Infinite Multiplication-Shift Acyclicity

## Construction

Use the natural arithmetic semigroup representation on basis vectors `e_n`:

\[
 S_p(s)e_n=p^{-s}e_{pn},
\]

and finite combinations

\[
 A_X(s)=\sum_{p\le P}a_p(s)S_p(s)
\]

restricted to `n<=X`, with edges retained only when `pn<=X`. This is the most direct infinite-state multiplicative analogue of a Bost–Connes/semigroup transition operator.

## Exact structural result

Every edge strictly increases the positive integer label. Ordering the basis by `n` makes every finite truncation strictly upper or lower triangular. Hence

\[
 A_X(s)^k\text{ has zero diagonal for every }k\ge1,
 \qquad
 \operatorname{Tr}(A_X(s)^k)=0,
 \qquad
 \det(I-A_X(s))=1.
\]

This remains true for arbitrary complex edge weights and for any finite set of multiplicative generators.

## Raw diagnostics

For generators `p=2,3,5,7`, the finite matrix was tested at `X=20,50,100` and both `s=1.5` and `s=0.5+14.1347i`:

| X | s | determinant | largest eigenvalue magnitude | traces of powers 1–4 |
|---:|---|---:|---:|---|
| 20 | 1.5 | 1 | 0 | 0, 0, 0, 0 |
| 20 | 0.5+14.1347i | 1 | 0 | 0, 0, 0, 0 |
| 50 | 1.5 | 1 | 0 | 0, 0, 0, 0 |
| 50 | 0.5+14.1347i | 1 | 0 | 0, 0, 0, 0 |
| 100 | 1.5 | 1 | 0 | 0, 0, 0, 0 |
| 100 | 0.5+14.1347i | 1 | 0 | 0, 0, 0, 0 |

## Consequence

Multiplication alone has no closed arithmetic orbits. Fredholm determinants and trace-log Euler products count closed cycles, so an acyclic semigroup graph cannot produce `1/ζ`, `-ζ'/ζ`, or zeta zeros. Adding reverse edges creates cycles, but then mixed composite cycles appear and require the primitive-cycle cancellation problem already documented in Cycles 54–60.

The infinite untruncated shifts are also not trace class in the naive form: `S_p` is a scalar multiple of an isometry on its range, so its singular values do not decay. Thus passing from finite nilpotent truncations to the infinite representation does not repair P6 automatically.

## P1–P6

| Property | Result |
|---|---|
| P1 | Fails: determinant is identically 1 in finite truncations. |
| P2 | Multiplicative labels are present, but no closed-cycle Lambda trace exists. |
| P3 | No coercive Weil form. |
| P4 | No `s ↔ 1-s` symmetry. |
| P5 | Exact arithmetic origin. |
| P6 | Naive infinite shifts are not trace class; finite approximants are nilpotent. |

## Verdict

**Class obstruction.** The natural infinite multiplication representation supplies arithmetic labels but no determinant mechanism. A successful global arithmetic operator must add a non-acyclic dynamical/automorphic structure and a trace-class regularization simultaneously.
