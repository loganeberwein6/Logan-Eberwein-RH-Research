# Cycle 44: Rees quotient-core versus abstract threshold coercivity

## Finite construction

For each quotient value `q=(X-1)//m`, choose the smallest support
representative `r_q`. Form the canonical quotient core

`R_X[q,q'] = Rees_sign(r_q,r_q')`.

Compare it with the abstract threshold matrix

`T_X[q,q']=-1` iff `q'<=q`, otherwise `+1`.

## Raw output

```text
X=6:   k=2,  max|R-T|=2,  sym-eigen range [-1.4142, 1.4142], det(R)=-2
X=10:  k=4,  max|R-T|=2,  sym-eigen range [-2.6131, 2.6131], det(R)=8
X=20:  k=6,  max|R-T|=2,  sym-eigen range [-3.8637, 3.8637], det(R)=-32
X=30:  k=8,  max|R-T|=2,  sym-eigen range [-5.1258, 5.1258], det(R)=128
X=50:  k=12, max|R-T|=2,  sym-eigen range [-7.6613, 7.6613], det(R)=2048
X=100: k=17, max|R-T|=2, sym-eigen range [-10.8380,10.8380], det(R)=65536
```

The maximum entry discrepancy is already `2` at every tested cutoff. More
importantly, the symmetric part of the canonical quotient core is indefinite,
with eigenvalues symmetric around zero, whereas the abstract threshold matrix
has symmetric part exactly `-I`.

## Structural diagnosis

The row quotient classification and rank theorem do not imply coercivity after
compression. The quotient labels describe equal rows, but the canonical column
representatives are integer support values, not quotient labels. Replacing the
support representatives by quotient indices changes the comparison relation.

Therefore the abstract threshold form cannot be transferred by the naive
representative compression. A weighted quotient basis or a nontrivial
congruence would be required; such a congruence must be constructed explicitly
and its inertia checked.

## Verdict

**Naive quotient compression is dead for P3.** This closes the finite target
posed in Cycle 43 in its simplest form and explains why the rank theorem alone
does not supply the SR coercive operator.
