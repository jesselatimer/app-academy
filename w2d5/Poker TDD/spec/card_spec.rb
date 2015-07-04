require 'rspec'
require 'card'

describe Card do
  let(:deck) { [Card.new(:spade, 13), Card.new(:diamond, 4), Card.new(:spade, 5)] }

  # context 'basic intiializes'
  it "initializes with a suit" do
    expect(Card.new(:club, 2).suit).to eq(:club)
    expect(Card.new(:heart, 2).suit).to eq(:heart)
    expect(Card.new(:spade, 2).suit).to eq(:spade)
    expect(Card.new(:diamond, 2).suit).to eq(:diamond)
  end

  it "initializes with a value" do
    expect(Card.new(:spade, 2).value).to eq(2)
    expect(Card.new(:spade, 14).value).to eq(14)
  end

  it "can compare itself to another card" do
    expect(deck.sort).to eq(deck.sort do |card1, card2|
      card1.value <=> card2.value
    end)
  end

end
