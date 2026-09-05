import SR_Carrier

namespace SR

/-- Ordered bidegree `(1,1)` carrier at X = 6. -/
abbrev E11 : Type :=
  PrimeIndex6 × PrimeIndex6 -> ℂ

/-- Ordered `(1,1)` basis vector `h_{m,nbar}`; invalid labels map to zero. -/
def h (m n : Nat) : E11 :=
  fun current =>
    match PrimeIndex6.ofNat? m, PrimeIndex6.ofNat? n with
    | some mi, some ni => basisValue (mi, ni) current
    | _, _ => 0

/-- Dagger swaps the ordered holomorphic and antiholomorphic labels. -/
def dagger (x : E11) : E11 :=
  fun current => x (current.2, current.1)

theorem dagger_involution :
    ∀ x : E11, dagger (dagger x) = x := by
  intro x
  funext current
  cases current with
  | mk left right =>
      rfl

theorem dagger_diagonal_fixed :
    ∀ m, dagger (h m m) = h m m := by
  intro m
  funext current
  cases current with
  | mk left right =>
      cases hm : PrimeIndex6.ofNat? m with
      | none =>
          simp [dagger, h, hm]
      | some a =>
          simp [dagger, h, hm, basisValue]
          cases a <;> cases left <;> cases right <;> decide

#check E11
#check h
#check dagger
#check dagger_involution
#check dagger_diagonal_fixed

end SR
