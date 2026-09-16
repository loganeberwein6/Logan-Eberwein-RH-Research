# Cycle 71 — Selberg-Zeta Analogue

## Construction

The requested finite product was evaluated:

\[
 Z_{\mathrm{SR}}(s,X)=\prod_{p\le X}\prod_{k=0}^{\lfloor\log_pX\rfloor}(1-p^{-(s+k)}).
\]

It is the determinant of the diagonal finite operator with eigenvalues `p^{-(s+k)}` for the listed prime-power sectors.

## Raw output

| X | `Z_SR(1.5,X)` | `1/ζ(1.5)` | absolute error | `Z_SR(2,X)` | `1/ζ(2)` | absolute error |
|---:|---:|---:|---:|---:|---:|---:|
| 20 | 0.2594910363 | 0.3827933840 | 0.1233023477 | 0.4513022459 | 0.6079271019 | 0.1566248559 |
| 50 | 0.2442851999 | 0.3827933840 | 0.1385081842 | 0.4420825806 | 0.6079271019 | 0.1658445213 |
| 100 | 0.2382143937 | 0.3827933840 | 0.1445789903 | 0.4388335463 | 0.6079271019 | 0.1690935556 |

At the first two zeta ordinates, the values were:

| X | `Z_SR(0.5+14.1347i,X)` | `Z_SR(0.5+21.0220i,X)` |
|---:|---:|---:|
| 20 | `19.0297658 - 8.3540827i` | `5.7550550 + 2.4349402i` |
| 50 | `24.1880272 - 10.9075114i` | `8.0624779 + 5.4856861i` |
| 100 | `22.5697253 - 8.1354704i` | `8.2492799 + 6.8879593i` |

Critical-line minima of the absolute value over `0 <= t <= 40` were sampled near:

- `X=20`: `t=27.20` with value `0.12298`
- `X=50`: `t=27.70` with value `0.12812`
- `X=100`: `t=35.40` with value `0.11537`

These do not converge to `14.1347` or `21.0220`.

## Exact algebraic failure

The extra `k`-product does not disappear as `X` grows. For every fixed prime `p`, the number of included factors tends to infinity, so the infinite limit is

\[
 \prod_p\prod_{k\ge0}(1-p^{-(s+k)}),
\]

not `1/ζ(s)=∏_p(1-p^{-s})`. It is a different q-Pochhammer-type Euler product. If the `k>=1` factors are removed, the ordinary prime Euler product is recovered, but then the construction is only the diagonal Euler operator and contributes no new RH mechanism.

Moreover, every finite factor has zeros satisfying

\[
 p^{-(s+k)}=1,
 \qquad
 \Re(s)=-k,
\]

so no factor has zeros on `Re(s)=1/2`. The finite product therefore cannot encode critical-line zeros.

## P1–P6

| Property | Result |
|---|---|
| P1 | Fails: zeros lie on `Re(s)=0,-1,-2,...`, not at zeta zeros. |
| P2 | Partial: prime-power sectors are explicit, but they generate the wrong repeated Euler product. |
| P3 | Fails as an RH positivity mechanism; diagonal factors are not a canonical Weil-positive form. |
| P4 | Fails: no `s ↔ 1-s` symmetry. |
| P5 | Holds: construction is arithmetically multiplicative. |
| P6 | Partial: diagonal eigenvalues are nuclear in suitable half-planes, but the resulting determinant is the wrong analytic function. |

## Verdict

**DEAD.** The Selberg analogy correctly identifies primitive primes but the proposed prime-power repetition is incompatible with the Riemann Euler product. Removing the repetition gives the already-known circular diagonal operator. The next required candidate is the Bost–Connes operator with a carefully constrained SR interaction.
