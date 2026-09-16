# Candidate E cycle — proposed integral operator

The proposed kernel was

```text
K(x,y,s) = Σ_{n≥1} Rees(n, floor(y/x)) (x*y)^(-s/2).
```

This is not a well-defined operator as stated. It omits:

- the domain and measure for (x,y);
- the range and convergence interpretation of the infinite (n)-sum;
- the treatment of `floor(y/x)=1` when the Rees support starts at `2`;
- boundary conditions and the operator domain;
- a finite discretization scheme with which to define `T_X` and
  `det(I-T_X)`.

Different choices change the operator and its determinant. Consequently no
honest P1–P6 numerical audit can be run until these data are specified. This
is a construction-level failure, not evidence for or against RH.

Verdict for the stated Candidate E: **UNDEFINED**, pending a precise kernel
and functional-analytic domain.

## Minimal logarithmic-grid completion

To test whether the ambiguity was merely formal, I chose the smallest explicit
completion: `x,y` on a 40-point logarithmic grid in `[1,X]`, measure `dy/y`
by trapezoidal weights, `n=2,...,X-1`, and Rees value zero when
`floor(y/x)<2`. The resulting discretized operator gave:

```text
X=20:  |det(I-K)|=1.0, top singular values at s=1.5:
        2.473122, 0.558282, 0.219744, 0.169521, 0.148417
X=50:  |det(I-K)|=1.0, top singular values:
        6.433364, 1.523190, 0.663877, 0.477466, 0.409691
X=100: |det(I-K)|=1.0, top singular values:
        12.806393, 3.217084, 1.501811, 0.998090, 0.834064
```

The same determinant magnitude was one at the tested critical-line ordinate
`1/2+14.1347i`. The singular spectrum grows with `X` rather than decaying,
so this discretization is not nuclear. The determinant behavior is consistent
with a triangular/nilpotent discretization artifact, not a zeta Fredholm
determinant. The precise completion therefore fails P1, P3, and P6; changing
the grid or boundary convention changes the object and cannot repair the
missing analytic specification.

## Verdict after completion

**DEAD/UNDEFINED.** The stated Candidate E does not define a unique operator,
and the minimal explicit completion has trivial determinant and non-nuclear
growth.
