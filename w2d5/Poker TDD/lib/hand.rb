# To implement: full tie breaking
class Hand

  def self.rank(*hands)
    hands.sort
  end

  def initialize(five_cards)
    @my_cards = five_cards
  end

  def discard_at(list_of_indexes)
    list_of_indexes.sort.reverse.each do |index|
      remove_card(index)
    end
  end

  def remove_card(index)
    my_cards.delete_at(index)
  end

  def receive_card(card)
    if card.is_a?(Array)
      my_card.concat(card)
    else
      my_card << card
    end
  end

  def count
    my_cards.size
  end

  def <=>(hand2)
    hand_value <=> hand2.hand_value
  end

  def hand_value
    sort!
    if straight_flush?
      800 + my_cards.last.value
    elsif four_of_a_kind?
      700 + my_cards[2].value
    elsif full_house?
      600 + my_cards[2].value
    elsif flush?
      500 + my_cards.last.value
    elsif three_of_a_kind?
      400 + my_cards[2].value
    elsif straight?(my_cards)
      300 + my_cards.last.value
    elsif two_pair?
      200 + my_cards[3].value
    elsif two_of_a_kind?
      100 + two_of_a_kind_value
    else
      get_high_card_value
    end
  end

  def sort
    my_cards.sort
  end

  def sort!
    my_cards.sort!
  end


  private
  attr_accessor :my_cards

  def straight_flush?
    straight?(my_cards) && flush?
  end

  def four_of_a_kind?
    match_cards(4)
  end

  def full_house?
    two_of_a_kind? && three_of_a_kind?
  end

  def flush?
    my_cards.all? { |card| card.suit == my_cards.first.suit }
  end

  def three_of_a_kind?
    match_cards(3)
  end

  def straight?(cards)
    base_value = cards.first.value
    if cards.last.value == 14 && cards.first.value == 2
      return true if straight?(my_cards[0...-1])
    end
    cards.each_with_index do |card, i|
      return false unless card.value - base_value == i
    end
    true
  end

  def two_pair?
    # match_cards(2) && Hand.new(my_cards[2..-1]).match_cards(2)
    [1, 3].all? do |i|
      my_cards.count { |card| card.value == my_cards[i].value } == 2
    end
  end

  def two_of_a_kind?
    match_cards(2)
  end

  def two_of_a_kind_value
    (my_cards.size - 1).times do |start_pos|
      return my_cards[start_pos].value if my_cards[start_pos] == my-cards[start_pos + 1]
    end
  end

  def get_high_card_value
    my_cards.last.value
  end

  def match_cards(count)
    (0..5-count).any? do |i|
      my_cards.count { |card| card.value == my_cards[i].value } == count
    end
  end

end
