# Cycle 8: functional-equation symmetrization of Mayer

## Construction

Let `L_s` be the Mayer operator from Cycle 7 and form the doubled block
operator

\[
 \mathcal L_s=\begin{pmatrix}L_s&0\\0&L_{1-s}\end{pmatrix}.
\]

This is the minimal direct-sum construction that makes the parameter involution
visible: swapping the two summands identifies `\mathcal L_s` with
`\mathcal L_{1-s}`.  Its determinant is exactly

\[
 D_{\rm sym}(s)=\det(I-\mathcal L_s)
 =\frac{\zeta(2s-1)}{\zeta(2s)}
  \frac{\zeta(1-2s)}{\zeta(2-2s)}.
\]

## Raw values

```text
s=1.5: D_sym(s)=0
s=1.75: D_sym(s)=-0.3978873577297383

t=0.001:  |D_sym|=0.0000009999967101448542
t=14.1347: |D_sym|=4.499214748242026
t=21.022:  |D_sym|=6.691510427355647
t=25.0109: |D_sym|=7.96121673235417
t=30.4249: |D_sym|=9.684546456153213
t=32.9351: |D_sym|=10.48356793245176
```

At `s=2`, the second factor has a pole because `zeta(2-2s)=zeta(-2)=0`,
so the determinant is singular rather than finite.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | no | its zeros are inherited from arguments `2s-1` and `1-2s`, not the required `s=rho` locations |
| P2 | partial | retains Mayer orbit arithmetic, but not the von Mangoldt logarithmic derivative |
| P3 | no | direct sum does not create a bounded-below coercive quadratic form |
| P4 | yes (formal) | the two summands exchange under `s -> 1-s` |
| P5 | yes | integer-indexed Gauss branches |
| P6 | yes where defined | direct sum of nuclear Mayer operators, with meromorphic determinant |

## Verdict

**DEAD.** Functional-equation symmetry alone does not move the spectral
arguments from `2s-1` and `2s` to `s`; it merely duplicates the wrong
determinant.  The critical-line minimum remains at `t=0`, and the values at
the first zeta ordinates grow rather than converge to zero.

This rules out the minimal “symmetrize Mayer” repair.  A successful repair
must alter the transfer weights or orbit coding while preserving nuclearity;
adding a second copy is insufficient.

## General direct-sum obstruction

Any finite direct sum of copies `L_(a_j s+b_j)` has determinant

`product_j zeta(2*a_j*s+2*b_j-1) / zeta(2*a_j*s+2*b_j)`.

Its divisor set is only a finite union of affine images of the divisor sets
already present in the Mayer quotients. Reflection or permutation of finitely
many copies cannot turn this family into a determinant whose zeros are exactly
the points `s=rho` without an additional nontrivial factor identity. Therefore
finite functional-equation symmetrization is structurally insufficient.
