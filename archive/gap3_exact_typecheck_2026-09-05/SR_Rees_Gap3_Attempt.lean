import SR_Rees

namespace SR

/--
Non-imported audit probe for Gap 3.

This file intentionally contains the exact displayed theorem shape so that
Lean can report the type obstruction.  It is not part of `lakefile.lean` and
is not imported into the verified foundation.
-/
theorem rees_not_leibniz_exact_probe :
    ¬ ∃ (d : E10 →ₗ[ℂ] E20_6),
      ∀ x y : E10,
        d (SR_mul x y) = SR_mul (d x) y + SR_mul x (d y) := by
  intro h
  rcases h with ⟨d, hd⟩
  exact False.elim (by contradiction)

end SR
