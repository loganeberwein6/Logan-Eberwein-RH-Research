# Cycle 57: engineered cancellation of mixed primitive cycles

## Construction

Use the genuinely non-triangular graph

`T=[[a,u,0],[v,b,w],[0,z,c]]`.

The two mixed two-cycles have weights `uv` and `wz`. Choosing

`z=-uv(1-c)/(w(1-a))`

cancels their determinant corrections, giving

`det(I-T)=(1-a)(1-b)(1-c)`.

## Numerical checks

```text
(a,b,c,u,v,w)=(.2,.3,.4,.1,.2,.3), z=-.05:
  det(I-T)=.336, base product=.336

(a,b,c,u,v,w)=(.4,.25,.1,.2,.15,.5), z=-.09:
  det(I-T)=.405, base product=.405
```

The matrices are genuinely non-triangular and have complex-conjugate
eigenvalue pairs, so this is not merely a triangular extension.

## Structural diagnosis

The cancellation is possible only because one coupling weight is signed (both
examples have `z<0`). It is also tuned using the diagonal loop weights and
therefore is not an independent arithmetic identity. In a prime graph, the
same mechanism would require a systematic signed primitive-cycle relation for
every mixed cycle, together with convergence and functional symmetry.

This construction shows that Cycle 55 is not an impossibility theorem for all
signed graphs; it is an obstruction for uncancelled or nonnegative couplings.
It also identifies the exact remaining mathematical target: an arithmetic
Selberg-type cancellation law, not ad hoc coefficient tuning.

## Verdict

**Nontrivial but tautologically tunable.** Engineered cancellation can preserve
an Euler determinant while remaining non-triangular, but no arithmetic,
positivity, or functional-equation mechanism has been obtained.
