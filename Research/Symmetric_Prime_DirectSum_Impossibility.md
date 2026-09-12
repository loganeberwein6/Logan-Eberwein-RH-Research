# Class theorem: direct reflected prime spectra cannot be nuclear

## Class

Consider a prime-loop determinant represented by a direct sum whose spectrum
contains, for every prime p, both

\[
 \lambda_p(s)=p^{-s}
 \quad\text{and}\quad
 \lambda_p(1-s)=p^{-(1-s)}.
\]

This includes the minimal way of imposing exact s <-> 1-s symmetry on the
prime diagonal Euler operator.

## Theorem

No such direct-sum operator is trace class for any s with Re(s)>1/2.

## Proof

Write sigma=Re(s). The absolute values of the reflected eigenvalues are

\[
 |p^{-(1-s)}|=p^{\sigma-1}.
\]

Trace class requires the sum of absolute eigenvalues to converge, but

\[
 \sum_p p^{\sigma-1}
 =\sum_p p^{-(1-\sigma)}
\]

diverges whenever 1-sigma <= 1, which holds for every sigma >= 0 and in
particular for the required half-plane sigma>1/2. In fact the individual
reflected eigenvalues do not even tend to zero when sigma>=1.

Therefore the direct sum cannot define a compact, trace-class, or Fredholm
determinant operator on the target half-plane.

## Consequence

The functional equation cannot be imposed by simply adjoining the reflected
Euler spectrum. A successful construction must use a regularized completion
in which the reflected contribution is represented through a different state
space or cancellation mechanism. Such a regularization must be proved to
preserve the determinant identity; multiplying by a formal gamma factor is
not sufficient.

This theorem is independent of the SR/Rees obstruction and eliminates a
separate direct-sum class.
