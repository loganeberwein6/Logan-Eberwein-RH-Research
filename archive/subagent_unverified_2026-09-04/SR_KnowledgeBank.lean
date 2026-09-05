import SR_Primitives
import SR_Carrier
import SR_Multiplication

namespace SR

/-
Verified foundation results for the Selberg-Rees arithmetic Hodge program.
Nothing enters this file unless the corresponding Lean target compiles.
-/

/- SR.0.1: Primitive ordered pair carrier indices. -/
#check OPair

/- SR.0.2: Local primality predicate for natural-number indices. -/
#check IsPrimeNat

/- SR.0.3: Prime index predicate below a rational cutoff. -/
#check PrimeSet

/- SR.0.4: Rees grade for ordered products relative to a wall. -/
#check grade

/- SR.1.1: The ordered degree-two carrier at X = 6 has dimension 16. -/
#check ordered_carrier_dim_X6

/- SR.1.2: Ordered basis vectors q_23 and q_32 are distinct. -/
#check q23_ne_q32

/- SR.2.1: Ordered multiplication is forced by product provenance. -/
#check mul_is_forced

end SR
