import lean.core.SR_Primitives
import Mathlib.Data.Complex.Basic
import Mathlib.LinearAlgebra.Dimension.Constructions

namespace SR

namespace FiniteDimensional

/-- Compatibility surface for the stage statement; mathlib's actual constant is `Module.finrank`. -/
noncomputable def finrank (K V : Type*) [Semiring K] [AddCommMonoid V] [Module K V] : Nat :=
  Module.finrank K V

end FiniteDimensional

/-- The four ordered labels used by the frozen X = 6 carrier. -/
inductive PrimeIndex6 where
  | p2
  | p3
  | p4
  | p5
  deriving DecidableEq, Repr

instance : Fintype PrimeIndex6 where
  elems := {PrimeIndex6.p2, PrimeIndex6.p3, PrimeIndex6.p4, PrimeIndex6.p5}
  complete := by
    intro x
    cases x <;> simp

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

/--
Neutral name for the frozen four-label support at `X = 6`.

It is intentionally separate from the prime-only predicate `PrimeSet`, because
the frozen carrier support is `{2,3,4,5}` and therefore includes `4`.
-/
abbrev SupportIndex6 : Type :=
  PrimeIndex6

def SupportIndex6.toNat : SupportIndex6 -> Nat :=
  PrimeIndex6.toNat

def SupportIndex6.ofNat? : Nat -> Option SupportIndex6 :=
  PrimeIndex6.ofNat?

theorem supportIndex6_card :
    Fintype.card SupportIndex6 = 4 := by
  decide

theorem ordered_support_pair_card_X6 :
    Fintype.card (SupportIndex6 × SupportIndex6) = 16 := by
  decide

/-- Ordered degree-two carrier at X = 6. -/
abbrev E20_6 : Type :=
  PrimeIndex6 × PrimeIndex6 -> ℂ

/-- Neutral alias for the ordered degree-two frozen carrier at `X = 6`. -/
abbrev E20_X6 : Type :=
  E20_6

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
  rw [FiniteDimensional.finrank, Module.finrank_fintype_fun_eq_card]
  decide

theorem q23_ne_q32 : q 2 3 ≠ q 3 2 := by
  intro h
  have hval := congrFun h (PrimeIndex6.p2, PrimeIndex6.p3)
  norm_num [q, PrimeIndex6.ofNat?, basisValue] at hval
  cases hval.1

#check E20_6
#check E20_X6
#check SupportIndex6
#check supportIndex6_card
#check ordered_support_pair_card_X6
#check q
#check ordered_carrier_dim_X6
#check q23_ne_q32

end SR
