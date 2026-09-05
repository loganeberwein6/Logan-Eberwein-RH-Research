# SR Failure Ledger

## Stage 0

### Attempt 1 - Syntax / missing object

Target: `lake build SR_Primitives`

Raw error excerpt:

```text
error: SR_Primitives.lean:14:34: unexpected token '}'; expected '=>'
error: SR_Primitives.lean:13:25: Function expected at
  Set
but this term has type
  ?m.1

Hint: The identifier `Set` is unknown, and Lean's `autoImplicit` option causes an unknown identifier to be treated as an implicitly bound variable with an unknown type.
```

Resolution: represent the prime set as the predicate `Nat → Prop`, avoiding the unavailable `Set` notation in the minimal Lean-core Stage 0 project.

### Attempt 2 - Missing Lean object

Target: `lake build SR_Primitives`

Raw error excerpt:

```text
error: SR_Primitives.lean:14:11: Unknown constant `Nat.Prime`
```

Resolution: add local predicate `IsPrimeNat` and define `PrimeSet` in terms of it.

## Stage 1

### Attempt 1 - Tactic syntax failure

Target: `lake build SR_Carrier`

Raw error excerpt:

```text
error: SR_Carrier.lean:66:2: Tactic `decide` proved that the proposition
  False
is false
error: SR_Carrier.lean:66:9: unexpected token 'at'; expected command
```

Resolution attempt: reduce the equality at the separating coordinate by
`simp [q, PrimeIndex6.ofNat?, basisValue]`.

## Stage 2

### Attempt 1 - Notation syntax failure during warning cleanup

Target: `lake build SR_Multiplication`

Raw error excerpt:

```text
error: SR_Multiplication.lean:6:20: unexpected token '_'; expected '=>'
error: SR_Multiplication.lean:14:20: unexpected token 'ℂ'; expected ':=', 'where' or '|'
error: SR_Multiplication.lean:18:18: unexpected token 'ℂ'; expected ')'
```

Resolution attempt: restore the notation binder form accepted by Lean
4.29.1, tolerating the harmless unused-notation-parameter warning.

## Stage 3

### Attempt 1 - Tactic failed after finite split

Target: `lake build SR_Dagger`

Raw error excerpt:

```text
error: SR_Dagger.lean:35:37: `simp` made no progress
warning: SR_Dagger.lean:35:43: This simp argument is unused:
  basisValue
```

Resolution attempt: after splitting the optional label and the finite ordered
coordinate cases, close the diagonal fixed proof by definitional equality.
