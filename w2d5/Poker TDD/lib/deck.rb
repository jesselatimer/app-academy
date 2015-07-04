require_relative 'card'

class Deck

  def initialize
    @stack = []
    populate_deck
  end

  def draw(n)
    stack.pop(n)
  end

  def shuffle
    @stack = stack.shuffle
  end

  def count
    stack.size
  end

  private
  attr_reader :stack

  def populate_deck
    (2..14).each do |value|
      [:spade, :club, :heart, :diamond].each do |suit|
        @stack << Card.new(suit, value)
      end
    end
  end

end
