"""Grid approximation to the Xi correlation kernel Phi_(2,y)."""

import numpy as np


def phi(t, terms=20):
    t = abs(t)
    n = np.arange(1, terms + 1, dtype=float)
    return np.sum((2 * np.pi**2 * n**4 * np.exp(4.5*t) -
                   3 * np.pi * n**2 * np.exp(2.5*t)) *
                  np.exp(-np.pi * n**2 * np.exp(2*t)))


if __name__ == "__main__":
    h = 0.02
    grid = np.arange(-6, 6 + h/2, h)
    values = np.array([phi(t) for t in grid])
    for y in (0.0, 0.2, 0.4):
        corr = []
        for t in grid[::20]:
            s = grid
            integrand = (t - 2*s)**2 * np.array([phi(t-x) for x in s]) * values
            corr.append(np.cosh(y*t) * np.sum(integrand) * h)
        corr = np.array(corr)
        print(f"y={y}: min={corr.min():.6e} max={corr.max():.6e} "
              f"negative_count={(corr < -1e-12).sum()}")
