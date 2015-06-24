require_relative 'tile'

class Board

  def self.from_file(filename)
    grid = []
    File.foreach(filename) do |line|
      grid << line.strip.split("")
    end
    grid
  end

  def initialize(grid) # Comes in as a 2d array, whatever factory method used.
    @grid = grid.map do |row|
      row.map { |val| Tile.new(val.to_i) }
    end
  end

  def render
    system "clear"
    puts "\n   0 1 2 | 3 4 5 | 6 7 8".light_white
    @grid.each_with_index do |row, j|
      print "#{j}  ".light_white
      row.each_with_index do |tile, i|
        if tile.given
          print(tile.value.to_s.light_red)
        else
          tile.value == 0 ? print("_") : print(tile.value.to_s.light_blue)
        end
        i == 2 || i == 5 ? print(" | ") : print(" ")
      end
      puts
      puts "-------------------------\n" if j == 2 || j == 5
    end
    puts
  end

  def update_tile(pos,val)
    row, col = pos
    if @grid[row][col].given
      puts "Error--Number is Fixed"
      sleep(2)
    else
      @grid[row][col].value = val
    end
  end

  def solved?
    # byebug
    solved_rows? && solved_cols? && solved_squares?
  end

  def solved_rows?
    solve(@grid)
  end

  def solved_cols?
    solve(@grid[0].zip(@grid[1], @grid[2], @grid[3], @grid[4],
                       @grid[5], @grid[6], @grid[7], @grid[8]))
  end

  def solved_squares?
    row_starts = [0, 3, 6]
    col_starts = [0, 3, 6]
    row_starts.each do |row_start|
      col_starts.each do |col_start|
        square = @grid[row_start..row_start + 2].map do |col|
          col[col_start..col_start + 2]
        end
        return false unless solve(square)
      end
    end
    true
  end

  def solve(grid)
    grid.each do |row|
      return false unless row.none? { |el| el.value == 0 }
      check_array = []
      row.each do |el|
        return false if check_array.include?(el)
        check_array << el
      end
    end
    true
  end

  # def cheat!
  #   grid = []
  #   File.foreach('puzzles/sudoku1-solved.txt') do |line|
  #     grid << line.strip.split("")
  #   end
  #   grid.each_with_index do |row, i|
  #     row.each_with_index do |new_val, j|
  #       @grid[i][j].value = new_val.to_i
  #     end
  #   end
  # end

end
