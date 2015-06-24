require 'byebug'

class Board
  def initialize
    @row_count = 6
    @column_count = 7
    @grid = Array.new(@row_count) { Array.new(@column_count) }
  end

  def valid_col?(col)
    return true if @grid[0][col].nil?
    false
  end

  def drop_disc(column,color)
    i = (@row_count - 1)
    while i >= 0
      if @grid[i][column].nil?
        @grid[i][column] = color
        return
      else
        i -= 1
      end
    end
  end

  def winner
    return :red if won_row?(:red) || won_col?(:red) || won_diag?(:red)
    return :black if won_row?(:black) || won_col?(:black) || won_diag?(:black)
    nil
  end

  def won_row?(color)
    solve(@grid,color)
  end

  def won_col?(color)
    solve(@grid[0].zip(*@grid[1...@column_count]), color)
  end

  def won_diag?(color)
    @grid.each_with_index do |row, i|
      row.each_with_index do |_, j|
        next if @grid[i+3].nil?
        unless j - 3 < 0
          return true if generate_diag(i, j, :back).all?  { |x| x == color }
        end
        unless @grid[i+3][j+3].nil?
          return true if generate_diag(i, j, :forward).all?  { |x| x == color }
        end
      end
    end
    false
  end

  def generate_diag(i, j, dir)
    if dir == :back
      return [@grid[i][j], @grid[i+1][j-1], @grid[i+2][j-2], @grid[i+3][j-3]]
    elsif dir == :forward
      return [@grid[i][j], @grid[i+1][j+1], @grid[i+2][j+2], @grid[i+3][j+3]]
    end
  end

  def solve(arr,color)
    arr.each do |row|
      (@column_count - 3).times do |i|
        return true if row[i..i+3].all? { |x| x == color }
      end
    end
    false
  end

  def cheat!
    @grid.map! { |row| row.map! { |spot| :black }}
  end

  def render
    system "clear"
    @column_count.times { |i| print("#{i} ".light_white) }
    puts
    @grid.each_with_index do |row, j|
      row.each do |spot|
        print "o ".red if spot == :red
        print "o ".black if spot == :black
        print "  " if spot == nil
      end
      puts
    end
    print "-" * ((@column_count * 2) - 1)
    puts
  end

end
