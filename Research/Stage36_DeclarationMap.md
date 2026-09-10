# Stage 36 declaration map

This is an inventory of the current checked Stage 36 interface. The source
of truth is `SR_Stage36.lean`; this map distinguishes finite proofs from
analytic claims that remain conjectural.

## Definitions

- `SR_divisorMultiplicity`, `SR_signed_divisor_coefficient`: finite divisor
  fibers and signed coefficients.
- `SR_signed_dirichlet_polynomial`: finite complex Dirichlet polynomial.
- `SR_complex_parameter`: parameter `-(beta - 1/2) - gamma*I`.
- `SR_product_channel_as_divisor_sum`, `SR_product_channel_fiber_sum`:
  finite product/divisor representations.
- `SR_product_channel_complex`, `SR_product_channel_complex_divisor`:
  complex product-channel interfaces.

## Proven finite algebra

- Coefficient/fiber identities: `sr36_filtered_const_sum`,
  `sr36_signed_coefficient_as_fiber_sum`,
  `sr36_signed_coefficient_complex_as_fiber_sum`.
- Polynomial reorganizations: `sr36_signed_polynomial_as_fiber_sum`,
  `sr36_signed_polynomial_as_product_sum`,
  `sr36_signed_polynomial_parameter_product_sum`.
- Divisor-channel identities: `SR_product_channel_divisor_as_product_sum`,
  `SR_product_channel_divisor_form`, `SR_product_channel_fiber_identity`.
- Support and edge cleanup: `sr36_support_pos`, `sr36_product_pos`,
  `sr36_zero_divisor_coefficient`, `sr36_small_divisor_coefficient`,
  `sr36_signed_polynomial_zero_term_removed`,
  `sr36_signed_polynomial_range_four`.
- Complex bridge: `sr36_parameter_exponent`,
  `sr36_log_product_additive`, `sr36_parameter_product_kernel_split`,
  `sr36_product_kernel_matches_pair_phase`,
  `sr36_parameter_kernel_matches_pair_phase`,
  `sr36_signed_polynomial_parameter_complex`.
- Real bridge: `sr36_complex_product_re`,
  `sr36_signed_polynomial_parameter_re_from_complex`,
  `sr36_channel_product_at_neutral_parameter`.

## Exact finite benchmarks

- `sr36_divisorMultiplicity_X6_4`: the fiber at product `4` has cardinality
  `1`.
- `sr36_signed_coefficient_sum_X6`: the complete signed coefficient sum is
  `14`.
- `sr36_signed_coefficient_sum_matches_allOnes_X6`: this equals the Stage 35
  `allOnesEntrySum 6` invariant.
- `sr36_channel_product_neutral_X6`: the neutral channel at `X = 6` is `14`.
- `SR_gram_entry_X30_5_7`: checked Gram entry.

## Numerical artifacts

`Research/Stage36_numeric_test.py` executes the explicit-formula model,
growth tables, and Gram computations. The observed ratios are unstable;
they are evidence only and do not prove an asymptotic or RH statement.

## Formal conjecture interfaces

The following declarations are intentionally placeholders whose propositions
currently reduce to `True`: explicit formula, logarithmic equidistribution,
critical-line growth, off-line growth, and zeta-nonvanishing growth. Their
certification theorems certify only the placeholder interfaces.

## Open analytic obligations

Infinite convergence, analytic continuation, identification with classical
`riemannZeta`, Perron inversion, contour/residue evaluation, zero detection,
genuine equidistribution, cancellation estimates, infinite spectral theory,
and the RH equivalence remain unproved.
