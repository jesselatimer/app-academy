# Jesse Latimer & Brad Sanders

require 'byebug'

class Card

  attr_reader :value
  attr_accessor :face_up

  def initialize(value)
    @value = value
    @face_up = false
  end

  def display
    @face_up ? @value : "X"
  end

  def hide
    @face_up = false
  end

  def reveal
    @face_up = true
  end

  def ==(card)
    @value == card.value
  end

end

class Board

  attr_reader :size
  attr_accessor :previous_guess

  CARDS = ("A".."Z").to_a

  def initialize(size = 4)
    @size = size
    @board = Array.new(size) { Array.new(size) }
    @previous_guess = []
    populate
    cheat
  end

  def [](row, col)
    @board[row][col]
  end

  def []=(row, col, value)
    @board[row][col] = value
  end

  def populate
    card_varieties = (@size**2)/2
    shuffle_deck = (CARDS[0...card_varieties] * 2).shuffle
    i = -1
    @board.map! do |row|
      row.map! do |col|
        i += 1
        Card.new(shuffle_deck[i])
      end
    end
    p @board
  end

  def render
    @board.each do |row|
      row.each do |card|
        print card.display
        print " "
      end
      puts
    end
    puts
  end

  def cheat
    @board.each do |row|
      row.each do |card|
        print card.value
        print " "
      end
      puts
    end
    puts
  end

  def won?
    @board.each do |row|
      row.each do |card|
        return false if !card.face_up
      end
    end
    true
  end

  def reveal(pos)
    # x, y = pos
    # p pos
    # p @board[*pos]
    # byebug
    self[*pos].face_up = true
    self.render
    # handle error check
  end

end

class Game

  attr_reader :guessed_pos

  def initialize(size)
    @board = Board.new(size)
    @player = AIPlayer.new
    @wrong_turn_max = size + 5
    play
  end

  def play
    until @board.won? || @wrong_turn_max == 0
      @board.render
      @guessed_pos = @player.get_move(@board)
      puts "First Turn"
      @board.reveal(@guessed_pos)
      @board.previous_guess = @guessed_pos
      @guessed_pos = @player.get_move(@board)
      puts "Second Turn"
      @board.reveal(@guessed_pos)
      # sleep(3)
      handle_moves
      @board.previous_guess = []
    end
    if @wrong_turn_max == 0
      puts "You lost! You took so many turns!"
    else
      puts "Congratulations, you won!"
    end
  end


  def handle_moves
    if @board[*@guessed_pos] != @board[*@previous_guess]
      @board[*@guessed_pos].face_up = false
      @board[*@previous_guess].face_up = false
      @wrong_turn_max -= 1
    end
  end

end

class HumanPlayer
  def get_move
    puts "Pick a card."
    gets.chomp.split(",").map(&:to_i)
    # input validation later
  end
end

class AIPlayer
  def initialize
    @guessed_moves = Hash.new
  end

  def get_move(board)
    @board = board

    if @board.previous_guess.empty?
      if duplicates.length > 0
        guess = @guessed_moves.key(duplicates[0])
        @guessed_moves.delete(guess)
        return guess
      else
        guess = [rand(@board.size), rand(@board.size)]
        @guessed_moves[guess] = @board[*guess].value
        return guess
      end
    else
      if @guessed_moves.values.include?(@board.previous_guess)
        return @guessed_moves.key(@board.previous_guess)
      else
        guess = [rand(@board.size), rand(@board.size)]
        @guessed_moves[guess] = @board[*guess].value
        return guess
      end
    end
  end

  def duplicates
    duplicate_values = []
    @guessed_moves.values.each do |value|
      duplicate_values << value if @guessed_moves.values.count(value) > 1 &&
                               !duplicate_values.include?(value)
    end
    duplicate_values
  end

end

if __FILE__ == $PROGRAM_NAME
  puts "How big of a board do you want?"
  size = gets.to_i
  until size.even?
    puts "You much choose an even number"
    size = gets.to_i
  end
  Game.new(size)
end
