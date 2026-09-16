import numpy as np
from sympy import divisors

gammas = [14.1347, 21.0220, 25.0109, 30.4249, 32.9351]

def hecke_lambda(n, s):
    return sum(complex(d) ** (s - 1) for d in divisors(n))

def det_hecke(s, X):
    value = 1.0 + 0j
    for n in range(2, X + 1):
        value *= 1 - hecke_lambda(n, s) * n ** (-s)
    return value

for X in [20, 50, 100]:
    grid = np.linspace(0, 50, 10001)
    vals = np.array([abs(det_hecke(0.5 + 1j * g, X)) for g in grid])
    ix = np.argsort(vals)[:5]
    print(f"X={X}: det(1.5)={det_hecke(1.5, X)} det(2.0)={det_hecke(2.0, X)}")
    print("  minima:", [(round(float(grid[i]), 4), round(float(vals[i]), 8)) for i in ix])
    print("  at zeta gammas:", [(g, abs(det_hecke(0.5 + 1j * g, X))) for g in gammas])
