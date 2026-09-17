"""Numerical check of the completed xi factor and its functional symmetry."""

import mpmath as mp


def completed_xi(s):
    return (mp.mpf("0.5") * s * (s - 1) *
            mp.pi ** (-s / 2) * mp.gamma(s / 2) * mp.zeta(s))


if __name__ == "__main__":
    mp.mp.dps = 60
    samples = [mp.mpf("0.3") + 2.1j,
               mp.mpf("0.7") + 7.25j,
               mp.mpf("1.4") + 3.0j,
               mp.mpf("-0.2") + 5.5j]
    for s in samples:
        lhs = completed_xi(s)
        rhs = completed_xi(1 - s)
        print(f"s={s}: symmetry_error={mp.nstr(abs(lhs-rhs), 8)}")
