# Cycle 27: functional-equation normalization of the Mayer chain

## Exact normalization

Cycle 26 gave

`P_N(q)=prod_{j=0}^N D(q-j)=zeta(q-N-1)/zeta(q)`.

Using the zeta functional equation

`zeta(z)=chi(z) zeta(1-z)`,

where `chi(z)=2^z pi^(z-1) sin(pi z/2) Gamma(1-z)`, this becomes

`P_N(q)/chi(q-N-1) = zeta(N+2-q)/zeta(q)`.

For fixed `q`, `zeta(N+2-q)->1`. Therefore

`lim_N P_N(q)/chi(q-N-1)=1/zeta(q)`

away from the usual poles and zeros. This removes the endpoint obstruction
analytically, but only after inserting an explicit archimedean normalization.

## Numerical convergence of the normalized endpoint

The quantity tested was
`|zeta(q-N-1)/chi(q-N-1)|=|zeta(N+2-q)|`.

```text
q=1.5:             N=0 1.4603545, N=5 1.0252046,
                   N=10 1.0007008, N=20 1.00000067, N=40 1.0000000
q=2.5:             N=0 .2078862, N=5 1.0547075,
                   N=10 1.0014126, N=20 1.00000135, N=40 1.0000000
q=1/2+14.1347i:   N=0 .5444031, N=5 .9890130,
                   N=10 .9996753, N=20 .99999969, N=40 1.0000000
q=1/2+21.022i:    N=0 .6640644, N=5 .9949449,
                   N=10 .9998533, N=20 .99999986, N=40 1.0000000
```

## What this does and does not solve

This gives a genuine algebraic route to `1/zeta(q)` from shifted Mayer blocks,
up to the explicit factor `chi`. It therefore addresses the P1/P2 determinant
obstruction much more directly than SR sign insertions.

It is not yet a valid single Fredholm operator satisfying all six properties:

1. The normalization `chi(q-N-1)` is currently an external scalar, not the
   determinant of an arithmetic/nuclear block.
2. The infinite shifted direct sum still needs a common Banach space and a
   nuclearity proof.
3. No SR positivity mechanism has been incorporated.
4. The completed functional-equation symmetry has not yet been realized as an
   operator involution.

## P1--P6 status

| Property | Status |
|---|---|
| P1 | strong at normalized determinant level: exact `1/zeta(q)` limit |
| P2 | strong at determinant/Euler-product level |
| P3 | missing |
| P4 | partially supplied by the functional equation |
| P5 | Mayer integer branches plus explicit archimedean factor |
| P6 | unresolved for the infinite chain; finite products are valid |

## Next mathematical target

Construct an operator realizing `chi` through an archimedean/continuous block,
then prove that the normalized shifted chain is nuclear on a common space. Only
after that can positivity or the SR boundary form be tested without conflating
an external scalar normalization with an operator determinant.
