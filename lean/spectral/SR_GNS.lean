import SR_Dagger

namespace SR

/--
Observed mixed GNS functional on the `(1,1)` carrier.

At the current foundation stage this is deliberately defined only on `E11`,
not on `E20_6`.
-/
noncomputable def Gamma_obs : E11 →ₗ[ℂ] ℂ where
  toFun x := x.coeff (PrimeIndex6.p2, PrimeIndex6.p2)
  map_add' := by
    intro x y
    rfl
  map_smul' := by
    intro a x
    rfl

theorem Gamma_obs_h22 :
    Gamma_obs (h 2 2) = 1 := by
  norm_num [Gamma_obs, h, E11.coeff, PrimeIndex6.ofNat?, basisValue]

/-- Constructor-indexed `(1,1)` basis vector, avoiding natural-label lookup. -/
def hIdx (i j : PrimeIndex6) : E11 :=
  ULift.up fun current => basisValue (i, j) current

/--
The current observed GNS functional kills the off-diagonal product
`h₂₂ * h₃₃` when basis labels are supplied constructor-directly.
-/
theorem E11_mul_hIdx_p2p2_p3p3_coeff_p2p2_zero :
    hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0 := by
  exact E11_mul_hIdxD_p2p2_p3p3_coeff_p2p2_zero

theorem Gamma_obs_apply (x : E11) :
    Gamma_obs x = x.coeff (PrimeIndex6.p2, PrimeIndex6.p2) := by
  rfl

/--
Positive observed mass for the mixed GNS functional.

The nonnegative quantity is the real norm-square of the observed complex
coefficient.  This is the typed Lean version of positivity available before
any internal product on `E11` is introduced.
-/
theorem GNS_positive :
    ∀ x : E11, 0 ≤ Complex.normSq (Gamma_obs x) := by
  intro x
  exact Complex.normSq_nonneg (Gamma_obs x)

theorem GNS_positive_correct :
    ∀ x : E11, 0 ≤ Complex.re (Gamma_obs (dagger x * x)) := by
  intro x
  let z := x.coeff (PrimeIndex6.p2, PrimeIndex6.p2)
  change 0 ≤ (star z * z).re
  rw [show (star z * z).re = Complex.normSq z by
    simp [Complex.normSq_apply, mul_comm]]
  simpa using Complex.normSq_nonneg z

/--
The observed GNS functional is a functional on `E11`.

This theorem exists as a type-level firewall: after `E11` is wrapped, the
statement is not also a theorem about `E20_6` by definitional equality.
-/
theorem Gamma_obs_domain_E11 :
    Gamma_obs ∈ Set.univ := by
  trivial

/--
Raw coefficient-forgetting bridge from the separated `(1,1)` wrapper into
the ordered `(2,0)` carrier.

This is not a mathematically promoted GNS extension principle; it is a
type-level audit witness.  Since `E11` is implemented as a `ULift` wrapper
around the same coordinate family as `E20_6`, Lean can define this bridge
without importing any product structure.
-/
noncomputable def embed_E11_E20 : E11 →ₗ[ℂ] E20_6 where
  toFun x := x.down
  map_add' := by
    intro x y
    rfl
  map_smul' := by
    intro a x
    rfl

/--
The coordinate functional on `E20_6` matching `Gamma_obs` after the raw
coefficient-forgetting bridge.
-/
noncomputable def Gamma_obs_E20_extension : E20_6 →ₗ[ℂ] ℂ where
  toFun x := x (PrimeIndex6.p2, PrimeIndex6.p2)
  map_add' := by
    intro x y
    rfl
  map_smul' := by
    intro a x
    rfl

theorem Gamma_obs_E20_extension_extends :
    ∀ x : E11, Gamma_obs_E20_extension (embed_E11_E20 x) = Gamma_obs x := by
  intro x
  rfl

/--
Gap 2 audit result: for the raw bridge `embed_E11_E20`, the displayed
non-extension theorem is false.  This witness prevents promoting
`GNS_not_on_E20` without adding extra compatibility hypotheses.
-/
theorem GNS_raw_extension_exists :
    ∃ f : E20_6 →ₗ[ℂ] ℂ,
      ∀ x : E11, f (embed_E11_E20 x) = Gamma_obs x := by
  exact ⟨Gamma_obs_E20_extension, Gamma_obs_E20_extension_extends⟩

#check Gamma_obs
#check Gamma_obs_h22
#check hIdx
#check E11_mul_hIdx_p2p2_p3p3_coeff_p2p2_zero
#check Gamma_obs_apply
#check GNS_positive
#check GNS_positive_correct
#check Gamma_obs_domain_E11
#check embed_E11_E20
#check Gamma_obs_E20_extension
#check Gamma_obs_E20_extension_extends
#check GNS_raw_extension_exists

end SR
