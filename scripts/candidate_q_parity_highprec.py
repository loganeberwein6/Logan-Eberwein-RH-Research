"""High-precision parity-block check for the finite Candidate-Q matrices."""
import mpmath as mp

from candidate_q_highprec import weil_matrix

mp.mp.dps = 80


def parity_block(lam, N, parity):
    A = weil_matrix(mp.mpf(lam), N)
    size = 2 * N + 1
    cols = []
    for i in range((size + 1) // 2):
        j = size - 1 - i
        v = mp.matrix(size, 1)
        if i == j:
            if parity == 1:
                v[i] = 1
        else:
            v[i] = 1 / mp.sqrt(2)
            v[j] = parity / mp.sqrt(2)
        if mp.norm(v) > 0:
            cols.append(v)
    B = mp.matrix(size, len(cols))
    for j, v in enumerate(cols):
        for i in range(size):
            B[i, j] = v[i]
    return B.T * A * B


def inspect(lam, N):
    result = {"lambda": lam, "N": N, "dps": mp.mp.dps}
    for parity, name in ((1, "even"), (-1, "odd")):
        vals, _ = mp.eigsy(parity_block(lam, N, parity))
        result[name] = [mp.nstr(v, 40) for v in vals]
    return result


if __name__ == "__main__":
    for lam, N in ((2, 2), (2, 4), (2, 6), (3, 4), (4, 4)):
        print(inspect(lam, N))
