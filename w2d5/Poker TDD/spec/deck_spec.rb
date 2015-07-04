require 'rspec'
require 'deck'

describe Deck do
  subject(:deck) { Deck.new }

  context "when deck is initialized" do
    it "has fifty-two cards" do
      expect(deck.count).to eq(52)
    end
  end

  it "deck can be shuffled" do
    expect(deck.shuffle).to_not eq(deck)
  end

  it "returns a card on draw" do
    expect(deck.draw(1).first).to be_an_instance_of(Card)
  end

  it "reduces a deck on draw" do
    deck.draw(1)
    expect(deck.count).to eq(51)
  end
  

end
