# Cycle 17: scalar completed-xi control

## Construction

Use the completed Riemann xi function

\[
 \xi(s)=\frac12s(s-1)\pi^{-s/2}\Gamma(s/2)\zeta(s)
\]

and define the one-dimensional determinant

\[
 D(s)=\xi(s)/\xi(2).
\]

This is a control experiment, not an independent operator construction.

## Raw output

xi(2)=0.5235987755982989
det(1.5)=0.9716047142108267
det(2.0)=1.0

t=14.1347: |det|=6.639523377792567e-8
t=21.0220: |det|=1.343777742208209e-9
t=25.0109: |det|=1.024991367706089e-10
t=30.4249: |det|=1.099623725368694e-12
t=32.9351: |det|=2.999847568964476e-13

The small nonzero values result from using rounded zero ordinates.

## P1--P6 audit

| property | result | reason |
|---|---|---|
| P1 | yes by definition | the determinant is proportional to xi(s) |
| P2 | no independent derivation | zeta is inserted directly; no operator trace produces Lambda |
| P3 | no RH-relevant mechanism | a scalar identity does not yield a positivity contradiction |
| P4 | yes | xi(1-s)=xi(s) |
| P5 | no in the required sense | construction uses the completed zeta function itself |
| P6 | yes | xi is entire |

## Verdict

**CONTROL ONLY, NOT A SOLUTION.** This is the trivial endpoint showing that
P1, P4, and P6 can be satisfied simultaneously by directly embedding the
target function. It supplies no new proof of the zero locations and violates
the non-circular arithmetic-origin requirement. Any proposed operator whose
determinant is obtained by inserting xi(s) is equivalent to this control and
does not solve the stated problem.
