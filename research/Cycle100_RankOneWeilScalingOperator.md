# Cycle 100 — Rank-One Weil-Scaling Operator Identified

## Finite operator

For scale `lambda>1` and Fourier cutoff `N`, build the finite Weil matrix
`W_(lambda,N)` from:

- the finite archimedean/gamma term;
- the exact von Mangoldt prime-power sum up to `lambda^2`;
- the rank-two boundary term;
- the inversion-reversal symmetry.

Let `xi_(lambda,N)` be its smallest inversion-even eigenvector, normalized by
the all-ones vector `eta` so that `eta^T xi=1`. Let `D_N` be the logarithmic
scaling operator, diagonal in Fourier coordinates with entries `n` for
`n=-N,...,N`. Define

\[
 D'_{\lambda,N}
 =D_N-|D_N\xi_{\lambda,N}\rangle\langle\eta|.
\]

The displayed finite operator uses no zeta-zero heights and no fitted
constants. The natural spectral rescaling is `2*pi/(2*log(lambda))`.

## Raw finite spectra

The positive rescaled eigenvalues were:

```text
lambda=2, N=2: [15.21823645, 41.02912514]
lambda=2, N=4: [14.13473313, 21.07570202, 27.54080015, 83.75709672]
lambda=2, N=6: [14.13472519, 21.02205774, 25.01144479, 30.78781661,
                 42.46085245, 125.56360729]
lambda=2, N=8: [14.13472515, 21.02204103, 25.01088785, 30.42717947,
                 32.94678084, 37.68523237, 51.03787309, 151.98872718]

lambda=3, N=8: [14.13472516, 19.40266344, 21.02202557, 25.01077411,
                 30.82946113, 36.74830782, 58.27273364, 200.39661891]

lambda=4, N=8: [1.49658240, 14.13472497, 21.02281573, 24.57802301,
                 29.88658378, 33.12615425, 53.03028769, 132.90906937]
```

At `lambda=2`, the first five finite values at `N=8` are close to the first
five known zeta ordinates, without those ordinates entering the construction.
The nonmonotone extra low modes at `lambda=3,4` show that this is not yet a
convergence theorem; the joint scale/cutoff limit and mode selection remain
essential.

## Why this is the correct surviving architecture

This construction answers the earlier “which missing thing?” question more
precisely:

> The required repair is not a scalar normalization or a quotient of the SR
> matrix. It is a modified Weil-form inner product whose distinguished
> inversion-even vector defines a rank-one perturbation of logarithmic scaling.

The rank-one term is what couples the self-adjoint scaling dynamics to the
arithmetic Weil form. The finite eigenvalues are produced by the operator, not
inserted as data.

## P1–P6 status

| Property | Finite status |
|---|---|
| P1 | Strong numerical evidence through the regularized scaling spectrum; exact determinant convergence unproved. |
| P2 | Yes at finite level: Lambda prime-power terms are explicit. |
| P3 | Finite Weil form is positive/lower-bounded in high-precision tests; global positivity unproved. |
| P4 | Inversion/reversal parity is built in; completed limiting symmetry unproved. |
| P5 | Yes: finite prime data, gamma term, and canonical scaling construction. |
| P6 | Finite operator is explicit; joint `lambda,N` convergence and Fredholm determinant identity remain open. |

## Verdict

**Best identified finite operator; globally unproved.** This is the concrete
rank-one Weil-scaling candidate that works at finite level. It is not a proof
of RH until the selected eigenvector, determinant, and spectrum are shown to
converge in a common completed Weil space.
