# Arithmetic / Selberg / mesoscopic audit

Date: 2026-08-31

This report works only with the hard cutoff `n<X`, where `T=log X=2M`.  It
does not prove LP or RH.  All convolutions below are stopped before `T`; in
particular the product condition is always `ab<X`.

## 1. Exact shifted finite Selberg coefficients

Put

`A_P = sum_(n<X) Lambda(n)n^(-1/2) delta_(log n)`

and `L_0=2 delta_0+A_P`.  If `d alpha(s)=s alpha(ds)`, coefficientwise stopped
convolution gives the exact identity

`-dL_0+L_0 star_T L_0`

`=4 delta_0+sum_(n<X) [Lambda*Lambda(n)+Lambda(n)(4-log n)]n^(-1/2) delta_(log n)`.

The `+4 Lambda(n)` term is exactly the pair of cross terms between the central
`2 delta_0` and `A_P`; it is not optional.

For one prime, if `p^k<X`, then

`(Lambda*Lambda)(p^k)=(k-1)(log p)^2`

and `Lambda(p^k)log(p^k)=k(log p)^2`.  Hence the coefficient at every legal
power in the full `p`-tower is

`p^(-k/2) log p (4-log p)`.

It is independent of `k`.  Its numerator is negative as soon as `p>e^4`; the
first prime with this property is `p=59`.  Thus the central atom does not give
coefficientwise positivity, even on a one-prime tower.

For distinct primes and `p^a q^b<X`, the coefficient is

`2 log p log q / sqrt(p^a q^b)`.

There are exactly two ordered decompositions, `(p^a,q^b)` and `(q^b,p^a)`.
For an integer having at least three distinct prime divisors, the coefficient
is zero.

If `R_p=max{r:p^r<X}`, the one-prime hard-exit tail omitted by stopped
convolution is exactly

`sum_(1<=i,j<=R_p, p^(i+j)>=X) (log p)^2 p^(-(i+j)/2) delta_((i+j)log p)`.

For two distinct primes it is exactly

`2 sum_(1<=a<=R_p, 1<=b<=R_q, p^a q^b>=X)`

`    log p log q (p^a q^b)^(-1/2) delta_(a log p+b log q)`.

These are genuine boundary/hyperbola terms.  Replacing `ab<X` by an
unrestricted Euler product inserts them illegally.

## 2. Full prime-minus-continuum shifted measure

Let `A_C=e^(s/2)1_(0,T)(s) ds` and `sigma=2 delta_0+A_P-A_C`.  On the open
interior `0<s<T`,

`dA_C=A_C star_T A_C=s e^(s/2) ds`,

and

`(A_P star_T A_C)(ds)=e^(s/2) sum_(n<e^s) Lambda(n)/n ds`.

Consequently

`-d sigma+sigma star_T sigma`

is the atomic shifted Selberg measure from Section 1 plus the exact continuous
density

`e^(s/2) [2s-4-2 sum_(n<e^s) Lambda(n)/n] ds`.

This identity keeps prime-prime, prime-continuum, and continuum-continuum
terms together.  It gives no sign: the one-prime high-prime coefficient is
already negative, and the continuous density is also signed.

Any square-zero projective lift `A -> N A` with `N^2=0` destroys all of the
load-bearing forward square, since `(N A)^2=0`.  It therefore cannot realize
the one-prime or two-prime coefficients above.  A graded repair has to retain
composable paths of length two (and, for PASE, their adjoints).

## 3. Exact endpoint port and support births

Write `phi_s(t)=cos(ts/M)` and `e(t)=phi_T(t)=cos(2t)`.  Since
`m_M=mu_M([0,T])` and `nu_M=mu_M-m_M delta_T`, its transform has the exact
endpoint-neutralized form

`V_M(t)=int_[0,T] [phi_s(t)-e(t)] dmu_M(s)`.

Thus adding an atom of mass `a` at delay `s<T` changes the two-ray input by

`Delta V=a psi_s`,  where `psi_s=phi_s-e`.

For a newly legal prime power `n`, this is

`Lambda(n)/sqrt(n) [cos(t log n/M)-cos(2t)]`,

and hence

`|Delta V(t)| <= Lambda(n)/sqrt(n)`

`                    * min(2, |t|(2M-log n)/M)`.

This is exact hard-endpoint suppression.  The corresponding change in `C_M`
is still the unsuppressed atom `a phi_s`; endpoint neutralization acts only in
`V_M`.

More precisely, let `N` be a prime power and `M_0=(1/2)log N`.  Because the
cutoff is strict, the `N`-atom is absent at `M=M_0` and present immediately to
the right.  With `a_N=Lambda(N)/sqrt(N)`, the one-sided birth limits are

`Delta m=a_N`,

`Delta C(t)=a_N cos(2t)`,

`Delta V(t)=a_N[cos(2t)-cos(2t)]=0`.

Thus the endpoint-completed two-ray input `V` is continuous across every
support birth, while `C` (and hence the first LP component `D`) has the exact
jump `a_N cos(2t)`.  The jump size `a_N<=log(N)/sqrt(N)=o(1)` at large births,
but its cross term with the pre-existing state has no automatic sign.

Let

`q(f,g)=(B/a_0) int_0^a0 <P(Theta_a f),P(Theta_a g)>_omega da`,

so `Q^av=q(V,V)`.  Freeze `M,u,w,Gamma` and perturb the arithmetic source by
one atom `a delta_s`, with the mandatory endpoint update `m -> m+a`.  If

`F=B||D||_omega^2+q(V,V)-(4-L)^2`,

then exact expansion gives

`Delta F=2a R_s+a^2 K_s`,

where

`R_s=B<D,phi_s>_omega+q(V,psi_s)+(4-L)<phi_s,h>_omega`

and

`K_s=B||phi_s||_omega^2+q(psi_s,psi_s)-<phi_s,h>_omega^2`

`   =B||P phi_s||_omega^2+q(psi_s,psi_s) >= 0`.

Therefore the LP defect is a convex, not concave, quadratic in every positive
atomic birth.  Even at the terminal delay `s=T`, where `psi_T=0`, its quadratic
coefficient is `B||P e||^2>=0`.  A birth-by-birth induction would have to prove
the signed first-order inequality `2R_s+aK_s<=0` (and additionally control all
continuous changes of the weights and Archimedean data).  The term `R_s`
contains the full correlations with the already existing `D` and `V`; no
Selberg coefficient identity above determines its sign.

At an actual threshold `M_0=(1/2)log N`, the frozen one-sided jump specializes
to

`Delta F=2a_N[B<D,e>_omega+(4-L)<e,h>_omega]`

`        +a_N^2 B||P e||_omega^2`,

because the exact endpoint compensation makes `Delta V=0`.  This is the
birth-continuity/jump equation that a scale induction must control before it
also treats the continuous evolution inside each cell.

The pair energy itself has the exact endpoint expansion.  Define

`K_pair(s,r)=(B/a_0) int_0^a0`

`    <P(Theta_a phi_s),P(Theta_a phi_r)>_omega da`.

Then

`Q^av = doubleint K_pair(s,r) dmu(s)dmu(r)`

`       -2m int K_pair(s,T)dmu(s)+m^2 K_pair(T,T)`.

The linear endpoint correlation with every interior delay and the quadratic
endpoint term are both required.  A scalar endpoint charge that retains only
`m^2` loses the first of these terms.  In a faithful full-shift model the same
fact appears as nonzero cross-exit products between the terminal exit and all
interior exits.

## 4. Exact common-cofactor decomposition

On `H_X=ell^2({m:m<X})`, let `S_a e_m=e_(am)` for `am<X`, and zero otherwise.
For `L=sum_(a<X)c_a S_a`, put `g=gcd(m,n)`, `m=gr`, `n=gs`, `(r,s)=1`.  Solving
`am=bn` gives the exact Gram formula

`<L e_m,L e_n> = sum_(k lcm(m,n)<X) conjugate(c_(ks)) c_(kr)`.

This is a bijective common-output/cofactor decomposition, including its exact
hard boundary.  For the actual Mangoldt coefficients
`c_a=Lambda(a)/sqrt(a)`, unique factorization makes it rigid:

* if `r,s>1`, only `k=1` can contribute, and then `r,s` are powers of two
  distinct primes;
* if `r=1,s>1` (or conversely), nonzero terms require `s=p^d` and `k=p^j`, so
  this is a same-prime tower;
* if `r=s=1`, the entry is the diagonal sum
  `sum_(km<X) Lambda(k)^2/k`.

For the shifted coefficient sequence `c_1=2`, the `k=1` term on an edge
`(1,p^d)` is `2 Lambda(p^d)/sqrt(p^d)`.  Its transposed Gram entry supplies the
other half.  Thus the forward `+4 Lambda` coefficient is split into a forward
and reverse `+2 Lambda` pair in the adjoint Gram geometry; it is not a single
forward `+4 Lambda` coefficient there.

This decomposition is a genuine exact invariant, but it is not a
lower-information inequality.  Same-cofactor terms are nonnegative for the
Mangoldt sequence, and the distinct-prime terms retain every required
two-point coefficient.  The prime-continuum and continuum-continuum blocks are
also absent from the purely discrete formula.  Bounding the PASE ratio kernel
after this reindexing still requires the completed covariance one began with.

## 5. Torus recurrence and the mesoscopic limitation

The continuum transform is elementary:

`I_M(t)=int_0^(2M)e^(s/2)cos(ts/M)ds`

`=[e^M((1/2)cos(2t)+(t/M)sin(2t))-1/2]/[1/4+(t/M)^2]`.

Let `A_M(t)=sum_(n<X)Lambda(n)n^(-1/2)cos(t log n/M)`.  Then

`C_M=A_M-I_M`

and the endpoint-neutralized identity is

`V_M(t)=[A_M(t)-A_M(0)cos(2t)]`

`       -[I_M(t)-I_M(0)cos(2t)]`.

For fixed `M`, compact-torus recurrence supplies an unbounded sequence `t_j`
for which simultaneously

`exp(i t_j log p/M) -> 1` for every prime `p<X`, and `exp(2i t_j)->1`.

All prime powers then align.  The displayed formula for `I_M` gives
`I_M(t_j)->0`, so exactly

`C_M(t_j) -> sum_(n<X)Lambda(n)/sqrt(n)`,

`V_M(t_j) -> I_M(0)=2(e^M-1)`.

Hence no uniform all-frequency cancellation estimate of logarithmic or bounded
size can be true.  This does not by itself contradict a localized PASE estimate,
because the recurrence times need not lie in the effective `w_u` window.

In a putative mesoscopic window `t=O(u)`, `1<<u<<M`, the exact continuum formula
has the expansion

`I_M(t)-I_M(0)cos(2t)`

`=4e^M(t/M)sin(2t)+2(cos(2t)-1)+O(e^M(t/M)^2)`

uniformly when `|t|/M` is small.  Therefore a proof must retain a correspondingly
precise prime-minus-continuum cancellation; estimating the prime and continuum
pieces separately loses an exponentially large cancellation.  The supplied
definition of `w_u` is not explicit enough to turn this observation into a
rigorous asymptotic for `B`, `L`, or `Q^av`.

## 6. Route classification and first open equation

* **Exact common-cofactor decomposition:** PROVED, but RECOMPLETION ONLY.  It is
  a reindexing of the ratio covariance and supplies no upper-bound orientation.
* **Scale induction across support births:** KILLED in its coefficientwise or
  monotone form.  High-prime shifted coefficients are negative, while the exact
  LP birth defect has nonnegative quadratic coefficient and an uncontrolled
  full-covariance linear coefficient.
* **Mesoscopic passage `M->infinity`, `1<<u<<M`:** LOAD-BEARING OPEN.  Endpoint
  neutralization gives useful boundary suppression, but the bulk requires a
  prime-minus-continuum estimate at the exact PASE scale.  Torus recurrence
  forbids upgrading such an estimate to all frequencies.

The first arithmetic equation not settled by the exact identities is the
source-specific signed covariance inequality needed at a birth,

`2[B<D,phi_s>+q(V,phi_s-e)+(4-L)<phi_s,h>]`

` + a[B||P phi_s||^2+q(phi_s-e,phi_s-e)] <= 0`,

together with the continuous-in-`M` evolution between births.  Proving this
uniformly for the actual source would not follow from the shifted Selberg
coefficients: it still queries the full completed PASE covariance.  In this
form it is not yet a rigorously lower-information substitute for PASE, and
calling it an induction lemma would be circular.
