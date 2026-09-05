import SR_Carrier

namespace SR

/-- The six strict ordered-pair directions `m < n` in the `X = 6` support. -/
inductive AntisymIndex6 where
  | p23
  | p24
  | p25
  | p34
  | p35
  | p45
  deriving DecidableEq, Repr

instance : Fintype AntisymIndex6 where
  elems := {
    AntisymIndex6.p23,
    AntisymIndex6.p24,
    AntisymIndex6.p25,
    AntisymIndex6.p34,
    AntisymIndex6.p35,
    AntisymIndex6.p45
  }
  complete := by
    intro x
    cases x <;> simp

/--
The antisymmetric sector carrier at `X = 6`.

This records the six independent skew directions indexed by unordered
off-diagonal support pairs.  It does not assert that these directions are a
radical.
-/
abbrev antisym_subspace (_V : Type) : Type :=
  AntisymIndex6 → ℂ

theorem antisym_dim_X6 :
    FiniteDimensional.finrank ℂ (antisym_subspace E20_6) = 6 := by
  rw [FiniteDimensional.finrank, Module.finrank_fintype_fun_eq_card]
  decide

/-- The strict ordered coordinate associated to an antisymmetric generator. -/
def AntisymIndex6.strictPair : AntisymIndex6 -> PrimeIndex6 × PrimeIndex6
  | AntisymIndex6.p23 => (PrimeIndex6.p2, PrimeIndex6.p3)
  | AntisymIndex6.p24 => (PrimeIndex6.p2, PrimeIndex6.p4)
  | AntisymIndex6.p25 => (PrimeIndex6.p2, PrimeIndex6.p5)
  | AntisymIndex6.p34 => (PrimeIndex6.p3, PrimeIndex6.p4)
  | AntisymIndex6.p35 => (PrimeIndex6.p3, PrimeIndex6.p5)
  | AntisymIndex6.p45 => (PrimeIndex6.p4, PrimeIndex6.p5)

/-- The reversed ordered coordinate associated to an antisymmetric generator. -/
def AntisymIndex6.revPair (idx : AntisymIndex6) : PrimeIndex6 × PrimeIndex6 :=
  (idx.strictPair.2, idx.strictPair.1)

/-- Extract the strict coordinates of an `E20_6` vector. -/
noncomputable def antisymStrictProjection : E20_6 →ₗ[ℂ] antisym_subspace E20_6 where
  toFun v := fun idx => v idx.strictPair
  map_add' := by
    intro x y
    rfl
  map_smul' := by
    intro a x
    rfl

/--
Embed the six antisymmetric directions into the full ordered carrier as
`q_mn - q_nm` coordinate directions.
-/
noncomputable def antisymEmbed : antisym_subspace E20_6 →ₗ[ℂ] E20_6 where
  toFun coeffs := fun current =>
    match current with
    | (PrimeIndex6.p2, PrimeIndex6.p3) => coeffs AntisymIndex6.p23
    | (PrimeIndex6.p3, PrimeIndex6.p2) => -coeffs AntisymIndex6.p23
    | (PrimeIndex6.p2, PrimeIndex6.p4) => coeffs AntisymIndex6.p24
    | (PrimeIndex6.p4, PrimeIndex6.p2) => -coeffs AntisymIndex6.p24
    | (PrimeIndex6.p2, PrimeIndex6.p5) => coeffs AntisymIndex6.p25
    | (PrimeIndex6.p5, PrimeIndex6.p2) => -coeffs AntisymIndex6.p25
    | (PrimeIndex6.p3, PrimeIndex6.p4) => coeffs AntisymIndex6.p34
    | (PrimeIndex6.p4, PrimeIndex6.p3) => -coeffs AntisymIndex6.p34
    | (PrimeIndex6.p3, PrimeIndex6.p5) => coeffs AntisymIndex6.p35
    | (PrimeIndex6.p5, PrimeIndex6.p3) => -coeffs AntisymIndex6.p35
    | (PrimeIndex6.p4, PrimeIndex6.p5) => coeffs AntisymIndex6.p45
    | (PrimeIndex6.p5, PrimeIndex6.p4) => -coeffs AntisymIndex6.p45
    | _ => 0
  map_add' := by
    intro x y
    funext current
    cases current with
    | mk left right =>
        cases left <;> cases right <;> simp [Pi.add_apply] <;> ring_nf
  map_smul' := by
    intro a x
    funext current
    cases current with
    | mk left right =>
        cases left <;> cases right <;> simp [Pi.smul_apply]

theorem antisymProjection_embed :
    antisymStrictProjection.comp antisymEmbed = LinearMap.id := by
  ext coeffs idx
  cases idx <;> rfl

theorem antisymEmbed_injective :
    Function.Injective antisymEmbed := by
  intro x y hxy
  have hproj : antisymStrictProjection (antisymEmbed x) =
      antisymStrictProjection (antisymEmbed y) := by
    exact congrArg antisymStrictProjection hxy
  rw [← LinearMap.comp_apply, antisymProjection_embed, LinearMap.id_apply] at hproj
  rw [← LinearMap.comp_apply, antisymProjection_embed, LinearMap.id_apply] at hproj
  exact hproj

/-- The actual antisymmetric submodule of the full ordered carrier at `X = 6`. -/
noncomputable def antisymSubmodule_X6 : Submodule ℂ E20_6 :=
  LinearMap.range antisymEmbed

/-
Stage 4: no commutative realization can be injective on the full ordered
carrier while identifying every ordered pair with its reversal.

Lean typing note: a codomain of `E20_6 →ₗ[ℂ] R` must explicitly carry a
`Module ℂ R` structure.  The theorem therefore records that structure as
part of the alleged realization data.
-/
theorem no_commutative_realization :
    ¬ ∃ (R : Type*) (_ : CommRing R) (_ : Module ℂ R) (f : E20_6 →ₗ[ℂ] R),
      Function.Injective f ∧
      ∀ m n, f (q m n) = f (q n m) := by
  intro hreal
  rcases hreal with ⟨R, _instCommRing, _instModule, f, hinj, hcomm⟩
  exact q23_ne_q32 (hinj (hcomm 2 3))

#check AntisymIndex6
#check antisym_subspace
#check antisym_dim_X6
#check antisymEmbed
#check antisymProjection_embed
#check antisymEmbed_injective
#check antisymSubmodule_X6
#check no_commutative_realization

end SR
