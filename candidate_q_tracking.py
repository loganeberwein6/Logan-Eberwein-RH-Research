"""Adaptive spectral ledger for the finite Candidate-Q Weil matrices.

This is deliberately a diagnostic framework, not an RH proof.  The key
repair over naive scans is that eigenbranches are matched by vector overlap
inside exact reversal-parity blocks, rather than re-sorted by magnitude.
"""
from __future__ import annotations

import csv
import json
import sys
from pathlib import Path

import numpy as np
from scipy.optimize import linear_sum_assignment

from candidate_q_reproduce import weil_matrix


def parity_basis(size: int, parity: int) -> np.ndarray:
    """Columns spanning R v = parity*v, where R reverses the index order."""
    cols = []
    for i in range((size + 1) // 2):
        j = size - 1 - i
        v = np.zeros(size)
        if i == j:
            if parity == 1:
                v[i] = 1.0
        else:
            v[i] = 1.0 / np.sqrt(2.0)
            v[j] = parity / np.sqrt(2.0)
        if np.linalg.norm(v) > 0:
            cols.append(v)
    return np.column_stack(cols) if cols else np.zeros((size, 0))


def block(lam: float, N: int, parity: int):
    T, _ = weil_matrix(lam, N)
    B = parity_basis(T.shape[0], parity)
    A = (B.T @ T @ B + (B.T @ T @ B).T) / 2.0
    vals, vecs = np.linalg.eigh(A)
    vecs = B @ vecs
    return vals, vecs, A


def match(previous, current):
    """Match modes by maximum absolute eigenvector overlap."""
    old_vals, old_vecs = previous
    new_vals, new_vecs = current
    overlap = np.abs(old_vecs.T @ new_vecs)
    rows, cols = linear_sum_assignment(-overlap)
    order = np.full(len(old_vals), -1, dtype=int)
    order[rows] = cols
    return order, overlap[rows, cols]


def mode_transport(lam_old, lam_new, N):
    """Matrix C[new, old] = <phi_new, phi_old> for nested log intervals."""
    lo, ln = 2.0 * np.log(lam_old), 2.0 * np.log(lam_new)
    old = np.arange(-N, N + 1)
    new = np.arange(-N, N + 1)
    left, right = -lo / 2.0, lo / 2.0
    C = np.zeros((len(new), len(old)), dtype=complex)
    for i, ni in enumerate(new):
        for j, nj in enumerate(old):
            delta = 2.0 * np.pi * (nj / lo - ni / ln)
            if abs(delta) < 1e-15:
                integral = lo
            else:
                integral = (np.exp(1j * delta * right) - np.exp(1j * delta * left)) / (1j * delta)
            C[i, j] = integral / np.sqrt(lo * ln)
    return C


def track_transported(lam_grid, N, parity):
    """Track modes after transporting each old Fourier basis into the new interval."""
    records = []
    previous = None
    for step, lam in enumerate(lam_grid):
        vals, vecs, A = block(lam, N, parity)
        if previous is None:
            branch = np.arange(len(vals)); overlaps = np.ones(len(vals))
        else:
            old_lam, old_vals, old_vecs = previous
            C = mode_transport(old_lam, lam, N)
            old_full = C @ old_vecs
            overlap = np.abs(old_full.conj().T @ vecs)
            old_rows, new_cols = linear_sum_assignment(-overlap)
            branch = np.full(len(vals), -1, dtype=int)
            overlaps = np.zeros(len(vals))
            for old_row, new_col in zip(old_rows, new_cols):
                branch[new_col] = old_row
                overlaps[new_col] = overlap[old_row, new_col]
        for mode, value in enumerate(vals):
            records.append({"step": step, "lambda": float(lam), "N": N,
                            "parity": parity, "branch": int(branch[mode]),
                            "eigenvalue": float(value), "overlap": float(overlaps[mode])})
        previous = (lam, vals, vecs)
    return records


def track(lam_grid, N, parity, output=None):
    previous = None
    rows = []
    for step, lam in enumerate(lam_grid):
        vals, vecs, A = block(lam, N, parity)
        gaps = np.minimum(np.r_[np.inf, np.diff(vals)], np.r_[np.diff(vals), np.inf])
        cond = np.linalg.cond(A) if A.shape[0] else np.nan
        if previous is None:
            branch = np.arange(len(vals))
            overlaps = np.ones(len(vals))
        else:
            branch, overlaps = match(previous, (vals, vecs))
        for mode, value in enumerate(vals):
            rows.append({
                "step": step, "lambda": float(lam), "N": N,
                "parity": parity, "branch": int(branch[mode]),
                "eigenvalue": float(value), "gap": float(gaps[mode]),
                "overlap": float(overlaps[mode]), "condition": float(cond),
                "precision": "float64",
                "escalate": bool(gaps[mode] < 1e-10 or overlaps[mode] < 0.9),
            })
        previous = (vals, vecs)
    if output is not None:
        Path(output).write_text(json.dumps(rows, indent=2), encoding="utf-8")
        with open(Path(output).with_suffix(".csv"), "w", newline="", encoding="utf-8") as f:
            writer = csv.DictWriter(f, fieldnames=rows[0].keys())
            writer.writeheader(); writer.writerows(rows)
    return rows


def track_truncations(lam, N_grid, parity, output=None):
    """Track the same parity modes while the Fourier cutoff N increases.

    Eigenvectors at cutoff N are embedded into the next full index space by
    matching their integer labels.  This prevents newly admitted modes from
    silently reordering the old branches.
    """
    previous = None
    rows = []
    for step, N in enumerate(N_grid):
        vals, vecs, A = block(lam, N, parity)
        gaps = np.minimum(np.r_[np.inf, np.diff(vals)], np.r_[np.diff(vals), np.inf])
        cond = np.linalg.cond(A) if A.shape[0] else np.nan
        if previous is None:
            branch = np.arange(len(vals)); overlaps = np.ones(len(vals))
        else:
            old_vals, old_vecs, old_N = previous
            embedded = np.zeros((2 * N + 1, old_vecs.shape[1]))
            old_labels = list(range(-old_N, old_N + 1))
            new_labels = list(range(-N, N + 1))
            for i, label in enumerate(old_labels):
                embedded[new_labels.index(label), :] = old_vecs[i, :]
            overlap = np.abs(embedded.T @ vecs)
            old_rows, new_cols = linear_sum_assignment(-overlap)
            branch = np.full(len(vals), -1, dtype=int)
            mode_overlaps = np.zeros(len(vals))
            for old_row, new_col in zip(old_rows, new_cols):
                branch[new_col] = old_row
                mode_overlaps[new_col] = overlap[old_row, new_col]
            next_branch = len(old_vals)
            for new_col in range(len(vals)):
                if branch[new_col] < 0:
                    branch[new_col] = next_branch
                    next_branch += 1
            overlaps = mode_overlaps
        for mode, value in enumerate(vals):
            rows.append({
                "step": step, "lambda": float(lam), "N": N,
                "parity": parity, "branch": int(branch[mode]),
                "eigenvalue": float(value), "gap": float(gaps[mode]),
                "overlap": float(overlaps[mode]), "condition": float(cond),
                "precision": "float64",
                "escalate": bool(gaps[mode] < 1e-10 or (overlaps[mode] != 0 and overlaps[mode] < 0.9)),
            })
        previous = (vals, vecs, N)
    if output is not None:
        Path(output).write_text(json.dumps(rows, indent=2), encoding="utf-8")
    return rows


if __name__ == "__main__":
    out = Path(sys.argv[1]) if len(sys.argv) > 1 else None
    grid = np.linspace(2.0, 4.0, 9)
    rows = track(grid, 8, 1, out)
    flagged = sum(row["escalate"] for row in rows)
    print(f"rows={len(rows)} output={out or '<stdout-only>'} flagged_for_precision={flagged}")
    for row in rows:
        if row["step"] in (0, len(grid) - 1) and row["branch"] < 5:
            print(row)
    nrows = track_truncations(2.0, [2, 4, 6, 8, 10, 12], 1)
    print("N-continuation:")
    for row in nrows:
        if row["branch"] < 3:
            print(row)
