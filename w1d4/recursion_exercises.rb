def range(start, finish)
  return [] if finish <= start + 1

  arr = range(start, finish - 1)
  arr << finish - 1
end

def sum_recursive(array)
  return nil if array.empty?
  return array[0] if array.length == 1

  sum = sum_recursive(array[0...-1]) + array.last
end

def sum_iterative(array)
  return nil if array.empty?
  array.inject(&:+)
end

def recursion1(b, n) # Takes 256 recursive steps.
  return 1 if n == 0

  b * recursion1(b, n - 1)
end

def recursion2(b, n) # Takes 8 recursive steps.
  return 1 if n == 0
  return b if n == 1

  if n.even?
    rec = recursion2(b, n/2)
    rec * rec
  else
    rec = recursion2(b, (n-1) / 2)
    b * rec * rec
  end
end

class Array

  def deep_dup
    return self.dup if self.none? { |el| el.is_a?(Array) }

    arr = self.map { |el| el.is_a?(Array) ? el.deep_dup : el }
    arr.dup
  end
end

def fibonacci(n)
  return [] if n == 0
  return [1] if n == 1
  return [1, 1] if n == 2

  arr = fibonacci(n - 1)
  arr << arr[-1] + arr[-2]
end

def binary_sort(array, target)
  return nil if array.length <= 1 && array.first != target

  i = array.length / 2
  return i if array[i] == target

  left, right = array[0...i], array[i+1..-1]

  right_index = binary_sort(right, target)
  left_index = binary_sort(left, target)

  if !right_index.nil?
    return i + right_index + 1
  end
  return left_index
end
