"""Hankel positivity probe for the centered Xi Taylor sequence."""

import mpmath as mp
import numpy as np


def Xi(t):
    s = mp.mpf("0.5") + 1j * t
    return (mp.mpf("0.5") * s * (s - 1) * mp.pi ** (-s / 2) *
            mp.gamma(s / 2) * mp.zeta(s)).real


if __name__ == "__main__":
    mp.mp.dps = 35
    raw = mp.taylor(Xi, 0, 24)
    # Xi(t)=sum (-1)^n b_n t^(2n).  The Fourier-moment normalization is
    # c_n=(2n)! b_n, not the raw Taylor coefficient b_n.
    b = [float(((-1) ** n) * raw[2 * n]) for n in range(13)]
    c = [float(mp.factorial(2 * n) * b[n]) for n in range(13)]
    print("b0=", b[0], "min b=", min(b))
    for size in (2, 3, 4, 5, 6, 7):
        H = np.array([[c[i + j] for j in range(size)]
                      for i in range(size)])
        eigs = np.linalg.eigvalsh(H)
        print(f"size={size}: min_eigenvalue={eigs[0]:.6e} "
              f"psd={bool(eigs[0] >= -1e-12)}")
