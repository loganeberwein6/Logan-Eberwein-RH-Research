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
