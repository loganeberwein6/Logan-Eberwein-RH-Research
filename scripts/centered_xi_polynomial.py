"""Finite centered-xi polynomial probe.

The centered completed xi function is even in z=s-1/2.  Truncating its
Taylor series gives a finite spectral proxy; root locations are diagnostic,
not a proof of RH.
"""

import mpmath as mp
import numpy as np


def xi_centered(z):
    s = mp.mpf("0.5") + z
    return (mp.mpf("0.5") * s * (s - 1) * mp.pi ** (-s / 2) *
            mp.gamma(s / 2) * mp.zeta(s))


if __name__ == "__main__":
    mp.mp.dps = 80
    coeffs = mp.taylor(xi_centered, 0, 12)
    odd = max(abs(coeffs[k]) for k in range(1, len(coeffs), 2))
    print("max odd Taylor coefficient:", mp.nstr(odd, 8))
    # Keep the even polynomial in y=z^2 and report its roots.
    even = [float(coeffs[2 * k]) for k in range(7)]
    roots = np.roots(list(reversed(even)))
    print("roots of truncated polynomial in y=z^2:")
    for r in roots:
        print(mp.nstr(r, 10))
