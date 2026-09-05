# Reflection-polarized product/ratio audit

Date: 2026-08-31

## Exact reflection calculus

Let `U_s` be bilateral translations, `Jf(x)=f(-x)`, and

`C_alpha=int U_s d alpha(s)`

for a real finite measure `alpha`. With `sharp=J(*)J`,

`C_alpha^*=C_(check alpha)`, `C_alpha^sharp=C_alpha`.

Therefore

`C_alpha^*C_alpha=C_(check alpha*alpha)`

is the ratio/difference square, whereas

`C_alpha^sharp C_alpha=C_(alpha*alpha)`

is the product/sum square.

For `P_+=(I+J)/2` and a translation-invariant spectral kernel `k`,

`<P_+e_s,P_+e_r>=[k(r-s)+k(r+s)]/2`.

This proves that reflection supplies the equal ratio/product weights in a cosine square.

## Exact odd-leakage identity

In the parity decomposition `H=H_+ direct-sum H_-`, every `J`-selfadjoint operator has

`C=[[H,B],[-B^*,K]]`, with `H=H^*` and `K=K^*`.

For `x in H_+`,

`||Cx||^2=<x,(H^2+BB^*)x>`,

`[Cx,Cx]_J=<x,(H^2-BB^*)x>=<x,P_+C^2P_+x>`,

and

`||P_+Cx||^2=<x,H^2x>=<x,P_+C^2P_+x>+||B^*x||^2`.

The extra positive term is the parity-odd/sine leakage. Hence reflection makes products and ratios coexist, but Selberg product information still has the wrong orientation for an upper bound on cosine energy.

For a single delay, this is the elementary identity

`cos^2(x)=[1+cos(2x)]/2`, `sin^2(x)=[1-cos(2x)]/2`.

The pair transmission `tau_a V` is not this sine port: both `tau_a` and `Theta_a` act on the already-even cosine waveform `V`.

## Compression corrupts multiplication

Even projection cannot be inserted between arithmetic steps. On the three-state space with basis `e_-1,e_0,e_1`, let

`S e_-1=e_0`, `S e_0=e_1`, `S e_1=0`, and `J e_k=e_-k`.

Then

`P_+S^2P_+e_0=0`,

but

`(P_+SP_+)^2e_0=e_0/2`.

The inserted projection converts a genuine forward exit into a spurious ratio-return loop. The exact correction is the odd excursion

`P_+S^2P_+=(P_+SP_+)^2+P_+SP_-SP_+`.

In a two-prime lattice, repeated compression likewise inserts ratio orbits and halves the forward product amplitude. Reflection must therefore be retained through the full dynamics and used only at final observation.

## Endpoint and exit completion

For `nu=mu-m delta_T`, bilateral convolution retains

`nu*nu=mu*mu-2m(delta_T*mu)+m^2delta_(2T)`

and

`check nu*nu=check mu*mu-m(check mu*delta_T+delta_-T*mu)+m^2delta_0`.

These are the exact endpoint sum/difference coefficients of `V_M^2`.

With finite-horizon compression `P` and exit `X_alpha=(I-P)C_alpha P`,

`P C_alpha^*C_beta P=A_alpha^*A_beta+X_alpha^*X_beta`.

Thus reflection plus the full exit history restores provenance but gives no inequality.

## Pair/coherent conservation

The frozen pair identity gives, for each `a`,

`B||V||_omega^2=B||tau_a V||_omega^2+B||P(Theta_aV)||_omega^2+J_a^2`.

The hidden sectors are distinct: odd/sine leakage, `tau` transmission, coherent scalar, hard exits, and endpoint paths. None can be deleted or counted as another.

Choosing the exact frozen spectral density `omega Theta_a^2` and the coherent quotient reproduces the PASE kernel. This is observation recompletion, not contractive slack.

## Scale-superconnection sign audit

With `Q=partial_lambda+W(lambda)` and reflection/Krein adjoint,

`Q^sharp Q=-partial_lambda^2-W'+W^2`.

For `W=diag(A_P,-A_C)`, the continuum block cancels and the prime block retains the Selberg/Miura curvature. But the factorization is indefinite. It already fails positivity at `W=0`: a scale test vector in the negative reflection sector gives

`int [QF,QF]_J<0`.

Hilbert adjunction restores positivity only by replacing the product square with the ratio square.

## New scale-boundary port

Endpoint zero-mass completion does not commute with scale flow. If

`m(lambda)=int e^(-lambda s)dmu(s)`

and

`nu(lambda)=T_lambda mu-m(lambda)delta_T`,

then

`nu'+d nu=-[int (T-s)e^(-lambda s)dmu(s)]delta_T`.

This terminal moment is a mandatory new port in any scale-superconnection using the completed source.

## First failed equation

The hoped-for positive identity

`even/cosine energy <= product/Selberg supply`

fails exactly because

`even/cosine energy=product compression+odd/sine leakage`.

The smallest counterexample is the three-state shift above.

The natural conservative source norm also does not equal `(4-L)^2`. Adding a scalar input of norm `|4-L|` and a hidden defect is possible exactly when LP is already true, so it is target-equivalent.

## Next forced branch

Because the odd channel is the sine transform of a one-sided source, the next non-arbitrary possibility is to exploit causality: after a legitimate Hardy-space regularization, cosine and sine boundary values are harmonic conjugates. The exact question is whether this relation survives the localized weights `omega Theta_a^2`, the coherent projection, the endpoint completion, and the mesoscopic window with a favorable one-way bound. Unweighted Hardy equality is insufficient.

## Status

Reflection bookkeeping: PROVED.

Even-compressed arithmetic dynamics: DISPROVED.

Reflection-derived LP contractivity: DISPROVED in source-independent form; LOAD-BEARING OPEN for any new source-specific causal mechanism.

RH: STILL OPEN.
