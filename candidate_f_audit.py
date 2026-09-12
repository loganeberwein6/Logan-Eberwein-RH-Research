import numpy as np
from sympy import gcd

def rees(X):
    sup = list(range(2, X))
    return np.array([[-1.0 if m*n < X else 1.0 for n in sup] for m in sup])

for X in [6, 10, 30, 100]:
    M = -rees(X)
    eigs = np.linalg.eigvalsh(M)
    ones = float(np.ones(X-2) @ M @ np.ones(X-2))
    print(f"X={X}: all_ones={ones:.1f} min_eig={eigs[0]:.6f} max_eig={eigs[-1]:.6f}")
    print(f"  first_5_eigs={np.round(eigs[:5], 6)}")
