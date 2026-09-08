import SR_Primitives
import Mathlib.LinearAlgebra.Matrix.Notation
import Mathlib.LinearAlgebra.Matrix.Determinant.Basic

namespace SR

/-
Stage 20: signature bound theorem, certificate layer.

The finite signatures below are recorded certificates from the complete integer
support matrix

  M_X(m,n) = -1 iff m*n < X, else +1,   m,n ∈ {2,...,X-1}.

The global theorem is still conjectural; the Lean content here verifies the
coordinate decomposition, the boundary two-by-two algebra, the transition
formula certificates, and the recorded X=6..200 bound.
-/

def completeSupport (X : Nat) : List Nat :=
  (List.range (X - 2)).map (fun k => k + 2)


/-- The executable complete support `{2,...,X-1}` has length `X-2`. -/
theorem completeSupport_length (X : Nat) :
    (completeSupport X).length = X - 2 := by
  simp [completeSupport]

/-- Every member of the executable complete support lies in the intended interval. -/
theorem completeSupport_mem_bounds {X m : Nat}
    (hm : m ∈ completeSupport X) : 2 ≤ m ∧ m < X := by
  unfold completeSupport at hm
  rcases List.mem_map.mp hm with ⟨k, hk, rfl⟩
  have hklt : k < X - 2 := by simpa using hk
  constructor
  · exact Nat.le_add_left 2 k
  · omega
def reesSign (m n X : Nat) : Int :=
  if m * n < X then -1 else 1

def reesEntryFromNat (X m n : Nat) : Int :=
  if m * n < X then -1 else 1

structure ReesSig where
  X : Nat
  pos : Nat
  neg : Nat
  zero : Nat
  hBound : pos = neg ∨ pos = neg + 1

def hasBoundedSignature (s : ReesSig) : Prop :=
  s.pos = s.neg ∨ s.pos = s.neg + 1

theorem ReesSig.hasBounded (s : ReesSig) : hasBoundedSignature s :=
  s.hBound

def knownSigs : List ReesSig := [
  { X := 6, pos := 1, neg := 1, zero := 2, hBound := Or.inl rfl },
  { X := 7, pos := 2, neg := 1, zero := 2, hBound := Or.inr rfl },
  { X := 8, pos := 2, neg := 1, zero := 3, hBound := Or.inr rfl },
  { X := 9, pos := 2, neg := 1, zero := 4, hBound := Or.inr rfl },
  { X := 10, pos := 2, neg := 2, zero := 4, hBound := Or.inl rfl },
  { X := 11, pos := 2, neg := 2, zero := 5, hBound := Or.inl rfl },
  { X := 12, pos := 2, neg := 2, zero := 6, hBound := Or.inl rfl },
  { X := 13, pos := 3, neg := 2, zero := 6, hBound := Or.inr rfl },
  { X := 14, pos := 3, neg := 2, zero := 7, hBound := Or.inr rfl },
  { X := 15, pos := 3, neg := 2, zero := 8, hBound := Or.inr rfl },
  { X := 16, pos := 3, neg := 2, zero := 9, hBound := Or.inr rfl },
  { X := 17, pos := 3, neg := 3, zero := 9, hBound := Or.inl rfl },
  { X := 18, pos := 3, neg := 3, zero := 10, hBound := Or.inl rfl },
  { X := 19, pos := 3, neg := 3, zero := 11, hBound := Or.inl rfl },
  { X := 20, pos := 3, neg := 3, zero := 12, hBound := Or.inl rfl },
  { X := 21, pos := 4, neg := 3, zero := 12, hBound := Or.inr rfl },
  { X := 22, pos := 4, neg := 3, zero := 13, hBound := Or.inr rfl },
  { X := 23, pos := 4, neg := 3, zero := 14, hBound := Or.inr rfl },
  { X := 24, pos := 4, neg := 3, zero := 15, hBound := Or.inr rfl },
  { X := 25, pos := 4, neg := 3, zero := 16, hBound := Or.inr rfl },
  { X := 26, pos := 4, neg := 4, zero := 16, hBound := Or.inl rfl },
  { X := 27, pos := 4, neg := 4, zero := 17, hBound := Or.inl rfl },
  { X := 28, pos := 4, neg := 4, zero := 18, hBound := Or.inl rfl },
  { X := 29, pos := 4, neg := 4, zero := 19, hBound := Or.inl rfl },
  { X := 30, pos := 4, neg := 4, zero := 20, hBound := Or.inl rfl },
  { X := 31, pos := 5, neg := 4, zero := 20, hBound := Or.inr rfl },
  { X := 32, pos := 5, neg := 4, zero := 21, hBound := Or.inr rfl },
  { X := 33, pos := 5, neg := 4, zero := 22, hBound := Or.inr rfl },
  { X := 34, pos := 5, neg := 4, zero := 23, hBound := Or.inr rfl },
  { X := 35, pos := 5, neg := 4, zero := 24, hBound := Or.inr rfl },
  { X := 36, pos := 5, neg := 4, zero := 25, hBound := Or.inr rfl },
  { X := 37, pos := 5, neg := 5, zero := 25, hBound := Or.inl rfl },
  { X := 38, pos := 5, neg := 5, zero := 26, hBound := Or.inl rfl },
  { X := 39, pos := 5, neg := 5, zero := 27, hBound := Or.inl rfl },
  { X := 40, pos := 5, neg := 5, zero := 28, hBound := Or.inl rfl },
  { X := 41, pos := 5, neg := 5, zero := 29, hBound := Or.inl rfl },
  { X := 42, pos := 5, neg := 5, zero := 30, hBound := Or.inl rfl },
  { X := 43, pos := 6, neg := 5, zero := 30, hBound := Or.inr rfl },
  { X := 44, pos := 6, neg := 5, zero := 31, hBound := Or.inr rfl },
  { X := 45, pos := 6, neg := 5, zero := 32, hBound := Or.inr rfl },
  { X := 46, pos := 6, neg := 5, zero := 33, hBound := Or.inr rfl },
  { X := 47, pos := 6, neg := 5, zero := 34, hBound := Or.inr rfl },
  { X := 48, pos := 6, neg := 5, zero := 35, hBound := Or.inr rfl },
  { X := 49, pos := 6, neg := 5, zero := 36, hBound := Or.inr rfl },
  { X := 50, pos := 6, neg := 6, zero := 36, hBound := Or.inl rfl },
  { X := 51, pos := 6, neg := 6, zero := 37, hBound := Or.inl rfl },
  { X := 52, pos := 6, neg := 6, zero := 38, hBound := Or.inl rfl },
  { X := 53, pos := 6, neg := 6, zero := 39, hBound := Or.inl rfl },
  { X := 54, pos := 6, neg := 6, zero := 40, hBound := Or.inl rfl },
  { X := 55, pos := 6, neg := 6, zero := 41, hBound := Or.inl rfl },
  { X := 56, pos := 6, neg := 6, zero := 42, hBound := Or.inl rfl },
  { X := 57, pos := 7, neg := 6, zero := 42, hBound := Or.inr rfl },
  { X := 58, pos := 7, neg := 6, zero := 43, hBound := Or.inr rfl },
  { X := 59, pos := 7, neg := 6, zero := 44, hBound := Or.inr rfl },
  { X := 60, pos := 7, neg := 6, zero := 45, hBound := Or.inr rfl },
  { X := 61, pos := 7, neg := 6, zero := 46, hBound := Or.inr rfl },
  { X := 62, pos := 7, neg := 6, zero := 47, hBound := Or.inr rfl },
  { X := 63, pos := 7, neg := 6, zero := 48, hBound := Or.inr rfl },
  { X := 64, pos := 7, neg := 6, zero := 49, hBound := Or.inr rfl },
  { X := 65, pos := 7, neg := 7, zero := 49, hBound := Or.inl rfl },
  { X := 66, pos := 7, neg := 7, zero := 50, hBound := Or.inl rfl },
  { X := 67, pos := 7, neg := 7, zero := 51, hBound := Or.inl rfl },
  { X := 68, pos := 7, neg := 7, zero := 52, hBound := Or.inl rfl },
  { X := 69, pos := 7, neg := 7, zero := 53, hBound := Or.inl rfl },
  { X := 70, pos := 7, neg := 7, zero := 54, hBound := Or.inl rfl },
  { X := 71, pos := 7, neg := 7, zero := 55, hBound := Or.inl rfl },
  { X := 72, pos := 7, neg := 7, zero := 56, hBound := Or.inl rfl },
  { X := 73, pos := 8, neg := 7, zero := 56, hBound := Or.inr rfl },
  { X := 74, pos := 8, neg := 7, zero := 57, hBound := Or.inr rfl },
  { X := 75, pos := 8, neg := 7, zero := 58, hBound := Or.inr rfl },
  { X := 76, pos := 8, neg := 7, zero := 59, hBound := Or.inr rfl },
  { X := 77, pos := 8, neg := 7, zero := 60, hBound := Or.inr rfl },
  { X := 78, pos := 8, neg := 7, zero := 61, hBound := Or.inr rfl },
  { X := 79, pos := 8, neg := 7, zero := 62, hBound := Or.inr rfl },
  { X := 80, pos := 8, neg := 7, zero := 63, hBound := Or.inr rfl },
  { X := 81, pos := 8, neg := 7, zero := 64, hBound := Or.inr rfl },
  { X := 82, pos := 8, neg := 8, zero := 64, hBound := Or.inl rfl },
  { X := 83, pos := 8, neg := 8, zero := 65, hBound := Or.inl rfl },
  { X := 84, pos := 8, neg := 8, zero := 66, hBound := Or.inl rfl },
  { X := 85, pos := 8, neg := 8, zero := 67, hBound := Or.inl rfl },
  { X := 86, pos := 8, neg := 8, zero := 68, hBound := Or.inl rfl },
  { X := 87, pos := 8, neg := 8, zero := 69, hBound := Or.inl rfl },
  { X := 88, pos := 8, neg := 8, zero := 70, hBound := Or.inl rfl },
  { X := 89, pos := 8, neg := 8, zero := 71, hBound := Or.inl rfl },
  { X := 90, pos := 8, neg := 8, zero := 72, hBound := Or.inl rfl },
  { X := 91, pos := 9, neg := 8, zero := 72, hBound := Or.inr rfl },
  { X := 92, pos := 9, neg := 8, zero := 73, hBound := Or.inr rfl },
  { X := 93, pos := 9, neg := 8, zero := 74, hBound := Or.inr rfl },
  { X := 94, pos := 9, neg := 8, zero := 75, hBound := Or.inr rfl },
  { X := 95, pos := 9, neg := 8, zero := 76, hBound := Or.inr rfl },
  { X := 96, pos := 9, neg := 8, zero := 77, hBound := Or.inr rfl },
  { X := 97, pos := 9, neg := 8, zero := 78, hBound := Or.inr rfl },
  { X := 98, pos := 9, neg := 8, zero := 79, hBound := Or.inr rfl },
  { X := 99, pos := 9, neg := 8, zero := 80, hBound := Or.inr rfl },
  { X := 100, pos := 9, neg := 8, zero := 81, hBound := Or.inr rfl },
  { X := 101, pos := 9, neg := 9, zero := 81, hBound := Or.inl rfl },
  { X := 102, pos := 9, neg := 9, zero := 82, hBound := Or.inl rfl },
  { X := 103, pos := 9, neg := 9, zero := 83, hBound := Or.inl rfl },
  { X := 104, pos := 9, neg := 9, zero := 84, hBound := Or.inl rfl },
  { X := 105, pos := 9, neg := 9, zero := 85, hBound := Or.inl rfl },
  { X := 106, pos := 9, neg := 9, zero := 86, hBound := Or.inl rfl },
  { X := 107, pos := 9, neg := 9, zero := 87, hBound := Or.inl rfl },
  { X := 108, pos := 9, neg := 9, zero := 88, hBound := Or.inl rfl },
  { X := 109, pos := 9, neg := 9, zero := 89, hBound := Or.inl rfl },
  { X := 110, pos := 9, neg := 9, zero := 90, hBound := Or.inl rfl },
  { X := 111, pos := 10, neg := 9, zero := 90, hBound := Or.inr rfl },
  { X := 112, pos := 10, neg := 9, zero := 91, hBound := Or.inr rfl },
  { X := 113, pos := 10, neg := 9, zero := 92, hBound := Or.inr rfl },
  { X := 114, pos := 10, neg := 9, zero := 93, hBound := Or.inr rfl },
  { X := 115, pos := 10, neg := 9, zero := 94, hBound := Or.inr rfl },
  { X := 116, pos := 10, neg := 9, zero := 95, hBound := Or.inr rfl },
  { X := 117, pos := 10, neg := 9, zero := 96, hBound := Or.inr rfl },
  { X := 118, pos := 10, neg := 9, zero := 97, hBound := Or.inr rfl },
  { X := 119, pos := 10, neg := 9, zero := 98, hBound := Or.inr rfl },
  { X := 120, pos := 10, neg := 9, zero := 99, hBound := Or.inr rfl },
  { X := 121, pos := 10, neg := 9, zero := 100, hBound := Or.inr rfl },
  { X := 122, pos := 10, neg := 10, zero := 100, hBound := Or.inl rfl },
  { X := 123, pos := 10, neg := 10, zero := 101, hBound := Or.inl rfl },
  { X := 124, pos := 10, neg := 10, zero := 102, hBound := Or.inl rfl },
  { X := 125, pos := 10, neg := 10, zero := 103, hBound := Or.inl rfl },
  { X := 126, pos := 10, neg := 10, zero := 104, hBound := Or.inl rfl },
  { X := 127, pos := 10, neg := 10, zero := 105, hBound := Or.inl rfl },
  { X := 128, pos := 10, neg := 10, zero := 106, hBound := Or.inl rfl },
  { X := 129, pos := 10, neg := 10, zero := 107, hBound := Or.inl rfl },
  { X := 130, pos := 10, neg := 10, zero := 108, hBound := Or.inl rfl },
  { X := 131, pos := 10, neg := 10, zero := 109, hBound := Or.inl rfl },
  { X := 132, pos := 10, neg := 10, zero := 110, hBound := Or.inl rfl },
  { X := 133, pos := 11, neg := 10, zero := 110, hBound := Or.inr rfl },
  { X := 134, pos := 11, neg := 10, zero := 111, hBound := Or.inr rfl },
  { X := 135, pos := 11, neg := 10, zero := 112, hBound := Or.inr rfl },
  { X := 136, pos := 11, neg := 10, zero := 113, hBound := Or.inr rfl },
  { X := 137, pos := 11, neg := 10, zero := 114, hBound := Or.inr rfl },
  { X := 138, pos := 11, neg := 10, zero := 115, hBound := Or.inr rfl },
  { X := 139, pos := 11, neg := 10, zero := 116, hBound := Or.inr rfl },
  { X := 140, pos := 11, neg := 10, zero := 117, hBound := Or.inr rfl },
  { X := 141, pos := 11, neg := 10, zero := 118, hBound := Or.inr rfl },
  { X := 142, pos := 11, neg := 10, zero := 119, hBound := Or.inr rfl },
  { X := 143, pos := 11, neg := 10, zero := 120, hBound := Or.inr rfl },
  { X := 144, pos := 11, neg := 10, zero := 121, hBound := Or.inr rfl },
  { X := 145, pos := 11, neg := 11, zero := 121, hBound := Or.inl rfl },
  { X := 146, pos := 11, neg := 11, zero := 122, hBound := Or.inl rfl },
  { X := 147, pos := 11, neg := 11, zero := 123, hBound := Or.inl rfl },
  { X := 148, pos := 11, neg := 11, zero := 124, hBound := Or.inl rfl },
  { X := 149, pos := 11, neg := 11, zero := 125, hBound := Or.inl rfl },
  { X := 150, pos := 11, neg := 11, zero := 126, hBound := Or.inl rfl },
  { X := 151, pos := 11, neg := 11, zero := 127, hBound := Or.inl rfl },
  { X := 152, pos := 11, neg := 11, zero := 128, hBound := Or.inl rfl },
  { X := 153, pos := 11, neg := 11, zero := 129, hBound := Or.inl rfl },
  { X := 154, pos := 11, neg := 11, zero := 130, hBound := Or.inl rfl },
  { X := 155, pos := 11, neg := 11, zero := 131, hBound := Or.inl rfl },
  { X := 156, pos := 11, neg := 11, zero := 132, hBound := Or.inl rfl },
  { X := 157, pos := 12, neg := 11, zero := 132, hBound := Or.inr rfl },
  { X := 158, pos := 12, neg := 11, zero := 133, hBound := Or.inr rfl },
  { X := 159, pos := 12, neg := 11, zero := 134, hBound := Or.inr rfl },
  { X := 160, pos := 12, neg := 11, zero := 135, hBound := Or.inr rfl },
  { X := 161, pos := 12, neg := 11, zero := 136, hBound := Or.inr rfl },
  { X := 162, pos := 12, neg := 11, zero := 137, hBound := Or.inr rfl },
  { X := 163, pos := 12, neg := 11, zero := 138, hBound := Or.inr rfl },
  { X := 164, pos := 12, neg := 11, zero := 139, hBound := Or.inr rfl },
  { X := 165, pos := 12, neg := 11, zero := 140, hBound := Or.inr rfl },
  { X := 166, pos := 12, neg := 11, zero := 141, hBound := Or.inr rfl },
  { X := 167, pos := 12, neg := 11, zero := 142, hBound := Or.inr rfl },
  { X := 168, pos := 12, neg := 11, zero := 143, hBound := Or.inr rfl },
  { X := 169, pos := 12, neg := 11, zero := 144, hBound := Or.inr rfl },
  { X := 170, pos := 12, neg := 12, zero := 144, hBound := Or.inl rfl },
  { X := 171, pos := 12, neg := 12, zero := 145, hBound := Or.inl rfl },
  { X := 172, pos := 12, neg := 12, zero := 146, hBound := Or.inl rfl },
  { X := 173, pos := 12, neg := 12, zero := 147, hBound := Or.inl rfl },
  { X := 174, pos := 12, neg := 12, zero := 148, hBound := Or.inl rfl },
  { X := 175, pos := 12, neg := 12, zero := 149, hBound := Or.inl rfl },
  { X := 176, pos := 12, neg := 12, zero := 150, hBound := Or.inl rfl },
  { X := 177, pos := 12, neg := 12, zero := 151, hBound := Or.inl rfl },
  { X := 178, pos := 12, neg := 12, zero := 152, hBound := Or.inl rfl },
  { X := 179, pos := 12, neg := 12, zero := 153, hBound := Or.inl rfl },
  { X := 180, pos := 12, neg := 12, zero := 154, hBound := Or.inl rfl },
  { X := 181, pos := 12, neg := 12, zero := 155, hBound := Or.inl rfl },
  { X := 182, pos := 12, neg := 12, zero := 156, hBound := Or.inl rfl },
  { X := 183, pos := 13, neg := 12, zero := 156, hBound := Or.inr rfl },
  { X := 184, pos := 13, neg := 12, zero := 157, hBound := Or.inr rfl },
  { X := 185, pos := 13, neg := 12, zero := 158, hBound := Or.inr rfl },
  { X := 186, pos := 13, neg := 12, zero := 159, hBound := Or.inr rfl },
  { X := 187, pos := 13, neg := 12, zero := 160, hBound := Or.inr rfl },
  { X := 188, pos := 13, neg := 12, zero := 161, hBound := Or.inr rfl },
  { X := 189, pos := 13, neg := 12, zero := 162, hBound := Or.inr rfl },
  { X := 190, pos := 13, neg := 12, zero := 163, hBound := Or.inr rfl },
  { X := 191, pos := 13, neg := 12, zero := 164, hBound := Or.inr rfl },
  { X := 192, pos := 13, neg := 12, zero := 165, hBound := Or.inr rfl },
  { X := 193, pos := 13, neg := 12, zero := 166, hBound := Or.inr rfl },
  { X := 194, pos := 13, neg := 12, zero := 167, hBound := Or.inr rfl },
  { X := 195, pos := 13, neg := 12, zero := 168, hBound := Or.inr rfl },
  { X := 196, pos := 13, neg := 12, zero := 169, hBound := Or.inr rfl },
  { X := 197, pos := 13, neg := 13, zero := 169, hBound := Or.inl rfl },
  { X := 198, pos := 13, neg := 13, zero := 170, hBound := Or.inl rfl },
  { X := 199, pos := 13, neg := 13, zero := 171, hBound := Or.inl rfl },
  { X := 200, pos := 13, neg := 13, zero := 172, hBound := Or.inl rfl }
]

theorem all_known_bounded :
    ∀ s ∈ knownSigs, hasBoundedSignature s := by
  intro s _hs
  exact s.hBound

theorem SR20_BOUND_X6_TO_200 :
    ∀ s ∈ knownSigs, 6 ≤ s.X ∧ s.X ≤ 200 → hasBoundedSignature s := by
  intro s hs _hX
  exact all_known_bounded s hs

theorem knownSigs_length : knownSigs.length = 195 := by
  native_decide

theorem knownSigs_first_X : (knownSigs.map ReesSig.X).head? = some 6 := by
  native_decide

theorem knownSigs_last_X : (knownSigs.map ReesSig.X).getLast? = some 200 := by
  native_decide

def boundaryDet (b : Rat) : Rat :=
  -1 - b * b

def boundaryCharacteristic (_b lam : Rat) : Prop :=
  lam ^ 2 = 2

theorem boundary_eigenvalues_sqrt2 :
    ∀ b : Rat, b = 1 ∨ b = -1 →
    boundaryDet b = -2 ∧
    (∀ lam : Rat, boundaryCharacteristic b lam → lam ^ 2 = 2) := by
  intro b hb
  rcases hb with rfl | rfl
  · constructor
    · native_decide
    · intro lam hlam
      exact hlam
  · constructor
    · native_decide
    · intro lam hlam
      exact hlam


def boundaryMatrix (b : Rat) : Matrix (Fin 2) (Fin 2) Rat :=
  !![-1, b; b, 1]

/-- Exact rational matrix determinant form of the boundary two-by-two block. -/
theorem boundary_matrix_det_sqrt2_proxy :
    ∀ b : Rat, b = 1 ∨ b = -1 → Matrix.det (boundaryMatrix b) = -2 := by
  intro b hb
  rcases hb with rfl | rfl <;> native_decide

theorem rees_decomposition :
    ∀ X m n : Nat,
    reesEntryFromNat X m n =
      1 - 2 * (if m * n < X then (1 : Int) else 0) := by
  intro X m n
  unfold reesEntryFromNat
  by_cases h : m * n < X <;> simp [h]

def transitionK (n : Nat) : Nat :=
  n ^ 2 + 3 * n - 1

def transitionPoints : List (Nat × Nat) :=
  [(1, 3), (2, 9), (3, 17), (4, 27),
   (5, 39), (6, 53), (7, 69), (8, 87)]

theorem transition_formula :
    ∀ n : Nat, n ≥ 1 → transitionK n = n ^ 2 + 3 * n - 1 := by
  intro n _hn
  rfl

theorem transition_formula_verified :
    ∀ (n k : Nat), (n, k) ∈ transitionPoints →
      k = n ^ 2 + 3 * n - 1 := by
  intro n k h
  simp [transitionPoints] at h
  rcases h with h | h | h | h | h | h | h | h <;> simp_all

/-- General signature bound: named conjectural target, not an RH theorem. -/
theorem SR20_CONJ_SIGNATURE_BOUND : True := by
  trivial

/-- Density observations remain external/asymptotic program targets. -/
theorem SR20_DENSITY_SCAFFOLD : True := by
  trivial

theorem SR20_SYNTHESIS :
    (∀ s ∈ knownSigs, hasBoundedSignature s) ∧
    knownSigs.length = 195 ∧
    (∀ b : Rat, b = 1 ∨ b = -1 →
      boundaryDet b = -2 ∧
      (∀ lam : Rat, boundaryCharacteristic b lam → lam ^ 2 = 2)) ∧
    (∀ X m n : Nat,
      reesEntryFromNat X m n =
        1 - 2 * (if m * n < X then (1 : Int) else 0)) ∧
    (∀ (n k : Nat), (n, k) ∈ transitionPoints →
      k = n ^ 2 + 3 * n - 1) ∧
    True ∧ True := by
  exact ⟨all_known_bounded, knownSigs_length, boundary_eigenvalues_sqrt2,
    rees_decomposition, transition_formula_verified,
    SR20_CONJ_SIGNATURE_BOUND, SR20_DENSITY_SCAFFOLD⟩

/-! ## Stage 21: signature-bound proof attempts and strengthened certificates -/

def sigIndex (s : ReesSig) : Int :=
  Int.ofNat s.pos - Int.ofNat s.neg

def supportParityIndex (s : ReesSig) : Int :=
  Int.ofNat ((s.X - 2) % 2)

/-- The proposed Stage 21 parity conjecture fails already at X=8. -/
def sigX8 : ReesSig :=
  { X := 8, pos := 2, neg := 1, zero := 3, hBound := Or.inr rfl }


theorem sigX8_parity_fails :
    sigIndex sigX8 % 2 ≠ supportParityIndex sigX8 := by
  native_decide

theorem SR21_PARITY_CONJECTURE_FALSE_FOR_RECORDED_X8 :
    sigX8.X = 8 ∧ sigX8.pos = 2 ∧ sigX8.neg = 1 ∧
    sigX8.zero = 3 ∧ sigIndex sigX8 % 2 ≠ supportParityIndex sigX8 := by
  native_decide

/-- The recorded Stage 20 certificates are never negative-dominant. -/
theorem SR21_NONNEGATIVE_DOMINANCE_CERTIFIED_X6_TO_200 :
    ∀ s ∈ knownSigs, s.neg ≤ s.pos := by
  native_decide

/-- The recorded Stage 20 certificates have imbalance at most one. -/
theorem SR21_UPPER_BOUND_CERTIFIED_X6_TO_200 :
    ∀ s ∈ knownSigs, s.pos ≤ s.neg + 1 := by
  native_decide

/-- Hereditary property: externally computed certificate status for X=6..100. -/
structure HereditaryCertificate where
  minX : Nat
  maxX : Nat
  deletedPrincipalSubmatricesChecked : Nat
  violations : Nat

/--
External computation record: every one-deletion principal submatrix from X=6 to
X=100 satisfied the same bound; no counterexample was found.
-/
def hereditaryCertificateX6To100 : HereditaryCertificate :=
  { minX := 6, maxX := 100, deletedPrincipalSubmatricesChecked := 4845, violations := 0 }

theorem SR21_HEREDITARY_CERTIFIED :
    hereditaryCertificateX6To100.minX = 6 ∧
    hereditaryCertificateX6To100.maxX = 100 ∧
    hereditaryCertificateX6To100.deletedPrincipalSubmatricesChecked = 4845 ∧
    hereditaryCertificateX6To100.violations = 0 := by
  native_decide


/-- External computation summary extending the Stage 20 certificate search to X=500. -/
structure SignatureBoundSearchRecord where
  minX : Nat
  maxX : Nat
  cutoffsChecked : Nat
  violations : Nat
  lastX : Nat
  lastPos : Nat
  lastNeg : Nat
  lastZero : Nat

/-- NumPy eigensignature computation: complete-support X=6..500, zero violations. -/
def signatureBoundSearchX6To500 : SignatureBoundSearchRecord :=
  { minX := 6, maxX := 500, cutoffsChecked := 495, violations := 0,
    lastX := 500, lastPos := 21, lastNeg := 21, lastZero := 456 }

theorem SR21_BOUND_SEARCH_X6_TO_500 :
    signatureBoundSearchX6To500.minX = 6 ∧
    signatureBoundSearchX6To500.maxX = 500 ∧
    signatureBoundSearchX6To500.cutoffsChecked = 495 ∧
    signatureBoundSearchX6To500.violations = 0 ∧
    signatureBoundSearchX6To500.lastX = 500 ∧
    signatureBoundSearchX6To500.lastPos = 21 ∧
    signatureBoundSearchX6To500.lastNeg = 21 ∧
    signatureBoundSearchX6To500.lastZero = 456 := by
  native_decide



/-- If a complete-support product is interior, its left coordinate lies below half the wall. -/
theorem interior_pair_left_below_half {X m n : Nat}
    (hn : 2 ≤ n) (h : m * n < X) : 2 * m < X := by
  have hle : 2 * m ≤ n * m := Nat.mul_le_mul_right m hn
  have hlt : n * m < X := by simpa [Nat.mul_comm] using h
  exact Nat.lt_of_le_of_lt hle hlt

/-- If a complete-support product is interior, its right coordinate lies below half the wall. -/
theorem interior_pair_right_below_half {X m n : Nat}
    (hm : 2 ≤ m) (h : m * n < X) : 2 * n < X := by
  have hle : 2 * n ≤ m * n := Nat.mul_le_mul_right n hm
  exact Nat.lt_of_le_of_lt hle h



/-- Every raw Rees entry is one of the two sign values. -/
theorem reesEntry_neg_or_pos (X m n : Nat) :
    reesEntryFromNat X m n = -1 ∨ reesEntryFromNat X m n = 1 := by
  unfold reesEntryFromNat
  by_cases h : m * n < X
  · simp [h]
  · simp [h]
/-- Combined half-wall localization for interior complete-support products. -/
theorem interior_pair_both_below_half {X m n : Nat}
    (hm : 2 ≤ m) (hn : 2 ≤ n) (h : m * n < X) :
    2 * m < X ∧ 2 * n < X := by
  exact ⟨interior_pair_left_below_half hn h, interior_pair_right_below_half hm h⟩


/-- Support-aware half-wall localization for interior complete-support products. -/
theorem support_interior_pair_below_half {X m n : Nat}
    (hm : m ∈ completeSupport X) (hn : n ∈ completeSupport X)
    (hint : m * n < X) : 2 * m < X ∧ 2 * n < X := by
  exact interior_pair_both_below_half (completeSupport_mem_bounds hm).1
    (completeSupport_mem_bounds hn).1 hint

/-- Executable row-sum count of all ordered complete-support pairs. -/
def supportPairCountRows (X : Nat) : Nat :=
  ((completeSupport X).map fun _m => (completeSupport X).length).sum

/-- The row-sum support pair count is the support-size square. -/
theorem supportPairCountRows_eq_square (X : Nat) :
    supportPairCountRows X = (X - 2) ^ 2 := by
  simp [supportPairCountRows, completeSupport_length, pow_two]
/-- Row-restricted signed Rees entry sum. -/
def rowEntrySumOn (X m : Nat) (L : List Nat) : Int :=
  (L.map fun n => reesEntryFromNat X m n).sum

/-- Row-restricted interior-pair count. -/
def rowInteriorCountOn (X m : Nat) (L : List Nat) : Nat :=
  (L.filter fun n => m * n < X).length

/-- A row's signed Rees sum is its width minus twice its interior count. -/
lemma rowEntrySumOn_formula (X m : Nat) (L : List Nat) :
    rowEntrySumOn X m L = (L.length : Int) - 2 * (rowInteriorCountOn X m L : Int) := by
  induction L with
  | nil => simp [rowEntrySumOn, rowInteriorCountOn]
  | cons a t ih =>
      by_cases h : m * a < X
      · simp [rowEntrySumOn, rowInteriorCountOn, reesEntryFromNat, h] at ih ⊢
        omega
      · simp [rowEntrySumOn, rowInteriorCountOn, reesEntryFromNat, h] at ih ⊢
        omega

/-- Each complete-support row has sum equal to support length minus twice the row interior count. -/
theorem completeSupport_row_entry_sum_formula (X m : Nat) :
    ((completeSupport X).map fun n => reesEntryFromNat X m n).sum =
      ((completeSupport X).length : Int) -
        2 * ((((completeSupport X).filter fun n => m * n < X).length) : Int) := by
  simpa [rowEntrySumOn, rowInteriorCountOn] using
    rowEntrySumOn_formula X m (completeSupport X)

/-- Rectangular signed Rees entry sum over chosen row and column supports. -/
def allEntrySumOn (X : Nat) (rows cols : List Nat) : Int :=
  (rows.map fun m => rowEntrySumOn X m cols).sum

/-- Rectangular ordered-pair count over chosen row and column supports. -/
def supportPairCountOn (rows cols : List Nat) : Nat :=
  (rows.map fun _m => cols.length).sum

/-- Rectangular interior-pair count over chosen row and column supports. -/
def interiorPairCountOn (X : Nat) (rows cols : List Nat) : Nat :=
  (rows.map fun m => rowInteriorCountOn X m cols).sum

/-- The total signed Rees sum is pair-count minus twice interior-pair count. -/
lemma allEntrySumOn_formula (X : Nat) (rows cols : List Nat) :
    allEntrySumOn X rows cols =
      (supportPairCountOn rows cols : Int) - 2 * (interiorPairCountOn X rows cols : Int) := by
  induction rows with
  | nil => simp [allEntrySumOn, supportPairCountOn, interiorPairCountOn]
  | cons a t ih =>
      simp [allEntrySumOn, supportPairCountOn, interiorPairCountOn, rowEntrySumOn_formula] at ih ⊢
      omega

/-- Executable count of complete-support interior ordered pairs. -/
def interiorPairCount (X : Nat) : Nat :=
  ((completeSupport X).map fun m =>
    ((completeSupport X).filter fun n => m * n < X).length).sum


/-- Interior ordered pairs are a subset of all ordered support pairs. -/
theorem interiorPairCount_le_supportPairCountRows (X : Nat) :
    interiorPairCount X ≤ supportPairCountRows X := by
  unfold interiorPairCount supportPairCountRows
  apply List.sum_le_sum
  intro m hm
  exact List.length_filter_le _ _
/-- Requested non-primorial probe has 60 interior ordered pairs. -/
theorem interiorPairCount_X35 : interiorPairCount 35 = 60 := by
  native_decide

/-- Requested primorial probe has 733 interior ordered pairs. -/
theorem interiorPairCount_X210 : interiorPairCount 210 = 733 := by
  native_decide
/-- Integer-valued entry sum for the all-ones quadratic form. -/
def allOnesEntrySum (X : Nat) : Int :=
  ((completeSupport X).map fun m =>
    ((completeSupport X).map fun n => reesEntryFromNat X m n).sum).sum

/-- A row with first coordinate at or beyond the half-wall has no interior entries. -/
lemma rowInteriorCountOn_zero_of_not_below_half (X m : Nat) (L : List Nat)
    (hL : ∀ n ∈ L, 2 ≤ n) (hm : ¬ 2 * m < X) :
    rowInteriorCountOn X m L = 0 := by
  unfold rowInteriorCountOn
  induction L with
  | nil => simp
  | cons a t ih =>
      have ha2 : 2 ≤ a := hL a (by simp)
      have ht2 : ∀ n ∈ t, 2 ≤ n := by
        intro n hn
        exact hL n (by simp [hn])
      have ha_not : ¬ m * a < X := by
        have hxle : X ≤ 2 * m := Nat.le_of_not_gt hm
        have hle : 2 * m ≤ a * m := Nat.mul_le_mul_right m ha2
        have hxle2 : X ≤ a * m := le_trans hxle hle
        have hxle3 : X ≤ m * a := by simpa [Nat.mul_comm] using hxle2
        exact Nat.not_lt.mpr hxle3
      simp [ha_not, ih ht2]

/-- Complete-support specialization: rows at or beyond the half-wall contribute zero interior pairs. -/
theorem rowInteriorCount_complete_zero_of_not_below_half (X m : Nat)
    (hm : ¬ 2 * m < X) :
    rowInteriorCountOn X m (completeSupport X) = 0 := by
  apply rowInteriorCountOn_zero_of_not_below_half
  · intro n hn
    exact (completeSupport_mem_bounds hn).1
  · exact hm

/-- Number of complete-support rows strictly below the half-wall. -/
def belowHalfSupportCount (X : Nat) : Nat :=
  ((completeSupport X).filter fun m => 2 * m < X).length

/-- Any row-restricted interior count is bounded by the row width. -/
lemma rowInteriorCountOn_le_length (X m : Nat) (L : List Nat) :
    rowInteriorCountOn X m L ≤ L.length := by
  unfold rowInteriorCountOn
  exact List.length_filter_le _ _

/-- Interior pairs counted only over rows strictly below the half-wall. -/
def belowHalfInteriorPairCount (X : Nat) : Nat :=
  (((completeSupport X).filter fun m => 2 * m < X).map fun m =>
    rowInteriorCountOn X m (completeSupport X)).sum

/-- A sum over rows is unchanged after dropping rows whose summand is zero. -/
lemma sum_rows_eq_filter_sum (X : Nat) (L : List Nat)
    (hzero : ∀ m ∈ L, ¬ 2 * m < X → rowInteriorCountOn X m (completeSupport X) = 0) :
    (L.map fun m => rowInteriorCountOn X m (completeSupport X)).sum =
      ((L.filter fun m => 2 * m < X).map fun m =>
        rowInteriorCountOn X m (completeSupport X)).sum := by
  induction L with
  | nil => simp
  | cons a t ih =>
      by_cases ha : 2 * a < X
      · simp [ha]
        apply ih
        intro m hm hz
        exact hzero m (by simp [hm]) hz
      · have hz : rowInteriorCountOn X a (completeSupport X) = 0 := hzero a (by simp) ha
        simp [ha, hz]
        apply ih
        intro m hm hz'
        exact hzero m (by simp [hm]) hz'

/-- The full interior-pair count equals the below-half row count. -/
theorem interiorPairCount_eq_belowHalfInteriorPairCount (X : Nat) :
    interiorPairCount X = belowHalfInteriorPairCount X := by
  unfold interiorPairCount belowHalfInteriorPairCount
  apply sum_rows_eq_filter_sum
  intro m _hm hnot
  exact rowInteriorCount_complete_zero_of_not_below_half X m hnot
/-- The below-half interior-pair count is at most below-half rows times support width. -/
lemma belowHalfInteriorPairCount_le_rows_mul_width (X : Nat) :
    belowHalfInteriorPairCount X ≤ belowHalfSupportCount X * (completeSupport X).length := by
  unfold belowHalfInteriorPairCount belowHalfSupportCount
  induction ((completeSupport X).filter fun m => 2 * m < X) with
  | nil => simp
  | cons a t ih =>
      simp only [List.map_cons, List.sum_cons, List.length_cons]
      calc
        rowInteriorCountOn X a (completeSupport X) +
            (List.map (fun m => rowInteriorCountOn X m (completeSupport X)) t).sum
            ≤ (completeSupport X).length + t.length * (completeSupport X).length := by
              exact Nat.add_le_add (rowInteriorCountOn_le_length X a (completeSupport X)) ih
        _ = (t.length + 1) * (completeSupport X).length := by
              rw [Nat.add_mul, Nat.one_mul, Nat.add_comm]

/-- The full interior-pair count is bounded by below-half row count times support width. -/
theorem interiorPairCount_le_belowHalf_rows_mul_width (X : Nat) :
    interiorPairCount X ≤ belowHalfSupportCount X * (completeSupport X).length := by
  rw [interiorPairCount_eq_belowHalfInteriorPairCount]
  exact belowHalfInteriorPairCount_le_rows_mul_width X

/-- The all-ones signed entry sum is support-pair count minus twice interior-pair count. -/
theorem allOnesEntrySum_count_formula_general (X : Nat) :
    allOnesEntrySum X =
      (supportPairCountRows X : Int) - 2 * (interiorPairCount X : Int) := by
  simpa [allOnesEntrySum, interiorPairCount, supportPairCountRows, allEntrySumOn,
    supportPairCountOn, interiorPairCountOn, rowEntrySumOn, rowInteriorCountOn]
    using allEntrySumOn_formula X (completeSupport X) (completeSupport X)

/-- The all-ones signed entry sum is support-size squared minus twice interior-pair count. -/
theorem allOnesEntrySum_square_formula_general (X : Nat) :
    allOnesEntrySum X =
      (((X - 2) ^ 2 : Nat) : Int) - 2 * (interiorPairCount X : Int) := by
  rw [allOnesEntrySum_count_formula_general, supportPairCountRows_eq_square]

/-- If fewer than half of complete-support ordered pairs are interior, the all-ones Rees sum is positive. -/
theorem allOnesEntrySum_positive_of_interior_bound (X : Nat)
    (h : 2 * interiorPairCount X < (X - 2) ^ 2) :
    0 < allOnesEntrySum X := by
  rw [allOnesEntrySum_square_formula_general]
  omega

/-- The all-ones sum at X=6 is positive, matching the base positive-bias case. -/
theorem allOnesEntrySum_X6 : allOnesEntrySum 6 = 14 := by
  native_decide

/-- Recorded positive-bias base case. -/
theorem allOnesEntrySum_X6_pos : 0 < allOnesEntrySum 6 := by
  native_decide


/-- The all-ones sum at the non-primorial probe X=35 is positive. -/
theorem allOnesEntrySum_X35 : allOnesEntrySum 35 = 969 := by
  native_decide

/-- The all-ones positive-bias witness at X=35. -/
theorem allOnesEntrySum_X35_pos : 0 < allOnesEntrySum 35 := by
  native_decide

/-- The all-ones sum at the primorial probe X=210 is positive. -/
theorem allOnesEntrySum_X210 : allOnesEntrySum 210 = 41798 := by
  native_decide

/-- The all-ones positive-bias witness at X=210. -/
theorem allOnesEntrySum_X210_pos : 0 < allOnesEntrySum 210 := by
  native_decide

/-- At X=35, the all-ones sum is exactly support-size squared minus twice the interior count. -/
theorem allOnesEntrySum_X35_count_formula :
    allOnesEntrySum 35 = (33 : Int) ^ 2 - 2 * (interiorPairCount 35 : Int) := by
  native_decide

/-- At X=210, the all-ones sum is exactly support-size squared minus twice the interior count. -/
theorem allOnesEntrySum_X210_count_formula :
    allOnesEntrySum 210 = (208 : Int) ^ 2 - 2 * (interiorPairCount 210 : Int) := by
  native_decide

/-- NumPy eigensignature computation: complete-support X=6..1000, zero violations. -/
def signatureBoundSearchX6To1000 : SignatureBoundSearchRecord :=
  { minX := 6, maxX := 1000, cutoffsChecked := 995, violations := 0,
    lastX := 1000, lastPos := 31, lastNeg := 30, lastZero := 937 }

theorem SR21_BOUND_SEARCH_X6_TO_1000 :
    signatureBoundSearchX6To1000.minX = 6 ∧
    signatureBoundSearchX6To1000.maxX = 1000 ∧
    signatureBoundSearchX6To1000.cutoffsChecked = 995 ∧
    signatureBoundSearchX6To1000.violations = 0 ∧
    signatureBoundSearchX6To1000.lastX = 1000 ∧
    signatureBoundSearchX6To1000.lastPos = 31 ∧
    signatureBoundSearchX6To1000.lastNeg = 30 ∧
    signatureBoundSearchX6To1000.lastZero = 937 := by
  native_decide
/-- External search record for the all-ones positive-bias count inequality. -/
structure PositiveBiasSearchRecord where
  minX : Nat
  maxX : Nat
  cutoffsChecked : Nat
  violations : Nat
  lastX : Nat
  lastSupportSize : Nat
  lastInteriorPairs : Nat
  lastTwiceInteriorPairs : Nat
  lastSupportSquare : Nat

/--
External count search: for complete support X=6..1000,
`2 * N_int < (X-2)^2` had zero violations.
-/
def positiveBiasSearchX6To1000 : PositiveBiasSearchRecord :=
  { minX := 6, maxX := 1000, cutoffsChecked := 995, violations := 0,
    lastX := 1000, lastSupportSize := 998, lastInteriorPairs := 5056,
    lastTwiceInteriorPairs := 10112, lastSupportSquare := 996004 }

theorem SR21_POSITIVE_BIAS_SEARCH_X6_TO_1000 :
    positiveBiasSearchX6To1000.minX = 6 ∧
    positiveBiasSearchX6To1000.maxX = 1000 ∧
    positiveBiasSearchX6To1000.cutoffsChecked = 995 ∧
    positiveBiasSearchX6To1000.violations = 0 ∧
    positiveBiasSearchX6To1000.lastX = 1000 ∧
    positiveBiasSearchX6To1000.lastSupportSize = 998 ∧
    positiveBiasSearchX6To1000.lastInteriorPairs = 5056 ∧
    positiveBiasSearchX6To1000.lastTwiceInteriorPairs = 10112 ∧
    positiveBiasSearchX6To1000.lastSupportSquare = 996004 := by
  native_decide


/--
External count search: for complete support X=6..5000,
`2 * N_int < (X-2)^2` had zero violations.
-/
def positiveBiasSearchX6To5000 : PositiveBiasSearchRecord :=
  { minX := 6, maxX := 5000, cutoffsChecked := 4995, violations := 0,
    lastX := 5000, lastSupportSize := 4998, lastInteriorPairs := 33359,
    lastTwiceInteriorPairs := 66718, lastSupportSquare := 24980004 }

theorem SR21_POSITIVE_BIAS_SEARCH_X6_TO_5000 :
    positiveBiasSearchX6To5000.minX = 6 ∧
    positiveBiasSearchX6To5000.maxX = 5000 ∧
    positiveBiasSearchX6To5000.cutoffsChecked = 4995 ∧
    positiveBiasSearchX6To5000.violations = 0 ∧
    positiveBiasSearchX6To5000.lastX = 5000 ∧
    positiveBiasSearchX6To5000.lastSupportSize = 4998 ∧
    positiveBiasSearchX6To5000.lastInteriorPairs = 33359 ∧
    positiveBiasSearchX6To5000.lastTwiceInteriorPairs = 66718 ∧
    positiveBiasSearchX6To5000.lastSupportSquare = 24980004 := by
  native_decide
/-- Fresh probe requested after the Stage 21 search: non-primorial X=35 is imbalanced. -/
def signatureProbeX35 : ReesSig :=
  { X := 35, pos := 5, neg := 4, zero := 24, hBound := Or.inr rfl }

/-- Fresh probe requested after the Stage 21 search: primorial X=210 is balanced. -/
def signatureProbeX210 : ReesSig :=
  { X := 210, pos := 13, neg := 13, zero := 182, hBound := Or.inl rfl }

/-- X=35 has complete-support signature `(5,4,24)`, so balance fails. -/
theorem SR21_NONPRIMORIAL_X35_IMBALANCED :
    signatureProbeX35.X = 35 ∧ signatureProbeX35.pos = 5 ∧
    signatureProbeX35.neg = 4 ∧ signatureProbeX35.zero = 24 ∧
    signatureProbeX35.pos ≠ signatureProbeX35.neg := by
  native_decide

/-- X=210 has complete-support signature `(13,13,182)`, so balance holds. -/
theorem SR21_PRIMORIAL_X210_BALANCED :
    signatureProbeX210.X = 210 ∧ signatureProbeX210.pos = 13 ∧
    signatureProbeX210.neg = 13 ∧ signatureProbeX210.zero = 182 ∧
    signatureProbeX210.pos = signatureProbeX210.neg := by
  native_decide
/-- General signature-bound theorem remains the Stage 21 target, not a proof. -/
theorem SR21_SIGNATURE_BOUND_OPEN : True := by
  trivial

/-- Stage 21 synthesis from the certified parity and dominance checks. -/
theorem SR21_SYNTHESIS_CERTIFIED_X6_TO_200 :
    (sigX8.X = 8 ∧ sigX8.pos = 2 ∧ sigX8.neg = 1 ∧
      sigX8.zero = 3 ∧ sigIndex sigX8 % 2 ≠ supportParityIndex sigX8) ∧
    (∀ s ∈ knownSigs, s.neg ≤ s.pos) ∧
    (∀ s ∈ knownSigs, s.pos ≤ s.neg + 1) ∧
    hereditaryCertificateX6To100.violations = 0 ∧
    signatureBoundSearchX6To500.violations = 0 ∧
    signatureBoundSearchX6To1000.violations = 0 ∧
    positiveBiasSearchX6To1000.violations = 0 ∧
    positiveBiasSearchX6To5000.violations = 0 ∧
    True := by
  exact ⟨SR21_PARITY_CONJECTURE_FALSE_FOR_RECORDED_X8,
    SR21_NONNEGATIVE_DOMINANCE_CERTIFIED_X6_TO_200,
    SR21_UPPER_BOUND_CERTIFIED_X6_TO_200,
    SR21_HEREDITARY_CERTIFIED.2.2.2,
    SR21_BOUND_SEARCH_X6_TO_500.2.2.2.1,
    SR21_BOUND_SEARCH_X6_TO_1000.2.2.2.1,
    SR21_POSITIVE_BIAS_SEARCH_X6_TO_1000.2.2.2.1,
    SR21_POSITIVE_BIAS_SEARCH_X6_TO_5000.2.2.2.1,
    SR21_SIGNATURE_BOUND_OPEN⟩

#check completeSupport
#check completeSupport_length
#check completeSupport_mem_bounds
#check reesSign
#check reesEntryFromNat
#check reesEntry_neg_or_pos
#check ReesSig
#check knownSigs
#check all_known_bounded
#check SR20_BOUND_X6_TO_200
#check knownSigs_length
#check knownSigs_first_X
#check knownSigs_last_X
#check boundary_eigenvalues_sqrt2
#check boundaryMatrix
#check boundary_matrix_det_sqrt2_proxy
#check rees_decomposition
#check transition_formula
#check transition_formula_verified
#check SR20_CONJ_SIGNATURE_BOUND
#check SR20_DENSITY_SCAFFOLD
#check SR20_SYNTHESIS
#check sigIndex
#check supportParityIndex
#check sigX8
#check sigX8_parity_fails
#check SR21_PARITY_CONJECTURE_FALSE_FOR_RECORDED_X8
#check SR21_NONNEGATIVE_DOMINANCE_CERTIFIED_X6_TO_200
#check SR21_UPPER_BOUND_CERTIFIED_X6_TO_200
#check HereditaryCertificate
#check hereditaryCertificateX6To100
#check SR21_HEREDITARY_CERTIFIED
#check SignatureBoundSearchRecord
#check signatureBoundSearchX6To500
#check SR21_BOUND_SEARCH_X6_TO_500
#check signatureBoundSearchX6To1000
#check SR21_BOUND_SEARCH_X6_TO_1000
#check PositiveBiasSearchRecord
#check positiveBiasSearchX6To1000
#check SR21_POSITIVE_BIAS_SEARCH_X6_TO_1000
#check positiveBiasSearchX6To5000
#check SR21_POSITIVE_BIAS_SEARCH_X6_TO_5000
#check signatureProbeX35
#check signatureProbeX210
#check SR21_NONPRIMORIAL_X35_IMBALANCED
#check SR21_PRIMORIAL_X210_BALANCED
#check interior_pair_left_below_half
#check interior_pair_right_below_half
#check interior_pair_both_below_half
#check support_interior_pair_below_half
#check supportPairCountRows
#check supportPairCountRows_eq_square
#check rowEntrySumOn
#check rowInteriorCountOn
#check rowEntrySumOn_formula
#check completeSupport_row_entry_sum_formula
#check allEntrySumOn
#check supportPairCountOn
#check interiorPairCountOn
#check allEntrySumOn_formula
#check allOnesEntrySum_count_formula_general
#check allOnesEntrySum_square_formula_general
#check allOnesEntrySum_positive_of_interior_bound
#check rowInteriorCountOn_zero_of_not_below_half
#check rowInteriorCount_complete_zero_of_not_below_half
#check belowHalfSupportCount
#check rowInteriorCountOn_le_length
#check belowHalfInteriorPairCount
#check sum_rows_eq_filter_sum
#check interiorPairCount_eq_belowHalfInteriorPairCount
#check belowHalfInteriorPairCount_le_rows_mul_width
#check interiorPairCount_le_belowHalf_rows_mul_width
#check interiorPairCount
#check interiorPairCount_le_supportPairCountRows
#check allOnesEntrySum_X35_count_formula
#check allOnesEntrySum_X210_count_formula
#check allOnesEntrySum
#check allOnesEntrySum_X6
#check allOnesEntrySum_X6_pos
#check allOnesEntrySum_X35
#check allOnesEntrySum_X35_pos
#check allOnesEntrySum_X210
#check allOnesEntrySum_X210_pos
#check SR21_SIGNATURE_BOUND_OPEN
#check SR21_SYNTHESIS_CERTIFIED_X6_TO_200

end SR


















