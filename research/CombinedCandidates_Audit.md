# Post-candidate combination audit

## Cycle 5: Mayer operator with SR regularization

The proposed hybrid was

\[
 (L^{SR}_s f)(x)=\sum_{n\geq1}(x+n)^{-2s}
 R(\lfloor x\rfloor,n)f((x+n)^{-1}),
\]

where `R(a,n)` is intended to be the SR/Rees sign.  As written this does not
define a new operator on the Mayer space.  The SR sign is only defined for
positive integer arguments in the finite construction (in particular its
first support coordinate starts at 2), whereas `floor(x)=0` on `(0,1)` and
`floor(x)=1` on `[1,2)`.  Thus the kernel is undefined on the basic Mayer
domain unless an extension `R(0,n)` and `R(1,n)` is chosen.

Even after choosing an extension, a finite determinant requires all of the
following additional choices: a grid or Galerkin basis, a measure and
boundary conditions, a truncation of the n-sum, and a normalization relating
the finite matrix to the nuclear Mayer operator.  These choices are not
equivalent: changing the values on the first two floor cells changes a
finite-rank part of the operator and can change its Fredholm determinant.

The only canonical choice that preserves the original Mayer kernel is
`R=1`; that removes the SR regularization and returns the already-known Mayer
operator.  The canonical extension `R=-1` for the undefined cells is likewise
an arbitrary finite-rank perturbation, not an arithmetic derivation.

**Verdict:** UNDEFINED as a mathematical candidate.  No numerical claim
about zeta-zero convergence is justified until the missing operator data are
specified.  This is stronger than a failed numerical fit: the expression is
not a well-typed operator on its proposed domain.

## Cycle 6: SR operator with Gauss-map iteration

The ordinary Gauss map is `G(x)={1/x}`.  On the integer SR support,

\[
 G(m)=\{1/m\}=0 \qquad (m\in\{2,3,\ldots\}).
\]

Consequently every integer support point has the identical orbit
`m -> 0 -> 0 -> ...`.  The iterates contain no continued-fraction digits and
therefore cannot supply the multiplicative information that makes the Mayer
operator work.  Any transfer matrix formed from these literal iterates has
rank at most one in its orbit-coordinate channel (before arbitrary weights
or extra state variables are added).

The non-degenerate Gauss dynamics lives on a real interval, with points such
as `1/(m+x)`, not on the integer support itself.  Replacing an integer `m` by
`m+x` therefore changes the state space and is precisely a new Mayer-type
construction, not an SR operator with Gauss iteration.  Adding prime or
factorization labels would also be new data rather than a consequence of the
SR boundary matrix.

**Verdict:** DEAD for the literal integer-support construction by exact orbit
collapse.  A continuous continued-fraction lift remains an open new class,
but it must be defined independently and audited from scratch; it cannot be
claimed to inherit SR positivity or the SR boundary count.

## Property summary

| candidate | P1 | P2 | P3 | P4 | P5 | P6 | verdict |
|---|---|---|---|---|---|---|---|
| Mayer–SR as stated | ? | ? | ? | inherited only from Mayer if defined | partial | ? | undefined |
| integer SR + Gauss iteration | no | no | inherited finite SR only | no | yes | no | dead |

No candidate in these two cycles meets the numerical success criterion, so the
next mathematically meaningful step is to define a genuinely new continuous
continued-fraction/arithmetic operator, including its Banach space and exact
determinant identity, before running numerical scans.
