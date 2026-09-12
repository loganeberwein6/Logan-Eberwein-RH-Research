import mpmath as mp
from sympy import factorint

mp.mp.dps = 50
PI = mp.pi


def von_mangoldt(k):
    factors = factorint(int(k))
    return mp.log(next(iter(factors))) if len(factors) == 1 else mp.mpf(0)


def qfun(n, m, x, length):
    if n == m:
        return 2 * (1 - x / length) * mp.cos(2 * PI * n * x / length)
    return (
        mp.sin(2 * PI * n * x / length)
        - mp.sin(2 * PI * m * x / length)
    ) / (PI * (m - n))


def weil_matrix(lam, N):
    length = 2 * mp.log(lam)
    indices = list(range(-N, N + 1))
    matrix = mp.matrix(len(indices))
    for i, n in enumerate(indices):
        for j, m in enumerate(indices):
            omega0 = qfun(n, m, 0, length)
            tail = mp.mpf("0.5") * mp.log(
                (mp.e**length + 1) / (mp.e**length - 1)
            )
            archimedean = (
                mp.quad(
                    lambda x: (
                        mp.e**(x / 2) * qfun(n, m, x, length) - omega0
                    ) / (mp.e**x - mp.e**(-x))
                    if x
                    else mp.mpf(0),
                    [0, length],
                )
                - omega0 * tail
                + (mp.euler + mp.log(4 * PI)) * omega0 / 2
            )
            prime_part = mp.fsum(
                von_mangoldt(k)
                * mp.mpf(k) ** (-mp.mpf("0.5"))
                * qfun(n, m, mp.log(k), length)
                for k in range(2, int(mp.e**length) + 1)
            )
            w02 = (
                32 * length * mp.sinh(length / 4) ** 2
                * (length**2 - 16 * PI**2 * m * n)
                / (
                    (length**2 + 16 * PI**2 * m**2)
                    * (length**2 + 16 * PI**2 * n**2)
                )
            )
            matrix[i, j] = w02 - prime_part - archimedean
    return matrix


for lam, N in [(2, 2), (2, 4), (3, 4)]:
    eigenvalues, _ = mp.eigsy(weil_matrix(mp.mpf(lam), N))
    print(
        f"lambda={lam}, N={N}: "
        f"mu_N={mp.nstr(eigenvalues[0], 30)} "
        f"gap={mp.nstr(eigenvalues[1] - eigenvalues[0], 20)}"
    )
