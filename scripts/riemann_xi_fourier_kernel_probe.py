"""Probe the standard theta-derived Fourier kernel for Xi."""

import mpmath as mp


def phi(u, terms=40):
    e2 = mp.e ** (2 * u)
    e52 = mp.e ** (mp.mpf("2.5") * u)
    e92 = mp.e ** (mp.mpf("4.5") * u)
    return mp.fsum((2 * mp.pi ** 2 * n ** 4 * e92 -
                    3 * mp.pi * n ** 2 * e52) *
                   mp.e ** (-mp.pi * n ** 2 * e2)
                   for n in range(1, terms + 1))


def phi_term(u, n):
    u = abs(mp.mpf(u))
    return (2 * mp.pi ** 2 * n ** 4 * mp.e ** (mp.mpf("4.5") * u) -
            3 * mp.pi * n ** 2 * mp.e ** (mp.mpf("2.5") * u)) * \
           mp.e ** (-mp.pi * n ** 2 * mp.e ** (2 * u))


if __name__ == "__main__":
    mp.mp.dps = 40
    # The theta-series expression is evaluated on t>=0 and then extended
    # evenly; direct substitution at negative t is not the stable formula.
    vals = [(u, phi(abs(mp.mpf(u)))) for u in
            (-8, -6, -4, -2, 0, 2, 4, 6, 8)]
    for u, value in vals:
        print(f"u={u}: phi={mp.nstr(value, 12)}")
    print("minimum sampled value:", mp.nstr(min(v for _, v in vals), 12))
    for n in (1, 2, 3, 5):
        sample_min = min(phi_term(u, n) for u in
                         [mp.mpf(k) / 4 for k in range(0, 25)])
        print(f"n={n}: sampled term minimum={mp.nstr(sample_min, 12)}")
