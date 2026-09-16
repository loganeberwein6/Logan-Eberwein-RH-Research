# Cycle 54: multi-prime cycle obstruction

## Construction

Use a four-state directed cycle with equal edge weight

`w=(pq)^(-s/4)`.

The cycle product is `(pq)^(-s)`, so

`det(I-K_{p,q})=1-(pq)^(-s)`.

## Numerical verification

```text
(p,q)=(2,3), s=1.5:          det=0.9319586183
(p,q)=(2,3), critical:       det=0.5993504670+0.0784003723i
(p,q)=(2,5), s=1.5:          det=0.9683772234
(p,q)=(3,5), critical:       det=0.7837952573+0.1411457407i
```

All values agree with `1-(pq)^(-s)` to floating-point precision.

## Structural diagnosis

The multi-prime loop is genuinely nonlocal and non-gauge-trivial, but its
determinant creates an Euler factor for the composite `pq`. The zeta Euler
product contains independent prime factors, not factors `1-(pq)^(-s)` for all
composite pairs. Adding these cycles therefore changes the target determinant.

To preserve `1/zeta`, composite loops would need exact cancellations against
other cycles. Such cancellations are not supplied by SR signs and would have
to be proved as a new dynamical zeta identity.

## Verdict

**Dead as an uncancelled multi-prime coupling.** Multi-prime loops provide the
first genuinely nonlocal interaction, but they introduce forbidden composite
Euler factors. A viable arithmetic interaction must control the primitive-loop
cycle inventory exactly, likely through a Selberg/graph-primitivity identity.
