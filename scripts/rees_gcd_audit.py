import numpy as np
from sympy import gcd

def Rees_times_GCD(X):
    """Hadamard product: Rees signs × GCD values"""
    sup = list(range(2, X))
    n = len(sup)
    M = np.zeros((n, n))
    for i, m in enumerate(sup):
        for j, nn in enumerate(sup):
            sign = -1.0 if m * nn < X else 1.0
            M[i, j] = sign * float(gcd(m, nn))
    return M

zeta_gammas = [14.1347, 21.0220, 25.0109, 30.4249, 32.9351]

for X in [100, 500]:
    M = Rees_times_GCD(X)
    eigs = np.linalg.eigvalsh(M)
    nonzero = np.sort(np.abs(eigs[np.abs(eigs) > 0.1]))[::-1]
    scale = zeta_gammas[0] / nonzero[0] if nonzero[0] > 0 else 1
    print(f"X={X}: scaled top eigenvalues: {np.round(nonzero[:5] * scale, 4)}")
    print(f"       zeta zeros:                {zeta_gammas[:5]}")
