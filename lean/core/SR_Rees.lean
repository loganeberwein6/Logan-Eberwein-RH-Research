import SR_Multiplication

namespace SR

/--
The Rees wall is represented as a separate two-term object.

It is intentionally not installed as an internal differential on a graded
algebra.  The source and target are separate degree-two carriers, connected
only by the explicitly supplied wall map.
-/
structure ReesCone (X : ℚ) where
  interior : E20_6
  exit : E20_6
  wall_map : E20_6 →ₗ[ℂ] E20_6

/-- The wall crossing associated to a `ReesCone`. -/
def ReesCone.wall {X : ℚ} (C : ReesCone X) : E20_6 :=
  C.wall_map C.interior

/--
An attempted internal dg-style Leibniz package.

This structure is deliberately local: declaring it does not install any
global multiplication, module action, or differential instance.  It records
the extra data one would need before the forbidden Leibniz formula even has
a Lean type.
-/
structure InternalLeibnizPackage where
  prod : E10 → E10 → E10
  prod_comm : ∀ x y : E10, prod x y = prod y x
  realize : E10 →ₗ[ℂ] E20_6
  product_provenance : ∀ m n : Nat, realize (prod (e m) (e n)) = q m n
  d : E10 →ₗ[ℂ] E20_6
  left_action : E20_6 → E10 → E20_6
  right_action : E10 → E20_6 → E20_6
  leibniz :
    ∀ x y : E10,
      d (prod x y) = left_action (d x) y + right_action x (d y)

/--
No internal commutative Leibniz package can preserve the ordered raw product
provenance.  The obstruction is already visible at `(2,3)`: commutativity of
the alleged internal product would force `q 2 3 = q 3 2`.
-/
theorem rees_not_leibniz :
    ¬ ∃ _pkg : InternalLeibnizPackage, True := by
  intro hexists
  rcases hexists with ⟨pkg, _⟩
  have h23 : pkg.realize (pkg.prod (e 2) (e 3)) = q 2 3 :=
    pkg.product_provenance 2 3
  have h32 : pkg.realize (pkg.prod (e 3) (e 2)) = q 3 2 :=
    pkg.product_provenance 3 2
  have hprod : pkg.prod (e 2) (e 3) = pkg.prod (e 3) (e 2) :=
    pkg.prod_comm (e 2) (e 3)
  have hq : q 2 3 = q 3 2 := by
    rw [← h23, ← h32, hprod]
  exact q23_ne_q32 hq

#check ReesCone
#check ReesCone.wall
#check InternalLeibnizPackage
#check rees_not_leibniz

end SR
