# Stage 40 operator-search status

This document separates exact algebraic results from numerical evidence and
from open conjectures.  It is not a claim that the Riemann Hypothesis has
been proved.

## Completed candidate audit

| cycle | construction | strongest result | status |
|---:|---|---|---|
| 1 | finite Selberg/Euler product | converges toward `1/zeta` only in `Re(s)>1`; critical minimum at `t=0` | dead |
| 2 | Bost--Connes prime diagonal | exact finite Euler product; no functional symmetry or zero detector | dead |
| 3 | Eisenstein/Hecke scalar model | determinant has persistent zero at `t=0`, not zeta ordinates | dead |
| 4 | integral/adelic candidates | integral kernel underdefined; adelic sign is exactly `-M_Rees` | undefined/dead |
| 5 | Mayer--SR hybrid | proposed kernel is not typed on the Mayer domain and lacks discretization data | undefined |
| 6 | integer SR plus Gauss map | every integer orbit collapses `m -> 0 -> 0` | dead |
| 7 | canonical Mayer operator | exact determinant `zeta(2s-1)/zeta(2s)`; nuclear but wrong zeros | dead |
| 8 | doubled symmetric Mayer | formal `s <-> 1-s` symmetry, but duplicates wrong determinant | dead |
| 9 | prime-loop diagonal | exact `1/zeta`; Lambda recovered by log differentiation; no positivity/FE | dead |
| 10 | p-adic threshold | weighted determinant is a monomial; local sign matrix indefinite | dead |
| 11 | Rees--Lambda candidate | negative eigenvalue persists; determinant near 1 | dead |
| 12 | positive Lambda Gram | positive but independent of `Im(s)` and not trace class for `Re(s)<=1` | dead |
| 13 | phase-preserving Lambda Gram | frequency returns, but positivity disappears and only `Lambda^2` occurs | dead |
| 14 | prime-branch transfer | determinant is `1 - sum_p p^{-s}`, mixing primes instead of forming independent Euler loops | dead |
| 16 | Gaussian-damped reflected primes | nuclear for fixed damping, but damping changes every Euler factor | dead |
| 17 | scalar completed-xi control | reproduces zeros by inserting `xi(s)` directly; circular benchmark only | control |
| 18 | Weil spectral triples | finite Weil matrix and rank-one scaling spectrum reproduced; high-precision simple-even gaps verified, global convergence open | promising/incomplete |

## Proved class-level result

Every operator of the form

\[
 c_X(s)D_X(s)R_XD_X(s)
\]

with positive scalar `c_X` and nonzero real diagonal `D_X` is indefinite for
every `X>=6`.  The proof is the negative `(2,3)` principal minor, whose value
after congruence is

\[
 -2c_X(s)^2d_2(s)^2d_3(s)^2<0.
\]

This eliminates the entire separable/Rees-congruence class, not merely the
tested weight formulas.

## What is established about the six requirements

- The prime diagonal establishes that P1 and P2 can coexist algebraically,
  but only through the Euler product and without a RH-relevant positivity
  theorem.
- Mayer establishes arithmetic dynamics plus nuclearity, but its exact
  determinant is the wrong zeta quotient.
- SR establishes finite arithmetic coercivity, but the Rees-congruence theorem
  proves that separable weighting cannot make it positive in the required way.
- No tested construction simultaneously satisfies P1--P6.

## Remaining open class

The search has not proved impossibility for all operators.  The unresolved
class consists of genuinely nonseparable, arithmetic transfer operators that
simultaneously have:

1. an exact determinant or trace identity producing `1/zeta` or
   `-zeta'/zeta`;
2. a completed-zeta involution `s <-> 1-s`;
3. a positive or coercive quadratic form not obtained by Rees diagonal
   congruence;
4. nuclear continuation through at least `Re(s)>1/2`.

No formula, Banach space, determinant identity, or positivity theorem for an
operator in this remaining class has been constructed here.  Any claim that
one exists is currently a conjecture, not a result.

## Unproven or unsafe conjectures explicitly rejected

- Numerical spectral resemblance is not evidence of zeta-zero convergence.
- A finite positive matrix cannot by itself establish a support statement for
  zeros without an analytic continuation/determinant theorem.
- Adding an SR perturbation to a known Euler/Mayer operator does not preserve
  its determinant unless an exact perturbation identity is proved.
- The statement that a trace equal to `-zeta'/zeta` must be indefinite is not
  used as a universal theorem here; only the Rees-congruence indefiniteness
  theorem is proved.

## Current conclusion

The original six-property goal remains open.  Stage 40 has produced a
class-level impossibility theorem and eliminated the listed candidate family,
but has not constructed the required operator or proved impossibility for the
remaining nonseparable transfer-operator class.

## Formal verification status

After setting the installed toolchain variable `ELAN_HOME` to
`C:\Users\ljoe6\.elan`, these files compiled successfully with no reported
errors:

```text
SR_Stage27.lean
SR_Stage36.lean
SR_Stage37_Clean.lean
```

The earlier inability to run these checks was an environment-variable issue,
not a Lean theorem failure.  No Lean files were changed during that check.

## Post-Stage-40 continuation: Cycles 22--28

| cycle | construction | result | status |
|---:|---|---|---|
| 22 | typed Mayer--SR branch sign using `floor(1/x)` | compact finite discretization, but no stable first-zero minimum; SR sign breaks Mayer trace cycles | dead |
| 23 | multiplicative `(-1)^(v_2(n))` Mayer weight | modifies only the 2-Euler factor, with no Lambda mechanism | dead |
| 24 | direct `log(n)` Mayer weight | periodic-orbit trace is not `-zeta'/zeta`; determinant stays near 1 | dead |
| 25 | Mayer determinant derivative | desired logarithmic derivative appears with unavoidable shifted term | near miss |
| 26 | telescoping shifted Mayer chain | exact `zeta(q-N-1)/zeta(q)` identity isolates `1/zeta(q)` up to an endpoint | promising |
| 27 | functional-equation endpoint normalization | normalized endpoint tends to 1, giving scalar `1/zeta(q)` | promising, operator open |
| 28 | completed scalar target | archimedean factor yields `1/xi(q)` and exact `q <-> 1-q` symmetry | strongest scalar framework, not an operator |

These cycles do not change the Stage 40 conclusion: no single operator with
all six properties has been constructed. The remaining class requires an
operator realization of the archimedean factor, a common nuclear space for the
infinite shifted chain, and an independent positivity theorem.

## Complete continuation ledger: Cycles 29--42

| cycle | construction/result | status |
|---:|---|---|
| 29 | Weierstrass trace-class realization of the archimedean gamma factor | partial P6, no P3 |
| 30 | sign-change test for `1/xi` rules out positive determinant blocks | class obstruction |
| 31 | Li coefficients positive, but raw Li Hankel matrix indefinite | bridge unresolved |
| 32 | ordinary Mobius weighting of SR flips corrected; it is not `2/zeta` | dead bridge |
| 33 | Dirichlet inversion of flip series yields `1/[zeta(zeta-2)]`, not `1/zeta` | dead |
| 34 | two-dimensional indefinite linearization of `1/xi` | formal P1 only |
| 35 | Candidate Q explicit root-error ledger; low-mode fit but unstable higher modes | promising/incomplete |
| 36 | exact `S+S^T=-2I` implies `Re(lambda)=-1`, hence `det(I-S)!=0` | class obstruction |
| 37 | SR determinant/positivity Schur-complement separation | promising but tautological |
| 38 | SR block coupled to Lambda vector | dead |
| 39 | direct nonseparable `Lambda(mn)` block | dead |
| 40 | fermionic prime Euler-loop operator | exact arithmetic control, no RH positivity |
| 41 | triangular Euler--SR extension | determinant-invisible coupling |
| 42 | self-adjoint determinant-preserving Schur coupling | congruence-trivial obstruction |

The current uneliminated class is therefore strictly narrower: non-triangular,
non-congruence, nonseparable arithmetic transfer operators with a completed
functional involution and a Weil-type (not determinant-positive) coercivity
criterion. No such operator has yet been constructed or ruled out.

| 43 | current-state audit: finite quotient row classification and rank theorem are already proved | gap narrowed |
| 44 | canonical quotient representative compression loses threshold coercivity | dead |
| 45 | symmetric bipartite quotient lift has exact +/- singular-value pairing | class obstruction |

| 46 | diagonal quotient identification preserves mixed diagonal signs | dead |
| 47 | Sylvester inertia rules out every real congruence repair | class obstruction |

The remaining class must therefore use a nontrivial arithmetic identification
of row and column spaces or a genuinely different Weil quadratic form; the
canonical quotient and bipartite repairs are eliminated.

| 48 | original Rees matrix is symmetric, so its skew perturbation is identically zero | invalid construction |
| 49 | ordered quotient skew plus representative Lambda weights | dead |
| 50 | acyclic multiplication-by-prime transition graph | determinant-trivial obstruction |
| 51 | self-adjoint two-step prime loops | exact finite P1/P2 control |
| 52 | paired `s` and `1-s` prime loops | exact finite P1/P2/P4 control |
| 53 | determinant-preserving edge signs are gauge similarities | class obstruction |
| 54 | multi-prime cycles | forbidden composite Euler factors |
| 55 | two-way prime-sector coupling creates mixed primitive cycles | class obstruction |
| 56 | nonnegative dynamics cannot cancel mixed cycles | positivity/cancellation obstruction |

The remaining operator class must therefore include a deliberately engineered
primitive-cycle cancellation, a completed functional involution, and a Weil
positivity criterion that is not entrywise positivity or determinant positivity.

| 70 | Lambda-weighted Rees Gram candidate, normalized by `psi(X)` | determinant collapses toward 1; trace has `Lambda^2` and threshold signs; indefinite | dead |
| 71 | Selberg-zeta analogue with repeated prime-power factors | converges to a q-Pochhammer Euler product, not `1/zeta`; zeros lie on nonpositive integer vertical lines | dead |
| 72 | Bost–Connes prime diagonal plus off-diagonal SR interaction | nonzero symmetric interaction changes Euler determinant at second order and can destroy positivity | dead |
| 73 | theorem: nonzero self-adjoint zero-diagonal coupling changes any positive Euler diagonal determinant | exact second-derivative obstruction; only nonsymmetric determinant-invisible couplings survive | class obstruction |
| 74 | paired local `s`/`1-s` Euler blocks | determinant becomes `1-p^-1`, independent of `s`; Hermitian inertia is exactly mixed | dead |
| 75 | global Weil/explicit-formula quadratic-form specification | correct P3 target identified; no proved SR-to-Weil map or Fredholm realization | open |
| 76 | Abel-damped Möbius supertrace on the critical line | finite sums vary smoothly near and away from rounded zeros; damping gives no controlled pole detector | insufficient |
| 77 | Mayer sign-cocycle gauge theorem | every cycle-preserving sign insertion is a diagonal gauge similarity; nontrivial cocycles change the Euler trace-log | class obstruction |
| 78 | nontrivial `Z/2` skew-product Mayer extension | determinant factors into untwisted/twisted sectors; twisted minima do not converge to zeta zeros | dead |
| 79 | finite-group skew-product theorem | regular representation decomposes into finitely many twisted Mayer sectors; finite labels add no new determinant mechanism | class obstruction |
| 80 | infinite multiplication-shift representation | finite semigroup graphs are nilpotent with determinant 1; infinite shifts are not trace class | class obstruction |
| 81 | reverse-edge arithmetic valuation graphs | acyclic forward graphs are trivial; shared reverse edges create mixed composite cycles | class obstruction |
| 82 | divisor cohomology superdeterminant audit | Möbius/Lambda signs arise from grading; ordinary positive determinants lose the cancellation | class obstruction |
| 83 | superdeterminant-to-positive-doubling test | direct positive blocks give products; Schur complements require inverse/poles and do not preserve positivity | class obstruction |
| 84 | tautological self-adjoint diagonal with inserted zeta ordinates | real positive spectrum is easy when zeros are supplied; arithmetic origin and trace-class realization remain absent | separation test |
| 85 | completed-xi Taylor companion matrices | truncated roots are unstable/off-axis; companion operators are nonnormal and directly use xi | dead |
| 86 | positive heat-trace theorem for Möbius coefficients | `mu(2),mu(3),mu(5)<0` rules out ordinary positive integer-spectrum heat realization | class obstruction |
| 87 | authoritative `SR_Stage36` Lean build | 3507 jobs completed successfully; finite algebra checked, analytic/RH bridge still absent | verification |
| 88 | exact raw SR quadratic-form decomposition and inertia | `M=J-2B` is mixed-sign with large nullity at every tested X; all-ones positivity is not PSD | class obstruction |
| 89 | scalar archimedean shift `M+alpha I` | positivity requires an unbounded X-dependent shift, observed above square-root scale | class obstruction |
| 90 | low-rank positive update `M+UU*` | update rank must be at least the growing negative index; no bounded-rank repair | class obstruction |
| 91 | Candidate-Q high-cutoff conditioning audit | finite Weil matrices remain positive in samples but become near-singular; branch/zero convergence unverified | promising/incomplete |
| 92 | exact symmetry answer | functional equation fixes the critical line but permits off-line quartets; only self-adjoint spectral realization/Weil positivity would force RH, and this is unproved | definitive status |
| 93 | finite arithmetic Weil operator implementation | built from Lambda, Fourier, gamma/archimedean rules with no zero fitting; finite positivity but rapidly worsening conditioning | promising/incomplete |
| 94 | finite arithmetic Weil invariant sweep | exact symmetry and sampled positivity across scales/cutoffs; smallest eigenvalues collapse rapidly | promising/incomplete |
| 95 | quadratic-form/operator metric diagnosis | raw eigenvalues are basis-dependent; the indispensable missing object is a canonical function-space Gram metric `G` | structural diagnosis |
| 96 | ordinary common-L2 embedding probe | exact overlap transport collapses across scales; naive fixed-window L2 is not the required metric | dead metric choice |
| 97 | metric identifiability theorem | finite arithmetic forms do not determine a unique positive metric or spectrum; canonical scale-invariant domain must come from independent structure | class obstruction |
| 98 | Mellin/Sobolev diagonal metric probe | scale-adapted weights improve conditioning but do not stop cutoff eigenvalue collapse | insufficient |
| 99 | canonical Weil-domain identification | arithmetic/functional-equation structure selects even Schwartz space and the closure of the global Weil form; positivity and spectral identity remain open | conditional structural result |
| 100 | rank-one Weil-scaling operator | modified Weil form selects an even vector; rank-one perturbation of logarithmic scaling reproduces low zero ordinates without zero inputs | best finite candidate/incomplete |
| 101 | weighted self-adjointness residual check | `WD'-(D')^T W` is numerically tiny relative to scale, confirming the rank-one algebraic mechanism | verified finite invariant |

## Literature integration update — 2026-09-12

The external literature adds two actionable branches to the current framework:

| source | imported result | effect on project |
|---|---|---|
| Connes--van Suijlekom, 2025 | Caratheodory--Fejer extension: simple isolated even lowest state gives real zeros of its Fourier transform | finite real-zero lemma; hypotheses must be verified, not numerically assumed |
| Groskin, 2026, finite Guinand--Weil dictionary | exact map from finite even Galerkin vectors to band-limited test functions and exact zero-side form values | replaces the informal finite-to-test-function map with an exact dictionary |
| Groskin, 2026, archimedean tail order | positive tail increment and explicit certification budget | add interval/LDL certification; raw deep floating-point signs are insufficient |
| Suzuki, 2026, screw function | continuous-kernel reformulation and expanding-interval nonlocal first-order operator conjecture | parallel candidate for the global scale limit |
| Kim et al., 2026 | finite-element/Richardson numerical realization of Suzuki's operator | diagnostic evidence for archimedean laws and tail control, not an RH proof |

The integrated framework now has three layers: exact finite dictionary and tail
certification; fixed-scale shifted-Weil rank-one operators; and a global scale
limit pursued through either the common Weil-form/Mosco route or Suzuki's
screw-function expanding-interval route. No cited source proves the final
global convergence to `Xi`.
