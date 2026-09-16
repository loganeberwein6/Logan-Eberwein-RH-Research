# Cycle 60: cohomological boson/fermion cancellation

## Construction

For a finite differential `Q`, define the two Laplacians

`L_0=Q^*Q` and `L_1=QQ^*`.

The nonzero spectra of `L_0` and `L_1` coincide, so their graded determinant
ratio cancels:

`det(zI-L_0)/det(zI-L_1)=1`

after matching zero modes. This is the finite-dimensional model of a
McKean--Singer/cohomological superdeterminant.

## Numerical checks

For `Q=[[1,2],[0,1]]` and `Q=[[1,0],[0,0]]`, at `z=2.3`:

```text
first Q:  det(zI-L0)=-7.51, det(zI-L1)=-7.51, ratio=1
second Q: det(zI-L0)= 2.99, det(zI-L1)= 2.99, ratio=1
```

## Consequence for the RH construction

The cohomological mechanism cancels all paired nonzero modes. A nontrivial
determinant can survive only through unpaired cohomology. To obtain
`1/xi(s)`, the zeta-zero spectrum would therefore have to appear as genuine
cohomology or as an index defect. Constructing that cohomology from SR/prime
arithmetic is exactly the unresolved Hilbert--Polya step; inserting it by
definition is circular.

The mechanism supplies a principled version of Cycle 58's ghost cancellation,
but it does not supply P1/P2 from arithmetic, nor P3 for the surviving
cohomology.

## Verdict

**Exact cancellation framework, no arithmetic zero detector.** A successful
graded construction must produce nontrivial arithmetic cohomology with a
completed functional involution and a Weil positivity theorem; no such complex
has been constructed here.
