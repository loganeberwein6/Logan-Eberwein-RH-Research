# Candidate B cycle — finite Selberg/Euler product

## Operator

For primes (p\le X), define

\[
 Z_X(s)=\prod_{p\le X}\prod_{0\le k\le\lfloor\log_p X\rfloor}
 (1-p^{-(s+k)}).
\]

This is the determinant of the diagonal operator with eigenvalues
`p^(-(s+k))`.

## Raw numerical output

```text
X=20: Z(1.5)=(0.2594910363073625+0j) Z(2.0)=(0.4513022459202846+0j)
  minima: [(0.0, 0.00350902), (0.005, 0.00351039), (0.01, 0.0035145), (0.015, 0.00352137), (0.02, 0.00353099)]
  at zeta gammas: [(14.1347, 20.782749661552717), (21.022, 6.248967240578422), (25.0109, 5.166573715778208), (30.4249, 8.73509273311193), (32.9351, 7.218815478629494)]
X=50: Z(1.5)=(0.24428519991838205+0j) Z(2.0)=(0.4420825805842397+0j)
  minima: [(0.0, 0.00085175), (0.005, 0.00085232), (0.01, 0.00085403), (0.015, 0.00085688), (0.02, 0.00086089)]
  at zeta gammas: [(14.1347, 26.533647772742043), (21.022, 9.751733583207267), (25.0109, 8.348955735275735), (30.4249, 10.785924226693309), (32.9351, 7.988355768128417)]
X=100: Z(1.5)=(0.23821439370455016+0j) Z(2.0)=(0.43883354629869586+0j)
  minima: [(0.0, 0.00023321), (0.005, 0.00023345), (0.01, 0.00023416), (0.015, 0.00023535), (0.02, 0.00023704)]
  at zeta gammas: [(14.1347, 23.991214564676337), (21.022, 10.74684195861097), (25.0109, 7.670516775839283), (30.4249, 11.116140391674218), (32.9351, 8.561713985127357)]
```

## P1–P6 audit

- P1: the infinite Euler product has the correct logarithmic derivative, but
  finite critical-line minima do not track zeta ordinates.
- P2: prime factors and prime powers are represented explicitly.
- P3: no SR positivity or uniform lower bound is present; the operator is
  diagonal Euler data.
- P4: no (s\leftrightarrow1-s) functional-equation symmetry is present.
- P5: arithmetic origin is present.
- P6: in the critical strip, 
  \(\sum_p |p^{-s}|=\sum_p p^{-\operatorname{Re}s}\) diverges for
  \(\operatorname{Re}s\le1\), so the finite operators do not yield a nuclear
  limit on `Re(s)>1/2`.

## Verdict

**DEAD.** Candidate B is the ordinary Euler product in finite disguise. It
supplies arithmetic factors but no new positivity, functional-equation
operator, or nuclear critical-strip construction. Its raw minima are at zero,
not at the zeta zeros.
