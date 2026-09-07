import Lake
open Lake DSL

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.29.1"

package «CodexRH» where
  -- Foundation library for the Selberg-Rees arithmetic Hodge program.

lean_lib SR_Primitives where
  roots := #[`SR_Primitives]

lean_lib SR_KnowledgeBank where
  roots := #[`SR_KnowledgeBank]

lean_lib SR_Carrier where
  roots := #[`SR_Carrier]

lean_lib SR_Multiplication where
  roots := #[`SR_Multiplication]

lean_lib SR_Dagger where
  roots := #[`SR_Dagger]

lean_lib SR_NoCommutativity where
  roots := #[`SR_NoCommutativity]

lean_lib SR_Rees where
  roots := #[`SR_Rees]

lean_lib SR_GNS where
  roots := #[`SR_GNS]

lean_lib SR_Underdetermination where
  roots := #[`SR_Underdetermination]

lean_lib SR_Stage8 where
  roots := #[`SR_Stage8]

lean_lib SR_Valuation where
  roots := #[`SR_Valuation]

lean_lib SR_Stage9 where
  roots := #[`SR_Stage9]

lean_lib SR_PoincareDuality where
  roots := #[`SR_PoincareDuality]

lean_lib SR_LefschetzDiagnosis where
  roots := #[`SR_LefschetzDiagnosis]

lean_lib SR_Lefschetz where
  roots := #[`SR_Lefschetz]

lean_lib SR_HermitianForm where
  roots := #[`SR_HermitianForm]

lean_lib SR_ISR where
  roots := #[`SR_ISR]

lean_lib SR_ISR_Full where
  roots := #[`SR_ISR_Full]

lean_lib SR_Signature where
  roots := #[`SR_Signature]

lean_lib SR_Flow where
  roots := #[`SR_Flow]

lean_lib SR_Balance where
  roots := #[`SR_Balance]
