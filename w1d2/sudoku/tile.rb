class Tile

  attr_accessor :value
  attr_reader :given

  def initialize(value = 0)
    @value = value
    value == 0 ? @given = false : @given = true
  end

end
