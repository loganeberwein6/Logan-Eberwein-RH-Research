# Candidate Q: exact convergence theorem program

This document separates the missing analytic theorem into checkable claims.
It is a specification of what must be proved, not a claim that the claims are
already true.

## 1. Common state space

Define the logarithmic interval

\[
I_\lambda=[-\log\lambda,\log\lambda]
\]

and let `E_N(lambda)` be the span of the first `2N+1` scaling eigenfunctions,
with parity decomposition under `Jf(x)=f(-x)`. A successful construction must
specify one Hilbert or completed Weil-form space `H` into which all these
finite spaces embed isometrically. The current scripts only compare matrices
whose coordinates change with `lambda` and `N`; they do not yet provide this
common embedding.

## 2. Required theorem package

### T1: form convergence

There must be a densely defined closed sesquilinear form `Q_lambda` on `H`
such that, for every fixed finite-energy vector `f`,

\[
 Q_\lambda(P_{N,\lambda}f,P_{N,\lambda}f)
 \longrightarrow Q(f,f)
\]

along a specified joint path `lambda -> infinity`, `N=N(lambda) -> infinity`.
The convergence must include an explicit tail bound, not only pointwise
convergence of matrix entries.

### T2: simple-even selection

For every sufficiently large cutoff, the bottom eigenvalue `mu_{N,lambda}`
must be simple, separated from the next eigenvalue by a certified gap, and its
normalized eigenvector must be even. If the gap tends to zero, the theorem
must replace individual eigenvectors with a convergent spectral projection.

The existing data establish this only at small finite cutoffs. They do not
establish a uniform gap; in fact the gap shrinks rapidly for `lambda=2`.

### T3: limiting state

The selected vectors `xi_{N,lambda}` must converge in a topology strong enough
to control their Fourier transforms at the determinant level. Weak convergence
of vectors is insufficient. A usable target is norm convergence in the common
space plus a uniform bound on the evaluation functionals at `±i/2`.

### T4: rank-one operator convergence

For the scaling operator `D` and rank-one perturbations

\[
 D_{N,\lambda}'=D_{N,\lambda}
  -|D\xi_{N,\lambda}\rangle\langle\delta_{N,\lambda}|,
\]

prove convergence in a resolvent or trace-norm topology to a closed operator
`D'`. Entrywise convergence is not enough to pass spectra or determinants.

### T5: determinant identity

Construct a common regularization and prove

\[
 \det_{\rm reg}(D'-z)=C(z)\,\Xi(z),
\]

where `C` is explicitly known and nonvanishing in the relevant domain. The
finite numerical agreement of roots is not evidence for this equality unless
the regularization and convergence topology are fixed first.

### T6: functional equation and RH implication

Prove that the limiting involution implements `s <-> 1-s`, and prove that the
positivity/lower-bound statement for the limiting Weil form implies all zeros
of `Xi` lie on the real spectral axis. This is the step that turns a spectral
construction into an RH proof.

## 3. Current evidence against shortcuts

- The first even eigenvalues at `lambda=2`, `N=2,4,6` are approximately
  `9.74e-7`, `1.70e-9`, `2.14e-11`.
- The first odd eigenvalues are approximately `6.47e-5`, `3.03e-7`,
  `5.73e-9`.
- The finite matrices are high-precision positive in these tests, but the
  shrinking values do not provide a uniform coercive estimate.
- Independent sorting fails because modes reorder as `N` and `lambda` vary;
  overlap tracking fixes identification but cannot create convergence.

## 4. Decision rule

Candidate Q is **not** eligible for `SUCCESS` until T1--T6 are proved or a
different operator is shown to satisfy P1--P6. If a proposed proof uses only
finite positivity, root matching, or entrywise convergence, it has not passed
the specification.

## 5. Next executable test

Implement a common-coordinate embedding for two different `lambda` values and
measure cross-parameter eigenvector overlaps after transporting the scaling
basis. A failure of Cauchy convergence would disprove the current finite-space
identification and force a new state-space construction; success would provide
the first evidence relevant to T1/T3 rather than another sorted-spectrum fit.

The existing fixed-`N=8` transport test over
`lambda=2,2.25,...,4` gives a minimum matched overlap of only `0.5331`.
Fifty-five of the 81 ledger rows trigger the precision/escalation rule, and
the condition number ranges from `9.09e11` to `1.33e16`. Thus the current
coordinate-level transport is not strong evidence for T1 or T3. It is exactly
the instability that a common-space theorem must eliminate or explain.

I then implemented the analytic overlap transport
`C[new,old] = <phi_new,phi_old>` for normalized exponential scaling modes on
the nested logarithmic intervals, rather than comparing raw coefficient
vectors. At fixed `N=8`, the minimum matched overlap over the same
`lambda=2,2.25,...,4` path was `0.1064`. This is weaker than the raw-coordinate
value and shows that the instability is not merely a sorting bug: the finite
interval representations themselves lose substantial common-space overlap.

As a truncation control, the same transported test gives minimum overlaps
`0.4269` at `N=4`, `0.1064` at `N=8`, and `0.1134` at `N=12`. The modest
recovery from `N=8` to `N=12` means the `0.1064` value is not by itself a
proof of incompatible infinite spaces; it is evidence that convergence is
non-monotone and requires a quantitative projection/tail estimate.

The projection test was then refined to the selected bottom even eigenvector,
rather than all basis columns. Its transported squared norm over adjacent
lambda steps was:

| N | minimum | maximum |
|---:|---:|---:|
| 4 | 0.8418 | 0.9117 |
| 8 | 0.8881 | 0.9489 |
| 12 | 0.9573 | 1.0000 |

This is positive evidence that the distinguished low mode may have a better
common-space limit than the full truncated bases. It remains numerical: the
lower bound is not uniform in `lambda`, and it does not prove T1--T3.

Stress-testing the larger interval `lambda=2` to `10` in eight equal steps
gave bottom-even projection norm-squared ranges of `0.8226--0.8783` (`N=4`),
`0.8848--0.9976` (`N=8`), and `0.9477--0.9999` (`N=12`). The corresponding
direct transported overlaps were only `0.1743--0.8795`, `0.1259--0.8256`,
and `0.1004--0.6421`. Thus the low mode remains largely representable in the
larger space, while its identity as the new bottom eigenvector is not stable
under a large parameter step. Any proof must use infinitesimal continuation or
spectral projections, not direct endpoint matching.

The infinitesimal-step control supports that diagnosis. Over `lambda=2..4`,
the minimum bottom-even overlap was:

| step size | `N=8` | `N=12` |
|---:|---:|---:|
| 0.25 | 0.1064 | 0.1134 |
| 0.10 | 0.3550 | 0.2688 |
| 0.05 | 0.5158 | 0.3908 |

Mean overlaps rose simultaneously (`0.6760 -> 0.9331` for `N=8` and
`0.6092 -> 0.8621` for `N=12`). Thus the branch is locally trackable as the
step tends to zero, while endpoint matching is misleading. The remaining
mathematical requirement is a uniform differential/adiabatic bound controlling
the branch through the full parameter path.

## Differential continuation diagnostic

A finite-difference estimate of `||d xi_0/d lambda||`, the bottom-even gap
`mu_1-mu_0`, and their ratio over `lambda=2.05..3.95` gives:

| N | max derivative | minimum gap | max derivative/gap |
|---:|---:|---:|---:|
| 4 | `3.39e-1` | `6.31e-11` | `1.32e9` |
| 8 | `7.98e2` | `3.43e-16` | `2.33e18` |
| 12 | `7.74e2` | `1.88e-16` | `3.34e18` |

These are float64 diagnostics and the smallest gaps are below reliable
precision, so they are not certified numerical values. They nevertheless
identify the obstruction to a naive adiabatic proof: the denominator needed
for eigenvector perturbation bounds collapses much faster than local overlap
improves. A successful theorem must use spectral projections/cluster
subspaces or a different normalization, not a simple isolated-eigenvector
derivative estimate.

At `N=8` with parameter step `0.25`, principal-angle diagnostics for the
transported lowest even subspaces were:

| cluster dimension `k` | minimum principal cosine | mean |
|---:|---:|---:|
| 1 | 0.1186 | 0.6642 |
| 2 | 0.4881 | 0.6633 |
| 3 | 0.2882 | 0.5746 |

The two-dimensional cluster is better behaved than the isolated lowest mode,
which supports replacing eigenvectors by Riesz projections when the first gap
collapses. It is not yet stable enough to certify a limiting projection, and
the higher cluster is less coherent.
