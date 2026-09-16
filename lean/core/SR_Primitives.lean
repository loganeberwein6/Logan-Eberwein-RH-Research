namespace SR

/-- The Rees grade of an ordered product relative to a wall. -/
inductive ReesGrade where
  | Interior
  | Exit
  deriving DecidableEq, Repr

/-- Ordered carrier indices.  No symmetry relation is imposed. -/
abbrev OPair : Type := Nat × Nat

/-- Local primality predicate for the Stage 0 foundation. -/
def IsPrimeNat (p : Nat) : Prop :=
  2 ≤ p ∧ ∀ a b : Nat, a * b = p → a = 1 ∨ b = 1

/-- Prime indices below a rational cutoff, represented as a predicate. -/
def PrimeSet (X : Rat) : Nat → Prop :=
  fun p => IsPrimeNat p ∧ (p : Rat) < X

/-- Rees grade for an ordered pair of natural indices at a rational cutoff. -/
def grade (m n : Nat) (X : Rat) : ReesGrade :=
  if ((m * n : Nat) : Rat) < X then
    ReesGrade.Interior
  else
    ReesGrade.Exit

#check ReesGrade
#check OPair
#check IsPrimeNat
#check PrimeSet
#check grade

end SR
