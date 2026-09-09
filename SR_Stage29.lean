import SR_WeilForm
import Mathlib.Data.Real.Sqrt

namespace SR

noncomputable def SR_weil_form_real (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      (m : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log m) *
        (reesEntryFromNat X m n : ℝ) *
        (n : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log n)

noncomputable def SR_weil_term (X : Nat) (beta gamma : ℝ) (m n : Nat) : ℝ :=
  (m : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log m) *
    (reesEntryFromNat X m n : ℝ) *
    (n : ℝ) ^ (beta - 1 / 2) * Real.cos (gamma * Real.log n)

noncomputable def SR_weil_form_total (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset, SR_weil_term X beta gamma m n

noncomputable def SR_weil_form_int (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      if m * n < X then SR_weil_term X beta gamma m n else 0

noncomputable def SR_weil_form_ext (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      if m * n < X then 0 else SR_weil_term X beta gamma m n

theorem SR_weil_total_eq_real (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_total X beta gamma = SR_weil_form_real X beta gamma := by
  rfl

theorem SR_weil_total_eq_ext_plus_int (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_total X beta gamma =
      SR_weil_form_ext X beta gamma + SR_weil_form_int X beta gamma := by
  unfold SR_weil_form_total SR_weil_form_ext SR_weil_form_int
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  split_ifs <;> ring

theorem SR_weil_Q_eq_total_minus_2int (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_real X beta gamma =
      SR_weil_form_total X beta gamma - 2 * SR_weil_form_int X beta gamma := by
  rw [SR_weil_total_eq_real]
  unfold SR_weil_form_total SR_weil_form_int
  apply congrArg id
  ring_nf

theorem SR_weil_Q_eq_ext_minus_int (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_real X beta gamma =
      SR_weil_form_ext X beta gamma - SR_weil_form_int X beta gamma := by
  rw [SR_weil_total_eq_real]
  rw [SR_weil_total_eq_ext_plus_int]
  ring

structure SR_GrowthCert where
  beta : Float
  gamma : Float
  X_points : List Nat
  Q_values : List Float
  exponent_estimate : Float
  exponent_lower : Float
  exponent_upper : Float

def sr_growth_cert_0_8 : SR_GrowthCert :=
  { beta := 0.8
    gamma := 21.022
    X_points := [30, 110, 210, 500]
    Q_values := [-19.47, 612.41, 1227.86, 22676.61]
    exponent_estimate := 2.4
    exponent_lower := 2.2
    exponent_upper := 2.6 }

def SR_growth_law_conjecture : Prop :=
  ∀ beta gamma : ℝ, ∃ C : ℝ, 0 < C ∧
    ∀ ε : ℝ, 0 < ε → ∃ X₀ : Nat, ∀ X : Nat, X₀ ≤ X →
      |SR_weil_form_real X beta gamma| ≤ C * X ^ (3 * beta + ε) ∧
      C * X ^ (3 * beta - ε) ≤ |SR_weil_form_real X beta gamma|

def SR_growth_upper_envelope_conjecture : Prop :=
  ∀ beta gamma : ℝ, ∃ C : ℝ, 0 < C ∧
    ∀ ε : ℝ, 0 < ε → ∃ X₀ : Nat, ∀ X : Nat, X₀ ≤ X →
      |SR_weil_form_real X beta gamma| ≤ C * X ^ (3 * beta + ε)

def SR_growth_coercivity : Prop :=
  ∀ beta : ℝ, beta > 1 / 2 → ∀ gamma C : ℝ,
    ∃ X₀ : Nat, ∀ X : Nat, X₀ ≤ X →
      C * X ^ (3 / 2 : ℝ) < |SR_weil_form_real X beta gamma|

theorem SR_growth_cert_0_8_consistent :
    sr_growth_cert_0_8.exponent_estimate =
      3 * sr_growth_cert_0_8.beta := by
  native_decide

theorem SR_weil_form_real_allones_X6 :
    SR_weil_form_real 6 (1 / 2) 0 = 14 := by
  norm_num [SR_weil_form_real, completeSupport, reesEntryFromNat,
    Real.zero_rpow, Finset.sum_range_succ]

theorem SR_weil_form_real_gamma_neg (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_real X beta (-gamma) =
      SR_weil_form_real X beta gamma := by
  unfold SR_weil_form_real
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro hm' n hn
  rw [neg_mul, Real.cos_neg]

theorem SR_cos_product_split (a b : ℝ) :
    Real.cos a * Real.cos b =
      (Real.cos (a + b) + Real.cos (a - b)) / 2 := by
  rw [Real.cos_add, Real.cos_sub]
  ring

theorem SR_log_cos_product_split (m n : Nat) (gamma : ℝ) :
    Real.cos (gamma * Real.log m) * Real.cos (gamma * Real.log n) =
      (Real.cos (gamma * Real.log m + gamma * Real.log n) +
        Real.cos (gamma * Real.log m - gamma * Real.log n)) / 2 := by
  exact SR_cos_product_split _ _

theorem SR_weil_term_phase_split (X : Nat) (beta gamma : ℝ) (m n : Nat) :
    SR_weil_term X beta gamma m n =
      ((m : ℝ) ^ (beta - 1 / 2) *
          (reesEntryFromNat X m n : ℝ) * (n : ℝ) ^ (beta - 1 / 2) *
          (Real.cos (gamma * Real.log m + gamma * Real.log n) +
            Real.cos (gamma * Real.log m - gamma * Real.log n))) / 2 := by
  unfold SR_weil_term
  rw [SR_log_cos_product_split]
  ring

noncomputable def SR_weil_form_phase (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      ((m : ℝ) ^ (beta - 1 / 2) *
          (reesEntryFromNat X m n : ℝ) * (n : ℝ) ^ (beta - 1 / 2) *
          (Real.cos (gamma * Real.log m + gamma * Real.log n) +
            Real.cos (gamma * Real.log m - gamma * Real.log n))) / 2

noncomputable def SR_weil_form_phase_plus (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      ((m : ℝ) ^ (beta - 1 / 2) *
          (reesEntryFromNat X m n : ℝ) * (n : ℝ) ^ (beta - 1 / 2) *
          Real.cos (gamma * Real.log m + gamma * Real.log n)) / 2

noncomputable def SR_weil_form_phase_minus (X : Nat) (beta gamma : ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      ((m : ℝ) ^ (beta - 1 / 2) *
          (reesEntryFromNat X m n : ℝ) * (n : ℝ) ^ (beta - 1 / 2) *
          Real.cos (gamma * Real.log m - gamma * Real.log n)) / 2

theorem SR_weil_form_phase_eq_plus_add_minus (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_phase X beta gamma =
      SR_weil_form_phase_plus X beta gamma +
        SR_weil_form_phase_minus X beta gamma := by
  unfold SR_weil_form_phase SR_weil_form_phase_plus SR_weil_form_phase_minus
  apply Finset.sum_congr rfl
  intro m hm
  rw [Finset.sum_add_distrib]
  apply Finset.sum_congr rfl
  intro n hn
  ring

theorem SR_weil_form_real_eq_phase (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_real X beta gamma = SR_weil_form_phase X beta gamma := by
  unfold SR_weil_form_real SR_weil_form_phase SR_weil_term
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro hm' n hn
  rw [SR_log_cos_product_split]
  ring

theorem SR_weil_form_abs_le_term_abs (X : Nat) (beta gamma : ℝ) :
    |SR_weil_form_real X beta gamma| ≤
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset, |SR_weil_term X beta gamma m n| := by
  unfold SR_weil_form_real
  calc
    |∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset, SR_weil_term X beta gamma m n| ≤
        ∑ m ∈ (completeSupport X).toFinset,
          |∑ n ∈ (completeSupport X).toFinset, SR_weil_term X beta gamma m n| := by
            apply Finset.abs_sum_le_sum_abs
    _ ≤ ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset, |SR_weil_term X beta gamma m n| := by
          apply Finset.sum_le_sum
          intro m hm
          apply Finset.abs_sum_le_sum_abs

theorem SR_weil_term_abs_le_weight (X : Nat) (beta gamma : ℝ) (m n : Nat)
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X) :
    |SR_weil_term X beta gamma m n| ≤
      |(m : ℝ) ^ (beta - 1 / 2)| * |(n : ℝ) ^ (beta - 1 / 2)| := by
  unfold SR_weil_term
  rw [abs_mul, abs_mul, abs_mul]
  have hre : |(reesEntryFromNat X m n : ℝ)| = 1 := by
    rcases reesEntry_neg_or_pos X m n with h | h <;> simp [h]
  rw [hre]
  have hc : |Real.cos (gamma * Real.log m)| ≤ 1 := Real.abs_cos_le_one _
  have hc' : |Real.cos (gamma * Real.log n)| ≤ 1 := Real.abs_cos_le_one _
  positivity

theorem SR_weil_form_abs_le_power_sum (X : Nat) (beta gamma : ℝ) :
    |SR_weil_form_real X beta gamma| ≤
      ∑ m ∈ (completeSupport X).toFinset,
        ∑ n ∈ (completeSupport X).toFinset,
          |(m : ℝ) ^ (beta - 1 / 2)| * |(n : ℝ) ^ (beta - 1 / 2)| := by
  apply le_trans (SR_weil_form_abs_le_term_abs X beta gamma)
  apply Finset.sum_le_sum
  intro m hm
  apply Finset.sum_le_sum
  intro n hn
    exact SR_weil_term_abs_le_weight X beta gamma m n
    (by simpa using hm) (by simpa using hn)

theorem SR_power_sum_factorization (X : Nat) (beta : ℝ) :
    (∑ m ∈ (completeSupport X).toFinset,
      ∑ n ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)| * |(n : ℝ) ^ (beta - 1 / 2)|) =
      (∑ m ∈ (completeSupport X).toFinset,
        |(m : ℝ) ^ (beta - 1 / 2)|) ^ 2 := by
  simp only [pow_two]
  rw [Finset.sum_mul]
  apply Finset.sum_congr rfl
  intro m hm
  rw [Finset.mul_sum]
  apply Finset.sum_congr rfl
  intro n hn
  ring

theorem SR_weil_form_phase_minus_zero (X : Nat) (beta : ℝ) :
    SR_weil_form_phase_minus X beta 0 =
      SR_weil_form_phase_plus X beta 0 := by
  unfold SR_weil_form_phase_minus SR_weil_form_phase_plus
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  rw [zero_mul, zero_mul, Real.cos_zero]
  ring

theorem SR_weil_form_phase_plus_gamma_neg (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_phase_plus X beta (-gamma) =
      SR_weil_form_phase_plus X beta gamma := by
  unfold SR_weil_form_phase_plus
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  rw [neg_mul, Real.cos_neg]

theorem SR_weil_form_phase_minus_gamma_neg (X : Nat) (beta gamma : ℝ) :
    SR_weil_form_phase_minus X beta (-gamma) =
      SR_weil_form_phase_minus X beta gamma := by
  unfold SR_weil_form_phase_minus
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  rw [neg_mul, neg_mul, Real.cos_neg]
  ring

theorem SR_weil_form_real_zero_gamma_eq_twice_phase_plus (X : Nat) (beta : ℝ) :
    SR_weil_form_real X beta 0 =
      2 * SR_weil_form_phase_plus X beta 0 := by
  rw [SR_weil_form_real_eq_phase, SR_weil_form_phase_eq_plus_add_minus,
    SR_weil_form_phase_minus_zero]
  ring

noncomputable def SR_Hilbert_inner (X : Nat) (f g : Nat → ℝ) : ℝ :=
  ∑ m ∈ (completeSupport X).toFinset,
    ∑ n ∈ (completeSupport X).toFinset,
      Real.log m * f m * (reesEntryFromNat X m n : ℝ) *
        Real.log n * g n / Real.sqrt ((m * n : Nat) : ℝ)

theorem SR_Hilbert_inner_symmetric (X : Nat) (f g : Nat → ℝ) :
    SR_Hilbert_inner X f g = SR_Hilbert_inner X g f := by
  unfold SR_Hilbert_inner
  classical
  rw [Finset.sum_comm]
  apply Finset.sum_congr rfl
  intro m hm
  apply Finset.sum_congr rfl
  intro n hn
  simp [mul_comm, mul_left_comm, mul_assoc]

noncomputable def SR_Hilbert_inner_list (X : Nat) (f g : Nat → ℝ) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      Real.log m * f m * (reesEntryFromNat X m n : ℝ) *
        Real.log n * g n / Real.sqrt ((m * n : Nat) : ℝ))).sum)).sum

theorem SR_Hilbert_inner_list_allones (X : Nat) :
    SR_Hilbert_inner_list X (fun _ => 1) (fun _ => 1) =
      SR_HalfWeightedSum X := by
  unfold SR_Hilbert_inner_list SR_HalfWeightedSum
  apply congrArg id
  apply congrArg List.sum
  apply List.map_congr_left
  intro m hm
  apply congrArg List.sum
  apply List.map_congr_left
  intro n hn
  simp [div_eq_mul_inv, mul_comm, mul_left_comm, mul_assoc]

end SR
