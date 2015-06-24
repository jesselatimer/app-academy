require 'colorize'
require_relative 'board'

class Connect4Game

  def initialize
    @board = Board.new
    @player1 = :red
    @player2 = :black
  end

  def play
    # Win conditions not perfect. Won with 3 in a row. Need to further debug.
    # Need to implement input validation.
    while @board.winner.nil?
      @board.render
      @board.drop_disc(player_input(@player1), @player1)
      next unless @board.winner.nil?
      @board.render
      @board.drop_disc(player_input(@player2), @player2)
    end
    @board.render
    puts "#{@board.winner.to_s.upcase} is winnaroo"
  end

  def player_input(current_player)
    puts "What column suits your fancy, #{current_player.to_s.upcase}?"
    a = gets.to_i
    until @board.valid_col?(a)
      a = gets.to_i
    end
    a
  end

end

game = Connect4Game.new
game.play
