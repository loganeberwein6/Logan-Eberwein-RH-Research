import Lake
open Lake DSL

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
