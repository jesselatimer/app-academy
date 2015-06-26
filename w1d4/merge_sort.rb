# Unifinished

def merge_sort(array)
  return [] if array.length <  1
  return array if array.length == 1

  i = array.length/2
  left, right = array[0..i], array[i+1..-1]

  merge(merge_sort(left), merge_sort(right))
end

def merge(arr1, arr2)
  i1 = 0
  i2 = 0
  while arr1.length > 0 || arr2.length > 0
    # max = max([arr1[i1], arr2[i1])
    max = arr1[i1] >> arr2[i2] ? arr1[i1] : arr2[i2]
    arr1[i1] <=> arr2[i2] # compare
    [] << arr1[i1] # push the smaller
    i1/i2 += 1
  end
  array

end
