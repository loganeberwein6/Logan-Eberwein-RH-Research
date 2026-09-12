# Cycle 18: Zeta Spectral Triples / Weil-form operator

## External candidate identified

The 2025 paper by Connes, Consani, and Moscovici constructs self-adjoint
operators as rank-one perturbations of the scaling operator on
[lambda^(-1),lambda]. The construction uses restricted Euler products over
primes p <= x=lambda^2, a finite Weil quadratic form, and a truncated
Fourier subspace.

The paper states a regularized determinant identity of the form

\[
 \det_{\rm reg}(D_{\log}^{(\lambda,N)}-z)
 =-i\,\lambda^{-iz}\widehat{\xi}(z),
\]

where widehat-xi is the Fourier transform of the selected eigenvector,
and the operator is self-adjoint under the modified Weil-form inner product.

## Why this is materially different

This is not:

- a Rees diagonal congruence;
- a prime diagonal with a reflected divergent block;
- a Mayer transfer determinant;
- a positive Lambda Gram norm.

It uses a nonseparable Weil quadratic form and obtains self-adjointness from a
rank-one perturbation plus a changed inner product. It is therefore in the
remaining open class identified in Stage 40.

## Exact finite form

For `lambda>1`, the semilocal form is

\[
 QW_\lambda(f,f)=
 \int_{\mathbb R}|\widehat f(t)|^2\frac{2\theta'(t)}{2\pi}\,dt
 +2\Re\left(\widehat f(i/2)\overline{\widehat f(-i/2)}\right)
 -\sum_{1<n\le\lambda^2}\Lambda(n)\langle f,T(n)f\rangle,
\]

where

\[
 \langle f,T(n)g\rangle=n^{-1/2}
 \left((f^* * g)(n)+(f^* * g)(n^{-1})\right).
\]

The finite Fourier space `E_N` is spanned by the `2N+1` lowest-frequency
eigenfunctions of the logarithmic scaling operator on
`[lambda^(-1),lambda]`.  The paper assumes that the smallest eigenvalue of
the restricted form is simple and that its eigenvector is inversion-even.  A
rank-one perturbation then makes the scaling operator self-adjoint in the
modified Weil-form inner product.

## P1--P6 audit

| property | result | evidence/status |
|---|---|---|
| P1 | promising, unproved globally | the regularized determinant has zeros given by widehat-xi, but convergence of widehat-xi to the Riemann Xi function is still a missing step |
| P2 | promising | the Weil explicit formula contains the non-archimedean terms log(p) and prime powers |
| P3 | promising | the finite Weil quadratic form yields self-adjoint/lower-bounded operators |
| P4 | promising | the construction is built from the Weil form and inversion symmetry, but exact limiting completed-zeta symmetry must be proved |
| P5 | yes | restricted Euler products and finite-prime arithmetic data |
| P6 | partial | each finite/truncated operator is controlled, but the limit and determinant convergence remain open |

## Missing mathematical steps

The source explicitly leaves two central steps open:

1. prove that the smallest eigenvalue of the finite Weil quadratic form is
   simple and that its eigenvector is even;
2. prove that the selected finite eigenvector converges sufficiently to the
   limiting vector so that its Fourier transform converges to Riemann's
   Xi function.

The source also states that the Weil zero sum is only conditionally convergent
in general; absolute convergence is obtained for the compactly supported
convolution test functions used in the finite construction.  Passing from
those finite forms to the global determinant therefore requires a genuine
uniform limit estimate, not merely finite-dimensional self-adjointness.

Without those steps, this is not a proof of RH. The source itself states that
establishing the convergence would amount to proving RH.

## Repository relationship

The prior SR work supplies a finite coercive threshold form, but not the Weil
form or the scaling-operator state space. The exact class-level Rees
indefiniteness theorem therefore does not eliminate this candidate. This
candidate is a new external framework, not an SR perturbation.

## Verdict

**PROMISING BUT INCOMPLETE.** This is the first candidate found in the search
that simultaneously addresses arithmetic prime weights, self-adjointness,
functional/inversion symmetry, and regularized spectral determinants without
falling into the previously eliminated classes. It does not yet satisfy all
six properties because determinant convergence and the simple-even
eigenvector theorem are missing.

## Independent finite reproduction

The repository script `candidate_q_reproduce.py` evaluates the exact formulas
for the rank-two `W_{0,2}` term, the finite von-Mangoldt sum, and the
archimedean integral.  Its raw output is:

```text
lambda=2 N=2: symerr=0.000e+00 min=9.74021556e-07 max=0.390032358 even_err=4.321e-13
lambda=2 N=4: symerr=0.000e+00 min=1.6995362e-09 max=1.81093587 even_err=4.438e-11
lambda=3 N=2: symerr=0.000e+00 min=4.92092193e-09 max=0.210198345 even_err=3.489e-11
lambda=3 N=4: symerr=0.000e+00 min=1.65761291e-13 max=0.415552901 even_err=5.329e-08
lambda=4 N=2: symerr=0.000e+00 min=1.00909317e-09 max=0.171437752 even_err=3.768e-11
lambda=4 N=4: symerr=0.000e+00 min=2.47095352e-15 max=0.346483713 even_err=1.297e-06
```

Here `symerr` is the maximum entrywise failure of symmetry and `even_err` is
the relative distance of the smallest-eigenvalue vector from its reversal.
The finite matrix and simple-even behavior therefore reproduce successfully.
The output does not establish determinant convergence or the RH implication.

## Perturbed scaling spectrum

Using the smallest eigenvector `xi`, normalizing it by the Dirichlet vector,
and forming the finite rank-one perturbation

\[
 D' = D-|D\xi\rangle\langle\delta_N|,
 \qquad D_{nn}=n,
\]

gives the following positive eigenvalues after the natural scale
`2*pi/L`, with `L=2 log(lambda)`:

```text
lambda=2, N=8:
  [14.134725, 21.022041, 25.010888, 30.427179, 32.946781,
   37.685232, 51.037873, 151.988727]

lambda=3, N=8:
  [14.134725, 19.402663, 21.022026, 25.010774, 30.829461,
   36.748308, 58.272734, 200.396619]

lambda=4, N=8:
  [1.496582, 14.134725, 21.022816, 24.578023, 29.886584,
   33.126154, 53.030288, 132.909069]
```

For `lambda=2`, the first five values agree closely with the first five zeta
zero ordinates.  This is finite-dimensional numerical evidence only.  The
construction assumes the simple-even minimizing vector and does not prove
that the finite spectra or regularized determinants converge as `lambda,N`
tend to infinity.

## N-convergence scan

Comparing the first five positive scaled eigenvalues with the first five known
ordinates gives a non-monotone two-parameter pattern:

```text
lambda=2 N=8:  [14.134725, 21.022041, 25.010888, 30.427179, 32.946781] maxerr=0.0117193
lambda=2 N=12: [14.134725, 21.022040, 25.010871, 30.425857, 32.939827] maxerr=0.00476497
lambda=3 N=8:  [14.134725, 19.402663, 21.022026, 25.010774, 30.829461] maxerr=5.4141
lambda=3 N=12: [4.606783, 8.577455, 14.134725, 21.022040, 25.010858] maxerr=12.4446
lambda=4 N=8:  [1.496582, 14.134725, 21.022816, 24.578023, 29.886584] maxerr=12.6381
lambda=4 N=12: [1.890083, 6.508996, 14.134725, 19.099625, 21.022040] maxerr=14.513
```

Extra low-frequency eigenvalues appear for larger lambda in this
implementation. Therefore ordering, normalization, and the joint lambda,N
limit are part of the proof obligation.

## Lower-bound diagnostic

The finite smallest eigenvalue `mu_N(lambda)` rapidly reaches double-precision
noise:

```text
N=4: lambda=1.5 -> 2.204086e-04, 2 -> 1.699536e-09,
     3 -> 1.657613e-13, 5 -> -6.784407e-16, 10 -> 2.105594e-15
N=6: lambda=1.5 -> 1.811870e-04, 2 -> 2.143147e-11,
     3 -> -2.422306e-16, 5 -> -1.436925e-15, 10 -> -5.123770e-15
N=8: lambda=1.5 -> 1.625386e-04, 2 -> 2.754578e-12,
     3 -> -2.184752e-16, 5 -> -1.832975e-15, 10 -> -1.724981e-15
```

The sign changes at larger lambda are roundoff artifacts at this precision,
not evidence that the limiting Weil lower bound is negative. High-precision
arithmetic and a condition-number/error analysis are required before finite
`mu_N` values can support the analytic implication `mu_lambda -> 0`.

## High-precision correction

Using 50-digit arithmetic and the same explicit formulas gives positive
finite minima:

```text
lambda=2, N=2: mu_N=0.000000974021554983189682308277035847
lambda=2, N=4: mu_N=0.000000001699535649045167714580965751
lambda=3, N=4: mu_N=0.000000000000166024392069177336983597
```

The negative double-precision values at larger parameters are therefore
confirmed as roundoff artifacts.  This validates finite lower-boundedness,
but still gives no uniform-in-`lambda,N` estimate and no proof that the
limiting lower bound is zero.

## High-precision perturbed roots

For `lambda=2`, the finite perturbed scaling roots computed with 50-digit
arithmetic are:

```text
N=2: [15.2182364482437343, 41.0291251413423176]
N=4: [14.1347331334482307, 21.0757020194876264,
      27.5408001507746831, 83.757096730377551]
N=6: [14.1347251866513842, 21.0220577410477662,
      25.0114447936540026, 30.7878166388223597,
      42.4608534163468343, 125.56362388796151]
```

The first two roots at `N=6` are within roughly `1e-5` of the first two known
zeta ordinates. Higher roots require larger truncations and exhibit the
non-monotone ordering already documented above.

## Simple-even finite check

The exact reversal symmetry splits the high-precision matrix into even and odd
blocks. For `lambda=2`, the lowest eigenvalues of the two blocks are:

```text
N=2: even=0.000000974021554983189682308277
     odd =0.00006467756106934426860042115
     gap =0.000063703539514361078918

N=4: even=0.000000001699535649045167714580966
     odd =0.0000003034007543117166196854123
     gap =0.00000030170121866267145197
```

The minimizing vector is therefore simple and even in these finite tests. The
gap shrinks rapidly with truncation, so proving a uniform nonzero gap or
proving simplicity for all parameters remains open.

Additional 50-digit checks at `N=4`:

```text
lambda=3: even=1.660243920691773269836942e-13
          odd =5.100956101727336529800658e-11
          gap =5.0843536625204188e-11

lambda=4: even=9.204351772685069089406271e-16
          odd =7.755679824934110121004055e-13
          gap =7.746475473161425e-13
```

The gap remains positive in these tests but rapidly approaches the numerical
conditioning limit.

## Next concrete work

The next repository task is to reproduce the finite Weil-form matrix from the
paper for small lambda,N, verify self-adjointness and the regularized
determinant numerically, and isolate exactly which convergence estimate would
be needed to connect it to Xi.
