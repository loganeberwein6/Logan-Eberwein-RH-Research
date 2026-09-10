# Open claims register

This file separates empirical or proposed mathematics from certified Lean
theorems.  None of the entries below is used as a proof of another claim.

| CLAIM | EVIDENCE | STATUS | PROOF PATH |
|---|---|---|---|
| RH is equivalent to the precisely defined adjacent signed-spectrum condition in `SR_ISR.lean`. | No analytic implication has been formalized. | OPEN | Define the spectrum and prove both implications from the explicit formula. |
| The recorded primorial cutoffs have balanced positive and negative signatures. | Lean theorem `SR19_CONJ_PRIMORIAL_BALANCE`; four explicit records. | CERTIFIED | Completed by finite reduction. |
| The primorial zeta-spectrum is governed by the nontrivial zeta zeros. | Only numerical motivation is recorded. | CONJECTURED | Define the spectral transform and compare its residues with the explicit formula. |
| The Stage-16 logarithmic SR sum converges along primorial cutoffs. | Finite values only; no limit estimate. | OPEN | Establish uniform tail bounds for the weighted divisor sum. |
| The signature bound `pos(M_Rees_X) ≤ neg(M_Rees_X)+1` holds for every `X ≥ 6`. | Finite certificates and counter-pressure from the bridge audit. | OPEN | Prove a pairing/involution on nonzero signature vectors. |
| The SR density strand values are decreasing for the recorded parameter sequence. | Recorded decimals in `SR_Density.lean`. | CERTIFIED (recorded data only) | Replace decimal certificates by exact rational values and `native_decide`. |
| The limiting Conrey-style density observable equals the RH-predicted zero-statistics density. | Heuristic comparison only; no limiting density theorem is formalized. | CONJECTURED | Define the density limit and derive it from zero statistics. |
| The SR fixed point exists and is unique in the proposed flow domain. | Current flow file contains only a placeholder proposition. | OPEN | Define the operator and prove contraction or compactness plus uniqueness. |
| The dBN flow cutoff is zero iff RH. | Proposed statement in `SR_Flow.lean`; no bridge theorem. | CONJECTURED | Relate the flow spectrum to the explicit formula. |
| The logarithm-weighted Rees sum is strictly positive for all `X ≥ 6`. | Positivity is proved only for selected finite records. | OPEN | Apply the general below-half-support counting lemma with positive log weights. |
| The half-weighted SR sum is strictly positive for all `X ≥ 6`. | Finite exploratory evidence. | OPEN | Establish a sign-preserving decomposition of the weighted fibers. |
| Finite X=6 logarithmic positivity can be reduced by kernel normalization to an explicit polynomial inequality in `log 2`, `log 3`, and `log 5`. | Two Lean attempts reached opaque `List.range.loop` terms; no false numerical inequality was found. | OPEN | Prove a reusable `List.range`/`foldr` evaluation lemma, then apply positivity of logarithms. |
| The SR upper-bound observable satisfies the advertised `X^(3β+ε)` estimate. | Empirical tests through `X=10000` for one parameter pair; no asymptotic proof. | CONJECTURED | Prove the required cancellation of the total and interior terms. |
| The exact SR form has a bounded `X^(3β)` envelope for fixed `(β,γ)`. | Accelerated computation at `β=.8, γ=21.022` remains bounded through `X=10000`. | CONJECTURED | Retain both sum- and difference-frequency channels in an exponential-sum estimate. |
| dBN/RH equivalence | The finite flow records nonfixed transitions and a negative eigenvalue, but no infinite-time spectrum or RH predicate is formalized. | CONJECTURED | Define the infinite SR flow, its positive-spectrum times, and prove `Λ_SR = sup {t | positive spectrum} = 0 ↔ RH`; current Lean record is only finite evidence. |
| `logWeightedReesSum 6 > 0` | The exact finite sum is defined, but normalization stops at opaque `List.range.loop` terms. | OPEN | Prove a reusable finite-list evaluation lemma and then establish the logarithmic inequality. |
| `SR_HalfWeightedSum 6 > 0` | The weighted finite sum is defined; no sign-preserving decomposition is formalized. | OPEN | Normalize the finite kernel and prove positivity using the square-root weights. |
| Stage-15 `M_Rees_X6` checkpoint agreement | The matrix constructor is present, but no equality to the archived Stage-15 artifact is formalized in the current file. | OPEN | Import the archived checkpoint data and prove entrywise equality. |
| Stage-14 external-sign motivation | External motivation is recorded, but no mathematical implication is formalized. | CONJECTURED | State the external sign condition and prove its relation to the SR signature. |
| Stage-15 reduction audit | The reduction data are recorded, but the complete audit proposition remains open. | OPEN | State each reduction invariant and verify it from the finite matrices. |
| Bridge sign obstruction | The proposed bridge cannot currently transfer finite sign data to the asymptotic analytic claim. | OPEN | Identify a sign-preserving analytic map or prove the obstruction is unavoidable. |
