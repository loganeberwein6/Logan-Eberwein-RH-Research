"""Finite arithmetic Weil-form operator.

This construction uses no zeta-zero data and no fitted constants.  Its
ingredients are: Lambda(k), logarithmic prime-power locations, Fourier test
functions on a symmetric interval, pi, Euler's constant, and the standard
archimedean gamma normalization.
"""

from __future__ import annotations

import mpmath as mp
from sympy import factorint


PI = mp.pi


def von_mangoldt(k: int) -> mp.mpf:
    """Return Lambda(k), defined arithmetically from prime factorization."""
    factors = factorint(k)
    if len(factors) == 1:
        return mp.log(next(iter(factors)))
    return mp.mpf("0")


def fourier_test(n: int, m: int, x: mp.mpf, length: mp.mpf) -> mp.mpf:
    """Fourier-basis test kernel on [-length/2,length/2]."""
    if n == m:
        return 2 * (1 - x / length) * mp.cos(2 * PI * n * x / length)
    return (mp.sin(2 * PI * n * x / length)
            - mp.sin(2 * PI * m * x / length)) / (PI * (m - n))


def finite_arithmetic_weil_operator(scale: mp.mpf, cutoff: int) -> mp.matrix:
    """Build the finite symmetric arithmetic Weil matrix W(scale, cutoff).

    `scale` determines the test interval length 2*log(scale); it is not fitted
    to zero ordinates.  `cutoff` is the Fourier-mode cutoff.
    """
    length = 2 * mp.log(scale)
    modes = list(range(-cutoff, cutoff + 1))
    size = len(modes)
    W = mp.matrix(size)
    tail = mp.mpf("0.5") * mp.log((mp.exp(length) + 1) /
                                   (mp.exp(length) - 1))
    arch_constant = (mp.euler + mp.log(4 * PI)) / 2

    for i, n in enumerate(modes):
        for j, m in enumerate(modes):
            omega0 = fourier_test(n, m, mp.mpf("0"), length)

            def arch_integrand(x: mp.mpf) -> mp.mpf:
                if x == 0:
                    return mp.mpf("0")
                return (mp.exp(x / 2) * fourier_test(n, m, x, length)
                        - omega0) / (mp.exp(x) - mp.exp(-x))

            arch = (mp.quad(arch_integrand, [0, length])
                    - omega0 * tail + arch_constant * omega0)
            prime = mp.fsum(
                von_mangoldt(k) * mp.mpf(k) ** (-mp.mpf("0.5"))
                * fourier_test(n, m, mp.log(k), length)
                for k in range(2, int(mp.floor(mp.exp(length))) + 1)
            )
            boundary = (32 * length * mp.sinh(length / 4) ** 2
                        * (length ** 2 - 16 * PI ** 2 * m * n)
                        / ((length ** 2 + 16 * PI ** 2 * m ** 2)
                           * (length ** 2 + 16 * PI ** 2 * n ** 2)))
            W[i, j] = boundary - prime - arch
    return W


def diagnostics() -> None:
    mp.mp.dps = 40
    for scale, cutoff in ((mp.mpf("1.5"), 2),
                          (mp.mpf("2"), 2),
                          (mp.mpf("2"), 4)):
        W = finite_arithmetic_weil_operator(scale, cutoff)
        vals, _ = mp.eigsy(W)
        print("scale=", scale, "cutoff=", cutoff)
        print("  dimension=", W.rows)
        print("  min_eigenvalue=", mp.nstr(vals[0], 16))
        max_value = vals[vals.rows - 1]
        print("  max_eigenvalue=", mp.nstr(max_value, 16))
        print("  condition_proxy=", mp.nstr(max_value / vals[0], 16))


def invariant_sweep() -> None:
    """Check symmetry and finite positivity over unfitted scales/cutoffs."""
    mp.mp.dps = 35
    for scale_text in ("1.2", "1.5", "2", "2.5", "3"):
        for cutoff in (1, 2, 3):
            W = finite_arithmetic_weil_operator(mp.mpf(scale_text), cutoff)
            vals, _ = mp.eigsy(W)
            asymmetry = max(
                abs(W[i, j] - W[j, i])
                for i in range(W.rows)
                for j in range(W.cols)
            )
            print(
                "sweep scale=", scale_text,
                "cutoff=", cutoff,
                "asymmetry=", mp.nstr(asymmetry, 5),
                "min=", mp.nstr(vals[0], 10),
                "max=", mp.nstr(vals[vals.rows - 1], 10),
            )


if __name__ == "__main__":
    diagnostics()
