# Stage 36: X=210 benchmark attempt

The existing Stage 35 invariant records
`allOnesEntrySum 210 = 41798`. Stage 36 also attempted to certify the
corresponding signed-divisor sum:

```lean
∑ k ∈ Finset.range (210 ^ 2), SR_signed_divisor_coefficient 210 k = 41798
```

The route used for the successful `X=6` and `X=35` benchmarks was
`native_decide` over the integer-valued finite sum. At `X=210`, the Lean
process remained live for several minutes without producing an exit status;
it was then stopped. The attempted declarations were removed and were not
committed.

This is a computational scaling limitation of the current reduction route,
not a disproof. The verified benchmarks remain `X=6` with value `14` and
`X=35` with value `969`. A future proof should use a structural cardinality
formula or a more efficient certified computation rather than expanding the
44,100-pair computation through `native_decide`.
