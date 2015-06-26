class Array

  def my_each(&blk)
    self.length.times do |i|
      blk.call(self[i])
    end

    self
  end

  def my_map(&blk)
    result = []
    self.my_each do |el|
      result << blk.call(el)
    end

    result
  end

  def my_select(&blk)
    result = []
    self.my_each do |el|
      result << el if blk.call(el)
    end

    result
  end

  def my_inject(&blk)
    result = self[0]
    self.drop(1).my_each do |el|
      result = blk.call(result, el)
    end

    result
  end

  def my_sort!(&blk)
    sorted = false

    until sorted
      sorted = true
      (self.length - 1).times do |i|
        j = i + 1
        comp_val = blk.call(self[i], self[j])
        p comp_val
        if comp_val > 0
          self[i], self[j]  = self[j], self[i]
          sorted = false
        end
      end
    end

    self
  end

  def my_sort(&blk)
    self.dup.my_sort!(&blk)
  end

end

def eval_block(*arguments, &blk)
  unless block_given?
    puts "NO BLOCK GIVEN"
  else
    blk.call(*arguments)
  end
end
