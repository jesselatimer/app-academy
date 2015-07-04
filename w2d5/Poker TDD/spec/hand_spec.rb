require 'rspec'
require 'hand'
require 'deck'
require 'card'

describe Hand do
  let(:deck) { Deck.new }
  before do
    deck.shuffle
  end
  let(:my_hand) { Hand.new(deck.draw(5)) }
  let(:flush) { Hand.new([Card.new(:spade, 3), Card.new(:spade, 6),
    Card.new(:spade, 9), Card.new(:spade, 4), Card.new(:spade, 14)])}
  let(:high_card) { Hand.new([Card.new(:spade, 3), Card.new(:heart, 6),
    Card.new(:diamond, 9), Card.new(:spade, 4), Card.new(:spade, 14)])}
  let(:straight) { Hand.new([Card.new(:heart, 3), Card.new(:spade, 6),
    Card.new(:spade, 5), Card.new(:diamond, 4), Card.new(:spade, 7)])}
  let(:full_house) { Hand.new([Card.new(:diamond, 3), Card.new(:heart, 3),
    Card.new(:spade, 9), Card.new(:club, 9), Card.new(:diamond, 9)])}
  let(:full_house2) { Hand.new([Card.new(:diamond, 2), Card.new(:heart, 2),
    Card.new(:spade, 10), Card.new(:club, 10), Card.new(:diamond, 10)])}
  let(:unsorted) { [ flush, high_card, full_house, straight ] }
  let(:sorted)   { [ high_card, straight, flush, full_house ] }

  it "initialize with five cards" do
    expect(my_hand.count).to eq(5)
  end

  it "can have a card removed" do
    my_hand.remove_card(2)
    expect(my_hand.count).to eq(4)
  end

  it "can receive an additional card" do
    my_hand.remove_card(2)
    my_hand.receive_card(deck.draw(1))
    expect(my_hand.count).to eq(5)
  end

  it "will sort ties correctly" do
    expect(Hand.rank(full_house2, full_house)).to eq([full_house, full_house2])
  end

  it "ranks multiple players" do
    expect(Hand.rank(*unsorted)).to eq(sorted)
  end


end
