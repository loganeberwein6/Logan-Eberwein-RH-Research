# Cycle 70 — Lambda-Weighted Rees Gram Candidate

## Construction

For `a,b in {2,...,X-1}`, define

\[
 T_X(s)_{a,b}=\frac{R_X(a,b)\Lambda(a)\Lambda(b)}{\psi(X)(ab)^{s/2}},
 \qquad
 R_X(a,b)=\begin{cases}-1&ab<X,\\+1&ab\ge X,\end{cases}
\]

where `psi(X)=sum_{n<X} Lambda(n)`. This is the requested Candidate A Gram-style construction.

## Raw numerical output

Using the normalized matrix and `det(I-T_X(s))`:

| X | ψ(X) | det at s=1.5 | smallest eigenvalue | largest absolute eigenvalues |
|---:|---:|---:|---:|---|
| 20 | 19.26565831 | 0.968178546669 | -0.04161626 | 0.058594, 0.041616, 0.019285, 0.015216, 0.013357 |
| 50 | 49.48538079 | 0.995740049923 | -0.02421913 | 0.027190, 0.024219, 0.008865, 0.008719, 0.005923 |
| 100 | 94.04531123 | 0.996027939611 | -0.01533986 | 0.015610, 0.015340, 0.005660, 0.004975, 0.003572 |

The unnormalized diagnostic was also run. Its determinants at `s=1.5` were `-0.1538896`, `-0.5270875`, and `-0.4792719` for `X=20,50,100`; its smallest eigenvalues were `-0.8018`, `-1.1985`, and `-1.4426`, respectively. Thus the normalization is what collapses the candidate toward the identity, but removing it does not produce a stable operator.

For the normalized critical-line scan over `0 <= t <= 40`, no minima converged to the first zeta ordinate. The unnormalized scans produced lowest sampled minima at approximately `t=7.10` (`X=20`), `23.05` (`X=50`), and `27.70` (`X=100`), with values `0.5137`, `21.0289`, and `4.5534`; these are nonconvergent and not the first zero `14.1347`.

## Algebraic failure

The matrix is a signed rank-one-weighted Rees kernel. Its trace is

\[
 \operatorname{Tr}T_X(s)=\frac1{\psi(X)}\sum_{m<X}R_X(m,m)\Lambda(m)^2m^{-s},
\]

not `-ζ'(s)/ζ(s)=sum Λ(m)m^{-s}`. The Lambda factors are squared on the diagonal, and the threshold sign is not an Euler-product primitive-cycle rule. The Gram interpretation also does not imply positivity because the Rees kernel has mixed-sign quadratic form.

## P1–P6

| Property | Result |
|---|---|
| P1 | Fails: determinant tends toward 1 under the prescribed normalization and has no zero encoding. |
| P2 | Fails: diagonal/trace weights are `Λ(m)^2` with threshold signs, not `Λ(m)`. |
| P3 | Fails: the matrix is indefinite; the smallest eigenvalue is negative at every tested X. |
| P4 | Fails: no `s ↔ 1-s` involution is built in. |
| P5 | Holds formally: entries use integer threshold data and von Mangoldt weights. |
| P6 | Only finite-rank: no limiting nuclear family or continuation through the critical strip follows. |

## Verdict

**DEAD.** The candidate combines the two desired data sources but does not combine their mechanisms: Rees signs remain additive-threshold structure, while Lambda weighting is squared by the Gram construction. The normalized family becomes asymptotically determinant-trivial rather than zeta-sensitive.

The next untested required candidate is the Selberg-zeta analogue (Candidate B), which is multiplicative by construction and has an exact finite Euler-product formula.
