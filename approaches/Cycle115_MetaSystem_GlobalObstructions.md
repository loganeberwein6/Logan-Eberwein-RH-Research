# Cycle 115 — Metamathematical Obstruction System

## Purpose

The seven difficulties are converted into proof obligations. This system does
not manufacture a proof by definition; it identifies exactly which estimates
would make the finite-to-infinite construction valid.

Let `H=L2_even(R)`, let `q` be the global Weil form, and let `q_j` denote the
finite forms after zero-extension into `H`, where `j` abbreviates `(lambda,N)`.

## Obstruction variables

Define the obstruction state

`E = (E_cl, E_lb, E_liminf, E_comp, E_cluster, E_op, E_det)`.

The components mean:

1. `E_cl`: failure of closability of `q` on the Schwartz core.
2. `E_lb`: failure of a uniform lower bound for `q_j` and `q`.
3. `E_liminf`: failure of the Mosco liminf inequality.
4. `E_comp`: failure of compactness/tightness of bounded form-energy sets.
5. `E_cluster`: failure to isolate and identify the limiting low-energy spectral
   projection.
6. `E_op`: failure of convergence of the Dirichlet-corrected scaling operators.
7. `E_det`: failure of locally uniform convergence of the normalized finite
   determinants to `Xi`.

The desired proof state is `E=0`, with each zero interpreted as a quantified
theorem, not as a numerical small residual.

## Solving the system logically

The dependencies are:

```text
core form convergence
        |
        v
closability + lower bound + Mosco liminf + compactness
        |
        v
strong resolvent convergence and Riesz-projection convergence
        |
        v
rank-one operator convergence
        |
        v
determinant convergence
        |
        v
Xi identification and RH implication
```

The minimal sufficient package is therefore not seven independent estimates.
It is:

`E_cl=E_lb=E_liminf=E_comp=0`,

plus an isolated limiting spectral cluster with controlled Dirichlet
functional. The abstract form theorem then forces `E_cluster=E_op=0`.
Finally, an explicit transform estimate forces `E_det=0`.

## Quantified target theorem

The system is solved if one proves:

1. `q` is a densely defined closed lower-semibounded form on `H`;
2. `q_j` Mosco-converges to `q` under the zero-extension embeddings;
3. bounded `q_j`-energy sequences are uniformly tight in `H`;
4. a finite-rank low-energy Riesz cluster remains separated by one common
   contour;
5. the Dirichlet evaluation functional is uniformly bounded on the form
   domain;
6. the normalized finite ground-state transforms converge locally uniformly
   to the nonzero function `Xi`.

Items 1–5 produce the infinite operator and convergence through the maps.
Item 6 identifies its determinant with Xi. Because each finite determinant has
real zeros, Hurwitz then yields RH.

## What the system reveals

The seven original obstacles are not seven unrelated mysteries. They reduce to
two fundamental analytic problems:

### A. Global Weil-form control

Prove closedness, lower boundedness, liminf stability, and compactness. The
positivity part is RH-strength and cannot be assumed silently.

### B. Ground-state transform identification

Prove that the selected low-energy spectral projection converges to the state
whose transform is Xi.

Everything else is a consequence of these two packages.

## Current status

- The common space, embeddings, core convergence, finite rank-one operator, and
  abstract projection theorem are constructed.
- The full global estimates making `E=0` are not proved.
- Therefore this metamathematical system identifies the exact thing to solve,
  but does not itself solve RH.
