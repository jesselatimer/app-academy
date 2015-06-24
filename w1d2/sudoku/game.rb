# Jesse Latimer and Bruce Reif

require 'colorize'
require 'byebug'
require_relative 'board'

# To implement: input validator, AI, timer

class SudokuGame
  def initialize(filename)
    @board = Board.new(Board.from_file(filename))
  end

  def play

    until @board.solved?
      @board.render
      # puts "Cheat? (y/n)"
      pos, val = get_player_input
      @board.update_tile(pos,val)
    end

    puts "YOU ARE WINNER"

  end

  def get_player_input
    puts "Coordinates?"
    pos = gets.chomp.split(",").map(&:to_i)
    puts "Number?"
    val = gets.to_i
    [pos,val]
  end

end

# puts "Name of file: "
# game = SudokuGame.new(gets.chomp)
game = SudokuGame.new('puzzles/sudoku1.txt')
game.play
