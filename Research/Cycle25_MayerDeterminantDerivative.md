# Cycle 25: derivative of the Mayer Fredholm determinant

## Exact construction

After the change of variable `q=2s`, Mayer's identity is

`D(q)=det(I-L_{q/2})=zeta(q-1)/zeta(q)`.

Differentiating gives

`D'(q)/D(q)=zeta'(q-1)/zeta(q-1)-zeta'(q)/zeta(q)`.

The desired von Mangoldt series is

`-zeta'(q)/zeta(q)`.

Therefore the derivative route differs by the unavoidable shifted term
`zeta'(q-1)/zeta(q-1)`. It does expose zeta zeros as poles, but it does not
isolate the desired logarithmic derivative.

## Numerical check

```text
q=1.5:       dlogD =  4.191327065401101
             target = 1.505235355788268
             extra  = 2.686091709612833

q=2.5:       dlogD = -1.216494670230075
             target = 0.2887406855581931
             extra  = -1.505235355788268

q=1/2+14.1347i:
             dlogD = -1.059715585363272 - 39774.54316314627 i
             target = 0.405273482429044 - 39774.42076147361 i
             extra  = -1.464989067792316 - 0.1224016726599871 i

q=1/2+21.022i:
             dlogD = -1.131144292760186 - 25227.86333822656 i
             target = 0.6037990600128556 - 25227.87797815231 i
             extra  = -1.734943352773042 + 0.01463992574630169 i
```

The point `q=2` is a pole and was excluded from numerical differentiation.

## P1--P6 assessment

| Property | Status |
|---|---|
| P1 | partial: differentiation produces poles at zeta zeros and shifted zeta zeros |
| P2 | partial: the desired logarithmic derivative is present, but mixed with a shift |
| P3 | absent |
| P4 | inherited only as a quotient relation, not the required positivity symmetry |
| P5 | yes through Mayer's integer branches |
| P6 | strong: derivative of a nuclear Fredholm determinant is analytically meaningful |

## Precise conclusion

This is the closest analytic mechanism found so far to P1/P2/P6, but it is
not a solution. Removing the shifted term would require a second operator with
determinant `zeta(q-1)` or an exact cancellation identity. Such cancellation
would return to the original quotient and cannot be obtained by simply taking
another derivative.

**Status: near miss, not dead as a framework; no RH operator yet.**
