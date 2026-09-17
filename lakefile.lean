import Lake
open Lake DSL

require mathlib from git
  "https://github.com/leanprover-community/mathlib4.git" @ "v4.29.1"

package «CodexRH» where
  -- Foundation library for the Selberg-Rees arithmetic Hodge program.

lean_lib SR_Stage38 where
  roots := #[`core.SR_Stage38]

lean_lib SR_WeilForm where
  roots := #[`weil.SR_WeilForm]

lean_lib SR_Dagger where
  roots := #[`spectral.SR_Dagger]

lean_lib SR_GNS where
  roots := #[`spectral.SR_GNS]

lean_lib SR_ZeroTransfer where
  roots := #[`spectral.SR_ZeroTransfer]

lean_lib RH_Summary where
  roots := #[`ledger.RH_Summary]

lean_lib RH_Operator_Criteria where
  roots := #[`ledger.RH_Operator_Criteria]
