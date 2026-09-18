import lean.weil.SR_WeilForm
import lean.spectral.SR_ZeroTransfer

/-!

# RH Operator Search: Criteria and Ruled-Out Classes

-/

open SR

#check SR_form_has_negative_direction
#check SR_no_psd_realization_preserving_raw_form
#check SR_global_coercivity_false
#check SR_form_is_indefinite_of_positive
#check SR_X6_indefinite
#check SR_X6_negative_basis_witness
#check SR_allones_quadratic_X6
#check nonzero_transfer_of_margin

/-!

## Six required properties for an RH-proving operator

P1: det(I-T(s))=0 at each zeta zero
P2: Tr(T^n) counts prime powers with weight Lambda(p^k)
P3: Some canonical quadratic form Q[T] >= 0
P4: T(s) and T(1-s) related; Re(s)=1/2 is fixed line
P5: T constructible from integers; T_X -> T as X->inf
P6: det(I-T(s)) well-defined, analytically continuable

NO KNOWN OPERATOR SATISFIES ALL SIX.
The gap between P3+P5 (SR results) and P1+P2+P6 (spectral zeta) IS RH.
-/
