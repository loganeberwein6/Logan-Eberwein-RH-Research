# Cycle 34: minimal indefinite linearization of the completed target

## Construction

Let `f(s)=1/xi(s)`. The two-dimensional pencil

`H_f(s) = [[0,1],[-f(s),0]]`

has

`det(H_f(s))=f(s)`

and characteristic equation `lambda^2+f(s)=0`. On the critical line, `f` is
real, so the pencil is a real `J`-self-adjoint linearization for an indefinite
metric, but it is not an ordinary positive/self-adjoint operator family.

## Critical-line diagnostic

```text
t=0:   f= 2.01158,       sqrt(-f)= 1.41830 i
t=10:  f= 26.3381,       sqrt(-f)= 5.13206 i
t=14:  f= 4967.85,       sqrt(-f)=70.4830 i
t=15:  f=-1417.04,       sqrt(-f)=37.6435
t=20:  f=-27281.1,       sqrt(-f)=165.170
t=22:  f=129595.5,       sqrt(-f)=359.994 i
t=26:  f=-1544691,       sqrt(-f)=1242.856
t=31:  f=131388984,      sqrt(-f)=11462.50 i
```

The eigenvalue type switches between real and imaginary precisely when the
completed determinant changes sign across a zero. This is unavoidable for this
linearization and is the finite-dimensional version of Cycle 30's positivity
obstruction.

## Interpretation

This construction proves only a formal realization of P1 at dimension two. It
does not encode arithmetic, nuclearity, or the Euler product. Its value is
diagnostic: any successful operator with determinant `1/xi` must either be
indefinite/J-self-adjoint on the critical line or use a larger Weil form whose
positivity statement is not positivity of the determinant operator itself.

## Verdict

**Formal P1 linearization, not a candidate solution.** It confirms that the
remaining problem is genuinely the construction of an arithmetic, nuclear,
functional-equation-compatible indefinite pencil with a non-circular coercive
criterion.
