import numpy as np

def K_threshold(X):
    """Skew-symmetric part of threshold matrix"""
    sup = list(range(2, X))
    thresholds = sorted(set((X - 1) // m for m in sup))
    n = len(thresholds)
    S = np.array([[-1.0 if thresholds[j] <= thresholds[i] else 1.0
                   for j in range(n)] for i in range(n)])
    K = (S - S.T) / 2
    eigs = np.linalg.eigvals(1j * K)
    return np.sort(eigs.real)

zeta_gammas = [14.1347, 21.0220, 25.0109, 30.4249, 32.9351]

print("Eigenvalues of K_threshold (scaled) vs zeta zero imaginary parts:")
for X in [100, 500, 1000, 2310]:
    eigs = K_threshold(X)
    nonzero = eigs[np.abs(eigs) > 0.01]
    if len(nonzero) > 0:
        scale = zeta_gammas[0] / nonzero[0] if nonzero[0] > 0 else 1
        print(f"\nX={X}: {len(nonzero)} nonzero eigenvalues")
        print(f"  First 5 (scaled by {scale:.4f}): {np.round(nonzero[:5] * scale, 4)}")
        print(f"  zeta zeros:                         {zeta_gammas[:5]}")
