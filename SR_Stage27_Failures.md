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

## Stage 27 unblock attempt

The direct nested-`List` proof of the triangle theorem does not typecheck with
`List.abs_sum_le_sum_abs`: Mathlib exposes the corresponding theorem for
`Finset`, while the existing SR sums are nested `List.sum`s. The attempted
map-congruence proof also fails because the unsigned definition uses coerced
list elements and is not definitionally identical to the natural-valued
nested sum. A Fin/Finset transport lemma is required before the triangle
theorem can be stated over the existing definitions.
