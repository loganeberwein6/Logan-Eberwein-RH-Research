# Candidate Q: adaptive spectral-tracking framework

## Failure repaired

The earlier finite scans sorted eigenvalues independently at each `(lambda,N)`.
That is not a valid convergence test: eigenvalues can cross, tiny gaps amplify
roundoff, and newly appearing modes change the sorted order.  A list of nearby
numbers is therefore not evidence that one spectral branch converges.

## Framework

`candidate_q_tracking.py` projects the real symmetric Weil matrix into the two
eigenspaces of index reversal (even and odd parity).  It then continues modes
over a parameter grid and matches successive modes by maximum absolute
eigenvector overlap using an assignment algorithm.  Every ledger row records
the branch id, eigenvalue, nearest spectral gap, overlap, matrix condition
number, numerical precision, and whether precision escalation is required.

The escalation rule is deliberately conservative: a gap below `1e-10` or an
overlap below `0.9` is flagged.  The current float64 implementation does not
claim to resolve flagged rows; an interval/arbitrary-precision backend is the
next verification layer.

## What this establishes

It fixes the identity and numerical-stability defect in the previous workflow.
It does **not** prove that the finite matrices converge to the infinite Weil
operator, that the limiting determinant is Xi, or RH.  Those remain analytic
theorems, not computer-science bookkeeping problems.

## First truncation-continuation result

At `lambda=2`, even-parity tracking over `N=2,4,6,8,10,12` preserves the
first two branches with overlaps at least `0.9896` at the first enlargement and
above `0.9988` thereafter.  Their eigenvalues decrease from approximately
`9.74e-7, 1.597e-3` at `N=2` to `1.38e-12, 2.75e-7` at `N=12`.

The third branch is not stable at the first enlargement: its overlap falls to
`0.8217`, triggering escalation, then recovers to `0.9830` or better.  The
matrix condition number grows from `4.0e5` at `N=2` to `2.0e12` at `N=12`.
Thus branch tracking removes a sorting artifact but simultaneously confirms
that the small-eigenvalue regime is ill-conditioned and cannot be certified in
float64.  This is evidence for a required high-precision/interval phase, not
evidence for or against RH.

## High-precision verification

`candidate_q_parity_highprec.py` recomputes the parity blocks at 80 decimal
digits.  For `lambda=2` it gives:

| cutoff | even smallest | odd smallest |
|---:|---:|---:|
| `N=2` | `9.7402155498318968e-7` | `6.4677561069344269e-5` |
| `N=4` | `1.6995356490451677e-9` | `3.0340075431171662e-7` |

These agree with the earlier high-precision full-matrix values, while proving
that the tiny positive values at these cutoffs are not merely float64 sign
artifacts.  They still do not establish a nonzero limiting gap: the values
shrink rapidly with the cutoff, and no infinite-dimensional convergence bound
has been proved.

At `lambda=2,N=6`, the 80-digit parity calculation gives

```text
even: 2.1430887973321369e-11, 9.5544293244772027e-7,
      8.0649409285451986e-3, 6.353280677745249e-1, ...
odd:  5.7266152406674712e-9, 1.0144395948907877e-4,
      1.4696653070663652e-1, 9.7331190260113723e-1, ...
```

The first even branch continues to fall by roughly two orders of magnitude
per two-unit cutoff increment (`N=2,4,6`), while the first odd branch also
falls.  This rules out the previous interpretation that a stable finite
positive minimum had been numerically observed.  It does not by itself prove
that the limiting form is degenerate, because a separate analytic lower-bound
or renormalized limiting operator could still exist.

## Renormalization probe

The observed gap does not follow a stable low-degree cutoff law on the tested
data. For the first even branch, successive ratios are approximately `573.1`
and `79.3`; for the first odd branch they are `213.2` and `53.0`. Multiplying
by `N^2` or `N^3` continues to drive both sequences downward rather than
producing a plateau. This is only a three-cutoff diagnostic, not an
impossibility theorem, but it rules out the simplest power-law normalizations
as an explanation of the finite gap.

For the same finite quadratic-form blocks, the 80-digit determinants are:

| `lambda` | `N` | even determinant | odd determinant |
|---:|---:|---:|---:|
| 2 | 2 | `6.0675787290760522e-10` | `1.5717409151692917e-6` |
| 2 | 4 | `2.3853973717500946e-15` | `1.5808955102561539e-10` |

These determinants shrink with the cutoff. They are determinants of the
finite Weil quadratic-form blocks, not yet a Fredholm determinant of an
operator (T(s)); identifying them with a zeta-related determinant would be
an unjustified step.
