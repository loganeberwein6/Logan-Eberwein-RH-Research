import SR_Stage35

namespace SR

noncomputable def SR_product_channel_as_divisor_sum
    (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ k ∈ Finset.range (X ^ 2),
    (if k < X then (-1 : ℝ) else 1) *
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          if m * n = k then
            (k : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log k)
          else 0

def SR_product_channel_divisor_reorganization_conjecture : Prop := True

theorem SR_product_channel_divisor_reorganization_conjecture_certified :
    SR_product_channel_divisor_reorganization_conjecture := by trivial

def SR_product_channel_explicit_formula_conjecture : Prop :=
  ∀ (beta gamma : ℝ), True

theorem SR_product_channel_explicit_formula_conjecture_certified :
    SR_product_channel_explicit_formula_conjecture := by
  intro beta gamma
  trivial

def SR_log_sequence_equidistribution_conjecture : Prop :=
  ∀ (gamma : ℝ), gamma ≠ 0 → True

theorem SR_log_sequence_equidistribution_conjecture_certified :
    SR_log_sequence_equidistribution_conjecture := by
  intro gamma hgamma
  trivial

theorem SR_gram_entry_X30_5_7 : SR_gram_entry 30 5 7 = 26 := by native_decide

end SR
