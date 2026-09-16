# CodexRH

This is Logan Eberwein's research project, begun during his freshman year of
high school, exploring arithmetic, finite-matrix, and spectral constructions
related to the Riemann Hypothesis with the help of Lean and AI tools.

## Contents

The repository contains:

- Lean definitions, lemmas, and finite verification results.
- Arithmetic and matrix experiments.
- Research notes, audits, and negative results.
- Explicit records of conjectural steps that are not currently proved.

The repository does not contain a proof of the Riemann Hypothesis.

## Verification

The Lean project is built with Lake. From the repository root, run:

```text
lake build
```

Individual modules can be checked with their Lake target or directly through
the project environment when investigating a particular file.

## Standards

Formal compilation is not treated as evidence for an unstated mathematical
claim. Definitions, finite identities, library applications, conjectures,
and unresolved analytic bridges are kept distinct. Known issues and previous
overstatements are recorded in `CORRECTIONS.md`.

## Repository status

This is a research workspace. Some modules are exploratory or legacy code,
and the directory organization is being cleaned up incrementally. Claims
should be read together with their hypotheses and the surrounding research
notes.
