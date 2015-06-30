require 'yaml'
require_relative 'board'

class Minesweeper

  attr_reader :board

  def initialize
    @board = Board.new
  end

  def play
    board.display

    puts "[c]ontinue or [n]ew game?"
    input = gets.chomp until input == 'c' || input == 'n'
    case input
    when 'c'
      @board = YAML.load_file("autosave.txt")
      board.display
      move = get_move
      pos = move[0]
      action = move[1]
    when 'n'
      # Gets the first move to ensure player doesn't lose right away.
      move = get_move(true)
      pos = move[0]
      action = 'r'
      board.set_first(pos)

      # Finishes setting up the board
      board.bombify
      board.find_neighbors
      board.set_values
    end

    # Starts game loop
    until board.over?(pos)
      board.reveal(pos) if action == 'r'
      board.flag(pos) if action == 'f'
      board.display
      save
      move = get_move
      pos = move[0]
      action = move[1]
    end
    board.game_over
  end

  def get_move(first_turn = false)
    unless first_turn
      puts "[r]eveal or [f]lag?"
      action = gets.chomp until action == 'r' || action == 'f'
    end
    puts "Please enter a coordinate pair: "
    pos = gets.split(',').map(&:to_i)
    until board.valid?(pos)
      puts "Enter a valid combination"
      pos = gets.split(',').map(&:to_i)
    end
    [pos, action]
  end

  def save
    yaml_board = board.to_yaml
    File.open("autosave.txt", "w") do |f|
      f.puts yaml_board
    end
  end

end

game = Minesweeper.new
game.play
