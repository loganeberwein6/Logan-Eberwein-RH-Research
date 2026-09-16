import Mathlib.Data.Complex.Basic

namespace SR

noncomputable def spectralPolynomial (eigenvalues : List ℝ) (z : ℂ) : ℂ :=
  (eigenvalues.map (fun a => z - (a : ℂ))).prod

theorem spectralPolynomial_eq_zero_iff {eigenvalues : List ℝ} {z : ℂ} :
    spectralPolynomial eigenvalues z = 0 ↔
      ∃ a ∈ eigenvalues, z = (a : ℂ) := by
  induction eigenvalues with
  | nil =>
      simp [spectralPolynomial]
  | cons a rest ih =>
      simp only [spectralPolynomial, List.map_cons, List.prod_cons]
      rw [mul_eq_zero, ih]
      constructor
      · intro h
        rcases h with h | h
        · exact ⟨a, by simp, sub_eq_zero.mp h⟩
        · rcases h with ⟨b, hb, hz⟩
          exact ⟨b, by simp [hb], hz⟩
      · rintro ⟨b, hb, hz⟩
        rcases (List.mem_cons.mp hb) with rfl | hb
        · exact Or.inl (sub_eq_zero.mpr rfl)
        · exact Or.inr (ih.mpr ⟨b, hb, hz⟩)

theorem spectralPolynomial_zero_has_real_parameter
    {eigenvalues : List ℝ} {z : ℂ}
    (hzero : spectralPolynomial eigenvalues z = 0) :
    ∃ a ∈ eigenvalues, z.im = 0 := by
  rcases spectralPolynomial_eq_zero_iff.mp hzero with ⟨a, ha, hz⟩
  refine ⟨a, ha, ?_⟩
  rw [hz]
  simp

end SR
