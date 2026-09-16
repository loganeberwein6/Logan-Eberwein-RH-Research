# Cycle 18: Candidate Q full finite audit

## Operator actually computed

For `lambda > 1`, set `L = 2 log(lambda)` and use the Fourier basis
`U_n`, `-N <= n <= N`. The matrix is

\[
 W^{(\lambda,N)}_{nm}=W_{0,2}(n,m)-W_{\rm prime}(n,m)-W_{\rm real}(n,m),
\]

with

\[
W_{\rm prime}(n,m)=\sum_{k\le\lambda^2}\Lambda(k)k^{-1/2}q(n,m,\log k),
\]

and the explicit archimedean and rank-two terms implemented in
`candidate_q_reproduce.py` and `candidate_q_highprec.py`. Reversal of the
Fourier index gives exact even/odd parity blocks.

## P1--P6 audit

| Property | Status | Reason |
|---|---|---|
| P1 poles/zeros at zeta zeros | **unproved** | finite perturbed spectra mimic several ordinates, but no determinant identity has been derived |
| P2 prime-power weights | **finite yes** | the matrix contains the von Mangoldt sum, including prime powers |
| P3 positivity | **finite yes; uniform no** | tested parity blocks are positive at high precision, but their minima shrink rapidly |
| P4 functional equation | **partial** | reversal/inversion symmetry is finite-dimensional; the global (s\leftrightarrow1-s) operator identity is absent |
| P5 arithmetic origin | **yes** | entries use finite Euler/von-Mangoldt data and explicit arithmetic kernels |
| P6 convergence/analytic continuation | **no** | no uniform operator convergence, trace-class bound, or Fredholm determinant limit has been proved |

## Required numerical checks

The finite parity determinants at 80 digits are:

```text
lambda=2, N=2: even 6.067578729076052198e-10
                 odd  1.571740915169291654e-6
lambda=2, N=4: even 2.385397371750094584e-15
                 odd  1.580895510256153900e-10
```

Smallest eigenvalues at `lambda=2` are:

```text
N=2: even 9.7402155498318968e-7,  odd 6.4677561069344269e-5
N=4: even 1.6995356490451677e-9,  odd 3.0340075431171662e-7
N=6: even 2.1430887973321369e-11, odd 5.7266152406674712e-9
```

The ratios are not consistent with a stable low-degree power-law
renormalization. The first five perturbed scaled roots for `lambda=2,N=8`
are approximately

```text
14.134725, 21.022041, 25.010888, 30.427179, 32.946781.
```

This is numerically suggestive but is not a convergence theorem: other
`lambda,N` paths introduce low modes and reorder the spectrum.

## Verdict

**PROMISING FINITE MODEL, INCOMPLETE OPERATOR.** Candidate Q remains the only
surviving construction in the current repository that simultaneously carries
prime-power arithmetic, inversion symmetry, finite lower bounds, and a
rank-one spectral mechanism. It still fails the requested end state because
P1 and P6 are missing and P3 has no uniform limiting proof.

## Exact next theorem required

The next decisive result is a uniform truncation theorem: specify a common
Hilbert/Weil-form space, prove convergence of the selected simple-even
minimizing vectors and rank-one perturbations, and prove convergence of the
regularized determinants to the completed zeta function. Numerical root fits
cannot substitute for this theorem.
