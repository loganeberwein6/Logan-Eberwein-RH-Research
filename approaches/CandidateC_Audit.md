# Candidate C cycle — finite Bost–Connes diagonal operator

## Operator

\[
T_{BC,X}(s)=\operatorname{diag}(p^{-s}:p\le X),
\qquad
\det(I-T_{BC,X}(s))=\prod_{p\le X}(1-p^{-s}).
\]

## Raw numerical output

```text
X=20: det(1.5)=(0.41682169559543186+0j) det(2.0)=(0.6142335411190183+0j)
  minima: [(0.0, 0.012541), (0.005, 0.01254557), (0.01, 0.01255928), (0.015, 0.01258216), (0.02, 0.01261424)]
  at zeta gammas: [(14.1347, 8.124074328986879), (21.022, 3.570155122065875), (25.0109, 3.74043432071659), (30.4249, 4.758110855373297), (32.9351, 4.123706989436382)]
  top eigenvalue magnitudes: [0.707107 0.57735  0.447214 0.377964 0.301511 0.27735  0.242536 0.229416]
X=50: det(1.5)=(0.4019735475452824+0j) det(2.0)=(0.6102889977846369+0j)
  minima: [(0.0, 0.00338457), (0.005, 0.00338672), (0.01, 0.00339318), (0.015, 0.00340396), (0.02, 0.0034191)]
  at zeta gammas: [(14.1347, 9.748625296386177), (21.022, 5.26804248707439), (25.0109, 5.770845618519211), (30.4249, 5.705220063633329), (32.9351, 4.413760166914007)]
  top eigenvalue magnitudes: [0.707107 0.57735  0.447214 0.377964 0.301511 0.27735  0.242536 0.229416 0.208514 0.185695]
X=100: det(1.5)=(0.39519957107693005+0j) det(2.0)=(0.6090337253995164+0j)
  minima: [(0.0, 0.00095995), (0.005, 0.0009609), (0.01, 0.00096373), (0.015, 0.00096846), (0.02, 0.00097513)]
  at zeta gammas: [(14.1347, 8.680608407141282), (21.022, 5.752616376655434), (25.0109, 5.2863952401164465), (30.4249, 5.823755361511965), (32.9351, 4.689838780313252)]
  top eigenvalue magnitudes: [0.707107 0.57735  0.447214 0.377964 0.301511 0.27735  0.242536 0.229416 0.208514 0.185695]
```

## Verdict

**DEAD.** The determinant is the finite Euler product and has correct prime
arithmetic, but its critical-line minima are at zero rather than at zeta
zeros. Eigenvalue magnitudes are (p^{-1/2}); there is no geometric decay in
the prime index, so this does not give a nuclear operator on the critical
strip. Functional-equation symmetry and SR positivity are absent.

An upper-triangular or strictly triangular SR residual could preserve the
finite determinant, but then its determinant contribution is nilpotent and it
does not supply a self-adjoint positive interaction. A non-triangular
self-adjoint interaction changes the Euler determinant and loses P1.

## Exact interaction dichotomy

Let `D=diag(p^{-s})` and let `R` be an interaction. If `R` is strictly
upper triangular in the prime basis, then `D+R` is triangular and

\[
\det(I-D-R)=\prod_p(1-p^{-s}),
\]

but `D+R` is not self-adjoint unless `R=0`. If `R=R^*` is a nonzero
self-adjoint off-diagonal interaction, the determinant changes generically:
the coefficient of a small scalar interaction `epsilon` is

\[
\frac{d}{d\epsilon}\det(I-D-\epsilon R)\big|_{\epsilon=0}
=-\det(I-D)\operatorname{Tr}((I-D)^{-1}R),
\]

and higher-order terms are nonzero for generic `R`. Thus determinant
preservation and self-adjoint positivity cannot both be obtained by a generic
SR residual in this finite BC basis.
