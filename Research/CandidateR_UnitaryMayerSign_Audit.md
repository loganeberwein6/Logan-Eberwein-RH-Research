# Candidate R: unitary/sign conjugation of Mayer

## Class

Let `L_s` be the nuclear Mayer transfer operator and let `U_X` be any bounded
unitary or boundedly invertible arithmetic sign operator (for example a
diagonal matrix with entries `+1` and `-1`). Define

`T_X(s) = U_X L_s U_X^{-1}`.

This is the minimal determinant-preserving way to insert SR signs.

## Exact obstruction

Similarity gives

\[
 I-T_X=U_X(I-L_s)U_X^{-1},
 \qquad
 \det_F(I-T_X)=\det_F(I-L_s).
\]

The entire spectrum, algebraic multiplicities, Fredholm determinant, trace
powers, and nuclear singular-value class are unchanged. For the Mayer operator
the determinant therefore remains

\[
\det_F(I-T_X(s))=\frac{\zeta(2s-1)}{\zeta(2s)}.
\]

No choice of arithmetic sign pattern can move its divisor set to the
nontrivial zeta zeros.

## P1--P6 audit

| Property | Status | Reason |
|---|---|---|
| P1 | fail | determinant divisor set is unchanged from Mayer |
| P2 | partial | orbit arithmetic is unchanged, so no new von Mangoldt trace identity appears |
| P3 | unchanged | unitary conjugation cannot create a new spectral lower bound |
| P4 | unchanged | no new `s <-> 1-s` relation is introduced |
| P5 | yes if `U_X` is arithmetic | construction can use integer signs |
| P6 | yes if `U_X` is uniformly bounded | nuclearity is preserved, but this does not fix P1--P4 |

## Verdict

**DEAD as a determinant-preserving SR deformation.** Any successful Mayer/SR
deformation must be a genuinely non-similar perturbation. Such a perturbation
must then supply a new determinant identity while preserving nuclearity and
functional symmetry; it cannot be obtained by sign conjugation alone.
