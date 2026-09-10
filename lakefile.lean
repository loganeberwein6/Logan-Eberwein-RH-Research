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

lean_lib SR_Balance_Comparison where
  roots := #[`SR_Balance_Comparison]

lean_lib SR_Primorial where
  roots := #[`SR_Primorial]

lean_lib SR_SignatureBound where
  roots := #[`SR_SignatureBound]

lean_lib SR_UpperBound where
  roots := #[`SR_UpperBound]

lean_lib SR_Density where
  roots := #[`SR_Density]

lean_lib SR_SpectralBridge where
  roots := #[`SR_SpectralBridge]

lean_lib SR_Boundary where
  roots := #[`SR_Boundary]

lean_lib SR_Mollifier where
  roots := #[`SR_Mollifier]

lean_lib SR_Bridge where
  roots := #[`SR_Bridge]

lean_lib SR_Stage27 where
  roots := #[`SR_Stage27]

lean_lib SR_Stage28 where
  roots := #[`SR_Stage28]

lean_lib SR_WeilForm where
  roots := #[`SR_WeilForm]

lean_lib SR_WEntropy where
  roots := #[`SR_WEntropy]

lean_lib SR_Stage29 where
  roots := #[`SR_Stage29]

lean_lib SR_Stage30_Bound where
  roots := #[`SR_Stage30_Bound]

lean_lib SR_Stage30 where
  roots := #[`SR_Stage30]

lean_lib SR_Stage31 where
  roots := #[`SR_Stage31]

lean_lib SR_Stage33 where
  roots := #[`SR_Stage33]

lean_lib SR_Stage34 where
  roots := #[`SR_Stage34]

lean_lib SR_Stage35 where
  roots := #[`SR_Stage35]
