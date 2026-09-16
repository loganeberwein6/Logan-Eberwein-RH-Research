# Cycle 46: diagonal row/column identification obstruction

## Test

For the quotient core with canonical representatives `r_q`, the matrix is

`R[q,q']=-1` iff `r_q' <= q`, otherwise `+1`.

Unlike the abstract threshold matrix, `R` is already symmetric in the tested
ordering because the representative/threshold relation is nested. Therefore a
diagonal symmetrizer cannot change its sign pattern; it only rescales entries.

The diagonal entries are mixed: `R[q,q]=+1` whenever `r_q>q`, and `-1`
whenever `r_q<=q`. The resulting symmetric matrices have both positive and
negative eigenvalues:

```text
X=6:   eigenvalue range [-1.4142, 1.4142]
X=10:  [-2.6131, 2.6131]
X=20:  [-3.8637, 3.8637]
X=50:  [-7.6613, 7.6613]
X=100: [-10.8380,10.8380]
```

## Exact obstruction

For any real nonzero diagonal `D`, the diagonal of `D R D` is
`d_q^2 R[q,q]`. Hence mixed diagonal signs survive every real diagonal
congruence. In particular, no diagonal row/column identification can turn
this quotient core into a negative-definite SR form.

## Consequence

The missing arithmetic identification cannot be a scalar weight or diagonal
normalization. It must be a genuinely nonlocal basis transformation, or the
coercive form must be defined on a different space than the quotient core.

## Verdict

**Diagonal identification is ruled out.** This closes the simplest weighted
quotient repair and further narrows the remaining class to nonlocal arithmetic
intertwiners or a separate Weil test-function space.
