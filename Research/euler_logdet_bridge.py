"""Finite Euler-product/log-determinant bridge.

This verifies the arithmetic mechanism a determinant must supply: its
logarithmic derivative produces additive von-Mangoldt prime-power weights.
It is not an RH proof.
"""

from math import log


def primes_up_to(n):
    out = []
    for x in range(2, n + 1):
        if all(x % p for p in out if p * p <= x):
            out.append(x)
    return out


def finite_euler_log_derivative(s, prime_cutoff, power_cutoff):
    total = 0.0
    for p in primes_up_to(prime_cutoff):
        total -= sum(log(p) * p ** (-s * k)
                     for k in range(1, power_cutoff + 1))
    return total


def finite_von_mangoldt_sum(s, prime_cutoff, power_cutoff):
    total = 0.0
    for p in primes_up_to(prime_cutoff):
        total -= sum(log(p) * p ** (-s * k)
                     for k in range(1, power_cutoff + 1))
    return total


if __name__ == "__main__":
    for s in (1.5, 2.0, 3.0):
        a = finite_euler_log_derivative(s, 100, 12)
        b = finite_von_mangoldt_sum(s, 100, 12)
        print(f"s={s}: logdet={a:.16e} vonMangoldt={b:.16e} error={a-b:.3e}")
