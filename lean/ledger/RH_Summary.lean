import lean.weil.SR_WeilForm
import lean.spectral.SR_Dagger
import lean.spectral.SR_GNS
import lean.spectral.SR_ZeroTransfer

/-!

# RH Research Program: Formal Ledger Summary

# Source: D:\CodexRH, branch stage31-two-channel

# SR_Stage38 excluded: pre-existing native_decide failures at lines 973-1003

-/

open SR

#check SR_form_has_negative_direction
#check SR_form_not_positive_semidefinite
#check SR_no_psd_realization_preserving_raw_form
#check SR_global_coercivity_false
#check SR_form_is_indefinite_of_positive
#check SR_X6_indefinite
#check SR_X6_negative_basis_witness
#check SR_allones_quadratic_X6
#check SR_uniform_X6_positive
#check SR_uniform_X6_strict
#check SR_uniform_X6_formula
#check dagger_involution
#check dagger_h_swap
#check dagger_diagonal_fixed
#check dagger_add
#check dagger_smul
#check GNS_positive
#check GNS_positive_correct
#check Gamma_obs_domain_E11
#check nonzero_transfer_of_margin
#check uniform_zero_free_transfer
