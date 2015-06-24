def common_subsets(arr1, arr2)
  subsets(arr1) & subsets(arr2)
end

def subsets(arr)
  return [[]] if arr.empty?
  old_subs = subsets(arr[0...-1])
  new_subs = old_subs.map { |subset| subset + arr[-1] }
  old_subs + new_subs
end
