# Cycle 126 — Finite Completed Xi Convergence

`finite_completed_xi.py` multiplies the finite prime Euler determinant by the
archimedean factor `1/2*s*(s-1)*pi^(-s/2)*Gamma(s/2)`.

The approximation converges toward completed `xi(s)` in the Euler-product
region:

```text
s=1.5: error 7.57e-2 -> 1.40e-3  (cutoff 10 -> 5000)
s=2.0: error 1.59e-2 -> 1.10e-5
s=3.0: error 1.04e-3 -> 1.27e-9
s=2+3i: error 5.77e-3 -> 3.10e-6
```

This verifies the finite completed-determinant architecture where the Euler
product converges. It does not extend the determinant through the critical
strip, does not establish a trace-class/self-adjoint operator there, and does
not prove zero reality. Those are the remaining spectral completion steps.
