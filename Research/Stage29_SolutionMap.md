# Stage 29 — Structural solution map

## Exact finite identity

For `a = beta - 1/2`, `w_m = m^a cos(gamma log m)`, and complete support
`2 <= m < X`, the verified SR form is

`Q_X = Sum_{m,n<X} w_m M_X(m,n) w_n`, with
`M_X(m,n) = 1 - 2*1_{mn<X}`.

Therefore

`Q_X = (Sum_{m<X} w_m)^2 - 2 Sum_{mn<X} w_m w_n`.

The cosine product identity splits the second term into the two exact
frequency channels `gamma(log m + log n)` and `gamma(log m - log n)`.

## Scale bookkeeping

The unconditional triangle estimate gives

`|Q_X| <= (Sum_{m<X} m^a)^2 = O(X^(2 beta + 1))`.

This is sharp for the unsigned envelope. The empirical `X^(3 beta)` scale
is subleading for `beta < 1`; it cannot be obtained by termwise domination.
It must arise from cancellation between the total square and the interior
product sum.

## Candidate analytic reductions

1. **Abel summation.** Define `R_X(t) = #{(m,n): m,n<X, mn<=t}` and apply
   partial summation to `Sum r(k) k^(a+i gamma)`. Required input: an explicit
   asymptotic for `R_X(t)` with an error term strong enough to survive the
   subtraction `Total - 2*Interior`.

2. **Dirichlet convolution.** Write `r(k)=#{(m,n):mn=k}` and express the
   interior channel through a truncated convolution. Required input: a
   uniform complex estimate for `Sum_{k<X^2} r(k) k^(a+i gamma)` and its
   cutoff error.

3. **Phase-channel analysis.** Fit the sum-frequency and difference-frequency
   channels separately. A single coefficient `1/(beta+1+i gamma)` is falsified
   numerically; both channels and their boundary phases are essential.

4. **Matrix/spectral route.** Use `M_X = J - 2A_X`, where `A_X(m,n)=1_{mn<X}`.
   The desired estimate becomes a quadratic-form cancellation statement for
   the divisor matrix `A_X`, not a positivity statement. Spectral bounds on
   `A_X` would directly imply bounds for admissible vectors.

## Precise missing theorem

A sufficient analytic target is a uniform estimate of the form

`|(Sum_m w_m)^2 - 2 Sum_{mn<X} w_m w_n| <= C(beta,gamma) X^(3 beta + epsilon)`

for the specified beta/gamma range. Any proof must identify the leading
`X^(2 beta+1)` terms in the two summands and show their coefficients cancel.

## What is and is not established

- Lean: all finite identities, phase splitting, absolute bounds, and the
  critical-line `X^2` envelope are verified.
- Computation: normalized values are bounded over tested cutoffs.
- Not established: an asymptotic theorem, a uniform cancellation estimate,
  or any implication for RH.

The correct next implementation target is an Abel-summation lemma for a
finite weighted convolution, with the remainder left explicit rather than
hidden behind a conjecture.
