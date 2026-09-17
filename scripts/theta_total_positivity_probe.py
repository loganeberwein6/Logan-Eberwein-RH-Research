"""Finite-minor probe for total positivity of the corrected theta kernel."""

import mpmath as mp


def kernel(t, terms=30):
    t = mp.mpf(t)
    return mp.fsum((2 * mp.pi ** 2 * n ** 4 * mp.e ** (mp.mpf("4.5") * t) -
                    3 * mp.pi * n ** 2 * mp.e ** (mp.mpf("2.5") * t)) *
                   mp.e ** (-mp.pi * n ** 2 * mp.e ** (2 * t))
                   for n in range(1, terms + 1))


if __name__ == "__main__":
    mp.mp.dps = 40
    grid = [mp.mpf(k) / 4 for k in range(6)]
    for size in (2, 3, 4):
        M = mp.matrix([[kernel(grid[i] + grid[j]) for j in range(size)]
                       for i in range(size)])
        print(f"size={size}: determinant={mp.nstr(mp.det(M), 12)}")
