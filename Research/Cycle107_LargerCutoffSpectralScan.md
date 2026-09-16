# Cycle 107 — Larger-Cutoff Finite Spectral Scan

The corrected shifted-Weil quotient construction was evaluated at `N=4,6,8,
10,12,16` for `lambda=2,3,4`.

## Raw positive spectra

```text
lambda=2
N= 4: [14.13473313, 21.07570202, 27.54080015, 83.75709672]
N= 6: [14.13472519, 21.02205774, 25.01144479, 30.78781661,
       42.46085245, 125.56360729]
N= 8: [14.13472515, 21.02204103, 25.01088785, 30.42717947,
       32.94678084, 37.68523237, 51.03787309, 151.98872718]
N=10: [14.13472515, 21.02204058, 25.01087761, 30.42632325,
       32.94213031, 37.63607549, 41.27673271, 44.06101400]
N=12: [14.13472514, 21.02204029, 25.01087132, 30.42585658,
       32.93982656, 37.61999590, 41.16090536, 43.75049540]
N=16: [14.13472514, 21.02204014, 25.01086815, 30.42563542,
       32.93877381, 37.61318146, 41.11677668, 43.66692909]

lambda=3
N= 8:  [14.13472516, 19.40266344, 21.02202557, 25.01077411,
        30.82946113, 36.74830782, 58.27273364, 200.39661891]
N=12:  [4.60678333, 8.57745466, 14.13472514, 21.02203964,
        25.01085758, 30.42487616, 32.93506234, 37.62257519]
N=16:  [3.37827082, 8.77279103, 14.13472514, 17.13445669,
        21.02203964, 25.01085758, 30.42487614, 32.93506162]

lambda=4
N= 8:  [1.49658240, 14.13472497, 21.02281573, 24.57802301,
        29.88658378, 33.12615425, 53.03028769, 132.90906937]
N=12:  [1.89008252, 6.50899617, 14.13472515, 19.09962504,
        21.02203956, 25.01085764, 30.42561703, 32.96112661]
N=16:  [0.26785131, 3.33575626, 6.98714758, 11.35744265,
        14.13472514, 21.02203964, 22.76640685, 25.01085758]
```

## Interpretation

At fixed `lambda=2`, the first five branches stabilize progressively near
`14.13472514`, `21.02203964`, `25.01085758`, and `30.42487613`; the higher
branches converge more slowly and reorder.

At `lambda=3` and `lambda=4`, additional low positive modes appear as `N`
grows. The known zero ordinates remain visible, but their positions in the
sorted list change. Thus sorted eigenvalue convergence is not uniform in the
two parameters and cannot be used as the definition of the infinite operator.

The shifted-form quotient residuals remain small (roughly `10^-12` to
`10^-6` in this scan), while the smallest finite Weil eigenvalues are at or
below floating-point conditioning for larger parameters. This confirms the
finite algebraic mechanism but also demonstrates why a common-space spectral
projection or determinant convergence theorem is necessary.

## Verdict

The finite approximations do not converge to a single visibly stable sorted
sequence under the tested joint increases. They show stable zero-like branches
embedded in a changing low-mode spectrum. This is evidence for the candidate
operator, not evidence that the global limit has been established.
