require_relative 'tile'


class Board

  attr_accessor :grid, :size

  def [](pos)
    row, col = pos[0], pos[1]
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos[0], pos[1]
    @grid[row][col] = val
  end

  def initialize(size=9)
    @size = size
    @grid = Array.new(size) { Array.new(size) { Tile.new(size) } }
  end

  def set_first(pos)
    self[pos].first = true
  end

  def bombify(bombs_wanted = size) #CHANGE THIS!!
    bombs_placed = 0
    until bombs_placed == bombs_wanted
      pos = [rand(size), rand(size)]
      next if self[pos].bomb? || self[pos].first
      self[pos].set_bomb
      bombs_placed += 1
    end
  end

  def display
    system("clear")
    puts "   0 1 2 3 4 5 6 7 8"
    grid.each_with_index do |row, i|
      print "#{i}  "
      row.each do |tile|
        if tile.revealed? && tile.bomb?
          print "B "
        elsif tile.revealed?
          tile.value == 0 ? print("  ") : print("#{tile.value} ")
        elsif tile.flagged?
          print "\u2691".encode('utf-8') + " "
        else
          print "\u25A0".encode('utf-8') + " "
        end
      end
      puts
    end
  end

  def game_over
    system("clear")
    puts "   0 1 2 3 4 5 6 7 8"
    grid.each_with_index do |row, i|
      print "#{i}  "
      row.each do |tile|
        if tile.bomb?
          print "B "
        elsif !tile.bomb?
          tile.value == 0 ? print("  ") : print("#{tile.value} ")
        end
      end
      puts
    end
    puts "Game over!"
  end

  def valid?(pos)
    return false unless pos.is_a?(Array) && pos.count == 2
    pos.each do |coord|
      return false unless coord.between?(0, size-1)
    end
    true
  end

  def find_neighbors
    @grid.each_with_index do |row, i|
      row.each_with_index do |tile, j|
        tile.find_neighbors(@grid, i, j)
      end
    end
  end

  def set_values
    @grid.each do |row|
      row.each do |tile|
        tile.set_value
      end
    end
  end

  def reveal(pos)
    self[pos].reveal
    return if self[pos].value > 0
    self[pos].neighbors.each do |neighbor|
      next if neighbor.flagged? || neighbor.revealed?
      if neighbor.value == 0 && !neighbor.bomb?
        reveal(neighbor.position)
      elsif neighbor.value > 0 && !neighbor.bomb?
        neighbor.reveal
      end
    end
  end

  def over?(pos)
    won? || lost?(pos)
  end

  def won?
    grid.each do |row|
      row.each do |tile|
        # return false if tile.bomb? && !tile.flagged?
        return false if !tile.bomb? && !tile.revealed?
      end
    end
    puts "won"
    true
  end

  def lost?(pos)
    if self[pos].bomb?
      return true
      puts "lost"
    end
    false
  end

  def flag(pos)
    self[pos].flag unless self[pos].revealed?
  end

end
