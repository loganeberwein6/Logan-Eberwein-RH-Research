# Cycle 20: Burnol--explicit-formula Rees--Lambda Gram candidate

## Definition tested

For `2 <= m,n < X`, define

`T_X(m,n) = Rees_X(m,n) Lambda(m) Lambda(n) / (psi(X) sqrt(m n))`,

where `psi(X) = sum_{k<X} Lambda(k)`. This is the requested Rees-weighted
von Mangoldt Gram candidate.

## Raw finite diagnostics

```text
X=20:  psi=19.2656583145  det(I-T)=0.8586667928
       min=-0.08102969     max=0.18171876
X=50:  psi=49.4853807924  det(I-T)=0.9294255307
       min=-0.05771383     max=0.11628192
X=100: psi=94.0453112294  det(I-T)=0.9402377059
       min=-0.04199137     max=0.08320204
```

Absolute eigenvalues decrease numerically, but the matrix remains indefinite
at every tested cutoff. The determinant trends toward one in this normalization,
not toward a function with visible zeta-zero structure.

## P1--P6 audit

| Property | Status | Reason |
|---|---|---|
| P1 | fail | no determinant or trace identity with zeta has been derived; finite determinant tends toward a trivial value |
| P2 | fail as an operator trace | entrywise Lambda factors do not make composite prime-power weights appear as the required trace powers |
| P3 | fail | negative eigenvalues occur at every tested cutoff because the Rees factor is indefinite |
| P4 | fail | no `s <-> 1-s` symmetry is built into the finite real matrix |
| P5 | yes | finite entries are arithmetic |
| P6 | fail/unproved | no trace-class limit or analytic continuation has been established |

## Failure mechanism

The Lambda weighting cannot repair the sign structure of the Rees matrix:
diagonal scaling by a nonzero real vector preserves its negative principal
minors. The normalization also suppresses the spectrum as `X` grows,
producing `det(I-T_X) -> 1` rather than a zeta determinant.

## Verdict

**DEAD.** This candidate adds arithmetic weights but does not supply the
functional equation, positivity, or zeta determinant. The next uneliminated
candidate is the Selberg-zeta finite Euler product, whose algebraic limit can
be checked exactly.
