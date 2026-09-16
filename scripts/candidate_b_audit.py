import cmath
import math
import numpy as np
from sympy import primerange

gammas = [14.1347, 21.0220, 25.0109, 30.4249, 32.9351]

def Z_sr(s, X):
    value = 1.0 + 0j
    for p in primerange(2, X + 1):
        kmax = int(math.log(X, p))
        for k in range(kmax + 1):
            value *= 1 - p ** (-(s + k))
    return value

for X in [20, 50, 100]:
    print(f"X={X}: Z(1.5)={Z_sr(1.5, X)} Z(2.0)={Z_sr(2.0, X)}")
    grid = np.linspace(0, 50, 10001)
    vals = np.array([abs(Z_sr(0.5 + 1j * g, X)) for g in grid])
    ix = np.argsort(vals)[:5]
    print("  minima:", [(round(float(grid[i]), 4), round(float(vals[i]), 8)) for i in ix])
    print("  at zeta gammas:", [(g, abs(Z_sr(0.5 + 1j * g, X))) for g in gammas])
