import SR_Stage8

namespace SR

/--
Stage 9A literal arithmetic valuation surface from the objective.

As stated over all natural numbers, this structure is inconsistent: the
additivity law at `0 * p` forces every prime value to vanish, contradicting
`pos`.
-/
structure ArithmeticValuation where
  val : Nat → ℝ
  zero : val 1 = 0
  add : ∀ m n : Nat, val (m * n) = val m + val n
  pos : ∀ p : Nat, Nat.Prime p → 0 < val p

theorem nat_prime_two : Nat.Prime 2 := by
  exact Nat.prime_two

/-- No literal `ArithmeticValuation` over all `Nat` can exist. -/
theorem no_arithmeticValuation_nat :
    ¬ ∃ _v : ArithmeticValuation, True := by
  intro h
  rcases h with ⟨w, _⟩
  have hzero : w.val 0 = w.val 0 + w.val 2 := by
    simpa using w.add 0 2
  have hv2_zero : w.val 2 = 0 := by
    nlinarith
  have hv2_pos : 0 < w.val 2 :=
    w.pos 2 nat_prime_two
  nlinarith

/--
The requested logarithmic-multiple theorem is vacuous for the literal
`ArithmeticValuation`, because no such valuation exists over all `Nat`.
-/
theorem valuation_is_log_multiple :
    ∀ v : ArithmeticValuation,
      ∃ c : ℝ, 0 < c ∧ ∀ n : Nat, 0 < n → v.val n = c * Real.log n := by
  intro v
  have hfalse : False := by
    exact no_arithmeticValuation_nat ⟨v, trivial⟩
  exact False.elim hfalse

/-- Positive natural numbers as the corrected domain for multiplicative laws. -/
abbrev PosNat : Type :=
  { n : Nat // 0 < n }

namespace PosNat

instance : Coe PosNat Nat where
  coe n := n.1

def one : PosNat :=
  ⟨1, by norm_num⟩

def mul (m n : PosNat) : PosNat :=
  ⟨m.1 * n.1, Nat.mul_pos m.2 n.2⟩

@[simp] theorem one_val : (one : Nat) = 1 := rfl

@[simp] theorem mul_val (m n : PosNat) : (mul m n : Nat) = (m : Nat) * (n : Nat) := rfl

def ofPrime (p : Nat) (hp : Nat.Prime p) : PosNat :=
  ⟨p, Nat.Prime.pos hp⟩

end PosNat

/--
Corrected positive-domain arithmetic valuation surface.

This avoids the `0` obstruction while retaining the intended multiplicative
to additive law on positive natural labels.
-/
structure PositiveArithmeticValuation where
  val : PosNat → ℝ
  zero : val PosNat.one = 0
  add : ∀ m n : PosNat, val (PosNat.mul m n) = val m + val n
  pos : ∀ p : Nat, (hp : Nat.Prime p) → 0 < val (PosNat.ofPrime p hp)

/-- A positive scale parameter for Archimedean logarithmic candidates. -/
abbrev PositiveScale : Type :=
  { c : ℝ // 0 < c }

/-- The logarithmic positive-domain valuation associated to a positive scale. -/
noncomputable def logPositiveValuation (c : PositiveScale) : PositiveArithmeticValuation where
  val n := c.1 * Real.log (n : Nat)
  zero := by
    rw [show ((PosNat.one : PosNat) : Nat) = 1 by exact PosNat.one_val]
    rw [Nat.cast_one, Real.log_one, mul_zero]
  add := by
    intro m n
    change c.1 * Real.log (((m : Nat) * (n : Nat) : Nat) : ℝ) =
      c.1 * Real.log ((m : Nat) : ℝ) + c.1 * Real.log ((n : Nat) : ℝ)
    rw [Nat.cast_mul]
    rw [Real.log_mul]
    ring
    · exact_mod_cast m.2.ne'
    · exact_mod_cast n.2.ne'
  pos := by
    intro p hp
    have hlog : 0 < Real.log (p : ℝ) := by
      exact Real.log_pos (by exact_mod_cast Nat.Prime.one_lt hp)
    exact mul_pos c.2 hlog

theorem logPositiveValuation_two (c : PositiveScale) :
    (logPositiveValuation c).val (PosNat.ofPrime 2 nat_prime_two) =
      c.1 * Real.log 2 := by
  rfl

theorem logPositiveValuation_two_pos (c : PositiveScale) :
    0 < (logPositiveValuation c).val (PosNat.ofPrime 2 nat_prime_two) := by
  exact (logPositiveValuation c).pos 2 nat_prime_two

#check ArithmeticValuation
#check nat_prime_two
#check no_arithmeticValuation_nat
#check valuation_is_log_multiple
#check PosNat
#check PositiveArithmeticValuation
#check PositiveScale
#check logPositiveValuation
#check logPositiveValuation_two
#check logPositiveValuation_two_pos

end SR
