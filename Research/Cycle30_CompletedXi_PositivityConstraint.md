# Cycle 30: positivity constraint for the completed target

## Test

For the completed target `F(s)=1/xi(s)`, the critical-line value is real
because `xi(1/2+it)` is real. High-precision values of `xi(1/2+it)` include:

```text
t=0    +4.971207781883141e-1
t=10   +3.796785031093568e-2
t=14   +2.012944442352575e-4
t=15   -7.056979589821479e-4
t=20   -3.665542775560946e-5
t=21   -3.977491987782704e-7
t=22   +7.716314799755667e-6
t=25   +1.382457216509899e-8
t=26   -6.473785308625023e-7
t=30   -1.501662247980207e-8
t=31   +7.610988126563921e-9
t=33   -2.574793999468391e-10
t=40   +2.117621707907226e-11
```

The sign changes occur at the known zeta zeros. Consequently, any proposed
operator satisfying

`det(I-K(t)) = 1/xi(1/2+it)`

cannot have `I-K(t)` positive semidefinite for every `t`: a positive
semidefinite Fredholm determinant is nonnegative and cannot change sign.

## Consequence for P3

The strongest viable positivity statement is therefore one of:

1. a self-adjoint but indefinite operator pencil whose determinant changes sign;
2. a lower-bound/coercivity statement for a different quadratic form;
3. positivity of a Weil kernel or quadratic form whose zero condition is
   equivalent to the determinant vanishing, rather than positivity of the
   determinant operator itself.

This explains why the finite SR identity `S+S^T=-2I` cannot simply be attached
to the completed determinant: exact coercivity of the determinant block would
contradict the observed sign structure.

## P1--P6 update

| Property | Status |
|---|---|
| P1 | scalar completed determinant has correct zeros |
| P2 | scalar Euler-product factor is correct |
| P3 | positive-semidefinite determinant block is ruled out; only weaker/coercive formulations remain |
| P4 | exact at scalar completed level |
| P5 | arithmetic chain plus archimedean completion |
| P6 | finite/archimedean pieces controlled; infinite arithmetic chain open |

## Verdict

**Positive-definite determinant realization is impossible for the target.** This
is not an impossibility theorem for all RH-relevant positivity, but it sharply
rules out the simplest interpretation of P3 and forces any successful operator
to use an indefinite self-adjoint pencil, a Weil-type kernel, or a positivity
criterion not equal to determinant positivity.
