# Stage 27 failure record

## Signed denominator comparison

The available theorem

`SR_cauchy_log_version X hX : SR_Sint_log X ^ 2 ≤
SR_S3_log_typed X * SR_S2_log_typed X`

does not compare `SR_HalfWeightedSum X ^ 2` with the same denominator.
The requested theorem for `SR_kappa_log ∈ [0,1]` therefore requires the
additional premise

`SR_HalfWeightedSum X ^ 2 ≤
 SR_S2_log_typed X * SR_S3_log_typed X`.

No proof of this premise is present in the current library, and it cannot be
obtained by rewriting `SR_HalfWeightedSum = SR_S_unsigned_log - 2*SR_Sint_log`.
The Stage 27 file proves the exact conditional upper bound and keeps the
unconditional nonnegativity theorem.  No axiom, sorry, or unsafe declaration
was added.
