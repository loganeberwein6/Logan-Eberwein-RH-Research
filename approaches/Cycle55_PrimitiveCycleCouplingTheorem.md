# Cycle 55: primitive-cycle coupling theorem

## Two-sector calculation

Let two prime-loop sectors have loop weights `a` and `b`, and let a coupling
path have forward/backward weights `u,v`:

`T=[[a,u],[v,b]]`.

Then

`det(I-T)=(1-a)(1-b)-uv`.

The first term is the product of the independent prime Euler factors. The
second term is the mixed two-sector cycle.

Numerically:

```text
a=.2,b=.3,u=.1,v=.2:
  det(I-T)=.54,  (1-a)(1-b)=.56,  uv=.02

a=.5,b=.4,u=0,v=.3:
  det(I-T)=.30,  (1-a)(1-b)=.30
```

The coupling changes the determinant exactly when the return path closes a
mixed cycle (`uv != 0`).

## General graph consequence

For a finite weighted directed graph, the Fredholm determinant is the product
over primitive cycles. If two otherwise independent prime-loop components are
joined by nonzero paths in both directions, a mixed primitive cycle exists and
contributes a new factor. Therefore preserving the pure Euler product requires
one of:

1. block decomposition into independent prime sectors;
2. one-way triangular coupling, which is determinant-invisible;
3. exact cancellation by additional weighted primitive cycles.

Cases 1 and 2 cannot transfer SR positivity. Case 3 requires a new exact
graph-zeta identity and cannot be obtained by generic SR signs.

## Verdict

**Class-level primitive-cycle obstruction.** Any nontrivial two-way coupling of
independent prime loops creates forbidden composite-cycle factors. The only
remaining possibility is a deliberately engineered primitive-cycle cancellation
with a proved Selberg-type identity.
