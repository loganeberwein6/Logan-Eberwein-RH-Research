"""Low-degree Jensen-polynomial probe for Xi(t)=xi(1/2+i t)."""

import mpmath as mp
import numpy as np


def Xi(t):
    s = mp.mpf("0.5") + 1j * t
    return (mp.mpf("0.5") * s * (s - 1) * mp.pi ** (-s / 2) *
            mp.gamma(s / 2) * mp.zeta(s)).real


if __name__ == "__main__":
    mp.mp.dps = 30
    # Xi is even; use coefficients of Xi(t)=sum a_n t^(2n).
    raw = mp.taylor(Xi, 0, 24)
    a = [raw[2 * n] for n in range(13)]
    print("max odd Xi coefficient:", mp.nstr(max(abs(raw[2*n+1]) for n in range(12)), 8))
    for degree in (2, 4, 6, 8, 10, 12):
        coeff = [float(mp.binomial(degree, j) * a[j])
                 for j in range(degree + 1)]
        roots = np.roots(list(reversed(coeff)))
        real_fraction = sum(abs(r.imag) < 1e-7 for r in roots) / degree
        print(f"degree={degree}: real_root_fraction={real_fraction:.2f}")
    for offset in range(1, 5):
        degree = 6
        coeff = [float(mp.binomial(degree, j) * a[offset + j])
                 for j in range(degree + 1)]
        scale = max(abs(c) for c in coeff)
        roots = np.roots(list(reversed([c / scale for c in coeff])))
        real_fraction = sum(abs(r.imag) < 1e-7 for r in roots) / degree
        print(f"offset={offset}, degree={degree}: real_root_fraction={real_fraction:.2f}")
