"""Numerical Fourier transforms of finite even theta-mode kernels."""

import mpmath as mp


def mode(t, n):
    t = abs(t)
    return ((2 * mp.pi ** 2 * n ** 4 * mp.e ** (mp.mpf("4.5") * t) -
             3 * mp.pi * n ** 2 * mp.e ** (mp.mpf("2.5") * t)) *
            mp.e ** (-mp.pi * n ** 2 * mp.e ** (2 * t)))


def partial_fourier(x, N):
    return 2 * mp.quad(lambda t:
                       mp.fsum(mode(t, n) for n in range(1, N + 1)) *
                       mp.cos(x * t), [0, 1, 2, 4, 8, mp.inf])


def Xi(x):
    s = mp.mpf("0.5") + 1j * x
    return (mp.mpf("0.5") * s * (s - 1) * mp.pi ** (-s / 2) *
            mp.gamma(s / 2) * mp.zeta(s)).real


if __name__ == "__main__":
    mp.mp.dps = 20
    for x in (0, 5):
        target = Xi(x)
        print(f"x={x}, Xi={mp.nstr(target, 10)}")
        for N in (1, 3):
            value = partial_fourier(mp.mpf(x), N)
            print(f"  N={N}: value={mp.nstr(value, 10)} "
                  f"error={mp.nstr(abs(value-target), 8)}")
