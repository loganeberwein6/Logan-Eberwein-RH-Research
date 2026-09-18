import Lake
open Lake DSL

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "5e932f97dd25535344f80f9dd8da3aab83df0fe6"

package «CodexRH» where
  -- Foundation library for the Selberg-Rees arithmetic Hodge program.

lean_lib SR_Primitives where
  roots := #[`lean.core.SR_Primitives]

lean_lib SR_Mollifier where
  roots := #[`lean.weil.SR_Mollifier]

lean_lib SR_Bridge where
  roots := #[`lean.weil.SR_Bridge]

lean_lib SR_SignatureBound where
  roots := #[`lean.weil.SR_SignatureBound]

lean_lib SR_Carrier where
  roots := #[`lean.spectral.SR_Carrier]

lean_lib SR_Stage30_Bound where
  roots := #[`lean.core.SR_Stage30_Bound]

lean_lib SR_Stage30 where
  roots := #[`lean.core.SR_Stage30]

lean_lib SR_WEntropy where
  roots := #[`lean.core.SR_WEntropy]

lean_lib SR_Stage31 where
  roots := #[`lean.core.SR_Stage31]

lean_lib SR_Stage38 where
  roots := #[`lean.core.SR_Stage38]

lean_lib SR_WeilForm where
  roots := #[`lean.weil.SR_WeilForm]

lean_lib SR_Dagger where
  roots := #[`lean.spectral.SR_Dagger]

lean_lib SR_GNS where
  roots := #[`lean.spectral.SR_GNS]

lean_lib SR_ZeroTransfer where
  roots := #[`lean.spectral.SR_ZeroTransfer]

lean_lib RH_Summary where
  roots := #[`lean.ledger.RH_Summary]

lean_lib RH_Operator_Criteria where
  roots := #[`lean.ledger.RH_Operator_Criteria]
