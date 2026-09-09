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

/- The signed/unsigned split is intentionally left explicit until the
   definitions are corrected; no false equality is promoted here. -/
theorem SR25_BRIDGE_SIGN_OBSTRUCTION : True := by
  trivial

end SR
