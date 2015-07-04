require 'rspec'
require 'deck'
require 'hand'
require 'player'

describe Player do
  subject(:player) { Player.new("Bob", 500, Deck.new) }

  it "initializes with a hand" do
    expect(player.hand.count).to eq(5)
  end

  it "initializes with a pot" do
    expect(player.pot).to be_an_instance_of(Fixnum)
  end

  it "can fold" do
    expect(player.fold).to eq([:fold, 0])
  end

  it "can see" do
    expect(player.see(50)).to eq([:see, 50])
    expect(player.pot).to eq(450)
  end

  it "can raise" do
    expect(player.raise_bet(50)).to eq([:raise, 80])
    expect(player.pot).to eq(420)
  end

  it "can make a bet" do
    expect(player.get_bet).to be_an_instance_of(Fixnum)
    expect(player.get_bet).to be_between(1, player.pot)
  end

end
