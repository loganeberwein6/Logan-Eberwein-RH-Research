"""Finite Euler determinant times the archimedean factor."""

import mpmath as mp

from euler_logdet_bridge import primes_up_to


def xi(s):
    return (mp.mpf("0.5") * s * (s - 1) * mp.pi ** (-s / 2) *
            mp.gamma(s / 2) * mp.zeta(s))


def finite_xi(s, prime_cutoff):
    euler = mp.fprod(1 / (1 - mp.power(p, -s))
                      for p in primes_up_to(prime_cutoff))
    arch = mp.mpf("0.5") * s * (s - 1) * mp.power(mp.pi, -s / 2) * mp.gamma(s / 2)
    return arch * euler


if __name__ == "__main__":
    mp.mp.dps = 50
    for s in (mp.mpf("1.5"), mp.mpf("2"), mp.mpf("3"),
              mp.mpf("2") + 3j):
        target = xi(s)
        print(f"s={s}")
        for cutoff in (10, 100, 1000, 5000):
            err = abs(finite_xi(s, cutoff) - target)
            print(f"  cutoff={cutoff}: error={mp.nstr(err, 8)}")
