# Cycle 72 — Bost–Connes Diagonal with SR Interaction

## Construction

The Bost–Connes finite diagonal is

\[
 D_X(s)=\operatorname{diag}(p^{-s}:p\le X),
 \qquad
 \det(I-D_X(s))=\prod_{p\le X}(1-p^{-s}).
\]

To test the proposed interaction, I added the off-diagonal SR sign matrix on the prime index set:

\[
 T_{X,\varepsilon}(s)=D_X(s)+\frac{\varepsilon}{\pi(X)}R_X,
\]

where `R_X(p,q)=-1` when `pq<X`, `+1` otherwise, and its diagonal was removed so the Euler diagonal is unchanged.

## Raw determinant output at s=2

| X | exact BC determinant | ε | determinant | difference |
|---:|---:|---:|---:|---:|
| 20 | 0.614233541119 | 0 | 0.614233541119 | ~0 |
| 20 | 0.614233541119 | .01 | 0.614202907885 | -0.00003063 |
| 20 | 0.614233541119 | .05 | 0.613463337380 | -0.00077020 |
| 20 | 0.614233541119 | .10 | 0.611131828379 | -0.003102 |
| 50 | 0.610288997785 | 0 | 0.610288997785 | ~0 |
| 50 | 0.610288997785 | .01 | 0.610258323511 | -0.00003067 |
| 50 | 0.610288997785 | .05 | 0.609513113553 | -0.0007759 |
| 50 | 0.610288997785 | .10 | 0.607140713366 | -0.003148 |
| 100 | 0.609033725400 | 0 | 0.609033725400 | ~0 |
| 100 | 0.609033725400 | .01 | 0.609003083168 | -0.00003064 |
| 100 | 0.609033725400 | .05 | 0.608256225195 | -0.0007775 |
| 100 | 0.609033725400 | .10 | 0.605866289227 | -0.003167 |

The Hermitian part also loses positivity under interaction. Its smallest eigenvalues for `epsilon=.1` were `-0.00943`, `-0.00740`, and `-0.01077` for `X=20,50,100`.

## Structural result

The diagonal BC operator already has the exact finite Euler determinant. A generic nonzero symmetric/off-diagonal SR interaction changes the determinant at second order, even when its diagonal is zero. Preserving the Euler determinant therefore requires a specially constrained determinant-one perturbation. Triangular/nilpotent perturbations are determinant-invisible but cannot supply a self-adjoint positivity mechanism; symmetric nonzero interactions generically change the determinant.

## P1–P6

| Property | Result |
|---|---|
| P1 | BC diagonal has exact finite Euler factors, but this is circular and does not locate zeros. |
| P2 | Exact prime Euler structure for the diagonal; SR interaction does not add a valid Lambda trace. |
| P3 | Interaction can destroy positivity; determinant-preserving triangular couplings are not self-adjoint. |
| P4 | No functional-equation involution. |
| P5 | Holds arithmetically. |
| P6 | Finite diagonal is trace class in the right half-plane, but no nontrivial continued RH operator results. |

## Verdict

**DEAD for the proposed SR interaction.** The exact Euler determinant and a nontrivial self-adjoint SR coupling are incompatible in this direct finite realization. The remaining Candidate C question reduces to engineered determinant-one couplings, already constrained by the triangular/gauge obstructions.
