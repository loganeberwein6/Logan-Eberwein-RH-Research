import Mathlib.Data.Real.Basic

namespace SR

/-!
  A positive multi-channel scaffold.  Unlike the rank-one Hermitian square,
  this construction can retain several independent observables while keeping
  a manifestly nonnegative energy.  The arithmetic content is intentionally
  left as channel data; no RH claim is hidden in this abstraction.
-/

def multiChannelEnergy {V : Type} (channels : List (V → ℝ)) (v : V) : ℝ :=
  (channels.map (fun f => (f v) ^ 2)).sum

theorem multiChannelEnergy_nonneg {V : Type}
    (channels : List (V → ℝ)) (v : V) :
    0 ≤ multiChannelEnergy channels v := by
  unfold multiChannelEnergy
  induction channels with
  | nil => simp
  | cons f fs ih =>
      simp only [List.map_cons, List.sum_cons]
      exact add_nonneg (sq_nonneg (f v)) (ih)

theorem multiChannelEnergy_eq_zero_of_all_zero {V : Type}
    (channels : List (V → ℝ)) (v : V)
    (hzero : ∀ f ∈ channels, f v = 0) :
    multiChannelEnergy channels v = 0 := by
  unfold multiChannelEnergy
  induction channels with
  | nil => simp
  | cons f fs ih =>
      rw [List.map_cons, List.sum_cons]
      have hf : f v = 0 := hzero f (by simp)
      have hfs : ∀ g ∈ fs, g v = 0 := by
        intro g hg
        exact hzero g (by simp [hg])
      simp [hf, ih hfs]

theorem multiChannelEnergy_singleton {V : Type}
    (f : V → ℝ) (v : V) :
    multiChannelEnergy [f] v = (f v) ^ 2 := by
  simp [multiChannelEnergy]

/- A signed channel form retains arithmetic sign information as a difference of
  two positive energies.  Positivity is then reduced to a domination estimate,
  rather than imposed by discarding the negative channel. -/
def signedChannelEnergy {V : Type}
    (positive negative : List (V → ℝ)) (v : V) : ℝ :=
  multiChannelEnergy positive v - multiChannelEnergy negative v

theorem signedChannelEnergy_nonneg_of_dominates {V : Type}
    (positive negative : List (V → ℝ)) (v : V)
    (hdom : multiChannelEnergy negative v ≤ multiChannelEnergy positive v) :
    0 ≤ signedChannelEnergy positive negative v := by
  unfold signedChannelEnergy
  exact sub_nonneg.mpr hdom

theorem signedChannelEnergy_eq_difference {V : Type}
    (positive negative : List (V → ℝ)) (v : V) :
    signedChannelEnergy positive negative v =
      multiChannelEnergy positive v - multiChannelEnergy negative v := by
  rfl

end SR
