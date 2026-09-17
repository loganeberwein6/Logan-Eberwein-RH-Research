"""Common ambient-space probe for finite arithmetic Weil forms."""

from __future__ import annotations

import mpmath as mp

from finite_arithmetic_weil_operator import finite_arithmetic_weil_operator


def overlap_matrix(old_length: mp.mpf, new_length: mp.mpf, cutoff: int) -> mp.matrix:
    """Exact L2 overlaps of normalized exponential modes on nested intervals."""
    modes = list(range(-cutoff, cutoff + 1))
    C = mp.matrix(len(modes))
    left, right = -old_length / 2, old_length / 2
    for i, new_mode in enumerate(modes):
        for j, old_mode in enumerate(modes):
            delta = 2 * mp.pi * (old_mode / old_length - new_mode / new_length)
            integral = old_length if delta == 0 else (
                mp.exp(1j * delta * right) - mp.exp(1j * delta * left)
            ) / (1j * delta)
            C[i, j] = mp.re(integral / mp.sqrt(old_length * new_length))
    return C


def probe() -> None:
    mp.mp.dps = 35
    master_scale = mp.mpf("3")
    for cutoff in (1, 2, 3):
        master_length = 2 * mp.log(master_scale)
        master = mp.eye(2 * cutoff + 1)
        print("cutoff=", cutoff)
        for scale_text in ("1.2", "1.5", "2", "2.5", "3"):
            scale = mp.mpf(scale_text)
            W = finite_arithmetic_weil_operator(scale, cutoff)
            C = overlap_matrix(2 * mp.log(scale), master_length, cutoff)
            pulled = C * W * C.T
            vals, _ = mp.eigsy(pulled)
            print(" scale=", scale_text,
                  "min=", mp.nstr(vals[0], 10),
                  "max=", mp.nstr(vals[vals.rows - 1], 10),
                  "overlap_det=", mp.nstr(abs(mp.det(C)), 10))


if __name__ == "__main__":
    probe()

