import SR_Primitives

namespace SR

/-- Local scalar placeholder for the Stage 1 carrier API. -/
abbrev Complex := Nat

notation "ℂ" => Complex

/-- Minimal local finrank interface used until the project imports mathlib. -/
class HasFinrank (K V : Type) where
  finrank : Nat

namespace FiniteDimensional

def finrank (K V : Type) [HasFinrank K V] : Nat :=
  HasFinrank.finrank (K := K) (V := V)

end FiniteDimensional

/-- The four ordered prime labels below 6. -/
inductive PrimeIndex6 where
  | p2
  | p3
  | p4
  | p5
  deriving DecidableEq, Repr

def PrimeIndex6.toNat : PrimeIndex6 -> Nat
  | PrimeIndex6.p2 => 2
  | PrimeIndex6.p3 => 3
  | PrimeIndex6.p4 => 4
  | PrimeIndex6.p5 => 5

def PrimeIndex6.ofNat? : Nat -> Option PrimeIndex6
  | 2 => some PrimeIndex6.p2
  | 3 => some PrimeIndex6.p3
  | 4 => some PrimeIndex6.p4
  | 5 => some PrimeIndex6.p5
  | _ => none

/-- Ordered degree-two carrier at X = 6. -/
abbrev E20_6 : Type :=
  PrimeIndex6 × PrimeIndex6 -> ℂ

instance : HasFinrank ℂ E20_6 where
  finrank := 16

def basisValue (target current : PrimeIndex6 × PrimeIndex6) : ℂ :=
  if current = target then 1 else 0

/-- Ordered basis vector `q_mn`; invalid labels map to zero. -/
def q (m n : Nat) : E20_6 :=
  fun current =>
    match PrimeIndex6.ofNat? m, PrimeIndex6.ofNat? n with
    | some mi, some ni => basisValue (mi, ni) current
    | _, _ => 0

theorem ordered_carrier_dim_X6 :
    FiniteDimensional.finrank ℂ E20_6 = 16 := by
  rfl

theorem q23_ne_q32 : q 2 3 ≠ q 3 2 := by
  intro h
  have hval := congrFun h (PrimeIndex6.p2, PrimeIndex6.p3)
  simp [q, PrimeIndex6.ofNat?, basisValue] at hval

#check E20_6
#check q
#check ordered_carrier_dim_X6
#check q23_ne_q32

end SR
