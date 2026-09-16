# Cycle 128 — Critical-Line Shift Versus Arithmetic Mismatch

The modified Euler factor

`1 - p^(1/2-s)`

has zeros exactly on `Re(s)=1/2`, with first examples:

```text
p=2:  0.5 + 9.06472028365 i
p=3:  0.5 + 5.71920173476 i
p=5:  0.5 + 3.90396253166 i
```

However, its logarithmic derivative is

`-sum_p,k log(p) p^(-k(s-1/2))`,

which is the von-Mangoldt series for `-zeta'(s-1/2)/zeta(s-1/2)`, not the
required `-zeta'(s)/zeta(s)`.

Thus a simple shift fixes the geometric location of factor zeros but changes
the arithmetic function. The final operator must implement the critical-line
shift through a genuine completed transform or metric/boundary mechanism,
not by shifting the Euler factors directly.
