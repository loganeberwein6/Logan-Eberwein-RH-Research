"""Finite positive Euler operator and its determinant identity.

The diagonal operator is self-adjoint and positive for real s>1.  Its
determinant reproduces a truncated Euler product, but this script intentionally
does not claim that its spectrum is the xi-zero spectrum.
"""

import numpy as np
from math import prod

from euler_logdet_bridge import primes_up_to


def euler_operator(s, prime_cutoff, power_cutoff):
    # One scalar factor per prime.  Prime powers arise only after expanding
    # the logarithmic derivative, not by inserting separate determinant modes.
    values = [p ** (-s) for p in primes_up_to(prime_cutoff)]
    return np.diag(values)


def euler_product(s, prime_cutoff, power_cutoff):
    return prod(1.0 / (1.0 - p ** (-s))
                for p in primes_up_to(prime_cutoff))


if __name__ == "__main__":
    for s in (1.5, 2.0, 3.0):
        A = euler_operator(s, 100, 12)
        gram_det = np.linalg.det(np.eye(len(A)) - A)
        print(f"s={s}: min_eigenvalue={A.diagonal().min():.6e} "
              f"positive={bool(np.all(A.diagonal() > 0))} "
              f"det_inverse={1.0/gram_det:.12e} "
              f"euler_product={euler_product(s,100,12):.12e}")
