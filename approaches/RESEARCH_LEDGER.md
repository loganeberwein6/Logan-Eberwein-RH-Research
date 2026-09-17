# RH finite-source program: proof ledger

Date: 2026-08-31

This ledger records only statements reconstructed from the supplied program or proved below. It is not a proof of RH. The analytic definitions of `w_u`, `Gamma`, JECMW, WCGM, `Q_M`, and `Q_W` were not included in the supplied text, so the downstream implication chain cannot yet be audited end to end.

## Exact Hilbert-algebra equivalence

**STATUS:** PROVED (conditional only on the displayed quantities being finite and `B>0`).

Let `f=C_M+2`, `h=Gamma+2`, `B=||h||_omega^2`, `S=<f,h>_omega`, `D=C_M-Gamma=f-h`, and `L=<D,h>_omega=U-G`. Orthogonal projection gives

`B||Pf||_omega^2 = B||f||_omega^2-S^2`

and, since `Pf=PD`,

`B||PD||_omega^2 = B||D||_omega^2-L^2`.

Using `U=S-B+G`, A2R is equivalent to

`B||f||_omega^2 + Q^av <= S^2-8S+8B+16 = 8B+(S-4)^2`,

which is PASE. Using `U=L+G`, A2R is also equivalent to

`B||D||_omega^2-L^2+Q^av+8L <= 16`,

hence to LP:

`B||D||_omega^2+Q^av <= (4-L)^2`.

No arithmetic inequality has been proved by these reversible rewrites.

### Lorentz-sign audit

**STATUS:** PROVED correction to the geometric interpretation.

LP is initially `||x_obs|| <= |4-L|`. However Cauchy--Schwarz and the first component of `x_obs` give

`L^2 <= B||D||_omega^2 <= ||x_obs||^2`.

Therefore LP implies `L^2 <= (4-L)^2`, hence `L<=2` and `4-L>=2`. Within this exact observation geometry, LP is consequently equivalent to membership in the standard forward Lorentz cone. The caution is methodological: a passive/causal construction cannot assume the sign before it has derived an inequality strong enough to force it.

### Relaxed-source scaling obstruction

**STATUS:** KILLED (source-independent/scaling-stable descendants); PROVED counterexample.

For a relaxed source take `D=c h` and suppress the pair channel. Then `L=cB` and `B||D||^2=L^2`. LP becomes `L^2<=(4-L)^2`, which fails for every `L>2` and has negative `4-L` for `L>4`. More generally, under `D_lambda=lambda d`, `V_lambda=lambda v`, write the observed quadratic energy as `lambda^2 e` and `ell=<d,h>`. LP becomes

`lambda^2(e-ell^2)+8 lambda ell-16 <= 0`,

with `e>=ell^2`; it fails for large positive scaling whenever `e>ell^2`, and also when `e=ell^2` with `ell>0`. Thus any theorem that accidentally extends the desired passivity/contractivity to arbitrary scaled sources is false. The actual finite Mangoldt source dependence is load-bearing.

## Finite divisibility shifts

**STATUS:** PROVED.

On `H_X = ell^2({m in N:m<X})`, define

`S_a e_m = e_(am)` if `am<X`, and `0` otherwise.

Then

- `S_a S_b=S_(ab)` exactly;
- `S_a^*e_n=e_(n/a)` when `a|n`, and `0` otherwise;
- `S_a^*S_a` is the projection onto `span{e_m:am<X}`;
- `I-S_a^*S_a` is precisely the hard-exit projection;
- `S_a^*S_b e_m=e_(bm/a)` exactly when `bm<X` and `a|bm`, and is zero otherwise.

Writing `E_a=I-S_a^*S_a`, the hard-exit projections obey the exact orthogonal recursion

`E_(ab)=E_b+S_b^*E_aS_b`.

The minimal simultaneous isometric completion is given on `ell^2(N)` by `V_a e_m=e_(am)`. If `P_X` projects onto `m<X`, then `S_a=P_XV_aP_X` and the exit operators `X_a=(I-P_X)V_aP_X` satisfy

`X_a^*X_b=P_XV_a^*V_bP_X-S_a^*S_b`, and `X_a^*X_a=E_a`.

Adjoining unitary reverse moves leads to the multiplicative group completion on `ell^2(Q_+)`. These are faithful recompletions of the product, ratio, and exit data, but they do not supply a PASE upper bound.

Thus forward-forward composition records products, while adjoint-forward composition records ratios/common cofactors. These identities do not provide the upper bound in LP.

## Pair two-port identity

**STATUS:** PROVED, including the removable resonances.

Away from `1-cos(pi x)cos(a x)=0`, direct expansion gives

`(cos(pi x)-cos(a x))^2 + sin^2(pi x)sin^2(a x) = (1-cos(pi x)cos(a x))^2`,

so `tau_a^2+Theta_a^2=1`.

At a common resonance `x_0`, where `cos(pi x_0)=cos(a x_0)=epsilon` with `epsilon=+/-1`, the continuous extensions are

`Theta_a(x_0)=2 pi a/(pi^2+a^2)` and

`tau_a(x_0)=epsilon(a^2-pi^2)/(pi^2+a^2)`,

which still have squared sum one.

## Incidence logarithmic derivative

**STATUS:** PROVED coefficientwise for the finite stopped convolution algebra.

For `Z_P=sum_(n<X)n^(-1/2) delta_(log n)`, its stopped-convolution inverse is `sum_(n<X)mu(n)n^(-1/2)delta_(log n)`, because the coefficient at `n<X` is `n^(-1/2)sum_(d|n)mu(d)`. Consequently

`Z_P^(-1) star_T dZ_P = sum_(n<X) Lambda(n)n^(-1/2)delta_(log n)`.

Applying the grading and expanding convolution gives coefficient

`Lambda(n)log n + sum_(ab=n)Lambda(a)Lambda(b) = (mu*log^2)(n)`.

For the continuum density `A_C=e^(s/2)ds`, both `dA_C` and `A_C star_T A_C` have density `s e^(s/2)`.

## Exact endpoint mismatch in the Volterra representation

**STATUS:** KILLED (Volterra-only colligation); PROVED counterexample.

For causal convolution on `L^2(0,T)`,

`(V_(delta_T)f)(x)=0`

for almost every `x in (0,T)`. Hence `V_(delta_T)=0` as an operator and `V_(nu_M)=V_(mu_M)`, even though the exact Fourier observation is

`V_M(t)=C_M(t)-m_M cos(2t)`.

Equivalently, define the zero-mass endpoint completion

`Pi_T alpha=alpha-alpha([0,T])delta_T`.

Then `Pi_T^2=Pi_T` and `nu_M=Pi_T mu_M`, but the Volterra representation satisfies `V_(Pi_T alpha)=V_alpha`. It factors through the quotient that erases exactly the completion, whereas cosine observation does not. Also `nu_M([0,T])=0`, so the endpoint enforces `V_M(0)=0`; dropping it changes the zero-frequency value to `m_M`. Since `Theta_a(0)=2 pi a/(pi^2+a^2)` after removable extension, the pair observation detects this loss directly.

**FIRST FAILED EQUATION:** any claimed factorization in which the exact endpoint-dependent PASE observation factors through `alpha -> V_alpha`.

**SMALLEST COUNTEREXAMPLE:** the source `alpha=delta_T`, which is nonzero and has cosine transform `cos(2t)` at scale `T=2M`, but maps to the zero Volterra operator.

This mismatch also occurs inside the actual completed-source family, not only for a relaxed test. If `0<M<=(log 2)/2`, then `1<X<=2` and there are no prime atoms. Hence

`m_M=-int_0^(2M)e^(s/2)ds=-2(e^M-1) != 0`,

so `nu_M=-e^(s/2)1_(0,T)ds+2(e^M-1)delta_T`. Volterra compression deletes its nonzero endpoint term, while the exact cosine channel retains `2(e^M-1)cos(2t)`.

**STRUCTURAL OBSTRUCTION:** the `L^2(0,T)` causal representation is nonfaithful on terminal boundary mass. This is more basic than a sign or dissipativity failure: the state has already discarded required information.

A scalar terminal-output patch is not bounded on the stated Hilbert space: `(alpha*f)(T)` requires point evaluation such as `f(0)` when `alpha=delta_T`, and point evaluation is not a bounded functional on `L^2(0,T)`. Moreover `delta_T=delta_s star_T delta_(T-s)` for every `0<s<T`; a multiplicative lift that retains `delta_T` must retain the intermediate boundary paths as well. Thus a faithful cure requires an atomic/rigged/Sobolev path state or an equivalent full-shift dilation, and its changed Hilbert metric must be matched to the exact PASE metric rather than assumed.

**STRICTNESS DELTA:** none; adding a boundary port only restores faithfulness and supplies no LP inequality by itself.

**BACK-SUBSTITUTION EFFECT:** none yet.

**NEXT FORCED OBJECT:** a boundary-augmented representation retaining the total-mass functional `alpha([0,T])`, the terminal direction `delta_T`, and the full boundary-reaching exit history required by convolution, together with independently proved multiplication, adjoint, and observation identities. A scalar endpoint mass `alpha({T})` alone is insufficient. The natural defect norm of the enlarged state must still be compared with `|4-L|`; assigning that norm by definition would be TARGET-EQUIVALENT.

### Canonical full-shift boundary completion

**STATUS:** PROVED; RECOMPLETION ONLY.

Let `R_s` be the isometric right shift on `K=L^2(0,infinity)`, let `J:L^2(0,T)->K` extend by zero, and put

`S_s=J^*R_sJ`, `E_s=(I-JJ^*)R_sJ`.

Then

`S_s^*S_r+E_s^*E_r=J^*R_s^*R_rJ`,

`E_s^*E_s=I-S_s^*S_s`.

In particular, `S_T=0` but `E_T=R_TJ` is isometric, and for `0<=r<T`,

`E_T^*E_r=S_(T-r)^*`.

Thus the endpoint and its correlations with every interior path live canonically in the exit history `L^2(T,2T)`. This fixes the nonfaithfulness of Volterra compression. Its natural exit Gram is not the exact PASE kernel, so the construction currently restores bookkeeping but gives no contractive slack.

### Continuum supply identity

**STATUS:** PROVED; KILLED ordinary one-sign dissipativity.

For `K=V_(e^(s/2)ds)` on `L^2(0,T)` and `g=Kf`, one has `g(0)=0` and `g'=f+g/2`. Integration by parts yields

`2 Re <Kf,f> = |g(T)|^2-||g||_2^2`.

The sign is indefinite: `g(x)=sin(pi x/T)` gives a negative value, while `g(x)=(x/T)^n` gives `1-T/(2n+1)>0` when `2n+1>T`. Hence neither `K` nor `-K` is dissipative on ordinary `L^2(0,T)`. The exact continuum geometry forces a terminal positive port and a distributed negative/bulk port, i.e. an indefinite/Krein supply law; this identity alone does not match the PASE metric.

### Single-nilpotent projective primitive

**STATUS:** KILLED as a faithful Selberg/Miura lift; formal primitive identity PROVED.

All compactly supported distributional solutions of `sK=e^(s/2)ds` have the form

`<K_c,phi>=int_0^T e^(s/2)(phi(s)-phi(0))/s ds+c phi(0)`.

The ambiguity is exactly `c delta_0`. Also `(m_M/T)delta_T` is a primitive of `m_M delta_T`, and `-2delta_0'` is a primitive of `2delta_0` because `s delta_0'=-delta_0`. These finite-part and jet kernels are not bounded Volterra convolvers on plain `L^2`; closed domains and boundary conditions would have to be supplied.

There is a more basic algebraic failure. For `N^2=0`, the formal unipotent `Z=I+NK_c` satisfies `Z^(-1)dZ=NA_C`, but

`(NA_C)^2=0`

while `A_C star_T A_C=dA_C` is nonzero. Encoding the arithmetic connection in the same nilpotent direction likewise erases `A_P^2` and the central cross term `4A_P`. Therefore the proposed single `2x2` nilpotent lift cannot preserve the load-bearing Selberg/Miura sector. A faithful graded repair needs at least composable length-two arrows with nonzero product, together with their adjoints; this is again a recompletion until its metric and supply law match LP.

### Closed central-jet realization

**STATUS:** PROVED; RECOMPLETION ONLY.

Let `D_0 f=f'` with domain `{f in H^1(0,T):f(0)=0}`. Then causal convolution by the central primitive has the rigorous realization

`V_(-2delta_0')=-2D_0`, ` [X,-2D_0]=2I`.

Integration by parts gives

`Re<-2D_0f,f>=-|f(T)|^2`.

Moreover `-2D_0` is maximal dissipative: for every positive `lambda`, the first-order problem `(lambda I+2D_0)f=g`, `f(0)=0`, has a unique `H^1` solution for each `g in L^2`. Its adjoint uses the opposite terminal boundary condition. Thus the central jet forces a terminal trace defect port rather than eliminating boundary data.

The continuum operator is `K=(D_0-I/2)^(-1)`, yielding the boundary-minus-bulk law above. Neither its graph norm/supply form nor the terminal trace norm is the exact `w_u`, `Theta_a`, coherent-quotient PASE metric, and neither derives `|4-L|`.

The exact endpoint loss inside the pair channel can be displayed explicitly. Put `e(t)=cos(2t)`, `g_a=Theta_a C_M`, and `r_a=Theta_a e`. If the endpoint is discarded, the remaining pair energy is

`Q_0=(B/a_0) int ||P g_a||^2 da`.

The exact correction is

`Q^av-Q_0=-(2Bm_M/a_0) int <P g_a,P r_a> da +(Bm_M^2/a_0) int ||P r_a||^2 da`.

Thus both a linear and a positive quadratic endpoint coefficient are missing from a Volterra-only state.

## Finite hostile matrix tests

**STATUS:** PROVED; KILLED generic groupoid positivity/one-defect descendants.

For a hard-truncated one-prime tower with basis `(e_0,e_1)` and `S e_0=e_1`, `S e_1=0`, one has

`S^2=0`, `S^*S=P_(e_0)`, and `I-S^*S=P_(e_1)`.

The ratio energy of `L=cS` on `e_0` is `c^2`, while the stated hard-exit defect `I-S^*S` vanishes there. The pulled-back/output defect

`S^*(I-S^*S)S=I-SS^*=P_(e_0)`

is forced. Longer towers require delayed/pulled-back exit data, not a single terminal projection.

On the three-state tower, `L^2=c^2|e_2><e_0|` while `L^*L=c^2 diag(1,1,0)`, so product and energy occupy different matrix coefficients.

On the two-prime divisor square `{1,p,q,pq}`, for `L=c_pS_p+c_qS_q`, the cross term of `L^2` is

`2c_pc_q|pq><1|`,

whereas the cross term of `L^*L` is

`c_pc_q(|q><p|+|p><q|)`.

These are the two different diagonals of the square. A coefficient-preserving comparison requires a plaquette state retaining both, not ordinary vertex/arrow positivity.

For the central shift `A=2I+cS` on the two-state tower,

`A^2=4I+4cS`,

but

`A^*A=4I+2c(S+S^*)+c^2P_(e_0)`.

Thus the exact forward `+4c` coefficient is split into `+2c` forward and `+2c` reverse Gram coefficients. This is the first coefficient mismatch after endpoint faithfulness is artificially repaired.

In a common-cofactor square `{m,pm,qm,pqm}` with distinct primes `p,q` and `(pq,m)=1`, `mu(pm)mu(qm)=mu(m)^2>0`; parity cancellation does not occur within the fiber. A cofactor label is load-bearing.

## Failure of the raw Mangoldt connection to be passive

**STATUS:** KILLED (unshifted incidence operator as dissipative/Schur coefficient); PROVED finite counterexample.

Let

`A=sum_(n<X) Lambda(n)n^(-1/2)S_n`.

It is strictly upper triangular under increasing integer order, hence nonzero nilpotent once `X>2`. If its Hermitian dissipative part were semidefinite, that part would have trace zero and therefore vanish; `A` would then be skew-adjoint as well as nilpotent, forcing `A=0`. Thus the actual nonzero `A` is not dissipative in either sign convention without added ports/shifts.

It is not even contractive at the first small cell containing `2,3,4,5`. For `5<X<=6`,

`||Ae_1||^2=(log2)^2/2+(log3)^2/3+(log2)^2/4+(log5)^2/5 approximately 1.2807>1`.

A Julia normalization therefore introduces a bulk attenuation defect not equal to the natural hard-exit projection and changes the actual Mangoldt coefficient.

For the no-fit resolvent `F(z)=zA(I-zA)^(-1)`, the coefficients are `F_1=A` and `F_2=A^2`, so the second coefficient is the forward/product convolution. The first Schur defect instead begins with `I-A^*A`, which is a ratio/Gram object. These coefficient types are distinct before the Archimedean, pair-frame, and coherent-rank-one terms are even inserted.

For an atomic cosine feature `phi_s(t)=cos(ts/M)`, the pair-channel covariance kernel when coefficients are taken in the completed source `nu_M` is

`K(s,r)=(B/(2a_0)) int_0^a0 int omega(t)Theta_a(t/u)^2 [cos(t(s-r)/M)+cos(t(s+r)/M)] dt da`

`      -(1/a_0) int_0^a0 j_a(s)j_a(r) da`,

where `j_a(s)=int w_u(t)Theta_a(t/u)phi_s(t)dt`.

Thus difference/ratio and sum/product frequencies occur with equal unprojected weight at the same quadratic level, followed by the exact coherent rank-one subtraction. The natural resolvent/Schur expansion places them in different coefficients. Adding a GNS port whose metric is defined to be `K` would merely re-encode PASE and is TARGET-EQUIVALENT unless independent structure supplies contractive slack.

If coefficients are instead taken in the original source `mu_M`, endpoint completion changes the feature to

`q_s(t)=cos(ts/M)-cos(2t)`,

because `V_M(t)=int q_s(t)dmu_M(s)`. The exact `mu_M`-coefficient kernel is obtained from the displayed formula by replacing every `phi_s` by `q_s`; omitting this replacement loses the endpoint projection.

## Shifted Selberg coefficient sign

**STATUS:** PROVED coefficient formula; KILLED coefficientwise positivity.

With `L_0=2I+A`, the coefficient at `S_n`, `n>1`, in `-dL_0+L_0^2` is

`[Lambda*Lambda(n)+Lambda(n)(4-log n)]/sqrt(n)`.

For `n=p^k` this equals

`p^(-k/2) log(p)(4-log(p))`,

which is negative for every prime `p>e^4`, first at `p=59`. For `n=p^a q^b` it is the positive coefficient `2log(p)log(q)/sqrt(n)`, and the sector with at least three distinct primes vanishes. Thus the central `2delta_0` produces the exact `+4Lambda` cross term, but not coefficientwise positivity or dissipativity.

## Full-shift/Toeplitz endpoint completion

**STATUS:** PROVED (faithful boundary completion); **RECOMPLETION ONLY** as a route to PASE.

Let `H=L^2(0,T)`, let `J:H -> K=L^2(0,infinity)` be zero extension, and let

`(R_sF)(x)=1_(s,infinity)(x)F(x-s)`.

Then `R_s` is an isometry, `R_sR_r=R_(s+r)`, and the compressed and exit maps

`S_s=J^*R_sJ`, `E_s=(I-JJ^*)R_sJ`

satisfy, for `0<=r,s<=T`,

`S_s^*S_r+E_s^*E_r=J^*R_s^*R_rJ`,

`E_s^*E_s=I-S_s^*S_s=1_(T-s,T)`,

`S_T=0`, `E_T^*E_T=I`, and `E_T^*E_r=S_(T-r)^*` for `r<T`.

Thus the terminal atom is wholly in the exit port, and its cross terms with every interior delay are nonzero backward-shift paths. For a finite measure `alpha`, put `W_alpha=int R_s d alpha(s)`, `V_alpha=J^*W_alpha J`, and `E_alpha=(I-JJ^*)W_alpha J`. Then

`J^*W_alpha^*W_beta J=V_alpha^*V_beta+E_alpha^*E_beta`.

For delays at most `T`, the canonical exit history is `L^2(T,2T)`. A scalar terminal port retains the coefficient of `delta_T` but not all of its multiplicative cross paths.

This completion restores information only. Its natural Toeplitz Gram is not the exact PASE pair metric. If `c_s(t)=cos(ts/M)`, the exact pair kernel on the completed source `nu` is

`K_Q(s,r)=(1/a_0)int_0^(a_0)[B int omega Theta_a^2 c_s c_r dt-(int w_u Theta_a c_s dt)(int w_u Theta_a c_r dt)]da`.

For `nu=mu-m delta_T`, its endpoint contribution is exactly

`-2m int K_Q(s,T)dmu(s)+m^2K_Q(T,T)`.

Equivalently, because `m=mu([0,T])`, the quadratic kernel on the original source `mu` uses `q_s(t)=c_s(t)-c_T(t)=cos(ts/M)-cos(2t)` in both slots. Thus a source-state construction must also retain the total-mass scalar that creates the endpoint coefficient.

No identity equating `E_alpha^*E_alpha` with this weighted cosine kernel has been derived. Choosing an observation/square root to force that equality simply reconstructs the already-given PASE feature space.

## Projective continuum primitive and its gauge obstruction

**STATUS:** PROVED distributional identity; **KILLED** as a canonical bounded colligation.

For `A_C=e^(s/2)ds`, every distributional solution of `d K_C=A_C`, where `d` is multiplication by `s`, has the form

`K_C=Fp(e^(s/2)/s)+c delta_0`.

More explicitly, if `chi=1` near zero, one may set

`<K_(chi,c),phi>=int_0^T e^(s/2)(phi(s)-phi(0)chi(s))/s ds+c phi(0)`.

Then `<sK_(chi,c),phi>=int_0^T e^(s/2)phi(s)ds`. Changing `chi` or `c` changes the primitive by a multiple of `delta_0`, and every distribution supported at zero killed by multiplication by `s` is such a multiple. Hence `A_C` does not canonically determine `K_C`.

With `N^2=0`, the formula

`(I-NK_C) d(I+NK_C)=N A_C`

is valid algebraically on test functions. It is not yet an operator-system identity on `L^2(0,T)`: convolution by the finite part of `1/s` is unbounded, with logarithmic growth on high-frequency test functions. The `c delta_0` ambiguity adds `cI` but cannot remove this growth. Thus `I+NK_C` is only an unbounded triangular operator on a proper common domain. Its cotangent lift has a Krein form identity only on suitable common domains, not the bounded everywhere-defined `J`-unitarity needed for a standard Schur/passive colligation.

There is an earlier algebraic loss if this same nilpotent direction is used as the completed arithmetic connection: `(NA)(NB)=0` for every pair `A,B`. In particular `(NA_C)^2=0` although `A_C star_T A_C=dA_C` is nonzero. It likewise deletes `A_P^2` and, if the central `2delta_0` is put in the same direction, the load-bearing `+4A_P` cross term in `(A_P+2delta_0)^2`. The 2-by-2 projective lift linearizes the connection but is not faithful to the forward product/Selberg sector. A product-faithful graded lift needs at least a length-two composable path (distinct matrix arrows with nonzero product), as well as reverse/adjoint arrows for the PASE Gram sector.

The endpoint primitive is less singular: `d((m/T)delta_T)=m delta_T`. It still disappears after Volterra compression and survives only in the full-shift exit state above.

After a finite-part constant and boundary realization are chosen, closed unbounded realizations can be made (for example, the causal derivative realization below, and a closed functional-calculus realization of the finite-part convolution). They are not canonical consequences of `A_C`: changing the finite-part constant adds `cI`, while changing the derivative boundary condition changes the adjoint and boundary form. A canonical *bounded* Krein realization therefore does not follow.

For a boundedly invertible `Z`, the cotangent identity with `J=[[0,I],[I,0]]` is exact:

`diag(Z,(Z^(-1))^*)^* J diag(Z,(Z^(-1))^*)=J`.

It preserves only the cross pairing. It supplies no Hilbert-norm bound: already the finite-dimensional unipotent `Z_c=[[1,c],[0,1]]` has arbitrarily large Euclidean gain as `|c|` grows while its cotangent lift remains `J`-unitary. Choosing a fundamental symmetry/polarization so that this cross pairing becomes the exact PASE norm is additional metric data, not a consequence of the lift.

## Central atom as a boundary jet

**STATUS:** PROVED distributionally; **KILLED** as an automatic bounded-state cure.

On distributions on the real line,

`s delta_0'=-delta_0`, hence `d(-2delta_0')=2delta_0`.

But convolution by `delta_0'` is differentiation, not a bounded operator on `L^2(0,T)`. If `f in H^1(0,T)` is extended by zero, then distributionally

`D(Jf)=Jf'+f(0)delta_0-f(T)delta_T`.

Also Green's identity gives

`2 Re <f',f>=|f(T)|^2-|f(0)|^2`.

Therefore a `delta_0'` primitive forces a Sobolev/rigged domain and both boundary traces; it cannot add the central `2delta_0` while silently omitting the terminal trace. The bounded alternative is to keep `2delta_0` as the exact feedthrough `2I`, without claiming it is exact in the bounded Volterra algebra.

There is a precise causal closed realization once the left boundary condition is made explicit. Let `D_0f=f'` on `Dom(D_0)={f in H^1(0,T):f(0)=0}`. Then `-D_0` is the maximal dissipative generator of the right-shift semigroup,

`[X,-2D_0]=2I`, and `Re<-2D_0f,f>=-|f(T)|^2`.

Its adjoint uses the opposite terminal boundary condition. Hence the central jet can be realized as a closed maximal-dissipative operator only together with a selected causal domain and its terminal defect trace. This is useful boundary structure, but it still supplies no weighted PASE estimate.

## Exact continuum boundary/Krein identity

**STATUS:** PROVED; natural form is indefinite and does not equal PASE.

Let

`(Kf)(x)=int_0^x e^((x-y)/2)f(y)dy`, and put `g=Kf`.

Then `g in H^1`, `g(0)=0`, and `g'=f+g/2`. Consequently

`2 Re <Kf,f>=|g(T)|^2-||g||_2^2`.

Equivalently, for `Psi f=(g(T),g)` and the Krein form `J_C=diag(1,-I)`,

`[Psi f,Psi f]_(J_C)=2 Re <Kf,f>`.

Both signs occur: a nonzero `g in H_0^1(0,T)` gives a negative value, while a function concentrated near `T` with nonzero terminal trace gives a positive value. Thus the continuum convolution is neither dissipative nor accretive without a boundary condition/port. The forced continuum state is at least the bulk storage `g` plus the terminal scalar `g(T)`.

The corresponding Hermitian delay kernel is `e^(|s-r|/2)`. It has no `u`, `a`, `Theta_a`, `w_u`, or coherent `h` subtraction. Therefore it is not the exact PASE kernel. A Krein or boundary system can encode LP only after proving a source-derived conservation law whose output is exactly `x_obs` and whose positive input charge is exactly `4-L`. Merely declaring

`|4-L|^2-||x_obs||^2=||z_hidden||^2`

or choosing a metric/feature square root to make it so is equivalent to LP, not a proof.

**FIRST FAILED EQUATION AFTER ENDPOINT REPAIR:** the unsupported identification of the natural Toeplitz/Green boundary defect with `B||D||_omega^2+Q^av`. The former is fixed by shift overlap and the exponential Green identity; the latter is the frozen weighted cosine/pair/coherent kernel.

**MINIMAL FORCED STATE:** a faithful boundary construction must retain (i) the uncompressed shift path with exit history `L^2(T,2T)` and the total-mass scalar that determines `-m delta_T`, (ii) the continuum bulk/terminal pair `(g,g(T))`, (iii) central and terminal trace/feedthrough data if boundary jets are used, and, to represent the exact observation, (iv) both pair channels `Theta_a,tau_a` and the coherent scalar removed by `P_(h^perp)`. These components restore all load-bearing data, but no proved natural Krein form on them yields the PASE Lorentz inequality.

## Endpoint-neutralized support births

**STATUS:** PROVED exact localization; no monotonicity consequence.

The completed pair input can be written

`V_M(t)=int_[0,T] [cos(ts/M)-cos(2t)] dmu_M(s)`.

When a prime power `N` is born at `M_0=(log N)/2`, with `a_N=Lambda(N)/sqrt(N)`, the strict-cutoff one-sided jumps are

`Delta m=a_N`, `Delta C=a_N cos(2t)`, `Delta V=0`.

An atom at `s<T` contributes `a[cos(ts/M)-cos(2t)]`, whose absolute value is at most

`a min(2, |t|(2M-s)/M)`.

Thus endpoint completion exactly cancels the discontinuity in `V_M` at every support birth, although `D=C_M-Gamma` still jumps.

Freeze the analytic data and write the LP defect as `F=B||D||^2+q(V,V)-(4-L)^2`, where `q` is the pair-channel bilinear form. Under a positive atomic perturbation `a delta_s` with mandatory endpoint update, set `phi_s=cos(ts/M)` and `psi_s=phi_s-cos(2t)`. Exact expansion gives

`Delta F=2aR_s+a^2K_s`,

`R_s=B<D,phi_s>+q(V,psi_s)+(4-L)<phi_s,h>`,

`K_s=B||P phi_s||^2+q(psi_s,psi_s)>=0`.

At an actual birth, `psi_T=0`. A birth-by-birth proof would therefore need signed full-covariance control on `R_T`; shifted Selberg coefficients do not determine this sign. This proposed induction condition is not currently lower-information than PASE.

## Common-cofactor Gram invariant

**STATUS:** PROVED; RECOMPLETION ONLY.

For `L=sum c_aS_a`, write `m=gr`, `n=gs`, `(r,s)=1`. Equality of common outputs gives

`<Le_m,Le_n>=sum_(k lcm(m,n)<X) conjugate(c_(ks))c_(kr)`.

For `c_a=Lambda(a)/sqrt(a)`, unique factorization restricts off-diagonal fibers to distinct-prime pairs when `r,s>1` and to same-prime towers when one of `r,s` is one. This exactly reindexes the ratio covariance; it is not an upper bound and it retains the completed covariance problem after continuum and endpoint terms are restored.

## Torus-recurrence obstruction

**STATUS:** PROVED against uniform all-frequency cancellation.

For fixed `M`, choose integers `k_j->infinity` so the finite torus rotation at `t_j=pi k_j` makes `exp(i t_j log p/M)->1` for every prime `p<X`. Then `cos(2t_j)=1` exactly. The elementary continuum transform

`I_M(t)=[e^M((1/2)cos(2t)+(t/M)sin(2t))-1/2]/[1/4+(t/M)^2]`

satisfies `I_M(t_j)->0`, while all prime powers align. Consequently `V_M(t_j)->2(e^M-1)`.

This rules out uniform all-frequency logarithmic or bounded cancellation, but not a localized `w_u` estimate. In the mesoscopic regime `t=O(u)`, `1<<u<<M`,

`I_M(t)-I_M(0)cos(2t)=4e^M(t/M)sin(2t)+2(cos(2t)-1)+O(e^M(t/M)^2)`.

Prime and continuum terms must be controlled jointly. The missing explicit formula for `w_u` prevents a rigorous asymptotic for `B`, `L`, or `Q^av` from the supplied material.

## Reflection-polarized scale superconnection

**STATUS:** PROVED factorization and Green identities; **KILLED** as an automatic positive/PASE supply.

Let `R_Tf(x)=f(T-x)` on `L^2(0,T)`. For every real finite delay measure `alpha`,

`V_alpha^*=R_T V_alpha R_T`.

Thus causal real convolution is selfadjoint for the Krein adjoint `A^sharp=R_TA^*R_T`. On a finite scale interval `I=[lambda_0,lambda_1]`, let

`W(lambda)=diag(A_P(lambda),-A_C(lambda))`, `Q=partial_lambda+W`,

where `A'=-dA`. With the block reflection as fundamental symmetry, the formal Krein adjoint is

`Q^sharp=-partial_lambda+W`.

Therefore the exact differential expression is

`Q^sharp Q=-partial_lambda^2-W'+W^2`

`=diag(-partial_lambda^2+dA_P+A_P^2, -partial_lambda^2-dA_C+A_C^2)`

`=diag(-partial_lambda^2+F_P,-partial_lambda^2)`.

If the central atom is retained as the feedthrough `2I` in the prime block, this becomes

`diag(-partial_lambda^2+F_P+4A_P+4I,-partial_lambda^2)`.

Hence the exact shifted `+4A_P` coefficient survives this factorization.

For sufficiently regular scale states `F,G`, the exact Green formula is

`int_I ([QF,G]-[F,Q^sharp G])d lambda=[F,G]_(lambda_0)^(lambda_1)`.

This also fixes the operator domains. If `Q` is taken on maximal `H^1(I;H)`, then `Q^sharp` has `H^1` domain with both endpoint values zero. If `Q` has minimal `H_0^1` domain, `Q^sharp` is maximal. More generally a scale boundary condition `F(lambda_1)=U F(lambda_0)` has the same adjoint boundary condition precisely when `U` is Krein-unitary. No such periodic/unitary identification of the two physical scale endpoints is supplied by the arithmetic, so it cannot be used merely to delete the Green term.

Taking `G=QF` gives

`int_I[QF,QF]=int_I[F,Q^sharp QF]+[F,QF]_(lambda_0)^(lambda_1)`.

Equivalently,

`int_I[QF,QF]=int_I[F',F']+int_I[F,(-W'+W^2)F]+[F,WF]_(lambda_0)^(lambda_1)`.

The scale-boundary term is therefore unavoidable unless an explicit boundary relation is imposed. It is an operator-valued reflection pairing at two scale endpoints, not the scalar `(4-L)^2`.

The decisive sign failure is that `[QF,QF]` is a Krein square, not a nonnegative quantity. Already with `W=0`, choose `F(lambda,x)=chi(lambda)f(x)`, with `chi` compactly supported in the interior of `I` and `R_Tf=-f`. Then

`int_I[QF,QF]=-||chi'||_2^2||f||_2^2<0`,

with all scale-boundary terms zero. Adding bounded `W` cannot cure this source-independently, since rapid scale oscillation makes the negative derivative term dominant. Hilbert adjunction would restore positivity but replace `W^2` by the ratio-type `W^*W`, losing the Selberg product. This is the product/positivity obstruction in exact factorized form.

In the fundamental decomposition `H=H_+ direct_sum H_-`, every `J`-selfadjoint `A` has the block form

`A=[[H,B],[-B^*,K]]`, with `H=H^*`, `K=K^*`.

Consequently

`P_+A^2P_+=H^2-BB^*`.

For an even vector `x`, the exact three energies are

`[Ax,Ax]=||Hx||^2-||B^*x||^2`,

`||P_+Ax||^2=||Hx||^2=<x,P_+A^2P_+x>+||B^*x||^2`,

`||Ax||^2=<x,P_+A^2P_+x>+2||B^*x||^2`.

Thus even/cosine Hilbert energy equals the forward-product compression plus the positive odd/sine leakage. The latter has the wrong orientation for an upper bound derived from the product sector.

For an even scale state `F=(f,0)`, the Green identity specializes exactly to

`int_I[QF,QF]=int_I ||f'+Hf||^2-int_I||B^*f||^2`

`=int_I||f'||^2+int_I<x,(-H'+H^2-BB^*)x>+[f,Hf]_(lambda_0)^(lambda_1)`.

The scale boundary supply contains `H` but no positive `BB^*` term. Hence it does not control the odd leakage. The central shift changes `H` to `H+2I` but leaves `B` untouched.

A smallest exact warning is the three-state shift on `{e_(-1),e_0,e_1}`, with reflection `Je_k=e_(-k)` and `Se_(-1)=e_0`, `Se_0=e_1`, `Se_1=0`. For the even vector `e_0`,

`P_+S^2P_+e_0=0`, while `(P_+SP_+)^2e_0=(1/2)e_0`.

The extra return loop is exactly `BB^*e_0=(1/2)e_0`. Therefore reflection must be retained through multiplication and only then observed; projecting to the cosine/even channel before squaring changes the product coefficient.

Finally, reflection on an infinite delay space has infinite positive and negative indices, while the LP Lorentz form has a single positive input direction `(4-L)`. A global Krein-unitary identification cannot change this inertia. Reducing the reflection-positive sector to one source-derived charge requires a nontrivial constraint/quotient; choosing that quotient to be the PASE coherent mode would be metric fitting unless independently forced.

### Reflection and the faithful endpoint port

The stopped compression has `V_(delta_T)=0`, so its reflection identity is endpoint-blind. The faithful right shift on `L^2(0,infinity)` cannot be made reflection-selfadjoint by a bounded fundamental symmetry: the right shift and its adjoint have different kernel dimensions. Passing to bilateral translations `U_s` on `L^2(R)` is forced. With

`(J_Tf)(x)=f(T-x)`, one has `J_TU_sJ_T=U_s^*`.

The price is an incoming as well as outgoing boundary history: `J_T` exchanges `L^2(T,infinity)` with `L^2(-infinity,0)`. In particular, the forward endpoint exit `U_TJf`, supported in `(T,2T)`, is `J_T`-null because its reflected copy is supported in `(-T,0)`. Therefore the positive endpoint-square term in exact `Q^av` cannot be the natural Krein norm of the causal outgoing endpoint alone. At minimum, an independently derived incoming/reverse endpoint companion is forced.

If an endpoint coefficient `c(lambda)delta_T` is scaled automorphically, then `c(lambda)=c(0)e^(-lambda T)` and `E'=-dE`. Full dilation retains the additional terms

`dE`, `A E+E A`, and `E^2`

in `-W'+W^2`; compression to `L^2(0,T)` deletes them. These are forward delays `T`, `T+s`, and `2T`, not by themselves the exact PASE endpoint Gram, which also contains reverse/difference paths and coherent subtraction.

There is a second endpoint obstruction if the source is recompleted to zero total mass at every scale. If

`m(lambda)=int e^(-lambda s)dmu(s)`, `nu(lambda)=T_lambda mu-m(lambda)delta_T`,

then

`nu'+dnu=-(m'(lambda)+T m(lambda))delta_T`

`=-[int (T-s)e^(-lambda s)dmu(s)]delta_T`.

Thus zero-mass endpoint completion does not commute with the dilation flow. One must either scale the physical endpoint automorphically and lose zero-mass completion away from the physical scale, or add the displayed boundary forcing as a new port.

**FIRST FAILED EQUATION:** `[QF,QF]>=0`. It is false even in the flat continuum block with zero scale-boundary data.

**FIRST OPEN PASE BRIDGE:** no source-forced boundary relation or incoming/outgoing observation has been derived for which the Green supply equals `(4-L)^2` and the output equals exact `x_obs`. Selecting such a scale boundary metric or observation by definition is target-equivalent to LP.

## Endpoint-completion/scale-flow commutator and terminal hierarchy

**STATUS:** PROVED exact hierarchy and Green identities; finite scalar closure **KILLED** by the continuum sector.

Let

`mu_lambda=T_lambda mu`, `m(lambda)=int e^(-lambda s)dmu(s)`,

`nu_lambda=mu_lambda-m(lambda)delta_T`.

Then `nu_lambda([0,T])=0`, but

`(partial_lambda+d)nu_lambda=-b_1(lambda)delta_T`,

where the forced terminal port is

`b_1(lambda)=m'(lambda)+Tm(lambda)=int (T-s)e^(-lambda s)dmu(s)`.

Define the complete terminal-moment ladder

`b_k(lambda)=int (T-s)^k e^(-lambda s)dmu(s)`, `k>=0`.

Thus `b_0=m`, and exactly

`(partial_lambda+T)b_k=b_(k+1)`.

The endpoint atom in `nu_lambda` contributes zero to `b_k` for `k>=1`; these ports are generated by the bulk source. No finite truncation is dynamically closed: differentiating any energy in `b_0,...,b_N` introduces `b_(N+1)`.

For the actual completed arithmetic bulk,

`b_k^P(lambda)=sum_(n<X) [Lambda(n)/sqrt(n)](T-log n)^k n^(-lambda)`,

`b_k^C(lambda)=-int_0^T (T-s)^k e^((1/2-lambda)s)ds`.

Writing `q=1/2-lambda`, for `q!=0`,

`b_k^C=-[k!/q^(k+1)](e^(qT)-sum_(j=0)^k (qT)^j/j!)`,

and at `q=0`, `b_k^C=-T^(k+1)/(k+1)`.

If the central `2delta_0` is included before zero-mass completion, its exact contribution is

`b_k^(0)=2T^k`.

In particular the central contribution to the first terminal port is `2T`, not the scalar `4`; the arithmetic `4` arises quadratically from `(A_P+2I)^2`, not from this linear boundary moment.

The exponential generating state

`B(lambda,z)=sum_(k>=0)b_k(lambda)z^k/k!=int e^(z(T-s))e^(-lambda s)dmu(s)`

obeys the exact transport equation

`(partial_lambda+T)B=partial_z B`,

with `B(lambda,0)=m(lambda)` and `partial_zB(lambda,0)=b_1(lambda)`. Equivalently,

`B(lambda,z)=e^(zT)m(lambda+z)`.

This hierarchy is exactly the endpoint-centered even/odd Hardy state. With `r=T-s` and `z=t/M`, define

`E_lambda(z)=int [cos(zr)-1]e^(-lambda s)dmu(s)`,

`O_lambda(z)=int sin(zr)e^(-lambda s)dmu(s)`.

Then

`E_lambda(z)=sum_(j>=1)(-1)^j b_(2j)(lambda)z^(2j)/(2j)!`,

`O_lambda(z)=sum_(j>=0)(-1)^j b_(2j+1)(lambda)z^(2j+1)/(2j+1)!`,

and the exact completed cosine transform is

`hat(nu_lambda)_c(z)=cos(zT)E_lambda(z)+sin(zT)O_lambda(z)`.

At the physical scale `z=t/M`, this is `cos(2t)E_lambda(t/M)+sin(2t)O_lambda(t/M)`. Thus the first terminal port `b_1` is only the first Taylor coefficient of the mandatory odd state; exact `V_M`, and therefore exact `Q^av`, require the full even/odd hierarchy.

Because the continuum source has support on an interval, this ladder has no nontrivial finite constant-coefficient closure: such a closure would give a polynomial identity in `T-s` on an interval. The Hardy/entire generating function packages the hierarchy into one object, but it remains an infinite-dimensional recompletion of the source.

For every differentiable test function `phi(lambda,s)`, the exact weak Green identity is

`[<nu_lambda,phi_lambda>]_(lambda_0)^(lambda_1)=int_I <nu_lambda,(partial_lambda-s)phi_lambda>d lambda-int_I b_1(lambda)phi(lambda,T)d lambda`.

For every differentiable symmetric kernel `K_lambda(s,r)`, put

`E_K(lambda)=double_int K_lambda(s,r)dnu_lambda(s)dnu_lambda(r)`.

Then

`E_K'=double_int [partial_lambda K_lambda-(s+r)K_lambda]dnu_lambda(s)dnu_lambda(r)-2b_1(lambda)int K_lambda(T,r)dnu_lambda(r)`.

Thus the natural terminal supply is bilinear between the forced port `b_1` and the endpoint observation. It is not a positive scalar square. Choosing `K_lambda` to transport the exact PASE kernel, or choosing an input metric to complete this bilinear term into `(4-L)^2`, imports the target metric.

The relation to the exact coherent charge is explicit. If

`ell_u(s)=int_0^infinity w_u(t)cos(ts/M)dt`,

then

`4-L=4+G-int ell_u(s)dmu(s)`.

A finite initial segment of the terminal moments does not determine this generally nonpolynomial functional. The full generating state does determine it, but extracting precisely this functional and declaring its square to be the positive supply is target-equivalent to retaining the entire source and reapplying the LP definition.

The odd/reflection Hardy state does not change the orientation: the exact even-energy identity adds the positive odd leakage `||B^*x||^2` to the product compression. Treating that state as Hilbert storage enlarges the required budget; treating it with the Krein sign destroys positivity. No Green identity above collapses it and the infinite terminal ladder to the single source-derived scalar `4-L`.

### Verification of the reflection endpoint claims

On `L^2(0,T)`, direct integration gives

`(V_alpha^*g)(y)=int_[0,T-y]g(y+s)dalpha(s)=(R_TV_alpha R_Tg)(y)`.

The identity is exact but endpoint-blind because `V_(delta_T)=0` almost everywhere. On `L^2(R)`, for `(U_sf)(x)=f(x-s)` and `(J_Tf)(x)=f(T-x)`,

`J_TU_sJ_T=U_s^*`.

If `psi=U_TJh` for `h` supported in `(0,T)`, then `psi` is supported in `(T,2T)` and `J_Tpsi` in `(-T,0)`, so

`[psi,psi]_(J_T)=0`.

The entire causal outgoing exit space is neutral and is paired with an incoming reverse copy. This verifies that the positive PASE endpoint square cannot be the natural reflection norm of the forward endpoint exit alone.

## Endpoint-centered low-frequency and causal-pair test

**STATUS:** PROVED exact expansions; finite moment closure **KILLED**; Householder/all-pass route is **RECOMPLETION ONLY**.

At the physical scale put `z=t/M`, `r=T-s`, and `b_k=int r^k dmu(s)`. Besides the completed cosine transform

`V(z)=int [cos(zs)-cos(zT)]dmu(s)`,

introduce its sine companion

`S(z)=int [sin(zs)-sin(zT)]dmu(s)`.

With the even/odd endpoint-centered functions `E(z)=int(cos(zr)-1)dmu` and `O(z)=int sin(zr)dmu`, the exact orthogonal reflection is

`V=cos(zT)E+sin(zT)O`,

`S=sin(zT)E-cos(zT)O`.

Since `T=2M`, `zT=2t`. Their low-frequency expansions are

`V=(Tb_1-b_2/2)z^2+(b_4/24+T^2b_2/4-Tb_3/6-T^3b_1/6)z^4+O(z^6)`,

`S=-b_1z+(b_3/6-Tb_2/2+T^2b_1/2)z^3+(-b_5/120+Tb_4/24-T^2b_3/12+T^3b_2/12-T^4b_1/24)z^5+O(z^7)`.

In general, the coefficient of `z^n` uses the endpoint-centered moments through `b_n`, with a nonzero coefficient on `b_n`. For the central test `mu=2delta_0`, one has `b_k=2T^k`, hence `V=2(1-cos(zT))` and `S=-2sin(zT)`, confirming all central and endpoint coefficients.

Let `P=pi`, `A=a`, and `Sigma=P^2+A^2`. At the removable point `x=0`,

`Theta_a(x)=[2PA/Sigma][1-(P^2-A^2)^2 x^2/(12Sigma)+O(x^4)]`,

`tau_a(x)=(A^2-P^2)/Sigma+[ (A^2-P^2)P^2A^2/(3Sigma^2)]x^2+O(x^4)`.

At any common resonance with `cos(Px_0)=cos(Ax_0)=epsilon`, their continuous values are

`Theta_a(x_0)=2PA/Sigma`, `tau_a(x_0)=epsilon(A^2-P^2)/Sigma`.

Because `0<a<pi`, both constants at zero are nonzero. Multiplication by either filter is therefore triangular with nonzero diagonal on Taylor coefficients: the coefficient of order `2N` in `Theta_a(t/u)V(t)` still contains the nonzero leading multiple of `b_(2N)`, and similarly for `tau_aV`; the sine companion retains the odd ladder. The removable behavior closes no finite subset of terminal moments.

This infinite-state necessity is canonical. On the continuum sector, the cyclic family `1,r,r^2,...` under multiplication by `r=T-s` is linearly independent on an interval. Equivalently, a polynomial relation would vanish on the continuum support and hence be the zero polynomial. Moreover, compact-interval moment determinacy implies that the full sequence `b_k` determines the finite signed source, whereas every finite prefix has nonzero signed-measure perturbations in its annihilator. Thus an exact linear scale/endpoint state preserving the continuum path cannot be finite-dimensional.

The first source-specific scalar functional required by LP is already

`c_(M,u)(mu)=4+G-int ell_u(s)dmu(s)=4-L`,

where `ell_u(s)=int_0^infinity w_u(t)cos(ts/M)dt`. When `ell_u(T-r)` admits its convergent Taylor expansion on `[0,T]`, this is

`4+G-sum_(k>=0)(-1)^k ell_u^(k)(T)b_k/k!`.

Thus it generically uses the full hierarchy. Defining this exact functional on the Hardy state and assigning its square as the input supply is the LP target charge, not an independently obtained boundary invariant.

Finally, the pair matrix

`U_a=[[tau_a,Theta_a],[Theta_a,-tau_a]]`

is a Householder multiplier: `U_a^*=U_a`, `U_a^2=I`. For input `(V,0)`, it gives the exact lossless decomposition

`B||V||_omega^2=B||tau_aV||_omega^2+B||P(Theta_aV)||_omega^2+J_a^2`,

where `J_a=<Theta_aV,h>_omega=int w_u Theta_aV`. Hence the all-pass defect is identically zero. It only partitions energy into transmission, observed contrast, and coherent scalar; it creates no positive supply. A causal all-pass realization, if constructed, can add only an initial-minus-final storage term, not the independently normalized scalar `(4-L)^2`. Selecting that storage metric to be PASE is again recompletion.

## Current load-bearing open equation

**STATUS:** LOAD-BEARING OPEN.

Construct from the completed arithmetic source a contractive system whose first derivative maps a structurally derived input `b` to

`x_obs=(sqrt(B)D, a -> sqrt(B)P(Theta_a V_M))`

and whose independently derived input norm is exactly `||b||=|4-L|`. A generic Schur factorization with these properties is merely equivalent to LP and is not evidence for it.

## RH status

STILL OPEN.
