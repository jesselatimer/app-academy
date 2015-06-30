require 'byebug'

class Tile

  NEIGHBOR_POSITIONS = [
    [-1,-1],
    [-1, 0],
    [-1, 1],
    [0, -1],
    [0,  1],
    [1, -1],
    [1,  0],
    [1,  1]
  ]

  attr_reader :board, :position, :state, :neighbors, :value
  attr_accessor :first

  def initialize(size)
    @state = :hidden
    @first = false
    @bomb = false
    @value = 0
    @board_size = size
  end

  def bomb?
    @bomb
  end

  def set_bomb
    @bomb = true
  end

  def find_neighbors(board, x, y)
    # debugger
    @board = board
    @position = [x, y]
    @neighbors = []
    NEIGHBOR_POSITIONS.each do |coords|
      i, j = (x + coords[0]), (y + coords[1])
      if valid?([i, j])
        @neighbors << board[i][j]
      end
    end
  end

  def set_value
    @neighbors.each do |neighbor|
      @value += 1 if neighbor.bomb?
    end
  end

  def revealed?
    state == :revealed ? true : false
  end

  def reveal
    @state = :revealed
  end

  def flagged?
    state == :flagged ? true : false
  end

  def flag
    @state = :flagged
  end

  def valid?(pos)
    pos.each do |coord|
      return false unless coord.between?(0, @board_size-1)
    end
    true
  end
end
