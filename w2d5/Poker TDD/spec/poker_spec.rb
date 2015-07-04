require 'rspec'
require 'deck'
require 'player'
require 'poker'

describe PokerGame do
  subject(:game) {PokerGame.new("Bob", "Elton", "Alice", "Jesse")}
  let(:player) { game.current_player }

  it "initializes with a deck" do
    expect(game.deck).to be_an_instance_of(Deck)
  end

  it "initializes with four players" do
    expect(game.players[0]).to be_an_instance_of(Player)
    expect(game.players.size).to be(4)
  end

  it "gets user input" do
    player = game.players[0]
    expect(player).to receive(:get_user_input).with(50)
    game.play
  end

  it "switches players" do
    player1 = game.current_player
    game.rotate_players
    player2 = game.current_player
    expect(player1).to_not be(player2)
  end

  it "has all players share the same deck" do
    expect(player.deck).to be(game.players.last.deck)
  end

  it "has a current pot size" do
    expect(game.current_pot_size).to eq(0)
  end

  it "gets a bet from player" do
    expect(player.get_bet).to be_an_instance_of(Fixnum)
  end

  it "adds player bet to communal pot" do
    player.get_bet
    expect(game.current_pot_size).to eq(10)
  end


end
