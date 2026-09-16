# Cycle 31: Li/Weil positivity bridge test

## Motivation

Since determinant positivity is impossible, the natural replacement is a Weil
or Li quadratic form. The first Li coefficients of the completed xi function
were computed from

`lambda_n = (1/(n-1)!) d^n/ds^n [s^(n-1) log xi(s)] at s=1`.

The first ten values are:

```text
0.0230957089661210
0.0923457352280467
0.207638920554325
0.368790479492242
0.575542714461177
0.827566012282379
1.12446011757096
1.46575567714706
1.85091604838253
2.27933936319316
```

All are positive, as expected from the Li criterion at these low orders.

## Failed naive Gram identification

A naive Hankel matrix `H[i,j]=lambda_(i+j+1)` at size 5 had eigenvalues

```text
-0.2964410017646904,
-8.746491516326902e-12,
 6.437167047849496e-8,
 0.01428028841814819,
 4.063814158918735
```

Thus positivity of the individual Li coefficients does not make the raw Li
sequence a positive moment sequence. The correct Weil kernel has additional
test-function and gamma/prime terms; it cannot be replaced by an arbitrary
Hankel matrix of Li values.

## Relation to SR

The SR identity `S+S^T=-2I` is a pointwise finite coercivity statement. The Li
criterion is a global positivity statement over a test-function space, with
the explicit formula supplying both archimedean and prime-power terms. No map
from the SR threshold fibers to that Weil test-function space has been proved.
In particular, finite SR positivity cannot be promoted to Li positivity by
matching scalar traces or low-order coefficients.

## P3 status

The viable P3 target is now clear: construct the full Weil quadratic form (or
an equivalent self-adjoint pencil) and prove its finite SR-derived truncations
converge to it. The failed raw Hankel test shows that coefficient-level
matching is insufficient.

## Verdict

**No operator found, but the positivity target is correctly narrowed.** The
remaining construction must be a nonseparable test-function/explicit-formula
operator, not a positive determinant block and not a coefficient Hankel matrix.
