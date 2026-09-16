# Cycle 22: typed Mayer--SR hybrid

## Construction

The literal proposed kernel uses `Rees(floor(x),n)`, but the Mayer state space
is `[0,1]`, so `floor(x)=0` and the expression is undefined on its intended
domain. The minimal branch-coordinate repair replaces `floor(x)` by
`k=floor(1/x)`:

`(L_X^SR(s)f)(x) = sum_{n=1}^X eps_X(k,n)(x+n)^(-2s)f(1/(x+n))`,

where `eps_X(k,n)=-1` if `kn<X`, and `+1` otherwise.

## Numerical discretization

I used a 60-point midpoint grid on `[0,1]`, linear interpolation for the
Mayer image, and midpoint quadrature. The following are raw determinant and
eigenvalue diagnostics.

```text
X=20
 |det(I-L^SR(1.5))|                    1.003662135607904
 |det(I-L^SR(2.0))|                    1.002022828698917
 |det(I-L^SR(1/2+14.1347i))|           1.002999870774281
 critical-line minima (t,value):
   (22.75, .97754550), (22.50, .97917238), (1.25, .98029937),
   (38.00, .98215791), (9.50, .98266719)
 top eigenvalue magnitudes at s=1.5:
   .00635018, .00257962, .00088816, .00082715, .00056482,
   .00053837, .00053837, .00051633, .00051633, .00049411

X=50
 |det(I-L^SR(1.5))|                    1.004097597693532
 |det(I-L^SR(2.0))|                    1.002100616631253
 |det(I-L^SR(1/2+14.1347i))|           1.002441794482268
 critical-line minima (t,value):
   (1.00, .97414792), (30.00, .97975443), (16.50, .97984602),
   (29.75, .98132411), (16.25, .98158747)
 top eigenvalue magnitudes at s=1.5:
   .00654010, .00245761, .00076711, .00070629, .00055599,
   .00055599, .00051098, .00051098, .00041894, .00041894
```

## P1--P6 assessment

| Property | Status | Evidence |
|---|---|---|
| P1 | fails numerically | no stable minimum at 14.1347; determinant stays close to 1 |
| P2 | not established | the sign changes are divisor-threshold data, not Lambda weights |
| P3 | unproved | branch-dependent signs destroy the standard Mayer positivity structure |
| P4 | absent | no `s -> 1-s` intertwining was constructed |
| P5 | yes | finite integer branch/sign rule |
| P6 | only finite-dimensional | decay is observed in this discretization, but no nuclear-limit theorem exists |

## Verdict

**DEAD as the minimal typed repair.** The repair is well-defined and remains
numerically compact, but it neither reproduces the Mayer determinant nor
creates zeta-zero-specific critical-line minima. The failure is not merely a
bad endpoint convention: the SR sign depends on the inverse-state branch and
breaks the transfer-operator trace-cycle identity that produces the Euler
product. A successful hybrid would need an intertwining sign cocycle, not an
arbitrary branchwise multiplier.
