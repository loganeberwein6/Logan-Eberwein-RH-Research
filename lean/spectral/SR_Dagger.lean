import lean.spectral.SR_Carrier

namespace SR

set_option maxHeartbeats 200000

/-- Ordered bidegree `(1,1)` carrier at X = 6. -/
abbrev E11 : Type :=
  ULift (PrimeIndex6 × PrimeIndex6 -> ℂ)

/-- Read an ordered `(1,1)` coefficient. -/
def E11.coeff (x : E11) (current : PrimeIndex6 × PrimeIndex6) : ℂ :=
  x.down current

/-- Ordered `(1,1)` basis vector `h_{m,nbar}`; invalid labels map to zero. -/
def h (m n : Nat) : E11 :=
  ULift.up fun current =>
    match PrimeIndex6.ofNat? m, PrimeIndex6.ofNat? n with
    | some mi, some ni => basisValue (mi, ni) current
    | _, _ => 0

theorem star_basisValue (target current : PrimeIndex6 × PrimeIndex6) :
    star (basisValue target current) = basisValue target current := by
  unfold basisValue
  split <;> simp

theorem basisValue_diagonal_swap (a left right : PrimeIndex6) :
    basisValue (a, a) (right, left) = basisValue (a, a) (left, right) := by
  unfold basisValue
  by_cases hleft : left = a
  · by_cases hright : right = a
    · subst left
      subst right
      simp
    · simp [hleft, hright]
  · by_cases hright : right = a
    · simp [hleft, hright]
    · simp [hleft, hright]

/-- Dagger conjugates coefficients and swaps the ordered holomorphic and antiholomorphic labels. -/
def dagger (x : E11) : E11 :=
  ULift.up fun current => star (x.coeff (current.2, current.1))

theorem dagger_add (x y : E11) :
    dagger (x + y) = dagger x + dagger y := by
  apply ULift.ext
  funext current
  simp [dagger, E11.coeff]

theorem dagger_smul (a : ℂ) (x : E11) :
    dagger (a • x) = (star a) • dagger x := by
  apply ULift.ext
  funext current
  simp [dagger, E11.coeff]

theorem dagger_h_swap :
    ∀ m n, dagger (h m n) = h n m := by
  intro m n
  apply ULift.ext
  funext current
  cases current with
  | mk left right =>
      cases hm : PrimeIndex6.ofNat? m with
      | none =>
          simp [dagger, h, E11.coeff, hm]
      | some mi =>
          cases hn : PrimeIndex6.ofNat? n with
          | none =>
              simp [dagger, h, E11.coeff, hn]
          | some ni =>
              cases mi <;> cases ni <;> cases left <;> cases right <;>
                simp [dagger, h, E11.coeff, hm, hn, basisValue]

theorem dagger_involution :
    ∀ x : E11, dagger (dagger x) = x := by
  intro x
  apply ULift.ext
  funext current
  cases current with
  | mk left right =>
      simp [dagger, E11.coeff]

theorem dagger_diagonal_fixed :
    ∀ m, dagger (h m m) = h m m := by
  intro m
  apply ULift.ext
  funext current
  cases current with
  | mk left right =>
      cases hm : PrimeIndex6.ofNat? m with
      | none =>
          simp [dagger, h, E11.coeff, hm]
      | some a =>
          simp [dagger, h, E11.coeff, hm, star_basisValue, basisValue_diagonal_swap]

/-- Internal pointwise product on the separated `(1,1)` carrier. -/
def E11_mul (x y : E11) : E11 :=
  ULift.up fun current => x.coeff current * y.coeff current

instance : Mul E11 where
  mul := E11_mul

theorem E11_mul_coeff (x y : E11) (current : PrimeIndex6 × PrimeIndex6) :
    (x * y).coeff current = x.coeff current * y.coeff current := by
  rfl

theorem E11_mul_h_coeff (m n p q : Nat) (current : PrimeIndex6 × PrimeIndex6) :
    (h m n * h p q).coeff current = (h m n).coeff current * (h p q).coeff current := by
  rfl

/-- Constructor-indexed `(1,1)` basis vector, avoiding natural-label lookup. -/
def hIdxD (i j : PrimeIndex6) : E11 :=
  ULift.up fun current => basisValue (i, j) current

/-- Named value for the observed coefficient of the constructor-level `h₂₂ * h₃₃` product. -/
def hIdxDProductCoeff_p2p2_p3p3_at_p2p2 : ℂ :=
  basisValue (PrimeIndex6.p2, PrimeIndex6.p2)
      (PrimeIndex6.p2, PrimeIndex6.p2) *
    basisValue (PrimeIndex6.p3, PrimeIndex6.p3)
      (PrimeIndex6.p2, PrimeIndex6.p2)

/-- The observed `(2,2)` coefficient of the constructor-level `h₂₂ * h₃₃` product is zero. -/
theorem E11_mul_hIdxD_p2p2_p3p3_coeff_p2p2_zero :
    hIdxDProductCoeff_p2p2_p3p3_at_p2p2 = 0 := by
  simp [hIdxDProductCoeff_p2p2_p3p3_at_p2p2, basisValue]

#check E11
#check h
#check dagger
#check dagger_add
#check dagger_smul
#check dagger_h_swap
#check dagger_involution
#check dagger_diagonal_fixed
#check E11_mul
#check E11_mul_coeff
#check E11_mul_h_coeff
#check hIdxD
#check hIdxDProductCoeff_p2p2_p3p3_at_p2p2
#check E11_mul_hIdxD_p2p2_p3p3_coeff_p2p2_zero

end SR
