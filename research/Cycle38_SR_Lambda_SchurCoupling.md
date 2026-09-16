# Cycle 38: SR--Lambda Schur coupling

## Non-tautological construction

Let `S_X` be the exact distinct-threshold SR matrix. Compress the arithmetic
channel into the threshold fibers using

`v_X(s)_k = sum_{2<=n<X, floor((X-1)/n)=q_k} Lambda(n)n^(-s/2)`.

The minimal Schur complement with scalar lower-right block zero is

`Q_X(s)=-v_X(s)^T S_X^(-1) v_X(s)`.

This preserves the exact SR coercive block and introduces genuine
von-Mangoldt prime-power weights without inserting a zeta function by hand.

## Critical-line scan

```text
X=20:  |Q(1/2+14.1347i)| = 2.3798850672
       minima: t=37.50 (0.386425), 37.75 (0.414310), 37.25 (0.533803)

X=50:  |Q(1/2+14.1347i)| = 4.3050745343
       minima: t=15.00 (2.548475), 14.75 (2.635836), 15.25 (2.716607)

X=100: |Q(1/2+14.1347i)| = 62.9518720553
       minima: t=35.75 (1.743486), 35.50 (1.743631), 36.00 (1.842184)
```

The minima do not stabilize at the first zeta ordinate and the scale is not
stable with `X`.

## Structural diagnosis

The SR inverse supplies a finite signed quadratic form, but it does not
reproduce the multiplicative convolution needed for the Euler product. The
Lambda weights are present only in the vector; the Schur quadratic form mixes
them through the threshold inverse. Consequently it produces an arithmetic
Dirichlet polynomial, not `1/xi(s)` or `-zeta'/zeta(s)`.

The construction also has no completed `s -> 1-s` symmetry and no limiting
nuclear theorem. It does, however, validate the Schur architecture as a
well-defined non-tautological test.

## P1--P6

| Property | Status |
|---|---|
| P1 | fails numerically; minima are unstable and non-zeta-specific |
| P2 | partial: exact Lambda prime-power weights enter the coupling vector |
| P3 | yes for the SR principal block, not for the full pencil |
| P4 | absent |
| P5 | yes |
| P6 | finite only |

## Verdict

**Dead as the minimal SR--Lambda Schur coupling.** It is the first honest test
of the separation framework, and its failure shows that inserting Lambda into
the coupling vector is insufficient. The missing ingredient must be a
nonseparable multiplicative interaction in the Schur complement itself.
