# Cycle 98 — Mellin/Sobolev Weight Does Not Cure Form Degeneration

## Probe

The natural scale-adapted diagonal metric on Fourier modes was tested:

\[
 G_a(n,n)=(1+n^2)^{a/2},
\]

with generalized operator `G_a^{-1/2} W G_a^{-1/2}` at scale `2`.

## Raw minimum eigenvalues

| cutoff N | a=0 | a=2 | a=4 | a=6 | a=8 |
|---:|---:|---:|---:|---:|---:|
| 2 | `9.7402e-7` | `6.6627e-7` | `3.8478e-7` | `1.8029e-7` | `6.5685e-8` |
| 3 | `2.3955e-8` | `1.5640e-8` | `8.3609e-9` | `3.4793e-9` | `1.1033e-9` |
| 4 | `1.6995e-9` | `1.0804e-9` | `5.5275e-10` | `2.1603e-10` | `6.4047e-11` |
| 5 | `1.5190e-10` | `9.5056e-11` | `4.7401e-11` | `1.7885e-11` | `5.1024e-12` |
| 6 | `2.1431e-11` | `1.3269e-11` | `6.5034e-12` | `2.3971e-12` | `6.6585e-13` |

Positive Sobolev weights change the scale of the eigenvalues and improve the
condition number at fixed cutoff, but every tested exponent still exhibits
rapid cutoff collapse.

## Definitive implication

The missing ingredient is not merely a choice of diagonal Mellin/Sobolev
metric on the existing form. A successful construction must change the form
domain itself through a canonical completion, quotient, or renormalization,
while preserving the prime/gamma terms and the Weil positivity statement.

Equivalently, the correct object is not the raw finite matrix with a better
conditioner. It must be a different limiting form/operator whose domain has
already removed or controlled the collapsing directions.

No particular quotient or renormalization is justified yet; finite data cannot
select one uniquely.

## Verdict

**Simple Mellin/Sobolev metric eliminated as sufficient.** The remaining
requirement is a canonically derived scale-adapted form domain plus a
renormalized limiting operator.
