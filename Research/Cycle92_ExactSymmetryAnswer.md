# Cycle 92 — Exact Answer: What Would Force the Critical Line?

## Definitive answer

No such independently proved symmetry is currently known.

The zeta function has the exact symmetries

\[
 \rho\mapsto 1-\rho,
 \qquad
 \rho\mapsto\overline\rho,
 \qquad
 \rho\mapsto1-\overline\rho.
\]

The combined involution `rho -> 1 - conjugate(rho)` has fixed set `Re(rho)=1/2`. But symmetry alone does not force a zero to be fixed: an off-line zero can occur in a four-element orbit

\[
 \rho,quad 1-\rho,quad\bar\rho,quad1-\bar\rho.
\]

Therefore the functional equation is necessary symmetry, not the missing forcing principle.

## The exact forcing principle, if an operator existed

The required additional statement would be a self-adjoint spectral realization

\[
 \rho=\frac12+i\lambda,
 \qquad \lambda\in\operatorname{Spec}(H),
 \qquad H=H^*.
\]

Self-adjointness forces `lambda` to be real, hence every represented zero lies on `Re(rho)=1/2`. Equivalently, on the explicit-formula side, the required statement is

\[
 Q_{\mathrm{Weil}}(h)\ge0
 \quad\text{for every admissible test function }h.
\]

Weil's criterion says this positivity is equivalent to RH. It is not currently proved independently.

Thus the exact answer is:

> The symmetry that identifies the critical line is the antiunitary functional-equation involution `rho -> 1-conjugate(rho)`, but the property that would prevent an off-line orbit is self-adjointness/Weil positivity. No theorem currently constructs an arithmetic operator with that property. Claiming that the symmetry alone prevents negative directions or off-line zeros would be false.

## Relevance to the project

The missing theorem is not another local symmetry. It must prove that the global arithmetic quadratic form is positive (or that the corresponding spectral pencil is self-adjoint/definitizable) and that its determinant or spectral measure is exactly the completed zeta object. That theorem would imply RH; it is presently the unresolved part of the problem.
