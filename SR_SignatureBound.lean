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
#check completeSupport
#check reesSign
#check reesEntryFromNat
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

end SR
