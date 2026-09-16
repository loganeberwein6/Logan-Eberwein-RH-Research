# Cycle 39: nonseparable `Lambda(mn)` block

## Construction

To put prime-power structure directly into matrix entries, define

`C_X(s)_{m,n}=Lambda(m*n)(m*n)^(-s/2)`,  `2<=m,n<X`.

This is nonseparable in `m,n` and is distinct from the failed Lambda Gram
matrix. It was tested as the arithmetic lower-right block of the Schur
framework, with determinant `det(I-C_X(s))`.

## Raw numerical output

```text
X=20: |det(I-C(1.5))| = 0.2935365870
      |det(I-C(2.0))| = 0.5668117568
      |det(I-C(1/2+14.1347i))| = 19.52990199
      minima: t=0 (.00000007), .25 (.00566299),
              34.25 (.02276205), 28.75 (.07003605)
      top eigenvalue magnitudes at s=1.5:
              .37317143, .25211738, .14395250, .10506927,
              .06572660, .05472223, .04042089, .03555266

X=50: |det(I-C(1.5))| = 0.2489452492
      |det(I-C(2.0))| = 0.5509434776
      |det(I-C(1/2+14.1347i))| = 37.60625561
      minima: t=0 (0), .25 (.00246341),
              38.75 (.03336179), 1.75 (.05162179)
      top eigenvalue magnitudes at s=1.5:
              .37700056, .25994805, .15682801, .11074248,
              .06572660, .05472223, .04042089, .03555266
```

The zero at `t=0` is a structural low-frequency singularity/degeneracy, not a
nontrivial zeta zero. The first ordinate has a large determinant value, and
the other minima move with `X`.

## Structural diagnosis

The nonseparable Lambda interaction does insert prime-power arithmetic into
the matrix, but it does not generate the Euler product: entries depend on a
single product `mn`, while determinant cycles impose overlapping product
constraints. No functional-equation involution or SR coercivity survives, and
finite eigenvalue decay alone gives no nuclear limiting theorem.

## P1--P6

| Property | Status |
|---|---|
| P1 | fails numerically; minima are at zero frequency or unstable |
| P2 | genuine nonseparable Lambda(mn) entries |
| P3 | absent |
| P4 | absent |
| P5 | yes |
| P6 | finite decay only; no limiting proof |

## Verdict

**Dead as a direct product-kernel block.** This rules out the simplest
nonseparable repair of Cycle 38. A successful multiplicative block must encode
prime powers through orbit composition/Euler loops, not merely through the
single entry label `mn`.
