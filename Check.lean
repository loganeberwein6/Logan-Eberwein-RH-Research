import SR_Stage36
#check Finset.sum_range_sub
#check Finset.sum_range_sub'
#check Finset.sum_Ico_eq_sub
#check Finset.sum_list
#check List.sum_toFinset
#check Finset.sum_coe_sort
#check List.toFinset_sum
#check List.Nodup.map
#check List.nodup_range
#check Finset.sum_fiberwise
#check Finset.sum_fiberwise_of_maps_to
#check Finset.sum_bij
#check @Finset.sum_fiberwise
#check @Finset.sum_fiberwise_of_maps_to
#check Finset.sum_bij
#check Fin.ofNat'
#check Finset.sum_product
#check Finset.sum_filter
#check Fin.castIso
#check Fintype.sum_equiv

example (X : Nat) : Fin (X - 2) ≃ Fin (completeSupport X).length := by
  let h : X - 2 = (completeSupport X).length := (completeSupport_length X).symm
  exact Fin.castIso h
#check Finset.sum_range_by_parts
