# Cycle 66: divisor-complex heat damping and zero modes

## Proposed nuclearity repair

The heat supertrace of a finite divisor complex is independent of the heat
time, so nonzero Laplacian modes can be damped without changing its Euler
index. The only modes that resist damping are harmonic zero modes. I computed
their Betti dimensions for sample divisor complexes.

```text
n=6:   simplex counts [2],          Betti [2],       total zero modes 2
n=12:  [4,3],                        Betti [1,0],     total 1
n=30:  [6,6],                        Betti [1,1],     total 2
n=60:  [10,21,12],                   Betti [1,0,0],   total 1
n=120: [14,45,52,20],                Betti [1,0,0,0], total 1
n=210: [14,36,24],                   Betti [1,0,1],   total 2
```

The reduced Euler characteristic still gives `mu(n)`, while the unreduced
harmonic dimension can exceed `|mu(n)|` because positive and negative Euler
contributions coexist.

## Consequence

Heat damping may make the nonzero-mode part trace class, but a global nuclear
estimate still requires a bound on the harmonic multiplicity `h(n)`. The
samples suggest small cohomology, but no general bound has been proved here.
If `h(n)` is bounded by a divisor-function type estimate, the direct sum could
be trace class for `Re(s)>1`; if it grows too quickly, even heat damping fails.

The logarithmic pair-complex lift does not alter this zero-mode issue.

## Verdict

**Promising P6 repair, unproved.** Heat-kernel damping separates the chain-count
problem from the harmonic multiplicity problem and provides a concrete theorem
target: bound the cohomology dimensions of proper-divisor complexes uniformly
enough for a weighted direct sum.
