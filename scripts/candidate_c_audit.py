import numpy as np
from sympy import primerange

gammas = [14.1347, 21.0220, 25.0109, 30.4249, 32.9351]

def det_bc(s, X):
    value = 1.0 + 0j
    for p in primerange(2, X + 1):
        value *= 1 - p ** (-s)
    return value

for X in [20, 50, 100]:
    primes = list(primerange(2, X + 1))
    vals = np.array([abs(det_bc(0.5 + 1j * g, X)) for g in np.linspace(0, 50, 10001)])
    grid = np.linspace(0, 50, 10001)
    ix = np.argsort(vals)[:5]
    eig_abs = sorted([p ** -0.5 for p in primes], reverse=True)
    print(f"X={X}: det(1.5)={det_bc(1.5, X)} det(2.0)={det_bc(2.0, X)}")
    print("  minima:", [(round(float(grid[i]), 4), round(float(vals[i]), 8)) for i in ix])
    print("  at zeta gammas:", [(g, abs(det_bc(0.5 + 1j * g, X))) for g in gammas])
    print("  top eigenvalue magnitudes:", np.round(eig_abs[:10], 6))
