# Cycle 41: triangular Euler--SR extension

## Construction

Let `A_s` be the prime/Euler-loop operator and `S_X` the exact SR threshold
block. The most general upper-triangular coupling has the form

`T(s)=[[A_s,B(s)],[0,S_X]]`.

Because `I-T` is block triangular,

`det(I-T)=det(I-A_s)det(I-S_X)`

for every coupling block `B(s)`. The same holds for trace-class Fredholm
determinants under the usual direct-sum hypotheses.

## Numerical sanity check

Using `A=2^(-1.5)`,
`S=[[-1,1],[-1,-1]]`, and coupling amplitudes `B=0,1,10`:

```text
B=0:  det(I-T)=3.2322330470336316
B=1:  det(I-T)=3.2322330470336316
B=10: det(I-T)=3.2322330470336316
```

The result agrees with `det(I-A)det(I-S)` to floating-point precision.

## Structural consequence

Triangular coupling is the only straightforward way to preserve both exact
Euler determinant data and the exact SR coercive block without solving a new
determinant identity. But the coupling is invisible to the determinant and
cannot transfer SR positivity to the Euler sector. If one makes the extension
self-adjoint by adding the lower-left adjoint block, the determinant changes
through a Schur complement and the previous SR--Lambda failures reappear.

## P1--P6

| Property | Status |
|---|---|
| P1 | inherited from the Euler block in `Re(s)>1` |
| P2 | inherited from Euler loops |
| P3 | present only as a separate SR block |
| P4 | absent |
| P5 | yes |
| P6 | conditional on the component spaces |

## Verdict

**Exact but sterile coupling.** This proves a class-level dichotomy: determinant-
preserving couplings cannot transmit SR coercivity, while determinant-visible
self-adjoint couplings require a new arithmetic identity. The remaining target
is therefore a genuinely non-triangular, integrable Schur coupling.
