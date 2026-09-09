import SR_Mollifier
import Mathlib.Analysis.InnerProductSpace.PiL2

namespace SR

/-! Stage 25: corrected arithmetic-bridge scaffolding. -/

noncomputable def SR_S1_log (X : Nat) : ℝ :=
  SR_HalfWeightedSum X

noncomputable def SR_S2_log (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      Real.log m * Real.log n / ((m : ℝ) * n))).sum)).sum

noncomputable def SR_S3_log (X : Nat) : ℝ :=
    ((completeSupport X).map (fun m =>
      ((completeSupport X).map (fun n => Real.log m * Real.log n)).sum)).sum

/-! The von Mangoldt-weighted arithmetic count restricted to the same finite
support used by the Rees matrix.  This keeps the support restriction and the
prime-power weighting separate, which is the datum needed before attempting
any comparison with the unrestricted `ψ₂` sum. -/
noncomputable def psi2_SR (X : Nat) : ℝ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      if m * n < X then vonMangoldt m * vonMangoldt n else 0)).sum)).sum

noncomputable def psi2_SR_interior_count (X : Nat) : ℕ :=
  ((completeSupport X).map (fun m =>
    ((completeSupport X).map (fun n =>
      if m * n < X then 1 else 0)).sum)).sum

theorem SR_S1_log_eq_halfWeighted (X : Nat) :
    SR_S1_log X = SR_HalfWeightedSum X := by
  rfl

lemma vonMangoldt_nonneg (n : Nat) :
    0 ≤ vonMangoldt n := by
  classical
  unfold vonMangoldt
  split_ifs with h
  · have hpprime : Nat.Prime (Classical.choose h) :=
      ((Classical.choose_spec h).choose_spec).1
    have hp : 2 ≤ Classical.choose h := Nat.Prime.two_le hpprime
    have hp1 : 1 ≤ Classical.choose h := le_trans (by norm_num) hp
    exact Real.log_nonneg (by exact_mod_cast hp1)
  · exact le_rfl

theorem psi2_SR_nonneg (X : Nat) : 0 ≤ psi2_SR X := by
  classical
  unfold psi2_SR
  apply List.sum_nonneg
  intro z hz
  rcases List.mem_map.1 hz with ⟨m, hm, rfl⟩
  apply List.sum_nonneg
  intro w hw
  rcases List.mem_map.1 hw with ⟨n, hn, rfl⟩
  split_ifs
  · exact mul_nonneg (vonMangoldt_nonneg m) (vonMangoldt_nonneg n)
  · rfl

/- The signed/unsigned split is intentionally left explicit until the
   definitions are corrected; no false equality is promoted here. -/
theorem SR25_BRIDGE_SIGN_OBSTRUCTION : True := by
  trivial

end SR
