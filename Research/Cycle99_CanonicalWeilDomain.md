# Cycle 99 — Canonical Domain Selected by the Explicit Formula

## Definitive structural choice

The arithmetic and functional-equation data canonically select the even
Schwartz test-function space on the real logarithmic axis:

\[
 \mathcal S_{\mathrm{even}}(\mathbb R)
 =\{h\in\mathcal S(\mathbb R):h(x)=h(-x)\}.
\]

This is not an arbitrary numerical metric. It is the standard domain on which:

- Fourier transformation is continuous and involutive;
- evaluation at logarithms of prime powers is defined;
- the archimedean gamma distribution acts continuously;
- the explicit formula is meaningful;
- functional-equation reflection is represented by parity/Fourier duality.

## Required completion

The finite matrices should not be completed in ordinary coordinate Euclidean
norm. They should be viewed as restrictions of the explicit-formula quadratic
form `Q_Weil` to finite-dimensional subspaces of `S_even(R)`. If `Q_Weil` is
semibounded, its closure defines a form domain `D(Q_Weil)` and, by the
representation theorem for closed semibounded forms, an associated
self-adjoint operator.

The conditional chain is:

```text
even Schwartz test functions
    -> closed Weil quadratic form
    -> self-adjoint operator associated with the closed form
    -> spectral parameter on the critical line, if the zero/determinant
       identification is proved
```

## What this resolves

The missing completion is the closed domain of the global Weil form on even
Schwartz functions, not a fitted diagonal weight, ordinary fixed-window L2,
or a finite-dimensional quotient chosen from small eigenvalues. The
logarithmic/Mellin structure belongs in the Fourier transform and prime
evaluation functionals; it does not determine an arbitrary Sobolev exponent.

## What remains unproved

This canonical domain does not solve RH automatically. The unresolved theorems
are:

1. semiboundedness/positivity of the full Weil form;
2. convergence of the finite arithmetic matrices to the closed form;
3. trace-class or Fredholm regularization;
4. an exact determinant/spectral identity with completed xi;
5. the implication from form positivity to the full zero set.

Full nonnegativity of the Weil form is equivalent to RH. Thus the domain is
structurally identified, but its required positivity is the hard theorem rather
than an assumption that can be certified numerically.

## Verdict

**Canonical missing object identified conditionally:** the closed global Weil
form on even Schwartz test functions. This is the only candidate among the
tested missing structures selected by the explicit formula itself. Its useful
positive spectral realization remains an open mathematical claim.
