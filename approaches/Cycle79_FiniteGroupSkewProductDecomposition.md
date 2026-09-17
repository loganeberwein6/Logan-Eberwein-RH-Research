# Cycle 79 — Finite-Group Skew-Product Decomposition

## General construction

Let `L` be a finite Mayer transfer matrix and let a finite group `G` label the auxiliary state. An edge `e:i -> j` carries a group element `c(e)`, acting on the group fiber by the right-regular representation `R(c(e))`. The skew-product operator is

\[
 \widetilde L_{(i,g),(j,h)}=L_{ij}\,1_{h=g c(i,j)}.
\]

For a nonabelian group, the fiber is the regular representation `C[G]`.

## Exact decomposition

The regular representation decomposes as

\[
 \mathbb C[G]\cong\bigoplus_{\pi\in\widehat G}V_\pi^{\oplus\dim V_\pi}.
\]

Therefore the skew-product operator decomposes into twisted transfer operators `L_pi`:

\[
 \det(I-\widetilde L)
 =\prod_{\pi\in\widehat G}\det(I-L_\pi)^{\dim V_\pi}.
\]

The `Z/2` experiment in Cycle 78 is exactly the special case with two one-dimensional representations.

## Consequence

Adding any finite group label does not create a new irreducible determinant mechanism. It produces a finite collection of twisted Mayer sectors. To obtain `1/ζ(s)` or `1/ξ(s)`, one of those sectors would need an independently proved exact arithmetic trace formula. To obtain P3, one would additionally need a positive or Weil-positive form on the sector; finite-group decomposition supplies neither.

If the full skew-product operator is self-adjoint or positivity-preserving, its representation blocks inherit corresponding spectral constraints. If it is not, the group label has not supplied a positivity proof; it has only enlarged the transfer space.

## Relation to the objective

This rules out the class of finite-state Mayer–SR repairs based solely on a finite group cocycle. It does not rule out an infinite adelic or automorphic representation, where the relevant trace formula could be genuinely new. Such a construction would require specifying the representation, Hilbert/nuclear space, arithmetic operator, functional involution, and Weil form—not just adding labels to the finite SR graph.

## P1–P6

| Property | Result |
|---|---|
| P1 | Reduced to twisted-sector determinants; no zeta identity follows. |
| P2 | Group cocycles alter orbit signs but do not intrinsically produce Lambda weights. |
| P3 | Not supplied by representation decomposition. |
| P4 | Not supplied. |
| P5 | Finite arithmetic cocycle can be defined. |
| P6 | Finite-dimensional fiber does not establish nuclear continuation of the base operator. |

## Verdict

**Class obstruction for finite-state extensions.** A successful operator must use an infinite/global arithmetic representation or a new explicit-formula construction, not a finite group-valued SR label.
