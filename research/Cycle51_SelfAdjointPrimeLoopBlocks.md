# Cycle 51: self-adjoint two-step prime loops

## Construction

For every prime `p`, use the self-adjoint block

`K_p(s)=[[0,p^(-s/2)],[p^(-s/2),0]]`.

Its determinant factor is exactly

`det(I-K_p)=1-p^(-s)`.

The direct sum over primes therefore has determinant the finite Euler product.
The two eigenvalues of each block are `+p^(-s/2)` and `-p^(-s/2)`.

## Numerical verification

```text
primes {2,3,5}, s=1.5:          determinant error 5.6e-17
primes {2,3,5}, s=.5+14.1347i: determinant error 5.0e-16
primes {2,3,5,7,11}, s=1.5:    error 1.1e-16
primes {2,3,5,7,11}, critical: error 1.7e-16
```

## What it achieves

This is an exact self-adjoint realization of the Euler product using return
loops rather than a diagonal occupation operator. It demonstrates that
self-adjointness and P1/P2 can coexist at the finite Euler-product level.

## What it lacks

1. The finite product has the usual zero-frequency behavior and no zeta-zero
   detector independent of Euler-product continuation.
2. There is no `s -> 1-s` operator involution or archimedean completion.
3. The blocks are indefinite: each has one positive and one negative eigenvalue.
4. No SR/Weil coercive form or non-circular positivity theorem is present.
5. The critical-strip Fredholm continuation is inherited only from the known
   zeta function, not proved from the operator construction.

Changing one loop sign gives `1+p^(-s)` instead of `1-p^(-s)`, so SR-style sign
changes are not harmless: they alter the Euler factor at the primitive loop.

## Verdict

**Exact P1/P2 self-adjoint control, but not an RH operator.** This is the
correct loop primitive for any future integrable coupling. The unresolved task
is to add a Weil functional involution and a separate coercive quadratic form
without changing the primitive Euler determinants.
