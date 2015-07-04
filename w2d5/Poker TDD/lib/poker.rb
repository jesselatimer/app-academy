require 'player'
require 'deck'

class PokerGame
  attr_reader :deck, :players, :round

  def initialize (*player_names)
    @players = []
    @round = 0
    @deck = Deck.new
    player_names.each do |name|
      @players << Player.new(name, 500, deck)
    end
  end

  def current_player
    players.first
  end

  def rotate_players
    @players.rotate!
  end

  def play
    until game_over?
      play_see_routine
      play_discard_routine
      reset_new_round
    end
  end

  def play_see_routine
    players.each { |player| player.get_user_input(50) }
  end

  def play_discard_routine

  end

  def reset_new_round

  end

  def game_over?
    @round += 1
    round >= 2
  end

  def current_pot_size

  end

end
