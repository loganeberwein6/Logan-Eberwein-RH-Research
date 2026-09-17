# Cycle 47: Sylvester-inertia obstruction for all quotient basis changes

## Strengthening Cycle 46

The canonical quotient core `R_X` is real symmetric. Its inertia is:

```text
X=6:   (positive, negative, zero) = (1,1,0)
X=10:  (2,2,0)
X=20:  (3,3,0)
X=50:  (6,6,0)
X=100: (9,8,0)
```

For any real invertible change of basis `P`, the congruent form

`P^T R_X P`

has exactly the same inertia by Sylvester's law. Therefore no nonlocal real
congruence—not merely a diagonal weighting—can turn `R_X` into a negative
definite SR threshold form.

## Scope

This rules out all attempts that preserve the quadratic-form interpretation by
changing coordinates. It does not rule out:

1. changing the underlying bilinear form rather than applying congruence;
2. using a non-self-adjoint determinant operator with a separate Weil form;
3. enlarging the space and imposing a different indefinite metric;
4. constructing a new arithmetic operator not equivalent to the quotient core.

## Consequence

The SR coercivity cannot be recovered from the quotient core by any ordinary
row/column basis identification. It must arise from a genuinely different
operator or from an external test-function-space form, as in the Weil
criterion.

## Verdict

**Proved class-level obstruction.** All real congruence-based quotient repairs
are eliminated by inertia, not just the tested representative and diagonal
choices.
