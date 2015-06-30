require "byebug"

#Problem 1: You have array of integers. Write a recursive solution to find the
#sum of the integers.

def sum_recur(array)
  return array[0] if array.length == 1
  array[0] + sum_recur(array.drop(1))
end

# p sum_recur([1, 3, 5, 7, 9, 2, 4, 6, 8]) # 45

#Problem 2: You have array of integers. Write a recursive solution to determine
#whether or not the array contains a specific value.

def includes?(array, target)
  return true if array[0] == target
  return false if array[0] != target && array.length <= 1

  includes?(array.drop(1), target)
end

# p includes?([1, 3, 5, 7, 9, 2, 4, 6, 8], 9) #true

# Problem 3: You have an unsorted array of integers. Write a recursive solution
# to count the number of occurrences of a specific value.

def num_occur(array, target)
  array[0] == target ? val = 1 : val = 0
  return val if array.length == 1

  val + num_occur(array.drop(1), target)
end

# p num_occur([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6], 5) # 4

# Problem 4: You have array of integers. Write a recursive solution to determine
# whether or not two adjacent elements of the array add to 12.

def add_to_twelve?(array)
  return false if array.length < 2
  return true if array[0] + array[1] == 12

  add_to_twelve?(array.drop(1))
end

# p add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 7, 6, 5, 6]) # false
# p add_to_twelve?([1, 1, 2, 3, 4, 5, 5, 4, 5, 6, 6, 5, 6]) # true

# Problem 5: You have array of integers. Write a recursive solution to determine
# if the array is sorted.

def sorted?(array)
  return true if array.length < 2
  return false if array[0] > array[1]
  sorted?(array.drop(1))
end

# p sorted?([1, 2, 3, 4, 4, 5, 6, 7]) # true

# Problem 6: Write a recursive function to reverse a string. Don't use any
# built-in #reverse methods!

def reverse(string)
  return string if string.length == 1
  reverse(string[1..-1]) + string[0]
end

# p reverse("kongfuzi")  # "izufgnok"

def fibonacci(n)
  return [1, 1].take(n) if n < 3
  nums = fibonacci(n - 1)
  nums << nums[-1] + nums[-2]
end

# p fibonacci(6) # [1, 1, 2, 3, 5, 8]


def bubble_sort(array)
  return array if array.length < 2
  (0...array.count - 1).each do |i|
    if array[i] > array[i + 1]
      array[i], array[i + 1] = array[i + 1], array[i]
    end
  end
  bubble_sort(array[0...-1]) + [array.last]
end

# p bubble_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def quick_sort(array)
end

# p quick_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def merge_sort(array)
  return array if array.length == 1
  l, r = array.take(array.count / 2), array.drop(array.count / 2)
  merge(merge_sort(l), merge_sort(r))
end

def merge(left, right)
  sorted = []
  until left.empty? || right.empty?
    if left[0] < right[0]
      sorted << left.shift
    else
      sorted << right.shift
    end
  end
  sorted + left + right
end

# p merge_sort([3,5,2,7,2,1]) # [1, 2, 2, 3, 5, 7]

def bsearch(array, target)
end

p bsearch([1, 2, 3], 1) # => 0
p bsearch([2, 3, 4, 5], 3) # => 1
p bsearch([2, 4, 6, 8, 10], 6) # => 2
p bsearch([1, 3, 4, 5, 9], 5) # => 3
p bsearch([1, 2, 3, 4, 5, 6], 6) # => 5
p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
