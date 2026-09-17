"""Test the critical-line-shifted Euler factor."""

import mpmath as mp


def shifted_factor_zero(p, k):
    # 1 - p^(1/2-s) = 0, so s = 1/2 + 2*pi*i*k/log(p).
    return mp.mpf("0.5") + 2 * mp.pi * 1j * k / mp.log(p)


def shifted_log_derivative(s, prime_cutoff, power_cutoff):
    total = 0
    for p in list(mp.primepi(prime_cutoff) and
                  [q for q in range(2, prime_cutoff + 1)
                   if all(q % d for d in range(2, int(q ** .5) + 1))]):
        total -= sum(mp.log(p) * p ** (power * (mp.mpf("0.5") - s))
                     for power in range(1, power_cutoff + 1))
    return total


if __name__ == "__main__":
    mp.mp.dps = 30
    print("shifted factor zeros:")
    for p in (2, 3, 5):
        print(p, shifted_factor_zero(p, 1))
    for s in (2, 3):
        print("s=", s, "shifted log derivative=",
              shifted_log_derivative(mp.mpf(s), 100, 12))
