# Cycle 73 — Self-Adjoint Euler-Coupling Obstruction

## Theorem

Let `D=diag(d_1,...,d_n)` be real diagonal with `d_i<1`, and let `K=K^T` be a real symmetric matrix with zero diagonal. Define

\[
 F(\varepsilon)=\det(I-D-\varepsilon K).
\]

If `K != 0`, then `F(epsilon)` is not identically `F(0)`.

## Proof

Put `A=I-D`, which is positive definite, and set

\[
 B=A^{-1/2}KA^{-1/2}.
\]

Then `B` is real symmetric and nonzero, and

\[
 F(\varepsilon)=\det(A)\det(I-\varepsilon B).
\]

Because `K` has zero diagonal and `A^{-1}` is diagonal,

\[
 \operatorname{tr}(B)=\operatorname{tr}(A^{-1}K)=0.
\]

The second derivative of the logarithm at zero is

\[
 \left.\frac{d^2}{d\varepsilon^2}\log\det(I-\varepsilon B)\right|_{\varepsilon=0}
 =-\operatorname{tr}(B^2).
\]

Since `B` is real symmetric and nonzero, `tr(B^2)=sum_i lambda_i(B)^2>0`. Hence the second derivative is strictly negative, so `F` cannot be constant.

## Interpretation

For every finite Bost–Connes diagonal with real `s>1`, any nonzero real symmetric zero-diagonal SR interaction changes the exact Euler determinant. This is independent of the particular threshold pattern. The numerical Cycle 72 results are instances of this theorem.

The only determinant-preserving perturbations must therefore be outside this class: triangular/nilpotent, non-self-adjoint, or specially nonlinear parameter-dependent similarities. Triangular perturbations are determinant-invisible and cannot transfer a nontrivial self-adjoint SR coercivity form. Similarities preserve the spectrum and likewise add no new spectral information.

## Relation to the six properties

- P1/P2 can be obtained by the diagonal Euler operator, but only circularly.
- A nonzero self-adjoint arithmetic interaction cannot preserve those exact determinant factors in this finite class.
- Therefore P3 cannot be imported from SR by a direct symmetric coupling.
- P4 and P6 remain independent missing requirements.

## Class-level verdict

The entire class

\[
 \{D_X(s)+\varepsilon K_X:\ D_X(s)\text{ is the prime Euler diagonal},\ K_X=K_X^T,\ \operatorname{diag}K_X=0\}
\]

is ruled out as a route to an exact Euler determinant plus a nontrivial self-adjoint SR interaction. Any successful construction must use a different Weil quadratic form, not a direct symmetric perturbation of the Euler diagonal.
