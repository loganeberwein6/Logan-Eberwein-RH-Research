# Causal Hardy and terminal-moment audit

Date: 2026-08-31

## Valid causal relation

For a real finite measure `alpha` supported in `[0,T]`, its Fourier--Laplace transform has boundary parts

`F_alpha(t)=U_alpha(t)+iS_alpha(t)`.

Distributionally,

`S_alpha=H(U_alpha-alpha({0}))`.

For `nu_M`, there is no central atom and `S_nu=H V_M`. The endpoint contributes both `-m cos(Tt)` and `-m sin(Tt)`.

The actual atomic source is not an ordinary `H^2` boundary function. The safe regularization

`G_eps(z)=F_alpha(z)/(eps-iz)`

belongs to `H^2`, but

`Re G_eps=(eps U-tS)/(eps^2+t^2)`,

`Im G_eps=(tU+eps S)/(eps^2+t^2)`.

Thus regularization mixes the exact cosine and sine features; de-regularization is unbounded.

## Exact localization failure

Applying unweighted Hardy equality after a nonconstant multiplier `m` would require

`H M_m=M_m H`.

The exact commutator is

`[H,M_m]f(t)=pi^(-1) pv int (m(r)-m(t))/(t-r) f(r)dr`.

It is generically an infinite-rank Hankel leakage port.

For the coherent projection `P=I-|h><h|/B`,

`P m H U=H P(mU)-[H,P](mU)-P[H,M_m]U`.

The coherent commutator has rank at most two; it cannot absorb the multiplier commutator.

## Exact pair weight is not a weighted-Hardy space

At `t=u`, for every `0<a<a0<pi`,

`Theta_a(1+delta)=-pi tan(a/2)delta+O(delta^2)`.

Hence, when `omega(u)` is finite and positive,

`omega(t)Theta_a(t/u)^2` and the pair-averaged weight both have a quadratic zero at `t=u`. Their reciprocals are not locally integrable, so these weights are not Muckenhoupt `A_2` weights and the Hilbert transform is unbounded in the exact pair norm.

A bump of width `eps` adjacent to the notch has weighted input norm squared of order `eps^3`, while the Hilbert-transform output has norm squared at least of order `eps^2`.

## Endpoint-neutralized low-frequency obstruction

For the exact relaxed atom `alpha=delta_s-delta_T`,

`U(t)=cos(st)-cos(Tt)=((T^2-s^2)/2)t^2+O(t^4)`,

`S(t)=sin(st)-sin(Tt)=(s-T)t+O(t^3)`.

Under any local positive weight near zero, the odd/even energy ratio diverges like `eps^(-2)` as the window shrinks. Since `Theta_a(0)=2pi a/(pi^2+a^2)`, the pair multiplier does not remove this mechanism.

For the actual completed source, define

`b_k(lambda)=int(T-s)^k e^(-lambda s)dmu(s)`.

Then

`(partial_lambda+d)nu_lambda=-b_1(lambda)delta_T`,

`(partial_lambda+T)b_k=b_(k+1)`.

Moreover,

`int s dnu=-b_1`.

Thus `b_1` is exactly the first odd Taylor coefficient. The cosine and pair energy require the full infinite ladder, not just this first port.

The generating state is

`B(lambda,z)=sum b_k z^k/k!=e^(zT)m(lambda+z)`,

and obeys

`(partial_lambda+T)B=partial_z B`.

The continuum interval support prevents finite constant-coefficient closure.

## Kernel evolution

For a symmetric scale-dependent kernel `K_lambda` and

`E_K=doubleint K_lambda(s,r)dnu_lambda(s)dnu_lambda(r)`,

one has

`E_K'=doubleint(partial_lambda K-(s+r)K)dnu dnu`

`     -2b_1 int K(T,r)dnu(r)`.

The natural terminal supply is bilinear, not a positive scalar square. Choosing kernel transport to cancel the bulk by using the exact PASE kernel is metric recompletion.

## First failed equation

The source-independent causal closure would require

`||P Theta_a H U||_(L2(omega)) <= ||P Theta_a U||_(L2(omega))`.

It is false; the left-side map is unbounded in the exact pair weight. Unweighted Hardy equality and ordinary `A_2` theory do not apply to the atomic, localized PASE state.

## Next forced object

Any surviving causal construction must retain:

1. the atomic regularization/deconvolution port;
2. the infinite-rank localization Hankel port;
3. the coherent commutator port;
4. the full terminal moment state `B(lambda,z)`;
5. a source-specific positive supply law.

The next exact test is whether the already-forced pointwise orthogonal pair `(Theta_a,tau_a)` is a genuine causal inner two-port whose state realizes the Hankel leakage. If it is not, the pair frame supplies no Hardy repair.

## Status

Unweighted causal conjugacy: PROVED.

Exact weighted/source-independent odd control: DISPROVED.

Terminal moment hierarchy: PROVED, RECOMPLETION ONLY.

LP and RH: STILL OPEN.
