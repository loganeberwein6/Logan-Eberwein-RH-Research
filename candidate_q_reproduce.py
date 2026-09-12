import numpy as np
from scipy.integrate import quad
from sympy import factorint


def von_mangoldt(k):
    f = factorint(int(k))
    return float(np.log(next(iter(f)))) if len(f) == 1 else 0.0


def qfun(n, m, x, L):
    if n == m:
        return 2.0 * (1.0 - x / L) * np.cos(2.0 * np.pi * n * x / L)
    return (
        np.sin(2.0 * np.pi * n * x / L)
        - np.sin(2.0 * np.pi * m * x / L)
    ) / (np.pi * (m - n))


def w02(n, m, L):
    return (
        32.0 * L * np.sinh(L / 4.0) ** 2
        * (L * L - 16.0 * np.pi**2 * m * n)
        / ((L * L + 16.0 * np.pi**2 * m * m)
           * (L * L + 16.0 * np.pi**2 * n * n))
    )


def w_prime(n, m, L):
    total = 0.0
    for k in range(2, int(np.exp(L)) + 1):
        weight = von_mangoldt(k)
        total += weight * k ** (-0.5) * qfun(n, m, np.log(k), L)
    return total


def w_real(n, m, L):
    omega0 = qfun(n, m, 0.0, L)
    gamma = 0.5772156649015329
    constant = 0.5 * (gamma + np.log(4.0 * np.pi))
    tail = 0.5 * np.log((np.exp(L) + 1.0) / (np.exp(L) - 1.0))

    def integrand(x):
        den = np.exp(x) - np.exp(-x)
        if abs(x) < 1e-8:
            # The numerator vanishes to first order; quad never needs this
            # value exactly, but this avoids a removable 0/0 at the endpoint.
            h = 1e-6
            return (
                (np.exp(h / 2.0) * qfun(n, m, h, L) - omega0)
                / (np.exp(h) - np.exp(-h))
            )
        return (np.exp(x / 2.0) * qfun(n, m, x, L) - omega0) / den

    integral = quad(integrand, 0.0, L, epsabs=2e-10, epsrel=2e-10)[0]
    return integral - omega0 * tail + constant * omega0


def weil_matrix(lam, N):
    L = 2.0 * np.log(lam)
    inds = list(range(-N, N + 1))
    T = np.zeros((len(inds), len(inds)))
    for i, n in enumerate(inds):
        for j, m in enumerate(inds):
            T[i, j] = w02(n, m, L) - w_prime(n, m, L) - w_real(n, m, L)
    return T, inds


def perturbed_scaled_spectrum(lam, N):
    T, inds = weil_matrix(lam, N)
    _, vectors = np.linalg.eigh(T)
    xi = vectors[:, 0]
    eta = np.ones(len(inds))
    xi = xi / (eta @ xi)
    D = np.diag(np.asarray(inds, dtype=float))
    perturbed = D - np.outer(D @ xi, eta)
    values = np.linalg.eigvals(perturbed)
    positive = np.sort(
        values.real[(np.abs(values.imag) < 1e-7) & (values.real > 1e-6)]
    )
    return positive * (2.0 * np.pi / (2.0 * np.log(lam)))


if __name__ == "__main__":
    for lam in [2.0, 3.0, 4.0]:
        for N in [2, 4]:
            T, inds = weil_matrix(lam, N)
            eigvals, eigvecs = np.linalg.eigh(T)
            v = eigvecs[:, 0]
            parity = np.linalg.norm(v - v[::-1]) / np.linalg.norm(v)
            print(
                f"lambda={lam:g} N={N}: "
                f"symerr={np.max(np.abs(T-T.T)):.3e} "
                f"min={eigvals[0]:.9g} "
                f"max={eigvals[-1]:.9g} "
                f"even_err={parity:.3e}"
            )
