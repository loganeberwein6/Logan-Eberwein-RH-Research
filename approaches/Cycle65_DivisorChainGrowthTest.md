# Cycle 65: divisor-complex chain-growth test

## Question

Cycle 64 left nuclearity dependent on a bound for the total number `c(n)` of
proper-divisor chains. I computed `c(n)` by dynamic programming: if `f(d)` is
the number of chains ending at `d`, then

`f(d)=1+sum_{e|d, 2<=e<d} f(e)`, and `c(n)=sum_{d|n,2<=d<n} f(d)`.

## Results

The simple conjecture `c(n)<=n` is false:

```text
n=72:  c(n)=75
n=96:  c(n)=111
n=120: c(n)=131
n=144: c(n)=207
n=192: c(n)=255
n=480: c(n)=975  (c/n=2.03125)
```

On `2<=n<=2000`, the largest observed ratio `c(n)/n^2` was `1/16`, attained
at the small case `n=4`; no quadratic violation was observed.

## Consequence

The naive linear trace-growth bound is disproved. A polynomial or
subpolynomial chain bound might still establish trace class in a right
half-plane, but it is not proved by the finite data. More importantly, even a
bound such as `c(n)=O(n^2)` would only give a direct-sum trace class for
`Re(s)>3`, far from the required critical strip.

To reach `Re(s)>1/2`, the complex must be renormalized or its nonzero Laplacian
modes must receive additional decay; Euler-index cancellation alone is not
enough.

## Verdict

**Linear nuclearity shortcut disproved.** The divisor complex remains an
arithmetic P2 framework, but global P6 requires spectral damping, a determinant
regularization, or a sharper chain-complex construction.
