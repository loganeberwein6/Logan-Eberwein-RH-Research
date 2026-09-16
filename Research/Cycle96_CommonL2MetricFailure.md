# Cycle 96 — Ordinary Common-L2 Metric Fails

## Probe

The scale-dependent Fourier bases were embedded into one ambient interval by
their exact normalized `L2` overlap integrals. The finite Weil forms were then
pulled into the master coordinates by the overlap matrix.

## Raw output

The master scale was `3`.

| cutoff | scale | pulled-form minimum | pulled-form maximum | overlap determinant |
|---:|---:|---:|---:|---:|
| 1 | 1.2 | `1.3126e-4` | `0.11847` | `1.1928e-3` |
| 1 | 2.0 | `7.7339e-6` | `0.14810` | `0.29715` |
| 2 | 1.2 | `8.6539e-8` | `0.19980` | `1.2914e-8` |
| 2 | 2.0 | `1.8958e-7` | `0.23479` | `0.05012` |
| 3 | 1.2 | `2.6739e-11` | `0.29908` | `4.9231e-16` |
| 3 | 2.0 | `1.1447e-8` | `0.31451` | `0.00369` |
| 3 | 3.0 | `3.2211e-11` | `0.30432` | `1` |

## Interpretation

The overlap determinant measures how much of one finite scale basis is
represented by the other in ordinary ambient `L2`. Its rapid collapse shows
that zero-extending the scale-dependent spaces is not a stable common-space
identification. The resulting pulled forms do not remove the degeneracy.

This is a useful elimination: the missing metric is not ordinary fixed-window
`L2` with naive zero extension.

## Remaining structural requirement

The common space must respect the logarithmic dilation underlying the test
functions. The likely alternatives are a scale-invariant Mellin/Sobolev norm,
a projective-limit completion, or a renormalized form domain in which the
changing intervals are identified by dilation before completion. This is a
stronger requirement than simply choosing a larger ambient vector space.

No such choice is asserted to work yet; it must preserve the arithmetic form,
positivity, and determinant convergence simultaneously.

## Verdict

**Ordinary common-L2 metric eliminated.** The metric, if it exists, must be
scale-adapted to logarithmic dilation.
