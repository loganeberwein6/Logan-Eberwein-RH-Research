# Cycle 40: fermionic Euler-loop operator

## Construction

Let `A_s` be the diagonal operator on the prime one-particle space with
eigenvalues `p^(-s)`. Its fermionic second quantization has determinant

`det(I-A_s)=prod_p (1-p^(-s))=1/zeta(s)`

in the convergent half-plane. Equivalently, the exterior algebra expands into
independent prime occupation loops, and the logarithmic derivative recovers
the von Mangoldt prime-power weights.

This is the cleanest exact implementation of the Euler-loop requirement.

## Finite numerical checks

```text
primes <= 3:  det at s=1.5 = 0.5220379014
primes <= 5:  det at s=1.5 = 0.4753454120
primes <= 7:  det at s=1.5 = 0.4496791723

critical-line minima:
primes <=11: t=0 (.02973184), .25 (.05018826), 28.75 (.27403965)
primes <=19: t=0 (.01254100), .25 (.02799518), 28.75 (.27287151)
```

The finite Euler products have their smallest values at zero frequency, not at
the first nontrivial zeta ordinate. This is expected: the exact infinite
product is an identity for `1/zeta`, not a new zero-location mechanism.

## P1--P6

| Property | Status |
|---|---|
| P1 | exact determinant identity in `Re(s)>1`, continuation only by zeta theory |
| P2 | exact: exterior-power expansion produces Lambda(p^k) |
| P3 | ordinary prime diagonal is positive for real `s`, but gives no RH-relevant coercivity |
| P4 | absent; no operator involution implementing `s -> 1-s` |
| P5 | yes, prime arithmetic is intrinsic |
| P6 | finite products converge only in the Euler-product half-plane; critical-strip operator continuation is missing |

## Structural conclusion

This construction proves that P1 and P2 are compatible through genuine Euler
loops, but it also exposes the circularity: the operator is simply the prime
diagonal whose determinant was chosen from the Euler product. Adding SR
off-diagonal terms changes the determinant unless an exact integrable coupling
is found.

## Verdict

**Exact arithmetic control, not an RH operator.** The next meaningful target is
an integrable coupling between this fermionic Euler-loop sector and a Weil/SR
coercive sector that preserves the determinant while adding a genuine
functional-equation symmetry.
