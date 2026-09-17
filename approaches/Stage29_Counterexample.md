# Stage 29 diagnostic: zero-frequency obstruction

The currently stated growth proposition quantifies over every real
`gamma`.  The case `gamma = 0` is structurally different: all cosine factors
are `1`, so the total term is a positive square of order `X^(2*beta+1)`,
whereas the interior divisor sum has only the divisor-summatory correction.
Consequently the requested nonzero two-sided law at exponent `3*beta` cannot
be expected uniformly in `gamma`; any theorem of that form must either exclude
zero frequency or include an explicit cancellation hypothesis. Direct exact
counts at `beta = 1/2, gamma = 0` give `Q_30 = 692`, `Q_100 = 9052`,
`Q_500 = 243642`, and `Q_1000 = 985892`; the ratios `Q_X/X^2` are
`0.769, 0.905, 0.975, 0.986`. The Lean finite identities remain valid at
`gamma = 0`, but they do not supply this cancellation. This is a mathematical
scope condition, not a tactic failure.
