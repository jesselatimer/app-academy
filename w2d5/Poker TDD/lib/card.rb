class Card

  attr_reader :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def ==(other_card)
    value == other_card.value
  end

end
