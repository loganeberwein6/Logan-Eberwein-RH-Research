# Pattern Recognition Pass — Failure Map

Date: 2026-09-10

This document separates established criteria, partial constructions, numerical
evidence, and proof claims. A criterion equivalent to RH is not itself a proof
of RH; the missing direction is always the verification of the criterion for
the classical zeta function.

## Executive diagnosis

Across the approaches below, the same structural gap recurs:

```text
candidate quantity/operator
        -> exact identification with the completed zeta function
        -> global positivity/self-adjointness/trace identity
        -> control of every nontrivial zero
```

Most failed attempts establish the first item only approximately, for a
restricted test class, for a finite truncation, or for a nearby function. The
last two arrows require global control: exact arithmetic coefficients,
domains and convergence, analytic continuation, and a theorem that excludes
off-line zeros rather than merely reproducing observed critical-line data.

## Q1–Q3 failure table

| APPROACH | QUANTITY | FAILURE POINT | MISSING PROPERTY |
|---|---|---|---|
| de Branges (2004 and later variants) | A de Branges/Hilbert-space positivity condition intended to imply RH through a space of entire functions and an associated kernel/operator | The proposed sufficient positivity/space conditions were not established for the zeta function; the published/posted arguments changed formulations and did not provide an accepted proof of the decisive zeta-specific implication | A rigorously constructed de Branges space whose positivity is verified for the actual completed zeta function, with all domain and kernel inequalities proved |
| Connes spectral/adelic program | A trace formula on the adele class space; zeros interpreted as an absorption spectrum or resonances | The trace-formula framework gives a spectral interpretation and conditional equivalences, but the required global positivity/trace-class determinant identification remains open; critical zeros can be represented without excluding noncritical resonances | An exact self-adjoint spectral realization or an independently proved Weil-positivity theorem for the full test-function class, including convergence and determinant identification |
| Berry–Keating (H=xp) program | A self-adjoint quantization of the classical Hamiltonian (xp), with eigenvalues corresponding to zero ordinates | Self-adjoint realizations of the natural scaling operator exist, but their spectra do not automatically equal the zeta zero ordinates; boundary conditions, regularization, and arithmetic trace data are not fixed by (xp) alone | One canonical self-adjoint operator with spectrum exactly equal to the nontrivial zero ordinates and a trace/determinant formula recovering the completed zeta function |
| Bombieri/Weil positivity | The Weil quadratic functional on convolution squares (f * \tilde f) | Weil positivity is an equivalence: RH implies positivity and positivity implies RH. The obstruction is proving positivity for the full unrestricted test class on the arithmetic side. Positivity for finite windows or selected functions is insufficient | Full positive semidefiniteness of the classical Weil functional for every admissible test function, with exact prime-power/archimedean terms |
| Li-coefficient / criterion route | Li coefficients or equivalent sums over zeros, often converted by the explicit formula to arithmetic expressions | The criterion is equivalent to RH, but proving all coefficient inequalities is essentially as difficult as RH; finite coefficient checks and asymptotics do not imply every coefficient is nonnegative | A uniform all-(n) positivity theorem for the exact zeta coefficients |
| Selberg trace / automorphic analogy | A geometric self-adjoint Laplacian whose spectrum produces zero ordinates | The analogy works for function-field and Selberg-zeta settings because a genuine geometric operator exists, but no corresponding classical-zeta geometry with the required trace formula has been constructed | A characteristic-zero geometric object whose self-adjoint cohomological operator has the zeta zeros as spectrum |
| Direct explicit-formula growth | A summatory prime/von Mangoldt quantity or an error term whose growth detects the rightmost zero | Contour shifting and residue heuristics identify possible terms, but the error term, analytic continuation, and noncancellation of oscillatory contributions are not controlled strongly enough to force a contradiction | A rigorous Perron/contour formula with an error smaller than the off-line contribution and a noncancellation/lower-bound theorem |
| Arithmetic positivity / matrix signatures | A finite Rees/SR matrix signature, positive direction, or signed quadratic form | Finite positivity and inertia certificates do not identify the form with the Weil functional or ζ; raw balance fails at counterexamples such as (X=7), and the available trivial envelope is too large for the proposed pole contradiction | An exact limiting map from the SR forms to the full Weil functional or zeta explicit formula, preserving positivity and detecting every off-line zero |
| Berry–Keating/Connes numerical spectral models | Finite matrices whose eigenvalues approximate low zero ordinates | Numerical agreement is compatible with many nonunique finite models and does not prove exact spectrum, self-adjoint domain, or zeta determinant equality | A theorem of exact spectral correspondence, not finite numerical interpolation |

### de Branges: precise caution

The historical record is not a single static manuscript: the 2004 claim was
followed by substantial reformulations. The safe mathematical diagnosis is
therefore not “one universally agreed typo,” but that the decisive
zeta-specific positivity and implication were never established in an
accepted proof. The de Branges machinery is real mathematics; the missing
step is applying its sufficient condition to the actual zeta function.

### Connes and Berry–Keating

Connes’s work supplies a sophisticated spectral interpretation and trace-formula
framework, not a completed exclusion of all resonances. Berry–Keating supplies
the correct semiclassical counting heuristic, but (xp) is not enough to
determine the arithmetic boundary conditions or an exact zeta determinant.

### Watkins/common failure structure

Watkins’s catalog of purported proofs is useful as a taxonomy rather than as a
single theorem. The repeated errors are:

1. using an identity outside its convergence or analytic-continuation domain;
2. replacing conditional convergence by absolute convergence;
3. proving only a necessary condition while claiming an equivalence;
4. checking a finite truncation and inferring an infinite statement;
5. constructing an operator with a plausible spectrum but not proving exact
   equality with the zeros of the completed zeta function;
6. treating numerical or asymptotic cancellation as uniform noncancellation.

These are the same failure classes found in `FailureInvariants.md` and the
Stage 36 audit.

## Property cross-map

| PROPERTY | APPROACHES THAT HAVE IT | APPROACHES THAT LACK IT |
|---|---|---|
| Exact criterion equivalent to RH | Weil, Li, de Branges target conditions, Connes positivity target | SR finite signatures, Berry–Keating finite models |
| Finite positivity or positive directions | Finite-window Weil computations, SR all-ones Rayleigh direction, finite matrix certificates | Full classical Weil form, global SR limit |
| Exact arithmetic coefficients | Classical explicit formula, von Mangoldt formalism | Numerical operators, generic Hilbert-space constructions, current SR convolution surrogate |
| Analytic continuation and functional equation | Classical completed ζ theory | Current finite SR L-series, finite cutoff objects |
| Self-adjoint operator | Selberg/function-field analogues; finite Hermitian matrices; proposed Connes constructions | Operator with exact classical-zeta spectrum; Berry–Keating arithmetic realization |
| Exact trace/determinant identity | Classical explicit formula in its established domain; Selberg analogues | Current SR form, finite spectral fits, incomplete operator proposals |
| Global positivity for every admissible test function | Equivalent target in Weil’s criterion; partial finite-window results | Classical zeta itself, SR finite certificates, restricted numerical tests |
| Uniform error bound below an off-line residue | None of the current approaches | All current SR pole-contradiction routes and most direct-growth attempts |
| Noncancellation of oscillatory zero terms | Not supplied by numerical evidence or generic residue calculus | Current SR growth conjectures and direct explicit-formula attempts |
| Exact identification with the classical completed ζ | Classical definitions and explicit formula components separately | de Branges application, Connes determinant program, Berry–Keating, SR program |

## What no approach currently supplies

The most important common missing object is:

> An exact, globally defined, positivity-preserving spectral/arithmetic
> correspondence for the completed classical zeta function, with enough
> convergence and error control to turn an off-line zero into a contradiction.

This can be decomposed into four required properties:

1. **Identification:** the constructed object must equal the classical
   completed zeta function or its exact Weil functional, not merely share a
   finite spectrum or asymptotic shape.
2. **Global control:** the identity must hold on the full domain needed for
   continuation and contour shifting, not only in `Re(s) > 1` or on a finite
   cutoff.
3. **Positivity/self-adjointness:** the relevant form/operator must have the
   sign or reality property for the entire admissible test space.
4. **Zero detection:** off-line zeros must produce a term that cannot be
   canceled by the remainder; this requires a quantitative error bound or a
   suitable averaged lower bound.

## Can the current SR results supply it?

No.

The strongest available SR construction is:

```text
finite support cutoff
→ divisor-antidiagonal convolution
→ fixed-cutoff L-series summability
→ coefficient vanishing for k ≥ X²
→ finite truncation identity (locally repaired, full file not clean)
```

This supplies finite algebra, support control, and some convergence. It does
not supply:

- analytic continuation of the SR L-series to the critical strip;
- an exact identity with the classical zeta or with `ζ'/ζ`;
- a Perron formula for the SR quadratic form;
- a contour shift with a controlled remainder;
- noncancellation of the oscillatory terms;
- positivity of the full Weil test-function space;
- an exact self-adjoint operator with the zeta zeros as its spectrum.

The SR counterexample at `X=6, k=4` also proves that the signed SR coefficient
is not simply the von Mangoldt coefficient. Thus the existing convolution
bridge cannot be relabeled as the classical explicit formula without a new
coefficient-identification theorem.

The new mathematics required is therefore an explicit construction of a
limiting transform (T) satisfying, for an admissible test function (f),

```text
lim_X SR_X(f) = Weil(f * f̃)
```

with a proved topology, a uniform domination theorem, and a sign-preserving
identification of every prime-power and archimedean term. Only after that
could the SR positivity results contribute to RH.

## Recent literature scan, 2020–2026

### Results that materially improve a missing property

**Connes–Consani (2020).** Their archimedean-place work gives a conceptual
positivity framework and relates the Weil distribution to Sonin traces,
prolate spheroidal functions, and Hermitian Toeplitz matrices. It advances the
positivity architecture, but it does not prove the full classical-zeta Weil
positivity statement. [Connes–Consani, *Weil positivity and Trace formula, the archimedean place*](https://arxiv.org/abs/2006.13771)

**Connes–Consani–Moscovici (2025).** *Zeta Spectral Triples* constructs
self-adjoint rank-one perturbations whose finite spectra numerically match low
zeta zeros. This supplies a promising finite self-adjoint model, but the
abstract describes a strategy and numerical agreement, not an exact global
spectral identification proving RH. [Zeta Spectral Triples](https://arxiv.org/abs/2511.22755)

**Berry–Keating analysis (2026).** A recent review explicitly states that the
Berry–Keating connection remains unresolved and notes that available
self-adjoint realizations do not reproduce the zeta zeros. This confirms that
self-adjointness alone is not the missing theorem. [On the Berry–Keating
Operator](https://link.springer.com/article/10.1007/s11785-026-01990-w)

**Finite-window Weil positivity (2026).** Recent work reports certified
positive-semidefinite finite-window bounds and extends the support range of
known positivity results. This supplies stronger finite positivity, not global
positivity for every test function. [Weil positivity in compact windows](https://arxiv.org/abs/2608.24827)

**Arithmetic Hodge theory.** The 2024 paper located by the requested search
concerns poles of Archimedean zeta functions associated to singularities; it
does not provide a characteristic-zero spectral realization of the Riemann
zeta zeros. [Archimedean zeta functions, singularities, and Hodge theory](https://arxiv.org/abs/2412.07849)

### Recent claims not usable as established mathematics

The search also found 2024–2026 repositories, working papers, and preprints
claiming complete spectral proofs. They do not provide peer-reviewed,
independently verified results that can be imported into the SR program. In
particular, a claimed operator or numerical fit is not evidence of the four
properties identified above unless exact correspondence, domain control, and
the global trace identity are proved.

## Final audit verdict

The external literature does not currently supply the missing object needed by
the SR program. It supplies partial ingredients:

```text
finite positivity                 yes, increasingly strong
spectral heuristics               yes
finite self-adjoint models        yes
classical explicit formula        yes, in its established setting
full exact zeta spectral object   no
full Weil positivity for ζ        no
SR-to-Weil identification         no
uniform pole-vs-error contradiction no
```

Consequently, combining the current SR results with the recent literature does
not close RH. The next mathematically meaningful target is not another finite
signature certificate; it is a precise limiting theorem identifying the SR
cutoff form with the classical Weil functional, or a proof that such an
identification is impossible for the current SR coefficients.

## Repository evidence used

- `Research/KilledApproaches.md`
- `Research/FailureInvariants.md`
- `Research/Conjectures.md`
- `Research/Stage36_CompletionAudit.md`
- `Research/Stage36_DeclarationMap.md`
- `Research/Stage36_ExplicitFormula.md`
- `SR_CompletionAudit.md`
- `SR_Stage27.lean` through `SR_Stage36.lean`

## Completion-record coverage audit

The repository does not contain one separate completion file for every stage.
The authoritative consolidated record is `SR_CompletionAudit.md`; the later
stage-specific records are listed below. This is the coverage used for the
failure scan.

| RECORD | SCOPE READ | RELEVANT FAILURE/STATUS RESULT |
|---|---|---|
| `SR_CompletionAudit.md` | Stages 0–23, including stages 8–23 appendices | Finite foundations and certificates exist; universal signature, analytic bridge, and RH remain open |
| `Research/DefinitionFixes.md` | Stages 25–26 | Definitions and B3 denominator dependencies repaired or isolated; no RH implication |
| `Research/NewEquivalences.md` | Stages 26–35 | W-SR, Abel, Rees-growth, exact-definition, and off-diagonal proposals separated into open claims and failures |
| `Research/Stage29_Counterexample.md` | Stage 29 | Zero-frequency obstruction; prior growth baseline cannot be trusted |
| `Research/Stage29_SolutionMap.md` | Stage 29 | Candidate routes mapped; exact cancellation and asymptotics missing |
| `Research/Stage33_DiagonalBound.md` | Stage 33 | Diagonal estimate certified; it does not control the full form |
| `Research/Stage34_OffDiagonal.md` | Stage 34 | Proposed pointwise off-diagonal route fails; only coarse bounds survive |
| `Research/Stage35_OffDiagonal.md` | Stage 35 | Correct absolute-value structure identified; cancellation remains unproved |
| `Research/Stage36_CompletionAudit.md` | Stage 36 | Finite divisor/Mellin/parameter work verified; continuation, Perron, residues, and RH equivalence open |
| `Research/Stage36_DeclarationMap.md` | Stage 36 | Declaration-by-declaration distinction between proved endpoints and conjectural interfaces |
| `Research/Stage36_ExplicitFormula.md` | Stages 36–37 | Explicit-formula route, build history, coefficient bridge, and pole-mechanism correction |
| `Research/Stage36_X210_Attempt.md` | Stage 36 | Finite X=210 benchmark does not establish an asymptotic theorem |
| `Research/KilledApproaches.md` | Stages 29–35 | Enumerated false baselines, invalid row bounds, stale exponent fits, and support counterexamples |
| `Research/FailureInvariants.md` | Stages 27–37 | Reusable obstructions: sign mismatch, convergence/domain errors, source/build compatibility, and weak envelopes |
| `Research/Conjectures.md` | Stages 16–37 | Open claims register; none is promoted as proof input |

The external Watkins reference used for the common-error taxonomy is Matthew
Watkins’s public collection of RH attempts and the accompanying survey links;
the taxonomy is treated as historical context, not as a proof authority:
[Watkins collection](https://empslocal.ex.ac.uk/people/staff/mrwatkin/zeta/).
