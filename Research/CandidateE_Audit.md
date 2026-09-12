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
