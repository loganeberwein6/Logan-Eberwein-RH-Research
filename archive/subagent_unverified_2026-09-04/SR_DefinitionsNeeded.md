# SR Definitions Needed

## Stage 0

- Added `IsPrimeNat` locally because `Nat.Prime` was unavailable in the current Lean-core project.

## Stage 1 Watchpoint

- The written Stage 0 requirement says `P_X = {p prime | p < X}`, but the Stage 1 frozen carrier at `X = 6` uses indices `{2,3,4,5}`, including `4`. Stage 1 must resolve whether the ordered carrier basis is indexed by `PrimeSet 6` or by a separate raw support set below the wall.
