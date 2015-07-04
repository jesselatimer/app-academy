class Array

  def my_uniq
    self.each_with_object([]) do |element, obj|
      obj << element unless obj.include?(element)
    end
  end

  def two_sums
    result = []
    (length - 1).times do |start_idx|
      (start_idx + 1...length).each do |end_idx|
        result << [start_idx, end_idx] if self[start_idx] + self[end_idx] == 0
      end
    end
    result
  end

  def median
    array = self.sort
    (array[array.length / 2] + array[(array.length - 1) / 2]) / 2
  end

  def my_transpose
    new_matrx = Array.new(self[0].length) { Array.new(self.length) }
    self.length.times do |row_i|
      self[0].length.times do |col_i|
        new_matrx[col_i][row_i] = self[row_i][col_i]
      end
    end

    new_matrx
  end

end
