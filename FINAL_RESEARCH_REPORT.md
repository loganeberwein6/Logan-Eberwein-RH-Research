# Riemann Hypothesis finite-source program: verified research state

Date: 2026-08-31

## Current exact root

The supplied program reduces its live task to

\[
B\|D\|_\omega^2+\mathcal Q^{av}\le(4-L)^2,
\]

where

\[
x_{\rm obs}=\left(\sqrt B,D,
a\mapsto\sqrt B,P(\Theta_aV_M)\right),
\qquad
\|x_{\rm obs}\|^2=B\|D\|_\omega^2+\mathcal Q^{av}.
\]

The displayed A2R, PASE, and LP forms are reversibly equivalent. Cauchy--Schwarz gives

\[
L^2\le B\|D\|_\omega^2\le\|x_{\rm obs}\|^2,
\]

so LP itself forces (L\le2) and is equivalent to forward Lorentz-cone membership. This is an exact reformulation, not a proof of the inequality.

## Proved new identities

1. On (H_X=\ell^2\{m<X\}), the finite divisibility shifts satisfy

   \[
   S_aS_b=S_{ab},\qquad E_a=I-S_a^*S_a,
   \qquad E_{ab}=E_b+S_b^*E_aS_b.
   \]

   Their common exterior dilation on (\ell^2(\mathbb N)) obeys

   \[
   PV_a^*V_bP=S_a^*S_b+X_a^*X_b.
   \]

2. The actual stopped incidence connection is

   \[
   A_X=Z_X^{-1}[N,Z_X]
   =\sum_{n<X}\frac{\Lambda(n)}{\sqrt n}S_n.
   \]

   Forward products occur in (A_X^2); common-cofactor ratios occur in (A_X^*A_X).

3. For the shifted connection (L_0=2I+A_X),

   \[
   -\mathfrak dL_0+L_0^2
   =4I+\sum_{n<X}
   \frac{(\Lambda*\Lambda)(n)+\Lambda(n)(4-\log n)}{\sqrt n}S_n.
   \]

   At (p^k) the coefficient is

   \[
   p^{-k/2}\log p(4-\log p),
   \]

   and at (p^aq^b) it is (2\log p\log q/\sqrt{p^aq^b}). The central (2\delta_0) therefore contributes exactly (+4\Lambda), but the prime-power coefficient is negative beginning at (p=59).

4. Endpoint completion is the projection

   \[
   \Pi_T\alpha=\alpha-\alpha([0,T])\delta_T,
   \qquad \nu_M=\Pi_T\mu_M.
   \]

   It gives

   \[
   V_M(t)=\int[\cos(ts/M)-\cos2t],d\mu_M(s).
   \]

   At every prime-power support birth (M_0=\tfrac12\log N),

   \[
   \Delta m=\frac{\Lambda(N)}{\sqrt N},\quad
   \Delta C=\frac{\Lambda(N)}{\sqrt N}\cos2t,
   \quad \Delta V=0.
   \]

5. The canonical full-shift boundary completion on (L^2(0,\infty)) satisfies

   \[
   J^*W_\alpha^*W_\beta J
   =V_\alpha^*V_\beta+E_\alpha^*E_\beta.
   \]

   In particular (S_T=0), but (E_T) is isometric and (E_T^*E_r=S_{T-r}^*). The endpoint and every endpoint/interior path correlation survive in the exit history.

6. For the continuum Volterra operator (K=V_{e^{s/2}ds}), with (g=Kf),

   \[
   2\Re\langle Kf,f\rangle=|g(T)|^2-\|g\|_2^2.
   \]

   The natural continuum supply is indefinite and requires both terminal and bulk ports.

7. A rigorous central-jet realization is obtained from (D_0f=f'), (f(0)=0):

   \[
   [X,-2D_0]=2I,qquad
   \Re\langle-2D_0f,f\rangle=-|f(T)|^2.
   \]

   The operator (-2D_0) is maximal dissipative, but its natural boundary norm is not the PASE norm.

8. Under a frozen positive atomic perturbation, the LP defect (F) varies exactly as

   \[
   \Delta F=2aR_s+a^2K_s,
   \qquad
   K_s=B\|P\phi_s\|^2+q(\phi_s-\phi_T,\phi_s-\phi_T)\ge0.
   \]

   The unresolved term (R_s) is the full signed covariance with the existing completed state.

## Killed new routes

1. **Volterra-only endpoint colligation.** On (L^2(0,T)), (V_{\delta_T}=0), while the exact cosine observation is (\cos2t). This failure occurs inside the actual continuum-only source family.

2. **Raw Mangoldt connection as a Schur coefficient.** For (5<X\le6),

   \[
   \|A_Xe_1\|^2
   =\frac{3\log^22}{4}+\frac{\log^23}{3}+\frac{\log^25}{5}
   =1.2807141595\ldots>1.
   \]

   Hence (zA_X(I-zA_X)^{-1}) cannot be Schur with the actual coefficient.

3. **Generic groupoid positivity.** Finite one-prime and two-prime matrices put (A^2) and (A^*A) on different entries/diagonals and give the wrong inequality orientation.

4. **Coefficientwise shifted positivity.** It fails at the prime (59).

5. **A single (2\times2) nilpotent projective lift.** If (N^2=0), then ((NA)^2=0), so the lift erases (A_C^2), (A_P^2), and the central forward cross term.

6. **Source-independent scaling-stable passivity.** Relaxed scaling makes the LP quadratic fail for large amplitude.

7. **All-frequency cancellation.** Torus recurrence gives a sequence (t_j\to\infty) with

   \[
   V_M(t_j)\longrightarrow2(e^M-1).
   \]

## Deepest obstruction discovered

The surviving obstruction is a **faithfulness--metric--passivity incompatibility**.

- Finite causal compression has the correct semigroup product but erases the load-bearing endpoint.
- The full-shift/group completion restores every endpoint and illegal-path coefficient, but its natural Toeplitz Gram is not the weighted cosine/(\Theta_a)/coherent-subtraction PASE Gram.
- The exact arithmetic forward square carries Selberg products, while a Hilbert defect carries ratios and splits the central (+4A) across opposite polarizations.
- The raw critical Mangoldt connection is already noncontractive, and the continuum has an indefinite boundary-minus-bulk supply.
- Choosing the exact PASE Gram or the input norm (|4-L|) by hand gives a GNS/Schur realization that is target-equivalent to LP and supplies no new inequality.

This is deeper than the original semigroup-versus-group diagnosis because merely passing to the group completion is now proved insufficient: the faithful completion has the wrong canonical metric and no source-specific passive supply.

## Minimal workaround forced by the obstruction

A faithful candidate must simultaneously contain:

1. the uncompressed product path and full hard-exit history;
2. the total-mass coordinate and terminal direction producing (-m_M\delta_T);
3. at least three forward grades so (A) and (A^2) both survive, plus reverse grades for (A^*A);
4. the continuum bulk/terminal Krein pair;
5. both pair ports (\Theta_a,\tau_a);
6. the coherent (h)-coordinate and its (h^\perp) quotient;
7. a source-derived, rather than fitted, positive supply charge.

This structure is forced for information preservation. No proved natural form on it yet yields LP.

## Exact first unproved equation

After faithful recompletion, the first unsupported bridge is

\[
\text{natural arithmetic/boundary defect kernel}
=
\text{exact PASE observation kernel}.
\]

The kernels currently computed are different, so the naive equality is false. A successful replacement must derive a hidden state and conservation law

\[
\boxed{
(4-L)^2-\|x_{\rm obs}\|_{\mathcal X}^2
=\|z_{\rm hidden}\|^2
}
\]

from the actual completed arithmetic dynamics. Declaring (z_{\rm hidden}) by a square root of the left side is circular.

The corresponding first local arithmetic condition in a scale-induction attempt is the signed covariance inequality

\[
2R_s+aK_s\le0,
\]

together with continuous evolution between births. It is not presently lower-information than PASE because (R_s) contains the full completed covariance.

## Best hostile counterexample

The smallest structural endpoint counterexample is (0) versus (c\delta_T): they have the same Volterra operator and different exact cosine observations. The strongest actual-arithmetic Schur counterexample is (5<X\le6), where the first Mangoldt coefficient operator has norm greater than one.

## Best new invariants

- Operator invariant:
  \[
  PV_a^*V_bP=S_a^*S_b+X_a^*X_b,
  \]
  which identifies missing ratio mass exactly as rendezvous through illegal common multiples.

- Arithmetic localization invariant:
  \[
  \Delta V=0,qquad \Delta F=2aR_s+a^2K_s,quad K_s\ge0,
  \]
  which isolates the precise signed covariance that prevents monotone scale induction.

## What must be back-substituted next

The next recursion must begin with the full-shift/graded boundary state and derive, without choosing the PASE metric by definition, an observation and supply identity whose Schur complement is exactly

\[
B\|D\|_\omega^2+\mathcal Q^{av}\le(4-L)^2.
\]

The explicit formulas for (w_u), (\Gamma), the admissible ((M,u)) range, (Z_{\pm,a}), JECMW, WCGM, (\mathfrak O_M), (Q_M), and (Q_W) are absent from the supplied material. Consequently neither the remaining analytic target nor the downstream implication chain can be independently audited end to end from the provided file.

## RH status

**STILL OPEN.** No proof or disproof of the Riemann Hypothesis has been obtained.
